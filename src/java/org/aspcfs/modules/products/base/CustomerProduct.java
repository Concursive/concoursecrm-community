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
package org.aspcfs.modules.products.base;

import com.darkhorseventures.framework.beans.*;
import java.util.*;
import java.sql.*;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.DateUtils;
import org.aspcfs.modules.base.Dependency;
import org.aspcfs.modules.base.DependencyList;
import com.zeroio.iteam.base.*;
import com.zeroio.webutils.*;
import com.isavvix.tools.*;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.orders.base.*;

/**
 *  Description of the Class
 *
 *@author     ananth
 *@created    April 20, 2004
 *@version    $Id: CustomerProduct.java,v 1.3 2004/06/03 16:04:04 mrajkowski Exp
 *      $
 */
public class CustomerProduct extends GenericBean {

  private int id = -1;
  private int orgId = -1;
  private int orderId = -1;
  private int orderItemId = -1;
  private String description = null;
  private int statusId = -1;
  private Timestamp statusDate = null;
  // record status
  private Timestamp entered = null;
  private int enteredBy = -1;
  private Timestamp modified = null;
  private int modifiedBy = -1;
  private boolean enabled = true;
  //resources
  private boolean buildFileList = false;
  private FileItemList fileItemList = new FileItemList();
  private boolean buildHistoryList = false;
  private CustomerProductHistoryList historyList = new CustomerProductHistoryList();

  private Timestamp lastOrdered = null;
  private Order lastOrder = null;



  /**
   *  Sets the buildHistoryList attribute of the CustomerProduct object
   *
   *@param  tmp  The new buildHistoryList value
   */
  public void setBuildHistoryList(boolean tmp) {
    this.buildHistoryList = tmp;
  }


  /**
   *  Sets the buildHistoryList attribute of the CustomerProduct object
   *
   *@param  tmp  The new buildHistoryList value
   */
  public void setBuildHistoryList(String tmp) {
    this.buildHistoryList = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Gets the buildHistoryList attribute of the CustomerProduct object
   *
   *@return    The buildHistoryList value
   */
  public boolean getBuildHistoryList() {
    return buildHistoryList;
  }


  /**
   *  Sets the lastOrder attribute of the CustomerProduct object
   *
   *@param  tmp  The new lastOrder value
   */
  public void setLastOrder(Order tmp) {
    this.lastOrder = tmp;
  }


  /**
   *  Gets the lastOrder attribute of the CustomerProduct object
   *
   *@return    The lastOrder value
   */
  public Order getLastOrder() {
    return lastOrder;
  }


  /**
   *  Sets the lastOrdered attribute of the CustomerProduct object
   *
   *@param  tmp  The new lastOrdered value
   */
  public void setLastOrdered(Timestamp tmp) {
    this.lastOrdered = tmp;
  }


  /**
   *  Sets the lastOrdered attribute of the CustomerProduct object
   *
   *@param  tmp  The new lastOrdered value
   */
  public void setLastOrdered(String tmp) {
    this.lastOrdered = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   *  Gets the lastOrdered attribute of the CustomerProduct object
   *
   *@return    The lastOrdered value
   */
  public Timestamp getLastOrdered() {
    return lastOrdered;
  }


  /**
   *  Sets the historyList attribute of the CustomerProduct object
   *
   *@param  tmp  The new historyList value
   */
  public void setHistoryList(CustomerProductHistoryList tmp) {
    this.historyList = tmp;
  }


  /**
   *  Gets the historyList attribute of the CustomerProduct object
   *
   *@return    The historyList value
   */
  public CustomerProductHistoryList getHistoryList() {
    return historyList;
  }


  /**
   *  Sets the buildFileList attribute of the CustomerProduct object
   *
   *@param  tmp  The new buildFileList value
   */
  public void setBuildFileList(boolean tmp) {
    this.buildFileList = tmp;
  }


  /**
   *  Sets the buildFileList attribute of the CustomerProduct object
   *
   *@param  tmp  The new buildFileList value
   */
  public void setBuildFileList(String tmp) {
    this.buildFileList = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Sets the fileItemList attribute of the CustomerProduct object
   *
   *@param  tmp  The new fileItemList value
   */
  public void setFileItemList(FileItemList tmp) {
    this.fileItemList = tmp;
  }


  /**
   *  Gets the buildFileList attribute of the CustomerProduct object
   *
   *@return    The buildFileList value
   */
  public boolean getBuildFileList() {
    return buildFileList;
  }


  /**
   *  Gets the fileItemList attribute of the CustomerProduct object
   *
   *@return    The fileItemList value
   */
  public FileItemList getFileItemList() {
    return fileItemList;
  }


  /**
   *  Sets the enabled attribute of the CustomerProduct object
   *
   *@param  tmp  The new enabled value
   */
  public void setEnabled(boolean tmp) {
    this.enabled = tmp;
  }


  /**
   *  Sets the enabled attribute of the CustomerProduct object
   *
   *@param  tmp  The new enabled value
   */
  public void setEnabled(String tmp) {
    this.enabled = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Gets the enabled attribute of the CustomerProduct object
   *
   *@return    The enabled value
   */
  public boolean getEnabled() {
    return enabled;
  }


  /**
   *  Sets the id attribute of the CustomerProduct object
   *
   *@param  tmp  The new id value
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   *  Sets the id attribute of the CustomerProduct object
   *
   *@param  tmp  The new id value
   */
  public void setId(String tmp) {
    this.id = Integer.parseInt(tmp);
  }


  /**
   *  Sets the orgId attribute of the CustomerProduct object
   *
   *@param  tmp  The new orgId value
   */
  public void setOrgId(int tmp) {
    this.orgId = tmp;
  }


  /**
   *  Sets the orgId attribute of the CustomerProduct object
   *
   *@param  tmp  The new orgId value
   */
  public void setOrgId(String tmp) {
    this.orgId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the orderId attribute of the CustomerProduct object
   *
   *@param  tmp  The new orderId value
   */
  public void setOrderId(int tmp) {
    this.orderId = tmp;
  }


  /**
   *  Sets the orderId attribute of the CustomerProduct object
   *
   *@param  tmp  The new orderId value
   */
  public void setOrderId(String tmp) {
    this.orderId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the orderItemId attribute of the CustomerProduct object
   *
   *@param  tmp  The new orderItemId value
   */
  public void setOrderItemId(int tmp) {
    this.orderItemId = tmp;
  }


  /**
   *  Sets the orderItemId attribute of the CustomerProduct object
   *
   *@param  tmp  The new orderItemId value
   */
  public void setOrderItemId(String tmp) {
    this.orderItemId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the description attribute of the CustomerProduct object
   *
   *@param  tmp  The new description value
   */
  public void setDescription(String tmp) {
    this.description = tmp;
  }


  /**
   *  Sets the statusId attribute of the CustomerProduct object
   *
   *@param  tmp  The new statusId value
   */
  public void setStatusId(int tmp) {
    this.statusId = tmp;
  }


  /**
   *  Sets the statusId attribute of the CustomerProduct object
   *
   *@param  tmp  The new statusId value
   */
  public void setStatusId(String tmp) {
    this.statusId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the statusDate attribute of the CustomerProduct object
   *
   *@param  tmp  The new statusDate value
   */
  public void setStatusDate(Timestamp tmp) {
    this.statusDate = tmp;
  }


  /**
   *  Sets the statusDate attribute of the CustomerProduct object
   *
   *@param  tmp  The new statusDate value
   */
  public void setStatusDate(String tmp) {
    this.statusDate = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   *  Sets the entered attribute of the CustomerProduct object
   *
   *@param  tmp  The new entered value
   */
  public void setEntered(Timestamp tmp) {
    this.entered = tmp;
  }


  /**
   *  Sets the entered attribute of the CustomerProduct object
   *
   *@param  tmp  The new entered value
   */
  public void setEntered(String tmp) {
    this.entered = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   *  Sets the enteredBy attribute of the CustomerProduct object
   *
   *@param  tmp  The new enteredBy value
   */
  public void setEnteredBy(int tmp) {
    this.enteredBy = tmp;
  }


  /**
   *  Sets the enteredBy attribute of the CustomerProduct object
   *
   *@param  tmp  The new enteredBy value
   */
  public void setEnteredBy(String tmp) {
    this.enteredBy = Integer.parseInt(tmp);
  }


  /**
   *  Sets the modified attribute of the CustomerProduct object
   *
   *@param  tmp  The new modified value
   */
  public void setModified(Timestamp tmp) {
    this.modified = tmp;
  }


  /**
   *  Sets the modified attribute of the CustomerProduct object
   *
   *@param  tmp  The new modified value
   */
  public void setModified(String tmp) {
    this.modified = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   *  Sets the modifiedBy attribute of the CustomerProduct object
   *
   *@param  tmp  The new modifiedBy value
   */
  public void setModifiedBy(int tmp) {
    this.modifiedBy = tmp;
  }


  /**
   *  Sets the modifiedBy attribute of the CustomerProduct object
   *
   *@param  tmp  The new modifiedBy value
   */
  public void setModifiedBy(String tmp) {
    this.modifiedBy = Integer.parseInt(tmp);
  }


  /**
   *  Gets the id attribute of the CustomerProduct object
   *
   *@return    The id value
   */
  public int getId() {
    return id;
  }


  /**
   *  Gets the orgId attribute of the CustomerProduct object
   *
   *@return    The orgId value
   */
  public int getOrgId() {
    return orgId;
  }


  /**
   *  Gets the orderId attribute of the CustomerProduct object
   *
   *@return    The orderId value
   */
  public int getOrderId() {
    return orderId;
  }


  /**
   *  Gets the orderItemId attribute of the CustomerProduct object
   *
   *@return    The orderItemId value
   */
  public int getOrderItemId() {
    return orderItemId;
  }


  /**
   *  Gets the description attribute of the CustomerProduct object
   *
   *@return    The description value
   */
  public String getDescription() {
    return description;
  }


  /**
   *  Gets the statusId attribute of the CustomerProduct object
   *
   *@return    The statusId value
   */
  public int getStatusId() {
    return statusId;
  }


  /**
   *  Gets the statusDate attribute of the CustomerProduct object
   *
   *@return    The statusDate value
   */
  public Timestamp getStatusDate() {
    return statusDate;
  }


  /**
   *  Gets the entered attribute of the CustomerProduct object
   *
   *@return    The entered value
   */
  public Timestamp getEntered() {
    return entered;
  }


  /**
   *  Gets the enteredBy attribute of the CustomerProduct object
   *
   *@return    The enteredBy value
   */
  public int getEnteredBy() {
    return enteredBy;
  }


  /**
   *  Gets the modified attribute of the CustomerProduct object
   *
   *@return    The modified value
   */
  public Timestamp getModified() {
    return modified;
  }


  /**
   *  Gets the modifiedBy attribute of the CustomerProduct object
   *
   *@return    The modifiedBy value
   */
  public int getModifiedBy() {
    return modifiedBy;
  }


  /**
   *  Constructor for the CustomerProduct object
   */
  public CustomerProduct() { }


  /**
   *  Constructor for the CustomerProduct object
   *
   *@param  db                Description of the Parameter
   *@param  id                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public CustomerProduct(Connection db, int id) throws SQLException {
    queryRecord(db, id);
  }


  /**
   *  Constructor for the CustomerProduct object
   *
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public CustomerProduct(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void buildFileList(Connection db) throws SQLException {
    fileItemList.setLinkModuleId(Constants.DOCUMENTS_CUSTOMER_PRODUCT);
    fileItemList.setLinkItemId(this.getId());
    fileItemList.buildList(db);
    //TODO: determine the actual place for this code
    Iterator i = fileItemList.iterator();
    while (i.hasNext()) {
      FileItem thisItem = (FileItem) i.next();
      thisItem.buildVersionList(db);
    }
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void buildHistoryList(Connection db) throws SQLException {
    historyList.setOrgId(this.getOrgId());
    historyList.setCustomerProductId(this.getId());
    historyList.buildList(db);
    if (historyList.size() > 1) {
      /*
       *  The history list size will be 1, if the customer product has never been used and the history item refers to the
       *  time the customer product was uploaded.
       *  The history list size will be > 1, if the customer product has been used atleast once. If it has been used before,
       *  then get the last history item in the list which corresponds to the last order that used it
       */
      CustomerProductHistory thisHistory = (CustomerProductHistory) historyList.get(historyList.size() - 1);
      lastOrdered = thisHistory.getProductStartDate();
      lastOrder = new Order(db, thisHistory.getOrderId());
    }
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
      throw new SQLException("Invalid Customer Product Number");
    }

    PreparedStatement pst = db.prepareStatement(
        " SELECT cp.* " +
        " FROM customer_product cp " +
        " WHERE cp.customer_product_id = ? "
        );
    pst.setInt(1, id);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    }
    rs.close();
    pst.close();
    if (this.id == -1) {
      throw new SQLException("Customer Product not found");
    }
    if (buildFileList) {
      this.buildFileList(db);
    }
    if (buildHistoryList) {
      this.buildHistoryList(db);
    }
  }


  /**
   *  Description of the Method
   *
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  protected void buildRecord(ResultSet rs) throws SQLException {
    // customer_product table
    this.setId(rs.getInt("customer_product_id"));
    orgId = rs.getInt("org_id");
    orderId = DatabaseUtils.getInt(rs, "order_id");
    orderItemId = DatabaseUtils.getInt(rs, "order_item_id");
    description = rs.getString("description");
    statusId = DatabaseUtils.getInt(rs, "status_id");
    statusDate = rs.getTimestamp("status_date");
    entered = rs.getTimestamp("entered");
    enteredBy = rs.getInt("enteredby");
    modified = rs.getTimestamp("modified");
    modifiedBy = rs.getInt("modifiedby");
    enabled = rs.getBoolean("enabled");
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public boolean insert(Connection db) throws SQLException {
    boolean result = false;
    if (!isValid(db)) {
      return result;
    }

    StringBuffer sql = new StringBuffer();
    sql.append(
        "INSERT INTO customer_product(org_id, order_id, order_item_id, description, " +
        " status_id, status_date, ");

    if (entered != null) {
      sql.append("entered, ");
    }
    sql.append("enteredby, ");
    if (modified != null) {
      sql.append("modified, ");
    }
    sql.append("modifiedby, enabled) ");
    sql.append("VALUES( ?, ?, ?, ?, ?, ?, ");
    if (entered != null) {
      sql.append("?, ");
    }
    sql.append("?, ");
    if (modified != null) {
      sql.append("?, ");
    }
    sql.append("?, ? )");
    int i = 0;
    PreparedStatement pst = db.prepareStatement(sql.toString());
    pst.setInt(++i, this.getOrgId());
    DatabaseUtils.setInt(pst, ++i, this.getOrderId());
    DatabaseUtils.setInt(pst, ++i, this.getOrderItemId());
    pst.setString(++i, this.getDescription());
    DatabaseUtils.setInt(pst, ++i, this.getStatusId());
    pst.setTimestamp(++i, this.getStatusDate());
    if (entered != null) {
      pst.setTimestamp(++i, this.getEntered());
    }
    pst.setInt(++i, this.getEnteredBy());
    if (modified != null) {
      pst.setTimestamp(++i, this.getModified());
    }
    pst.setInt(++i, this.getModifiedBy());
    pst.setBoolean(++i, this.getEnabled());
    pst.execute();
    pst.close();
    id = DatabaseUtils.getCurrVal(db, "customer_product_customer_product_id_seq");
    result = true;
    return result;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public boolean delete(Connection db) throws SQLException {
    if (this.getId() == -1) {
      throw new SQLException("Customer Product ID not specified");
    }
    boolean recordDeleted = false;
    try {
      db.setAutoCommit(false);
      //TODO: code to delete customer product  history
      this.buildHistoryList(db);
      if (historyList.size() == 1) {
        // If the history list has just one entry for this customer product
        // then it can be infered that this customer product has not been used in
        // any ad run. Hence it is safe to delete this customer product

        // Delete the customer product history
        historyList.delete(db);
        // Delete this customer product
        PreparedStatement pst = db.prepareStatement(" DELETE FROM customer_product WHERE customer_product_id = ? ");
        pst.setInt(1, this.getId());
        pst.execute();
        pst.close();
        // Delete the dummy order product that maps to this customer product
        OrderProduct thisProduct = new OrderProduct(db, this.getOrderItemId());
        thisProduct.delete(db);
        // Delete the dummy order that maps to this customer product
        Order thisOrder = new Order(db, this.getOrderId());
        recordDeleted = thisOrder.delete(db);
        db.commit();
      }
    } catch (SQLException e) {
      db.rollback();
    } finally {
      db.setAutoCommit(true);
    }
    return recordDeleted;
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
    if (!isValid(db)) {
      return -1;
    }
    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();

    sql.append(" UPDATE customer_product " +
        " SET description = ?, " +
        "     status_id = ?, " +
        "     status_date = ?, " +
        "     modified = " + DatabaseUtils.getCurrentTimestamp(db) + ", " +
        "     modifiedby = ?, " +
        "     enabled = ? "
        );
    sql.append("WHERE order_id = ? ");
    sql.append("AND modified = ? ");

    int i = 0;
    pst = db.prepareStatement(sql.toString());
    pst.setString(++i, this.getDescription());
    DatabaseUtils.setInt(pst, ++i, this.getStatusId());
    pst.setTimestamp(++i, this.getStatusDate());
    pst.setInt(++i, this.getModifiedBy());
    pst.setInt(++i, this.getId());
    pst.setTimestamp(++i, this.getModified());
    pst.setBoolean(++i, this.getEnabled());
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
  public DependencyList processDependencies(Connection db) throws SQLException {
    DependencyList dependencyList = new DependencyList();
    if (historyList.size() > 1) {
      Dependency thisDependency = new Dependency();
      thisDependency.setName("History Exists");
      thisDependency.setCount(FileItemList.retrieveRecordCount(db, Constants.DOCUMENTS_CUSTOMER_PRODUCT, this.getId()));
      thisDependency.setCanDelete(false);
      dependencyList.add(thisDependency);
    }
    return dependencyList;
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Return Value
   */
  public boolean hasHistory() {
    if (historyList != null) {
      if (historyList.size() > 1) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }


  /**
   *  Gets the valid attribute of the CustomerProduct object
   *
   *@param  db                Description of the Parameter
   *@return                   The valid value
   *@exception  SQLException  Description of the Exception
   */
  protected boolean isValid(Connection db) throws SQLException {
    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  id                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void queryRecordFromItemId(Connection db, int id) throws SQLException {
    if (id == -1) {
      throw new SQLException("Invalid Order Product Number");
    }

    PreparedStatement pst = db.prepareStatement(
        " SELECT cp.* " +
        " FROM customer_product cp " +
        " LEFT JOIN customer_product_history hist " +
        " ON ( cp.customer_product_id = hist.customer_product_id ) " +
        " WHERE hist.order_item_id = ? "
        );
    pst.setInt(1, id);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    }
    rs.close();
    pst.close();

    if (this.getId() == -1) {
      throw new SQLException("Customer Product not found");
    }
    if (buildFileList) {
      this.buildFileList(db);
    }
    if (buildHistoryList) {
      this.buildHistoryList(db);
    }
  }

}

