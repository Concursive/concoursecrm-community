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
package org.aspcfs.modules.tasks.base;

import org.aspcfs.modules.base.Constants;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.DateUtils;
import org.aspcfs.utils.web.PagedListInfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.TimeZone;

/**
 * Description of the Class
 *
 * @author akhi_m
 * @version $Id: TaskList.java,v 1.19.50.1 2004/07/06 19:13:37 mrajkowski Exp
 *          $
 * @created August 15, 2002
 */
public class TaskList extends ArrayList {
  protected int enteredBy = -1;
  protected PagedListInfo pagedListInfo = null;
  protected int owner = -1;
  protected int complete = -1;
  protected int sharing = Constants.UNDEFINED;
  protected int tasksAssignedByUser = -1;
  protected java.sql.Timestamp alertRangeStart = null;
  protected java.sql.Timestamp alertRangeEnd = null;
  protected int categoryId = -1;
  protected int projectId = -1;
  protected int ticketId = -1;
  protected int hasLinkedContact = Constants.UNDEFINED;
  protected int areAssigned = Constants.UNDEFINED;
  private java.sql.Timestamp trashedDate = null;
  private boolean includeOnlyTrashed = false;


  /**
   * Constructor for the TaskList object
   */
  public TaskList() {
  }


  /**
   * Gets the sharing attribute of the TaskList object
   *
   * @return The sharing value
   */
  public int getSharing() {
    return sharing;
  }


  /**
   * Sets the sharing attribute of the TaskList object
   *
   * @param tmp The new sharing value
   */
  public void setSharing(int tmp) {
    this.sharing = tmp;
  }


  /**
   * Sets the sharing attribute of the TaskList object
   *
   * @param tmp The new sharing value
   */
  public void setSharing(String tmp) {
    this.sharing = Integer.parseInt(tmp);
  }


  /**
   * Sets the enteredBy attribute of the TaskList object
   *
   * @param enteredBy The new enteredBy value
   */
  public void setEnteredBy(int enteredBy) {
    this.enteredBy = enteredBy;
  }


  /**
   * Sets the pagedListInfo attribute of the TaskList object
   *
   * @param tmp The new pagedListInfo value
   */
  public void setPagedListInfo(PagedListInfo tmp) {
    this.pagedListInfo = tmp;
  }


  /**
   * Sets the complete attribute of the TaskList object
   *
   * @param tmp The new complete value
   */
  public void setComplete(int tmp) {
    this.complete = tmp;
  }


  /**
   * Sets the owner attribute of the TaskList object
   *
   * @param owner The new owner value
   */
  public void setOwner(int owner) {
    this.owner = owner;
  }


  /**
   * Sets the tasksAssignedByUser attribute of the TaskList object
   *
   * @param tmp The new tasksAssignedByUser value
   */
  public void setTasksAssignedByUser(int tmp) {
    this.tasksAssignedByUser = tmp;
  }


  /**
   * Sets the alertRangeStart attribute of the Task object
   *
   * @param alertRangeStart The new alertRangeStart value
   */
  public void setAlertRangeStart(java.sql.Timestamp alertRangeStart) {
    this.alertRangeStart = alertRangeStart;
  }


  /**
   * Sets the ticketId attribute of the TaskList object
   *
   * @param ticketId The new ticketId value
   */
  public void setTicketId(int ticketId) {
    this.ticketId = ticketId;
  }


  /**
   * Gets the tasksAssignedByUser attribute of the TaskList object
   *
   * @return The tasksAssignedByUser value
   */
  public int getTasksAssignedByUser() {
    return tasksAssignedByUser;
  }


  /**
   * Gets the owner attribute of the TaskList object
   *
   * @return The owner value
   */
  public int getOwner() {
    return owner;
  }


  /**
   * Gets the ticketId attribute of the TaskList object
   *
   * @return The ticketId value
   */
  public int getTicketId() {
    return ticketId;
  }


  /**
   * Sets the alertRangeEnd attribute of the Task object
   *
   * @param alertRangeEnd The new alertRangeEnd value
   */
  public void setAlertRangeEnd(java.sql.Timestamp alertRangeEnd) {
    this.alertRangeEnd = alertRangeEnd;
  }


  /**
   * Sets the categoryId attribute of the TaskList object
   *
   * @param tmp The new categoryId value
   */
  public void setCategoryId(int tmp) {
    this.categoryId = tmp;
  }


  /**
   * Sets the projectId attribute of the TaskList object
   *
   * @param tmp The new projectId value
   */
  public void setProjectId(int tmp) {
    this.projectId = tmp;
  }


  /**
   * Gets the enteredBy attribute of the TaskList object
   *
   * @return The enteredBy value
   */
  public int getEnteredBy() {
    return enteredBy;
  }

  /**
   * Gets the hasLinkedContact attribute of the TaskList object
   *
   * @return The hasLinkedContact value
   */
  public int getHasLinkedContact() {
    return hasLinkedContact;
  }


  /**
   * Sets the hasLinkedContact attribute of the TaskList object
   *
   * @param tmp The new hasLinkedContact value
   */
  public void setHasLinkedContact(int tmp) {
    this.hasLinkedContact = tmp;
  }


  /**
   * Sets the hasLinkedContact attribute of the TaskList object
   *
   * @param tmp The new hasLinkedContact value
   */
  public void setHasLinkedContact(String tmp) {
    this.hasLinkedContact = Integer.parseInt(tmp);
  }


  /**
   * Gets the areAssigned attribute of the TaskList object
   *
   * @return The areAssigned value
   */
  public int getAreAssigned() {
    return areAssigned;
  }


  /**
   * Sets the areAssigned attribute of the TaskList object
   *
   * @param tmp The new areAssigned value
   */
  public void setAreAssigned(int tmp) {
    this.areAssigned = tmp;
  }


  /**
   * Sets the areAssigned attribute of the TaskList object
   *
   * @param tmp The new areAssigned value
   */
  public void setAreAssigned(String tmp) {
    this.areAssigned = Integer.parseInt(tmp);
  }


  /**
   * Gets the trashedDate attribute of the TaskList object
   *
   * @return The trashedDate value
   */
  public java.sql.Timestamp getTrashedDate() {
    return trashedDate;
  }


  /**
   * Sets the trashedDate attribute of the TaskList object
   *
   * @param tmp The new trashedDate value
   */
  public void setTrashedDate(java.sql.Timestamp tmp) {
    this.trashedDate = tmp;
  }


  /**
   * Sets the trashedDate attribute of the TaskList object
   *
   * @param tmp The new trashedDate value
   */
  public void setTrashedDate(String tmp) {
    this.trashedDate = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   * Gets the includeOnlyTrashed attribute of the TaskList object
   *
   * @return The includeOnlyTrashed value
   */
  public boolean getIncludeOnlyTrashed() {
    return includeOnlyTrashed;
  }


  /**
   * Sets the includeOnlyTrashed attribute of the TaskList object
   *
   * @param tmp The new includeOnlyTrashed value
   */
  public void setIncludeOnlyTrashed(boolean tmp) {
    this.includeOnlyTrashed = tmp;
  }


  /**
   * Sets the includeOnlyTrashed attribute of the TaskList object
   *
   * @param tmp The new includeOnlyTrashed value
   */
  public void setIncludeOnlyTrashed(String tmp) {
    this.includeOnlyTrashed = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   * Return a mapping of number of alerts for each alert category.
   *
   * @param db       Description of the Parameter
   * @param timeZone Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public HashMap queryRecordCount(Connection db, TimeZone timeZone) throws SQLException {
    PreparedStatement pst = null;
    ResultSet rs = null;
    HashMap events = new HashMap();
    StringBuffer sqlSelect = new StringBuffer();
    StringBuffer sqlFilter = new StringBuffer();
    StringBuffer sqlTail = new StringBuffer();
    sqlSelect.append(
        "SELECT duedate, count(*) AS nocols " +
        "FROM task t " +
        "WHERE t.task_id > -1 ");
    createFilter(sqlFilter);
    sqlFilter.append("AND duedate IS NOT NULL ");
    sqlFilter.append("AND t.complete = " + DatabaseUtils.getFalse(db) + " ");
    sqlTail.append("GROUP BY duedate");
    pst = db.prepareStatement(
        sqlSelect.toString() + sqlFilter.toString() + sqlTail.toString());
    int i = prepareFilter(pst);
    rs = pst.executeQuery();
    if (System.getProperty("DEBUG") != null) {
      System.out.println("TaskList-> Building Record Count ");
    }
    while (rs.next()) {
      String dueDate = DateUtils.getServerToUserDateString(
          timeZone, DateFormat.SHORT, rs.getTimestamp("duedate"));
      events.put(dueDate, new Integer(rs.getInt("nocols")));
    }
    rs.close();
    pst.close();
    return events;
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void buildShortList(Connection db) throws SQLException {
    PreparedStatement pst = null;
    ResultSet rs = null;
    StringBuffer sqlSelect = new StringBuffer();
    StringBuffer sqlFilter = new StringBuffer();
    createFilter(sqlFilter);
    sqlSelect.append(
        "SELECT t.task_id, t.description, t.duedate, t.complete, t.priority, t.entered, tc.contact_id " +
        "FROM task t " +
        "LEFT JOIN tasklink_contact tc ON (t.task_id = tc.task_id) " +
        "WHERE t.task_id > -1 ");
    pst = db.prepareStatement(sqlSelect.toString() + sqlFilter.toString());
    prepareFilter(pst);
    rs = pst.executeQuery();
    while (rs.next()) {
      Task thisTask = new Task();
      thisTask.setId(rs.getInt("task_id"));
      thisTask.setDescription(rs.getString("description"));
      thisTask.setDueDate(rs.getTimestamp("duedate"));
      thisTask.setComplete(rs.getBoolean("complete"));
      thisTask.setPriority(rs.getInt("priority"));
      thisTask.setEntered(rs.getTimestamp("entered"));
      float ageCheck = ((System.currentTimeMillis() - thisTask.getEntered().getTime()) / 86400000);
      thisTask.setAge(java.lang.Math.round(ageCheck));
      thisTask.setContactId(DatabaseUtils.getInt(rs, "contact_id"));
      this.add(thisTask);
    }
    rs.close();
    pst.close();
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void buildList(Connection db) throws SQLException {
    PreparedStatement pst = null;
    ResultSet rs = null;
    int items = -1;
    StringBuffer sqlSelect = new StringBuffer();
    StringBuffer sqlCount = new StringBuffer();
    StringBuffer sqlFilter = new StringBuffer();
    StringBuffer sqlOrder = new StringBuffer();
    //Build a base SQL statement for counting records
    sqlCount.append(
        "SELECT COUNT(*) AS recordcount " +
        "FROM task t " +
        "WHERE t.task_id > -1 ");
    createFilter(sqlFilter);
    if (pagedListInfo != null) {
      //Get the total number of records matching filter
      pst = db.prepareStatement(sqlCount.toString() + sqlFilter.toString());
      items = prepareFilter(pst);
      rs = pst.executeQuery();
      if (rs.next()) {
        int maxRecords = rs.getInt("recordcount");
        pagedListInfo.setMaxRecords(maxRecords);
      }
      rs.close();
      pst.close();
      //Determine the offset, based on the filter, for the first record to show
      if (!pagedListInfo.getCurrentLetter().equals("")) {
        pst = db.prepareStatement(
            sqlCount.toString() +
            sqlFilter.toString() +
            "AND t.priority > ? ");
        items = prepareFilter(pst);
        pst.setString(++items, pagedListInfo.getCurrentLetter().toLowerCase());
        rs = pst.executeQuery();
        if (rs.next()) {
          int offsetCount = rs.getInt("recordcount");
          pagedListInfo.setCurrentOffset(offsetCount);
        }
        rs.close();
        pst.close();
      }
      if (pagedListInfo.getMaxRecords() == 0) {
        pagedListInfo.setCurrentOffset(0);
      }
      //Determine column to sort by
      pagedListInfo.setDefaultSort("t.priority, description", null);
      pagedListInfo.appendSqlTail(db, sqlOrder);
    } else {
      sqlOrder.append("ORDER BY t.priority, description ");
    }
    //Build a base SQL statement for returning records
    if (pagedListInfo != null) {
      pagedListInfo.appendSqlSelectHead(db, sqlSelect);
    } else {
      sqlSelect.append("SELECT ");
    }
    sqlSelect.append(
        "t.task_id, t.entered, t.enteredby, t.priority, t.description, " +
        "t.duedate, t.notes, t.sharing, t.complete, t.estimatedloe, " +
        "t.estimatedloetype, t.type, t.owner, t.completedate, t.modified, " +
        "t.modifiedby, t.category_id, t.duedate_timezone, t.trashed_date " +
        "FROM task t " +
        "WHERE t.task_id > -1 ");
    pst = db.prepareStatement(
        sqlSelect.toString() + sqlFilter.toString() + sqlOrder.toString());
    items = prepareFilter(pst);
    rs = pst.executeQuery();
    if (pagedListInfo != null) {
      pagedListInfo.doManualOffset(db, rs);
    }
    while (rs.next()) {
      Task thisTask = new Task(rs);
      this.add(thisTask);
    }
    rs.close();
    pst.close();
    Iterator i = this.iterator();
    while (i.hasNext()) {
      Task thisTask = (Task) i.next();
      thisTask.buildResources(db);
      if (thisTask.getType() != Task.GENERAL) {
        thisTask.buildLinkDetails(db);
      }
    }
  }


  /**
   * Description of the Method
   *
   * @param sqlFilter Description of the Parameter
   */
  protected void createFilter(StringBuffer sqlFilter) {
    if (sqlFilter == null) {
      sqlFilter = new StringBuffer();
    }

    if (enteredBy != -1) {
      sqlFilter.append("AND t.enteredby = ? ");
    }

    if (tasksAssignedByUser > 0) {
      sqlFilter.append(
          "AND t.enteredby = ? AND t.owner NOT IN (SELECT user_id FROM contact WHERE user_id = ?) AND t.owner IS NOT NULL ");
    }

    if (owner > 0) {
      sqlFilter.append("AND t.owner = ? ");
    }

    if (complete != -1) {
      sqlFilter.append("AND t.complete = ? ");
    }

    if (sharing != Constants.UNDEFINED) {
      if (sharing == Constants.TRUE) {
        sqlFilter.append("AND t.sharing > 0 ");
      } else if (sharing == Constants.FALSE) {
        sqlFilter.append("AND t.sharing <= 0 ");
      }
    }

    if (alertRangeStart != null) {
      sqlFilter.append("AND t.duedate >= ? ");
    }

    if (alertRangeEnd != null) {
      sqlFilter.append("AND t.duedate < ? ");
    }

    if (categoryId > 0) {
      sqlFilter.append("AND t.category_id = ? ");
    }

    if (projectId > 0) {
      sqlFilter.append(
          "AND t.task_id IN (SELECT task_id FROM tasklink_project WHERE project_id = ?) ");
    }

    if (ticketId > 0) {
      sqlFilter.append(
          "AND t.task_id IN (SELECT task_id FROM tasklink_ticket WHERE ticket_id = ?) ");
    }
    if (hasLinkedContact == Constants.TRUE) {
      sqlFilter.append(
          "AND t.task_id IN (SELECT tlc.task_id FROM tasklink_contact tlc WHERE tlc.contact_id IS NOT NULL) ");
    } else if (hasLinkedContact == Constants.FALSE) {
      sqlFilter.append(
          "AND t.task_id NOT IN (SELECT tlc.task_id FROM tasklink_contact tlc WHERE tlc.contact_id IS NOT NULL) ");
    }
    if (areAssigned == Constants.TRUE) {
      sqlFilter.append("AND t.owner IS NOT NULL ");
    } else if (areAssigned == Constants.FALSE) {
      sqlFilter.append("AND t.owner IS NULL ");
    }
    if (includeOnlyTrashed) {
      sqlFilter.append("AND t.trashed_date IS NOT NULL ");
    } else if (trashedDate != null) {
      sqlFilter.append("AND t.trashed_date = ? ");
    } else {
      sqlFilter.append("AND t.trashed_date IS NULL ");
    }
  }


  /**
   * Description of the Method
   *
   * @param pst Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  protected int prepareFilter(PreparedStatement pst) throws SQLException {
    int i = 0;

    if (enteredBy != -1) {
      pst.setInt(++i, enteredBy);
    }

    if (tasksAssignedByUser > 0) {
      pst.setInt(++i, tasksAssignedByUser);
      pst.setInt(++i, tasksAssignedByUser);
    }

    if (owner > 0) {
      pst.setInt(++i, owner);
    }

    if (complete != -1) {
      pst.setBoolean(++i, (complete == Constants.TRUE ? true : false));
    }

    if (alertRangeStart != null) {
      pst.setTimestamp(++i, alertRangeStart);
    }

    if (alertRangeEnd != null) {
      pst.setTimestamp(++i, alertRangeEnd);
    }

    if (categoryId > 0) {
      pst.setInt(++i, categoryId);
    }

    if (projectId > 0) {
      pst.setInt(++i, projectId);
    }

    if (ticketId > 0) {
      pst.setInt(++i, ticketId);
    }

    if (includeOnlyTrashed) {
      // do nothing
    } else if (trashedDate != null) {
      pst.setTimestamp(++i, trashedDate);
    } else {
      // do nothing
    }
    return i;
  }


  /**
   * Description of the Method
   *
   * @param db     Description of the Parameter
   * @param userId Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public static int queryPendingCount(Connection db, int userId) throws SQLException {
    int toReturn = 0;
    String sql =
        "SELECT count(*) as taskcount " +
        "FROM task " +
        "WHERE owner = ? AND complete = ? ";
    int i = 0;
    PreparedStatement pst = db.prepareStatement(sql);
    pst.setInt(++i, userId);
    pst.setBoolean(++i, false);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      toReturn = rs.getInt("taskcount");
    }
    rs.close();
    pst.close();
    return toReturn;
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void delete(Connection db) throws SQLException {
    Iterator tasks = this.iterator();
    while (tasks.hasNext()) {
      Task thisTask = (Task) tasks.next();
      thisTask.delete(db);
    }
  }


  /**
   * Description of the Method
   *
   * @param db        Description of the Parameter
   * @param toTrash   Description of the Parameter
   * @param tmpUserId Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public boolean updateStatus(Connection db, boolean toTrash, int tmpUserId) throws SQLException {
    Iterator itr = this.iterator();
    while (itr.hasNext()) {
      Task tmpTask = (Task) itr.next();
      tmpTask.updateStatus(db, toTrash, tmpUserId);
    }
    return true;
  }
}


