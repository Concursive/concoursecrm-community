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
package org.aspcfs.modules.orders.base;

import java.sql.*;
import java.text.*;
import java.util.*;
import org.aspcfs.utils.web.PagedListInfo;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.DateUtils;

/**
 *  This represents a list of Product Options of a particular product associated
 *  with a product
 *
 *@author     ananth
 *@created    March 18, 2004
 *@version    $Id: OrderProductOptionList.java,v 1.2 2004/05/04 15:52:27
 *      mrajkowski Exp $
 */
public class OrderProductOptionList extends ArrayList {
  private int itemId = -1;
  private int statusId = -1;


  /**
   *  Sets the itemId attribute of the OrderProductOptionList object
   *
   *@param  tmp  The new itemId value
   */
  public void setItemId(int tmp) {
    this.itemId = tmp;
  }


  /**
   *  Sets the itemId attribute of the OrderProductOptionList object
   *
   *@param  tmp  The new itemId value
   */
  public void setItemId(String tmp) {
    this.itemId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the statusId attribute of the OrderProductOptionList object
   *
   *@param  tmp  The new statusId value
   */
  public void setStatusId(int tmp) {
    this.statusId = tmp;
  }


  /**
   *  Sets the statusId attribute of the OrderProductOptionList object
   *
   *@param  tmp  The new statusId value
   */
  public void setStatusId(String tmp) {
    this.statusId = Integer.parseInt(tmp);
  }


  /**
   *  Gets the itemId attribute of the OrderProductOptionList object
   *
   *@return    The itemId value
   */
  public int getItemId() {
    return itemId;
  }


  /**
   *  Gets the statusId attribute of the OrderProductOptionList object
   *
   *@return    The statusId value
   */
  public int getStatusId() {
    return statusId;
  }


  /**
   *  Constructor for the OrderProductOptionList object
   */
  public OrderProductOptionList() { }


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
        "SELECT COUNT(*) AS recordcount " +
        "FROM order_product_options opo " +
        "WHERE opo.order_product_option_id > -1 ");
    createFilter(sqlFilter);
    sqlOrder.append("ORDER BY status_id");
    //Build a base SQL statement for returning records
    sqlSelect.append("SELECT ");
    sqlSelect.append(
        "     opt.order_product_option_id, opt.item_id, opt.product_option_id, " +
        "     opt.quantity, opt.price_currency, opt.price_amount, opt.recurring_currency, " +
        "     opt.recurring_amount, opt.recurring_type, opt.extended_price, " +
        "     opt.total_price, opt.status_id, " +
        "     prod.product_id " +
        " FROM order_product_options opt, order_product prod " +
        " WHERE opt.item_id = prod.item_id AND opt.order_product_option_id > -1 ");

    pst = db.prepareStatement(sqlSelect.toString() + sqlFilter.toString() + sqlOrder.toString());
    items = prepareFilter(pst);
    rs = pst.executeQuery();
    while (rs.next()) {
      OrderProductOption thisOrderProductOption = new OrderProductOption(rs);
      this.add(thisOrderProductOption);
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

    if (itemId > -1) {
      sqlFilter.append("AND opt.item_id = ? ");
    }

    if (statusId > -1) {
      sqlFilter.append("AND opt.status_id = ? ");
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
    if (itemId > -1) {
      pst.setInt(++i, itemId);
    }

    if (statusId > -1) {
      pst.setInt(++i, statusId);
    }
    return i;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void insert(Connection db) throws SQLException {
    Iterator i = this.iterator();
    while (i.hasNext()) {
      OrderProductOption thisOption = (OrderProductOption) i.next();
      thisOption.insert(db);
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
      OrderProductOption thisOption = (OrderProductOption) i.next();
      thisOption.delete(db);
    }
  }
}

