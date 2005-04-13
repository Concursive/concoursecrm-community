/*
 *  Copyright(c) 2004 Team Elements LLC (http://www.teamelements.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Team Elements LLC. Permission to use, copy, and modify this
 *  material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. TEAM
 *  ELEMENTS MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL TEAM ELEMENTS LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR ANY
 *  DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package com.zeroio.iteam.base;

import java.sql.*;
import java.util.Calendar;
import java.util.Iterator;
import java.util.ArrayList;
import java.text.*;
import com.darkhorseventures.framework.beans.*;
import com.darkhorseventures.framework.actions.*;
import org.aspcfs.utils.DatabaseUtils;

/**
 *  Description of the Class
 *
 *@author     matt rajkowski
 *@created    July 23, 2001
 *@version    $Id: Requirement.java,v 1.1.136.1 2004/03/19 21:00:50 rvasista Exp
 *      $
 */
public class Requirement extends GenericBean {

  private Project project = null;
  private int projectId = -1;
  private int id = -1;
  private String submittedBy = "";
  private String departmentBy = "";
  private String shortDescription = "";
  private String description = "";
  private java.sql.Timestamp dateReceived = null;
  private int estimatedLoe = -1;
  private int estimatedLoeTypeId = -1;
  private String estimatedLoeType = null;
  private int actualLoe = -1;
  private int actualLoeTypeId = -1;
  private String actualLoeType = null;
  private java.sql.Timestamp startDate = null;
  private java.sql.Timestamp deadline = null;
  private boolean approved = false;
  private int approvedBy = -1;
  private String approvedByString = "";
  private java.sql.Timestamp approvalDate = null;
  private boolean closed = false;
  private int closedBy = -1;
  private java.sql.Timestamp closeDate = null;
  private int enteredBy = -1;
  private java.sql.Timestamp entered = null;
  private java.sql.Timestamp modified = null;
  private int modifiedBy = -1;
  private String startDateTimeZone = null;
  private String deadlineTimeZone = null;
  // Helpers
  private AssignmentList assignments = new AssignmentList();
  private boolean treeOpen = false;
  private AssignmentFolder plan = new AssignmentFolder();
  // Activity counts
  private int planActivityCount = -1;
  private int planClosedCount = -1;
  private int planUpcomingCount = -1;
  private int planOverdueCount = -1;


  /**
   *  Constructor for the Assignment object
   *
   *@since
   */
  public Requirement() { }


  /**
   *  Constructor for the Requirement object
   *
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public Requirement(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }


  /**
   *  Constructor for the Requirement object
   *
   *@param  db                Description of the Parameter
   *@param  requirementId     Description of the Parameter
   *@param  projectId         Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public Requirement(Connection db, int requirementId, int projectId) throws SQLException {
    this.projectId = projectId;
    queryRecord(db, requirementId);
  }


  /**
   *  Constructor for the Requirement object
   *
   *@param  db                Description of the Parameter
   *@param  requirementId     Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public Requirement(Connection db, int requirementId) throws SQLException {
    queryRecord(db, requirementId);
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  requirementId     Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  private void queryRecord(Connection db, int requirementId) throws SQLException {
    StringBuffer sql = new StringBuffer();
    sql.append(
        "SELECT r.*, loe_e.description as loe_estimated_type, loe_a.description as loe_actual_type " +
        "FROM project_requirements r " +
        " LEFT JOIN lookup_project_loe loe_e ON (r.estimated_loetype = loe_e.code) " +
        " LEFT JOIN lookup_project_loe loe_a ON (r.actual_loetype = loe_a.code) " +
        "WHERE requirement_id = ? ");

    if (projectId > -1) {
      sql.append("AND project_id = ? ");
    }

    PreparedStatement pst = db.prepareStatement(sql.toString());
    int i = 0;
    pst.setInt(++i, requirementId);
    if (projectId > -1) {
      pst.setInt(++i, projectId);
    }
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    } else {
      rs.close();
      pst.close();
      throw new SQLException("Requirement record not found.");
    }
    rs.close();
    pst.close();
  }


  /**
   *  Description of the Method
   *
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  private void buildRecord(ResultSet rs) throws SQLException {
    //project_requirements table
    id = rs.getInt("requirement_id");
    projectId = rs.getInt("project_id");
    submittedBy = rs.getString("submittedBy");
    departmentBy = rs.getString("departmentBy");
    shortDescription = rs.getString("shortDescription");
    description = rs.getString("description");
    dateReceived = rs.getTimestamp("dateReceived");
    estimatedLoe = DatabaseUtils.getInt(rs, "estimated_loevalue");
    estimatedLoeTypeId = DatabaseUtils.getInt(rs, "estimated_loetype");
    actualLoe = DatabaseUtils.getInt(rs, "actual_loevalue");
    actualLoeTypeId = DatabaseUtils.getInt(rs, "actual_loetype");
    deadline = rs.getTimestamp("deadline");
    approvedBy = DatabaseUtils.getInt(rs, "approvedBy");
    approvalDate = rs.getTimestamp("approvalDate");
    approved = (approvalDate != null);
    closedBy = DatabaseUtils.getInt(rs, "closedBy");
    closeDate = rs.getTimestamp("closedate");
    closed = (closeDate != null);
    entered = rs.getTimestamp("entered");
    enteredBy = rs.getInt("enteredBy");
    modified = rs.getTimestamp("modified");
    modifiedBy = rs.getInt("modifiedBy");
    startDate = rs.getTimestamp("startdate");
    this.startDateTimeZone = rs.getString("startdate_timezone");
    this.deadlineTimeZone = rs.getString("deadline_timezone");

    //lookup_project_loe table
    estimatedLoeType = rs.getString("loe_estimated_type");
    actualLoeType = rs.getString("loe_actual_type");
  }


  /**
   *  Sets the project attribute of the Requirement object
   *
   *@param  tmp  The new project value
   */
  public void setProject(Project tmp) {
    this.project = tmp;
  }


  /**
   *  Sets the projectId attribute of the Requirement object
   *
   *@param  tmp  The new projectId value
   */
  public void setProjectId(int tmp) {
    this.projectId = tmp;
  }


  /**
   *  Sets the projectId attribute of the Requirement object
   *
   *@param  tmp  The new projectId value
   */
  public void setProjectId(String tmp) {
    this.projectId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the id attribute of the Requirement object
   *
   *@param  tmp  The new id value
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   *  Sets the id attribute of the Requirement object
   *
   *@param  tmp  The new id value
   */
  public void setId(String tmp) {
    this.id = Integer.parseInt(tmp);
  }


  /**
   *  Sets the submittedBy attribute of the Requirement object
   *
   *@param  tmp  The new submittedBy value
   */
  public void setSubmittedBy(String tmp) {
    this.submittedBy = tmp;
  }


  /**
   *  Sets the departmentBy attribute of the Requirement object
   *
   *@param  tmp  The new departmentBy value
   */
  public void setDepartmentBy(String tmp) {
    this.departmentBy = tmp;
  }


  /**
   *  Sets the shortDescription attribute of the Requirement object
   *
   *@param  tmp  The new shortDescription value
   */
  public void setShortDescription(String tmp) {
    this.shortDescription = tmp;
  }


  /**
   *  Sets the description attribute of the Requirement object
   *
   *@param  tmp  The new description value
   */
  public void setDescription(String tmp) {
    this.description = tmp;
  }


  /**
   *  Sets the dateReceived attribute of the Requirement object
   *
   *@param  tmp  The new dateReceived value
   */
  public void setDateReceived(java.sql.Timestamp tmp) {
    this.dateReceived = tmp;
  }


  /**
   *  Sets the dateReceived attribute of the Requirement object
   *
   *@param  tmp  The new dateReceived value
   */
  public void setDateReceived(String tmp) {
    try {
      java.util.Date tmpDate = DateFormat.getDateInstance(3).parse(tmp);
      dateReceived = new java.sql.Timestamp(System.currentTimeMillis());
      dateReceived.setTime(tmpDate.getTime());
      dateReceived.setNanos(0);
    } catch (Exception e) {
    }
  }


  /**
   *  Sets the estimatedLoe attribute of the Requirement object
   *
   *@param  tmp  The new estimatedLoe value
   */
  public void setEstimatedLoe(int tmp) {
    this.estimatedLoe = tmp;
  }


  /**
   *  Sets the estimatedLoe attribute of the Requirement object
   *
   *@param  tmp  The new estimatedLoe value
   */
  public void setEstimatedLoe(String tmp) {
    this.estimatedLoe = Integer.parseInt(tmp);
  }


  /**
   *  Sets the estimatedLoeTypeId attribute of the Requirement object
   *
   *@param  tmp  The new estimatedLoeTypeId value
   */
  public void setEstimatedLoeTypeId(int tmp) {
    this.estimatedLoeTypeId = tmp;
  }


  /**
   *  Sets the estimatedLoeTypeId attribute of the Requirement object
   *
   *@param  tmp  The new estimatedLoeTypeId value
   */
  public void setEstimatedLoeTypeId(String tmp) {
    this.estimatedLoeTypeId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the estimatedLoeType attribute of the Requirement object
   *
   *@param  tmp  The new estimatedLoeType value
   */
  public void setEstimatedLoeType(String tmp) {
    this.estimatedLoeType = tmp;
  }


  /**
   *  Sets the actualLoe attribute of the Requirement object
   *
   *@param  tmp  The new actualLoe value
   */
  public void setActualLoe(int tmp) {
    this.actualLoe = tmp;
  }


  /**
   *  Sets the actualLoe attribute of the Requirement object
   *
   *@param  tmp  The new actualLoe value
   */
  public void setActualLoe(String tmp) {
    this.actualLoe = Integer.parseInt(tmp);
  }


  /**
   *  Sets the actualLoeTypeId attribute of the Requirement object
   *
   *@param  tmp  The new actualLoeTypeId value
   */
  public void setActualLoeTypeId(int tmp) {
    this.actualLoeTypeId = tmp;
  }


  /**
   *  Sets the actualLoeTypeId attribute of the Requirement object
   *
   *@param  tmp  The new actualLoeTypeId value
   */
  public void setActualLoeTypeId(String tmp) {
    this.actualLoeTypeId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the actualLoeType attribute of the Requirement object
   *
   *@param  tmp  The new actualLoeType value
   */
  public void setActualLoeType(String tmp) {
    this.actualLoeType = tmp;
  }


  /**
   *  Sets the startDate attribute of the Requirement object
   *
   *@param  tmp  The new startDate value
   */
  public void setStartDate(java.sql.Timestamp tmp) {
    this.startDate = tmp;
  }


  /**
   *  Sets the startDate attribute of the Requirement object
   *
   *@param  tmp  The new startDate value
   */
  public void setStartDate(String tmp) {
    startDate = DatabaseUtils.parseDateToTimestamp(tmp);
  }


  /**
   *  Sets the deadline attribute of the Requirement object
   *
   *@param  tmp  The new deadline value
   */
  public void setDeadline(java.sql.Timestamp tmp) {
    this.deadline = tmp;
  }


  /**
   *  Sets the deadline attribute of the Requirement object
   *
   *@param  tmp  The new deadline value
   */
  public void setDeadline(String tmp) {
    deadline = DatabaseUtils.parseDateToTimestamp(tmp);
  }


  /**
   *  Sets the approved attribute of the Requirement object
   *
   *@param  tmp  The new approved value
   */
  public void setApproved(boolean tmp) {
    this.approved = tmp;
  }


  /**
   *  Sets the approved attribute of the Requirement object
   *
   *@param  tmp  The new approved value
   */
  public void setApproved(String tmp) {
    approved = ("on".equalsIgnoreCase(tmp) || "true".equalsIgnoreCase(tmp));
  }


  /**
   *  Sets the approvedBy attribute of the Requirement object
   *
   *@param  tmp  The new approvedBy value
   */
  public void setApprovedBy(int tmp) {
    this.approvedBy = tmp;
  }


  /**
   *  Sets the approvedBy attribute of the Requirement object
   *
   *@param  tmp  The new approvedBy value
   */
  public void setApprovedBy(String tmp) {
    this.approvedBy = Integer.parseInt(tmp);
  }


  /**
   *  Sets the approvedByString attribute of the Requirement object
   *
   *@param  tmp  The new approvedByString value
   */
  public void setApprovedByString(String tmp) {
    this.approvedByString = tmp;
  }


  /**
   *  Sets the approvalDate attribute of the Requirement object
   *
   *@param  tmp  The new approvalDate value
   */
  public void setApprovalDate(java.sql.Timestamp tmp) {
    approvalDate = tmp;
  }


  /**
   *  Sets the approvalDate attribute of the Requirement object
   *
   *@param  tmp  The new approvalDate value
   */
  public void setApprovalDate(String tmp) {
    this.approvalDate = DatabaseUtils.parseDateToTimestamp(tmp);
  }


  /**
   *  Sets the closedBy attribute of the Requirement object
   *
   *@param  tmp  The new closedBy value
   */
  public void setClosedBy(int tmp) {
    closedBy = tmp;
  }


  /**
   *  Sets the closedBy attribute of the Requirement object
   *
   *@param  tmp  The new closedBy value
   */
  public void setClosedBy(String tmp) {
    closedBy = Integer.parseInt(tmp);
  }


  /**
   *  Sets the closed attribute of the Requirement object
   *
   *@param  tmp  The new closed value
   */
  public void setClosed(boolean tmp) {
    this.closed = tmp;
  }


  /**
   *  Sets the closed attribute of the Requirement object
   *
   *@param  tmp  The new closed value
   */
  public void setClosed(String tmp) {
    closed = ("on".equalsIgnoreCase(tmp) || "true".equalsIgnoreCase(tmp));
  }


  /**
   *  Sets the closeDate attribute of the Requirement object
   *
   *@param  tmp  The new closeDate value
   */
  public void setCloseDate(java.sql.Timestamp tmp) {
    this.closeDate = tmp;
  }


  /**
   *  Sets the closeDate attribute of the Requirement object
   *
   *@param  tmp  The new closeDate value
   */
  public void setCloseDate(String tmp) {
    this.closeDate = DatabaseUtils.parseDateToTimestamp(tmp);
  }


  /**
   *  Sets the enteredBy attribute of the Requirement object
   *
   *@param  tmp  The new enteredBy value
   */
  public void setEnteredBy(int tmp) {
    this.enteredBy = tmp;
  }


  /**
   *  Sets the enteredBy attribute of the Requirement object
   *
   *@param  tmp  The new enteredBy value
   */
  public void setEnteredBy(String tmp) {
    this.enteredBy = Integer.parseInt(tmp);
  }


  /**
   *  Sets the entered attribute of the Requirement object
   *
   *@param  tmp  The new entered value
   */
  public void setEntered(java.sql.Timestamp tmp) {
    this.entered = tmp;
  }


  /**
   *  Sets the entered attribute of the Requirement object
   *
   *@param  tmp  The new entered value
   */
  public void setEntered(String tmp) {
    this.entered = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   *  Sets the modified attribute of the Requirement object
   *
   *@param  tmp  The new modified value
   */
  public void setModified(java.sql.Timestamp tmp) {
    this.modified = tmp;
  }


  /**
   *  Sets the modified attribute of the Requirement object
   *
   *@param  tmp  The new modified value
   */
  public void setModified(String tmp) {
    this.modified = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   *  Sets the modifiedBy attribute of the Requirement object
   *
   *@param  tmp  The new modifiedBy value
   */
  public void setModifiedBy(int tmp) {
    this.modifiedBy = tmp;

    if (approvedBy == -1) {
      this.setApprovedBy(tmp);
    }
    if (closedBy == -1) {
      this.setClosedBy(tmp);
    }
  }


  /**
   *  Sets the modifiedBy attribute of the Requirement object
   *
   *@param  tmp  The new modifiedBy value
   */
  public void setModifiedBy(String tmp) {
    this.setModifiedBy(Integer.parseInt(tmp));
  }


  /**
   *  Sets the treeOpen attribute of the Requirement object
   *
   *@param  tmp  The new treeOpen value
   */
  public void setTreeOpen(boolean tmp) {
    this.treeOpen = tmp;
  }


  /**
   *  Sets the planActivityCount attribute of the Requirement object
   *
   *@param  tmp  The new planActivityCount value
   */
  public void setPlanActivityCount(int tmp) {
    this.planActivityCount = tmp;
  }


  /**
   *  Sets the planClosedCount attribute of the Requirement object
   *
   *@param  tmp  The new planClosedCount value
   */
  public void setPlanClosedCount(int tmp) {
    this.planClosedCount = tmp;
  }


  /**
   *  Sets the startDateTimeZone attribute of the Requirement object
   *
   *@param  tmp  The new startDateTimeZone value
   */
  public void setStartDateTimeZone(String tmp) {
    this.startDateTimeZone = tmp;
  }


  /**
   *  Sets the deadlineTimeZone attribute of the Requirement object
   *
   *@param  tmp  The new deadlineTimeZone value
   */
  public void setDeadlineTimeZone(String tmp) {
    this.deadlineTimeZone = tmp;
  }


  /**
   *  Gets the startDateTimeZone attribute of the Requirement object
   *
   *@return    The startDateTimeZone value
   */
  public String getStartDateTimeZone() {
    return startDateTimeZone;
  }


  /**
   *  Gets the deadlineTimeZone attribute of the Requirement object
   *
   *@return    The deadlineTimeZone value
   */
  public String getDeadlineTimeZone() {
    return deadlineTimeZone;
  }


  /**
   *  Gets the project attribute of the Requirement object
   *
   *@return    The project value
   */
  public Project getProject() {
    return project;
  }


  /**
   *  Gets the projectId attribute of the Requirement object
   *
   *@return    The projectId value
   */
  public int getProjectId() {
    return projectId;
  }


  /**
   *  Gets the id attribute of the Requirement object
   *
   *@return    The id value
   */
  public int getId() {
    return id;
  }


  /**
   *  Gets the submittedBy attribute of the Requirement object
   *
   *@return    The submittedBy value
   */
  public String getSubmittedBy() {
    return submittedBy;
  }


  /**
   *  Gets the departmentBy attribute of the Requirement object
   *
   *@return    The departmentBy value
   */
  public String getDepartmentBy() {
    return departmentBy;
  }


  /**
   *  Gets the shortDescription attribute of the Requirement object
   *
   *@return    The shortDescription value
   */
  public String getShortDescription() {
    return shortDescription;
  }


  /**
   *  Gets the description attribute of the Requirement object
   *
   *@return    The description value
   */
  public String getDescription() {
    return description;
  }


  /**
   *  Gets the dateReceived attribute of the Requirement object
   *
   *@return    The dateReceived value
   */
  public Timestamp getDateReceived() {
    return dateReceived;
  }


  /**
   *  Gets the estimatedLoe attribute of the Requirement object
   *
   *@return    The estimatedLoe value
   */
  public int getEstimatedLoe() {
    return estimatedLoe;
  }


  /**
   *  Gets the estimatedLoeValue attribute of the Requirement object
   *
   *@return    The estimatedLoeValue value
   */
  public String getEstimatedLoeValue() {
    return (estimatedLoe == -1 ? "" : "" + estimatedLoe);
  }


  /**
   *  Gets the estimatedLoeTypeId attribute of the Requirement object
   *
   *@return    The estimatedLoeTypeId value
   */
  public int getEstimatedLoeTypeId() {
    return estimatedLoeTypeId;
  }


  /**
   *  Gets the estimatedLoeType attribute of the Requirement object
   *
   *@return    The estimatedLoeType value
   */
  public String getEstimatedLoeType() {
    return estimatedLoeType;
  }


  /**
   *  Gets the actualLoe attribute of the Requirement object
   *
   *@return    The actualLoe value
   */
  public int getActualLoe() {
    return actualLoe;
  }


  /**
   *  Gets the actualLoeValue attribute of the Requirement object
   *
   *@return    The actualLoeValue value
   */
  public String getActualLoeValue() {
    return (actualLoe == -1 ? "" : "" + actualLoe);
  }


  /**
   *  Gets the actualLoeTypeId attribute of the Requirement object
   *
   *@return    The actualLoeTypeId value
   */
  public int getActualLoeTypeId() {
    return actualLoeTypeId;
  }


  /**
   *  Gets the actualLoeType attribute of the Requirement object
   *
   *@return    The actualLoeType value
   */
  public String getActualLoeType() {
    return actualLoeType;
  }


  /**
   *  Gets the estimatedLoeString attribute of the Requirement object
   *
   *@return    The estimatedLoeString value
   */
  public String getEstimatedLoeString() {
    if (estimatedLoe == -1) {
      return "--";
    } else {
      String loeTmp = estimatedLoeType;
      if (loeTmp.endsWith("(s)")) {
        return estimatedLoe + " " + estimatedLoeType.substring(0, estimatedLoeType.indexOf("(s)")) + (estimatedLoe == 1 ? "" : "s");
      } else {
        return loeTmp;
      }
    }
  }


  /**
   *  Gets the actualLoeString attribute of the Requirement object
   *
   *@return    The actualLoeString value
   */
  public String getActualLoeString() {
    if (actualLoe == -1) {
      return "--";
    } else {
      String loeTmp = actualLoeType;
      if (loeTmp.endsWith("(s)")) {
        return actualLoe + " " + actualLoeType.substring(0, actualLoeType.indexOf("(s)")) + (actualLoe == 1 ? "" : "s");
      } else {
        return loeTmp;
      }
    }
  }


  /**
   *  Gets the startDate attribute of the Requirement object
   *
   *@return    The startDate value
   */
  public java.sql.Timestamp getStartDate() {
    return startDate;
  }


  /**
   *  Gets the startDateString attribute of the Requirement object
   *
   *@return    The startDateString value
   */
  public String getStartDateString() {
    try {
      return DateFormat.getDateInstance(DateFormat.SHORT).format(startDate);
    } catch (NullPointerException e) {
    }
    return "--";
  }


  /**
   *  Gets the startDateValue attribute of the Requirement object
   *
   *@return    The startDateValue value
   */
  public String getStartDateValue() {
    try {
      return DateFormat.getDateInstance(DateFormat.SHORT).format(startDate);
    } catch (NullPointerException e) {
    }
    return "";
  }


  /**
   *  Gets the startDateDateTimeString attribute of the Requirement object
   *
   *@return    The startDateDateTimeString value
   */
  public String getStartDateDateTimeString() {
    try {
      return DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT).format(startDate);
    } catch (NullPointerException e) {
    }
    return "--";
  }


  /**
   *  Gets the startDateDateTimeValue attribute of the Requirement object
   *
   *@return    The startDateDateTimeValue value
   */
  public String getStartDateDateTimeValue() {
    try {
      return DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT).format(startDate);
    } catch (NullPointerException e) {
    }
    return "";
  }


  /**
   *  Gets the deadline attribute of the Requirement object
   *
   *@return    The deadline value
   */
  public java.sql.Timestamp getDeadline() {
    return deadline;
  }


  /**
   *  Gets the deadlineString attribute of the Requirement object
   *
   *@return    The deadlineString value
   */
  public String getDeadlineString() {
    try {
      return DateFormat.getDateInstance(DateFormat.SHORT).format(deadline);
    } catch (NullPointerException e) {
    }
    return "--";
  }


  /**
   *  Gets the deadlineValue attribute of the Requirement object
   *
   *@return    The deadlineValue value
   */
  public String getDeadlineValue() {
    try {
      return DateFormat.getDateInstance(DateFormat.SHORT).format(deadline);
    } catch (NullPointerException e) {
    }
    return "";
  }


  /**
   *  Gets the deadlineDateTimeString attribute of the Requirement object
   *
   *@return    The deadlineDateTimeString value
   */
  public String getDeadlineDateTimeString() {
    try {
      return DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT).format(deadline);
    } catch (NullPointerException e) {
    }
    return "--";
  }


  /**
   *  Gets the deadlineDateTimeValue attribute of the Requirement object
   *
   *@return    The deadlineDateTimeValue value
   */
  public String getDeadlineDateTimeValue() {
    try {
      return DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT).format(deadline);
    } catch (NullPointerException e) {
    }
    return "";
  }


  /**
   *  Gets the approved attribute of the Requirement object
   *
   *@return    The approved value
   */
  public boolean getApproved() {
    return approved;
  }


  /**
   *  Gets the approvedBy attribute of the Requirement object
   *
   *@return    The approvedBy value
   */
  public int getApprovedBy() {
    return approvedBy;
  }


  /**
   *  Gets the approvedByString attribute of the Requirement object
   *
   *@return    The approvedByString value
   */
  public String getApprovedByString() {
    return approvedByString;
  }


  /**
   *  Gets the approvalDate attribute of the Requirement object
   *
   *@return    The approvalDate value
   */
  public java.sql.Timestamp getApprovalDate() {
    return approvalDate;
  }


  /**
   *  Gets the closedBy attribute of the Requirement object
   *
   *@return    The closedBy value
   */
  public int getClosedBy() {
    return closedBy;
  }


  /**
   *  Gets the closeDate attribute of the Requirement object
   *
   *@return    The closeDate value
   */
  public java.sql.Timestamp getCloseDate() {
    return closeDate;
  }


  /**
   *  Gets the closed attribute of the Requirement object
   *
   *@return    The closed value
   */
  public boolean getClosed() {
    return (closeDate != null);
  }


  /**
   *  Gets the enteredBy attribute of the Requirement object
   *
   *@return    The enteredBy value
   */
  public int getEnteredBy() {
    return enteredBy;
  }


  /**
   *  Gets the entered attribute of the Requirement object
   *
   *@return    The entered value
   */
  public java.sql.Timestamp getEntered() {
    return entered;
  }


  /**
   *  Gets the enteredString attribute of the Requirement object
   *
   *@return    The enteredString value
   */
  public String getEnteredString() {
    try {
      return DateFormat.getDateInstance(DateFormat.SHORT).format(entered);
    } catch (NullPointerException e) {
    }
    return ("");
  }


  /**
   *  Gets the enteredDateTimeString attribute of the Requirement object
   *
   *@return    The enteredDateTimeString value
   */
  public String getEnteredDateTimeString() {
    try {
      return DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT).format(entered);
    } catch (NullPointerException e) {
    }
    return ("");
  }


  /**
   *  Gets the modified attribute of the Requirement object
   *
   *@return    The modified value
   */
  public Timestamp getModified() {
    return modified;
  }


  /**
   *  Gets the modifiedString attribute of the Requirement object
   *
   *@return    The modifiedString value
   */
  public String getModifiedString() {
    if (modified != null) {
      return modified.toString();
    } else {
      return "";
    }
  }


  /**
   *  Gets the modifiedDateTimeString attribute of the Requirement object
   *
   *@return    The modifiedDateTimeString value
   */
  public String getModifiedDateTimeString() {
    try {
      return DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT).format(modified);
    } catch (NullPointerException e) {
    }
    return ("");
  }


  /**
   *  Gets the modifiedBy attribute of the Requirement object
   *
   *@return    The modifiedBy value
   */
  public int getModifiedBy() {
    return modifiedBy;
  }


  /**
   *  Gets the assignments attribute of the Requirement object
   *
   *@return    The assignments value
   */
  public AssignmentList getAssignments() {
    return assignments;
  }


  /**
   *  Gets the statusGraphicTag attribute of the Requirement object
   *
   *@return    The statusGraphicTag value
   */
  public String getStatusGraphicTag() {
    String statusGraphic = "";
    if (!approved && !closed) {
      statusGraphic = "box-hold.gif";
    }
    if (approved && !closed) {
      statusGraphic = "box.gif";
    }
    if (closed) {
      statusGraphic = "box-checked.gif";
    }
    return "<img border=\"0\" src=\"images/" + statusGraphic + "\" align=\"absmiddle\">";
  }


  /**
   *  Gets the plan attribute of the Requirement object
   *
   *@return    The plan value
   */
  public AssignmentFolder getPlan() {
    return plan;
  }


  /**
   *  Gets the assignmentTag attribute of the Requirement object
   *
   *@param  link  Description of the Parameter
   *@return       The assignmentTag value
   */
  public String getAssignmentTag(String link) {
    String treeGraphic = null;
    if (treeOpen) {
      treeGraphic = "tree1.gif";
    } else {
      treeGraphic = "tree0.gif";
    }
    return "<a href=\"" + link + "\"><img border=\"0\" src=\"images/" + treeGraphic + "\" align=\"absmiddle\"></a>";
  }


  /**
   *  Gets the treeOpen attribute of the Requirement object
   *
   *@return    The treeOpen value
   */
  public boolean isTreeOpen() {
    return treeOpen;
  }


  /**
   *  Gets the planActivityCount attribute of the Requirement object
   *
   *@return    The planActivityCount value
   */
  public int getPlanActivityCount() {
    return planActivityCount;
  }


  /**
   *  Gets the planClosedCount attribute of the Requirement object
   *
   *@return    The planClosedCount value
   */
  public int getPlanClosedCount() {
    return planClosedCount;
  }

  public int getPlanOverdueCount() {
    return planOverdueCount;
  }

  public void setPlanOverdueCount(int planOverdueCount) {
    this.planOverdueCount = planOverdueCount;
  }

  public int getPlanUpcomingCount() {
    return planUpcomingCount;
  }

  public void setPlanUpcomingCount(int planUpcomingCount) {
    this.planUpcomingCount = planUpcomingCount;
  }

  /**
   *  Gets the RelativeDueDateString attribute of the Assignment object
   *
   *@param  checkDate  Description of the Parameter
   *@return            The RelativeDueDateString value
   *@since
   */
  public String getRelativeDateString(java.sql.Timestamp checkDate) {
    if (checkDate != null) {
      String dateString = checkDate.toString();
      Calendar rightNow = Calendar.getInstance();
      rightNow.set(Calendar.HOUR_OF_DAY, 0);
      rightNow.set(Calendar.MINUTE, 0);
      Calendar dateTest = Calendar.getInstance();
      dateTest.setTime(deadline);
      dateTest.set(Calendar.HOUR_OF_DAY, 0);
      dateTest.set(Calendar.MINUTE, 0);
      if (rightNow.after(dateTest)) {
        return "<font color='red'>" + dateString + "</font>";
      } else {
        dateTest.add(Calendar.DATE, -1);
        if (rightNow.after(dateTest)) {
          return "<font color='orange'>" + dateString + "</font>";
        } else {
          return "<font color='darkgreen'>" + dateString + "</font>";
        }
      }
    } else {
      return ("--");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public boolean insert(Connection db) throws SQLException {

    StringBuffer sql = new StringBuffer();
    sql.append(
        "INSERT INTO project_requirements " +
        "(project_id, submittedBy, departmentBy, shortDescription, description, " +
        "dateReceived, estimated_loevalue, estimated_loetype, actual_loevalue, actual_loetype, " +
        "startdate, startdate_timezone, deadline, deadline_timezone, approvedBy, approvalDate, closedBy, closeDate, ");
    if (entered != null) {
      sql.append("entered, ");
    }
    if (modified != null) {
      sql.append("modified, ");
    }
    sql.append("enteredBy, modifiedBy) ");
    sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,");
    if (entered != null) {
      sql.append("?, ");
    }
    if (modified != null) {
      sql.append("?, ");
    }
    sql.append("?, ?) ");

    int i = 0;
    PreparedStatement pst = db.prepareStatement(sql.toString());
    pst.setInt(++i, projectId);
    pst.setString(++i, submittedBy);
    pst.setString(++i, departmentBy);
    pst.setString(++i, shortDescription);
    pst.setString(++i, description);
    if (dateReceived == null) {
      pst.setNull(++i, java.sql.Types.DATE);
    } else {
      pst.setTimestamp(++i, dateReceived);
    }
    DatabaseUtils.setInt(pst, ++i, estimatedLoe);
    DatabaseUtils.setInt(pst, ++i, estimatedLoeTypeId);
    DatabaseUtils.setInt(pst, ++i, actualLoe);
    DatabaseUtils.setInt(pst, ++i, actualLoeTypeId);
    DatabaseUtils.setTimestamp(pst, ++i, startDate);
    pst.setString(++i, this.startDateTimeZone);
    DatabaseUtils.setTimestamp(pst, ++i, deadline);
    pst.setString(++i, this.deadlineTimeZone);

    if (approved) {
      if (approvalDate == null) {
        java.util.Date tmpDate = new java.util.Date();
        approvalDate = new java.sql.Timestamp(tmpDate.getTime());
      }
    } else {
      approvalDate = null;
    }
    if (approvalDate == null) {
      pst.setNull(++i, java.sql.Types.INTEGER);
      pst.setNull(++i, java.sql.Types.DATE);
    } else {
      if (approvedBy > -1) {
        pst.setInt(++i, approvedBy);
      } else {
        pst.setNull(++i, java.sql.Types.INTEGER);
      }
      approvalDate.setNanos(0);
      pst.setTimestamp(++i, approvalDate);
    }

    if (closed) {
      if (closeDate == null) {
        java.util.Date tmpDate = new java.util.Date();
        closeDate = new java.sql.Timestamp(tmpDate.getTime());
      }
    } else {
      closeDate = null;
    }
    if (closeDate == null) {
      pst.setNull(++i, java.sql.Types.INTEGER);
      pst.setNull(++i, java.sql.Types.DATE);
    } else {
      if (closedBy > -1) {
        pst.setInt(++i, closedBy);
      } else {
        pst.setNull(++i, java.sql.Types.INTEGER);
      }
      closeDate.setNanos(0);
      pst.setTimestamp(++i, closeDate);
    }
    if (entered != null) {
      pst.setTimestamp(++i, entered);
    }
    if (modified != null) {
      pst.setTimestamp(++i, modified);
    }
    pst.setInt(++i, enteredBy);
    pst.setInt(++i, enteredBy);
    pst.execute();
    pst.close();
    id = DatabaseUtils.getCurrVal(db, "project_requi_requirement_i_seq");
    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public boolean delete(Connection db) throws SQLException {
    if (this.getId() == -1 || this.projectId == -1) {
      throw new SQLException("Requirement ID was not specified");
    }
    boolean commit = db.getAutoCommit();
    int recordCount = 0;
    try {
      if (commit) {
        db.setAutoCommit(false);
      }
      //Delete assignments/assignment folders and mappings
      RequirementMapList.delete(db, id);
      AssignmentList.delete(db, id);
      AssignmentFolderList.delete(db, id);
      //Delete the requirement
      PreparedStatement pst = db.prepareStatement(
          "DELETE FROM project_requirements " +
          "WHERE requirement_id = ? ");
      pst.setInt(1, id);
      recordCount = pst.executeUpdate();
      pst.close();
      if (commit) {
        db.commit();
      }
    } catch (Exception e) {
      if (commit) {
        db.rollback();
      }
      throw new SQLException(e.getMessage());
    } finally {
      if (commit) {
        db.setAutoCommit(true);
      }
    }
    if (recordCount == 0) {
      return false;
    } else {
      return true;
    }
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  context           Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public int update(Connection db, ActionContext context) throws SQLException {
    return update(db);
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public int update(Connection db) throws SQLException {
    if (this.getId() == -1 || this.projectId == -1) {
      throw new SQLException("ID was not specified");
    }
    int resultCount = 0;
    Requirement previousState = new Requirement(db, this.getId());
    PreparedStatement pst = db.prepareStatement(
        "UPDATE project_requirements " +
        "SET submittedBy = ?, departmentBy = ?, shortDescription = ?, description = ?, " +
        " dateReceived = ?, estimated_loevalue = ?, estimated_loetype = ?, actual_loevalue = ?, actual_loetype = ?, " +
        " startdate = ?, startdate_timezone = ?, deadline = ?, deadline_timezone = ?,  approvedBy = ?, " +
        " approvalDate = ?, closedBy = ?, closeDate = ?, modifiedBy = ?, modified = CURRENT_TIMESTAMP " +
        "WHERE requirement_id = ? " +
        "AND project_id = ? " +
        "AND modified = ? ");
    int i = 0;
    pst.setString(++i, submittedBy);
    pst.setString(++i, departmentBy);
    pst.setString(++i, shortDescription);
    pst.setString(++i, description);
    if (dateReceived == null) {
      pst.setNull(++i, java.sql.Types.DATE);
    } else {
      pst.setTimestamp(++i, dateReceived);
    }
    DatabaseUtils.setInt(pst, ++i, estimatedLoe);
    DatabaseUtils.setInt(pst, ++i, estimatedLoeTypeId);
    DatabaseUtils.setInt(pst, ++i, actualLoe);
    DatabaseUtils.setInt(pst, ++i, actualLoeTypeId);
    DatabaseUtils.setTimestamp(pst, ++i, startDate);
    pst.setString(++i, this.startDateTimeZone);
    DatabaseUtils.setTimestamp(pst, ++i, deadline);
    pst.setString(++i, this.deadlineTimeZone);
    if (previousState.getApproved() && approved) {
      DatabaseUtils.setInt(pst, ++i, previousState.getApprovedBy());
      pst.setTimestamp(++i, previousState.getApprovalDate());
    } else if (!previousState.getApproved() && approved) {
      pst.setInt(++i, approvedBy);
      if (approvalDate == null) {
        java.util.Date tmpDate = new java.util.Date();
        approvalDate = new java.sql.Timestamp(tmpDate.getTime());
        approvalDate.setNanos(0);
      }
      pst.setTimestamp(++i, approvalDate);
    } else if (!approved) {
      pst.setNull(++i, java.sql.Types.INTEGER);
      pst.setNull(++i, java.sql.Types.DATE);
    }
    if (previousState.getClosed() && closed) {
      DatabaseUtils.setInt(pst, ++i, previousState.getClosedBy());
      pst.setTimestamp(++i, previousState.getCloseDate());
    } else if (!previousState.getClosed() && closed) {
      pst.setInt(++i, closedBy);
      if (closeDate == null) {
        java.util.Date tmpDate = new java.util.Date();
        closeDate = new java.sql.Timestamp(tmpDate.getTime());
        closeDate.setNanos(0);
      }
      pst.setTimestamp(++i, closeDate);
    } else if (!closed) {
      pst.setNull(++i, java.sql.Types.INTEGER);
      pst.setNull(++i, java.sql.Types.DATE);
    }
    pst.setInt(++i, this.getModifiedBy());
    pst.setInt(++i, this.getId());
    pst.setInt(++i, projectId);
    pst.setTimestamp(++i, modified);
    resultCount = pst.executeUpdate();
    pst.close();
    return resultCount;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public int buildAssignmentList(Connection db) throws SQLException {
    assignments.setProject(this.getProject());
    assignments.setProjectId(this.getProjectId());
    assignments.setRequirementId(this.getId());
    assignments.buildList(db);
    return assignments.size();
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  folderState       Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void buildPlan(Connection db, ArrayList folderState) throws SQLException {
    plan.getFolders().setRequirementId(this.getId());
    plan.getFolders().setParentId(0);
    plan.getFolders().buildList(db);
    plan.getAssignments().setRequirementId(this.getId());
    plan.getAssignments().setFolderId(0);
    plan.getAssignments().setClosedOnly(this.getAssignments().getClosedOnly());
    plan.getAssignments().setIncompleteOnly(this.getAssignments().getIncompleteOnly());
    plan.getAssignments().buildList(db);
    buildItems(db, plan.getFolders(), true, folderState);
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void buildFolderHierarchy(Connection db) throws SQLException {
    plan.getFolders().setRequirementId(this.getId());
    plan.getFolders().setParentId(0);
    plan.getFolders().buildList(db);
    buildItems(db, plan.getFolders(), false, null);
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  folderList        Description of the Parameter
   *@param  buildAssignments  Description of the Parameter
   *@param  folderState       Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  private void buildItems(Connection db, AssignmentFolderList folderList, boolean buildAssignments, ArrayList folderState) throws SQLException {
    Iterator i = folderList.iterator();
    while (i.hasNext()) {
      AssignmentFolder folder = (AssignmentFolder) i.next();
      if (isFolderTreeOpen(folderState, folder.getId())) {
        folder.setTreeOpen(true);
        folder.getFolders().setRequirementId(folder.getRequirementId());
        folder.getFolders().setParentId(folder.getId());
        folder.getFolders().buildList(db);
        if (buildAssignments) {
          folder.getAssignments().setRequirementId(folder.getRequirementId());
          folder.getAssignments().setFolderId(folder.getId());
          folder.getAssignments().setClosedOnly(this.getAssignments().getClosedOnly());
          folder.getAssignments().setIncompleteOnly(this.getAssignments().getIncompleteOnly());
          folder.getAssignments().buildList(db);
        }
        buildItems(db, folder.getFolders(), buildAssignments, folderState);
      } else {
        folder.setTreeOpen(false);
      }
    }
  }


  /**
   *  Gets the folderTreeOpen attribute of the Requirement object
   *
   *@param  folderIds  Description of the Parameter
   *@param  folderId   Description of the Parameter
   *@return            The folderTreeOpen value
   */
  private boolean isFolderTreeOpen(ArrayList folderIds, int folderId) {
    if (folderIds == null) {
      return true;
    }
    if (folderIds.contains(new Integer(folderId))) {
      return true;
    }
    return false;
  }


  /**
   *  The following fields depend on a timezone preference
   *
   *@return    The timeZoneParams value
   */
  public static ArrayList getTimeZoneParams() {
    ArrayList thisList = new ArrayList();
    thisList.add("startDate");
    thisList.add("deadline");
    return thisList;
  }
  
  public int getPercentClosed() {
    if (planActivityCount == 0 || planClosedCount == planActivityCount) {
      return 100;
    }
    return (int) Math.round(((double) planClosedCount / (double) planActivityCount) * 100.0);
  }

  public int getPercentUpcoming() {
    if (planActivityCount == 0 || planUpcomingCount == 0) {
      return 0;
    }
    return (int) Math.round(((double) planUpcomingCount / (double) planActivityCount) * 100.0);
  }

  public int getPercentOverdue() {
    if (planActivityCount == 0 || planOverdueCount == 0) {
      return 0;
    }
    return (int) Math.round(((double) planOverdueCount / (double) planActivityCount) * 100.0);
  }

  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void buildPlanActivityCounts(Connection db) throws SQLException {
    planActivityCount = 0;
    planClosedCount = 0;
    planUpcomingCount = 0;
    planOverdueCount = 0;
    // Total count
    PreparedStatement pst = db.prepareStatement(
        "SELECT COUNT(*) AS plan_count " +
        "FROM project_assignments " +
        "WHERE requirement_id = ? ");
    pst.setInt(1, id);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      planActivityCount = rs.getInt("plan_count");
    }
    rs.close();
    pst.close();
    // Complete-Closed count
    pst = db.prepareStatement(
        "SELECT COUNT(*) AS plan_count " +
        "FROM project_assignments " +
        "WHERE requirement_id = ? " +
        "AND complete_date IS NOT NULL ");
    pst.setInt(1, id);
    rs = pst.executeQuery();
    if (rs.next()) {
      planClosedCount = rs.getInt("plan_count");
    }
    rs.close();
    pst.close();
    // Overdue count
    pst = db.prepareStatement(
        "SELECT COUNT(*) AS reccount " +
        "FROM project_assignments " +
        "WHERE requirement_id = ? " +
        "AND complete_date IS NULL " +
        "AND due_date IS NOT NULL AND due_date < CURRENT_TIMESTAMP "
    );
    pst.setInt(1, id);
    rs = pst.executeQuery();
    if (rs.next()) {
      planOverdueCount = rs.getInt("reccount");
    }
    rs.close();
    pst.close();
    // Upcoming count
    pst = db.prepareStatement(
        "SELECT count(*) AS reccount " +
        "FROM project_assignments " +
        "WHERE requirement_id = ? " +
        "AND complete_date IS NULL " +
        "AND ((due_date IS NOT NULL AND due_date >= CURRENT_TIMESTAMP) " +
        "     OR (due_date IS NULL)) "
    );
    pst.setInt(1, id);
    rs = pst.executeQuery();
    if (rs.next()) {
      planUpcomingCount = rs.getInt("reccount");
    }
    rs.close();
    pst.close();
  }
}


