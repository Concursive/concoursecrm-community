/*
 *  Copyright(c) 2004 Concursive Corporation (http://www.concursive.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Concursive Corporation. Permission to use, copy, and modify
 *  this material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. CONCURSIVE
 *  CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL CONCURSIVE CORPORATION OR ANY OF ITS AFFILIATES BE LIABLE FOR
 *  ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package org.aspcfs.modules.pipeline.components;

import org.aspcfs.apps.workFlowManager.ComponentContext;
import org.aspcfs.apps.workFlowManager.ComponentInterface;
import org.aspcfs.controller.objectHookManager.ObjectHookComponent;
import org.aspcfs.modules.accounts.base.OrganizationHistory;
import org.aspcfs.modules.pipeline.base.OpportunityComponent;
import org.aspcfs.modules.pipeline.base.OpportunityComponentList;

import java.sql.Connection;
import java.util.Iterator;

/**
 * Description of the Class
 *
 * @author partha
 * @version $Id$
 * @created May 27, 2005
 */
public class ResetOpportunityContactHistory extends ObjectHookComponent implements ComponentInterface {
  public final static String LEVEL = "history.level";
  public final static String CONTACT_ID = "history.contactId";
  public final static String ORG_ID = "history.orgId";
  public final static String LINK_OBJECT_ID = "history.linkObjectId";
  public final static String LINK_ITEM_ID = "history.linkItemId";
  public final static String DESCRIPTION = "history.description";
  public final static String ENABLED = "history.enabled";
  public final static String STATUS = "history.status";
  public final static String TYPE = "history.type";
  public final static String PREVIOUS_CONTACT_ID = "history.previousContactId";
  public final static String MODIFIED_BY = "history.modifiedby";
  public final static String RESET = "history.reset";


  /**
   * Gets the description attribute of the ResetOpportunityContactHistory
   * object
   *
   * @return The description value
   */
  public String getDescription() {
    return "Reset the contact's history for all component entries";
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public boolean execute(ComponentContext context) {
    boolean result = false;
    OpportunityComponentList componentList = null;
    OrganizationHistory history = null;
    String reset = null;
    Connection db = null;
    try {
      db = getConnection(context);
      reset = context.getParameter(RESET);
      int contactId = context.getParameterAsInt(CONTACT_ID);
      int orgId = context.getParameterAsInt(ORG_ID);
      //build the opportunity component list
      componentList = new OpportunityComponentList();
      componentList.setHeaderId(context.getParameterAsInt(LINK_ITEM_ID));
      componentList.buildList(db);
      Iterator iterator = (Iterator) componentList.iterator();
      while (iterator.hasNext()) {
        OpportunityComponent component = (OpportunityComponent) iterator.next();
        history = new OrganizationHistory();
        if (reset.equals("contact")) {
          history.setContactId(contactId);
        } else if (reset.equals("account")) {
          history.setOrgId(orgId);
        }
        history.setLinkObjectId(context.getParameterAsInt(LINK_OBJECT_ID));
        history.setLinkItemId(component.getId());
        history.queryRecord(db);
        if (reset.equals("contact")) {
          history.setContactId(-1);
          history.setOrgId(orgId);
        } else if (reset.equals("account")) {
          history.setContactId(contactId);
          history.setOrgId(-1);
        }
        history.setLevel(context.getParameterAsInt(LEVEL));
        history.setDescription(context.getParameter(DESCRIPTION));
        history.setStatus(context.getParameter(STATUS));
        history.setType(context.getParameter(TYPE));
        history.setModifiedBy(context.getParameter(MODIFIED_BY));
        history.setEnteredBy(context.getParameter(MODIFIED_BY));
        history.setReset(true);
        if (history.getId() > -1) {
          history.update(db);
          result = true;
        } else {
          history.insert(db);
          result = true;
        }
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      freeConnection(context, db);
    }
    return result;
  }
}

