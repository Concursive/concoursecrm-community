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
package org.aspcfs.modules.contacts.base;

import com.darkhorseventures.framework.actions.ActionContext;
import com.darkhorseventures.framework.beans.GenericBean;
import com.zeroio.webdav.utils.ICalendar;
import org.aspcfs.modules.accounts.base.OrganizationHistory;
import org.aspcfs.modules.actionlist.base.ActionItemLog;
import org.aspcfs.modules.actionlist.base.ActionItemLogList;
import org.aspcfs.modules.actionlist.base.ActionList;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.base.Dependency;
import org.aspcfs.modules.base.DependencyList;
import org.aspcfs.modules.base.PhoneNumber;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.DateUtils;
import org.aspcfs.utils.web.LookupList;

import java.sql.*;
import java.text.DateFormat;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.TimeZone;

/**
 * Description of the Class
 *
 * @author chris
 * @version $Id: Call.java 13737 2006-01-05 21:56:14 -0500 (Thu, 05 Jan 2006)
 *          mrajkowski $
 * @created January 8, 2002
 */
public class Call extends GenericBean {

  private static org.apache.log4j.Logger log = org.apache.log4j.Logger.getLogger(org.aspcfs.modules.contacts.base.Call.class);

  //static variables
  //PENDING :followup due of a completed activity
  public final static int CANCELED = 1;
  public final static int COMPLETE = 2;
  public final static int COMPLETE_FOLLOWUP_PENDING = 3;

  private int id = -1;
  private int orgId = -1;
  private int contactId = -1;
  private int callTypeId = -1;
  private int followupContactId = -1;
  private int oppHeaderId = -1;
  private int length = 0;
  private int enteredBy = -1;
  private String enteredName = "";
  private int modifiedBy = -1;
  private String modifiedName = "";
  private int alertCallTypeId = -1;
  private int owner = -1;
  private int assignedBy = -1;
  private int completedBy = -1;
  private int resultId = -1;
  private int priorityId = -1;
  private int statusId = -1;
  private int reminderTypeId = -1;
  private int reminderId = -1;
  private int parentId = -1;
  private int contactOrgId = -1;

  private String callType = "";
  private String subject = null;
  private String notes = null;
  private String followupNotes = null;
  private String contactName = "";
  private String followupContactName = "";
  private String alertText = null;
  private String alertCallType = "";
  private String priorityString = "";
  private String orgName = null;
  private String alertDateTimeZone = null;
  private String followupEndDateTimeZone = null;
  private String followupLocation = null;
  private String callStartDateTimeZone = null;
  private String callEndDateTimeZone = null;
  private String callLocation = null;
  private boolean emailParticipants = false;
  private boolean emailFollowupParticipants = false;
  private boolean reminder = false;

  private String action = null;
  protected java.sql.Timestamp alertDate = null;
  protected java.sql.Timestamp followupEndDate = null;
  protected java.sql.Timestamp callStartDate = null;
  protected java.sql.Timestamp callEndDate = null;
  private java.sql.Timestamp entered = null;
  private java.sql.Timestamp modified = null;
  private java.sql.Timestamp assignDate = null;
  private java.sql.Timestamp completeDate = null;
  private int followupStatusId = -1;

  private int followupLength = 0;
  private int followupLengthDuration = -1;
  private int callLengthDuration = -1;
  private String callLengthDurationText = null;
  private String followupCallLengthDurationText = null;

  private boolean hasFollowup = false;
  private java.sql.Timestamp trashedDate = null;

  //action list properties
  private int actionId = -1;
  private boolean checkAlertDate = true;

  private boolean updateOrganization = false;
  Contact contact = new Contact();
  Contact followupContact = new Contact();
  CallParticipantList participants = new CallParticipantList();
  CallParticipantList followupParticipants = new CallParticipantList();



  /**
   * Constructor for the Call object
   */
  public Call() {
  }


  /**
   * Constructor for the Call object
   *
   * @param rs Description of Parameter
   * @throws SQLException Description of the Exception
   * @throws SQLException Description of Exception
   */
  public Call(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }


  /**
   * Constructor for the Call object
   *
   * @param db     Description of Parameter
   * @param callId Description of Parameter
   * @throws SQLException Description of the Exception
   * @throws SQLException Description of Exception
   */
  public Call(Connection db, String callId) throws SQLException {
    queryRecord(db, Integer.parseInt(callId));
  }


  /**
   * Constructor for the Call object
   *
   * @param db     Description of the Parameter
   * @param callId Description of the Parameter
   * @throws SQLException Description of the Exception
   * @throws SQLException Description of the Exception
   */
  public Call(Connection db, int callId) throws SQLException {
    queryRecord(db, callId);
  }


  /**
   * Description of the Method
   *
   * @param db     Description of the Parameter
   * @param callId Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void queryRecord(Connection db, int callId) throws SQLException {
    StringBuffer sql = new StringBuffer();
    sql.append(
        "SELECT c.call_id, c.org_id, c.contact_id, c.opp_id, c.call_type_id, " +
        		"c." + DatabaseUtils.addQuotes(db, "length") + ", " +
            "c.subject, c.notes, c.alertdate, c.followup_notes, c.entered as entered_date, c.enteredby, c.modified as modified_date, c.modifiedby, " +
            "c.alert, c.alert_call_type_id, c.parent_id, c.owner, " +
            "c.assignedby, c.assign_date, " +
            "c.completedby, c.complete_date, " +
            "c.result_id, c.priority_id, c.status_id, " +
            "c.reminder_value, c.reminder_type_id, " +
            "c.alertdate_timezone, c.trashed_date, " +
            "c.followup_contact_Id, " +
            "c.followup_end_date, c.followup_end_date_timezone, " +
            "c.followup_location, " +
            "c.followup_length, c.followup_length_duration, " +
            "c.call_start_date, c.call_start_date_timezone, " +
            "c.call_end_date, c.call_end_date_timezone, " +
            "c.call_location, " +
            "c.call_length_duration, " +
            "c.email_participants, " +
            "c.email_followup_participants, " +
            "t.code, talert.description AS alertdescription," +
            "ct.namelast AS ctlast, ct.namefirst AS ctfirst, ct.org_name AS ctcompany, " +
            "fct.namelast AS fctlast, fct.namefirst AS fctfirst, fct.org_name AS fctcompany, " +
            "o.name AS orgname, " +
            "p.description AS priority " +
            "FROM call_log c " +
            "LEFT JOIN contact ct ON (c.contact_id = ct.contact_id) " +
            "LEFT JOIN contact fct ON (c.followup_contact_id = fct.contact_id) " +
            "LEFT JOIN lookup_call_types t ON (c.call_type_id = t.code) " +
            "LEFT JOIN lookup_call_types talert ON (c.alert_call_type_id = talert.code) " +
            "LEFT JOIN lookup_call_priority p ON (c.priority_id = p.code) " +
            "LEFT JOIN organization o ON (c.org_id = o.org_id) " +
            "WHERE call_id > -1 ");
    if (callId > -1) {
      sql.append("AND call_id = " + callId + " ");
    } else {
      throw new SQLException("Valid call ID not specified.");
    }
    PreparedStatement pst = db.prepareStatement(sql.toString());
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    }
    rs.close();
    pst.close();
    if (id == -1) {
      throw new SQLException("Call record not found.");
    }
  }


  /**
   * Sets the oppHeaderId attribute of the Call object
   *
   * @param oppHeaderId The new oppHeaderId value
   */
  public void setOppHeaderId(int oppHeaderId) {
    this.oppHeaderId = oppHeaderId;
  }


  /**
   * Sets the oppHeaderId attribute of the Call object
   *
   * @param oppHeaderId The new oppHeaderId value
   */
  public void setOppHeaderId(String oppHeaderId) {
    this.oppHeaderId = Integer.parseInt(oppHeaderId);
  }


  /**
   * Sets the contactName attribute of the Call object
   *
   * @param contactName The new contactName value
   */
  public void setContactName(String contactName) {
    this.contactName = contactName;
  }


  /**
   * Sets the Id attribute of the Call object
   *
   * @param tmp The new Id value
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   * Sets the assignDate attribute of the Call object
   *
   * @param tmp The new assignDate value
   */
  public void setAssignDate(String tmp) {
    this.assignDate = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   * Sets the completeDate attribute of the Call object
   *
   * @param tmp The new completeDate value
   */
  public void setCompleteDate(String tmp) {
    this.completeDate = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   * Sets the completedBy attribute of the Call object
   *
   * @param tmp The new completedBy value
   */
  public void setCompletedBy(String tmp) {
    this.completedBy = Integer.parseInt(tmp);
  }


  /**
   * Sets the alertDate attribute of the Call object
   *
   * @param alertDate The new alertDate value
   */
  public void setAlertDate(java.sql.Timestamp alertDate) {
    this.alertDate = alertDate;
  }

  /**
   * Sets the alertDate attribute of the Call object
   *
   * @param alertDate The new alertDate value
   */
  public void setAlertDate(String alertDate) {
    this.alertDate = DatabaseUtils.parseTimestamp(alertDate);
  }

  /**
   * Sets the Id attribute of the Call object
   *
   * @param tmp The new Id value
   */
  public void setId(String tmp) {
    try {
      this.id = Integer.parseInt(tmp);
    } catch (Exception e) {
    }
  }


  /**
   * Sets the entered attribute of the Call object
   *
   * @param tmp The new entered value
   */
  public void setEntered(java.sql.Timestamp tmp) {
    this.entered = tmp;
  }

  /**
   * Sets the modified attribute of the Call object
   *
   * @param tmp The new modified value
   */
  public void setModified(java.sql.Timestamp tmp) {
    this.modified = tmp;
  }


  /**
   * Sets the entered attribute of the Call object
   *
   * @param tmp The new entered value
   */
  public void setEntered(String tmp) {
    this.entered = DateUtils.parseTimestampString(tmp);
  }


  /**
   * Sets the modified attribute of the Call object
   *
   * @param tmp The new modified value
   */
  public void setModified(String tmp) {
    this.modified = DateUtils.parseTimestampString(tmp);
  }


  /**
   * Sets the OrgId attribute of the Call object
   *
   * @param tmp The new OrgId value
   */
  public void setOrgId(int tmp) {
    this.orgId = tmp;
  }


  /**
   * Sets the actionId attribute of the Call object
   *
   * @param actionId The new actionId value
   */
  public void setActionId(int actionId) {
    this.actionId = actionId;
  }


  /**
   * Sets the actionId attribute of the Call object
   *
   * @param actionId The new actionId value
   */
  public void setActionId(String actionId) {
    this.actionId = Integer.parseInt(actionId);
  }

  /**
   * Gets the followupContactId attribute of the Call object
   *
   * @return followupContactId The followupContactId value
   */
  public int getFollowupContactId() {
    return this.followupContactId;
  }


  /**
   * Sets the followupContactId attribute of the Call object
   *
   * @param followupContactId The new followupContactId value
   */
  public void setFollowupContactId(int followupContactId) {
    this.followupContactId = followupContactId;
  }

  /**
   * Sets the actionId attribute of the Call object
   *
   * @param followupContactId The new FollowupContactId value
   */
  public void setFollowupContactId(String followupContactId) {
      this.followupContactId = Integer.parseInt(followupContactId);
    }

  /**
   * Sets the parentId attribute of the Call object
   *
   * @param parentId The new parentId value
   */
  public void setParentId(int parentId) {
    this.parentId = parentId;
  }


  /**
   * Sets the parentId attribute of the Call object
   *
   * @param parentId The new parentId value
   */
  public void setParentId(String parentId) {
    this.parentId = Integer.parseInt(parentId);
  }


  /**
   * Sets the owner attribute of the Call object
   *
   * @param tmp The new owner value
   */
  public void setOwner(int tmp) {
    this.owner = tmp;
  }
  
  public void setCallOwner(String tmp) {
  	this.owner = Integer.parseInt(tmp);
  }

  /**
   * Sets the hasFollowup attribute of the Call object
   *
   * @param hasFollowup The new hasFollowup value
   */
  public void setHasFollowup(boolean hasFollowup) {
    this.hasFollowup = hasFollowup;
  }


  /**
   * Sets the hasFollowup attribute of the Call object
   *
   * @param hasFollowup The new hasFollowup value
   */
  public void setHasFollowup(String hasFollowup) {
    this.hasFollowup = DatabaseUtils.parseBoolean(hasFollowup);
  }


  /**
   * Gets the hasFollowup attribute of the Call object
   *
   * @return The hasFollowup value
   */
  public boolean getHasFollowup() {
    return hasFollowup;
  }


  /**
   * Sets the trashedDate attribute of the Call object
   *
   * @param tmp The new trashedDate value
   */
  public void setTrashedDate(java.sql.Timestamp tmp) {
    this.trashedDate = tmp;
  }


  /**
   * Sets the trashedDate attribute of the Call object
   *
   * @param tmp The new trashedDate value
   */
  public void setTrashedDate(String tmp) {
    this.trashedDate = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   * Gets the trashedDate attribute of the Call object
   *
   * @return The trashedDate value
   */
  public java.sql.Timestamp getTrashedDate() {
    return trashedDate;
  }


  /**
   * Sets the owner attribute of the Call object
   *
   * @param tmp The new owner value
   */
  public void setOwner(String tmp) {
    this.owner = Integer.parseInt(tmp);
  }


  /**
   * Sets the assignedBy attribute of the Call object
   *
   * @param assignedBy The new assignedBy value
   */
  public void setAssignedBy(int assignedBy) {
    this.assignedBy = assignedBy;
  }

  /**
   * Sets the assignedBy attribute of the Call object
   *
   * @param assignedBy The new assignedBy value
   */
  public void setAssignedBy(String assignedBy) {
    this.assignedBy = Integer.parseInt(assignedBy);
  }

  /**
   * Sets the completedBy attribute of the Call object
   *
   * @param completedBy The new completedBy value
   */
  public void setCompletedBy(int completedBy) {
    this.completedBy = completedBy;
  }


  /**
   * Sets the priorityId attribute of the Call object
   *
   * @param priorityId The new priorityId value
   */
  public void setPriorityId(int priorityId) {
    this.priorityId = priorityId;
  }


  /**
   * Sets the priorityId attribute of the Call object
   *
   * @param priorityId The new priorityId value
   */
  public void setPriorityId(String priorityId) {
    if (Integer.parseInt(priorityId) > 0) {
      this.priorityId = Integer.parseInt(priorityId);
    }
  }


  /**
   * Sets the statusId attribute of the Call object
   *
   * @param statusId The new statusId value
   */
  public void setStatusId(int statusId) {
    this.statusId = statusId;
  }


  /**
   * Sets the statusId attribute of the Call object
   *
   * @param statusId The new statusId value
   */
  public void setStatusId(String statusId) {
    this.statusId = Integer.parseInt(statusId);
  }


  /**
   * Sets the reminderTypeId attribute of the Call object
   *
   * @param reminderTypeId The new reminderTypeId value
   */
  public void setReminderTypeId(int reminderTypeId) {
    this.reminderTypeId = reminderTypeId;
  }


  /**
   * Sets the reminderTypeId attribute of the Call object
   *
   * @param reminderTypeId The new reminderTypeId value
   */
  public void setReminderTypeId(String reminderTypeId) {
    if (Integer.parseInt(reminderTypeId) > 0) {
      this.reminderTypeId = Integer.parseInt(reminderTypeId);
    }
  }


  /**
   * Sets the reminderId attribute of the Call object
   *
   * @param reminderId The new reminderId value
   */
  public void setReminderId(int reminderId) {
    this.reminderId = reminderId;
  }


  /**
   * Sets the reminderId attribute of the Call object
   *
   * @param reminderId The new reminderId value
   */
  public void setReminderId(String reminderId) {
    this.reminderId = Integer.parseInt(reminderId);
  }


  /**
   * Sets the assignDate attribute of the Call object
   *
   * @param assignDate The new assignDate value
   */
  public void setAssignDate(java.sql.Timestamp assignDate) {
    this.assignDate = assignDate;
  }


  /**
   * Sets the completeDate attribute of the Call object
   *
   * @param completeDate The new completeDate value
   */
  public void setCompleteDate(java.sql.Timestamp completeDate) {
    this.completeDate = completeDate;
  }


  /**
   * Sets the alertCallType attribute of the Call object
   *
   * @param alertCallType The new alertCallType value
   */
  public void setAlertCallType(String alertCallType) {
    this.alertCallType = alertCallType;
  }


  /**
   * Sets the followupNotes attribute of the Call object
   *
   * @param followupNotes The new followupNotes value
   */
  public void setFollowupNotes(String followupNotes) {
    this.followupNotes = followupNotes;
  }


  /**
   * Sets the priorityString attribute of the Call object
   *
   * @param priorityString The new priorityString value
   */
  public void setPriorityString(String priorityString) {
    this.priorityString = priorityString;
  }


  /**
   * Sets the checkAlertDate attribute of the Call object
   *
   * @param tmp The new checkAlertDate value
   */
  public void setCheckAlertDate(boolean tmp) {
    this.checkAlertDate = tmp;
  }


  /**
   * Sets the checkAlertDate attribute of the Call object
   *
   * @param tmp The new checkAlertDate value
   */
  public void setCheckAlertDate(String tmp) {
    this.checkAlertDate = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   * Sets the contactOrgId attribute of the Call object
   *
   * @param contactOrgId The new contactOrgId value
   */
  public void setContactOrgId(int contactOrgId) {
    this.contactOrgId = contactOrgId;
  }


  /**
   * Sets the orgName attribute of the Call object
   *
   * @param orgName The new orgName value
   */
  public void setOrgName(String orgName) {
    this.orgName = orgName;
  }


  /**
   * Sets the contact attribute of the Call object
   *
   * @param contact The new contact value
   */
  public void setContact(Contact contact) {
    this.contact = contact;
  }


  /**
   * Sets the alertDateTimeZone attribute of the Call object
   *
   * @param tmp The new alertDateTimeZone value
   */
  public void setAlertDateTimeZone(String tmp) {
    this.alertDateTimeZone = tmp;
  }


  /**
   * Gets the alertDateTimeZone attribute of the Call object
   *
   * @return The alertDateTimeZone value
   */
  public String getAlertDateTimeZone() {
    return alertDateTimeZone;
  }

  /**
   * Gets the contact attribute of the Call object
   *
   * @return The contact value
   */
  public Contact getContact() {
    return contact;
  }


  /**
   * Gets the EnteredName attribute of the Call object
   *
   * @return The EnteredName value
   */
  public String getEnteredName() {
    return enteredName;
  }


  /**
   * Gets the ModifiedName attribute of the Call object
   *
   * @return The ModifiedName value
   */
  public String getModifiedName() {
    return modifiedName;
  }


  /**
   * Gets the orgName attribute of the Call object
   *
   * @return The orgName value
   */
  public String getOrgName() {
    return orgName;
  }


  /**
   * Gets the contactOrgId attribute of the Call object
   *
   * @return The contactOrgId value
   */
  public int getContactOrgId() {
    return contactOrgId;
  }


  /**
   * Gets the priorityString attribute of the Call object
   *
   * @return The priorityString value
   */
  public String getPriorityString() {
    return priorityString;
  }


  /**
   * Gets the followupNotes attribute of the Call object
   *
   * @return The followupNotes value
   */
  public String getFollowupNotes() {
    return followupNotes;
  }


  /**
   * Gets the alertCallType attribute of the Call object
   *
   * @return The alertCallType value
   */
  public String getAlertCallType() {
    return alertCallType;
  }


  /**
   * Gets the parentId attribute of the Call object
   *
   * @return The parentId value
   */
  public int getParentId() {
    return parentId;
  }


  /**
   * Gets the parentId attribute of the Call object
   *
   * @return The priority value
   */
  public int getPriorityId() {
    return priorityId;
  }


  /**
   * Gets the owner attribute of the Call object
   *
   * @return The owner value
   */
  public int getOwner() {
    return owner;
  }


  /**
   * Gets the assignedBy attribute of the Call object
   *
   * @return The assignedBy value
   */
  public int getAssignedBy() {
    return assignedBy;
  }


  /**
   * Gets the completedBy attribute of the Call object
   *
   * @return The completedBy value
   */
  public int getCompletedBy() {
    return completedBy;
  }


  /**
   * Gets the statusId attribute of the Call object
   *
   * @return The statusId value
   */
  public int getStatusId() {
    return statusId;
  }


  /**
   * Gets the statusString attribute of the Call object
   *
   * @return The statusString value
   */
  public String getStatusString() {
    String tmp = "";
    if (statusId == Call.COMPLETE || statusId == Call.COMPLETE_FOLLOWUP_PENDING) {
      tmp = "Complete";
    } else if (statusId == Call.CANCELED) {
      tmp = "Canceled";
    }
    return tmp;
  }


  /**
   * Gets the reminderTypeId attribute of the Call object
   *
   * @return The reminderTypeId value
   */
  public int getReminderTypeId() {
    return reminderTypeId;
  }


  /**
   * Gets the reminderId attribute of the Call object
   *
   * @return The reminderId value
   */
  public int getReminderId() {
    return reminderId;
  }


  /**
   * Gets the alertCallTypeId attribute of the Call object
   *
   * @return The alertCallTypeId value
   */
  public int getAlertCallTypeId() {
    return alertCallTypeId;
  }


  /**
   * Gets the assignDate attribute of the Call object
   *
   * @return The assignDate value
   */
  public java.sql.Timestamp getAssignDate() {
    return assignDate;
  }


  /**
   * Gets the completeDate attribute of the Call object
   *
   * @return The completeDate value
   */
  public java.sql.Timestamp getCompleteDate() {
    return completeDate;
  }


  /**
   * Gets the actionId attribute of the Call object
   *
   * @return The actionId value
   */
  public int getActionId() {
    return actionId;
  }


  /**
   * Gets the alertText attribute of the Call object
   *
   * @return The alertText value
   */
  public String getAlertText() {
    return alertText;
  }


  /**
   * Sets the alertText attribute of the Call object
   *
   * @param alertText The new alertText value
   */
  public void setAlertText(String alertText) {
    this.alertText = alertText;
  }


  /**
   * Sets the OrgId attribute of the Call object
   *
   * @param tmp The new OrgId value
   */
  public void setOrgId(String tmp) {
    try {
      this.orgId = Integer.parseInt(tmp);
    } catch (Exception e) {
    }
  }


  /**
   * Sets the ContactId attribute of the Call object
   *
   * @param tmp The new ContactId value
   */
  public void setContactId(int tmp) {
    this.contactId = tmp;
  }


  /**
   * Sets the ContactId attribute of the Call object
   *
   * @param tmp The new ContactId value
   */
  public void setContactId(String tmp) {
    try {
      this.contactId = Integer.parseInt(tmp);
    } catch (Exception e) {
    }
  }


  /**
   * Sets the CallTypeId attribute of the Call object
   *
   * @param tmp The new CallTypeId value
   */
  public void setCallTypeId(int tmp) {
    this.callTypeId = tmp;
  }


  /**
   * Sets the CallTypeId attribute of the Call object
   *
   * @param tmp The new CallTypeId value
   */
  public void setCallTypeId(String tmp) {
    try {
      this.callTypeId = Integer.parseInt(tmp);
    } catch (Exception e) {
    }
  }


  /**
   * Sets the Length attribute of the Call object
   *
   * @param tmp The new Length value
   */
  public void setLength(int tmp) {
    this.length = tmp;
  }


  /**
   * Sets the Length attribute of the Call object
   *
   * @param tmp The new Length value
   */
  public void setLength(String tmp) {
    try {
      this.length = Integer.parseInt(tmp);
    } catch (Exception e) {
    }
  }


  /**
   * Sets the Subject attribute of the Call object
   *
   * @param tmp The new Subject value
   */
  public void setSubject(String tmp) {
    this.subject = tmp;
  }


  /**
   * Sets the Notes attribute of the Call object
   *
   * @param tmp The new Notes value
   */
  public void setNotes(String tmp) {
    this.notes = tmp;
  }


  /**
   * Sets the EnteredBy attribute of the Call object
   *
   * @param tmp The new EnteredBy value
   */
  public void setEnteredBy(int tmp) {
    this.enteredBy = tmp;
  }


  /**
   * Sets the enteredBy attribute of the Call object
   *
   * @param tmp The new enteredBy value
   */
  public void setEnteredBy(String tmp) {
    this.enteredBy = Integer.parseInt(tmp);
  }


  /**
   * Sets the ModifiedBy attribute of the Call object
   *
   * @param tmp The new ModifiedBy value
   */
  public void setModifiedBy(int tmp) {
    this.modifiedBy = tmp;
  }


  /**
   * Sets the modifiedBy attribute of the Call object
   *
   * @param tmp The new modifiedBy value
   */
  public void setModifiedBy(String tmp) {
    this.modifiedBy = Integer.parseInt(tmp);
  }


  /**
   * Gets the checkAlertDate attribute of the Call object
   *
   * @return The checkAlertDate value
   */
  public boolean getCheckAlertDate() {
    return checkAlertDate;
  }


  /**
   * Gets the oppHeaderId attribute of the Call object
   *
   * @return The oppHeaderId value
   */
  public int getOppHeaderId() {
    return oppHeaderId;
  }


  /**
   * Gets the contactName attribute of the Call object
   *
   * @return The contactName value
   */
  public String getContactName() {
    return contactName;
  }


  /**
   * Gets the alertDate attribute of the Call object
   *
   * @return The alertDate value
   */
  public java.sql.Timestamp getAlertDate() {
    return alertDate;
  }

  /**
   * Gets the entered attribute of the Call object
   *
   * @return The entered value
   */
  public java.sql.Timestamp getEntered() {
    return entered;
  }


  /**
   * Gets the modified attribute of the Call object
   *
   * @return The modified value
   */
  public java.sql.Timestamp getModified() {
    return modified;
  }


  /**
   * Gets the modifiedString attribute of the Call object
   *
   * @return The modifiedString value
   */
  public String getModifiedString() {
    String tmp = "";
    try {
      return DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.LONG).format(
          modified);
    } catch (NullPointerException e) {
    }
    return tmp;
  }


  /**
   * Gets the enteredString attribute of the Call object
   *
   * @return The enteredString value
   */
  public String getEnteredString() {
    String tmp = "";
    try {
      return DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.LONG).format(
          entered);
    } catch (NullPointerException e) {
    }
    return tmp;
  }


  /**
   * Gets the Id attribute of the Call object
   *
   * @return The Id value
   */
  public int getId() {
    return id;
  }


  /**
   * Gets the idString attribute of the Call object
   *
   * @return The idString value
   */
  public String getIdString() {
    return String.valueOf(id);
  }


  /**
   * Gets the OrgId attribute of the Call object
   *
   * @return The OrgId value
   */
  public int getOrgId() {
    return orgId;
  }


  /**
   * Gets the ContactId attribute of the Call object
   *
   * @return The ContactId value
   */
  public int getContactId() {
    return contactId;
  }


  /**
   * Gets the CallTypeId attribute of the Call object
   *
   * @return The CallTypeId value
   */
  public int getCallTypeId() {
    return callTypeId;
  }


  /**
   * Gets the CallType attribute of the Call object
   *
   * @return The CallType value
   */
  public String getCallType() {
    return callType;
  }


  /**
   * Sets the callType attribute of the Call object
   *
   * @param tmp The new callType value
   */
  public void setCallType(String tmp) {
    this.callType = tmp;
  }


  /**
   * Gets the Length attribute of the Call object
   *
   * @return The Length value
   */
  public int getLength() {
    return length;
  }


  /**
   * Gets the LengthString attribute of the Call object
   *
   * @return The LengthString value
   */
  public String getLengthString() {
    return (String.valueOf(length));
  }


  /**
   * Gets the LengthText attribute of the Call object
   *
   * @return The LengthText value
   */
  public String getLengthText() {
    if (length > 0) {
      return (length + " min.");
    } else {
      return "";
    }
  }

  /**
   * Description of the Method
   *
   * @return Description of the Return Value
   */
  public boolean hasLength() {
    return (length > 0);
  }
  
  /**
   * Description of the Method
   *
   * @return Description of the Return Value
   */
  public boolean hasFollowupLength() {
    return (followupLength > 0);
  }


  /**
   * Gets the Subject attribute of the Call object
   *
   * @return The Subject value
   */
  public String getSubject() {
    return subject;
  }


  /**
   * Gets the Notes attribute of the Call object
   *
   * @return The Notes value
   */
  public String getNotes() {
    return notes;
  }


  /**
   * Gets the EnteredBy attribute of the Call object
   *
   * @return The EnteredBy value
   */
  public int getEnteredBy() {
    return enteredBy;
  }


  /**
   * Gets the ModifiedBy attribute of the Call object
   *
   * @return The ModifiedBy value
   */
  public int getModifiedBy() {
    return modifiedBy;
  }


  /**
   * Sets the resultId attribute of the Call object
   *
   * @param tmp The new resultId value
   */
  public void setResultId(int tmp) {
    this.resultId = tmp;
  }


  /**
   * Sets the resultId attribute of the Call object
   *
   * @param tmp The new resultId value
   */
  public void setResultId(String tmp) {
    this.resultId = Integer.parseInt(tmp);
  }


  /**
   * Gets the resultId attribute of the Call object
   *
   * @return The resultId value
   */
  public int getResultId() {
    return resultId;
  }


  /**
   * Sets the alertCallTypeId attribute of the Call object
   *
   * @param tmp The new alertCallTypeId value
   */
  public void setAlertCallTypeId(int tmp) {
    this.alertCallTypeId = tmp;
  }


  /**
   * Gets the trashed attribute of the Call object
   *
   * @return The trashed value
   */
  public boolean isTrashed() {
    return (trashedDate != null);
  }


  /**
   * Sets the alertCallTypeId attribute of the Call object
   *
   * @param tmp The new alertCallTypeId value
   */
  public void setAlertCallTypeId(String tmp) {
    if (Integer.parseInt(tmp) > 0) {
      this.alertCallTypeId = Integer.parseInt(tmp);
    }
  }


  /**
   * Sets the updateOrganization attribute of the Call object
   *
   * @param tmp The new updateOrganization value
   */
  public void setUpdateOrganization(boolean tmp) {
    this.updateOrganization = tmp;
  }


  /**
   * Sets the updateOrganization attribute of the Call object
   *
   * @param tmp The new updateOrganization value
   */
  public void setUpdateOrganization(String tmp) {
    this.updateOrganization = DatabaseUtils.parseBoolean(tmp);
  }

  /**
   * Gets the updateOrganization attribute of the Call object
   *
   * @return The updateOrganization value
   */
  public boolean getUpdateOrganization() {
    return updateOrganization;
  }

  /**
   * @return the followupEndDate
   */
  public java.sql.Timestamp getFollowupEndDate() {
    return followupEndDate;
  }

  /**
   * @param followupEndDate the followupEndDate to set
   */
  public void setFollowupEndDate(java.sql.Timestamp followupEndDate) {
    this.followupEndDate = followupEndDate;
  }

  /**
   * @param followupEndDate the followupEndDate to set
   */
  public void setFollowupEndDate(String followupEndDate) {
    this.followupEndDate = DatabaseUtils.parseTimestamp(followupEndDate);
  }

  /**
   * @return the followupEndDateTimeZone
   */
  public String getFollowupEndDateTimeZone() {
    return followupEndDateTimeZone;
  }

  /**
   * @param followupEndDateTimeZone the followupEndDateTimeZone to set
   */
  public void setFollowupEndDateTimeZone(String followupEndDateTimeZone) {
    this.followupEndDateTimeZone = followupEndDateTimeZone;
  }

  /**
   * @return the callStartDateTimeZone
   */
  public String getCallStartDateTimeZone() {
    return callStartDateTimeZone;
  }

  /**
   * @param callStartDateTimeZone the callDateTimeZone to set
   */
  public void setCallStartDateTimeZone(String callStartDateTimeZone) {
    this.callStartDateTimeZone = callStartDateTimeZone;
  }


  /**
   * @return the callEndDate
   */
  public java.sql.Timestamp getCallEndDate() {
    return callEndDate;
  }

  /**
   * @param callEndDate the callEndDate to set
   */
  public void setCallEndDate(java.sql.Timestamp callEndDate) {
    this.callEndDate = callEndDate;
  }

  /**
   * @param callEndDate the callEndDate to set
   */
  public void setCallEndDate(String callEndDate) {
    this.callEndDate = DatabaseUtils.parseTimestamp(callEndDate);
  }

  /**
   * @return the callEndDateTimeZone
   */
  public String getCallEndDateTimeZone() {
    return callEndDateTimeZone;
  }


  /**
   * @param callEndDateTimeZone the callEndDateTimeZone to set
   */
  public void setCallEndDateTimeZone(String callEndDateTimeZone) {
    this.callEndDateTimeZone = callEndDateTimeZone;
  }


  /**
   * @return the callLengthDuration
   */
  public int getCallLengthDuration() {
    return callLengthDuration;
  }


  /**
   * @param callLengthDuration the callLengthDuration to set
   */
  public void setCallLengthDuration(int callLengthDuration) {
    this.callLengthDuration = callLengthDuration;
  }

  /**
   * @param callLengthDuration the callLengthDuration to set
   */
  public void setCallLengthDuration(String callLengthDuration) {
    if (Integer.parseInt(callLengthDuration) > 0) {
      this.callLengthDuration = Integer.parseInt(callLengthDuration);
    }
  }

  /**
   * @return the callLocation
   */
  public String getCallLocation() {
    return callLocation;
  }


  /**
   * @param callLocation the callLocation to set
   */
  public void setCallLocation(String callLocation) {
    this.callLocation = callLocation;
  }


  /**
   * @return the callStartDate
   */
  public java.sql.Timestamp getCallStartDate() {
    return callStartDate;
  }

  /**
   * @param callStartDate the callStartDate to set
   */
  public void setCallStartDate(java.sql.Timestamp callStartDate) {
    this.callStartDate = callStartDate;
  }

  /**
   * @param callStartDate the callStartDate to set
   */
  public void setCallStartDate(String callStartDate) {
    this.callStartDate = DatabaseUtils.parseTimestamp(callStartDate);
  }

  /**
   * @return the followupLength
   */
  public int getFollowupLength() {
    return followupLength;
  }

  /**
   * Description of the Method
   *
   * @return Description of the Returned Value
   */
  public String getFollowupLengthString() {
    return String.valueOf(followupLength);
  }

  /**
   * @param followupLength the followupLength to set
   */
  public void setFollowupLength(int followupLength) {
    this.followupLength = followupLength;
  }

  /**
   * @param followupLength the followupLength to set
   */
  public void setFollowupLength(String followupLength) {
    try {
      this.followupLength = Integer.parseInt(followupLength);
    } catch (Exception e) {}
  }

  /**
   * @return the followupLengthDuration
   */
  public int getFollowupLengthDuration() {
    return followupLengthDuration;
  }


  /**
   * @param followupLengthDuration the followupLengthDuration to set
   */
  public void setFollowupLengthDuration(int followupLengthDuration) {
    this.followupLengthDuration = followupLengthDuration;
  }

  /**
   * @param followupLengthDuration the followupLengthDuration to set
   */
  public void setFollowupLengthDuration(String followupLengthDuration) {
    if (Integer.parseInt(followupLengthDuration) > 0) {
      this.followupLengthDuration = Integer.parseInt(followupLengthDuration);
    }
  }

  /**
   * @return the followupLocation
   */
  public String getFollowupLocation() {
    return followupLocation;
  }


  /**
   * @param followupLocation the followupLocation to set
   */
  public void setFollowupLocation(String followupLocation) {
    this.followupLocation = followupLocation;
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public int lookupReminderSeconds(Connection db) throws SQLException {
    if (this.getReminderTypeId() == -1) {
      throw new SQLException("ID was not specified");
    }

    int scds = 0;
    PreparedStatement pst = db.prepareStatement(
        "SELECT base_value FROM lookup_call_reminder " +
            "WHERE code = ? ");
    pst.setInt(1, reminderTypeId);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      scds = rs.getInt("base_value");
    }
    rs.close();
    pst.close();
    return scds;
  }


  /**
   * Description of the Method
   *
   * @param db      Description of Parameter
   * @param context Description of Parameter
   * @return Description of the Returned Value
   * @throws SQLException Description of Exception
   */
  public boolean insert(Connection db, ActionContext context) throws SQLException {
    return (insert(db));
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public boolean insert(Connection db) throws SQLException {
    boolean commit = db.getAutoCommit();
    try {
      if (commit) {
        db.setAutoCommit(false);
      }
      Contact thisContact = new Contact();
      if (this.getContactId() > 0) {
        thisContact.setBuildDetails(false);
        thisContact.setBuildTypes(false);
        thisContact.setId(this.getContactId());
        thisContact.build(db);
      }
      StringBuffer sql = new StringBuffer();
      id = DatabaseUtils.getNextSeq(db, "call_log_call_id_seq");
      sql.append(
          "INSERT INTO call_log " +
              "(org_id, contact_id, opp_id, call_type_id, " + DatabaseUtils.addQuotes(db, "length") + ", subject, notes, " +
              "alertdate, alert, alert_call_type_id, result_id, parent_id, owner, followup_notes, status_id, " +
              "reminder_value, reminder_type_id, priority_id, alertdate_timezone, followup_contact_id, ");
      sql.append(
              "followup_end_date, followup_end_date_timezone, " +
              "followup_location, " +
              "followup_length, followup_length_duration, " +
              "call_start_date, call_start_date_timezone, call_end_date, call_end_date_timezone, " +
              "call_location, " +
              "call_length_duration," +
              "email_participants, email_followup_participants, ");
      if (id > -1) {
        sql.append("call_id, ");
      }
      sql.append("entered, modified, ");
      sql.append("enteredBy, modifiedBy ) ");
      sql.append(
          "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ");
      sql.append(
          "?, ?, " +
          "?, " +
          "?, ?, " +
          "?, ?, ?, ?, " +
          "?, " +
          "?, " +
          "?, ?,"
          );
      if (id > -1) {
        sql.append("?, ");
      }
      if (entered != null) {
        sql.append("?, ");
      } else {
        sql.append(DatabaseUtils.getCurrentTimestamp(db) + ", ");
      }
      if (modified != null) {
        sql.append("?, ");
      } else {
        sql.append(DatabaseUtils.getCurrentTimestamp(db) + ", ");
      }
      sql.append("?, ?) ");
      int i = 0;
      PreparedStatement pst = db.prepareStatement(sql.toString());
      if (thisContact.getOrgId() > 0) {
        pst.setInt(++i, thisContact.getOrgId());
      } else if (this.getOrgId() > 0) {
        pst.setInt(++i, this.getOrgId());
      } else {
        pst.setNull(++i, java.sql.Types.INTEGER);
      }

      if (this.getContactId() > 0) {
        pst.setInt(++i, this.getContactId());
      } else {
        pst.setNull(++i, java.sql.Types.INTEGER);
      }
      if (this.getOppHeaderId() > 0) {
        pst.setInt(++i, this.getOppHeaderId());
      } else {
        pst.setNull(++i, java.sql.Types.INTEGER);
      }
      if (this.getCallTypeId() > 0) {
        pst.setInt(++i, this.getCallTypeId());
      } else {
        pst.setNull(++i, java.sql.Types.INTEGER);
      }
      pst.setInt(++i, this.getLength());
      pst.setString(++i, this.getSubject());
      pst.setString(++i, this.getNotes());
      DatabaseUtils.setTimestamp(pst, ++i, alertDate);
      pst.setString(++i, this.getAlertText());
      DatabaseUtils.setInt(pst, ++i, alertCallTypeId);
      DatabaseUtils.setInt(pst, ++i, resultId);
      DatabaseUtils.setInt(pst, ++i, parentId);
      DatabaseUtils.setInt(pst, ++i, owner);
      pst.setString(++i, this.getFollowupNotes());
      pst.setInt(++i, statusId);
      DatabaseUtils.setInt(pst, ++i, reminder ? reminderId : -1);
      DatabaseUtils.setInt(pst, ++i, reminder ? reminderTypeId : -1);
      DatabaseUtils.setInt(pst, ++i, priorityId);
      pst.setString(++i, alertDateTimeZone);
      if (this.getFollowupContactId() > 0) {
        pst.setInt(++i, this.getFollowupContactId());
      } else {
        pst.setNull(++i, java.sql.Types.INTEGER);
      }
      
      DatabaseUtils.setTimestamp(pst, ++i, this.getFollowupEndDate());
      pst.setString(++i, this.getFollowupEndDateTimeZone());
      pst.setString(++i, this.getFollowupLocation());
      DatabaseUtils.setInt(pst, ++i, this.getFollowupLength());
      DatabaseUtils.setInt(pst, ++i, this.getFollowupLengthDuration());
      DatabaseUtils.setTimestamp(pst, ++i, this.getCallStartDate());
      pst.setString(++i, this.getCallStartDateTimeZone());
      DatabaseUtils.setTimestamp(pst, ++i, this.getCallEndDate());
      pst.setString(++i, this.getCallEndDateTimeZone());
      pst.setString(++i, this.getCallLocation());
      DatabaseUtils.setInt(pst, ++i, this.getCallLengthDuration());
      pst.setBoolean(++i, this.getEmailParticipants());
      pst.setBoolean(++i, this.getEmailFollowupParticipants());

      if (id > -1) {
        pst.setInt(++i, id);
      }
      if (entered != null) {
        pst.setTimestamp(++i, entered);
      }
      if (modified != null) {
        pst.setTimestamp(++i, modified);
      }
      pst.setInt(++i, this.getEnteredBy());
      pst.setInt(++i, this.getModifiedBy());
      pst.execute();
      pst.close();
      id = DatabaseUtils.getCurrVal(db, "call_log_call_id_seq", id);

      if (!offline && !restore) {
        //mark complete/canceled based on statusId
        if (this.getStatusId() == COMPLETE || this.getStatusId() == COMPLETE_FOLLOWUP_PENDING) {
          markComplete(db, this.getEnteredBy());
        } else if (this.getStatusId() == CANCELED) {
          markCanceled(db, this.getEnteredBy());
        }
        if (actionId > 0) {
          updateLog(db);
        }
      }
      if (commit) {
        db.commit();
      }
    } catch (SQLException e) {
      if (commit) {
        db.rollback();
      }
      throw new SQLException(e.getMessage());
    } finally {
      if (commit) {
        db.setAutoCommit(true);
      }
    }
    return true;
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void updateLog(Connection db) throws SQLException {
    boolean commit = true;
    try {
      commit = db.getAutoCommit();
      if (commit) {
        db.setAutoCommit(false);
      }
      ActionItemLog thisLog = new ActionItemLog();
      thisLog.setEnteredBy(this.getEnteredBy());
      thisLog.setModifiedBy(this.getModifiedBy());
      thisLog.setItemId(this.getActionId());
      thisLog.setLinkItemId(this.getId());
      thisLog.setType(Constants.CALL_OBJECT);
      thisLog.insert(db);
      if (commit) {
        db.commit();
      }
    } catch (SQLException e) {
      if (commit) {
        db.rollback();
      }
      throw new SQLException(e.getMessage());
    } finally {
      if (commit) {
        db.setAutoCommit(true);
      }
    }
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public DependencyList processDependencies(Connection db) throws SQLException {
    DependencyList dependencyList = new DependencyList();
    ActionList actionList = ActionItemLogList.isItemLinked(
        db, this.getId(), Constants.CALL_OBJECT);
    if (actionList != null) {
      Dependency thisDependency = new Dependency();
      thisDependency.setName(actionList.getDescription());
      thisDependency.setCount(1);
      thisDependency.setCanDelete(true);
      dependencyList.add(thisDependency);
    }
    Dependency thisDependency = new Dependency();
    thisDependency.setName("contact.history");
    if (this.getStatusId() == Call.COMPLETE || this.getStatusId() == Call.COMPLETE_FOLLOWUP_PENDING) {
      thisDependency.setCount(
          ContactHistory.retrieveRecordCount(
              db, OrganizationHistory.COMPLETE_ACTIVITY, this.getId()));
    } else {
      thisDependency.setCount(
          ContactHistory.retrieveRecordCount(
              db, OrganizationHistory.CANCELED_ACTIVITY, this.getId()));
    }
    thisDependency.setCanDelete(true);
    if (thisDependency.getCount() > 0) {
      dependencyList.add(thisDependency);
    }
    return dependencyList;
  }


  /**
   * Description of the Method
   *
   * @param db Description of Parameter
   * @return Description of the Returned Value
   * @throws SQLException Description of Exception
   */
  public boolean delete(Connection db) throws SQLException {
    if (this.getId() == -1) {
      throw new SQLException("ID was not specified");
    }

    int recordCount = 0;
    ActionItemLog.deleteLink(db, this.getId(), Constants.CALL_OBJECT);
    if (this.getStatusId() == Call.COMPLETE || this.getStatusId() == Call.COMPLETE_FOLLOWUP_PENDING) {
      ContactHistory.deleteObject(
          db, OrganizationHistory.COMPLETE_ACTIVITY, this.getId());
    } else {
      ContactHistory.deleteObject(
          db, OrganizationHistory.CANCELED_ACTIVITY, this.getId());
    }
    PreparedStatement pst = db.prepareStatement(
        "DELETE FROM call_log " +
            "WHERE call_id = ? ");
    pst.setInt(1, id);
    recordCount = pst.executeUpdate();
    pst.close();
    if (recordCount == 0) {
      return false;
    }
    return true;
  }


  /**
   * Description of the Method
   *
   * @param db      Description of Parameter
   * @param context Description of Parameter
   * @return Description of the Returned Value
   * @throws SQLException Description of Exception
   */
  public int update(Connection db) throws SQLException {
    if (this.getId() == -1) {
      throw new SQLException("Call ID was not specified");
    }
    int resultCount = 0;
    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();
    sql.append(
        "UPDATE call_log " +
            "SET " + (updateOrganization ? " org_id = ?," : "") + " call_type_id = ?, " + DatabaseUtils.addQuotes(db, "length") + " = ?, subject = ?, notes = ?, " +
            "modifiedby = ?, alertdate = ?, alert = ?, alert_call_type_id = ?, " +
            "followup_notes = ?, status_id = ?, result_id = ?, owner = ?, " +
            "reminder_value = ?, reminder_type_id = ?, priority_id = ?, " +
            "alertdate_timezone = ?, trashed_date = ?, opp_id = ?, followup_contact_id=?, contact_id=?, " +
            "followup_end_date = ?, followup_end_date_timezone = ?, " +
            "followup_location = ?, " +
            "followup_length = ?, followup_length_duration = ?, " +
            "call_start_date = ?, call_start_date_timezone = ?, call_end_date = ?, call_end_date_timezone = ?, " +
            "call_location = ?, " +
            "call_length_duration = ?, " +
            "email_participants = ?, " +
            "email_followup_participants = ?, " +
            "modified = " + DatabaseUtils.getCurrentTimestamp(db) + " " +
            "WHERE call_id = ? " +
            "AND modified " + ((this.getModified() == null) ? "IS NULL " : "= ? "));
    int i = 0;
    pst = db.prepareStatement(sql.toString());
    if (updateOrganization) {
      DatabaseUtils.setInt(pst, ++i, this.getOrgId());
    }
    if (this.getCallTypeId() > 0) {
      pst.setInt(++i, this.getCallTypeId());
    } else {
      pst.setNull(++i, java.sql.Types.INTEGER);
    }
    pst.setInt(++i, length);
    pst.setString(++i, subject);
    pst.setString(++i, notes);
    pst.setInt(++i, this.getModifiedBy());
    DatabaseUtils.setTimestamp(pst, ++i, alertDate);
    pst.setString(++i, this.getAlertText());
    DatabaseUtils.setInt(pst, ++i, alertCallTypeId);
    pst.setString(++i, this.getFollowupNotes());
    pst.setInt(++i, statusId);
    DatabaseUtils.setInt(pst, ++i, resultId);
    if (this.getOwner() > 0) {
      pst.setInt(++i, this.getOwner());
    } else {
      pst.setNull(++i, java.sql.Types.INTEGER);
    }
    DatabaseUtils.setInt(pst, ++i, reminder ? reminderId : -1);
    DatabaseUtils.setInt(pst, ++i, reminder ? reminderTypeId : -1);
    DatabaseUtils.setInt(pst, ++i, priorityId);
    pst.setString(++i, alertDateTimeZone);
    DatabaseUtils.setTimestamp(pst, ++i, trashedDate);
    DatabaseUtils.setInt(pst, ++i, this.getOppHeaderId());
    DatabaseUtils.setInt(pst, ++i, this.getFollowupContactId());
    DatabaseUtils.setInt(pst, ++i, this.getContactId());

    DatabaseUtils.setTimestamp(pst, ++i, this.getFollowupEndDate());
    pst.setString(++i, this.getFollowupEndDateTimeZone());
    pst.setString(++i, this.getFollowupLocation());
    DatabaseUtils.setInt(pst, ++i, this.getFollowupLength());
    DatabaseUtils.setInt(pst, ++i, this.getFollowupLengthDuration());
    DatabaseUtils.setTimestamp(pst, ++i, this.getCallStartDate());
    pst.setString(++i, this.getCallStartDateTimeZone());
    DatabaseUtils.setTimestamp(pst, ++i, this.getCallEndDate());
    pst.setString(++i, this.getCallEndDateTimeZone());
    pst.setString(++i, this.getCallLocation());
    DatabaseUtils.setInt(pst, ++i, this.getCallLengthDuration());
    pst.setBoolean(++i, this.getEmailParticipants());
    pst.setBoolean(++i, this.getEmailFollowupParticipants());
    
    pst.setInt(++i, this.getId());
    if (this.getModified() != null) {
      pst.setTimestamp(++i, this.getModified());
    }
    resultCount = pst.executeUpdate();
    pst.close();
    return resultCount;
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
    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();
    boolean commit = true;
    try {
      commit = db.getAutoCommit();
      if (commit) {
        db.setAutoCommit(false);
      }
      sql.append(
          "UPDATE call_log " +
              "SET trashed_date = ? , " +
              "modified = " + DatabaseUtils.getCurrentTimestamp(db) + " , " +
              "modifiedby = ? " +
              "WHERE call_id = ? ");
      int i = 0;
      pst = db.prepareStatement(sql.toString());
      if (toTrash) {
        DatabaseUtils.setTimestamp(
            pst, ++i, new Timestamp(System.currentTimeMillis()));
      } else {
        DatabaseUtils.setTimestamp(pst, ++i, (Timestamp) null);
      }
      DatabaseUtils.setInt(pst, ++i, tmpUserId);
      pst.setInt(++i, this.id);
      pst.executeUpdate();
      pst.close();
      // Disable the contact history for the call
      if (this.getStatusString().equals("Complete")) {
        ContactHistory.trash(
            db, OrganizationHistory.COMPLETE_ACTIVITY, this.getId(), !toTrash);
      } else {
        ContactHistory.trash(
            db, OrganizationHistory.CANCELED_ACTIVITY, this.getId(), !toTrash);
      }

      if (commit) {
        db.commit();
      }
    } catch (SQLException e) {
      if (commit) {
        db.rollback();
      }
      throw new SQLException(e.getMessage());
    } finally {
      if (commit) {
        db.setAutoCommit(true);
      }
    }
    return true;
  }


  /**
   * Updates the current record and marks it complete in the database
   *
   * @param db     Description of the Parameter
   * @param userId Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public int markComplete(Connection db, int userId) throws SQLException {
    if (this.getId() == -1) {
      throw new SQLException("Call ID was not specified");
    }
    int resultCount = 0;
    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();
    sql.append(
        "UPDATE call_log " +
            "SET completedby = ?, complete_date = " + DatabaseUtils.getCurrentTimestamp(
            db) + ", status_id = ?, " +
            "modified = " + DatabaseUtils.getCurrentTimestamp(db) + " " +
            "WHERE call_id = ? ");
    int i = 0;
    pst = db.prepareStatement(sql.toString());
    pst.setInt(++i, userId);
    if (this.getStatusId() == COMPLETE_FOLLOWUP_PENDING) {
      pst.setInt(++i, COMPLETE_FOLLOWUP_PENDING);
    } else {
      pst.setInt(++i, COMPLETE);
    }
    pst.setInt(++i, this.getId());
    resultCount = pst.executeUpdate();
    pst.close();
    return resultCount;
  }


  /**
   * Description of the Method
   *
   * @param db     Description of the Parameter
   * @param userId Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public int markCanceled(Connection db, int userId) throws SQLException {
    if (this.getId() == -1) {
      throw new SQLException("Call ID was not specified");
    }
    int resultCount = 0;
    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();
    sql.append(
        "UPDATE call_log " +
            "SET completedby = ?, complete_date = " + DatabaseUtils.getCurrentTimestamp(db) + ", status_id = ?, " +
            "modified = " + DatabaseUtils.getCurrentTimestamp(db) + " " +
            "WHERE call_id = ? ");
    int i = 0;
    pst = db.prepareStatement(sql.toString());
    pst.setInt(++i, userId);
    pst.setInt(++i, CANCELED);
    pst.setInt(++i, this.getId());
    resultCount = pst.executeUpdate();
    pst.close();
    return resultCount;
  }


  /**
   * Description of the Method
   *
   * @param rs Description of Parameter
   * @throws SQLException Description of Exception
   */
  protected void buildRecord(ResultSet rs) throws SQLException {
    //call_log table
    id = rs.getInt("call_id");
    orgId = DatabaseUtils.getInt(rs, "org_id");
    contactId = DatabaseUtils.getInt(rs, "contact_id");
    oppHeaderId = DatabaseUtils.getInt(rs, "opp_id");
    callTypeId = DatabaseUtils.getInt(rs, "call_type_id");
    length = rs.getInt("length");
    subject = rs.getString("subject");
    notes = rs.getString("notes");
    alertDate = rs.getTimestamp("alertdate");
    followupNotes = rs.getString("followup_notes");
    entered = rs.getTimestamp("entered_date");
    enteredBy = rs.getInt("enteredby");
    modified = rs.getTimestamp("modified_date");
    modifiedBy = rs.getInt("modifiedby");
    alertText = rs.getString("alert");
    alertCallTypeId = DatabaseUtils.getInt(rs, "alert_call_type_id");
    parentId = DatabaseUtils.getInt(rs, "parent_id");
    owner = DatabaseUtils.getInt(rs, "owner");
    assignedBy = DatabaseUtils.getInt(rs, "assignedBy");
    assignDate = rs.getTimestamp("assign_date");
    completedBy = DatabaseUtils.getInt(rs, "completedBy");
    completeDate = rs.getTimestamp("complete_date");
    resultId = DatabaseUtils.getInt(rs, "result_id");
    priorityId = DatabaseUtils.getInt(rs, "priority_id");
    statusId = rs.getInt("status_id");
    reminderId = DatabaseUtils.getInt(rs, "reminder_value");
    reminderTypeId = DatabaseUtils.getInt(rs, "reminder_type_id");
    alertDateTimeZone = rs.getString("alertdate_timezone");
    trashedDate = rs.getTimestamp("trashed_date");
    followupContactId = DatabaseUtils.getInt(rs, "followup_contact_id");
    followupEndDate = rs.getTimestamp("followup_end_date");
    followupEndDateTimeZone = rs.getString("followup_end_date_timezone");
    followupLocation = rs.getString("followup_location");
    followupLength = DatabaseUtils.getInt(rs, "followup_length");
    followupLengthDuration = DatabaseUtils.getInt(rs, "followup_length_duration");
    callStartDate = rs.getTimestamp("call_start_date");
    callStartDateTimeZone = rs.getString("call_start_date_timezone");
    callEndDate = rs.getTimestamp("call_end_date");
    callEndDateTimeZone = rs.getString("call_end_date_timezone");
    callLocation = rs.getString("call_location");
    callLengthDuration = DatabaseUtils.getInt(rs, "call_length_duration");
    emailParticipants = rs.getBoolean("email_participants");
    emailFollowupParticipants = rs.getBoolean("email_followup_participants");
    //lookup_call_types table
    callTypeId = DatabaseUtils.getInt(rs, "code");
   	alertCallType = rs.getString("alertdescription");
    //contact table
    contactName = Contact.getNameLastFirst(
        rs.getString("ctlast"), rs.getString("ctfirst"));
    if (contactName == null || "".equals(contactName)) {
      contactName = rs.getString("ctcompany");
    }
    followupContactName = Contact.getNameLastFirst(
        rs.getString("fctlast"), rs.getString("fctfirst"));
    if (followupContactName == null || "".equals(followupContactName)) {
      followupContactName = rs.getString("fctcompany");
    }
    orgName = rs.getString("orgname");
    priorityString = rs.getString("priority");
  }


  /**
   * Gets the properties that are TimeZone sensitive for a Call
   *
   * @return The timeZoneParams value
   */
  public static ArrayList getTimeZoneParams() {
    ArrayList thisList = new ArrayList();
    thisList.add("alertDate");
    thisList.add("followupEndDate");
    thisList.add("callStartDate");
    thisList.add("callEndDate");
    return thisList;
  }


  /**
   * Description of the Method
   *
   * @param db       Description of the Parameter
   * @param context  Description of the Parameter
   * @param newOwner Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public boolean reassign(Connection db, ActionContext context, int newOwner) throws SQLException {
    int result = -1;
    this.setOwner(newOwner);
    result = this.update(db);
    if (result == -1) {
      return false;
    }
    return true;
  }


  /**
   * Description of the Method
   *
   * @param db       Description of the Parameter
   * @param context  Description of the Parameter
   * @param newOrgId Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public boolean reassignAccount(Connection db, ActionContext context, int newOrgId) throws SQLException {
    int result = -1;
    this.setOrgId(newOrgId);
    this.setUpdateOrganization(true);
    result = this.update(db);
    if (result == -1) {
      return false;
    }
    return true;
  }


  /**
   * Description of the Method
   *
   * @param tz      Description of the Parameter
   * @param created Description of the Parameter
   * @param type    Description of the Parameter
   * @return Description of the Return Value
   */
  public String generateWebcalEvent(TimeZone tz, Timestamp created, int type) {
    StringBuffer webcal = new StringBuffer();
    String CRLF = System.getProperty("line.separator");

    String description = "";
    if (contactName != null && !"".equals(contactName.trim())) {
      description += contactName;
    }

    if (orgName != null && !"".equals(orgName.trim())) {
      description += "\\n";
      description += orgName;
    }

    if (type == COMPLETE_FOLLOWUP_PENDING) {
      if (contact != null) {
        Iterator k = contact.getPhoneNumberList().iterator();
        while (k.hasNext()) {
          PhoneNumber thisNumber = (PhoneNumber) k.next();
          description += "\\n" + String.valueOf(
              thisNumber.getTypeName().charAt(0)) + ":" + thisNumber.getNumber();
        }
      }

      if (followupNotes != null) {
        description += "\\n\\n";
        description += followupNotes;
      }
    }

    if (type == COMPLETE) {
      if (notes != null) {
        description += "\\n\\n";
        description += notes;
      }
    }

    //write the event
    webcal.append("BEGIN:VEVENT" + CRLF);

    if (type == COMPLETE_FOLLOWUP_PENDING) {
      webcal.append(
          "UID:www.centriccrm.com-myhomepage-pending-calls-" + this.getId() + CRLF);
    } else if (type == COMPLETE) {
      webcal.append(
          "UID:www.centriccrm.com-myhomepage-completed-calls-" + this.getId() + CRLF);
    }

    if (created != null) {
      webcal.append("DTSTAMP:" + ICalendar.getDateTimeUTC(created) + CRLF);
    }

    if (entered != null) {
      webcal.append("CREATED:" + ICalendar.getDateTimeUTC(entered) + CRLF);
    }

    if (type == COMPLETE_FOLLOWUP_PENDING) {
      if (alertDate != null) {
        webcal.append(
            "DTSTART;TZID=" + tz.getID() + ":" + ICalendar.getDateTime(
                tz, alertDate) + CRLF);
      }
    } else if (type == COMPLETE) {
      if (completeDate != null) {
        webcal.append(
            "DTSTART;TZID=" + tz.getID() + ":" + ICalendar.getDateTime(
                tz, completeDate) + CRLF);
      }
    }

    if (type == COMPLETE && length != -1) {
      webcal.append("DURATION:" + "PT" + length + "M" + CRLF);
      //Positive time in minutes
    }

    if (type == COMPLETE_FOLLOWUP_PENDING) {
      if (alertText != null) {
        webcal.append(ICalendar.foldLine("SUMMARY:" + alertText) + CRLF);
      }
    } else if (type == COMPLETE) {
      if (subject != null) {
        webcal.append(ICalendar.foldLine("SUMMARY:" + subject) + CRLF);
      }
    }

    if (description != null) {
      webcal.append(
          ICalendar.foldLine(
              "DESCRIPTION:" + ICalendar.parseNewLine(description)) + CRLF);
    }

    if (priorityString != null) {
      webcal.append("PRIORITY:" + priorityString + CRLF);
    }

    webcal.append("END:VEVENT" + CRLF);

    return webcal.toString();
  }


  /**
   * Gets the action attribute of the Call object
   *
   * @return action The action value
   */
  public String getAction() {
    return this.action;
  }


  /**
   * Sets the action attribute of the Call object
   *
   * @param action The new action value
   */
  public void setAction(String action) {
    this.action = action;
  }


  /**
   * Gets the followupContactName attribute of the Call object
   *
   * @return followupContactName The followupContactName value
   */
  public String getFollowupContactName() {
    return this.followupContactName;
  }

  /**
   * Sets the followupContactName attribute of the Call object
   *
   * @param followupContactName The new followupContactName value
   */
  public void setFollowupContactName(String followupContactName) {
    this.followupContactName = followupContactName;
  }

  /**
   * Gets the participants attribute of the Call object
   *
   * @return participants The participants value
   */
  public CallParticipantList getParticipants() {
    return this.participants;
  }

  /**
   * Sets the participants attribute of the Call object
   *
   * @param tmp The new participants value
   */
  public void setParticipants(CallParticipantList tmp) {
		if (tmp != null) {
			Iterator i = tmp.iterator();
			while (i.hasNext()) {
				CallParticipant participant = (CallParticipant) i.next();
				participant.setCallId(this.getId());
			}
			this.participants = tmp;
		}
	}

  /**
   * Gets the buildParticipants attribute of the Call object
   *
   * @return buildParticipants The buildParticipants value
   * @throws SQLException 
   */
  public void buildParticipants(Connection db) throws SQLException {
    
    participants.setCallId(id);
    participants.setIsFollowup(CallParticipant.LOGGED_CALL);
    participants.buildList(db);
    followupParticipants.setCallId(id);
    followupParticipants.setIsFollowup(CallParticipant.SCHEDULED_CALL);
    followupParticipants.buildList(db);
  }
  
  /**
   * Gets the followupParticipants attribute of the Call object
   *
   * @return followupParticipants The followupParticipants value
   */
  public CallParticipantList getFollowupParticipants() {
    return this.followupParticipants;
  }

  /**
   * Sets the followupParticipants attribute of the Call object
   *
   * @param tmp The new followupParticipants value
   */
  public void setFollowupParticipants(CallParticipantList tmp) {
		if (tmp != null) {
			Iterator i = tmp.iterator();
			while (i.hasNext()) {
				CallParticipant participant = (CallParticipant) i.next();
				participant.setCallId(this.getId());
			}
			this.followupParticipants = tmp;
		}
	}

	public boolean getEmailFollowupParticipants() {
		return emailFollowupParticipants;
	}
  public String getEmailFollowupParticipantsString() {
    return emailFollowupParticipants?"Yes":"No";
  }
	public void setEmailFollowupParticipants(String tmp) {
		this.emailFollowupParticipants = ("true".equalsIgnoreCase(tmp) || "on".equalsIgnoreCase(tmp));
	}

	public boolean getEmailParticipants() {
		return emailParticipants;
	}

	public void setEmailParticipants(String tmp) {
		this.emailParticipants = ("true".equalsIgnoreCase(tmp) || "on".equalsIgnoreCase(tmp));
	}


	/**
	 * @return the reminder
	 */
	public boolean getReminder() {
		return reminder;
	}


	/**
	 * @param reminder the reminder to set
	 */
	public void setReminder(String tmp) {
		this.reminder = ("true".equalsIgnoreCase(tmp) || "on".equalsIgnoreCase(tmp));
	}


	/**
	 * @return the callLengthDurationText
	 */
	public String getCallLengthDurationText() {
		return callLengthDurationText;
	}


	/**
	 * @param callLengthDurationText the callLengthDurationText to set
	 */
	public void setCallLengthDurationText(String callLengthDurationText) {
		this.callLengthDurationText = callLengthDurationText;
	}

  public void setCallLengthDurationText(Connection db) throws SQLException {
  	LookupList lengthTypes = new LookupList(db, "lookup_call_reminder");
  	callLengthDurationText = lengthTypes.getValueFromId(callLengthDuration);
  }


	/**
	 * @return the followupCallLengthDurationText
	 */
	public String getFollowupCallLengthDurationText() {
		return followupCallLengthDurationText;
	}


	/**
	 * @param followupCallLengthDurationText the followupCallLengthDurationText to set
	 */
	public void setFollowupCallLengthDurationText(String followupCallLengthDurationText) {
		this.followupCallLengthDurationText = followupCallLengthDurationText;
	}

  public void setFollowupCallLengthDurationText(Connection db) throws SQLException {
  	LookupList lengthTypes = new LookupList(db, "lookup_call_reminder");
  	followupCallLengthDurationText = lengthTypes.getValueFromId(followupLengthDuration);
  }


	/**
	 * @return the followupContact
	 */
	public Contact getFollowupContact() {
		return followupContact;
	}


	/**
	 * @param followupContact the followupContact to set
	 */
	public void setFollowupContact(Contact followupContact) {
		this.followupContact = followupContact;
	}

}
