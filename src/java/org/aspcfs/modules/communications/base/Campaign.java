package com.darkhorseventures.cfsbase;

import org.theseus.beans.*;
import java.util.*;
import java.sql.*;
import java.text.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.darkhorseventures.utils.DatabaseUtils;
import com.darkhorseventures.utils.Template;

/**
 *  Description of the Class
 *
 *@author     Wesley_S_Gillette
 *@created    November 16, 2001
 *@version    $Id$
 */
public class Campaign extends GenericBean {

  public final static int IDLE = 1;
  public final static int QUEUE = 2;
  public final static int STARTED = 3;
  public final static int FINISHED = 4;
  public final static int ERROR = 5;
  public final static int CANCELLED = 6;

  public final static String IDLE_TEXT = "Idle";
  public final static String QUEUE_TEXT = "In Queue";
  public final static String STARTED_TEXT = "Sending Messages";
  public final static String FINISHED_TEXT = "Messages Sent";
  public final static String ERROR_TEXT = "Error in Campaign";
  public final static String CANCELLED_TEXT = "Cancelled";

  private int id = -1;
  private String name = null;
  private String description = null;
  private int messageId = -1;
  private int groupId = -1;
  private int runId = -1;
  private int statusId = -1;
  private int owner = -1;
  private java.sql.Timestamp entered = null;
  private int enteredBy = -1;
  private java.sql.Timestamp modified = null;
  private int modifiedBy = -1;
  private boolean enabled = true;
  private java.sql.Date activeDate = null;
  private String groupList = "";
  private int groupCount = -1;
  private String status = null;
  private boolean active = false;
  private String messageName = "";
  private int recipientCount = -1;
  private int sentCount = -1;
  private ContactList contactList = null;
  private String replyTo = null;
  private String subject = null;
  private String message = null;
  private int sendMethodId = -1;
  private String deliveryName = null;
  private int files = 0;

  private int surveyId = -1;
  private String serverName = "";


  /**
   *  Constructor for the Campaign object
   *
   *@since    1.1
   */
  public Campaign() { }


  /**
   *  Constructor for the Campaign object
   *
   *@param  rs                Description of Parameter
   *@exception  SQLException  Description of Exception
   *@since                    1.1
   */
  public Campaign(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }


  /**
   *  Gets the surveyId attribute of the Campaign object
   *
   *@return    The surveyId value
   */
  public int getSurveyId() {
    return surveyId;
  }
  
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
   *@param  surveyId  The new surveyId value
   */
  public void setSurveyId(int surveyId) {
    this.surveyId = surveyId;
  }


  /**
   *  Sets the surveyId attribute of the Campaign object
   *
   *@param  surveyId  The new surveyId value
   */
  public void setSurveyId(String surveyId) {
    this.surveyId = Integer.parseInt(surveyId);
  }


  /**
   *  Constructor for the Campaign object
   *
   *@param  db                Description of Parameter
   *@param  campaignId        Description of Parameter
   *@exception  SQLException  Description of Exception
   *@since                    1.1
   */
  public Campaign(Connection db, String campaignId) throws SQLException {
    if (campaignId == null) {
      throw new SQLException("Campaign ID not specified.");
    }
    PreparedStatement pst = null;
    ResultSet rs = null;

    String sql = 
      "SELECT c.*, msg.name as messageName, dt.description as delivery " +
      "FROM campaign c " +
      "LEFT JOIN message msg ON (c.message_id = msg.id) " +
      "LEFT JOIN lookup_delivery_options dt ON (c.send_method_id = dt.code) " +
      "WHERE c.campaign_id = ? ";
    pst = db.prepareStatement(sql);
    pst.setInt(1, Integer.parseInt(campaignId));
    rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    } else {
      rs.close();
      pst.close();
      throw new SQLException("Campaign record not found.");
    }
    rs.close();
    pst.close();

    buildRecipientCount(db);
    buildSurveyId(db);
    setGroupList(db);
    buildFileCount(db);
  }


  /**
   *  Sets the ContactList attribute of the Campaign object
   *
   *@param  contactList  The new ContactList value
   *@since               1.10
   */
  public void setContactList(ContactList contactList) {
    this.contactList = contactList;
  }


  /**
   *  Sets the RecipientCount attribute of the Campaign object
   *
   *@param  recipientCount  The new RecipientCount value
   *@since                  1.17
   */
  public void setRecipientCount(int recipientCount) {
    this.recipientCount = recipientCount;
  }


  /**
   *  Sets the RecipientCount attribute of the Campaign object
   *
   *@param  recipientCount  The new RecipientCount value
   *@since                  1.17
   */
  public void setRecipientCount(String recipientCount) {
    this.recipientCount = Integer.parseInt(recipientCount);
  }


  /**
   *  Sets the SentCount attribute of the Campaign object
   *
   *@param  tmp  The new SentCount value
   *@since       1.17
   */
  public void setSentCount(int tmp) {
    this.sentCount = tmp;
  }


  /**
   *  Sets the MessageName attribute of the Campaign object
   *
   *@param  messageName  The new MessageName value
   *@since               1.10
   */
  public void setMessageName(String messageName) {
    this.messageName = messageName;
  }


  /**
   *  Gets the serverName attribute of the Campaign object
   *
   *@return    The serverName value
   */
  public String getServerName() {
    return serverName;
  }


  /**
   *  Sets the serverName attribute of the Campaign object
   *
   *@param  serverName  The new serverName value
   */
  public void setServerName(String serverName) {
    this.serverName = serverName;
  }


  /**
   *  Sets the GroupList attribute of the Campaign object
   *
   *@param  groupList  The new GroupList value
   *@since             1.10
   */
  public void setGroupList(String groupList) {
    this.groupList = groupList;
  }


  /**
   *  Sets the id attribute of the Campaign object
   *
   *@param  tmp  The new id value
   *@since       1.1
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   *  Sets the Active attribute of the Campaign object
   *
   *@param  active  The new Active value
   *@since          1.1
   */
  public void setActive(boolean active) {
    this.active = active;
  }


  /**
   *  Sets the Active attribute of the Campaign object
   *
   *@param  tmp  The new Active value
   *@since       1.1
   */
  public void setActive(String tmp) {
    if (tmp != null) {
      this.active = (tmp.toUpperCase().equals("ON"));
    } else {
      this.active = false;
    }
  }


  /**
   *  Sets the id attribute of the Campaign object
   *
   *@param  tmp  The new id value
   *@since       1.1
   */
  public void setId(String tmp) {
    this.setId(Integer.parseInt(tmp));
  }


  /**
   *  Sets the name attribute of the Campaign object
   *
   *@param  tmp  The new name value
   *@since       1.1
   */
  public void setName(String tmp) {
    this.name = tmp;
  }


  /**
   *  Sets the description attribute of the Campaign object
   *
   *@param  tmp  The new description value
   *@since       1.1
   */
  public void setDescription(String tmp) {
    this.description = tmp;
  }


  /**
   *  Sets the Status attribute of the Campaign object
   *
   *@param  status  The new Status value
   *@since          1.17
   */
  public void setStatus(String status) {
    this.status = status;
  }


  /**
   *  Sets the messageId attribute of the Campaign object
   *
   *@param  tmp  The new messageId value
   *@since       1.10
   */
  public void setMessageId(int tmp) {
    this.messageId = tmp;
  }


  /**
   *  Sets the MessageId attribute of the Campaign object
   *
   *@param  tmp  The new MessageId value
   *@since       1.10
   */
  public void setMessageId(String tmp) {
    this.messageId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the groupId attribute of the Campaign object
   *
   *@param  tmp  The new groupId value
   *@since       1.10
   */
  public void setGroupId(int tmp) {
    this.groupId = tmp;
  }


  /**
   *  Sets the runId attribute of the Campaign object
   *
   *@param  tmp  The new runId value
   *@since       1.10
   */
  public void setRunId(int tmp) {
    this.runId = tmp;
  }


  /**
   *  Sets the statusId attribute of the Campaign object
   *
   *@param  tmp  The new statusId value
   *@since       1.17
   */
  public void setStatusId(int tmp) {
    this.statusId = tmp;
    
    switch (statusId) {
      case IDLE: status = IDLE_TEXT; break;
      case QUEUE: status = QUEUE_TEXT; break;
      case STARTED: status = STARTED_TEXT; break;
      case ERROR: status = "Unspecified error"; break;
      case FINISHED: status = FINISHED_TEXT; break;
      default: break;
    }
  }


  /**
   *  Sets the owner attribute of the Campaign object
   *
   *@param  tmp  The new owner value
   *@since       1.10
   */
  public void setOwner(int tmp) {
    this.owner = tmp;
  }


  /**
   *  Sets the ActiveDate attribute of the Campaign object
   *
   *@param  tmp  The new ActiveDate value
   *@since       1.10
   */
  public void setActiveDate(java.sql.Date tmp) {
    this.activeDate = tmp;
  }


  /**
   *  Sets the ActiveDate attribute of the Campaign object
   *
   *@param  tmp  The new ActiveDate value
   *@since       1.17
   */
  public void setActiveDate(String tmp) {
    try {
      java.util.Date tmpDate = DateFormat.getDateInstance(3).parse(tmp);
      activeDate = new java.sql.Date(new java.util.Date().getTime());
      activeDate.setTime(tmpDate.getTime());
    } catch (Exception e) {
      activeDate = null;
    }
  }


  /**
   *  Sets the Entered attribute of the Campaign object
   *
   *@param  tmp  The new Entered value
   *@since       1.17
   */
  public void setEntered(Timestamp tmp) {
    this.entered = tmp;
  }


  /**
   *  Sets the Entered attribute of the Campaign object
   *
   *@param  tmp  The new Entered value
   *@since       1.17
   */
  public void setEntered(String tmp) {
    try {
      java.util.Date tmpDate = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.LONG).parse(tmp);
      entered = new java.sql.Timestamp(new java.util.Date().getTime());
      entered.setTime(tmpDate.getTime());
    } catch (Exception e) {
      entered = null;
    }
  }


  /**
   *  Sets the enteredBy attribute of the Campaign object
   *
   *@param  tmp  The new enteredBy value
   *@since       1.17
   */
  public void setEnteredBy(int tmp) {
    this.enteredBy = tmp;
  }


  /**
   *  Sets the Modified attribute of the Campaign object
   *
   *@param  tmp  The new Modified value
   *@since       1.17
   */
  public void setModified(Timestamp tmp) {
    this.modified = tmp;
  }


  /**
   *  Sets the Modified attribute of the Campaign object
   *
   *@param  tmp  The new Modified value
   *@since       1.17
   */
  public void setModified(String tmp) {
    java.util.Date tmpDate = new java.util.Date();
    modified = new java.sql.Timestamp(tmpDate.getTime());
    modified = modified.valueOf(tmp);
  }


  /**
   *  Sets the modifiedBy attribute of the Campaign object
   *
   *@param  tmp  The new modifiedBy value
   *@since       1.17
   */
  public void setModifiedBy(int tmp) {
    this.modifiedBy = tmp;
  }


  /**
   *  Sets the enabled attribute of the Campaign object
   *
   *@param  tmp  The new enabled value
   *@since       1.1
   */
  public void setEnabled(boolean tmp) {
    this.enabled = tmp;
  }


  /**
   *  Sets the enabled attribute of the Campaign object
   *
   *@param  tmp  The new enabled value
   *@since       1.1
   */
  public void setEnabled(String tmp) {
    if (tmp.toLowerCase().equals("false")) {
      this.enabled = false;
    } else {
      this.enabled = true;
    }
  }


  /**
   *  Sets the deliveryName attribute of the Campaign object
   *
   *@param  deliveryName  The new deliveryName value
   */
  public void setDeliveryName(String deliveryName) {
    this.deliveryName = deliveryName;
  }


  /**
   *  Sets the Groups attribute of the Campaign object
   *
   *@param  request  The new Groups value
   *@since           1.10
   */
  public void setGroups(HttpServletRequest request) {
    StringBuffer sb = new StringBuffer();

    int selectCount = 0;
    String item = null;
    while ((item = request.getParameter("select" + (++selectCount))) != null) {
      if ("on".equalsIgnoreCase(request.getParameter("select" + selectCount + "check"))) {
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
   *@param  db                The new GroupList value
   *@exception  SQLException  Description of Exception
   *@since                    1.10
   */
  public void setGroupList(Connection db) throws SQLException {
    this.groupCount = 0;
    StringBuffer groups = new StringBuffer();
    boolean b = false;

    PreparedStatement pst = db.prepareStatement(
      "SELECT group_id " +
      "FROM campaign_list_groups " +
      "WHERE campaign_id = ? "
    );
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
   *  Sets the sendMethodId attribute of the Campaign object
   *
   *@param  tmp  The new sendMethodId value
   */
  public void setSendMethodId(int tmp) {
    sendMethodId = tmp;
  }


  /**
   *  Sets the sendMethodId attribute of the Campaign object
   *
   *@param  tmp  The new sendMethodId value
   */
  public void setSendMethodId(String tmp) {
    sendMethodId = Integer.parseInt(tmp);
  }


  /**
   *  Gets the sendMethodId attribute of the Campaign object
   *
   *@return    The sendMethodId value
   */
  public int getSendMethodId() {
    return sendMethodId;
  }


  /**
   *  Gets the deliveryName attribute of the Campaign object
   *
   *@return    The deliveryName value
   */
  public String getDeliveryName() {
    return deliveryName;
  }


  /**
   *  Gets the RecipientCount attribute of the Campaign object
   *
   *@return    The RecipientCount value
   *@since     1.10
   */
  public int getRecipientCount() {
    return recipientCount;
  }


  /**
   *  Gets the SentCount attribute of the Campaign object
   *
   *@return    The SentCount value
   *@since     1.10
   */
  public int getSentCount() {
    return sentCount;
  }


  /**
   *  Gets the ContactList attribute of the Campaign object
   *
   *@return    The ContactList value
   *@since     1.10
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
   *@return    The MessageName value
   *@since     1.10
   */
  public String getMessageName() {
    return messageName;
  }


  /**
   *  Gets the Active attribute of the Campaign object
   *
   *@return    The Active value
   *@since     1.10
   */
  public boolean getActive() {
    return active;
  }


  /**
   *  Gets the ActiveYesNo attribute of the Campaign object
   *
   *@return    The ActiveYesNo value
   *@since     1.10
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
   *@param  tmp  Description of Parameter
   *@return      The Active value
   *@since       1.10
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
   *@return    The ActiveDate value
   *@since     1.10
   */
  public java.sql.Date getActiveDate() {
    return activeDate;
  }


  /**
   *  Gets the ActiveDateString attribute of the Campaign object
   *
   *@return    The ActiveDateString value
   *@since     1.10
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
   *@return    The Status value
   *@since     1.17
   */
  public String getStatus() {
    return status;
  }


  /**
   *  Gets the GroupList attribute of the Campaign object
   *
   *@return    The GroupList value
   *@since     1.10
   */
  public String getGroupList() {
    return groupList;
  }


  /**
   *  Gets the GroupCount attribute of the Campaign object
   *
   *@return    The GroupCount value
   *@since     1.10
   */
  public int getGroupCount() {
    return groupCount;
  }



  /**
   *  Gets the id attribute of the Campaign object
   *
   *@return    The id value
   *@since     1.1
   */
  public int getId() {
    return id;
  }


  /**
   *  Gets the name attribute of the Campaign object
   *
   *@return    The name value
   *@since     1.1
   */
  public String getName() {
    return name;
  }


  /**
   *  Gets the description attribute of the Campaign object
   *
   *@return    The description value
   *@since     1.1
   */
  public String getDescription() {
    return description;
  }


  /**
   *  Gets the messageId attribute of the Campaign object
   *
   *@return    The messageId value
   *@since     1.1
   */
  public int getMessageId() {
    return messageId;
  }


  /**
   *  Gets the replyTo attribute of the Campaign object
   *
   *@return    The replyTo value
   */
  public String getReplyTo() {
    return replyTo;
  }


  /**
   *  Gets the message attribute of the Campaign object
   *
   *@return    The message value
   */
  public String getMessage() {
    return message;
  }


  /**
   *  Gets the subject attribute of the Campaign object
   *
   *@return    The subject value
   */
  public String getSubject() {
    return subject;
  }


  /**
   *  Gets the groupId attribute of the Campaign object
   *
   *@return    The groupId value
   *@since     1.1
   */
  public int getGroupId() {
    return groupId;
  }


  /**
   *  Gets the runId attribute of the Campaign object
   *
   *@return    The runId value
   *@since     1.1
   */
  public int getRunId() {
    return runId;
  }


  /**
   *  Gets the statusId attribute of the Campaign object
   *
   *@return    The statusId value
   *@since     1.17
   */
  public int getStatusId() {
    return statusId;
  }


  /**
   *  Gets the owner attribute of the Campaign object
   *
   *@return    The owner value
   *@since     1.10
   */
  public int getOwner() {
    return owner;
  }


  /**
   *  Gets the enteredBy attribute of the Campaign object
   *
   *@return    The enteredBy value
   *@since     1.1
   */
  public int getEnteredBy() {
    return enteredBy;
  }


  /**
   *  Gets the modifiedBy attribute of the Campaign object
   *
   *@return    The modifiedBy value
   *@since     1.1
   */
  public int getModifiedBy() {
    return modifiedBy;
  }


  /**
   *  Gets the Modified attribute of the Campaign object
   *
   *@return    The Modified value
   *@since     1.1
   */
  public String getModified() {
    return modified.toString();
  }


  /**
   *  Gets the ModifiedString attribute of the Campaign object
   *
   *@return    The ModifiedString value
   *@since     1.17
   */
  public String getModifiedString() {
    String tmp = "";
    try {
      return DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.LONG).format(modified);
    } catch (NullPointerException e) {
    }
    return tmp;
  }


  /**
   *  Gets the Entered attribute of the Campaign object
   *
   *@return    The Entered value
   *@since     1.17
   */
  public java.sql.Timestamp getEntered() {
    return entered;
  }


  /**
   *  Gets the EnteredString attribute of the Campaign object
   *
   *@return    The EnteredString value
   *@since     1.17
   */
  public String getEnteredString() {
    String tmp = "";
    try {
      return DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.LONG).format(entered);
    } catch (NullPointerException e) {
    }
    return tmp;
  }


  /**
   *  Gets the enabled attribute of the Campaign object
   *
   *@return    The enabled value
   *@since     1.1
   */
  public boolean getEnabled() {
    return enabled;
  }


  /**
   *  Gets the Range attribute of the Campaign object
   *
   *@return    The Range value
   *@since     1.10
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
   *@param  tmp  Description of Parameter
   *@return      The MessageChecked value
   *@since       1.17
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
   *@param  tmp  Description of Parameter
   *@return      The GroupChecked value
   *@since       1.17
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
   *@return    The ReadyToActivate value
   *@since     1.17
   */
  public boolean isReadyToActivate() {
    return (hasGroups() && hasMessage() && hasDetails());
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Returned Value
   *@since     1.17
   */
  public boolean hasGroups() {
    return (groupList != null && !groupList.equals(""));
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Returned Value
   *@since     1.17
   */
  public boolean hasMessage() {
    return (messageId > 0);
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Return Value
   */
  public boolean hasSurvey() {
    return (surveyId > 0);
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Returned Value
   *@since     1.17
   */
  public boolean hasDetails() {
    return (activeDate != null);
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Returned Value
   *@since     1.17
   */
  public boolean hasRun() {
    return (statusId == FINISHED);
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Returned Value
   */
  public boolean hasFiles() {
    return (files > 0);
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@exception  SQLException  Description of Exception
   *@since                    1.10
   */
  public void buildRecipientCount(Connection db) throws SQLException {
    Statement st = db.createStatement();
    ResultSet rs = st.executeQuery(
        "SELECT count(id) " +
        "FROM scheduled_recipient sr " +
        "WHERE campaign_id = " + id + " ");

    if (rs.next()) {
      this.setRecipientCount(rs.getInt(1));
    }

    rs.close();
    st.close();
  }


  /**
   *  Retrieves the file id for this campaign.  A file will exist if a campaign gets executed
   *  and is configured to output a file.  For example, when the "letter" option is
   *  selected, a .zip file gets created in which the user can download.
   *
   *@param  db                Description of Parameter
   *@exception  SQLException  Description of Exception
   */
  public void buildFileCount(Connection db) throws SQLException {
    //TODO: Move this code to the Files object and call getFileCount
    PreparedStatement pst = db.prepareStatement(
      "SELECT count(*) " +
      "FROM project_files " +
      "WHERE link_module_id = ? " +
      "AND link_item_id = ? ");
    pst.setInt(1, Constants.COMMUNICATIONS);
    pst.setInt(2, id);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      files = (rs.getInt(1));
    }
    rs.close();
    pst.close();
  }
  
  public void buildSurveyId(Connection db) throws SQLException {
    if (active) {
      surveyId = ActiveSurvey.getId(db, this.id);
    } else {
      surveyId = Survey.getId(db, this.id);
    }
  }


  /*
   *  public void buildContactList(Connection db, String range) throws SQLException {
   *  StringBuffer searchCriteriaText = new StringBuffer();
   *  Statement st = db.createStatement();
   *  ResultSet rs = st.executeQuery(
   *  "SELECT s.field, s.operatorid, s.value " +
   *  "FROM saved_criteriaelement s " +
   *  "WHERE s.id IN ( " + range + " )");
   *  while (rs.next()) {
   *  searchCriteriaText.append(
   *  rs.getString("field") + "|" +
   *  rs.getInt("operatorid") + "|" +
   *  rs.getString("value") + "^");
   *  }
   *  rs.close();
   *  st.close();
   *  SearchCriteriaList scl = new SearchCriteriaList(searchCriteriaText.toString());
   *  contactList.setScl(scl);
   *  contactList.buildList(db);
   *  }
   */
  /**
   *  Gets the ContactList attribute of the Campaign object
   *
   *@param  db                Description of Parameter
   *@exception  SQLException  Description of Exception
   *@since                    1.10
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
   *@param  db                Description of Parameter
   *@param  userId            Description of the Parameter
   *@param  userRangeId       Description of the Parameter
   *@exception  SQLException  Description of Exception
   */
  public void insertRecipients(Connection db, int userId, String userRangeId) throws SQLException {
    SearchCriteriaListList groupData = new SearchCriteriaListList();
    groupData.setCampaignId(this.id);
    groupData.buildList(db);
    Iterator i = groupData.iterator();
    while (i.hasNext()) {
      SearchCriteriaList thisGroup = (SearchCriteriaList) i.next();
      ContactList groupContacts = new ContactList();
      groupContacts.setScl(thisGroup, userId, userRangeId);
      groupContacts.setBuildDetails(false);
      groupContacts.setCheckExcludedFromCampaign(this.getId());
      groupContacts.buildList(db);

      if (System.getProperty("DEBUG") != null) {
        System.out.println("Campaign-> GroupContacts has " + groupContacts.size() + " items");
      }
      Iterator j = groupContacts.iterator();
      while (j.hasNext()) {
        Contact thisContact = (Contact) j.next();
        if (thisContact.excludedFromCampaign() == false) {
          Recipient thisRecipient = new Recipient();
          thisRecipient.setCampaignId(this.getId());
          thisRecipient.setContactId(thisContact.getId());
          thisRecipient.insert(db);
        }
      }
    }
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   *@since                    1.5
   */
  public boolean insert(Connection db) throws SQLException {

    if (!isValid(db)) {
      return false;
    }

    StringBuffer sql = new StringBuffer();

    try {
      db.setAutoCommit(false);
      sql.append(
          "INSERT INTO campaign " +
          "(enteredby, modifiedby, name, message_id ) " +
          "VALUES (?, ?, ?, ?) ");

      int i = 0;
      PreparedStatement pst = db.prepareStatement(sql.toString());
      pst.setInt(++i, this.getEnteredBy());
      pst.setInt(++i, this.getModifiedBy());
      pst.setString(++i, this.getName());
      pst.setInt(++i, this.getMessageId());
      pst.execute();
      pst.close();

      id = DatabaseUtils.getCurrVal(db, "campaign_campaign_id_seq");
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

      db.commit();
    } catch (SQLException e) {
      db.rollback();
      db.setAutoCommit(true);
      throw new SQLException(e.getMessage());
    } finally {
      db.setAutoCommit(true);
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   *@since                    1.17
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
      st.close();

      db.commit();
    } catch (SQLException e) {
      db.rollback();
      db.setAutoCommit(true);
      throw new SQLException(e.getMessage());
    } finally {
      db.setAutoCommit(true);
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
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
   *@param  db                Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   *@since                    1.17
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
        st.close();
      }
      db.commit();
    } catch (SQLException e) {
      db.rollback();
      db.setAutoCommit(true);
      throw new SQLException(e.getMessage());
    } finally {
      db.setAutoCommit(true);
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   *@since                    1.5
   */
  public int update(Connection db) throws SQLException {
    int resultCount = -1;

    if (!isValid(db)) {
      return -1;
    }

    try {
      db.setAutoCommit(false);
      resultCount = this.update(db, false);
      db.commit();
    } catch (Exception e) {
      db.rollback();
      db.setAutoCommit(true);
      throw new SQLException(e.getMessage());
    }

    db.setAutoCommit(true);
    return resultCount;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   *@since                    1.5
   */
  public boolean delete(Connection db) throws SQLException {
    PreparedStatement pst = null;
    SQLException message = null;
    try {
      db.setAutoCommit(false);
      pst = db.prepareStatement(
          "DELETE FROM campaign_list_groups WHERE campaign_id = ? ");
      pst.setInt(1, this.getId());
      pst.execute();
          
      pst = db.prepareStatement(
          "DELETE FROM scheduled_recipient WHERE campaign_id = ? ");
      pst.setInt(1, this.getId());
      pst.execute();
      
      pst = db.prepareStatement(
          "DELETE FROM campaign_run WHERE campaign_id = ? ");
      pst.setInt(1, this.getId());
      pst.execute();
      
      pst = db.prepareStatement(
          "DELETE FROM excluded_recipient WHERE campaign_id = ? ");
      pst.setInt(1, this.getId());
      pst.execute();
      
      //Delete any inactive survey links
      pst = db.prepareStatement(
          "DELETE FROM campaign_survey_link WHERE campaign_id = ? ");
      pst.setInt(1, this.getId());
      pst.execute();
      
      //Delete the attached survey
      int activeSurveyId = (ActiveSurvey.getId(db, id));
      if (activeSurveyId > -1) {
        ActiveSurvey thisSurvey = new ActiveSurvey(db, activeSurveyId);
        thisSurvey.delete(db);
      }
      
      pst = db.prepareStatement(
          "DELETE FROM campaign WHERE campaign_id = ? ");
      pst.setInt(1, this.getId());
      pst.execute();
      
      db.commit();
    } catch (SQLException e) {
      db.rollback();
      message = e;
    } finally {
      db.setAutoCommit(true);
      pst.close();
    }
    if (message != null) {
      throw new SQLException(message.getMessage());
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   *@since                    1.17
   */
  public int cancel(Connection db) throws SQLException {
    if (this.getId() == -1) {
      throw new SQLException("Campaign ID was not specified");
    }

    boolean commit = true;
    int resultCount = 0;
    PreparedStatement pst = null;
    
    try {
      commit = db.getAutoCommit();
      if (commit) {
        db.setAutoCommit(false);
      }
      pst = db.prepareStatement(
        "UPDATE campaign " +
        "SET status_id = ?, " +
        "status = ?, " +
        "active = ?, " +
        "modifiedby = ?, " +
        "modified = CURRENT_TIMESTAMP " +
        "WHERE campaign_id = ? " +
        "AND status_id IN (" + QUEUE + ", " + ERROR + ") ");
      int i = 0;
      pst.setInt(++i, CANCELLED);
      pst.setString(++i, CANCELLED_TEXT);
      pst.setBoolean(++i, false);
      pst.setInt(++i, modifiedBy);
      pst.setInt(++i, id);
      resultCount = pst.executeUpdate();
  
      if (resultCount == 1) {
        pst = db.prepareStatement(
          "DELETE FROM scheduled_recipient " +
          "WHERE campaign_id = ? " +
          "AND sent_date IS NULL ");
        pst.setInt(1, id);
        pst.execute();
        
        //Remove attached survey if campaign has one
        int activeSurveyId = ActiveSurvey.getId(db, id);
        if (activeSurveyId > -1) {
          ActiveSurvey activeSurvey = new ActiveSurvey(db, activeSurveyId);
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
   *@param  db                Description of Parameter
   *@param  userId            Description of the Parameter
   *@param  userRangeId       Description of the Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   *@since                    1.17
   */
  public int activate(Connection db, int userId, String userRangeId) throws SQLException {
    int resultCount = 0;
    if (this.getId() == -1) {
      throw new SQLException("Campaign ID was not specified");
    }
    SQLException message = null;
    PreparedStatement pst = null;

    try {
      db.setAutoCommit(false);
      
      //See if the campaign is not already active
      pst = db.prepareStatement(
        "UPDATE campaign " +
        "SET status_id = ?, " +
        "status = ?, " +
        "modifiedby = ?, " +
        "modified = CURRENT_TIMESTAMP " +
        "WHERE campaign_id = ? " + 
        "AND modified = ? " +
        "AND active = ? ");
      int i = 0;
      pst.setInt(++i, QUEUE);
      pst.setString(++i, QUEUE_TEXT);
      pst.setInt(++i, modifiedBy);
      pst.setInt(++i, id);
      pst.setTimestamp(++i, modified);
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
        
        //Lock in the message
        Message thisMessage = new Message(db, this.getMessageId());
     
        //Replace tags
        Template template = new Template();
        if (this.surveyId > -1) {
          template.addParseElement("${survey_url}", "<a href=\"http://" + this.getServerName() + "/ProcessSurvey.do?id=${surveyId=" + this.getActiveSurveyId() + "}\">http://" + this.getServerName() + "/ProcessSurvey.do?id=${surveyId=" + this.getActiveSurveyId() + "}</a>");
          if (thisMessage.getMessageText().indexOf("${survey_url}") == -1) {
            template.setText(thisMessage.getMessageText() + "<br><br>You can take the survey at the following web-site: ${survey_url}");
          } else {
            template.setText(thisMessage.getMessageText());
          }
        } else {
          template.setText(thisMessage.getMessageText());
        }
    
        //Finalize the campaign activation
        pst = db.prepareStatement(
          "UPDATE campaign " +
          "SET active = ?, " +
          "reply_addr = ?, " +
          "subject = ?, " +
          "message = ?, " +
          "modifiedby = ?, " +
          "modified = CURRENT_TIMESTAMP " +
          "WHERE campaign_id = ? ");
        i = 0;
        pst.setBoolean(++i, true);
        pst.setString(++i, thisMessage.getReplyTo());
        pst.setString(++i, thisMessage.getMessageSubject());
        pst.setString(++i, template.getParsedText());
        pst.setInt(++i, modifiedBy);
        pst.setInt(++i, id);
        resultCount = pst.executeUpdate();
        pst.close();
    
        db.commit();
      }
    } catch (SQLException e) {
      message = e;
      db.rollback();
    } catch (Exception ee) {
      db.rollback();
      ee.printStackTrace(System.out);
    } finally {
      db.setAutoCommit(true);
    }
    
    if (message != null) {
      throw new SQLException (message.getMessage());
    }
    return resultCount;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   *@since                    1.17
   */
  public int insertRun(Connection db) throws SQLException {
    int returnCode = -1;
    if (!isValid(db)) {
      return -1;
    }

    String sql = 
      "INSERT INTO campaign_run " +
      "(campaign_id, total_contacts, total_sent) " +
      "VALUES (?, ?, ?) ";
    int i = 0;
    PreparedStatement pst = db.prepareStatement(sql);
    pst.setInt(++i, this.getId());
    pst.setInt(++i, this.getRecipientCount());
    pst.setInt(++i, this.getSentCount());
    pst.execute();
    pst.close();

    returnCode = DatabaseUtils.getCurrVal(db, "campaign_run_id_seq");

    return returnCode;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   *@since                    1.17
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
    int i = 0;
    pst.setString(++i, name);
    pst.setString(++i, description);
    pst.setInt(++i, modifiedBy);
    resultCount = pst.executeUpdate();
    pst.close();

    return resultCount;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   *@since                    1.17
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
        "message = null, " +
        "modifiedby = ?, " +
        "modified = CURRENT_TIMESTAMP " +
        "WHERE campaign_id = ? ");
    pst.setInt(++i, messageId);
    pst.setInt(++i, modifiedBy);
    pst.setInt(++i, id);
    resultCount = pst.executeUpdate();
    pst.close();

    return resultCount;
  }
  
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
      pst.setInt(2, id);
      resultCount = pst.executeUpdate();
      
      pst = db.prepareStatement("DELETE FROM campaign_survey_link WHERE campaign_id = ? ");
      pst.setInt(1, id);
      pst.execute();
      
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
      db.setAutoCommit(true);
    } catch (SQLException e) {
      db.rollback();
      db.setAutoCommit(true);
      throw new SQLException(e.getMessage());
    }
    return resultCount;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   *@since                    1.17
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
        "active_date = ?, " +
        "send_method_id = ?, " +
        "modified = CURRENT_TIMESTAMP " +
        "WHERE campaign_id = " + id);
    pst.setInt(++i, messageId);
    pst.setDate(++i, activeDate);
    pst.setInt(++i, sendMethodId);
    resultCount = pst.executeUpdate();
    pst.close();

    return resultCount;
  }


  /**
   *  Gets the valid attribute of the Message object
   *
   *@param  db                Description of Parameter
   *@return                   The valid value
   *@exception  SQLException  Description of Exception
   *@since                    1.15
   */
  protected boolean isValid(Connection db) throws SQLException {
    errors.clear();

    if (name == null || name.trim().equals("")) {
      errors.put("nameError", "Campaign name is required");
    }

    if (hasErrors()) {
      return false;
    } else {
      return true;
    }
  }



  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@param  override          Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   *@since                    1.5
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
    String sql =
        "UPDATE campaign " +
        "SET description = ?, active_date = ?, " +
        "enabled = ?, modified = CURRENT_TIMESTAMP, modifiedby = ?, " +
        "active = ?, status_id = ?, status = ?, message_id = ? " +
        "WHERE campaign_id = ? ";
    int i = 0;
    pst = db.prepareStatement(sql);
    pst.setString(++i, this.getDescription());

    if (activeDate == null) {
      pst.setNull(++i, java.sql.Types.DATE);
    } else {
      pst.setDate(++i, this.getActiveDate());
    }

    pst.setBoolean(++i, this.getEnabled());
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
    
    return resultCount;
  }


  /**
   *  Description of the Method
   *
   *@param  rs                Description of Parameter
   *@exception  SQLException  Description of Exception
   *@since                    1.5
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
    activeDate = rs.getDate("active_date");
    sendMethodId = rs.getInt("send_method_id");
    enabled = rs.getBoolean("enabled");
    entered = rs.getTimestamp("entered");
    enteredBy = rs.getInt("enteredby");
    modified = rs.getTimestamp("modified");
    modifiedBy = rs.getInt("modifiedby");

    //message table
    messageName = rs.getString("messageName");

    //lookup_delivery_options table
    deliveryName = rs.getString("delivery");
  }
}

