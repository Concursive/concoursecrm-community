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

import java.sql.*;
import java.util.*;
import org.aspcfs.utils.web.PagedListInfo;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.DateUtils;
import org.aspcfs.modules.base.Constants;

/**
 *  Description of the Class
 *
 *@author     ananth
 *@created    April 20, 2004
 *@version    $Id: CustomerProductHistoryList.java,v 1.1.2.6 2004/05/17 19:53:42
 *      partha Exp $
 */
public class CustomerProductHistoryList extends ArrayList {

  private PagedListInfo pagedListInfo = null;
  private int orgId = -1;
  private int orderId = -1;
  private int customerProductId = -1;


  /**
   *  Sets the orgId attribute of the CustomerProductHistoryList object
   *
   *@param  tmp  The new orgId value
   */
  public void setOrgId(int tmp) {
    this.orgId = tmp;
  }


  /**
   *  Sets the orgId attribute of the CustomerProductHistoryList object
   *
   *@param  tmp  The new orgId value
   */
  public void setOrgId(String tmp) {
    this.orgId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the orderId attribute of the CustomerProductHistoryList object
   *
   *@param  tmp  The new orderId value
   */
  public void setOrderId(int tmp) {
    this.orderId = tmp;
  }


  /**
   *  Sets the orderId attribute of the CustomerProductHistoryList object
   *
   *@param  tmp  The new orderId value
   */
  public void setOrderId(String tmp) {
    this.orderId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the customerProductId attribute of the CustomerProductHistoryList
   *  object
   *
   *@param  tmp  The new customerProductId value
   */
  public void setCustomerProductId(int tmp) {
    this.customerProductId = tmp;
  }


  /**
   *  Sets the customerProductId attribute of the CustomerProductHistoryList
   *  object
   *
   *@param  tmp  The new customerProductId value
   */
  public void setCustomerProductId(String tmp) {
    this.customerProductId = Integer.parseInt(tmp);
  }


  /**
   *  Gets the orgId attribute of the CustomerProductHistoryList object
   *
   *@return    The orgId value
   */
  public int getOrgId() {
    return orgId;
  }


  /**
   *  Gets the orderId attribute of the CustomerProductHistoryList object
   *
   *@return    The orderId value
   */
  public int getOrderId() {
    return orderId;
  }


  /**
   *  Gets the customerProductId attribute of the CustomerProductHistoryList
   *  object
   *
   *@return    The customerProductId value
   */
  public int getCustomerProductId() {
    return customerProductId;
  }


  /**
   *  Constructor for the CustomerProductHistoryList object
   */
  public CustomerProductHistoryList() { }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
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
        " SELECT COUNT(*) AS recordcount " +
        " FROM customer_product_history cph " +
        " WHERE cph.history_id > -1 ");

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
        pst = db.prepareStatement(sqlCount.toString() + sqlFilter.toString());
        items = prepareFilter(pst);
        //pst.setString(++items, pagedListInfo.getCurrentLetter().toLowerCase());
        rs = pst.executeQuery();
        if (rs.next()) {
          int offsetCount = rs.getInt("recordcount");
          pagedListInfo.setCurrentOffset(offsetCount);
        }
        rs.close();
        pst.close();
      }
      //Determine column to sort by
      pagedListInfo.setDefaultSort("cph.entered", null);
      pagedListInfo.appendSqlTail(db, sqlOrder);
    } else {
      sqlOrder.append("ORDER BY cph.order_id, cph.product_start_date ");
    }
    //Build a base SQL statement for returning records
    if (pagedListInfo != null) {
      pagedListInfo.appendSqlSelectHead(db, sqlSelect);
    } else {
      sqlSelect.append("SELECT ");
    }
    sqlSelect.append(
        "  cph.history_id, cph.customer_product_id, cph.org_id, cph.order_id, " +
        "  cph.product_start_date, cph.product_end_date, cph.entered, cph.enteredby, " +
        "  cph.modified, cph.modifiedby, cph.order_item_id, " +
        "  pc.product_name, pc.short_description, pcp.price_amount, pcat.category_name " +
        " FROM customer_product_history cph " +
        " LEFT JOIN order_entry o ON (cph.order_id = o.order_id) " +
        " LEFT JOIN order_product op ON (cph.order_item_id = op.item_id) " +
        " LEFT JOIN product_catalog pc ON (op.product_id = pc.product_id) " +
        " LEFT JOIN product_catalog_category_map pccm ON (pc.product_id = pccm.product_id) " +
        " LEFT JOIN product_category pcat ON (pccm.category_id = pcat.category_id) " +
        " LEFT JOIN product_catalog_pricing pcp ON (pc.product_id = pcp.product_id) " +
        " WHERE cph.history_id > -1 "
        );

    pst = db.prepareStatement(sqlSelect.toString() + sqlFilter.toString() + sqlOrder.toString());
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
      CustomerProductHistory productHistory = new CustomerProductHistory(rs);
      this.add(productHistory);
    }
    rs.close();
    pst.close();
  }


  /**
   *  Description of the Method
   *
   *@param  sqlFilter  Description of the Parameter
   */
  protected void createFilter(StringBuffer sqlFilter) {
    if (sqlFilter == null) {
      sqlFilter = new StringBuffer();
    }
    if (orgId > -1) {
      sqlFilter.append("AND cph.org_id = ? ");
    }
    if (orderId > -1) {
      sqlFilter.append("AND cph.order_id = ? ");
    }
    if (customerProductId > -1) {
      sqlFilter.append("AND cph.customer_product_id = ? ");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void delete(Connection db) throws SQLException {
    Iterator i = this.iterator();
    while (i.hasNext()) {
      CustomerProductHistory thisHistory = (CustomerProductHistory) i.next();
      thisHistory.delete(db);
    }
  }


  /**
   *  Description of the Method
   *
   *@param  pst               Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  protected int prepareFilter(PreparedStatement pst) throws SQLException {
    int i = 0;
    if (orgId > -1) {
      pst.setInt(++i, orgId);
    }
    if (orderId > -1) {
      pst.setInt(++i, orderId);
    }
    if (customerProductId > -1) {
      pst.setInt(++i, customerProductId);
    }
    return i;
  }


  /**
   *  Gets the customerProductIdFromOrderProductId attribute of the
   *  CustomerProductHistoryList object
   *
   *@param  id                Description of the Parameter
   *@return                   The customerProductIdFromOrderProductId value
   *@exception  SQLException  Description of the Exception
   */
  public int getCustomerProductIdFromOrderProductId(int id) throws SQLException {
    int result = -1;
    Iterator iterator = (Iterator) this.iterator();
    while (iterator.hasNext()) {
      CustomerProductHistory customerProductHistory = (CustomerProductHistory) iterator.next();
      if (customerProductHistory.getOrderItemId() == id) {
        result = customerProductHistory.getCustomerProductId();
        break;
      }
    }
    return result;
  }
}

