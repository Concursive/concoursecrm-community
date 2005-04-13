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
package org.aspcfs.modules.pipeline.base;

import com.darkhorseventures.framework.actions.ActionContext;
import com.darkhorseventures.framework.beans.GenericBean;
import com.zeroio.iteam.base.FileItemList;
import org.aspcfs.modules.actionlist.base.ActionItemLog;
import org.aspcfs.modules.actionlist.base.ActionItemLogList;
import org.aspcfs.modules.actionlist.base.ActionList;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.base.Dependency;
import org.aspcfs.modules.base.DependencyList;
import org.aspcfs.modules.contacts.base.CallList;
import org.aspcfs.modules.contacts.base.Contact;
import org.aspcfs.modules.quotes.base.QuoteList;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.DateUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.DateFormat;

/**
 *  An OpportunityHeader is a top level description for all of the components
 *  that make up an Opportunity.
 *
 *@author     chris
 *@created    December, 2002
 *@version    $Id: OpportunityHeader.java,v 1.3 2003/01/07 20:21:45 mrajkowski
 *      Exp $
 */

public class OpportunityHeader extends GenericBean {
  /**
   *  Description of the Field
   */
  protected int id = -1;
  /**
   *  Description of the Field
   */
  protected String description = null;
  private int accountLink = -1;
  private int contactLink = -1;
  private String accountName = "";
  private String contactName = "";
  private String contactCompanyName = "";
  private boolean accountEnabled = true;
  private java.sql.Timestamp entered = null;
  private java.sql.Timestamp modified = null;
  private int enteredBy = -1;
  private int modifiedBy = -1;

  private int componentCount = 0;
  //count of components owned by a specific user
  private int ownerComponentCount = 0;
  private boolean buildComponentCount = true;
  private double totalValue = 0;
  private FileItemList files = new FileItemList();


  /**
   *  Constructor for the OpportunityHeader object
   */
  public OpportunityHeader() { }


  /**
   *  Constructor for the OpportunityHeader object
   *
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public OpportunityHeader(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }


  /**
   *  Constructor for the OpportunityHeader object
   *
   *@param  db                Description of the Parameter
   *@param  id                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public OpportunityHeader(Connection db, int id) throws SQLException {
    queryRecord(db, id);
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  id                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void queryRecord(Connection db, int id) throws SQLException {
    if (id == -1) {
      throw new SQLException("Opportunity Header ID not specified.");
    }
    PreparedStatement pst = db.prepareStatement(
        "SELECT " +
        "oh.opp_id AS header_opp_id, " +
        "oh.description AS header_description, " +
        "oh.acctlink AS header_acctlink, " +
        "oh.contactlink AS header_contactlink, " +
        "oh.entered AS header_entered, " +
        "oh.enteredby AS header_enteredby, " +
        "oh.modified AS header_modified, " +
        "oh.modifiedby AS header_modifiedby, " +
        "org.name as acct_name, org.enabled as accountenabled, " +
        "ct.namelast as last_name, ct.namefirst as first_name, " +
        "ct.company as ctcompany " +
        "FROM opportunity_header oh " +
        "LEFT JOIN organization org ON (oh.acctlink = org.org_id) " +
        "LEFT JOIN contact ct ON (oh.contactlink = ct.contact_id) " +
        "WHERE opp_id = ? ");
    pst.setInt(1, id);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    }
    rs.close();
    pst.close();

    if (id == -1) {
      throw new SQLException("Opportunity Header record not found.");
    }
    if (buildComponentCount) {
      this.retrieveComponentCount(db);
    }
    this.buildFiles(db);
  }


  /**
   *  Constructor for the OpportunityHeader object
   *
   *@param  db                Description of the Parameter
   *@param  id                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public OpportunityHeader(Connection db, String id) throws SQLException {
    queryRecord(db, Integer.parseInt(id));
  }


  /**
   *  Gets the componentCount attribute of the OpportunityHeader object
   *
   *@return    The componentCount value
   */
  public int getComponentCount() {
    return componentCount;
  }


  /**
   *  Sets the ownerComponentCount attribute of the OpportunityHeader object
   *
   *@param  ownerComponentCount  The new ownerComponentCount value
   */
  public void setOwnerComponentCount(int ownerComponentCount) {
    this.ownerComponentCount = ownerComponentCount;
  }


  /**
   *  Gets the ownerComponentCount attribute of the OpportunityHeader object
   *
   *@return    The ownerComponentCount value
   */
  public int getOwnerComponentCount() {
    return ownerComponentCount;
  }


  /**
   *  Sets the componentCount attribute of the OpportunityHeader object
   *
   *@param  componentCount  The new componentCount value
   */
  public void setComponentCount(int componentCount) {
    this.componentCount = componentCount;
  }


  /**
   *  Sets the componentCount attribute of the OpportunityHeader object
   *
   *@param  componentCount  The new componentCount value
   */
  public void setComponentCount(String componentCount) {
    this.componentCount = Integer.parseInt(componentCount);
  }


  /**
   *  Gets the totalValue attribute of the OpportunityHeader object
   *
   *@return    The totalValue value
   */
  public double getTotalValue() {
    return totalValue;
  }


  /**
   *  Gets the totalValue attribute of the OpportunityHeader object
   *
   *@param  divisor  Description of the Parameter
   *@return          The totalValue value
   */
  public double getTotalValue(int divisor) {
    return (java.lang.Math.round(totalValue) / (double) divisor);
  }


  /**
   *  Sets the totalValue attribute of the OpportunityHeader object
   *
   *@param  totalValue  The new totalValue value
   */
  public void setTotalValue(double totalValue) {
    this.totalValue = totalValue;
  }


  /**
   *  Gets the shortDescription attribute of the OpportunityHeader object
   *
   *@return    The shortDescription value
   */
  public String getShortDescription() {
    if (description == null) {
      return null;
    }
    if (description.length() <= 40) {
      return description;
    } else {
      return description.substring(0, 40) + "...";
    }
  }


  /**
   *  Gets the id attribute of the OpportunityHeader object
   *
   *@return    The id value
   */
  public int getId() {
    return id;
  }


  /**
   *  Gets the description attribute of the OpportunityHeader object
   *
   *@return    The description value
   */
  public String getDescription() {
    return description;
  }


  /**
   *  Gets the accountLink attribute of the OpportunityHeader object
   *
   *@return    The accountLink value
   */
  public int getAccountLink() {
    return accountLink;
  }


  /**
   *  Gets the contactLink attribute of the OpportunityHeader object
   *
   *@return    The contactLink value
   */
  public int getContactLink() {
    return contactLink;
  }


  /**
   *  Gets the accountName attribute of the OpportunityHeader object
   *
   *@return    The accountName value
   */
  public String getAccountName() {
    return accountName;
  }


  /**
   *  Gets the contactName attribute of the OpportunityHeader object
   *
   *@return    The contactName value
   */
  public String getContactName() {
    return contactName;
  }


  /**
   *  Gets the contactCompanyName attribute of the OpportunityHeader object
   *
   *@return    The contactCompanyName value
   */
  public String getContactCompanyName() {
    return contactCompanyName;
  }


  /**
   *  Gets the calculated name that relates to this opportunity. An opportunity
   *  can be linked to Contacts and Accounts.
   *
   *@return    The displayName value
   */
  public String getDisplayName() {
    StringBuffer sb = new StringBuffer();
    //Account Name
    if (accountName != null) {
      sb.append(accountName);
    }
    //Contact Name
    if (contactName != null && !"".equals(contactName.trim())) {
      if (sb.length() > 0) {
        sb.append(" (" + contactName + ")");
      } else {
        sb.append(contactName);
      }
    }
    //Contact's Company Name
    if (contactCompanyName != null && !"".equals(contactCompanyName.trim())) {
      if (sb.length() > 0) {
        sb.append(" (" + contactCompanyName + ")");
      } else {
        sb.append(contactCompanyName);
      }
    }
    return sb.toString();
  }


  /**
   *  Gets the accountEnabled attribute of the OpportunityHeader object
   *
   *@return    The accountEnabled value
   */
  public boolean getAccountEnabled() {
    return accountEnabled;
  }


  /**
   *  Gets the entered attribute of the OpportunityHeader object
   *
   *@return    The entered value
   */
  public java.sql.Timestamp getEntered() {
    return entered;
  }


  /**
   *  Gets the modified attribute of the OpportunityHeader object
   *
   *@return    The modified value
   */
  public java.sql.Timestamp getModified() {
    return modified;
  }


  /**
   *  Sets the id attribute of the OpportunityHeader object
   *
   *@param  tmp  The new id value
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   *  Sets the id attribute of the OpportunityHeader object
   *
   *@param  tmp  The new id value
   */
  public void setId(String tmp) {
    this.id = Integer.parseInt(tmp);
  }


  /**
   *  Sets the description attribute of the OpportunityHeader object
   *
   *@param  tmp  The new description value
   */
  public void setDescription(String tmp) {
    this.description = tmp;
  }


  /**
   *  Sets the accountLink attribute of the OpportunityHeader object
   *
   *@param  tmp  The new accountLink value
   */
  public void setAccountLink(int tmp) {
    this.accountLink = tmp;
  }


  /**
   *  Sets the contactLink attribute of the OpportunityHeader object
   *
   *@param  tmp  The new contactLink value
   */
  public void setContactLink(int tmp) {
    this.contactLink = tmp;
  }


  /**
   *  Sets the accountLink attribute of the OpportunityHeader object
   *
   *@param  tmp  The new accountLink value
   */
  public void setAccountLink(String tmp) {
    this.accountLink = Integer.parseInt(tmp);
  }


  /**
   *  Sets the contactLink attribute of the OpportunityHeader object
   *
   *@param  tmp  The new contactLink value
   */
  public void setContactLink(String tmp) {
    this.contactLink = Integer.parseInt(tmp);
  }


  /**
   *  Gets the buildComponentCount attribute of the OpportunityHeader object
   *
   *@return    The buildComponentCount value
   */
  public boolean getBuildComponentCount() {
    return buildComponentCount;
  }


  /**
   *  Sets the buildComponentCount attribute of the OpportunityHeader object
   *
   *@param  buildComponentCount  The new buildComponentCount value
   */
  public void setBuildComponentCount(boolean buildComponentCount) {
    this.buildComponentCount = buildComponentCount;
  }


  /**
   *  Gets the enteredString attribute of the OpportunityHeader object
   *
   *@return    The enteredString value
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
   *  Gets the modifiedString attribute of the OpportunityHeader object
   *
   *@return    The modifiedString value
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
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void buildFiles(Connection db) throws SQLException {
    files.clear();
    files.setLinkModuleId(Constants.PIPELINE);
    files.setLinkItemId(this.getId());
    files.buildList(db);
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Return Value
   */
  public boolean hasFiles() {
    return (files != null && files.size() > 0);
  }


  /**
   *  Sets the accountName attribute of the OpportunityHeader object
   *
   *@param  tmp  The new accountName value
   */
  public void setAccountName(String tmp) {
    this.accountName = tmp;
  }


  /**
   *  Sets the contactName attribute of the OpportunityHeader object
   *
   *@param  tmp  The new contactName value
   */
  public void setContactName(String tmp) {
    this.contactName = tmp;
  }


  /**
   *  Sets the contactCompanyName attribute of the OpportunityHeader object
   *
   *@param  tmp  The new contactCompanyName value
   */
  public void setContactCompanyName(String tmp) {
    this.contactCompanyName = tmp;
  }


  /**
   *  Sets the accountEnabled attribute of the OpportunityHeader object
   *
   *@param  tmp  The new accountEnabled value
   */
  public void setAccountEnabled(boolean tmp) {
    this.accountEnabled = tmp;
  }


  /**
   *  Sets the entered attribute of the OpportunityHeader object
   *
   *@param  tmp  The new entered value
   */
  public void setEntered(java.sql.Timestamp tmp) {
    this.entered = tmp;
  }


  /**
   *  Sets the modified attribute of the OpportunityHeader object
   *
   *@param  tmp  The new modified value
   */
  public void setModified(java.sql.Timestamp tmp) {
    this.modified = tmp;
  }


  /**
   *  Sets the entered attribute of the OpportunityHeader object
   *
   *@param  tmp  The new entered value
   */
  public void setEntered(String tmp) {
    this.entered = DateUtils.parseTimestampString(tmp);
  }


  /**
   *  Sets the modified attribute of the OpportunityHeader object
   *
   *@param  tmp  The new modified value
   */
  public void setModified(String tmp) {
    this.modified = DateUtils.parseTimestampString(tmp);
  }


  /**
   *  Sets the enteredBy attribute of the OpportunityHeader object
   *
   *@param  tmp  The new enteredBy value
   */
  public void setEnteredBy(int tmp) {
    this.enteredBy = tmp;
  }


  /**
   *  Sets the modifiedBy attribute of the OpportunityHeader object
   *
   *@param  tmp  The new modifiedBy value
   */
  public void setModifiedBy(int tmp) {
    this.modifiedBy = tmp;
  }


  /**
   *  Sets the enteredBy attribute of the OpportunityHeader object
   *
   *@param  tmp  The new enteredBy value
   */
  public void setEnteredBy(String tmp) {
    this.enteredBy = Integer.parseInt(tmp);
  }


  /**
   *  Sets the modifiedBy attribute of the OpportunityHeader object
   *
   *@param  tmp  The new modifiedBy value
   */
  public void setModifiedBy(String tmp) {
    this.modifiedBy = Integer.parseInt(tmp);
  }


  /**
   *  Gets the enteredBy attribute of the OpportunityHeader object
   *
   *@return    The enteredBy value
   */
  public int getEnteredBy() {
    return enteredBy;
  }


  /**
   *  Gets the modifiedBy attribute of the OpportunityHeader object
   *
   *@return    The modifiedBy value
   */
  public int getModifiedBy() {
    return modifiedBy;
  }


  /**
   *  Gets the files attribute of the OpportunityHeader object
   *
   *@return    The files value
   */
  public FileItemList getFiles() {
    return files;
  }


  /**
   *  Sets the files attribute of the OpportunityHeader object
   *
   *@param  files  The new files value
   */
  public void setFiles(FileItemList files) {
    this.files = files;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@param  context           Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   *@since
   */
  public boolean insert(Connection db, ActionContext context) throws SQLException {
    if (insert(db)) {
      //invalidateUserData(context);
      return true;
    } else {
      return false;
    }
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@param  context           Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   *@since
   */
  public boolean delete(Connection db, ActionContext context) throws SQLException {
    if (delete(db)) {
      //invalidateUserData(context);
      return true;
    } else {
      return false;
    }
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  context           Description of the Parameter
   *@param  baseFilePath      Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public boolean delete(Connection db, ActionContext context, String baseFilePath) throws SQLException {
    if (delete(db, baseFilePath)) {
      //invalidateUserData(context);
      return true;
    } else {
      return false;
    }
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public boolean disable(Connection db) throws SQLException {
    if (id == -1) {
      throw new SQLException("Opportunity Header ID not specified");
    }
    PreparedStatement pst = db.prepareStatement(
        "UPDATE opportunity_component " +
        "SET enabled = ? " +
        "WHERE opp_id = ? ");
    int i = 0;
    pst.setBoolean(++i, false);
    pst.setInt(++i, id);
    int resultCount = pst.executeUpdate();
    pst.close();
    return (resultCount == 1);
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public boolean insert(Connection db) throws SQLException {
    if (this.getAccountLink() == -1 && this.getContactLink() == -1) {
      throw new SQLException("You must associate an Opportunity Header with an account or contact.");
    }
    boolean doCommit = false;
    try {
      if ((doCommit = db.getAutoCommit()) == true) {
        db.setAutoCommit(false);
      }
      StringBuffer sql = new StringBuffer();
      sql.append(
          "INSERT INTO opportunity_header " +
          "(acctlink, contactlink, description, ");
      if (entered != null) {
        sql.append("entered, ");
      }
      if (modified != null) {
        sql.append("modified, ");
      }
      sql.append("enteredBy, modifiedBy ) ");
      sql.append("VALUES (?, ?, ?, ");
      if (entered != null) {
        sql.append("?, ");
      }
      if (modified != null) {
        sql.append("?, ");
      }
      sql.append("?, ?) ");

      int i = 0;
      PreparedStatement pst = db.prepareStatement(sql.toString());
      DatabaseUtils.setInt(pst, ++i, this.getAccountLink());
      DatabaseUtils.setInt(pst, ++i, this.getContactLink());
      pst.setString(++i, this.getDescription());
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

      id = DatabaseUtils.getCurrVal(db, "opportunity_header_opp_id_seq");
      if (doCommit) {
        db.commit();
      }
    } catch (SQLException e) {
      if (doCommit) {
        db.rollback();
      }
      throw new SQLException(e.getMessage());
    } finally {
      if (doCommit) {
        db.setAutoCommit(true);
      }
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  actionId          Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void updateLog(Connection db, int actionId) throws SQLException {
    boolean commit = true;
    try {
      commit = db.getAutoCommit();
      if (commit) {
        db.setAutoCommit(false);
      }
      ActionItemLog thisLog = new ActionItemLog();
      thisLog.setEnteredBy(this.getEnteredBy());
      thisLog.setModifiedBy(this.getModifiedBy());
      thisLog.setItemId(actionId);
      thisLog.setLinkItemId(this.getId());
      thisLog.setType(Constants.OPPORTUNITY_OBJECT);
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
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public int update(Connection db) throws SQLException {
    int resultCount = 0;
    if (id == -1) {
      throw new SQLException("Opportunity Header ID was not specified");
    }
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
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public DependencyList processDependencies(Connection db) throws SQLException {
    ResultSet rs = null;
    DependencyList dependencyList = new DependencyList();
    String sql =
        "SELECT COUNT(*) as callcount " +
        "FROM call_log c WHERE c.opp_id = ? ";
    int i = 0;
    PreparedStatement pst = db.prepareStatement(sql);
    pst.setInt(++i, this.getId());
    rs = pst.executeQuery();
    if (rs.next()) {
      Dependency thisDependency = new Dependency();
      thisDependency.setName("calls");
      thisDependency.setCount(rs.getInt("callcount"));
      thisDependency.setCanDelete(true);
      dependencyList.add(thisDependency);
    }
    rs.close();
    pst.close();
    sql =
        "SELECT COUNT(*) as documentcount " +
        "FROM project_files pf WHERE pf.link_module_id = ? and pf.link_item_id = ? ";
    i = 0;
    pst = db.prepareStatement(sql);
    pst.setInt(++i, Constants.DOCUMENTS_OPPORTUNITIES);
    pst.setInt(++i, this.getId());
    rs = pst.executeQuery();
    if (rs.next()) {
      Dependency thisDependency = new Dependency();
      thisDependency.setName("documents");
      thisDependency.setCount(rs.getInt("documentcount"));
      thisDependency.setCanDelete(true);
      dependencyList.add(thisDependency);
    }
    sql =
        "SELECT COUNT(*) as componentcount " +
        "FROM opportunity_component oc WHERE oc.opp_id = ? ";
    i = 0;
    pst = db.prepareStatement(sql);
    pst.setInt(++i, this.getId());
    rs = pst.executeQuery();
    if (rs.next()) {
      Dependency thisDependency = new Dependency();
      thisDependency.setName("components");
      thisDependency.setCount(rs.getInt("componentcount"));
      thisDependency.setCanDelete(true);
      dependencyList.add(thisDependency);
    }
    rs.close();
    pst.close();

    //Quotes dependencies
    sql =
        "SELECT COUNT(*) as quotecount " +
        "FROM quote_entry qe WHERE qe.opp_id = ? ";
    i = 0;
    pst = db.prepareStatement(sql);
    pst.setInt(++i, this.getId());
    rs = pst.executeQuery();
    if (rs.next()) {
      Dependency thisDependency = new Dependency();
      thisDependency.setName("quotes");
      thisDependency.setCount(rs.getInt("quotecount"));
      thisDependency.setCanDelete(true);
      dependencyList.add(thisDependency);
    }

    ActionList actionList = ActionItemLogList.isItemLinked(db, this.getId(), Constants.OPPORTUNITY_OBJECT);
    if (actionList != null) {
      Dependency thisDependency = new Dependency();
      thisDependency.setName("actionLists");
      thisDependency.setCount(1);
      thisDependency.setCanDelete(true);
      dependencyList.add(thisDependency);
    }
    return dependencyList;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  protected boolean delete(Connection db) throws SQLException {
    if (id == -1) {
      throw new SQLException("The Opportunity Header could not be found.");
    }

    //delete any action list items associated
    ActionItemLog.deleteLink(db, this.getId(), Constants.OPPORTUNITY_OBJECT);

    //delete the quotes
    QuoteList quoteList = new QuoteList();
    quoteList.setHeaderId(this.getId());
    quoteList.buildList(db);
    quoteList.delete(db);

    //delete the call list
    CallList callList = new CallList();
    callList.setOppHeaderId(id);
    callList.buildList(db);
    callList.delete(db);
    callList = null;

    //delete opportunity component
    PreparedStatement pst = db.prepareStatement(
        "DELETE FROM opportunity_component WHERE opp_id = ? ");
    pst.setInt(1, id);
    pst.executeUpdate();
    pst.close();

    //delete opportunity
    pst = db.prepareStatement(
        "DELETE FROM opportunity_header WHERE opp_id = ? ");
    pst.setInt(1, id);
    pst.executeUpdate();
    pst.close();
    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public boolean resetType(Connection db) throws SQLException {
    if (id == -1) {
      throw new SQLException("Opportunity ID not specified");
    }
    PreparedStatement pst = db.prepareStatement(
        "DELETE FROM opportunity_component_levels " +
        "WHERE opp_id in (SELECT id from opportunity_component oc where oc.opp_id = ?) ");
    pst.setInt(1, id);
    pst.execute();
    pst.close();
    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  baseFilePath      Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  protected boolean delete(Connection db, String baseFilePath) throws SQLException {
    if (this.getId() == -1) {
      throw new SQLException("The Opportunity Record could not be found.");
    }
    try {
      db.setAutoCommit(false);
      this.resetType(db);

      //delete any action list items associated
      ActionItemLog.deleteLink(db, this.getId(), Constants.OPPORTUNITY_OBJECT);

      CallList callList = new CallList();
      callList.setOppHeaderId(id);
      callList.buildList(db);
      callList.delete(db);
      callList = null;

      FileItemList fileList = new FileItemList();
      fileList.setLinkModuleId(Constants.PIPELINE);
      fileList.setLinkItemId(this.getId());
      fileList.buildList(db);
      fileList.delete(db, baseFilePath);
      fileList = null;

      //delete the quotes
      QuoteList quoteList = new QuoteList();
      quoteList.setHeaderId(this.getId());
      quoteList.buildList(db);
      quoteList.delete(db);
  
      //delete components
      PreparedStatement pst = db.prepareStatement(
          "DELETE FROM opportunity_component " +
          "WHERE opp_id = ? ");
      pst.setInt(1, id);
      pst.executeUpdate();
      pst.close();

      pst = db.prepareStatement(
          "DELETE FROM opportunity_header " +
          "WHERE opp_id = ? ");
      pst.setInt(1, id);
      pst.executeUpdate();
      pst.close();

      db.commit();
    } catch (SQLException e) {
      db.rollback();
    } finally {
      db.setAutoCommit(true);
    }
    return true;
  }



  /**
   *  Description of the Method
   *
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  protected void buildRecord(ResultSet rs) throws SQLException {
    id = rs.getInt("header_opp_id");
    description = rs.getString("header_description");
    accountLink = DatabaseUtils.getInt(rs, "header_acctlink");
    contactLink = DatabaseUtils.getInt(rs, "header_contactlink");
    entered = rs.getTimestamp("header_entered");
    enteredBy = rs.getInt("header_enteredby");
    modified = rs.getTimestamp("header_modified");
    modifiedBy = rs.getInt("header_modifiedby");

    //joined tables
    accountName = rs.getString("acct_name");
    accountEnabled = rs.getBoolean("accountenabled");
    String contactNameLast = rs.getString("last_name");
    String contactNameFirst = rs.getString("first_name");
    contactName = Contact.getNameLastFirst(contactNameLast, contactNameFirst);
    contactCompanyName = rs.getString("ctcompany");
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  override          Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  protected int update(Connection db, boolean override) throws SQLException {
    int resultCount = 0;
    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();
    if (System.getProperty("DEBUG") != null) {
      System.out.println("Opportunity Header-> Updating the opportunity header");
    }
    sql.append(
        "UPDATE opportunity_header " +
        "SET description = ?, acctlink = ?, contactlink = ?, ");
    if (!override) {
      sql.append("modified = " + DatabaseUtils.getCurrentTimestamp(db) + ", ");
    }
    sql.append("modifiedby = ? ");
    sql.append("WHERE opp_id = ? ");
    if (!override) {
      sql.append("AND modified = ? ");
    }
    int i = 0;
    pst = db.prepareStatement(sql.toString());
    pst.setString(++i, this.getDescription());
    DatabaseUtils.setInt(pst, ++i, accountLink);
    DatabaseUtils.setInt(pst, ++i, contactLink);
    pst.setInt(++i, modifiedBy);
    pst.setInt(++i, id);
    if (!override) {
      pst.setTimestamp(++i, modified);
    }
    resultCount = pst.executeUpdate();
    if (System.getProperty("DEBUG") != null) {
      System.out.println("Opportunity Header-> ResultCount: " + resultCount);
    }
    pst.close();
    return resultCount;
  }


  /**
   *  Retrieves count of all components
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void retrieveComponentCount(Connection db) throws SQLException {
    retrieveComponentCount(db, -1);
  }


  /**
   *  Retrieves count of all components Optionally retrieves only count of
   *  components owned by a specific user
   *
   *@param  db                Description of the Parameter
   *@param  ownerId           Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void retrieveComponentCount(Connection db, int ownerId) throws SQLException {
    int count = 0;

    PreparedStatement pst = db.prepareStatement(
        "SELECT COUNT(*) as componentcount " +
        "FROM opportunity_component oc " +
        "WHERE oc.opp_id = ? ");
    pst.setInt(1, id);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      count = rs.getInt("componentcount");
    }
    rs.close();
    pst.close();
    this.setComponentCount(count);

    if (ownerId > -1) {
      pst = db.prepareStatement(
          "SELECT COUNT(*) as componentcount " +
          "FROM opportunity_component oc " +
          "WHERE oc.opp_id = ? " +
          "AND oc.owner = ? ");
      pst.setInt(1, id);
      pst.setInt(2, ownerId);
      rs = pst.executeQuery();
      if (rs.next()) {
        count = rs.getInt("componentcount");
      }
      rs.close();
      pst.close();
      this.setOwnerComponentCount(count);
    }
  }


  /**
   *  Builds the total value of the components.<br>
   *
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void buildTotal(Connection db) throws SQLException {
    buildTotal(db, -1);
  }


  /**
   *  Builds the total value of the components.<br>
   *  Optionally builds count only for components owned by a specified user
   *
   *@param  db                Description of the Parameter
   *@param  ownerId           Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void buildTotal(Connection db, int ownerId) throws SQLException {
    double total = 0;
    PreparedStatement pst = db.prepareStatement(
        "SELECT sum(guessvalue) as total " +
        "FROM opportunity_component oc " +
        "WHERE oc.opp_id = ? AND oc.closed IS NULL " +
        (ownerId != -1 ? "AND oc.owner = ? " : ""));
    pst.setInt(1, id);
    if (ownerId != -1) {
      pst.setInt(2, ownerId);
    }
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      total = rs.getDouble("total");
    }
    rs.close();
    pst.close();
    this.setTotalValue(total);
  }


  /**
   *  Checks if the user owns atleast one of the components
   *
   *@param  db                Description of the Parameter
   *@param  id                Description of the Parameter
   *@param  userId            Description of the Parameter
   *@return                   The componentOwner value
   *@exception  SQLException  Description of the Exception
   */
  public static boolean isComponentOwner(Connection db, int id, int userId) throws SQLException {
    boolean isOwner = false;
    PreparedStatement pst = db.prepareStatement(
        "SELECT opp_id " +
        "FROM opportunity_component oc " +
        "WHERE oc.opp_id = ? AND oc.owner = ?");
    pst.setInt(1, id);
    pst.setInt(2, userId);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      isOwner = true;
    }
    rs.close();
    pst.close();
    return isOwner;
  }
}

