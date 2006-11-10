/*
 *  Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
 *  this material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. DARK HORSE
 *  VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
 *  ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package org.aspcfs.modules.communications.actions;

import com.darkhorseventures.database.ConnectionElement;
import com.darkhorseventures.framework.actions.ActionContext;
import org.aspcfs.controller.ApplicationPrefs;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.controller.SecurityHook;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.communications.base.ActiveSurvey;
import org.aspcfs.modules.communications.base.SurveyResponse;
import org.aspcfs.modules.communications.base.ScheduledRecipient;
import org.aspcfs.modules.contacts.base.Contact;
import org.aspcfs.modules.login.base.AuthenticationItem;
import org.aspcfs.modules.system.base.Site;
import org.aspcfs.utils.PrivateString;
import org.aspcfs.utils.DateUtils;
import org.aspcfs.utils.web.CountrySelect;
import org.aspcfs.utils.web.LookupList;
import org.aspcfs.utils.web.StateSelect;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.StringTokenizer;
import java.security.Key;

/**
 * Allows respondants to take part in a survey in which they were invited to
 *
 * @author Kailash Bhoopalam
 * @version $Id$
 * @created January 12, 2005
 */
public final class ProcessAddressSurvey extends CFSModule {

  /**
   * Generates the survey for presentation, decodes URL for a non-user of this
   * system.
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandDefault(ActionContext context) {
    ActiveSurvey thisSurvey = null;
    Connection db = null;
    int addressSurveyId = -1;
    int contactId = -1;
    int campaignId = -1;
    int addressNoChangeId = -1;
    Contact thisContact = null;
    String codedId = context.getRequest().getParameter("id");
    //return alert message if someone tried clicking link from the campaign dashboard's message tab
    if (codedId != null && codedId.startsWith("${surveyId")) {
      return "InvalidRequestError";
    }
    try {
      // Get a database connection based on the request
      AuthenticationItem auth = new AuthenticationItem();
      db = auth.getConnection(context, false);
      // Load the survey key which decodes the url
      String dbName = auth.getConnectionElement(context).getDbName();
      String filename = getPath(context) + dbName + fs + "keys" + fs + "survey2.key";
      Key key = PrivateString.loadEncodedKey(filename);
      String uncodedId = PrivateString.decrypt(key, codedId);
      StringTokenizer st = new StringTokenizer(uncodedId, ",");
      while (st.hasMoreTokens()) {
        String pair = (st.nextToken());
        StringTokenizer stPair = new StringTokenizer(pair, "=");
        String param = stPair.nextToken();
        String value = stPair.nextToken();
        if ("addressSurveyId".equals(param)) {
          addressSurveyId = Integer.parseInt(value);
        }
        if ("cid".equals(param)) {
          contactId = Integer.parseInt(value);
        }
        if ("campaignId".equals(param)) {
          campaignId = Integer.parseInt(value);
        }
        if ("addressNoChangeId".equals(param)) {
          addressNoChangeId = Integer.parseInt(value);
        }
      }
      if (campaignId != -1) {
        if (addressSurveyId != -1) {
          thisSurvey = new ActiveSurvey(db, addressSurveyId);
        } else if (addressNoChangeId != -1) {
          thisSurvey = new ActiveSurvey(db, addressNoChangeId);
        }
      }

      //mark the recipient to have received the survey
      if (contactId != -1 && campaignId != -1) {
        ScheduledRecipient recipient = new ScheduledRecipient(db, campaignId, contactId);
        if (recipient.getReplyDate() == null) {
          recipient.setReplyDate(
            DateUtils.roundUpToNextFive(System.currentTimeMillis()));
          recipient.update(db);
        }
      }

      thisContact = new Contact(db, contactId);
      context.getRequest().setAttribute("ContactDetails", thisContact);
      context.getRequest().setAttribute("id", codedId);
      prepareFormElements(context, db);

      ConnectionElement ce = auth.getConnectionElement(context);
      SystemStatus systemStatus = this.getSystemStatus(context, ce);
      if (systemStatus == null) {
        //Since typical login was bypassed, make sure the system status is in memory
        Site thisSite = SecurityHook.retrieveSite(context.getServletContext(), context.getRequest());
        systemStatus = SecurityHook.retrieveSystemStatus(
            context.getServletContext(), db, ce, thisSite.getLanguage());
      }
      //Make the StateSelect and CountrySelect drop down menus available in the request.
      //This needs to be done here to provide the SystemStatus to the constructors, otherwise translation is not possible
      StateSelect stateSelect = (StateSelect) context.getRequest().getAttribute("StateSelect");
      ApplicationPrefs prefs = (ApplicationPrefs) context.getServletContext().getAttribute("applicationPrefs");
      if (stateSelect == null) {
        if (systemStatus != null) {
          stateSelect = new StateSelect(systemStatus, thisContact.getAddressList().getCountries()+","+prefs.get("SYSTEM.COUNTRY"));
        } else {
          stateSelect = new StateSelect(thisContact.getAddressList().getCountries()+","+prefs.get("SYSTEM.COUNTRY"));
        }
      }
      stateSelect.setPreviousStates(thisContact.getAddressList().getSelectedStatesHashMap());
      CountrySelect countrySelect = new CountrySelect(systemStatus);
      context.getRequest().setAttribute("StateSelect", stateSelect);
      context.getRequest().setAttribute("CountrySelect", countrySelect);
      context.getRequest().setAttribute("systemStatus", systemStatus);
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("NotFoundError");
    } finally {
      this.freeConnection(context, db);
    }
    if (addressNoChangeId != -1) {
      return ("PrepareAddressCurrentOK");
    }
    return ("PrepareOK");
  }


  /**
   * Processes the user's answers and inserts them
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandUpdate(ActionContext context) {
    Connection db = null;
    ActiveSurvey thisSurvey = null;
    int addressSurveyId = -1;
    int contactId = -1;
    int campaignId = -1;
    int addressNoChangeId = -1;
    try {
      AuthenticationItem auth = new AuthenticationItem();
      db = auth.getConnection(context, false);
      // Load the survey key which decodes the url
      String dbName = auth.getConnectionElement(context).getDbName();
      String filename = getPath(context) + dbName + fs + "keys" + fs + "survey2.key";
      String codedId = context.getRequest().getParameter("id");
      Key key = PrivateString.loadEncodedKey(filename);
      String uncodedId = PrivateString.decrypt(key, codedId);
      StringTokenizer st = new StringTokenizer(uncodedId, ",");
      while (st.hasMoreTokens()) {
        String pair = (st.nextToken());
        StringTokenizer stPair = new StringTokenizer(pair, "=");
        String param = stPair.nextToken();
        String value = stPair.nextToken();
        if ("addressSurveyId".equals(param)) {
          addressSurveyId = Integer.parseInt(value);
        } else if ("cid".equals(param)) {
          contactId = Integer.parseInt(value);
        } else if ("campaignId".equals(param)) {
          campaignId = Integer.parseInt(value);
        } else if ("addressNoChangeId".equals(param)) {
          addressNoChangeId = Integer.parseInt(value);
        }
      }
      if (addressSurveyId != -1) {
        Contact thisContact = (Contact) context.getFormBean();
        thisContact.setId(contactId);
        thisContact.setRequestItems(context);
        thisContact.updateNameandAddress(db);
      }
      if (campaignId != -1) {
        // Record campaign response details
        SurveyResponse thisResponse = new SurveyResponse();
        thisResponse.setContactId(contactId);
        thisResponse.setUniqueCode(codedId);
        thisResponse.setIpAddress(context.getIpAddress());
        if (addressSurveyId != -1) {
          thisResponse.setActiveSurveyId(addressSurveyId);
          thisResponse.setAddressUpdated(SurveyResponse.ADDRESS_UPDATED);
          thisResponse.insert(db);
          thisSurvey = new ActiveSurvey(db, addressSurveyId);
        }
        if (addressNoChangeId != -1) {
          thisResponse.setActiveSurveyId(addressNoChangeId);
          thisResponse.setAddressUpdated(SurveyResponse.ADDRESS_VALID);
          thisResponse.insert(db);
          thisSurvey = new ActiveSurvey(db, addressNoChangeId);
        }
        context.getRequest().setAttribute(
            "ThankYouText", thisSurvey.getOutro());
      }
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return ("UpdateOK");
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @param db      Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  private void prepareFormElements(ActionContext context, Connection db) throws SQLException {
    LookupList phoneTypeList = new LookupList(db, "lookup_contactphone_types");
    context.getRequest().setAttribute("ContactPhoneTypeList", phoneTypeList);

    LookupList emailTypeList = new LookupList(db, "lookup_contactemail_types");
    context.getRequest().setAttribute("ContactEmailTypeList", emailTypeList);

    LookupList addressTypeList = new LookupList(
        db, "lookup_contactaddress_types");
    context.getRequest().setAttribute(
        "ContactAddressTypeList", addressTypeList);

    LookupList instantMessageAddressTypeList = new LookupList(
          db, "lookup_im_types");
      context.getRequest().setAttribute(
          "ContactInstantMessageAddressTypeList", instantMessageAddressTypeList);

      LookupList instantMessageAddressServiceList = new LookupList(
          db, "lookup_im_services");
      context.getRequest().setAttribute(
          "ContactInstantMessageAddressServiceList", instantMessageAddressServiceList);

    LookupList textMessageAddressTypeList = new LookupList(
        db, "lookup_textmessage_types");
    context.getRequest().setAttribute(
        "ContactTextMessageAddressTypeList", textMessageAddressTypeList);
  }
}
