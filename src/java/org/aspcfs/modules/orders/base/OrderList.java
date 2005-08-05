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

import org.aspcfs.modules.base.Constants;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.web.PagedListInfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

/**
 * This represents a List of Orders
 *
 * @author ananth
 * @version $Id$
 * @created March 18, 2004
 */
public class OrderList extends ArrayList {
  private PagedListInfo pagedListInfo = null;
  private int orgId = -1;
  private int sourceId = -1;
  private int statusId = -1;
  private int typeId = -1;
  private int categoryId = -1;
  private boolean buildResources = false;
  private int closedOnly = Constants.UNDEFINED;
  private boolean typeExists = false;


  /**
   * Sets the typeExists attribute of the OrderList object
   *
   * @param tmp The new typeExists value
   */
  public void setTypeExists(boolean tmp) {
    this.typeExists = tmp;
  }


  /**
   * Sets the typeExists attribute of the OrderList object
   *
   * @param tmp The new typeExists value
   */
  public void setTypeExists(String tmp) {
    this.typeExists = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   * Gets the typeExists attribute of the OrderList object
   *
   * @return The typeExists value
   */
  public boolean getTypeExists() {
    return typeExists;
  }


  /**
   * Sets the categoryId attribute of the OrderList object
   *
   * @param tmp The new categoryId value
   */
  public void setCategoryId(int tmp) {
    this.categoryId = tmp;
  }


  /**
   * Sets the categoryId attribute of the OrderList object
   *
   * @param tmp The new categoryId value
   */
  public void setCategoryId(String tmp) {
    this.categoryId = Integer.parseInt(tmp);
  }


  /**
   * Sets the closedOnly attribute of the OrderList object
   *
   * @param tmp The new closedOnly value
   */
  public void setClosedOnly(int tmp) {
    this.closedOnly = tmp;
  }


  /**
   * Sets the closedOnly attribute of the OrderList object
   *
   * @param tmp The new closedOnly value
   */
  public void setClosedOnly(String tmp) {
    this.closedOnly = Integer.parseInt(tmp);
  }


  /**
   * Gets the closedOnly attribute of the OrderList object
   *
   * @return The closedOnly value
   */
  public int getClosedOnly() {
    return closedOnly;
  }


  /**
   * Gets the categoryId attribute of the OrderList object
   *
   * @return The categoryId value
   */
  public int getCategoryId() {
    return categoryId;
  }


  /**
   * Sets the typeId attribute of the OrderList object
   *
   * @param tmp The new typeId value
   */
  public void setTypeId(int tmp) {
    this.typeId = tmp;
  }


  /**
   * Sets the typeId attribute of the OrderList object
   *
   * @param tmp The new typeId value
   */
  public void setTypeId(String tmp) {
    this.typeId = Integer.parseInt(tmp);
  }


  /**
   * Gets the typeId attribute of the OrderList object
   *
   * @return The typeId value
   */
  public int getTypeId() {
    return typeId;
  }


  /**
   * Sets the pagedListInfo attribute of the OrderList object
   *
   * @param tmp The new pagedListInfo value
   */
  public void setPagedListInfo(PagedListInfo tmp) {
    this.pagedListInfo = tmp;
  }


  /**
   * Sets the orgId attribute of the OrderList object
   *
   * @param tmp The new orgId value
   */
  public void setOrgId(int tmp) {
    this.orgId = tmp;
  }


  /**
   * Sets the orgId attribute of the OrderList object
   *
   * @param tmp The new orgId value
   */
  public void setOrgId(String tmp) {
    this.orgId = Integer.parseInt(tmp);
  }


  /**
   * Sets the sourceId attribute of the OrderList object
   *
   * @param tmp The new sourceId value
   */
  public void setSourceId(int tmp) {
    this.sourceId = tmp;
  }


  /**
   * Sets the sourceId attribute of the OrderList object
   *
   * @param tmp The new sourceId value
   */
  public void setSourceId(String tmp) {
    this.sourceId = Integer.parseInt(tmp);
  }


  /**
   * Sets the statusId attribute of the OrderList object
   *
   * @param tmp The new statusId value
   */
  public void setStatusId(int tmp) {
    this.statusId = tmp;
  }


  /**
   * Sets the statusId attribute of the OrderList object
   *
   * @param tmp The new statusId value
   */
  public void setStatusId(String tmp) {
    this.statusId = Integer.parseInt(tmp);
  }


  /**
   * Sets the buildResources attribute of the OrderList object
   *
   * @param tmp The new buildResources value
   */
  public void setBuildResources(boolean tmp) {
    this.buildResources = tmp;
  }


  /**
   * Sets the buildResources attribute of the OrderList object
   *
   * @param tmp The new buildResources value
   */
  public void setBuildResources(String tmp) {
    this.buildResources = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   * Gets the pagedListInfo attribute of the OrderList object
   *
   * @return The pagedListInfo value
   */
  public PagedListInfo getPagedListInfo() {
    return pagedListInfo;
  }


  /**
   * Gets the orgId attribute of the OrderList object
   *
   * @return The orgId value
   */
  public int getOrgId() {
    return orgId;
  }


  /**
   * Gets the sourceId attribute of the OrderList object
   *
   * @return The sourceId value
   */
  public int getSourceId() {
    return sourceId;
  }


  /**
   * Gets the statusId attribute of the OrderList object
   *
   * @return The statusId value
   */
  public int getStatusId() {
    return statusId;
  }


  /**
   * Gets the buildResources attribute of the OrderList object
   *
   * @return The buildResources value
   */
  public boolean getBuildResources() {
    return buildResources;
  }


  /**
   * Constructor for the OrderList object
   */
  public OrderList() {
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
        " SELECT COUNT(*) AS recordcount " +
        " FROM order_entry oe " +
        " LEFT JOIN organization org ON (oe.org_id = org.org_id) " +
        " LEFT JOIN lookup_order_status loes ON ( oe.status_id = loes.code ) " +
        " LEFT JOIN contact ct_billing ON (oe.billing_contact_id = ct_billing.contact_id) " +
        " WHERE oe.order_id > -1 ");
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
      pagedListInfo.setDefaultSort("oe.entered", null);
      pagedListInfo.appendSqlTail(db, sqlOrder);
    } else {
      sqlOrder.append("ORDER BY oe.order_id");
    }
    //Build a base SQL statement for returning records
    if (pagedListInfo != null) {
      pagedListInfo.appendSqlSelectHead(db, sqlSelect);
    } else {
      sqlSelect.append("SELECT ");
    }
    sqlSelect.append(
        "   oe.order_id, oe.parent_id, oe.org_id, oe.quote_id, oe.sales_id, oe.orderedby, oe.billing_contact_id, oe.source_id, " +
        "   oe.grand_total, oe.status_id, oe.contract_date, oe.status_date, oe.expiration_date, oe.order_terms_id, oe.order_type_id, " +
        "   oe.description, oe.notes, oe.entered, oe.enteredby, oe.modified, oe.modifiedby, oe.submitted, " +
        "   org.name, ct_billing.namelast, ct_billing.namefirst, ct_billing.namemiddle " +
        " FROM order_entry oe " +
        " LEFT JOIN organization org ON (oe.org_id = org.org_id) " +
        " LEFT JOIN lookup_order_status loes ON ( oe.status_id = loes.code ) " +
        " LEFT JOIN contact ct_billing ON (oe.billing_contact_id = ct_billing.contact_id) " +
        " WHERE oe.order_id > -1 ");

    pst = db.prepareStatement(
        sqlSelect.toString() + sqlFilter.toString() + sqlOrder.toString());
    items = prepareFilter(pst);
    rs = pst.executeQuery();
    if (pagedListInfo != null) {
      pagedListInfo.doManualOffset(db, rs);
    }
    while (rs.next()) {
      Order thisOrder = new Order(rs);
      this.add(thisOrder);
    }
    rs.close();
    pst.close();
    if (buildResources) {
      Iterator i = this.iterator();
      while (i.hasNext()) {
        Order thisOrder = (Order) i.next();
        thisOrder.buildProducts(db);
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
    if (orgId > -1) {
      sqlFilter.append("AND oe.org_id = ? ");
    }
    if (sourceId > -1) {
      sqlFilter.append("AND oe.source_id = ? ");
    }
    if (statusId > -1) {
      sqlFilter.append("AND oe.status_id = ? ");
    }
    if (typeId > -1) {
      sqlFilter.append("AND oe.order_type_id = ? ");
    }
    if (closedOnly == Constants.TRUE) {
      sqlFilter.append(
          " AND loes.description IN ( 'Closed' , 'Complete', 'Cancelled', 'Rejected' ) ");
    } else if (closedOnly == Constants.FALSE) {
      sqlFilter.append(
          " AND loes.description NOT IN ( 'Closed' , 'Complete', 'Cancelled', 'Rejected' ) ");
    }
    if (categoryId > -1) {
      sqlFilter.append(
          " AND oe.order_id IN (SELECT order_id " +
          " FROM order_product " +
          " WHERE product_id IN (SELECT product_id " +
          " FROM product_catalog_category_map pccm " +
          " WHERE pccm.category_id = ? )) ");
    }
    if (typeExists) {
      sqlFilter.append("AND oe.order_type_id IS NOT NULL ");
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
    if (orgId > -1) {
      pst.setInt(++i, orgId);
    }
    if (sourceId > -1) {
      pst.setInt(++i, sourceId);
    }
    if (statusId > -1) {
      pst.setInt(++i, statusId);
    }
    if (typeId > -1) {
      pst.setInt(++i, typeId);
    }
    if (categoryId > -1) {
      pst.setInt(++i, categoryId);
    }
    return i;
  }
}

