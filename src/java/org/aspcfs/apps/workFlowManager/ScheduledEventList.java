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
package org.aspcfs.apps.workFlowManager;

import java.util.*;
import java.sql.*;
import org.aspcfs.modules.base.Constants;

/**
 *  A collection of Scheduled Event objects.
 *
 *@author     matt rajkowski
 *@created    June 23, 2003
 *@version    $Id: ScheduledEventList.java,v 1.1 2003/06/24 15:17:30 mrajkowski
 *      Exp $
 */
public class ScheduledEventList extends ArrayList {

  //Filters for query
  private int businessProcessId = -1;
  private int enabled = Constants.UNDEFINED;


  /**
   *  Constructor for the ScheduledEventList object
   */
  public ScheduledEventList() { }


  /**
   *  Sets the businessProcessId attribute of the ScheduledEventList object
   *
   *@param  tmp  The new businessProcessId value
   */
  public void setBusinessProcessId(int tmp) {
    this.businessProcessId = tmp;
  }


  /**
   *  Sets the businessProcessId attribute of the ScheduledEventList object
   *
   *@param  tmp  The new businessProcessId value
   */
  public void setBusinessProcessId(String tmp) {
    this.businessProcessId = Integer.parseInt(tmp);
  }


  /**
   *  Gets the businessProcessId attribute of the ScheduledEventList object
   *
   *@return    The businessProcessId value
   */
  public int getBusinessProcessId() {
    return businessProcessId;
  }


  /**
   *  Sets the enabled attribute of the ScheduledEventList object
   *
   *@param  tmp  The new enabled value
   */
  public void setEnabled(int tmp) {
    this.enabled = tmp;
  }


  /**
   *  Sets the enabled attribute of the ScheduledEventList object
   *
   *@param  tmp  The new enabled value
   */
  public void setEnabled(String tmp) {
    this.enabled = Integer.parseInt(tmp);
  }


  /**
   *  Gets the enabled attribute of the ScheduledEventList object
   *
   *@return    The enabled value
   */
  public int getEnabled() {
    return enabled;
  }


  /**
   *  Loads scheduled events from the database using the specified filters
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void buildList(Connection db) throws SQLException {
    StringBuffer sqlSelect = new StringBuffer();
    StringBuffer sqlFilter = new StringBuffer();
    StringBuffer sqlOrder = new StringBuffer();
    sqlSelect.append(
        "SELECT event_id, second, minute, hour, " +
        "dayofmonth, month, dayofweek, year, task, extrainfo, " +
        "enabled, entered, process_id " +
        "FROM business_process_events " +
        "WHERE event_id > 0 ");
    createFilter(sqlFilter);
    sqlOrder.append("ORDER BY event_id ");
    PreparedStatement pst = db.prepareStatement(sqlSelect.toString() + sqlFilter.toString() + sqlOrder.toString());
    prepareFilter(pst);
    ResultSet rs = pst.executeQuery();
    while (rs.next()) {
      ScheduledEvent thisEvent = new ScheduledEvent(rs);
      this.add(thisEvent);
    }
    rs.close();
    pst.close();
  }


  /**
   *  Adds filter parameters to the query
   *
   *@param  sqlFilter  Description of the Parameter
   */
  private void createFilter(StringBuffer sqlFilter) {
    if (sqlFilter == null) {
      sqlFilter = new StringBuffer();
    }
    if (businessProcessId > -1) {
      sqlFilter.append("AND process_id = ? ");
    }
    if (enabled != Constants.UNDEFINED) {
      sqlFilter.append("AND enabled = ? ");
    }
  }


  /**
   *  Sets the filter parameters on the query
   *
   *@param  pst               Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  private int prepareFilter(PreparedStatement pst) throws SQLException {
    int i = 0;
    if (businessProcessId > -1) {
      pst.setInt(++i, businessProcessId);
    }
    if (enabled != Constants.UNDEFINED) {
      pst.setBoolean(++i, enabled == Constants.TRUE);
    }
    return i;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  void delete(Connection db) throws SQLException {
    Iterator itr = this.iterator();
    while (itr.hasNext()) {
      ScheduledEvent tmpScheduledEvent = (ScheduledEvent) itr.next();
      tmpScheduledEvent.delete(db);
    }
  }
}

