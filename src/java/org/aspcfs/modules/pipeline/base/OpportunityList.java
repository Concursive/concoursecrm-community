//Copyright 2001 Dark Horse Ventures
// The createFilter method and the prepareFilter method need to have the same
// number of parameters if modified.

package com.darkhorseventures.cfsbase;

import java.util.Vector;
import java.util.Iterator;
import java.sql.*;
import java.util.*;
import java.text.*;
import com.darkhorseventures.webutils.PagedListInfo;
import com.darkhorseventures.utils.DatabaseUtils;
import com.darkhorseventures.utils.ObjectUtils;

/**
 *  Contains a list of contacts... currently used to build the list from the
 *  database with any of the parameters to limit the results.
 *
 *@author     mrajkowski
 *@created    August 29, 2001
 *@version    $Id: OpportunityList.java,v 1.7 2001/10/03 21:26:46 mrajkowski Exp
 *      $
 */
public class OpportunityList extends Vector {

  public static final int TRUE = 1;
  public static final int FALSE = 0;
  protected int includeEnabled = 1;
  
  public static final String tableName = "opportunity";
  public static final String uniqueField = "opp_id";
  protected java.sql.Timestamp lastAnchor = null;
  protected java.sql.Timestamp nextAnchor = null;
  protected int syncType = Constants.NO_SYNC;

  protected PagedListInfo pagedListInfo = null;
  protected int orgId = -1;
  protected int contactId = -1;
  protected Vector ignoreTypeIdList = new Vector();
  protected String description = null;
  protected int enteredBy = -1;
  protected boolean hasAlertDate = false;
  protected java.sql.Date alertDate = null;
  protected int owner = -1;
  protected String ownerIdRange = null;
  protected String units = null;
  protected String accountOwnerIdRange = null;
  protected java.sql.Date alertRangeStart = null;
  protected java.sql.Date alertRangeEnd = null;
  protected java.sql.Date closeDateStart = null;
  protected java.sql.Date closeDateEnd = null;
  protected int stage = -1;
  private boolean queryOpenOnly = false;

  /**
   *  Constructor for the ContactList object
   *
   *@since    1.1
   */
  public OpportunityList() { }


  /**
   *  Sets the PagedListInfo attribute of the ContactList object
   *
   *@param  tmp  The new PagedListInfo value
   *@since       1.1
   */
  public void setPagedListInfo(PagedListInfo tmp) {
    this.pagedListInfo = tmp;
  }


  /**
   *  Sets the OrgId attribute of the ContactList object
   *
   *@param  tmp  The new OrgId value
   *@since       1.1
   */
  public void setOrgId(String tmp) {
    this.orgId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the orgId attribute of the OpportunityList object
   *
   *@param  tmp  The new orgId value
   */
  public void setOrgId(int tmp) {
    this.orgId = tmp;
  }

  public int getStage() {
	return stage;
}
public void setStage(int stage) {
	this.stage = stage;
}

public void setStage(String stage) {
	this.stage = Integer.parseInt(stage);
}


  /**
   *  Sets the TypeId attribute of the ContactList object
   *
   *@param  tmp  The new TypeId value
   *@since       1.1
   */
  public void setContactId(String tmp) {
    this.contactId = Integer.parseInt(tmp);
  }
  
  public void setContactId(int tmp) {
    this.contactId = tmp;
  }


  /**
   *  Sets the Description attribute of the OpportunityList object
   *
   *@param  description  The new Description value
   */
  public void setDescription(String description) {
    this.description = description;
  }


  /**
   *  Sets the EnteredBy attribute of the OpportunityList object
   *
   *@param  tmp  The new EnteredBy value
   */
  public void setEnteredBy(int tmp) {
    this.enteredBy = tmp;
  }


  /**
   *  Sets the accountOwnerIdRange attribute of the OpportunityList object
   *
   *@param  accountOwnerIdRange  The new accountOwnerIdRange value
   */
  public void setAccountOwnerIdRange(String accountOwnerIdRange) {
    this.accountOwnerIdRange = accountOwnerIdRange;
  }
  
  public int getIncludeEnabled() {
	return includeEnabled;
  }
  public void setIncludeEnabled(int includeEnabled) {
	this.includeEnabled = includeEnabled;
  }

  /**
   *  Sets the OwnerIdRange attribute of the OpportunityList object
   *
   *@param  ownerIdRange  The new OwnerIdRange value
   */
  public void setOwnerIdRange(String ownerIdRange) {
    this.ownerIdRange = ownerIdRange;
  }
  
  public void setAlertRangeStart(java.sql.Date tmp) { this.alertRangeStart = tmp; }
  public void setAlertRangeStart(String tmp) { 
    this.alertRangeStart = java.sql.Date.valueOf(tmp);
  }
  public void setAlertRangeEnd(java.sql.Date tmp) { this.alertRangeEnd = tmp; }
  public void setAlertRangeEnd(String tmp) { 
    this.alertRangeEnd = java.sql.Date.valueOf(tmp);
  }
  
  public java.sql.Date getAlertRangeStart() { return alertRangeStart; }
  public java.sql.Date getAlertRangeEnd() { return alertRangeEnd; }
  
  public boolean getQueryOpenOnly() {
    return queryOpenOnly;
  }
  public void setQueryOpenOnly(boolean queryOpenOnly) {
    this.queryOpenOnly = queryOpenOnly;
  }

  /**
   *  Sets the HasAlertDate attribute of the OpportunityList object
   *
   *@param  tmp  The new HasAlertDate value
   */
  public void setHasAlertDate(boolean tmp) {
    this.hasAlertDate = tmp;
  }

  /**
   *  Sets the AlertDate attribute of the OpportunityList object
   *
   *@param  tmp  The new AlertDate value
   */
  public void setAlertDate(java.sql.Date tmp) {
    this.alertDate = tmp;
  }
  
  public String getTableName() {
    return tableName;
  }
  
  public String getUniqueField() {
    return uniqueField;
  }

public java.sql.Date getCloseDateStart() { return closeDateStart; }
public java.sql.Date getCloseDateEnd() { return closeDateEnd; }
public void setCloseDateStart(java.sql.Date tmp) { this.closeDateStart = tmp; }

public void setCloseDateStart(String tmp) {
    try {
      java.util.Date tmpDate = DateFormat.getDateInstance(3).parse(tmp);
      closeDateStart = new java.sql.Date(new java.util.Date().getTime());
      closeDateStart.setTime(tmpDate.getTime());
    } catch (Exception e) {
      closeDateStart = null;
    }
}
    
public void setCloseDateEnd(java.sql.Date tmp) { this.closeDateEnd = tmp; }

public void setCloseDateEnd(String tmp) {
    try {
      java.util.Date tmpDate = DateFormat.getDateInstance(3).parse(tmp);
      closeDateEnd = new java.sql.Date(new java.util.Date().getTime());
      closeDateEnd.setTime(tmpDate.getTime());
    } catch (Exception e) {
      closeDateEnd = null;
    }
}

  /**
   *  Sets the owner attribute of the OpportunityList object
   *
   *@param  tmp  The new owner value
   */
  public void setOwner(int tmp) {
    this.owner = tmp;
  }


  /**
   *  Sets the Units attribute of the OpportunityList object
   *
   *@param  units  The new Units value
   */
  public void setUnits(String units) {
    this.units = units;
  }


  /**
   *  Gets the accountOwnerIdRange attribute of the OpportunityList object
   *
   *@return    The accountOwnerIdRange value
   */
  public String getAccountOwnerIdRange() {
    return accountOwnerIdRange;
  }


  /**
   *  Gets the OwnerIdRange attribute of the OpportunityList object
   *
   *@return    The OwnerIdRange value
   */
  public String getOwnerIdRange() {
    return ownerIdRange;
  }


  /**
   *  Gets the ListSize attribute of the OpportunityList object
   *
   *@return    The ListSize value
   */
  public int getListSize() {
    return this.size();
  }


  /**
   *  Gets the Units attribute of the OpportunityList object
   *
   *@return    The Units value
   */
  public String getUnits() {
    return units;
  }


  /**
   *  Gets the EnteredBy attribute of the OpportunityList object
   *
   *@return    The EnteredBy value
   */
  public int getEnteredBy() {
    return enteredBy;
  }


  /**
   *  Gets the HasAlertDate attribute of the OpportunityList object
   *
   *@return    The HasAlertDate value
   */
  public boolean getHasAlertDate() {
    return hasAlertDate;
  }


  /**
   *  Gets the Description attribute of the OpportunityList object
   *
   *@return    The Description value
   */
  public String getDescription() {
    return description;
  }


  /**
   *  Builds a list of contacts based on several parameters. The parameters are
   *  set after this object is constructed, then the buildList method is called
   *  to generate the list.
   *
   *@param  db                Description of Parameter
   *@exception  SQLException  Description of Exception
   *@since                    1.1
   */
  public void buildList(Connection db) throws SQLException {

    PreparedStatement pst = null;
    ResultSet rs = null;
    int items = -1;

    //String whereClause = "";

    /*
    if (orgId == -1) {
      whereClause = " x.acctlink like '%' ";
    } else {
      whereClause = " x.acctlink = " + orgId + " ";
    }
    */

    StringBuffer sqlSelect = new StringBuffer();
    StringBuffer sqlCount = new StringBuffer();
    StringBuffer sqlFilter = new StringBuffer();
    StringBuffer sqlOrder = new StringBuffer();

    //Need to build a base SQL statement for counting records
    sqlCount.append(
      "SELECT COUNT(*) AS recordcount " +
      "FROM opportunity x " +
      "WHERE x.opp_id > -1 ");
      /**
      + "WHERE " + whereClause);
      */

    createFilter(sqlFilter);

    if (pagedListInfo != null) {
      //Get the total number of records matching filter
      pst = db.prepareStatement(sqlCount.toString() +
          sqlFilter.toString());
      items = prepareFilter(pst);
      rs = pst.executeQuery();
      if (rs.next()) {
        int maxRecords = rs.getInt("recordcount");
        pagedListInfo.setMaxRecords(maxRecords);
      }
      pst.close();
      rs.close();

      //Determine the offset, based on the filter, for the first record to show
      if (!pagedListInfo.getCurrentLetter().equals("")) {
        pst = db.prepareStatement(sqlCount.toString() +
            sqlFilter.toString() +
            "AND x.description < ? ");
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
      
      pagedListInfo.setDefaultSort("x.description", null);
      pagedListInfo.appendSqlTail(db, sqlOrder);
    } else {
      sqlOrder.append("ORDER BY x.entered");
    }

    //Need to build a base SQL statement for returning records
    if (pagedListInfo != null) {
      pagedListInfo.appendSqlSelectHead(db, sqlSelect);
    } else {
      sqlSelect.append("SELECT ");
    }
    sqlSelect.append(
      "x.*, y.description as stagename, org.name as acct_name, org.enabled as accountenabled, " +
      "ct.namelast as last_name, ct.namefirst as first_name, " +
      "ct.company as ctcompany," +
      "ct_owner.namelast as o_namelast, ct_owner.namefirst as o_namefirst, " +
      "ct_eb.namelast as eb_namelast, ct_eb.namefirst as eb_namefirst, " +
      "ct_mb.namelast as mb_namelast, ct_mb.namefirst as mb_namefirst " +
      "FROM opportunity x " +
      "LEFT JOIN organization org ON (x.acctlink = org.org_id) " +
      "LEFT JOIN contact ct_owner ON (x.owner = ct_owner.user_id) " +
      "LEFT JOIN contact ct_eb ON (x.enteredby = ct_eb.user_id) " +
      "LEFT JOIN contact ct_mb ON (x.modifiedby = ct_mb.user_id) " +
      "LEFT JOIN contact ct ON (x.contactlink = ct.contact_id), " +
      "lookup_stage y " +
      "WHERE x.stage = y.code ");
      //"WHERE x.stage = y.code AND " + whereClause);
    pst = db.prepareStatement(
      sqlSelect.toString() + 
      sqlFilter.toString() + 
      sqlOrder.toString());
    items = prepareFilter(pst);
    rs = pst.executeQuery();
    if (pagedListInfo != null) {
      pagedListInfo.doManualOffset(db, rs);
    }
    int count = 0;
    while (rs.next()) {
      if (pagedListInfo != null && pagedListInfo.getItemsPerPage() > 0 &&
          DatabaseUtils.getType(db) == DatabaseUtils.MSSQL &&
          count >= pagedListInfo.getItemsPerPage()) {
        break;
      }
      ++count;
      Opportunity thisOpp = new Opportunity(rs);
      thisOpp.buildFiles(db);
      this.addElement(thisOpp);
    }
    rs.close();
    pst.close();
  }


  /**
   *  Adds a feature to the IgnoreTypeId attribute of the ContactList object
   *
   *@param  tmp  The feature to be added to the IgnoreTypeId attribute
   *@since       1.2
   */
  public void addIgnoreTypeId(String tmp) {
    ignoreTypeIdList.addElement(tmp);
  }


  /**
   *  Adds a feature to the IgnoreTypeId attribute of the ContactList object
   *
   *@param  tmp  The feature to be added to the IgnoreTypeId attribute
   *@since       1.2
   */
  public void addIgnoreTypeId(int tmp) {
    ignoreTypeIdList.addElement("" + tmp);
  }
  
  public int reassignElements(Connection db, int newOwner) throws SQLException {
    int total = 0;
    Iterator i = this.iterator();
    while (i.hasNext()) {
      Opportunity thisOpp = (Opportunity) i.next();
      if (thisOpp.reassign(db, newOwner)) {
        total++;
      }
    }
    return total;
  }    

  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@exception  SQLException  Description of Exception
   */
  public void delete(Connection db) throws SQLException {
    Iterator opportunities = this.iterator();
    while (opportunities.hasNext()) {
      Opportunity thisOpportunity = (Opportunity) opportunities.next();
      thisOpportunity.delete(db);
    }
  }


  /**
   *  Builds a base SQL where statement for filtering records to be used by
   *  sqlSelect and sqlCount
   *
   *@param  sqlFilter  Description of Parameter
   *@since             1.3
   */
  protected void createFilter(StringBuffer sqlFilter) {
    if (sqlFilter == null) {
      sqlFilter = new StringBuffer();
    }

    if (orgId != -1) {
      sqlFilter.append("AND acctlink = ? ");
    }

    if (contactId != -1) {
      sqlFilter.append("AND contactlink = ? ");
    }

    if (enteredBy != -1) {
      sqlFilter.append("AND x.enteredby = ? ");
    }

    if (hasAlertDate == true) {
      sqlFilter.append("AND x.alertdate IS NOT NULL ");
    }

    if (ignoreTypeIdList.size() > 0) {
      Iterator iList = ignoreTypeIdList.iterator();
      sqlFilter.append("AND contactlink NOT IN (");
      while (iList.hasNext()) {
        String placeHolder = (String) iList.next();
        sqlFilter.append("?");
        if (iList.hasNext()) {
          sqlFilter.append(",");
        }
      }
      sqlFilter.append(") ");
    }

    if (description != null) {
      if (description.indexOf("%") >= 0) {
        sqlFilter.append("AND lower(x.description) like lower(?) ");
      } else {
        sqlFilter.append("AND lower(x.description) = lower(?) ");
      }
    }

    if (alertDate != null) {
      sqlFilter.append("AND x.alertdate = ? ");
    }
    
    if (alertRangeStart != null) {
      sqlFilter.append("AND x.alertdate >= ? ");
    }
    if (alertRangeEnd != null) {
      sqlFilter.append("AND x.alertdate <= ? ");
    }
    
    if (closeDateStart != null) {
      sqlFilter.append("AND x.closedate >= ? ");
    }
    if (closeDateEnd != null) {
      sqlFilter.append("AND x.closedate <= ? ");
    }

    if (owner != -1) {
      sqlFilter.append("AND x.owner = ? ");
    }

    if (ownerIdRange != null) {
      sqlFilter.append("AND x.owner in (" + this.ownerIdRange + ") ");
    }

    if (accountOwnerIdRange != null) {
      sqlFilter.append("AND x.acctlink IN (SELECT org_id FROM organization WHERE owner IN (" + accountOwnerIdRange + ")) ");
    }

    if (units != null) {
      sqlFilter.append("AND units = ? ");
    }
    
    if (includeEnabled == TRUE || includeEnabled == FALSE) {
      sqlFilter.append("AND x.enabled = ? ");
    }
    
    if (stage != -1) {
      sqlFilter.append("AND x.stage = ? ");
    }
    
    if (queryOpenOnly) {
      sqlFilter.append("AND x.closed IS NULL ");
    }
	
  }


  /**
   *  Sets the parameters for the preparedStatement - these items must
   *  correspond with the createFilter statement
   *
   *@param  pst               Description os.gerameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   *@since                    1.3
   */
  protected int prepareFilter(PreparedStatement pst) throws SQLException {
    int i = 0;
    if (orgId != -1) {
      pst.setInt(++i, orgId);
    }

    if (contactId != -1) {
      pst.setInt(++i, contactId);
    }

    if (enteredBy != -1) {
      pst.setInt(++i, enteredBy);
    }

    if (ignoreTypeIdList.size() > 0) {
      Iterator iList = ignoreTypeIdList.iterator();
      while (iList.hasNext()) {
        int thisType = Integer.parseInt((String) iList.next());
        pst.setInt(++i, thisType);
      }
    }

    if (description != null) {
      pst.setString(++i, description);
    }

    if (alertDate != null) {
      pst.setDate(++i, alertDate);
    }
    
    if (alertRangeStart != null) {
      pst.setDate(++i, alertRangeStart);
    }
    
    if (alertRangeEnd != null) {
      pst.setDate(++i, alertRangeEnd);
    }
    
    if (closeDateStart != null) {
      pst.setDate(++i, closeDateStart);
    }
    
    if (closeDateEnd != null) {
      pst.setDate(++i, closeDateEnd);
    }

    if (owner != -1) {
      pst.setInt(++i, owner);
    }

    if (units != null) {
      pst.setString(++i, units);
    }
    
    if (includeEnabled == TRUE) {
      pst.setBoolean(++i, true);
    } else if (includeEnabled == FALSE) {
      pst.setBoolean(++i, false);
    }
    
    if (stage != -1) {
      pst.setInt(++i, stage);
    }

    return i;
  }
  
  public static int retrieveRecordCount(Connection db, int moduleId, int itemId) throws SQLException {
    int count = 0;
    StringBuffer sql = new StringBuffer();
    sql.append(
      "SELECT COUNT(*) as itemcount " +
      "FROM opportunity o " +
      "WHERE opp_id > 0 ");
    if (moduleId == Constants.ACCOUNTS) {  
      sql.append("AND o.acctlink = ? ");
    }
    PreparedStatement pst = db.prepareStatement(sql.toString());
    if (moduleId == Constants.ACCOUNTS) {
      pst.setInt(1, itemId);
    }
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      count = rs.getInt("itemcount");
    }
    rs.close();
    pst.close();
    return count;
  }

}

