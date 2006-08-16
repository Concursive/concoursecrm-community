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
package org.aspcfs.modules.communications.base;

import com.darkhorseventures.framework.beans.GenericBean;
import com.zeroio.iteam.base.FileItemList;
import org.aspcfs.modules.accounts.base.OrganizationHistory;
import org.aspcfs.modules.actionlist.base.ActionItemLog;
import org.aspcfs.modules.actionplans.base.ActionStepList;
import org.aspcfs.modules.actionplans.base.ActionStep;
import org.aspcfs.modules.admin.base.AccessTypeList;
import org.aspcfs.modules.admin.base.AccessType;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.base.Dependency;
import org.aspcfs.modules.base.DependencyList;
import org.aspcfs.modules.contacts.base.Contact;
import org.aspcfs.modules.contacts.base.ContactHistory;
import org.aspcfs.modules.contacts.base.ContactList;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.DateUtils;
import org.aspcfs.utils.PasswordHash;
import org.aspcfs.utils.Template;

import javax.servlet.http.HttpServletRequest;
import java.sql.*;
import java.text.DateFormat;
import java.util.*;

/**
 *  Description of the Class
 *
 * @author     Wesley_S_Gillette
 * @created    November 16, 2001
 * @version    $Id: Campaign.java,v 1.58.12.1 2004/11/12 19:55:24 mrajkowski Exp
 *      $
 */
public class Campaign extends GenericBean {

  public final static int IDLE = 1;
  public final static int QUEUE = 2;
  public final static int STARTED = 3;
  public final static int FINISHED = 4;
  public final static int ERROR = 5;
  public final static int CANCELED = 6;

  public final static String IDLE_TEXT = "Idle";
  public final static String QUEUE_TEXT = "In Queue";
  public final static String STARTED_TEXT = "Sending Messages";
  public final static String FINISHED_TEXT = "Messages Sent";
  public final static String ERROR_TEXT = "Error in Campaign";
  public final static String CANCELED_TEXT = "Canceled";

  //campaign types
  public final static int GENERAL = 1;
  public final static int INSTANT = 2;

  private int id = -1;
  private String name = null;
  private String description = null;
  private int messageId = -1;
  private int groupId = -1;
  private int runId = -1;
  private int statusId = -1;
  private int owner = -1;
  private int modifiedBy = -1;
  private int enteredBy = -1;
  private java.sql.Timestamp activeDate = null;
  private java.sql.Timestamp inactiveDate = null;
  private java.sql.Timestamp entered = null;
  private java.sql.Timestamp modified = null;
  private boolean enabled = true;
  private String status = null;
  private boolean active = false;
  private String replyTo = null;
  private String subject = null;
  private String message = null;
  private int sendMethodId = -1;
  private int type = GENERAL;
  private String activeDateTimeZone = null;
  private java.sql.Timestamp trashedDate = null;
  private boolean partComplete = false;

  private boolean buildGroupMaps = false;
  private CampaignUserGroupMapList userGroupMaps = new CampaignUserGroupMapList();
  private int files = 0;
  private String deliveryName = null;
  private int deliveryType = -1;
  private ContactList contactList = null;
  private int recipientCount = -1;
  private int responseCount = -1;
  private int sentCount = -1;
  private String messageName = "";
  private int surveyId = -1;
  private String serverName = "";
  private String groupList = "";
  private int groupCount = -1;
  private int approvedBy = -1;
  private java.sql.Timestamp approvalDate = null;
  private LinkedHashMap groups = null;
  private java.sql.Timestamp lastResponse = null;
  private String messageSubject = null;
  private boolean hasAddressRequest = false;
  private int addressSurveyId = -1;
  private int addressResponseCount = -1;
  private java.sql.Timestamp lastAddressResponse = null;
  private boolean hasSurvey = false;
  protected String bcc = null;
  protected String cc = null;


  /**
   *  Constructor for the Campaign object
   *
   * @since    1.1
   */
  public Campaign() { }


  /**
   *  Constructor for the Campaign object
   *
   * @param  rs                Description of Parameter
   * @exception  SQLException  Description of the Exception
   * @throws  SQLException     Description of the Exception
   * @throws  SQLException     Description of Exception
   * @since                    1.1
   */
  public Campaign(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }


  /**
   *  Sets the activeDateTimeZone attribute of the Campaign object
   *
   * @param  tmp  The new activeDateTimeZone value
   */
  public void setActiveDateTimeZone(String tmp) {
    this.activeDateTimeZone = tmp;
  }


  /**
   *  Gets the activeDateTimeZone attribute of the Campaign object
   *
   * @return    The activeDateTimeZone value
   */
  public String getActiveDateTimeZone() {
    return activeDateTimeZone;
  }


  /**
   *  Sets the trashedDate attribute of the Campaign object
   *
   * @param  tmp  The new trashedDate value
   */
  public void setTrashedDate(java.sql.Timestamp tmp) {
    this.trashedDate = tmp;
  }


  /**
   *  Sets the trashedDate attribute of the Campaign object
   *
   * @param  tmp  The new trashedDate value
   */
  public void setTrashedDate(String tmp) {
    this.trashedDate = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   *  Gets the trashedDate attribute of the Campaign object
   *
   * @return    The trashedDate value
   */
  public java.sql.Timestamp getTrashedDate() {
    return trashedDate;
  }


  /**
   *  Gets the surveyId attribute of the Campaign object
   *
   * @return    The surveyId value
   */
  public int getSurveyId() {
    return surveyId;
  }


  /**
   *  Gets the activeSurveyId attribute of the Campaign object
   *
   * @return    The activeSurveyId value
   */
  public int getActiveSurveyId() {
    if (active) {
      return surveyId;
    } else {
      return -1;
    }
  }


  /**
   *  Sets the surveyId attribute of the Campaign object
   *
   * @param  surveyId  The new surveyId value
   */
  public void setSurveyId(int surveyId) {
    this.surveyId = surveyId;
  }


  /**
   *  Sets the surveyId attribute of the Campaign object
   *
   * @param  surveyId  The new surveyId value
   */
  public void setSurveyId(String surveyId) {
    this.surveyId = Integer.parseInt(surveyId);
  }


  /**
   *  Sets the groups attribute of the Campaign object
   *
   * @param  groups  The new groups value
   */
  public void setGroups(LinkedHashMap groups) {
    this.groups = groups;
  }


  /**
   *  Sets the responseCount attribute of the Campaign object
   *
   * @param  responseCount  The new responseCount value
   */
  public void setResponseCount(int responseCount) {
    this.responseCount = responseCount;
  }


  /**
   *  Sets the lastResponse attribute of the Campaign object
   *
   * @param  lastResponse  The new lastResponse value
   */
  public void setLastResponse(java.sql.Timestamp lastResponse) {
    this.lastResponse = lastResponse;
  }


  /**
   *  Sets the type attribute of the Campaign object
   *
   * @param  type  The new type value
   */
  public void setType(int type) {
    this.type = type;
  }


  /**
   *  Sets the type attribute of the Campaign object
   *
   * @param  type  The new type value
   */
  public void setType(String type) {
    this.type = Integer.parseInt(type);
  }


  /**
   *  Sets the messageSubject attribute of the Campaign object
   *
   * @param  tmp  The new messageSubject value
   */
  public void setMessageSubject(String tmp) {
    this.messageSubject = tmp;
  }


  /**
   *  Sets the hasAddressRequest attribute of the Campaign object
   *
   * @param  tmp  The new hasAddressRequest value
   */
  public void setHasAddressRequest(boolean tmp) {
    this.hasAddressRequest = tmp;
  }


  /**
   *  Sets the hasAddressRequest attribute of the Campaign object
   *
   * @param  tmp  The new hasAddressRequest value
   */
  public void setHasAddressRequest(String tmp) {
    this.hasAddressRequest = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Sets the addressSurveyId attribute of the Campaign object
   *
   * @param  tmp  The new addressSurveyId value
   */
  public void setAddressSurveyId(int tmp) {
    this.addressSurveyId = tmp;
  }


  /**
   *  Sets the addressSurveyId attribute of the Campaign object
   *
   * @param  tmp  The new addressSurveyId value
   */
  public void setAddressSurveyId(String tmp) {
    this.addressSurveyId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the addressResponseCount attribute of the Campaign object
   *
   * @param  tmp  The new addressResponseCount value
   */
  public void setAddressResponseCount(int tmp) {
    this.addressResponseCount = tmp;
  }


  /**
   *  Sets the addressResponseCount attribute of the Campaign object
   *
   * @param  tmp  The new addressResponseCount value
   */
  public void setAddressResponseCount(String tmp) {
    this.addressResponseCount = Integer.parseInt(tmp);
  }


  /**
   *  Sets the lastAddressResponse attribute of the Campaign object
   *
   * @param  tmp  The new lastAddressResponse value
   */
  public void setLastAddressResponse(java.sql.Timestamp tmp) {
    this.lastAddressResponse = tmp;
  }


  /**
   *  Sets the lastAddressResponse attribute of the Campaign object
   *
   * @param  tmp  The new lastAddressResponse value
   */
  public void setLastAddressResponse(String tmp) {
    this.lastAddressResponse = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   *  Sets the hasSurvey attribute of the Campaign object
   *
   * @param  tmp  The new hasSurvey value
   */
  public void setHasSurvey(boolean tmp) {
    this.hasSurvey = tmp;
  }


  /**
   *  Sets the hasSurvey attribute of the Campaign object
   *
   * @param  tmp  The new hasSurvey value
   */
  public void setHasSurvey(String tmp) {
    this.hasSurvey = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Gets the messageSubject attribute of the Campaign object
   *
   * @return    The messageSubject value
   */
  public String getMessageSubject() {
    return messageSubject;
  }


  /**
   *  Gets the hasAddressRequest attribute of the Campaign object
   *
   * @return    The hasAddressRequest value
   */
  public boolean getHasAddressRequest() {
    return hasAddressRequest;
  }


  /**
   *  Gets the addressSurveyId attribute of the Campaign object
   *
   * @return    The addressSurveyId value
   */
  public int getAddressSurveyId() {
    return addressSurveyId;
  }


  /**
   *  Gets the addressResponseCount attribute of the Campaign object
   *
   * @return    The addressResponseCount value
   */
  public int getAddressResponseCount() {
    return addressResponseCount;
  }


  /**
   *  Gets the lastAddressResponse attribute of the Campaign object
   *
   * @return    The lastAddressResponse value
   */
  public java.sql.Timestamp getLastAddressResponse() {
    return lastAddressResponse;
  }


  /**
   *  Gets the hasSurvey attribute of the Campaign object
   *
   * @return    The hasSurvey value
   */
  public boolean getHasSurvey() {
    return hasSurvey;
  }


  /**
   *  Gets the type attribute of the Campaign object
   *
   * @return    The type value
   */
  public int getType() {
    return type;
  }


  /**
   *  Gets the lastResponse attribute of the Campaign object
   *
   * @return    The lastResponse value
   */
  public java.sql.Timestamp getLastResponse() {
    return lastResponse;
  }


  /**
   *  Gets the lastResponseString attribute of the Campaign object
   *
   * @return    The lastResponseString value
   */
  public String getLastResponseString() {
    String tmp = "";
    try {
      return DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.LONG).format(
          lastResponse);
    } catch (NullPointerException e) {
    }
    return tmp;
  }


  /**
   *  Gets the lastAddressResponseString attribute of the Campaign object
   *
   * @return    The lastAddressResponseString value
   */
  public String getLastAddressResponseString() {
    String tmp = "";
    try {
      return DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.LONG).format(
          lastAddressResponse);
    } catch (NullPointerException e) {
    }
    return tmp;
  }


  /**
   *  Gets the responseCount attribute of the Campaign object
   *
   * @return    The responseCount value
   */
  public int getResponseCount() {
    return responseCount;
  }


  /**
   *  Gets the groups attribute of the Campaign object
   *
   * @return    The groups value
   */
  public LinkedHashMap getGroups() {
    return groups;
  }


  /**
   *  Gets the bcc attribute of the Campaign object
   *
   * @return    The bcc value
   */
  public String getBcc() {
    return bcc;
  }


  /**
   *  Sets the bcc attribute of the Campaign object
   *
   * @param  tmp  The new bcc value
   */
  public void setBcc(String tmp) {
    this.bcc = tmp;
  }


  /**
   *  Gets the cc attribute of the Campaign object
   *
   * @return    The cc value
   */
  public String getCc() {
    return cc;
  }


  /**
   *  Sets the cc attribute of the Campaign object
   *
   * @param  tmp  The new cc value
   */
  public void setCc(String tmp) {
    this.cc = tmp;
  }


  /**
   *  Constructor for the Campaign object
   *
   * @param  db                Description of Parameter
   * @param  campaignId        Description of Parameter
   * @exception  SQLException  Description of the Exception
   * @throws  SQLException     Description of Exception
   * @since                    1.1
   */
  public Campaign(Connection db, String campaignId) throws SQLException {
    queryRecord(db, Integer.parseInt(campaignId));
  }


  /**
   *  Constructor for the Campaign object
   *
   * @param  db                Description of the Parameter
   * @param  campaignId        Description of the Parameter
   * @exception  SQLException  Description of the Exception
   * @throws  SQLException     Description of the Exception
   */
  public Campaign(Connection db, int campaignId) throws SQLException {
    queryRecord(db, campaignId);
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @param  campaignId     Description of the Parameter
   * @throws  SQLException  Description of the Exception
   */
  public void queryRecord(Connection db, int campaignId) throws SQLException {
    if (campaignId <= 0) {
      throw new SQLException("Invalid ID specified.");
    }
    PreparedStatement pst = null;
    ResultSet rs = null;

    String sql =
        "SELECT c.*, msg.name AS messageName, msg.subject AS messageSubject, dt.code AS deliveryType, dt.description AS deliveryTypeName " +
        "FROM campaign c " +
        "LEFT JOIN " + DatabaseUtils.addQuotes(db, "message") + " msg ON (c.message_id = msg.id) " +
        "LEFT JOIN lookup_delivery_options dt ON (c.send_method_id = dt.code) " +
        "WHERE c.campaign_id = ? ";
    pst = db.prepareStatement(sql);
    pst.setInt(1, campaignId);
    rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    }
    rs.close();
    pst.close();
    if (id == -1) {
      throw new SQLException(Constants.NOT_FOUND_ERROR);
    }
    buildRecipientCount(db);
    buildResponseCount(db);
    buildAddressResponseCount(db);
    buildLastResponse(db);
    buildLastAddressResponse(db);
    buildSurveyId(db);
    buildHasAddressRequest(db);
    buildHasSurvey(db);
    setGroupList(db);
    buildFileCount(db);
    buildGroups(db);
    buildUserGroupMaps(db);
  }


  /**
   *  Description of the Method
   *
   * @param  db                Description of the Parameter
   * @exception  SQLException  Description of the Exception
   */
  public void buildUserGroupMaps(Connection db) throws SQLException {
    if (this.getBuildGroupMaps()) {
      if (userGroupMaps == null) {
        userGroupMaps = new CampaignUserGroupMapList();
      }
      userGroupMaps.setCampaignId(this.getId());
      userGroupMaps.buildList(db);
    }
  }


  /**
   *  Sets the ContactList attribute of the Campaign object
   *
   * @param  contactList  The new ContactList value
   * @since               1.10
   */
  public void setContactList(ContactList contactList) {
    this.contactList = contactList;
  }


  /**
   *  Sets the RecipientCount attribute of the Campaign object
   *
   * @param  recipientCount  The new RecipientCount value
   * @since                  1.17
   */
  public void setRecipientCount(int recipientCount) {
    this.recipientCount = recipientCount;
  }


  /**
   *  Sets the RecipientCount attribute of the Campaign object
   *
   * @param  recipientCount  The new RecipientCount value
   * @since                  1.17
   */
  public void setRecipientCount(String recipientCount) {
    this.recipientCount = Integer.parseInt(recipientCount);
  }


  /**
   *  Sets the SentCount attribute of the Campaign object
   *
   * @param  tmp  The new SentCount value
   * @since       1.17
   */
  public void setSentCount(int tmp) {
    this.sentCount = tmp;
  }


  /**
   *  Sets the MessageName attribute of the Campaign object
   *
   * @param  messageName  The new MessageName value
   * @since               1.10
   */
  public void setMessageName(String messageName) {
    this.messageName = messageName;
  }


  /**
   *  Gets the serverName attribute of the Campaign object
   *
   * @return    The serverName value
   */
  public String getServerName() {
    return serverName;
  }


  /**
   *  Sets the serverName attribute of the Campaign object
   *
   * @param  serverName  The new serverName value
   */
  public void setServerName(String serverName) {
    this.serverName = serverName;
  }


  /**
   *  Sets the GroupList attribute of the Campaign object
   *
   * @param  groupList  The new GroupList value
   * @since             1.10
   */
  public void setGroupList(String groupList) {
    this.groupList = groupList;
  }


  /**
   *  Gets the approvedBy attribute of the Campaign object
   *
   * @return    The approvedBy value
   */
  public int getApprovedBy() {
    return approvedBy;
  }


  /**
   *  Sets the approvedBy attribute of the Campaign object
   *
   * @param  approvedBy  The new approvedBy value
   */
  public void setApprovedBy(int approvedBy) {
    this.approvedBy = approvedBy;
  }


  /**
   *  Sets the approvedBy attribute of the Campaign object
   *
   * @param  approvedBy  The new approvedBy value
   */
  public void setApprovedBy(String approvedBy) {
    this.approvedBy = Integer.parseInt(approvedBy);
  }


  /**
   *  Sets the id attribute of the Campaign object
   *
   * @param  tmp  The new id value
   * @since       1.1
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   *  Sets the id attribute of the Campaign object
   *
   * @param  tmp  The new id value
   * @since       1.1
   */
  public void setId(String tmp) {
    this.setId(Integer.parseInt(tmp));
  }


  /**
   *  Sets the Active attribute of the Campaign object
   *
   * @param  active  The new Active value
   * @since          1.1
   */
  public void setActive(boolean active) {
    this.active = active;
  }


  /**
   *  Sets the Active attribute of the Campaign object
   *
   * @param  tmp  The new Active value
   * @since       1.1
   */
  public void setActive(String tmp) {
    active = DatabaseUtils.parseBoolean(tmp);
    ;
  }


  /**
   *  Sets the replyTo attribute of the Campaign object
   *
   * @param  tmp  The new replyTo value
   */
  public void setReplyTo(String tmp) {
    this.replyTo = tmp;
  }


  /**
   *  Sets the subject attribute of the Campaign object
   *
   * @param  tmp  The new subject value
   */
  public void setSubject(String tmp) {
    this.subject = tmp;
  }


  /**
   *  Sets the message attribute of the Campaign object
   *
   * @param  tmp  The new message value
   */
  public void setMessage(String tmp) {
    this.message = tmp;
  }


  /**
   *  Sets the sendMethodId attribute of the Campaign object
   *
   * @param  tmp  The new sendMethodId value
   */
  public void setSendMethodId(int tmp) {
    this.sendMethodId = tmp;
  }


  /**
   *  Sets the sendMethodId attribute of the Campaign object
   *
   * @param  tmp  The new sendMethodId value
   */
  public void setSendMethodId(String tmp) {
    this.sendMethodId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the name attribute of the Campaign object
   *
   * @param  tmp  The new name value
   * @since       1.1
   */
  public void setName(String tmp) {
    this.name = tmp;
  }


  /**
   *  Sets the description attribute of the Campaign object
   *
   * @param  tmp  The new description value
   * @since       1.1
   */
  public void setDescription(String tmp) {
    this.description = tmp;
  }


  /**
   *  Sets the Status attribute of the Campaign object
   *
   * @param  status  The new Status value
   * @since          1.17
   */
  public void setStatus(String status) {
    this.status = status;
  }


  /**
   *  Sets the messageId attribute of the Campaign object
   *
   * @param  tmp  The new messageId value
   * @since       1.10
   */
  public void setMessageId(int tmp) {
    this.messageId = tmp;
  }


  /**
   *  Sets the MessageId attribute of the Campaign object
   *
   * @param  tmp  The new MessageId value
   * @since       1.10
   */
  public void setMessageId(String tmp) {
    this.messageId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the groupId attribute of the Campaign object
   *
   * @param  tmp  The new groupId value
   * @since       1.10
   */
  public void setGroupId(int tmp) {
    this.groupId = tmp;
  }


  /**
   *  Sets the groupId attribute of the Campaign object
   *
   * @param  tmp  The new groupId value
   */
  public void setGroupId(String tmp) {
    this.groupId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the runId attribute of the Campaign object
   *
   * @param  tmp  The new runId value
   * @since       1.10
   */
  public void setRunId(int tmp) {
    this.runId = tmp;
  }


  /**
   *  Sets the runId attribute of the Campaign object
   *
   * @param  tmp  The new runId value
   */
  public void setRunId(String tmp) {
    this.runId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the statusId attribute of the Campaign object
   *
   * @param  tmp  The new statusId value
   * @since       1.17
   */
  public void setStatusId(int tmp) {
    this.statusId = tmp;

    switch (statusId) {
      case IDLE:
        status = IDLE_TEXT;
        break;
      case QUEUE:
        status = QUEUE_TEXT;
        break;
      case STARTED:
        status = STARTED_TEXT;
        break;
      case ERROR:
        status = "Unspecified error";
        break;
      case FINISHED:
        status = FINISHED_TEXT;
        break;
      default:
        break;
    }
  }


  /**
   *  Sets the statusId attribute of the Campaign object
   *
   * @param  tmp  The new statusId value
   */
  public void setStatusId(String tmp) {
    this.setStatusId(Integer.parseInt(tmp));
  }


  /**
   *  Sets the owner attribute of the Campaign object
   *
   * @param  tmp  The new owner value
   * @since       1.10
   */
  public void setOwner(int tmp) {
    this.owner = tmp;
  }


  /**
   *  Sets the owner attribute of the Campaign object
   *
   * @param  tmp  The new owner value
   */
  public void setOwner(String tmp) {
    this.owner = Integer.parseInt(tmp);
  }


  /**
   *  Sets the ActiveDate attribute of the Campaign object
   *
   * @param  tmp  The new ActiveDate value
   * @since       1.10
   */
  public void setActiveDate(java.sql.Timestamp tmp) {
    this.activeDate = tmp;
  }


  /**
   *  Sets the entered attribute of the Ticket object
   *
   * @param  tmp  The new entered value
   */
  public void setActiveDate(String tmp) {
    this.activeDate = DatabaseUtils.parseDateToTimestamp(tmp);
  }


  /**
   *  Sets the inactiveDate attribute of the Campaign object
   *
   * @param  tmp  The new inactiveDate value
   */
  public void setInactiveDate(java.sql.Timestamp tmp) {
    this.inactiveDate = tmp;
  }


  /**
   *  Sets the inactiveDate attribute of the Campaign object
   *
   * @param  tmp  The new inactiveDate value
   */
  public void setInactiveDate(String tmp) {
    this.inactiveDate = DatabaseUtils.parseDateToTimestamp(tmp);
  }


  /**
   *  Sets the Entered attribute of the Campaign object
   *
   * @param  tmp  The new Entered value
   * @since       1.17
   */
  public void setEntered(Timestamp tmp) {
    this.entered = tmp;
  }


  /**
   *  Sets the entered attribute of the Ticket object
   *
   * @param  tmp  The new entered value
   */
  public void setEntered(String tmp) {
    this.entered = DateUtils.parseTimestampString(tmp);
  }


  /**
   *  Sets the modified attribute of the Ticket object
   *
   * @param  tmp  The new modified value
   */
  public void setModified(String tmp) {
    this.modified = DateUtils.parseTimestampString(tmp);
  }


  /**
   *  Sets the enteredBy attribute of the Campaign object
   *
   * @param  tmp  The new enteredBy value
   * @since       1.17
   */
  public void setEnteredBy(int tmp) {
    this.enteredBy = tmp;
  }


  /**
   *  Sets the enteredBy attribute of the Campaign object
   *
   * @param  tmp  The new enteredBy value
   */
  public void setEnteredBy(String tmp) {
    this.enteredBy = Integer.parseInt(tmp);
  }


  /**
   *  Sets the Modified attribute of the Campaign object
   *
   * @param  tmp  The new Modified value
   * @since       1.17
   */
  public void setModified(Timestamp tmp) {
    this.modified = tmp;
  }


  /**
   *  Sets the modifiedBy attribute of the Campaign object
   *
   * @param  tmp  The new modifiedBy value
   * @since       1.17
   */
  public void setModifiedBy(int tmp) {
    this.modifiedBy = tmp;
  }


  /**
   *  Sets the modifiedBy attribute of the Campaign object
   *
   * @param  tmp  The new modifiedBy value
   */
  public void setModifiedBy(String tmp) {
    this.modifiedBy = Integer.parseInt(tmp);
  }


  /**
   *  Sets the enabled attribute of the Campaign object
   *
   * @param  tmp  The new enabled value
   * @since       1.1
   */
  public void setEnabled(boolean tmp) {
    enabled = tmp;
  }


  /**
   *  Sets the enabled attribute of the Campaign object
   *
   * @param  tmp  The new enabled value
   * @since       1.1
   */
  public void setEnabled(String tmp) {
    enabled = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Sets the deliveryName attribute of the Campaign object
   *
   * @param  deliveryName  The new deliveryName value
   */
  public void setDeliveryName(String deliveryName) {
    this.deliveryName = deliveryName;
  }


  /**
   *  Sets the deliveryType attribute of the Campaign object
   *
   * @param  tmp  The new deliveryType value
   */
  public void setDeliveryType(int tmp) {
    this.deliveryType = tmp;
  }


  /**
   *  Sets the deliveryType attribute of the Campaign object
   *
   * @param  tmp  The new deliveryType value
   */
  public void setDeliveryType(String tmp) {
    this.deliveryType = Integer.parseInt(tmp);
  }


  /**
   *  Sets the Groups attribute of the Campaign object
   *
   * @param  request  The new Groups value
   * @since           1.10
   */
  public void setGroups(HttpServletRequest request) {
    StringBuffer sb = new StringBuffer();
    int selectCount = 0;
    String item = null;
    while ((item = request.getParameter("select" + (++selectCount))) != null) {
      if (DatabaseUtils.parseBoolean(
          request.getParameter("select" + selectCount + "check"))) {
        if (sb.length() > 0) {
          sb.append("*");
        }
        sb.append(item);
      }
    }
    groupList = sb.toString();
  }


  /**
   *  Sets the GroupList attribute of the Campaign object
   *
   * @param  db             The new GroupList value
   * @throws  SQLException  Description of Exception
   * @since                 1.10
   */
  public void setGroupList(Connection db) throws SQLException {
    this.groupCount = 0;
    StringBuffer groups = new StringBuffer();
    boolean b = false;

    PreparedStatement pst = db.prepareStatement(
        "SELECT group_id " +
        "FROM campaign_list_groups " +
        "WHERE campaign_id = ? ");
    pst.setInt(1, this.getId());
    ResultSet rs = pst.executeQuery();
    while (rs.next()) {
      ++groupCount;
      if (b) {
        groups.append(", ");
      } else {
        b = true;
      }
      groups.append(rs.getInt("group_id"));
    }
    this.setGroupList(groups.toString());
    rs.close();
    pst.close();
  }


  /**
   *  Gets the modified attribute of the Campaign object
   *
   * @return    The modified value
   */
  public java.sql.Timestamp getModified() {
    return modified;
  }


  /**
   *  Gets the sendMethodId attribute of the Campaign object
   *
   * @return    The sendMethodId value
   */
  public int getSendMethodId() {
    return sendMethodId;
  }


  /**
   *  Gets the deliveryName attribute of the Campaign object
   *
   * @return    The deliveryName value
   */
  public String getDeliveryName() {
    return deliveryName;
  }


  /**
   *  Gets the deliveryType attribute of the Campaign object
   *
   * @return    The deliveryType value
   */
  public int getDeliveryType() {
    return deliveryType;
  }


  /**
   *  Gets the RecipientCount attribute of the Campaign object
   *
   * @return    The RecipientCount value
   * @since     1.10
   */
  public int getRecipientCount() {
    return recipientCount;
  }


  /**
   *  Gets the SentCount attribute of the Campaign object
   *
   * @return    The SentCount value
   * @since     1.10
   */
  public int getSentCount() {
    return sentCount;
  }


  /**
   *  Gets the ContactList attribute of the Campaign object
   *
   * @return    The ContactList value
   * @since     1.10
   */
  public ContactList getContactList() {
    if (contactList == null) {
      contactList = new ContactList();
    }
    return contactList;
  }


  /**
   *  Gets the MessageName attribute of the Campaign object
   *
   * @return    The MessageName value
   * @since     1.10
   */
  public String getMessageName() {
    return messageName;
  }


  /**
   *  Gets the Active attribute of the Campaign object
   *
   * @return    The Active value
   * @since     1.10
   */
  public boolean getActive() {
    return active;
  }


  /**
   *  Gets the ActiveYesNo attribute of the Campaign object
   *
   * @return    The ActiveYesNo value
   * @since     1.10
   */
  public String getActiveYesNo() {
    if (active == true) {
      return ("Yes");
    } else {
      return ("No");
    }
  }


  /**
   *  Gets the Active attribute of the Campaign object
   *
   * @param  tmp  Description of Parameter
   * @return      The Active value
   * @since       1.10
   */
  public String getActive(String tmp) {
    if (active == true) {
      return tmp;
    } else {
      return "";
    }
  }


  /**
   *  Gets the ActiveDate attribute of the Campaign object
   *
   * @return    The ActiveDate value
   * @since     1.10
   */
  public java.sql.Timestamp getActiveDate() {
    return activeDate;
  }


  /**
   *  Gets the ActiveDateString attribute of the Campaign object
   *
   * @return    The ActiveDateString value
   * @since     1.10
   */
  public String getActiveDateString() {
    String tmp = "";
    try {
      return DateFormat.getDateInstance(3).format(activeDate);
    } catch (NullPointerException e) {
    }
    return tmp;
  }


  /**
   *  Gets the Status attribute of the Campaign object
   *
   * @return    The Status value
   * @since     1.17
   */
  public String getStatus() {
    return status;
  }


  /**
   *  Gets the GroupList attribute of the Campaign object
   *
   * @return    The GroupList value
   * @since     1.10
   */
  public String getGroupList() {
    return groupList;
  }


  /**
   *  Gets the GroupCount attribute of the Campaign object
   *
   * @return    The GroupCount value
   * @since     1.10
   */
  public int getGroupCount() {
    return groupCount;
  }


  /**
   *  Gets the id attribute of the Campaign object
   *
   * @return    The id value
   * @since     1.1
   */
  public int getId() {
    return id;
  }


  /**
   *  Gets the name attribute of the Campaign object
   *
   * @return    The name value
   * @since     1.1
   */
  public String getName() {
    return name;
  }


  /**
   *  Gets the description attribute of the Campaign object
   *
   * @return    The description value
   * @since     1.1
   */
  public String getDescription() {
    return description;
  }


  /**
   *  Gets the messageId attribute of the Campaign object
   *
   * @return    The messageId value
   * @since     1.1
   */
  public int getMessageId() {
    return messageId;
  }


  /**
   *  Gets the replyTo attribute of the Campaign object
   *
   * @return    The replyTo value
   */
  public String getReplyTo() {
    return replyTo;
  }


  /**
   *  Gets the message attribute of the Campaign object
   *
   * @return    The message value
   */
  public String getMessage() {
    return message;
  }


  /**
   *  Gets the subject attribute of the Campaign object
   *
   * @return    The subject value
   */
  public String getSubject() {
    return subject;
  }


  /**
   *  Gets the groupId attribute of the Campaign object
   *
   * @return    The groupId value
   * @since     1.1
   */
  public int getGroupId() {
    return groupId;
  }


  /**
   *  Gets the runId attribute of the Campaign object
   *
   * @return    The runId value
   * @since     1.1
   */
  public int getRunId() {
    return runId;
  }


  /**
   *  Gets the statusId attribute of the Campaign object
   *
   * @return    The statusId value
   * @since     1.17
   */
  public int getStatusId() {
    return statusId;
  }


  /**
   *  Gets the owner attribute of the Campaign object
   *
   * @return    The owner value
   * @since     1.10
   */
  public int getOwner() {
    return owner;
  }


  /**
   *  Gets the enteredBy attribute of the Campaign object
   *
   * @return    The enteredBy value
   * @since     1.1
   */
  public int getEnteredBy() {
    return enteredBy;
  }


  /**
   *  Gets the modifiedBy attribute of the Campaign object
   *
   * @return    The modifiedBy value
   * @since     1.1
   */
  public int getModifiedBy() {
    return modifiedBy;
  }


  /**
   *  Gets the ModifiedString attribute of the Campaign object
   *
   * @return    The ModifiedString value
   * @since     1.17
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
   *  Gets the Entered attribute of the Campaign object
   *
   * @return    The Entered value
   * @since     1.17
   */
  public java.sql.Timestamp getEntered() {
    return entered;
  }


  /**
   *  Gets the EnteredString attribute of the Campaign object
   *
   * @return    The EnteredString value
   * @since     1.17
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
   *  Gets the enabled attribute of the Campaign object
   *
   * @return    The enabled value
   * @since     1.1
   */
  public boolean getEnabled() {
    return enabled;
  }


  /**
   *  Gets the partComplete attribute of the Campaign object
   *
   * @return    The partComplete value
   */
  public boolean getPartComplete() {
    return partComplete;
  }


  /**
   *  Sets the partComplete attribute of the Campaign object
   *
   * @param  tmp  The new partComplete value
   */
  public void setPartComplete(boolean tmp) {
    this.partComplete = tmp;
  }


  /**
   *  Sets the partComplete attribute of the Campaign object
   *
   * @param  tmp  The new partComplete value
   */
  public void setPartComplete(String tmp) {
    this.partComplete = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Gets the userGroupMaps attribute of the Campaign object
   *
   * @return    The userGroupMaps value
   */
  public CampaignUserGroupMapList getUserGroupMaps() {
    return userGroupMaps;
  }


  /**
   *  Sets the userGroupMaps attribute of the Campaign object
   *
   * @param  tmp  The new userGroupMaps value
   */
  public void setUserGroupMaps(CampaignUserGroupMapList tmp) {
    this.userGroupMaps = tmp;
  }


  /**
   *  Gets the buildGroupMaps attribute of the Campaign object
   *
   * @return    The buildGroupMaps value
   */
  public boolean getBuildGroupMaps() {
    return buildGroupMaps;
  }


  /**
   *  Sets the buildGroupMaps attribute of the Campaign object
   *
   * @param  tmp  The new buildGroupMaps value
   */
  public void setBuildGroupMaps(boolean tmp) {
    this.buildGroupMaps = tmp;
  }


  /**
   *  Sets the buildGroupMaps attribute of the Campaign object
   *
   * @param  tmp  The new buildGroupMaps value
   */
  public void setBuildGroupMaps(String tmp) {
    this.buildGroupMaps = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Gets the Range attribute of the Campaign object
   *
   * @return    The Range value
   * @since     1.10
   */
  public String getRange() {
    StringTokenizer strt = new StringTokenizer(this.getGroupList(), "*");
    String range = "";
    boolean b = true;

    while (strt.hasMoreTokens()) {
      String tmpString = (String) strt.nextToken();

      if (b == true) {
        range = range + tmpString;
        b = false;
      } else {
        range = range + ", " + tmpString;
      }
    }

    return range;
  }


  /**
   *  Gets the MessageChecked attribute of the Campaign object
   *
   * @param  tmp  Description of Parameter
   * @return      The MessageChecked value
   * @since       1.17
   */
  public String getMessageChecked(int tmp) {
    if (messageId == tmp) {
      return "checked";
    } else {
      return "";
    }
  }


  /**
   *  Gets the GroupChecked attribute of the Campaign object
   *
   * @param  tmp  Description of Parameter
   * @return      The GroupChecked value
   * @since       1.17
   */
  public String getGroupChecked(int tmp) {
    if (groupList != null || groupList.length() > 0) {
      StringTokenizer st = new StringTokenizer(groupList, "*");

      while (st.hasMoreTokens()) {
        String tmpString = (String) st.nextToken();
        if (tmpString.equals(String.valueOf(tmp))) {
          return "checked";
        }
      }
    }
    return "";
  }


  /**
   *  Gets the ReadyToActivate attribute of the Campaign object
   *
   * @return    The ReadyToActivate value
   * @since     1.17
   */
  public boolean isReadyToActivate() {
    return (hasGroups() && hasMessage() && hasDetails());
  }


  /**
   *  Description of the Method
   *
   * @return    Description of the Returned Value
   * @since     1.17
   */
  public boolean hasGroups() {
    return (groupList != null && !groupList.equals(""));
  }


  /**
   *  Description of the Method
   *
   * @return    Description of the Returned Value
   * @since     1.17
   */
  public boolean hasMessage() {
    return (messageId > 0);
  }


  /**
   *  Description of the Method
   *
   * @return    Description of the Return Value
   */
  public boolean hasSurvey() {
    return (surveyId > 0);
  }


  /**
   *  Description of the Method
   *
   * @return    Description of the Returned Value
   * @since     1.17
   */
  public boolean hasDetails() {
    return (activeDate != null);
  }


  /**
   *  Description of the Method
   *
   * @return    Description of the Returned Value
   * @since     1.17
   */
  public boolean hasRun() {
    return (statusId == FINISHED);
  }


  /**
   *  Description of the Method
   *
   * @return    Description of the Returned Value
   */
  public boolean hasFiles() {
    return (files > 0);
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @throws  SQLException  Description of Exception
   * @since                 1.10
   */
  public void buildRecipientCount(Connection db) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "SELECT count(id) " +
        "FROM scheduled_recipient sr " +
        "WHERE campaign_id = ? ");
    pst.setInt(1, id);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      this.setRecipientCount(rs.getInt(1));
    }
    rs.close();
    pst.close();
  }


  /**
   *  Builds the total number of people who responded to the survey Note :
   *  counts a person only once.
   *
   * @param  db             Description of the Parameter
   * @throws  SQLException  Description of the Exception
   */
  public void buildResponseCount(Connection db) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "SELECT count(sr.contact_id) AS reccount " +
        "FROM active_survey_responses sr, active_survey sa " +
        "WHERE campaign_id = ? " +
        "AND (sr.active_survey_id = sa.active_survey_id) " +
        "AND sa." + DatabaseUtils.addQuotes(db, "type") + " = ? ");
    pst.setInt(1, id);
    pst.setInt(2, Constants.SURVEY_REGULAR);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      this.setResponseCount(rs.getInt("reccount"));
    }
    rs.close();
    pst.close();
  }


  /**
   *  Builds the total number of people who responded to the address update
   *  request : counts a person only once.
   *
   * @param  db             Description of the Parameter
   * @throws  SQLException  Description of the Exception
   */
  public void buildAddressResponseCount(Connection db) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "SELECT count(sr.contact_id) AS reccount " +
        "FROM active_survey_responses sr, active_survey sa " +
        "WHERE campaign_id = ? " +
        "AND (sr.active_survey_id = sa.active_survey_id) " +
        "AND sa." + DatabaseUtils.addQuotes(db, "type") + " = ? ");
    pst.setInt(1, id);
    pst.setInt(2, Constants.SURVEY_ADDRESS_REQUEST);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      this.setAddressResponseCount(rs.getInt("reccount"));
    }
    rs.close();
    pst.close();
  }


  /**
   *  Fetches the time at which the last response for a survey was recieved
   *
   * @param  db             Description of the Parameter
   * @throws  SQLException  Description of the Exception
   */
  public void buildLastResponse(Connection db) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "SELECT max(sr.entered) AS lastresponse " +
        "FROM active_survey_responses sr, active_survey sa " +
        "WHERE campaign_id = ? " +
        "AND (sr.active_survey_id = sa.active_survey_id) " +
        "AND sa." + DatabaseUtils.addQuotes(db, "type") + " = ? ");
    pst.setInt(1, id);
    pst.setInt(2, Constants.SURVEY_REGULAR);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      this.setLastResponse(rs.getTimestamp("lastresponse"));
    }
    rs.close();
    pst.close();
  }


  /**
   *  Fetches the time at which the last response to an address update request
   *  was recieved
   *
   * @param  db             Description of the Parameter
   * @throws  SQLException  Description of the Exception
   */
  public void buildLastAddressResponse(Connection db) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "SELECT max(sr.entered) AS lastresponse " +
        "FROM active_survey_responses sr, active_survey sa " +
        "WHERE campaign_id = ? " +
        "AND (sr.active_survey_id = sa.active_survey_id) " +
        "AND sa." + DatabaseUtils.addQuotes(db, "type") + " = ? ");
    pst.setInt(1, id);
    pst.setInt(2, Constants.SURVEY_ADDRESS_REQUEST);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      this.setLastAddressResponse(rs.getTimestamp("lastresponse"));
    }
    rs.close();
    pst.close();
  }


  /**
   *  Retrieves the file id for this campaign. A file will exist if a campaign
   *  gets executed and is configured to output a file. For example, when the
   *  "letter" option is selected, a .zip file gets created in which the user
   *  can download.
   *
   * @param  db             Description of Parameter
   * @throws  SQLException  Description of Exception
   */
  public void buildFileCount(Connection db) throws SQLException {
    //All internal documents for a campaign
    files = FileItemList.retrieveRecordCount(
        db, Constants.COMMUNICATIONS_DOCUMENTS, id);
  }


  /**
   *  Builds all groups associated with the campaign.
   *
   * @param  db             Description of the Parameter
   * @throws  SQLException  Description of the Exception
   */
  public void buildGroups(Connection db) throws SQLException {
    ArrayList criteriaList = null;
    groups = new LinkedHashMap();
    PreparedStatement pst = db.prepareStatement(
        "SELECT groupname, groupcriteria " +
        "FROM active_campaign_groups " +
        "WHERE campaign_id = ? ");
    pst.setInt(1, id);
    ResultSet rs = pst.executeQuery();
    while (rs.next()) {
      String groupName = rs.getString("groupName");
      if (groups.containsKey(groupName)) {
        criteriaList = (ArrayList) groups.get(groupName);
      } else {
        criteriaList = new ArrayList();
        groups.put(groupName, criteriaList);
      }
      criteriaList.add(rs.getString("groupcriteria"));
    }
    rs.close();
    pst.close();
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @throws  SQLException  Description of the Exception
   */
  public void buildSurveyId(Connection db) throws SQLException {
    if (active) {
      surveyId = ActiveSurvey.getId(db, this.id, Constants.SURVEY_REGULAR);
    } else {
      surveyId = Survey.getId(db, this.id, Constants.SURVEY_REGULAR);
    }
  }


  /**
   *  Determines whether an address update request is attached with the campaign
   *
   * @param  db             Description of the Parameter
   * @throws  SQLException  Description of the Exception
   */
  public void buildHasAddressRequest(Connection db) throws SQLException {
    if (Survey.getId(db, this.id, Constants.SURVEY_ADDRESS_REQUEST) != -1) {
      this.setHasAddressRequest(true);
    } else if (ActiveSurvey.getId(
        db, this.id, Constants.SURVEY_ADDRESS_REQUEST) != -1) {
      this.setHasAddressRequest(true);
    } else {
      this.setHasAddressRequest(false);
    }
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @throws  SQLException  Description of the Exception
   */
  public void buildHasSurvey(Connection db) throws SQLException {
    if (Survey.getId(db, this.id, Constants.SURVEY_REGULAR) != -1) {
      this.setHasSurvey(true);
    } else
        if (ActiveSurvey.getId(db, this.id, Constants.SURVEY_REGULAR) != -1) {
      this.setHasSurvey(true);
    } else {
      this.setHasSurvey(false);
    }
  }


  /**
   *  Gets the ContactList attribute of the Campaign object
   *
   * @param  db             Description of Parameter
   * @throws  SQLException  Description of Exception
   * @since                 1.10
   */
  public void insertContactList(Connection db) throws SQLException {
    Iterator j = contactList.iterator();
    while (j.hasNext()) {
      Contact thisContact = (Contact) j.next();
      Recipient thisRecipient = new Recipient();
      thisRecipient.setCampaignId(this.getId());
      thisRecipient.setContactId(thisContact.getId());
      thisRecipient.insert(db);
    }
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @param  userId         Description of the Parameter
   * @param  userRangeId    Description of the Parameter
   * @throws  SQLException  Description of Exception
   */
  public void insertRecipients(Connection db, int userId, String userRangeId) throws SQLException {
    ContactList dummyList = this.getContactList();
    boolean addContacts = (dummyList.size() == 0);
    SearchCriteriaListList groupData = new SearchCriteriaListList();
    groupData.setCampaignId(this.id);
    groupData.setBuildCriteria(true);
    groupData.buildList(db);
    Iterator i = groupData.iterator();
    while (i.hasNext()) {
      SearchCriteriaList thisGroup = (SearchCriteriaList) i.next();
      ContactList groupContacts = new ContactList();
      groupContacts.setScl(thisGroup, userId, userRangeId);
      groupContacts.setBuildDetails(false);
      groupContacts.setBuildTypes(false);
      groupContacts.setCheckExcludedFromCampaign(this.getId());
      AccessTypeList gcAccessTypes = new AccessTypeList();
      gcAccessTypes.setLinkModuleId(AccessType.GENERAL_CONTACTS);
      gcAccessTypes.buildList(db);
      groupContacts.setGeneralContactAccessTypes(gcAccessTypes);
      groupContacts.buildList(db);
      if (System.getProperty("DEBUG") != null) {
        System.out.println(
            "Campaign-> GroupContacts has " + groupContacts.size() + " items");
      }
      Iterator j = groupContacts.iterator();
      while (j.hasNext()) {
        Contact thisContact = (Contact) j.next();
        if (thisContact.excludedFromCampaign() == false) {
          Recipient thisRecipient = new Recipient();
          thisRecipient.setCampaignId(this.getId());
          thisRecipient.setContactId(thisContact.getId());
          thisRecipient.insert(db);
          if (addContacts) {
            this.contactList.add(thisContact);
          }
        }
      }
    }
  }


  /**
   *  Sets the contacts attribute of the Campaign object
   *
   * @param  db             The new contacts value
   * @param  userId         The new contacts value
   * @param  userRangeId    The new contacts value
   * @throws  SQLException  Description of the Exception
   */
  public void setContacts(Connection db, int userId, String userRangeId) throws SQLException {
    ContactList dummyList = this.getContactList();
    boolean addContacts = (dummyList.size() == 0);
    if (!addContacts) {
      return;
    }
    SearchCriteriaListList groupData = new SearchCriteriaListList();
    groupData.setCampaignId(this.id);
    groupData.setBuildCriteria(true);
    groupData.buildList(db);
    Iterator i = groupData.iterator();
    while (i.hasNext()) {
      SearchCriteriaList thisGroup = (SearchCriteriaList) i.next();
      ContactList groupContacts = new ContactList();
      groupContacts.setScl(thisGroup, userId, userRangeId);
      groupContacts.setBuildDetails(false);
      groupContacts.setBuildTypes(false);
      groupContacts.setCheckExcludedFromCampaign(this.getId());
      AccessTypeList gcAccessTypes = new AccessTypeList();
      gcAccessTypes.setLinkModuleId(AccessType.GENERAL_CONTACTS);
      gcAccessTypes.buildList(db);
      groupContacts.setGeneralContactAccessTypes(gcAccessTypes);
      groupContacts.buildList(db);
      if (System.getProperty("DEBUG") != null) {
        System.out.println(
            "Campaign-> GroupContacts has " + groupContacts.size() + " items");
      }
      Iterator j = groupContacts.iterator();
      while (j.hasNext()) {
        Contact thisContact = (Contact) j.next();
        if (thisContact.excludedFromCampaign() == false) {
          this.contactList.add(thisContact);
        }
      }
    }
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   * @since                 1.5
   */
  public boolean insert(Connection db) throws SQLException {
    StringBuffer sql = new StringBuffer();
    boolean commit = true;
    try {
      commit = db.getAutoCommit();
      if (commit) {
        db.setAutoCommit(false);
      }
      id = DatabaseUtils.getNextSeq(db, "campaign_campaign_id_seq");
      sql.append(
          "INSERT INTO campaign " +
          "(enteredby, modifiedby, name, message_id, " +
          "reply_addr, subject, " + DatabaseUtils.addQuotes(db, "message") + ", send_method_id, " +
          "inactive_date, approval_date, " + DatabaseUtils.addQuotes(db, "type") + ", ");
      if (id > -1) {
        sql.append("campaign_id, ");
      }
      if (entered != null) {
        sql.append("entered, ");
      }
      sql.append("approvedby ) ");
      sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ");
      if (id > -1) {
        sql.append("?, ");
      }
      if (entered != null) {
        sql.append("?, ");
      }
      sql.append("?) ");
      int i = 0;
      PreparedStatement pst = db.prepareStatement(sql.toString());
      pst.setInt(++i, this.getEnteredBy());
      pst.setInt(++i, this.getModifiedBy());
      pst.setString(++i, this.getName());
      pst.setInt(++i, this.getMessageId());
      pst.setString(++i, replyTo);
      pst.setString(++i, subject);
      pst.setString(++i, message);
      pst.setInt(++i, sendMethodId);
      pst.setTimestamp(++i, inactiveDate);
      pst.setTimestamp(++i, approvalDate);
      pst.setInt(++i, type);
      if (id > -1) {
        pst.setInt(++i, id);
      }
      if (entered != null) {
        pst.setTimestamp(++i, entered);
      }
      DatabaseUtils.setInt(pst, ++i, this.getApprovedBy());
      pst.execute();
      pst.close();
      id = DatabaseUtils.getCurrVal(db, "campaign_campaign_id_seq", id);
      this.update(db, true);
      if (this.getGroupList() != null && !this.getGroupList().equals("")) {
        if (System.getProperty("DEBUG") != null) {
          System.out.println("Campaign-> GroupList: " + this.getGroupList());
        }
        StringBuffer groupSql = new StringBuffer();
        StringTokenizer strt = new StringTokenizer(this.getGroupList(), "*");
        PreparedStatement pstx = null;

        while (strt.hasMoreTokens()) {
          String tmpString = (String) strt.nextToken();
          groupSql.append(
              "INSERT INTO campaign_list_groups " +
              "(campaign_id, group_id ) " +
              "VALUES (?, ?) ");
          int j = 0;
          pstx = db.prepareStatement(groupSql.toString());
          pstx.setInt(++j, this.getId());
          pstx.setInt(++j, Integer.parseInt(tmpString));
          pstx.execute();
          pstx.close();
        }
      }
      parseUserGroups(db);
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
   *  Description of the Method
   *
   * @param  db                Description of the Parameter
   * @return                   Description of the Return Value
   * @exception  SQLException  Description of the Exception
   */
  public boolean parseUserGroups(Connection db) throws SQLException {
    CampaignUserGroupMapList oldList = new CampaignUserGroupMapList();
    oldList.setCampaignId(this.getId());
    oldList.buildList(db);
    if (oldList.size() > 0) {
      HashMap oldMap = oldList.createMapOfElements();
      HashMap mapOfElements = oldList.createMapOfElements();
      Iterator iter = null;
      if (userGroupMaps != null) {
        iter = (Iterator) userGroupMaps.iterator();
        while (iter.hasNext()) {
          CampaignUserGroupMap groupMap = (CampaignUserGroupMap) iter.next();
          // check if the mapping exists
          if (mapOfElements.get(new Integer(groupMap.getUserGroupId())) != null) {
            //remove from the userGroupMaps so that nothing is changed
            iter.remove();
            // remove it from oldMap so that the groupMap is not deleted
            Object tmp = oldMap.remove(new Integer(groupMap.getUserGroupId()));
          }
        }
      }
      //delete the rest of the userGroupMaps in the oldMap as they are not supposed to exist
      iter = (Iterator) oldMap.keySet().iterator();
      while (iter.hasNext()) {
        CampaignUserGroupMap toRemove = (CampaignUserGroupMap) oldMap.get((Integer) iter.next());
        toRemove.delete(db);
      }
    }
    // insert new mappings
    if (userGroupMaps != null) {
      userGroupMaps.setCampaignId(this.getId());
      userGroupMaps.insert(db);
    }

    //build a new list of userGroupMaps to include unchanged elements
    userGroupMaps = new CampaignUserGroupMapList();
    userGroupMaps.setCampaignId(this.getId());
    userGroupMaps.buildList(db);
    return true;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   * @since                 1.17
   */
  public boolean insertGroups(Connection db) throws SQLException {
    try {
      db.setAutoCommit(false);

      deleteAllGroups(db);

      if (this.getGroupList() != null && !this.getGroupList().equals("")) {
        StringTokenizer strt = new StringTokenizer(this.getGroupList(), "*");
        while (strt.hasMoreTokens()) {
          String tmpString = (String) strt.nextToken();

          PreparedStatement pstx = null;
          String groupSql =
              "INSERT INTO campaign_list_groups " +
              "(campaign_id, group_id ) " +
              "VALUES (?, ?) ";
          int j = 0;
          pstx = db.prepareStatement(groupSql);
          pstx.setInt(++j, this.getId());
          pstx.setInt(++j, Integer.parseInt(tmpString));
          pstx.execute();
          pstx.close();
        }
      }

      Statement st = db.createStatement();
      st.executeUpdate(
          "UPDATE campaign " +
          "SET modified = CURRENT_TIMESTAMP " +
          "WHERE campaign_id = " + id);
      //"WHERE id = " + id);
      st.close();

      db.commit();
    } catch (SQLException e) {
      db.rollback();
      throw new SQLException(e.getMessage());
    } finally {
      db.setAutoCommit(true);
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public boolean deleteAllGroups(Connection db) throws SQLException {
    PreparedStatement pstx = null;
    String groupSql =
        "DELETE FROM campaign_list_groups " +
        "WHERE campaign_id = ? ";
    int j = 0;
    pstx = db.prepareStatement(groupSql);
    pstx.setInt(++j, this.getId());
    pstx.execute();
    pstx.close();
    return true;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   * @since                 1.17
   */
  public boolean deleteGroups(Connection db) throws SQLException {
    try {
      db.setAutoCommit(false);
      if (this.getGroupList() != null && !this.getGroupList().equals("")) {
        StringTokenizer strt = new StringTokenizer(this.getGroupList(), "*");
        while (strt.hasMoreTokens()) {
          String tmpString = (String) strt.nextToken();
          PreparedStatement pstx = null;
          StringBuffer groupSql = new StringBuffer();
          groupSql.append(
              "DELETE FROM campaign_list_groups " +
              "WHERE campaign_id = ? " +
              "AND group_id = ? ");
          int j = 0;
          pstx = db.prepareStatement(groupSql.toString());
          pstx.setInt(++j, this.getId());
          pstx.setInt(++j, Integer.parseInt(tmpString));
          pstx.execute();
          pstx.close();
        }

        Statement st = db.createStatement();
        st.executeUpdate(
            "UPDATE campaign " +
            "SET modified = CURRENT_TIMESTAMP " +
            "WHERE campaign_id = " + id);
        //"WHERE id = " + id);
        st.close();
      }
      db.commit();
    } catch (SQLException e) {
      db.rollback();
      throw new SQLException(e.getMessage());
    } finally {
      db.setAutoCommit(true);
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   * @since                 1.5
   */
  public int update(Connection db) throws SQLException {
    int resultCount = -1;

    try {
      db.setAutoCommit(false);
      resultCount = this.update(db, false);
      db.commit();
    } catch (Exception e) {
      db.rollback();
      throw new SQLException(e.getMessage());
    } finally {
      db.setAutoCommit(true);
    }
    return resultCount;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public DependencyList processDependencies(Connection db) throws SQLException {
    DependencyList dependencyList = new DependencyList();

    //Check for attached survey
    int activeSurveyId = (ActiveSurvey.getId(db, id, Constants.SURVEY_REGULAR));
    if (activeSurveyId > -1) {
      Dependency dependency = new Dependency();
      dependency.setName("activeSurvey");
      dependency.setCount(1);
      dependency.setCanDelete(false);
      dependencyList.add(dependency);
    }

    //Check for address request
    int addressSurveyId = (ActiveSurvey.getId(
        db, id, Constants.SURVEY_ADDRESS_REQUEST));
    if (addressSurveyId > -1) {
      Dependency dependency = new Dependency();
      dependency.setName("addressRequest");
      dependency.setCount(1);
      dependency.setCanDelete(false);
      dependencyList.add(dependency);
    }
    return dependencyList;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @param  baseFilePath   Description of the Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   * @since                 1.5
   */
  public boolean delete(Connection db, String baseFilePath) throws SQLException {
    PreparedStatement pst = null;
    SQLException message = null;
    boolean commit = db.getAutoCommit();
    try {
      if (commit) {
        db.setAutoCommit(false);
      }
      //make sure there arent any  for instant action campaigns
      ActionItemLog.deleteLink(db, this.getId(), Constants.CAMPAIGN_OBJECT);

      //Delete the user group mappings for the campaign
      this.setBuildGroupMaps(true);
      this.buildUserGroupMaps(db);
      this.getUserGroupMaps().delete(db);

      pst = db.prepareStatement(
          "DELETE FROM campaign_list_groups WHERE campaign_id = ? ");
      pst.setInt(1, this.getId());
      pst.execute();
      pst.close();

      pst = db.prepareStatement(
          "DELETE FROM scheduled_recipient WHERE campaign_id = ? ");
      pst.setInt(1, this.getId());
      pst.execute();
      pst.close();

      pst = db.prepareStatement(
          "DELETE FROM campaign_run WHERE campaign_id = ? ");
      pst.setInt(1, this.getId());
      pst.execute();
      pst.close();

      pst = db.prepareStatement(
          "DELETE FROM excluded_recipient WHERE campaign_id = ? ");
      pst.setInt(1, this.getId());
      pst.execute();
      pst.close();

      //Delete any inactive survey links
      pst = db.prepareStatement(
          "DELETE FROM campaign_survey_link WHERE campaign_id = ? ");
      pst.setInt(1, this.getId());
      pst.execute();
      pst.close();

      //Delete the attached survey
      int activeSurveyId = (ActiveSurvey.getId(
          db, id, Constants.SURVEY_REGULAR));
      if (activeSurveyId > -1) {
        ActiveSurvey thisSurvey = new ActiveSurvey(db, activeSurveyId);
        thisSurvey.delete(db);
      }
      //Delete the attached address request
      int addSurveyId = (ActiveSurvey.getId(
          db, id, Constants.SURVEY_ADDRESS_REQUEST));
      if (addSurveyId > -1) {
        ActiveSurvey thisSurvey = new ActiveSurvey(db, addSurveyId);
        thisSurvey.delete(db);
      }

      //Delete any attached documents
      FileItemList fileList = new FileItemList();
      fileList.setLinkModuleId(Constants.COMMUNICATIONS_FILE_ATTACHMENTS);
      fileList.setLinkItemId(id);
      fileList.buildList(db);
      fileList.delete(db, baseFilePath + "communications" + Constants.fs);
      fileList = null;

      //Delete any dashboard documents, included exported recipients
      FileItemList docList = new FileItemList();
      docList.setLinkModuleId(Constants.COMMUNICATIONS_DOCUMENTS);
      docList.setLinkItemId(id);
      docList.buildList(db);
      docList.delete(db, baseFilePath + "campaign" + Constants.fs);
      docList = null;

      ActionStepList stepList = new ActionStepList();
      stepList.setCampaignId(this.getId());
      stepList.buildList(db);
      stepList.resetCampaignInformation(db);

      ContactHistory.deleteObject(db, OrganizationHistory.CAMPAIGN, this.getId());
      
      //Deleting Active Campaign Groups
      pst = db.prepareStatement(
          "DELETE FROM active_campaign_groups WHERE campaign_id = ? ");
      pst.setInt(1, this.getId());
      pst.execute();

      pst = db.prepareStatement("DELETE FROM campaign WHERE campaign_id = ? ");
      //"DELETE FROM campaign WHERE id = ? ");
      pst.setInt(1, this.getId());
      pst.execute();
      pst.close();
      if (commit) {
        db.commit();
      }
    } catch (SQLException e) {
      if (commit) {
        db.rollback();
      }
      message = e;
    } finally {
      if (commit) {
        db.setAutoCommit(true);
      }
    }
    if (message != null) {
      throw new SQLException(message.getMessage());
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   * @since                 1.17
   */
  public int cancel(Connection db) throws SQLException {
    if (this.getId() == -1) {
      throw new SQLException("Campaign ID was not specified");
    }
    boolean commit = true;
    int resultCount = 0;
    int activeRecipients = 0;
    PreparedStatement pst = null;
    try {
      commit = db.getAutoCommit();
      if (commit) {
        db.setAutoCommit(false);
      }
      pst = db.prepareStatement(
          "SELECT count(*) AS activecount " +
          "FROM scheduled_recipient " +
          "WHERE campaign_id = ? " +
          "AND sent_date IS NOT NULL ");
      pst.setInt(1, this.getId());
      ResultSet rs = pst.executeQuery();
      if (rs.next()) {
        activeRecipients = rs.getInt("activecount");
      }
      rs.close();
      pst.close();
      if (activeRecipients <= 0) {
        pst = db.prepareStatement(
            "UPDATE campaign " +
            "SET status_id = ?, " +
            "status = ?, " +
            "" + DatabaseUtils.addQuotes(db, "active") + " = ?, " +
            "modifiedby = ?, " +
            "modified = CURRENT_TIMESTAMP " +
            "WHERE campaign_id = ? " +
            "AND status_id IN (" + QUEUE + ", " + ERROR + ") ");
        int i = 0;
        pst.setInt(++i, CANCELED);
        pst.setString(++i, CANCELED_TEXT);
        pst.setBoolean(++i, false);
        pst.setInt(++i, modifiedBy);
        pst.setInt(++i, id);
        resultCount = pst.executeUpdate();
        pst.close();
      }
      if (resultCount == 1) {
        pst = db.prepareStatement(
            "DELETE FROM scheduled_recipient " +
            "WHERE campaign_id = ? " +
            "AND sent_date IS NULL ");
        pst.setInt(1, id);
        pst.execute();
        pst.close();

        pst = db.prepareStatement(
            "DELETE FROM active_campaign_groups " +
            "WHERE campaign_id = ? ");
        pst.setInt(1, id);
        pst.execute();
        pst.close();

        //Remove attached survey if campaign has one
        int activeSurveyId = ActiveSurvey.getId(
            db, id, Constants.SURVEY_REGULAR);
        if (activeSurveyId > -1) {
          ActiveSurvey activeSurvey = new ActiveSurvey(db, activeSurveyId);
          activeSurvey.delete(db);
        }
        //Remove address request if campaign has one
        int addSurveyId = ActiveSurvey.getId(
            db, id, Constants.SURVEY_ADDRESS_REQUEST);
        if (addSurveyId > -1) {
          ActiveSurvey activeSurvey = new ActiveSurvey(db, addSurveyId);
          activeSurvey.delete(db);
        }
      }

      if (commit) {
        db.commit();
      }
    } catch (SQLException e) {
      if (commit) {
        db.rollback();
      }
      throw new SQLException(e.toString());
    } finally {
      if (commit) {
        db.setAutoCommit(true);
      }
      pst.close();
    }
    return resultCount;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @param  userId         Description of the Parameter
   * @param  userRangeId    Description of the Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   * @since                 1.17
   */
  public int activate(Connection db, int userId, String userRangeId) throws SQLException {
    int resultCount = 0;
    if (this.getId() == -1) {
      throw new SQLException("Campaign ID was not specified");
    }
    boolean commit = false;
    PreparedStatement pst = null;
    try {
      commit = db.getAutoCommit();
      if (commit) {
        db.setAutoCommit(false);
      }
      //See if the campaign is not already active
      StringBuffer sql = new StringBuffer(
          "UPDATE campaign " +
          "SET status_id = ?, " +
          "status = ?, ");
      //Used for instant campaigns
      if (cc != null && !"".equals(cc)) {
        sql.append("cc = ?, ");
      }
      //Used for instant campaigns
      if (bcc != null && !"".equals(bcc)) {
        sql.append("bcc = ?, ");
      }
      sql.append(
          "modifiedby = ?, " +
          "modified = CURRENT_TIMESTAMP " +
          "WHERE campaign_id = ? " +
      //"WHERE id = ? " +
          "AND modified " + ((this.getModified() == null)?"IS NULL ":"= ? ") +
          "AND " + DatabaseUtils.addQuotes(db, "active") + " = ? ");
      pst = db.prepareStatement(sql.toString());
      int i = 0;
      pst.setInt(++i, QUEUE);
      pst.setString(++i, QUEUE_TEXT);
      //Used for instant campaigns
      if (cc != null && !"".equals(cc)) {
        pst.setString(++i, cc);
      }
      //Used for instant campaigns
      if (bcc != null && !"".equals(bcc)) {
        pst.setString(++i, bcc);
      }
      pst.setInt(++i, modifiedBy);
      pst.setInt(++i, id);
      if(this.getModified() != null){
        pst.setTimestamp(++i, modified);
      }
      pst.setBoolean(++i, false);
      resultCount = pst.executeUpdate();
      pst.close();

      //Activate the campaign...
      if (resultCount == 1) {
        active = true;
        //Lock in the recipients
        insertRecipients(db, userId, userRangeId);

        //Lock in the survey
        if (this.surveyId > -1) {
          Survey thisSurvey = new Survey(db, surveyId);
          ActiveSurvey activeSurvey = new ActiveSurvey(thisSurvey);
          activeSurvey.setEnteredBy(userId);
          activeSurvey.setModifiedBy(userId);
          activeSurvey.setCampaignId(id);
          activeSurvey.insert(db);
          this.surveyId = activeSurvey.getId();
        }
        if (this.hasAddressRequest) {
          Survey thisSurvey = new Survey(db, Survey.getAddressSurveyId(db));
          ActiveSurvey activeSurvey = new ActiveSurvey(thisSurvey);
          activeSurvey.setEnteredBy(userId);
          activeSurvey.setModifiedBy(userId);
          activeSurvey.setCampaignId(id);
          activeSurvey.insert(db);
          this.addressSurveyId = activeSurvey.getId();
        }

        //Lock in the message
        Message thisMessage = new Message(db, this.getMessageId());

        //Lock in the groups & criteria
        SearchCriteriaListList thisList = new SearchCriteriaListList();
        thisList.setCampaignId(id);
        thisList.setBuildCriteria(true);
        thisList.buildList(db);
        lockGroupCriteria(thisList, db);

        //Replace tags
        Template template = new Template();
        if (this.surveyId > -1) {
          template.addParseElement(
              "${survey_url}", "<a href=\"http://" + this.getServerName() + "/ProcessSurvey.do?id=${surveyId=" + this.getActiveSurveyId() + "}\">http://" + this.getServerName() + "/ProcessSurvey.do?id=${surveyId=" + this.getActiveSurveyId() + "}</a>");
          if (thisMessage.getMessageText().indexOf("${survey_url}") == -1) {
            template.setText(
                thisMessage.getMessageText() + "<br><br>You can take the survey at the following web-site:<br />${survey_url}");
            thisMessage.setMessageText(
                thisMessage.getMessageText() + "<br><br>You can take the survey at the following web-site:<br />${survey_url}");
          } else {
            template.setText(thisMessage.getMessageText());
          }
        }
        if (this.hasAddressRequest) {
          thisMessage.setMessageText(
              thisMessage.getMessageText() + "<br />" +
              "${server_name=" + serverName + "}" + "<br />" +
              "${contact_address=" + addressSurveyId + "}" + "<br />" +
              "${survey_url_address=" + addressSurveyId + "}");
          template.setText(thisMessage.getMessageText());
        }
        if ((this.surveyId == -1) && (!this.hasAddressRequest)) {
          template.addParseElement(
              "${received_confirmation_url}", "<a href=\"http://" + this.getServerName() + "/ProcessCampaignConfirmation.do?id=${campaignId=" + this.getId() + "}\">here</a>");
          thisMessage.setMessageText(
              thisMessage.getMessageText() + "<br><br>Please click ${received_confirmation_url} to confirm that you have received the message!");
          template.setText(thisMessage.getMessageText());
        }
        //Finalize the campaign activation
        pst = db.prepareStatement(
            "UPDATE campaign " +
            "SET " + DatabaseUtils.addQuotes(db, "active") + " = ?, " +
            "reply_addr = ?, " +
            "subject = ?, " +
            "" + DatabaseUtils.addQuotes(db, "message") + " = ?, " +
            "modifiedby = ?, " +
            "modified = CURRENT_TIMESTAMP " +
            "WHERE campaign_id = ? ");
        //"WHERE id = ? ");
        i = 0;
        pst.setBoolean(++i, true);
        pst.setString(++i, thisMessage.getReplyTo());
        pst.setString(++i, thisMessage.getMessageSubject());
        pst.setString(++i, template.getParsedText());
        pst.setInt(++i, modifiedBy);
        pst.setInt(++i, id);
        resultCount = pst.executeUpdate();
        pst.close();
      }
      if (commit) {
        db.commit();
      }
    } catch (SQLException e) {
      if (commit) {
        db.rollback();
      }
      throw new SQLException(e.getMessage());
    } catch (Exception ee) {
      if (commit) {
        db.rollback();
      }
      throw new SQLException(ee.getMessage());
    } finally {
      if (commit) {
        db.setAutoCommit(true);
      }
    }
    return resultCount;
  }


  /**
   *  Makes a copy of the groups associated with this Campaign.
   *
   * @param  groups         Description of the Parameter
   * @param  db             Description of the Parameter
   * @throws  SQLException  Description of the Exception
   */
  public void lockGroupCriteria(SearchCriteriaListList groups, Connection db) throws SQLException {
    Iterator i = groups.iterator();
    while (i.hasNext()) {
      SearchCriteriaList thisList = (SearchCriteriaList) i.next();
      HashMap thisArray = thisList.getCriteriaTextArray();
      Iterator j = thisArray.keySet().iterator();
      while (j.hasNext()) {
        String criteria = (String) thisArray.get(j.next());
        int k = 0;
        int seqId = DatabaseUtils.getNextSeq(
            db, "active_campaign_groups_id_seq");
        PreparedStatement pst =
            db.prepareStatement(
            "INSERT INTO active_campaign_groups " +
            "(" + (seqId > -1 ? "id, " : "") + "campaign_id, groupname, groupcriteria )" +
            "VALUES (" + (seqId > -1 ? "?, " : "") + "?, ?, ?) ");
        if (seqId > -1) {
          pst.setInt(++k, seqId);
        }
        pst.setInt(++k, id);
        pst.setString(++k, thisList.getGroupName());
        pst.setString(++k, criteria);
        pst.execute();
        pst.close();
      }
    }
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   * @since                 1.17
   */
  public int insertRun(Connection db) throws SQLException {
    CampaignRun thisRun = new CampaignRun();
    thisRun.setCampaignId(this.getId());
    thisRun.setTotalContacts(this.getRecipientCount());
    thisRun.setTotalSent(this.getSentCount());
    thisRun.insert(db);
    return thisRun.getId();
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   * @since                 1.17
   */
  public int updateDetails(Connection db) throws SQLException {
    if (this.getId() == -1) {
      throw new SQLException("Campaign ID was not specified");
    }
    int resultCount = 0;

    PreparedStatement pst = null;
    pst = db.prepareStatement(
        "UPDATE campaign " +
        "SET name = ?, " +
        "description = ?, " +
        "modifiedby = ?, " +
        "modified = CURRENT_TIMESTAMP " +
        "WHERE campaign_id = " + id);
    //"WHERE id = " + id);
    int i = 0;
    pst.setString(++i, name);
    pst.setString(++i, description);
    pst.setInt(++i, modifiedBy);
    resultCount = pst.executeUpdate();
    pst.close();
    this.parseUserGroups(db);
    return resultCount;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   * @since                 1.17
   */
  public int updateMessage(Connection db) throws SQLException {
    if (this.getId() == -1) {
      throw new SQLException("Campaign ID was not specified");
    }

    int resultCount = 0;

    PreparedStatement pst = null;
    int i = 0;
    pst = db.prepareStatement(
        "UPDATE campaign " +
        "SET message_id = ?, " +
        "reply_addr = null, " +
        "subject = null, " +
        "" + DatabaseUtils.addQuotes(db, "message") + " = null, " +
        "modifiedby = ?, " +
        "modified = CURRENT_TIMESTAMP " +
        "WHERE campaign_id = ? ");
    //"WHERE id = ? ");
    pst.setInt(++i, messageId);
    pst.setInt(++i, modifiedBy);
    pst.setInt(++i, id);
    resultCount = pst.executeUpdate();
    pst.close();

    return resultCount;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public int updateSurvey(Connection db) throws SQLException {
    if (this.getId() == -1) {
      throw new SQLException("Campaign ID was not specified");
    }
    int resultCount = 0;
    PreparedStatement pst = null;
    try {
      db.setAutoCommit(false);
      pst = db.prepareStatement(
          "UPDATE campaign " +
          "SET modifiedby = ?, " +
          "modified = CURRENT_TIMESTAMP " +
          "WHERE campaign_id = ? ");
      pst.setInt(1, modifiedBy);
      pst.setInt(2, this.id);
      resultCount = pst.executeUpdate();
      pst.close();

      //Fetching the survey Id that need to be deleted and removing it from the campaign
      int tmpSurveyId = Survey.getId(db, this.id, Constants.SURVEY_REGULAR);
      pst = db.prepareStatement(
          "DELETE FROM campaign_survey_link WHERE campaign_id = ? AND survey_id = ? ");
      pst.setInt(1, id);
      pst.setInt(2, tmpSurveyId);
      pst.execute();
      pst.close();

      //Inserting the new survey (i.e, associating it with the campaign)
      if (surveyId > -1) {
        pst = db.prepareStatement(
            "INSERT INTO campaign_survey_link " +
            "(campaign_id, survey_id) VALUES (?, ?) ");
        pst.setInt(1, id);
        pst.setInt(2, surveyId);
        pst.execute();
      }
      pst.close();
      db.commit();
    } catch (SQLException e) {
      db.rollback();
      throw new SQLException(e.getMessage());
    } finally {
      db.setAutoCommit(true);
    }
    return resultCount;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public int updateAddressRequest(Connection db) throws SQLException {
    if (this.getId() == -1) {
      throw new SQLException("Campaign ID was not specified");
    }

    int resultCount = 0;

    PreparedStatement pst = null;
    try {
      db.setAutoCommit(false);

      pst = db.prepareStatement(
          "UPDATE campaign " +
          "SET modifiedby = ?, " +
          "modified = CURRENT_TIMESTAMP " +
          "WHERE campaign_id = ? ");
      pst.setInt(1, modifiedBy);
      pst.setInt(2, id);
      resultCount = pst.executeUpdate();

      //Fetching the survey Id's that need to be deleted
      int tmpSurveyId = Survey.getId(
          db, this.id, Constants.SURVEY_ADDRESS_REQUEST);
      pst = db.prepareStatement(
          "DELETE FROM campaign_survey_link WHERE campaign_id = ? AND survey_id = ? ");
      pst.setInt(1, id);
      pst.setInt(2, tmpSurveyId);
      pst.execute();
      pst.close();

      if (hasAddressRequest) {
        if (surveyId > -1) {
          pst = db.prepareStatement(
              "INSERT INTO campaign_survey_link " +
              "(campaign_id, survey_id) VALUES (?, ?) ");
          pst.setInt(1, id);
          pst.setInt(2, surveyId);
          pst.execute();
          pst.close();
        }
      }
      db.commit();
    } catch (SQLException e) {
      db.rollback();
      throw new SQLException(e.getMessage());
    } finally {
      db.setAutoCommit(true);
    }
    return resultCount;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   * @since                 1.17
   */
  public int updateSchedule(Connection db) throws SQLException {
    int resultCount = 0;
    if (this.getId() == -1) {
      throw new SQLException("Campaign ID was not specified");
    }
    PreparedStatement pst = null;
    int i = 0;
    pst = db.prepareStatement(
        "UPDATE campaign " +
        "SET message_id = ?, " +
        "active_date = ?, active_date_timezone = ?, " +
        "send_method_id = ?, " +
        "modified = CURRENT_TIMESTAMP " +
        "WHERE campaign_id = " + id);
    //"WHERE id = " + id);
    pst.setInt(++i, messageId);
    pst.setTimestamp(++i, activeDate);
    pst.setString(++i, activeDateTimeZone);
    pst.setInt(++i, sendMethodId);
    resultCount = pst.executeUpdate();
    pst.close();
    return resultCount;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of Parameter
   * @param  override       Description of Parameter
   * @return                Description of the Returned Value
   * @throws  SQLException  Description of Exception
   * @since                 1.5
   */
  protected int update(Connection db, boolean override) throws SQLException {
    int resultCount = 0;

    if (this.getId() == -1) {
      throw new SQLException("Campaign ID was not specified");
    }

    if (status == null) {
      if (active) {
        this.setStatusId(QUEUE);
      } else {
        this.setStatusId(IDLE);
      }
    }

    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();
    sql.append(
        "UPDATE campaign " +
        "SET description = ?, active_date = ?, active_date_timezone = ?, " +
        "enabled = ?, trashed_date = ?, ");
    if (cc != null && !"".equals(cc)) {
      sql.append("cc = ?, ");
    }
    if (bcc != null && !"".equals(bcc)) {
      sql.append("bcc = ?, ");
    }
    if (override && modified != null) {
      sql.append("modified = ?, ");
    } else {
      sql.append("modified = CURRENT_TIMESTAMP, ");
    }
    sql.append(
        "modifiedby = ?, " +
        "" + DatabaseUtils.addQuotes(db, "active") + " = ?, status_id = ?, status = ?, message_id = ? " +
        "WHERE campaign_id = ? ");
    int i = 0;
    pst = db.prepareStatement(sql.toString());
    pst.setString(++i, this.getDescription());
    DatabaseUtils.setTimestamp(pst, ++i, this.getActiveDate());
    pst.setString(++i, this.getActiveDateTimeZone());
    pst.setBoolean(++i, this.getEnabled());
    DatabaseUtils.setTimestamp(pst, ++i, this.getTrashedDate());
    if (cc != null && !"".equals(cc)) {
      pst.setString(++i, cc);
    }
    if (bcc != null && !"".equals(bcc)) {
      pst.setString(++i, bcc);
    }
    if (override && modified != null) {
      pst.setTimestamp(++i, modified);
    }
    pst.setInt(++i, this.getModifiedBy());
    pst.setBoolean(++i, this.getActive());
    pst.setInt(++i, this.getStatusId());
    pst.setString(++i, this.getStatus());
    pst.setInt(++i, this.getMessageId());
    pst.setInt(++i, this.getId());
    resultCount = pst.executeUpdate();
    pst.close();
    //The original survey is no longer needed
    if (statusId == FINISHED) {
      Survey.removeLink(db, this.id);
    }
    parseUserGroups(db);
    return resultCount;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @param  toTrash        Description of the Parameter
   * @param  tmpUserId      Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public boolean updateStatus(Connection db, boolean toTrash, int tmpUserId) throws SQLException {
    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();
    sql.append(
        "UPDATE campaign " +
        "SET trashed_date = ? , " +
        "modified = " + DatabaseUtils.getCurrentTimestamp(db) + " , " +
        "modifiedby = ? " +
        "WHERE campaign_id = ? ");
    int i = 0;
    pst = db.prepareStatement(sql.toString());
    if (toTrash) {
      DatabaseUtils.setTimestamp(
          pst, ++i, new Timestamp(System.currentTimeMillis()));
    } else {
      DatabaseUtils.setTimestamp(pst, ++i, (Timestamp) null);
    }
    DatabaseUtils.setInt(pst, ++i, tmpUserId);
    pst.setInt(++i, this.getId());
    pst.executeUpdate();
    pst.close();

    //Delete the user group mappings for the campaign
    this.setBuildGroupMaps(true);
    this.buildUserGroupMaps(db);
    this.getUserGroupMaps().delete(db);

    ActionStepList stepList = new ActionStepList();
    stepList.setCampaignId(this.getId());
    stepList.buildList(db);
    stepList.resetCampaignInformation(db);
    
    // remove link to instant action campaigns
    ActionItemLog.deleteLink(db, this.getId(), Constants.CAMPAIGN_OBJECT);

    ContactHistory.deleteObject(db, OrganizationHistory.CAMPAIGN, this.getId());

    return true;
  }


  /**
   *  Description of the Method
   *
   * @param  rs             Description of Parameter
   * @throws  SQLException  Description of Exception
   * @since                 1.5
   */
  protected void buildRecord(ResultSet rs) throws SQLException {
    //campaign table
    this.setId(rs.getInt("campaign_id"));
    name = rs.getString("name");
    description = rs.getString("description");
    groupId = rs.getInt("list_id");
    messageId = rs.getInt("message_id");
    replyTo = rs.getString("reply_addr");
    subject = rs.getString("subject");
    message = rs.getString("message");
    statusId = rs.getInt("status_id");
    status = rs.getString("status");
    active = rs.getBoolean("active");
    activeDate = rs.getTimestamp("active_date");
    sendMethodId = rs.getInt("send_method_id");
    inactiveDate = rs.getTimestamp("inactive_date");
    approvalDate = rs.getTimestamp("approval_date");
    approvedBy = DatabaseUtils.getInt(rs, "approvedBy");
    enabled = rs.getBoolean("enabled");
    entered = rs.getTimestamp("entered");
    enteredBy = rs.getInt("enteredby");
    modified = rs.getTimestamp("modified");
    modifiedBy = rs.getInt("modifiedby");
    type = rs.getInt("type");
    activeDateTimeZone = rs.getString("active_date_timezone");
    cc = rs.getString("cc");
    bcc = rs.getString("bcc");
    trashedDate = rs.getTimestamp("trashed_date");
    //message table
    messageName = rs.getString("messageName");
    messageSubject = rs.getString("messageSubject");
    //lookup_delivery_options table
    deliveryType = rs.getInt("deliveryType");
    deliveryName = rs.getString("deliveryTypeName");
  }


  /**
   *  This method is called when the notifier begins processing a campaign. If
   *  lockProcess returns a 1, then it was successful and this instance of the
   *  notifier can execute the campaign. If lockProcess is not successful then
   *  the notifier should skip this campaign because another instance may have
   *  processed this one already.
   *
   * @param  db             Description of the Parameter
   * @return                1 if successfully locked
   * @throws  SQLException  Description of the Exception
   */
  public int lockProcess(Connection db) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "UPDATE campaign " +
        "SET status_id = ? " +
        "WHERE campaign_id = ? " +
        "AND status_id = ? ");
    pst.setInt(1, statusId);
    pst.setInt(2, id);
    pst.setInt(3, Campaign.QUEUE);
    int count = pst.executeUpdate();
    pst.close();
    return count;
  }


  /**
   *  Returns the user who entered a campaign, useful for checking the authority
   *  of a campaign record
   *
   * @param  db             Description of the Parameter
   * @param  campaignId     Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public final static int queryEnteredBy(Connection db, int campaignId) throws SQLException {
    int enteredBy = -1;
    PreparedStatement pst = db.prepareStatement(
        "SELECT enteredby " +
        "FROM campaign " +
        "WHERE campaign_id = ? ");
    pst.setInt(1, campaignId);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      enteredBy = rs.getInt("enteredby");
    }
    rs.close();
    pst.close();
    return enteredBy;
  }


  /**
   *  Gets the userIdParams attribute of the Campaign class
   *
   * @return    The userIdParams value
   */
  public static ArrayList getUserIdParams() {
    ArrayList thisList = new ArrayList();
    thisList.add("enteredBy");
    thisList.add("modifiedBy");
    thisList.add("owner");
    return thisList;
  }


  /**
   *  Gets the properties that are TimeZone sensitive for a Call
   *
   * @return    The timeZoneParams value
   */
  public static ArrayList getTimeZoneParams() {
    ArrayList thisList = new ArrayList();
    thisList.add("activeDate");
    thisList.add("inactiveDate");
    return thisList;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @param  tmpUserId      Description of the Parameter
   * @param  password       Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public static boolean authenticateForBroadcast(Connection db, int tmpUserId, String password) throws SQLException {
    String pw = "";
    String encryptedPassword = PasswordHash.encrypt(password);
    PreparedStatement pst = db.prepareStatement(
        "SELECT a.password " +
        "FROM " + DatabaseUtils.addQuotes(db, "access") + " a " +
        "WHERE user_id = ? " +
        "AND a.enabled = ? ");
    pst.setInt(1, tmpUserId);
    pst.setBoolean(2, true);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      pw = rs.getString("password");
    }
    rs.close();
    pst.close();
    if (pw == null || pw.trim().equals("") || !pw.equals(encryptedPassword)) {
      return false;
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   * @param  db                Description of the Parameter
   * @return                   Description of the Return Value
   * @exception  SQLException  Description of the Exception
   */
  public boolean restartCampaign(Connection db) throws SQLException {
    if (this.getId() == -1) {
      throw new SQLException("Campaign ID required to restart the campaign");
    }
    String currentTimestamp = DatabaseUtils.getCurrentTimestamp(db);
    PreparedStatement pst = db.prepareStatement(
        "UPDATE campaign SET " +
        "status_id = ?, " +
        "status = ?, " +
        "active_date = " + currentTimestamp + " " +
        "WHERE campaign_id = ? ");
    pst.setInt(1, Campaign.QUEUE);
    pst.setString(2, Campaign.QUEUE_TEXT);
    pst.setInt(3, this.getId());
    pst.executeUpdate();
    pst.close();
    return true;
  }
}

