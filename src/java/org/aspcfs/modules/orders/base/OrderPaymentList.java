package org.aspcfs.modules.orders.base;

import java.sql.*;
import java.util.*;
import org.aspcfs.utils.web.PagedListInfo;
import org.aspcfs.utils.DatabaseUtils;

/**
 *  This represents a list of Order Payments
 *
 * @author     ananth
 * @created    March 19, 2004
 * @version    $Id$
 */
public class OrderPaymentList extends ArrayList {
  private PagedListInfo pagedListInfo = null;
  private int orderId = -1;
  private int paymentMethodId = -1;


  /**
   *  Sets the orderId attribute of the OrderPaymentList object
   *
   * @param  tmp  The new orderId value
   */
  public void setOrderId(int tmp) {
    this.orderId = tmp;
  }


  /**
   *  Sets the orderId attribute of the OrderPaymentList object
   *
   * @param  tmp  The new orderId value
   */
  public void setOrderId(String tmp) {
    this.orderId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the paymentMethodId attribute of the OrderPaymentList object
   *
   * @param  tmp  The new paymentMethodId value
   */
  public void setPaymentMethodId(int tmp) {
    this.paymentMethodId = tmp;
  }


  /**
   *  Sets the paymentMethodId attribute of the OrderPaymentList object
   *
   * @param  tmp  The new paymentMethodId value
   */
  public void setPaymentMethodId(String tmp) {
    this.paymentMethodId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the pagedListInfo attribute of the OrderPaymentList object
   *
   * @param  tmp  The new pagedListInfo value
   */
  public void setPagedListInfo(PagedListInfo tmp) {
    this.pagedListInfo = tmp;
  }


  /**
   *  Gets the orderId attribute of the OrderPaymentList object
   *
   * @return    The orderId value
   */
  public int getOrderId() {
    return orderId;
  }


  /**
   *  Gets the paymentMethodId attribute of the OrderPaymentList object
   *
   * @return    The paymentMethodId value
   */
  public int getPaymentMethodId() {
    return paymentMethodId;
  }


  /**
   *  Gets the pagedListInfo attribute of the OrderPaymentList object
   *
   * @return    The pagedListInfo value
   */
  public PagedListInfo getPagedListInfo() {
    return pagedListInfo;
  }


  /**
   *Constructor for the OrderPaymentList object
   */
  public OrderPaymentList() { }


  /**
   *  Description of the Method
   *
   * @param  db                Description of the Parameter
   * @exception  SQLException  Description of the Exception
   */
  public void buildList(Connection db) throws SQLException {
    PreparedStatement pst = null;
    ResultSet rs = null;
    int items = -1;

    StringBuffer sqlSelect = new StringBuffer();
    StringBuffer sqlCount = new StringBuffer();
    StringBuffer sqlFilter = new StringBuffer();
    StringBuffer sqlOrder = new StringBuffer();

    // Build a base SQL statement for counting records
    sqlCount.append(
        " SELECT COUNT(*) AS recordcount " +
        " FROM order_payment op " +
        " WHERE op.payment_id > -1 ");

    createFilter(sqlFilter);

    if (pagedListInfo != null) {
      // Get the total number of records matching the filter
      pst = db.prepareStatement(sqlCount.toString() + sqlFilter.toString());
      items = prepareFilter(pst);
      rs = pst.executeQuery();
      if (rs.next()) {
        int maxRecords = rs.getInt("recordcount");
        pagedListInfo.setMaxRecords(maxRecords);
      }
      rs.close();
      pst.close();

      // Determine the offset, based on the filter, for the first record to show
      //TODO : figure out why there is the below piece of code in Ticket.java
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
      pagedListInfo.setDefaultSort("op.entered", null);
      pagedListInfo.appendSqlTail(db, sqlOrder);
    } else {
      sqlOrder.append("ORDER BY op.entered");
    }

    //Need to build a base SQL statement for returning the records
    if (pagedListInfo != null) {
      pagedListInfo.appendSqlSelectHead(db, sqlSelect);
    } else {
      sqlSelect.append("SELECT");
    }
    sqlSelect.append(
        "       op.payment_id, op.order_id, op.payment_method_id, op.payment_amount, " +
        "       op.authorization_ref_number, op.authorization_code, op.authorization_date, " +
        "       op.entered, op.enteredby, op.modified, op.modifiedby " +
        " FROM order_payment op " +
        " WHERE op.payment_id > -1 "
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
      OrderPayment thisPayment = new OrderPayment(rs);
      this.add(thisPayment);
    }
    rs.close();
    pst.close();
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
    if (paymentMethodId > -1) {
      sqlFilter.append("AND op.payment_method_id = ? ");
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
    if (paymentMethodId > -1) {
      pst.setInt(++i, paymentMethodId);
    }
    return i;
  }
}

