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

import java.util.ArrayList;
import java.util.Iterator;
import java.sql.*;
import org.aspcfs.utils.web.PagedListInfo;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.modules.troubletickets.base.*;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.base.SyncableList;
import java.util.Calendar;

/**
 *  List class for ProductCatalogPricing
 *
 *@author     partha
 *@created    March 19, 2004
 *@version    $Id: ProductCatalogPricingList.java,v 1.1.2.2 2004/03/19 20:46:01
 *      partha Exp $
 */
public class ProductCatalogPricingList extends ArrayList implements SyncableList {
  //sync api
  /**
   *  Description of the Field
   */
  public final static String tableName = "product_catalog_pricing";
  /**
   *  Description of the Field
   */
  public final static String uniqueField = "price_id";
  private int syncType = Constants.NO_SYNC;
  private Timestamp lastAnchor = null;
  private Timestamp nextAnchor = null;

  //filters
  private PagedListInfo pagedListInfo = null;
  private int id = -1;
  //other supplimentary fields
  private String productName = null;


  /**
   *  Gets the tableName attribute of the ProductCatalogPricingList object
   *
   *@return    The tableName value
   */
  public String getTableName() {
    return tableName;
  }


  /**
   *  Gets the uniqueField attribute of the ProductCatalogPricingList object
   *
   *@return    The uniqueField value
   */
  public String getUniqueField() {
    return uniqueField;
  }


  /**
   *  Gets the pagedListInfo attribute of the ProductCatalogPricingList object
   *
   *@return    The pagedListInfo value
   */
  public PagedListInfo getPagedListInfo() {
    return pagedListInfo;
  }


  /**
   *  Gets the id attribute of the ProductCatalogPricingList object
   *
   *@return    The id value
   */
  public int getId() {
    return id;
  }


  /**
   *  Gets the syncType attribute of the ProductCatalogPricingList object
   *
   *@return    The syncType value
   */
  public int getSyncType() {
    return syncType;
  }


  /**
   *  Gets the lastAnchor attribute of the ProductCatalogPricingList object
   *
   *@return    The lastAnchor value
   */
  public Timestamp getLastAnchor() {
    return lastAnchor;
  }


  /**
   *  Gets the nextAnchor attribute of the ProductCatalogPricingList object
   *
   *@return    The nextAnchor value
   */
  public Timestamp getNextAnchor() {
    return nextAnchor;
  }


  /**
   *  Gets the productName attribute of the ProductCatalogPricingList object
   *
   *@return    The productName value
   */
  public String getProductName() {
    return productName;
  }


  /**
   *  Sets the pagedListInfo attribute of the ProductCatalogPricingList object
   *
   *@param  tmp  The new pagedListInfo value
   */
  public void setPagedListInfo(PagedListInfo tmp) {
    this.pagedListInfo = tmp;
  }


  /**
   *  Sets the id attribute of the ProductCatalogPricingList object
   *
   *@param  tmp  The new id value
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   *  Sets the id attribute of the ProductCatalogPricingList object
   *
   *@param  tmp  The new id value
   */
  public void setId(String tmp) {
    this.id = Integer.parseInt(tmp);
  }


  /**
   *  Sets the syncType attribute of the ProductCatalogPricingList object
   *
   *@param  tmp  The new syncType value
   */
  public void setSyncType(int tmp) {
    this.syncType = tmp;
  }


  /**
   *  Sets the syncType attribute of the ProductCatalogPricingList object
   *
   *@param  tmp  The new syncType value
   */
  public void setSyncType(String tmp) {
    this.syncType = Integer.parseInt(tmp);
  }


  /**
   *  Sets the lastAnchor attribute of the ProductCatalogPricingList object
   *
   *@param  tmp  The new lastAnchor value
   */
  public void setLastAnchor(Timestamp tmp) {
    this.lastAnchor = tmp;
  }


  /**
   *  Sets the lastAnchor attribute of the ProductCatalogPricingList object
   *
   *@param  tmp  The new lastAnchor value
   */
  public void setLastAnchor(String tmp) {
    this.lastAnchor = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   *  Sets the nextAnchor attribute of the ProductCatalogPricingList object
   *
   *@param  tmp  The new nextAnchor value
   */
  public void setNextAnchor(Timestamp tmp) {
    this.nextAnchor = tmp;
  }


  /**
   *  Sets the productName attribute of the ProductCatalogPricingList object
   *
   *@param  tmp  The new productName value
   */
  public void setProductName(String tmp) {
    this.productName = tmp;
  }


  /**
   *  Sets the nextAnchor attribute of the ProductCatalogPricingList object
   *
   *@param  tmp  The new nextAnchor value
   */
  public void setNextAnchor(String tmp) {
    this.nextAnchor = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   *  Constructor for the ProductCatalogPricingList object
   */
  public ProductCatalogPricingList() { }


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
    //Need to build a base SQL statement for counting records
    sqlCount.append(
        " SELECT COUNT(poptconfig.*) AS recordcount " +
        " FROM product_catalog_pricing AS pctlgpricing " +
        " WHERE pctlgpricing.price_id > 0"
        );

    createFilter(sqlFilter, db);

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
    }
    //Need to build a base SQL statement for returning records
    if (pagedListInfo != null) {
      pagedListInfo.appendSqlSelectHead(db, sqlSelect);
    } else {
      sqlSelect.append(" SELECT ");
    }
    sqlSelect.append(
        " pctlgprice.*, " +
        " pctlg.product_name AS product_name " +
        " FROM product_catalog_pricing pctlgprice, " +
        " LEFT JOIN product_catalog AS pctlg " +
        " ON ( pctlgprice.product_id = pctlg.product_id ) " +
        " WHERE pctlgprice.price_id > -1 "
        );
    sqlOrder.append(" ORDER BY pctlgprice.priceAmount ");
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
      ProductCatalogPricing productOptionConfigurator = new ProductCatalogPricing(rs);
      this.add(productOptionConfigurator);
    }
    rs.close();
    pst.close();

  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  basePath          Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void delete(Connection db, String basePath) throws SQLException {
    Iterator configurators = this.iterator();
    while (configurators.hasNext()) {
      ProductCatalogPricing productOptionConfigurator = (ProductCatalogPricing) configurators.next();
      productOptionConfigurator.delete(db, basePath);
    }
  }


  /**
   *  Description of the Method
   *
   *@param  sqlFilter  Description of the Parameter
   *@param  db         Description of the Parameter
   */
  private void createFilter(StringBuffer sqlFilter, Connection db) {

    if (id > -1) {
      sqlFilter.append(" AND poptconfig.configurator_id = ? ");
    }
    if (productName != null) {
      sqlFilter.append(" AND pctlg.product_name = ? ");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  pst               Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  private int prepareFilter(PreparedStatement pst) throws SQLException {
    int i = 0;
    if (id > -1) {
      pst.setInt(++i, id);
    }
    if (productName != null) {
      pst.setString(++i, productName);
    }
    return i;
  }
}

