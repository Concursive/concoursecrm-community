package org.aspcfs.modules.accounts.actions;

import com.darkhorseventures.framework.actions.ActionContext;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.admin.base.User;
import org.aspcfs.modules.contacts.base.Contact;
import org.aspcfs.modules.contacts.base.ContactEmailAddress;
import org.aspcfs.modules.contacts.base.ContactEmailAddressList;
import org.aspcfs.utils.web.LookupList;

import java.sql.Connection;
import java.util.Iterator;

/**
 * Description of the Class
 *
 * @author partha
 * @version $Id$
 * @created November 4, 2004
 */
public final class ContactEmailAddressSelector extends CFSModule {

  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandList(ActionContext context) {
    Connection db = null;
    ContactEmailAddressList emailList = null;
    User user = this.getUser(context, getUserId(context));
    Contact contact = null;
    String contactId = (String) context.getRequest().getParameter("contactId");
    String hiddenFieldId = (String) context.getRequest().getParameter(
        "hiddenFieldId");
    if (hiddenFieldId != null && !"".equals(hiddenFieldId)) {
      context.getRequest().setAttribute("hiddenFieldId", hiddenFieldId);
    }
    try {
      db = this.getConnection(context);
      if (contactId != null && !"".equals(contactId)) {
        contact = new Contact();
        contact.setBuildDetails(true);
        contact.setBuildTypes(true);
        contact.queryRecord(db, Integer.parseInt(contactId));
        context.getRequest().setAttribute("contact", contact);
      }
      if (contact != null && contact.getEmailAddressList() != null) {
        contact = new Contact();
        contact.setBuildDetails(true);
        contact.queryRecord(db, Integer.parseInt(contactId));
        context.getRequest().setAttribute(
            "contactEmailAddressList", contact.getEmailAddressList());
      } else {
        user.setBuildContact(true);
        user.setBuildContactDetails(true);
        user.buildRecord(db, user.getId());
        context.getRequest().setAttribute(
            "contactEmailAddressList", user.getContact().getEmailAddressList());
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return ("ListOK");
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandDelete(ActionContext context) {
    Connection db = null;
    ContactEmailAddressList emailList = null;
    User user = this.getUser(context, getUserId(context));
    String addressId = (String) context.getRequest().getParameter("addressId");
    Iterator iterator = null;
    Contact contact = null;
    ContactEmailAddress deleteItem = null;
    String contactId = (String) context.getRequest().getParameter("contactId");
    String hiddenFieldId = (String) context.getRequest().getParameter(
        "hiddenFieldId");
    if (hiddenFieldId != null && !"".equals(hiddenFieldId)) {
      context.getRequest().setAttribute("hiddenFieldId", hiddenFieldId);
    }
    try {
      db = this.getConnection(context);
      if (contactId != null && !"".equals(contactId)) {
        contact = new Contact();
        contact.setBuildDetails(true);
        contact.setBuildTypes(true);
        contact.queryRecord(db, Integer.parseInt(contactId));
        context.getRequest().setAttribute("contact", contact);
      }
      user.setBuildContact(true);
      user.setBuildContactDetails(true);
      user.buildRecord(db, user.getId());
      if (contact != null) {
        iterator = (Iterator) contact.getEmailAddressList().iterator();
      } else {
        iterator = (Iterator) user.getContact().getEmailAddressList().iterator();
      }
      while (iterator.hasNext()) {
        ContactEmailAddress email = (ContactEmailAddress) iterator.next();
        if (email.getId() == Integer.parseInt(addressId)) {
          deleteItem = email;
          break;
        }
      }
      if (deleteItem != null) {
        deleteItem.delete(db);
      }
      if (contact != null && contact.getEmailAddressList() != null) {
        contact = new Contact();
        contact.setBuildDetails(true);
        contact.queryRecord(db, Integer.parseInt(contactId));
        context.getRequest().setAttribute(
            "contactEmailAddressList", contact.getEmailAddressList());
      } else {
        user.buildRecord(db, user.getId());
        context.getRequest().setAttribute(
            "contactEmailAddressList", user.getContact().getEmailAddressList());
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return ("ListOK");
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandAddressForm(ActionContext context) {
    Connection db = null;
    Contact contact = null;
    String contactId = (String) context.getRequest().getParameter("contactId");
    String hiddenFieldId = (String) context.getRequest().getParameter(
        "hiddenFieldId");
    if (hiddenFieldId != null && !"".equals(hiddenFieldId)) {
      context.getRequest().setAttribute("hiddenFieldId", hiddenFieldId);
    }
    try {
      db = this.getConnection(context);
      if (contactId != null && !"".equals(contactId)) {
        contact = new Contact();
        contact.setBuildDetails(true);
        contact.setBuildTypes(true);
        contact.queryRecord(db, Integer.parseInt(contactId));
        context.getRequest().setAttribute("contact", contact);
      }
      SystemStatus systemStatus = this.getSystemStatus(context);
      LookupList typeSelect = systemStatus.getLookupList(
          db, "lookup_contactemail_types");
      context.getRequest().setAttribute("typeSelect", typeSelect);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return ("AddressFormOK");
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandAdd(ActionContext context) {
    Connection db = null;
    User user = this.getUser(context, getUserId(context));
    user.setBuildContact(true);
    user.setBuildContactDetails(true);
    ContactEmailAddress deleteItem = null;
    Contact contact = null;
    String contactId = (String) context.getRequest().getParameter("contactId");
    String hiddenFieldId = (String) context.getRequest().getParameter(
        "hiddenFieldId");
    if (hiddenFieldId != null && !"".equals(hiddenFieldId)) {
      context.getRequest().setAttribute("hiddenFieldId", hiddenFieldId);
    }
    try {
      db = this.getConnection(context);
      if (contactId != null && !"".equals(contactId)) {
        contact = new Contact();
        contact.setBuildDetails(true);
        contact.setBuildTypes(true);
        contact.queryRecord(db, Integer.parseInt(contactId));
        context.getRequest().setAttribute("contact", contact);
      }
      user.buildRecord(db, user.getId());
      ContactEmailAddress email = new ContactEmailAddress();
      email.buildRecord(context.getRequest(), 1);
      if (contact != null && contact.getEmailAddressList() != null) {
        email.process(db, contact.getId(), user.getId(), user.getId());
        contact = new Contact();
        contact.setBuildDetails(true);
        contact.queryRecord(db, Integer.parseInt(contactId));
        context.getRequest().setAttribute(
            "contactEmailAddressList", contact.getEmailAddressList());
      } else {
        email.process(
            db, user.getContact().getId(), user.getId(), user.getId());
        user.buildRecord(db, user.getId());
        context.getRequest().setAttribute(
            "contactEmailAddressList", user.getContact().getEmailAddressList());
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return ("ListOK");
  }
}

