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
package org.aspcfs.modules.troubletickets.base;

import com.darkhorseventures.framework.actions.ActionContext;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.admin.base.User;
import org.aspcfs.modules.base.ScheduledActions;
import org.aspcfs.modules.mycfs.base.CalendarEventList;
import org.aspcfs.modules.mycfs.base.TicketEventList;
import org.aspcfs.utils.DateUtils;
import org.aspcfs.utils.web.CalendarView;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.TimeZone;

/**
 *  Description of the Class
 *
 *@author     kbhoopal
 *@created    June 30, 2004
 *@version    $Id: TicketListScheduledActions.java,v 1.4 2004/08/31 12:48:26
 *      mrajkowski Exp $
 */
public class TicketListScheduledActions extends TicketList implements ScheduledActions {

  private int userId = -1;
  private ActionContext context = null;
  private CFSModule module = null;


  /**
   *  Constructor for the TicketListScheduledActions object
   */
  public TicketListScheduledActions() { }


  /**
   *  Sets the module attribute of the TicketListScheduledActions object
   *
   *@param  tmp  The new module value
   */
  public void setModule(CFSModule tmp) {
    this.module = tmp;
  }


  /**
   *  Sets the context attribute of the TicketListScheduledActions object
   *
   *@param  tmp  The new context value
   */
  public void setContext(ActionContext tmp) {
    this.context = tmp;
  }


  /**
   *  Gets the context attribute of the TicketListScheduledActions object
   *
   *@return    The context value
   */
  public ActionContext getContext() {
    return context;
  }


  /**
   *  Gets the module attribute of the TicketListScheduledActions object
   *
   *@return    The module value
   */
  public CFSModule getModule() {
    return module;
  }


  /**
   *  Sets the userId attribute of the TicketListScheduledActions object
   *
   *@param  userId  The new userId value
   */
  public void setUserId(int userId) {
    this.userId = userId;
  }


  /**
   *  Sets the userId attribute of the TicketListScheduledActions object
   *
   *@param  tmp  The new userId value
   */
  public void setUserId(String tmp) {
    this.userId = Integer.parseInt(tmp);
  }


  /**
   *  Gets the userId attribute of the TicketListScheduledActions object
   *
   *@return    The userId value
   */
  public int getUserId() {
    return userId;
  }


  /**
   *  Description of the Method
   *
   *@param  companyCalendar   Description of the Parameter
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void buildAlerts(CalendarView companyCalendar, Connection db) throws SQLException {
    try {
      if (System.getProperty("DEBUG") != null) {
        System.out.println("TicketListScheduledActions-> Building Ticket alerts for user " + userId);
      }
      //get User
      User thisUser = null;
      if (context != null) {
        /*
          This check is necessary since ICalendar.java for webcal feature builds
          a list of Ticket events and does not have access to the ActionContext
        */
        thisUser = module.getUser(context, userId);
      }
      
      //get TimeZone
      TimeZone timeZone = companyCalendar.getCalendarInfo().getTimeZone();

      Timestamp todayTimestamp = new Timestamp(System.currentTimeMillis());
      String alertDate = DateUtils.getServerToUserDateString(timeZone, DateFormat.SHORT, todayTimestamp);
      // List 1//currently non-functional
      // NOTE: any filters set here must be unset in next list
      // this.setOrgId(thisUser.getContact().getOrgId());
      this.setOnlyOpen(true);
      this.setOnlyWithProducts(true);
/*
      this.buildList(db);
      Iterator tickets = this.iterator();
      while (tickets.hasNext()) {
        Ticket thisTicket = (Ticket) tickets.next();
        TicketEventList thisList = (TicketEventList) companyCalendar.getEventList(alertDate, CalendarEventList.EVENT_TYPES[11]);
        thisList.getOpenProductTickets().add(thisTicket);
      }
*/
      // List 2
      this.clear();
      this.setOrgId(-1);
      this.setOnlyWithProducts(false);
      // now set the values for this list
      this.setAssignedTo(this.getUserId());
      this.setOnlyAssigned(true);
      this.setHasEstimatedResolutionDate(true);
      this.setOnlyOpen(true);
      this.buildList(db);
      Iterator m = this.iterator();
      while (m.hasNext()) {
        Ticket thisTicket = (Ticket) m.next();
        thisTicket.buildContactInformation(db);
        alertDate = DateUtils.getServerToUserDateString(timeZone, DateFormat.SHORT, thisTicket.getEstimatedResolutionDate());
        TicketEventList thisList = (TicketEventList) companyCalendar.getEventList(alertDate, CalendarEventList.EVENT_TYPES[12]);
        thisList.getOpenTickets().add(thisTicket);
      }
    } catch (SQLException e) {
      throw new SQLException("Error Building Ticket Calendar Alerts 2");
    }
  }


  /**
   *  Build event categories and count of occurance of each category.
   *
   *@param  companyCalendar   Description of the Parameter
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void buildAlertCount(CalendarView companyCalendar, Connection db) throws SQLException {
    if (System.getProperty("DEBUG") != null) {
      System.out.println("TicketListScheduledActions --> Building Alert Counts ");
    }
    // List 1//currently non-functional
      //get User
      User thisUser = null;
      if (context != null) {
        /*
          This check is necessary since ICalendar.java for webcal feature builds
          a list of Ticket events and does not have access to the ActionContext
        */
        thisUser = module.getUser(context, userId);
      }
      
      TimeZone timeZone = companyCalendar.getCalendarInfo().getTimeZone();
/*
    try {
      this.setOrgId(thisUser.getContact().getOrgId());
      this.setOnlyOpen(true);
      this.setOnlyWithProducts(true);
      HashMap dayEvents = this.queryRecordCount(db, timeZone);
      Iterator i = dayEvents.keySet().iterator();
      while (i.hasNext()) {
        String thisDay = (String) i.next();
        companyCalendar.addEventCount(thisDay, CalendarEventList.EVENT_TYPES[11], dayEvents.get(thisDay));
      }
    } catch (SQLException e) {
      throw new SQLException("Error Building Ticket Calendar Alert Counts 1");
    }
*/
    // List 2
    try {
      //clear the search criteria for the first list
      this.clear();
      this.setOrgId(-1);
      this.setOnlyWithProducts(false);

      //get the userId
      //int userId = module.getUserId(context);
      timeZone = companyCalendar.getCalendarInfo().getTimeZone();

      //set the search criteria for the first list
      this.setAssignedTo(this.getUserId());
      this.setOnlyAssigned(true);
      this.setOnlyOpen(true);
      this.setHasEstimatedResolutionDate(true);
      this.setOnlyOpen(true);
      HashMap dayEvents = this.queryRecordCount(db, timeZone);
      Iterator i = dayEvents.keySet().iterator();
      while (i.hasNext()) {
        String thisDay = (String) i.next();
        companyCalendar.addEventCount(thisDay, CalendarEventList.EVENT_TYPES[12], dayEvents.get(thisDay));
      }
    } catch (SQLException e) {
      throw new SQLException("Error Building Ticket Calendar Alert Counts 2");
    }
  }
}

