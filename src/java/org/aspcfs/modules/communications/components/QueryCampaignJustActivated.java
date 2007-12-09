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
package org.aspcfs.modules.communications.components;

import org.aspcfs.apps.workFlowManager.ComponentContext;
import org.aspcfs.apps.workFlowManager.ComponentInterface;
import org.aspcfs.controller.objectHookManager.ObjectHookComponent;
import org.aspcfs.modules.communications.base.Campaign;

import java.sql.Connection;

/**
 * Description of the Class
 *
 * @author partha
 * @version $Id$
 * @created May 27, 2005
 */
public class QueryCampaignJustActivated extends ObjectHookComponent implements ComponentInterface {

  public final static String CAMPAIGN = "campaign";


  /**
   * Gets the description attribute of the QueryCampaignJustActivated object
   *
   * @return The description value
   */
  public String getDescription() {
    return "Load Campaign information for use in other steps";
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public boolean execute(ComponentContext context) {
    boolean result = false;
    Campaign thisCampaign = (Campaign) context.getThisObject();
    Campaign previousCampaign = (Campaign) context.getPreviousObject();
    result = (previousCampaign.getStatusId() == Campaign.IDLE || previousCampaign.getStatusId() == Campaign.CANCELED) &&
        (thisCampaign.getStatusId() == Campaign.QUEUE || thisCampaign.getStatusId() == Campaign.STARTED ||
        thisCampaign.getStatusId() == Campaign.FINISHED || thisCampaign.getStatusId() == Campaign.ERROR);
    if (!result) {
      result = (previousCampaign.getStatusId() == Campaign.ERROR || previousCampaign.getStatusId() == Campaign.FINISHED || 
                previousCampaign.getStatusId() == Campaign.QUEUE) && thisCampaign.getStatusId() == Campaign.QUEUE;
    }
    return result;
  }
}

