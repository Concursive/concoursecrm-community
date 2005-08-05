package org.aspcfs.modules.orders.actions;

import com.darkhorseventures.framework.actions.ActionContext;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.orders.base.Order;
import org.aspcfs.modules.orders.base.OrderPaymentList;
import org.aspcfs.modules.orders.base.OrderProduct;
import org.aspcfs.modules.orders.base.OrderProductStatusList;
import org.aspcfs.modules.orders.beans.StatusBean;
import org.aspcfs.modules.products.base.CustomerProduct;
import org.aspcfs.modules.products.base.CustomerProductHistoryList;
import org.aspcfs.modules.products.base.ProductOptionList;
import org.aspcfs.modules.products.base.ProductOptionValuesList;
import org.aspcfs.utils.web.LookupList;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Calendar;

/**
 * Description of the Class
 *
 * @author ananth
 * @version $Id$
 * @created April 20, 2004
 */
public final class OrdersProducts extends CFSModule {
  public String executeCommandDefault(ActionContext context) {
    if (!(hasPermission(context, "orders-view"))) {
      return ("PermissionError");
    }
    return "OK";
  }

  public String executeCommandDetails(ActionContext context) {
    if (!(hasPermission(context, "orders-view"))) {
      return ("PermissionError");
    }
    int productId = -1;
    try {
      productId = Integer.parseInt(
          context.getRequest().getParameter("productId"));
    } catch (Exception e) {
      context.getRequest().setAttribute(
          "actionError",
          "Invalid criteria, please review and make necessary changes before submitting");
      return "SearchCriteriaError";
    }
    OrderProduct orderProduct = null;
    OrderProductStatusList productStatusList = null;
    OrderPaymentList paymentList = null;
    Order order = null;
    Connection db = null;
    try {
      db = getConnection(context);

      orderProduct = new OrderProduct();
      orderProduct.setBuildProduct(true);
      orderProduct.setBuildProductOptions(true);
      orderProduct.setBuildProductStatus(true);
      orderProduct.queryRecord(db, productId);
      context.getRequest().setAttribute("orderProduct", orderProduct);

      order = new Order();
      order.setBuildProducts(true);
      order.queryRecord(db, orderProduct.getOrderId());
      context.getRequest().setAttribute("order", order);

      SystemStatus systemStatus = this.getSystemStatus(context);
      LookupList statusSelect = systemStatus.getLookupList(
          db, "lookup_order_status");
      context.getRequest().setAttribute("statusSelect", statusSelect);

      LookupList paymentSelect = systemStatus.getLookupList(
          db, "lookup_payment_status");
      context.getRequest().setAttribute("paymentSelect", paymentSelect);

      productStatusList = orderProduct.getProductStatusList();
      context.getRequest().setAttribute(
          "productStatusList", productStatusList);

      paymentList = new OrderPaymentList();
      paymentList.setOrderId(orderProduct.getOrderId());
      paymentList.setOrderItemId(orderProduct.getId());
      paymentList.buildList(db);
      context.getRequest().setAttribute("paymentList", paymentList);

      ProductOptionList optionList = new ProductOptionList();
      optionList.buildList(db);
      context.getRequest().setAttribute("productOptionList", optionList);

      ProductOptionValuesList valuesList = new ProductOptionValuesList();
      valuesList.buildList(db);
      context.getRequest().setAttribute("productOptionValuesList", valuesList);

      CustomerProductHistoryList historyList = new CustomerProductHistoryList();
      historyList.setOrderId(order.getId());
      historyList.setOrderItemId(orderProduct.getId());
      historyList.buildList(db);
      context.getRequest().setAttribute("historyList", historyList);

    } catch (Exception e) {
      context.getRequest().setAttribute(
          "actionError",
          "The specified order item could not be found");
      return "SearchCriteriaError";
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "OrdersProducts", "OrdersProducts Details");
    return ("DetailsOK");

  }

  public String executeCommandModify(ActionContext context) {
    if (!(hasPermission(context, "orders-view"))) {
      return ("PermissionError");
    }
    int productId = Integer.parseInt(
        (String) context.getRequest().getParameter("productId"));
    OrderProduct orderProduct = null;
    OrderProductStatusList productStatusList = null;
    OrderPaymentList paymentList = null;
    Order order = null;
    Connection db = null;
    try {
      db = getConnection(context);

      orderProduct = new OrderProduct();
      orderProduct.setBuildProduct(true);
      orderProduct.setBuildProductOptions(true);
      orderProduct.setBuildProductStatus(true);
      orderProduct.queryRecord(db, productId);
      context.getRequest().setAttribute("orderProduct", orderProduct);

      StatusBean productBean = new StatusBean();
      productBean.setStatusId(orderProduct.getStatusId());
      context.getRequest().setAttribute("statusBean", productBean);

      SystemStatus systemStatus = this.getSystemStatus(context);
      LookupList statusSelect = systemStatus.getLookupList(
          db, "lookup_order_status");
      statusSelect.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("statusSelect", statusSelect);

      order = new Order();
      order.setBuildProducts(true);
      order.queryRecord(db, orderProduct.getOrderId());
      context.getRequest().setAttribute("order", order);

      productStatusList = orderProduct.getProductStatusList();
      context.getRequest().setAttribute(
          "productStatusList", productStatusList);

      paymentList = new OrderPaymentList();
      paymentList.setOrderId(orderProduct.getOrderId());
      paymentList.setOrderItemId(orderProduct.getId());
      paymentList.buildList(db);
      context.getRequest().setAttribute("paymentList", paymentList);

      ProductOptionList optionList = new ProductOptionList();
      optionList.buildList(db);
      context.getRequest().setAttribute("productOptionList", optionList);

      ProductOptionValuesList valuesList = new ProductOptionValuesList();
      valuesList.buildList(db);
      context.getRequest().setAttribute("productOptionValuesList", valuesList);

    } catch (Exception e) {
      e.printStackTrace();
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "OrdersProducts", "OrdersProducts Details");
    return ("ModifyOK");
  }

  public String executeCommandSave(ActionContext context) {
    if (!(hasPermission(context, "orders-view"))) {
      return ("PermissionError");
    }
    int productId = Integer.parseInt(
        (String) context.getRequest().getParameter("productId"));
    OrderProduct orderProduct = null;
    OrderProductStatusList productStatusList = null;
    OrderPaymentList paymentList = null;
    Order order = null;
    Connection db = null;
    try {
      db = getConnection(context);

      orderProduct = new OrderProduct();
      orderProduct.setBuildProduct(true);
      orderProduct.setBuildProductOptions(true);
      orderProduct.setBuildProductStatus(true);
      orderProduct.queryRecord(db, productId);
      orderProduct.setModifiedBy(this.getUserId(context));
      context.getRequest().setAttribute("orderProduct", orderProduct);

      Calendar now = Calendar.getInstance();
      Timestamp rightNow = new Timestamp(now.getTimeInMillis());
      StatusBean statusBean = (StatusBean) context.getFormBean();

      if (statusBean.getStatusId() != -1 && statusBean.getStatusId() != 0) {
        orderProduct.setStatusId(statusBean.getStatusId());
      }
      orderProduct.setStatusDate(rightNow);
      orderProduct.update(db);

    } catch (Exception e) {
      e.printStackTrace();
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "OrdersProducts", "OrdersProducts Details");
    return "SaveOK";
  }

  public String executeCommandDisplayCustomerProduct(ActionContext context) {
    if (!(hasPermission(context, "orders-view"))) {
      return ("PermissionError");
    }
    Connection db = null;
    int productId = Integer.parseInt(
        (String) context.getRequest().getParameter("productId"));
    CustomerProduct customerProduct = null;
    try {
      db = getConnection(context);

      //retrieve the order product form the database
      OrderProduct product = new OrderProduct();
      product.setBuildProduct(true);
      product.setBuildProductOptions(true);
      product.queryRecord(db, productId);
      context.getRequest().setAttribute("orderProduct", product);

      //retrieve the order from the database
      Order order = new Order(db, product.getOrderId());
      context.getRequest().setAttribute("order", order);
      
      // retrieve the customer product from the database
      customerProduct = new CustomerProduct();
      customerProduct.setBuildFileList(true);
      try {
        customerProduct.queryRecordFromItemId(db, product.getId());
      } catch (SQLException sqlException) {
        if (sqlException.getMessage().equals("Customer Product not found")) {
          return "DisplayCustomerProductOK";
        } else {
          throw sqlException;
        }
      }
      // if the customer product exists
      context.getRequest().setAttribute("customerProduct", customerProduct);
    } catch (Exception e) {
      e.printStackTrace();
      context.getRequest().setAttribute("Error", e);
      return "SystemError";
    } finally {
      this.freeConnection(context, db);
    }
    return "DisplayCustomerProductOK";
  }
}

