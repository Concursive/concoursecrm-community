package org.aspcfs.modules.orders.base;

import java.sql.*;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import org.aspcfs.utils.web.PagedListInfo;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.DateUtils;

/**
 *  This represents a list of Products that the customer requested.
 *  This is associated with a particular order
 *
 * @author     ananth
 * @created    March 18, 2004
 * @version    $Id$
 */
public class OrderProductList extends ArrayList {
  private PagedListInfo pagedListInfo = null;
  private int orderId = -1;
  private int productId = -1;
  private int statusId = -1;
  private boolean buildResources = false;


  /**
   *  Sets the pagedListInfo attribute of the OrderProductList object
   *
   * @param  tmp  The new pagedListInfo value
   */
  public void setPagedListInfo(PagedListInfo tmp) {
    this.pagedListInfo = tmp;
  }


  /**
   *  Sets the orderId attribute of the OrderProductList object
   *
   * @param  tmp  The new orderId value
   */
  public void setOrderId(int tmp) {
    this.orderId = tmp;
  }


  /**
   *  Sets the orderId attribute of the OrderProductList object
   *
   * @param  tmp  The new orderId value
   */
  public void setOrderId(String tmp) {
    this.orderId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the statusId attribute of the OrderProductList object
   *
   * @param  tmp  The new statusId value
   */
  public void setStatusId(int tmp) {
    this.statusId = tmp;
  }


  /**
   *  Sets the statusId attribute of the OrderProductList object
   *
   * @param  tmp  The new statusId value
   */
  public void setStatusId(String tmp) {
    this.statusId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the buildResources attribute of the OrderProductList object
   *
   * @param  tmp  The new buildResources value
   */
  public void setBuildResources(boolean tmp) {
    this.buildResources = tmp;
  }


  /**
   *  Sets the buildResources attribute of the OrderProductList object
   *
   * @param  tmp  The new buildResources value
   */
  public void setBuildResources(String tmp) {
    this.buildResources = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Sets the productId attribute of the OrderProductList object
   *
   * @param  tmp  The new productId value
   */
  public void setProductId(int tmp) {
    this.productId = tmp;
  }


  /**
   *  Sets the productId attribute of the OrderProductList object
   *
   * @param  tmp  The new productId value
   */
  public void setProductId(String tmp) {
    this.productId = Integer.parseInt(tmp);
  }


  /**
   *  Gets the productId attribute of the OrderProductList object
   *
   * @return    The productId value
   */
  public int getProductId() {
    return productId;
  }


  /**
   *  Gets the pagedListInfo attribute of the OrderProductList object
   *
   * @return    The pagedListInfo value
   */
  public PagedListInfo getPagedListInfo() {
    return pagedListInfo;
  }


  /**
   *  Gets the orderId attribute of the OrderProductList object
   *
   * @return    The orderId value
   */
  public int getOrderId() {
    return orderId;
  }


  /**
   *  Gets the statusId attribute of the OrderProductList object
   *
   * @return    The statusId value
   */
  public int getStatusId() {
    return statusId;
  }


  /**
   *  Gets the buildResources attribute of the OrderProductList object
   *
   * @return    The buildResources value
   */
  public boolean getBuildResources() {
    return buildResources;
  }


  /**
   *Constructor for the OrderProductList object
   */
  public OrderProductList() { }


  /**
   *  Description of the Method
   *
   * @param  db                Description of the Parameter
   * @exception  SQLException  Description of the Exception
   */
  public void buildList(Connection db) throws SQLException {
    System.out.println("inside the build function");
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
        "FROM order_product op " +
        "WHERE op.item_id > -1 ");
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
      pagedListInfo.appendSqlTail(db, sqlOrder);
    } else {
      sqlOrder.append("ORDER BY status_date");
    }
    //Build a base SQL statement for returning records
    if (pagedListInfo != null) {
      pagedListInfo.appendSqlSelectHead(db, sqlSelect);
    } else {
      sqlSelect.append("SELECT ");
    }
    sqlSelect.append(
        "     op.item_id, op.order_id, op.product_id, " +
        "     op.quantity, op.msrp_currency, op.msrp_amount, op.price_currency, op.price_amount, " +
        "     op.recurring_currency, op.recurring_amount, op.recurring_type, " +
        "     op.extended_price, op.total_price, op.status_id, op.status_date " +
        " FROM order_product op " +
        " WHERE op.item_id > -1 ");

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
      OrderProduct thisOrderProduct = new OrderProduct(rs);
      this.add(thisOrderProduct);
      System.out.println("added a product to the list");
    }
    rs.close();
    pst.close();
    if (buildResources) {
      Iterator i = this.iterator();
      while (i.hasNext()) {
        OrderProduct thisOrderProduct = (OrderProduct) i.next();
        thisOrderProduct.buildProduct(db);
        thisOrderProduct.buildProductOptions(db);
      }
    }
  }


  /**
   *  Description of the Method
   *
   * @param  sqlFilter  Description of the Parameter
   */
  protected void createFilter(StringBuffer sqlFilter) {
    if (sqlFilter == null) {
      sqlFilter = new StringBuffer();
    }

    if (orderId > -1) {
      sqlFilter.append("AND op.order_id = ? ");
    }
    
    if (productId > -1) {
      sqlFilter.append("AND op.product_id = ? ");
    }
    
    if (statusId > -1) {
      sqlFilter.append("AND op.status_id = ? ");
    }
  }


  /**
   *  Description of the Method
   *
   * @param  pst               Description of the Parameter
   * @return                   Description of the Return Value
   * @exception  SQLException  Description of the Exception
   */
  protected int prepareFilter(PreparedStatement pst) throws SQLException {
    int i = 0;
    if (orderId > -1) {
      pst.setInt(++i, orderId);
    }

    if (productId > -1) {
      pst.setInt(++i, productId);
    }
    
    if (statusId > -1) {
      pst.setInt(++i, statusId);
    }
    return i;
  }


  /**
   *  Description of the Method
   *
   * @param  db                Description of the Parameter
   * @exception  SQLException  Description of the Exception
   */
  public void insert(Connection db) throws SQLException {
    Iterator i = this.iterator();
    while (i.hasNext()) {
      OrderProduct thisProduct = (OrderProduct) i.next();
      thisProduct.insert(db);
    }
  }


  /**
   *  Description of the Method
   *
   * @param  db                Description of the Parameter
   * @exception  SQLException  Description of the Exception
   */
  public void delete(Connection db) throws SQLException {
    Iterator i = this.iterator();
    while (i.hasNext()) {
      OrderProduct thisProduct = (OrderProduct) i.next();
      thisProduct.delete(db);
    }
  }
}

