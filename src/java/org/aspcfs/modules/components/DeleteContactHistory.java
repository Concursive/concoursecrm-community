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
package org.aspcfs.modules.components;

import org.aspcfs.apps.workFlowManager.ComponentContext;
import org.aspcfs.apps.workFlowManager.ComponentInterface;
import org.aspcfs.controller.objectHookManager.ObjectHookComponent;
import org.aspcfs.modules.contacts.base.Call;
import org.aspcfs.modules.contacts.base.ContactHistory;

import java.sql.Connection;

/**
 * Description of the Class
 * 
 * @author partha
 * @version $Id$
 * @created May 27, 2005
 */
public class DeleteContactHistory extends ObjectHookComponent implements
    ComponentInterface {
  public final static String CONTACT_ID = "history.contactId";

  public final static String FOLLOWUP_CONTACT_ID = "history.followupContactId";

  public final static String LINK_OBJECT_ID = "history.linkObjectId";

  public final static String LINK_ITEM_ID = "history.linkItemId";

  public final static String PREVIOUS_CONTACT_ID = "history.previousContactId";

  public final static String PREVIOUS_FOLLOWUP_CONTACT_ID = "history.previousFollowupContactId";

  /**
   * Gets the description attribute of the DeleteContactHistory object
   * 
   * @return The description value
   */
  public String getDescription() {
    return "Delete the contact's history entry";
  }

  /**
   * Description of the Method
   * 
   * @param context
   *          Description of the Parameter
   * @return Description of the Return Value
   */
  public boolean execute(ComponentContext context) {
    boolean result = false;

    ContactHistory history = new ContactHistory();
    Connection db = null;
    try {
      db = getConnection(context);
      int currentContactId = -1;
      if (context.getParameter(CONTACT_ID) != null
          && !"-1".equals(context.getParameter(CONTACT_ID))) {
        currentContactId = context.getParameterAsInt(CONTACT_ID);
      } else {
        currentContactId = context.getParameterAsInt(FOLLOWUP_CONTACT_ID);
      }
      int previousContactId = -1;
      if ((context.getParameter(PREVIOUS_CONTACT_ID) != null && !"-1"
          .equals(context.getParameter(PREVIOUS_CONTACT_ID)))
          || (context.getParameter(PREVIOUS_FOLLOWUP_CONTACT_ID) != null && !"-1"
              .equals(context.getParameter(PREVIOUS_FOLLOWUP_CONTACT_ID)))) {
        if (context.getParameter(PREVIOUS_CONTACT_ID) != null
            && !"-1".equals(context.getParameter(PREVIOUS_CONTACT_ID))) {
          previousContactId = context.getParameterAsInt(PREVIOUS_CONTACT_ID);
        } else {
          previousContactId = context
              .getParameterAsInt(PREVIOUS_FOLLOWUP_CONTACT_ID);
        }
        if (previousContactId != currentContactId) {
          history.setContactId(previousContactId);
        } else {
          history.setContactId(currentContactId);
        }
      } else {
        history.setContactId(currentContactId);
      }
      history.setLinkObjectId(context.getParameterAsInt(LINK_OBJECT_ID));
      history.setLinkItemId(context.getParameterAsInt(LINK_ITEM_ID));
      history.queryRecord(db);
      if (history.getId() != -1) {
        result = history.delete(db);
      }
    } catch (Exception e) {
      e.printStackTrace();
    } finally {
      freeConnection(context, db);
    }
    return result;
  }
}
