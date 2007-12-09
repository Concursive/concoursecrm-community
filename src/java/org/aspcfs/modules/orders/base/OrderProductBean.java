/*
 *  Copyright(c) 2004 Concursive Corporation (http://www.concursive.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Concursive Corporation. Permission to use, copy, and modify
 *  this material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. CONCURSIVE
 *  CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL CONCURSIVE CORPORATION OR ANY OF ITS AFFILIATES BE LIABLE FOR
 *  ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package org.aspcfs.modules.orders.base;

import com.darkhorseventures.framework.beans.GenericBean;
import org.aspcfs.modules.products.base.ProductCatalog;
import org.aspcfs.modules.products.base.ProductCatalogPricing;
import org.aspcfs.modules.quotes.base.QuoteProduct;
import org.aspcfs.utils.DatabaseUtils;

import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

/**
 * Description of the Class
 *
 * @author Olga.Kaptyug
 * @version $Id: 
 *          Exp $
 * @created Aug 22, 2006
 */
public class OrderProductBean extends GenericBean {
  //ProductCatalog related fields
  private String sku = null;
  private int typeId = -1;
  private int formatId = -1;
  private int shippingId = -1;
  private int estimatedShipTime = -1;
  private int thumbnailImageId = -1;
  private int smallImageId = -1;
  private int largeImageId = -1;
  private int listOrder = -1;
  private String name = null;
  private String abbreviation = null;
  private String shortDescription = null;
  private String longDescription = null;
  private String specialNotes = null;

  //QuoteProduct related fields
  private int orderId = -1;
  private int quantity = 0;
  private String comment = null;
  private double extendedPrice = 0;
  private double totalPrice = 0;
  private int statusId = -1;
  private Timestamp statusDate = null;
  

  //ProductCatalogPricing related fields
  private int msrpCurrency = -1;
  private double msrpAmount = 0.0;
  private int costCurrency = -1;
  private double costAmount = 0.0;
  private int priceCurrency = -1;
  private double priceAmount = 0.0;
  private int recurringCurrency = -1;
  private double recurringAmount = 0.0;
  private int recurringType = -1;
  private Timestamp startDate = null;
  private Timestamp expirationDate = null;
  private boolean enabled = false;

  //supplimentary fields
  private ProductCatalog product = null;
  private OrderProduct orderProduct = null;
  private ProductCatalogPricing pricing = null;


  /**
   * Gets the timeZoneParams attribute of the QuoteProductBean class
   *
   * @return The timeZoneParams value
   */
  public static ArrayList getTimeZoneParams() {
    ArrayList thisList = new ArrayList();
    thisList.add("estimatedDeliveryDate");
    thisList.add("statusDate");
    thisList.add("startDate");
    thisList.add("expirationDate");
    return thisList;
  }


  /**
   * Gets the quoteId attribute of the QuoteProductBean object
   *
   * @return The quoteId value
   */
  public int getOrderId() {
    return orderId;
  }


  /**
   * Sets the quoteId attribute of the QuoteProductBean object
   *
   * @param tmp The new quoteId value
   */
  public void setOrderId(int tmp) {
    this.orderId = tmp;
  }


  /**
   * Sets the quoteId attribute of the QuoteProductBean object
   *
   * @param tmp The new quoteId value
   */
  public void setQuoteId(String tmp) {
    this.orderId = Integer.parseInt(tmp);
  }


  /**
   * Gets the quantity attribute of the QuoteProductBean object
   *
   * @return The quantity value
   */
  public int getQuantity() {
    return quantity;
  }


  /**
   * Sets the quantity attribute of the QuoteProductBean object
   *
   * @param tmp The new quantity value
   */
  public void setQuantity(int tmp) {
    this.quantity = tmp;
  }


  /**
   * Sets the quantity attribute of the QuoteProductBean object
   *
   * @param tmp The new quantity value
   */
  public void setQuantity(String tmp) {
    this.quantity = Integer.parseInt(tmp);
  }


  /**
   * Gets the extendedPrice attribute of the QuoteProductBean object
   *
   * @return The extendedPrice value
   */
  public double getExtendedPrice() {
    return extendedPrice;
  }


  /**
   * Sets the extendedPrice attribute of the QuoteProductBean object
   *
   * @param tmp The new extendedPrice value
   */
  public void setExtendedPrice(double tmp) {
    this.extendedPrice = tmp;
  }


  /**
   * Sets the extendedPrice attribute of the QuoteProductBean object
   *
   * @param tmp The new extendedPrice value
   */
  public void setExtendedPrice(String tmp) {
    this.extendedPrice = Double.parseDouble(tmp);
  }


  /**
   * Gets the totalPrice attribute of the QuoteProductBean object
   *
   * @return The totalPrice value
   */
  public double getTotalPrice() {
    return totalPrice;
  }


  /**
   * Sets the totalPrice attribute of the QuoteProductBean object
   *
   * @param tmp The new totalPrice value
   */
  public void setTotalPrice(double tmp) {
    this.totalPrice = tmp;
  }


  /**
   * Sets the totalPrice attribute of the QuoteProductBean object
   *
   * @param tmp The new totalPrice value
   */
  public void setTotalPrice(String tmp) {
    this.totalPrice = Double.parseDouble(tmp);
  }
  
  /**
   * Gets the statusId attribute of the QuoteProductBean object
   *
   * @return The statusId value
   */
  public int getStatusId() {
    return statusId;
  }


  /**
   * Sets the statusId attribute of the QuoteProductBean object
   *
   * @param tmp The new statusId value
   */
  public void setStatusId(int tmp) {
    this.statusId = tmp;
  }


  /**
   * Sets the statusId attribute of the QuoteProductBean object
   *
   * @param tmp The new statusId value
   */
  public void setStatusId(String tmp) {
    this.statusId = Integer.parseInt(tmp);
  }


  /**
   * Gets the statusDate attribute of the QuoteProductBean object
   *
   * @return The statusDate value
   */
  public Timestamp getStatusDate() {
    return statusDate;
  }


  /**
   * Sets the statusDate attribute of the QuoteProductBean object
   *
   * @param tmp The new statusDate value
   */
  public void setStatusDate(Timestamp tmp) {
    this.statusDate = tmp;
  }


  /**
   * Sets the statusDate attribute of the QuoteProductBean object
   *
   * @param tmp The new statusDate value
   */
  public void setStatusDate(String tmp) {
    this.statusDate = DatabaseUtils.parseTimestamp(tmp);
  }

  
  /**
   * Gets the sku attribute of the QuoteProductBean object
   *
   * @return The sku value
   */
  public String getSku() {
    return sku;
  }


  /**
   * Sets the sku attribute of the QuoteProductBean object
   *
   * @param tmp The new sku value
   */
  public void setSku(String tmp) {
    this.sku = tmp;
  }


  /**
   * Gets the typeId attribute of the QuoteProductBean object
   *
   * @return The typeId value
   */
  public int getTypeId() {
    return typeId;
  }


  /**
   * Sets the typeId attribute of the QuoteProductBean object
   *
   * @param tmp The new typeId value
   */
  public void setTypeId(int tmp) {
    this.typeId = tmp;
  }


  /**
   * Sets the typeId attribute of the QuoteProductBean object
   *
   * @param tmp The new typeId value
   */
  public void setTypeId(String tmp) {
    this.typeId = Integer.parseInt(tmp);
  }


  /**
   * Gets the formatId attribute of the QuoteProductBean object
   *
   * @return The formatId value
   */
  public int getFormatId() {
    return formatId;
  }


  /**
   * Sets the formatId attribute of the QuoteProductBean object
   *
   * @param tmp The new formatId value
   */
  public void setFormatId(int tmp) {
    this.formatId = tmp;
  }


  /**
   * Sets the formatId attribute of the QuoteProductBean object
   *
   * @param tmp The new formatId value
   */
  public void setFormatId(String tmp) {
    this.formatId = Integer.parseInt(tmp);
  }


  /**
   * Gets the shippingId attribute of the QuoteProductBean object
   *
   * @return The shippingId value
   */
  public int getShippingId() {
    return shippingId;
  }


  /**
   * Sets the shippingId attribute of the QuoteProductBean object
   *
   * @param tmp The new shippingId value
   */
  public void setShippingId(int tmp) {
    this.shippingId = tmp;
  }


  /**
   * Sets the shippingId attribute of the QuoteProductBean object
   *
   * @param tmp The new shippingId value
   */
  public void setShippingId(String tmp) {
    this.shippingId = Integer.parseInt(tmp);
  }


  /**
   * Gets the estimatedShipTime attribute of the QuoteProductBean object
   *
   * @return The estimatedShipTime value
   */
  public int getEstimatedShipTime() {
    return estimatedShipTime;
  }


  /**
   * Sets the estimatedShipTime attribute of the QuoteProductBean object
   *
   * @param tmp The new estimatedShipTime value
   */
  public void setEstimatedShipTime(int tmp) {
    this.estimatedShipTime = tmp;
  }


  /**
   * Sets the estimatedShipTime attribute of the QuoteProductBean object
   *
   * @param tmp The new estimatedShipTime value
   */
  public void setEstimatedShipTime(String tmp) {
    this.estimatedShipTime = Integer.parseInt(tmp);
  }


  /**
   * Gets the thumbnailImageId attribute of the QuoteProductBean object
   *
   * @return The thumbnailImageId value
   */
  public int getThumbnailImageId() {
    return thumbnailImageId;
  }


  /**
   * Sets the thumbnailImageId attribute of the QuoteProductBean object
   *
   * @param tmp The new thumbnailImageId value
   */
  public void setThumbnailImageId(int tmp) {
    this.thumbnailImageId = tmp;
  }


  /**
   * Sets the thumbnailImageId attribute of the QuoteProductBean object
   *
   * @param tmp The new thumbnailImageId value
   */
  public void setThumbnailImageId(String tmp) {
    this.thumbnailImageId = Integer.parseInt(tmp);
  }


  /**
   * Gets the smallImageId attribute of the QuoteProductBean object
   *
   * @return The smallImageId value
   */
  public int getSmallImageId() {
    return smallImageId;
  }


  /**
   * Sets the smallImageId attribute of the QuoteProductBean object
   *
   * @param tmp The new smallImageId value
   */
  public void setSmallImageId(int tmp) {
    this.smallImageId = tmp;
  }


  /**
   * Sets the smallImageId attribute of the QuoteProductBean object
   *
   * @param tmp The new smallImageId value
   */
  public void setSmallImageId(String tmp) {
    this.smallImageId = Integer.parseInt(tmp);
  }


  /**
   * Gets the largeImageId attribute of the QuoteProductBean object
   *
   * @return The largeImageId value
   */
  public int getLargeImageId() {
    return largeImageId;
  }


  /**
   * Sets the largeImageId attribute of the QuoteProductBean object
   *
   * @param tmp The new largeImageId value
   */
  public void setLargeImageId(int tmp) {
    this.largeImageId = tmp;
  }


  /**
   * Sets the largeImageId attribute of the QuoteProductBean object
   *
   * @param tmp The new largeImageId value
   */
  public void setLargeImageId(String tmp) {
    this.largeImageId = Integer.parseInt(tmp);
  }


  /**
   * Gets the listOrder attribute of the QuoteProductBean object
   *
   * @return The listOrder value
   */
  public int getListOrder() {
    return listOrder;
  }


  /**
   * Sets the listOrder attribute of the QuoteProductBean object
   *
   * @param tmp The new listOrder value
   */
  public void setListOrder(int tmp) {
    this.listOrder = tmp;
  }


  /**
   * Sets the listOrder attribute of the QuoteProductBean object
   *
   * @param tmp The new listOrder value
   */
  public void setListOrder(String tmp) {
    this.listOrder = Integer.parseInt(tmp);
  }


  /**
   * Gets the name attribute of the QuoteProductBean object
   *
   * @return The name value
   */
  public String getName() {
    return name;
  }


  /**
   * Sets the name attribute of the QuoteProductBean object
   *
   * @param tmp The new name value
   */
  public void setName(String tmp) {
    this.name = tmp;
  }


  /**
   * Gets the abbreviation attribute of the QuoteProductBean object
   *
   * @return The abbreviation value
   */
  public String getAbbreviation() {
    return abbreviation;
  }


  /**
   * Sets the abbreviation attribute of the QuoteProductBean object
   *
   * @param tmp The new abbreviation value
   */
  public void setAbbreviation(String tmp) {
    this.abbreviation = tmp;
  }


  /**
   * Gets the shortDescription attribute of the QuoteProductBean object
   *
   * @return The shortDescription value
   */
  public String getShortDescription() {
    return shortDescription;
  }


  /**
   * Sets the shortDescription attribute of the QuoteProductBean object
   *
   * @param tmp The new shortDescription value
   */
  public void setShortDescription(String tmp) {
    this.shortDescription = tmp;
  }


  /**
   * Gets the longDescription attribute of the QuoteProductBean object
   *
   * @return The longDescription value
   */
  public String getLongDescription() {
    return longDescription;
  }


  /**
   * Sets the longDescription attribute of the QuoteProductBean object
   *
   * @param tmp The new longDescription value
   */
  public void setLongDescription(String tmp) {
    this.longDescription = tmp;
  }


  /**
   * Gets the specialNotes attribute of the QuoteProductBean object
   *
   * @return The specialNotes value
   */
  public String getSpecialNotes() {
    return specialNotes;
  }


  /**
   * Sets the specialNotes attribute of the QuoteProductBean object
   *
   * @param tmp The new specialNotes value
   */
  public void setSpecialNotes(String tmp) {
    this.specialNotes = tmp;
  }


  /**
   * Gets the msrpCurrency attribute of the QuoteProductBean object
   *
   * @return The msrpCurrency value
   */
  public int getMsrpCurrency() {
    return msrpCurrency;
  }


  /**
   * Sets the msrpCurrency attribute of the QuoteProductBean object
   *
   * @param tmp The new msrpCurrency value
   */
  public void setMsrpCurrency(int tmp) {
    this.msrpCurrency = tmp;
  }


  /**
   * Sets the msrpCurrency attribute of the QuoteProductBean object
   *
   * @param tmp The new msrpCurrency value
   */
  public void setMsrpCurrency(String tmp) {
    this.msrpCurrency = Integer.parseInt(tmp);
  }


  /**
   * Gets the msrpAmount attribute of the QuoteProductBean object
   *
   * @return The msrpAmount value
   */
  public double getMsrpAmount() {
    return msrpAmount;
  }


  /**
   * Sets the msrpAmount attribute of the QuoteProductBean object
   *
   * @param tmp The new msrpAmount value
   */
  public void setMsrpAmount(double tmp) {
    this.msrpAmount = tmp;
  }


  /**
   * Sets the msrpAmount attribute of the QuoteProductBean object
   *
   * @param tmp The new msrpAmount value
   */
  public void setMsrpAmount(String tmp) {
    this.msrpAmount = Double.parseDouble(tmp);
  }


  /**
   * Gets the costCurrency attribute of the QuoteProductBean object
   *
   * @return The costCurrency value
   */
  public int getCostCurrency() {
    return costCurrency;
  }


  /**
   * Sets the costCurrency attribute of the QuoteProductBean object
   *
   * @param tmp The new costCurrency value
   */
  public void setCostCurrency(int tmp) {
    this.costCurrency = tmp;
  }


  /**
   * Sets the costCurrency attribute of the QuoteProductBean object
   *
   * @param tmp The new costCurrency value
   */
  public void setCostCurrency(String tmp) {
    this.costCurrency = Integer.parseInt(tmp);
  }


  /**
   * Gets the costAmount attribute of the QuoteProductBean object
   *
   * @return The costAmount value
   */
  public double getCostAmount() {
    return costAmount;
  }


  /**
   * Sets the costAmount attribute of the QuoteProductBean object
   *
   * @param tmp The new costAmount value
   */
  public void setCostAmount(double tmp) {
    this.costAmount = tmp;
  }


  /**
   * Sets the costAmount attribute of the QuoteProductBean object
   *
   * @param tmp The new costAmount value
   */
  public void setCostAmount(String tmp) {
    this.costAmount = Double.parseDouble(tmp);
  }


  /**
   * Gets the priceCurrency attribute of the QuoteProductBean object
   *
   * @return The priceCurrency value
   */
  public int getPriceCurrency() {
    return priceCurrency;
  }


  /**
   * Sets the priceCurrency attribute of the QuoteProductBean object
   *
   * @param tmp The new priceCurrency value
   */
  public void setPriceCurrency(int tmp) {
    this.priceCurrency = tmp;
  }


  /**
   * Sets the priceCurrency attribute of the QuoteProductBean object
   *
   * @param tmp The new priceCurrency value
   */
  public void setPriceCurrency(String tmp) {
    this.priceCurrency = Integer.parseInt(tmp);
  }


  /**
   * Gets the priceAmount attribute of the QuoteProductBean object
   *
   * @return The priceAmount value
   */
  public double getPriceAmount() {
    return priceAmount;
  }


  /**
   * Sets the priceAmount attribute of the QuoteProductBean object
   *
   * @param tmp The new priceAmount value
   */
  public void setPriceAmount(double tmp) {
    this.priceAmount = tmp;
  }


  /**
   * Sets the priceAmount attribute of the QuoteProductBean object
   *
   * @param tmp The new priceAmount value
   */
  public void setPriceAmount(String tmp) {
    this.priceAmount = Double.parseDouble(tmp);
  }


  /**
   * Gets the recurringCurrency attribute of the QuoteProductBean object
   *
   * @return The recurringCurrency value
   */
  public int getRecurringCurrency() {
    return recurringCurrency;
  }


  /**
   * Sets the recurringCurrency attribute of the QuoteProductBean object
   *
   * @param tmp The new recurringCurrency value
   */
  public void setRecurringCurrency(int tmp) {
    this.recurringCurrency = tmp;
  }


  /**
   * Sets the recurringCurrency attribute of the QuoteProductBean object
   *
   * @param tmp The new recurringCurrency value
   */
  public void setRecurringCurrency(String tmp) {
    this.recurringCurrency = Integer.parseInt(tmp);
  }


  /**
   * Gets the recurringAmount attribute of the QuoteProductBean object
   *
   * @return The recurringAmount value
   */
  public double getRecurringAmount() {
    return recurringAmount;
  }


  /**
   * Sets the recurringAmount attribute of the QuoteProductBean object
   *
   * @param tmp The new recurringAmount value
   */
  public void setRecurringAmount(double tmp) {
    this.recurringAmount = tmp;
  }


  /**
   * Sets the recurringAmount attribute of the QuoteProductBean object
   *
   * @param tmp The new recurringAmount value
   */
  public void setRecurringAmount(String tmp) {
    this.recurringAmount = Double.parseDouble(tmp);
  }


  /**
   * Gets the recurringType attribute of the QuoteProductBean object
   *
   * @return The recurringType value
   */
  public int getRecurringType() {
    return recurringType;
  }


  /**
   * Sets the recurringType attribute of the QuoteProductBean object
   *
   * @param tmp The new recurringType value
   */
  public void setRecurringType(int tmp) {
    this.recurringType = tmp;
  }


  /**
   * Sets the recurringType attribute of the QuoteProductBean object
   *
   * @param tmp The new recurringType value
   */
  public void setRecurringType(String tmp) {
    this.recurringType = Integer.parseInt(tmp);
  }


  /**
   * Gets the startDate attribute of the QuoteProductBean object
   *
   * @return The startDate value
   */
  public Timestamp getStartDate() {
    return startDate;
  }


  /**
   * Sets the startDate attribute of the QuoteProductBean object
   *
   * @param tmp The new startDate value
   */
  public void setStartDate(Timestamp tmp) {
    this.startDate = tmp;
  }


  /**
   * Sets the startDate attribute of the QuoteProductBean object
   *
   * @param tmp The new startDate value
   */
  public void setStartDate(String tmp) {
    this.startDate = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   * Gets the expirationDate attribute of the QuoteProductBean object
   *
   * @return The expirationDate value
   */
  public Timestamp getExpirationDate() {
    return expirationDate;
  }


  /**
   * Sets the expirationDate attribute of the QuoteProductBean object
   *
   * @param tmp The new expirationDate value
   */
  public void setExpirationDate(Timestamp tmp) {
    this.expirationDate = tmp;
  }


  /**
   * Sets the expirationDate attribute of the QuoteProductBean object
   *
   * @param tmp The new expirationDate value
   */
  public void setExpirationDate(String tmp) {
    this.expirationDate = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   * Gets the enabled attribute of the QuoteProductBean object
   *
   * @return The enabled value
   */
  public boolean getEnabled() {
    return enabled;
  }


  /**
   * Sets the enabled attribute of the QuoteProductBean object
   *
   * @param tmp The new enabled value
   */
  public void setEnabled(boolean tmp) {
    this.enabled = tmp;
  }


  /**
   * Sets the enabled attribute of the QuoteProductBean object
   *
   * @param tmp The new enabled value
   */
  public void setEnabled(String tmp) {
    this.enabled = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   * Gets the product attribute of the QuoteProductBean object
   *
   * @return The product value
   */
  public ProductCatalog getProduct() {
   if(this.product == null){  
    product = new ProductCatalog();
    product.setSku(this.getSku());
    product.setName(this.getName());
    product.setAbbreviation(this.getAbbreviation());
    product.setShortDescription(this.getShortDescription());
    product.setStartDate(this.getStartDate());
    product.setSpecialNotes(this.getSpecialNotes());
    product.setLongDescription(this.getLongDescription());
    product.setEnabled(true);
    product.setActive(true);
    product.setInStock(true);
    product.setOnlyWarnings(this.getOnlyWarnings());
   }
    return product;
  }


  /**
   * Sets the product attribute of the QuoteProductBean object
   *
   * @param tmp The new product value
   */
  public void setProduct(ProductCatalog tmp) {
    this.product = tmp;
  }


  /**
   * Gets the quoteProduct attribute of the QuoteProductBean object
   *
   * @return The quoteProduct value
   * @throws SQLException Description of the Exception
   */
  public OrderProduct getOrderProduct() throws SQLException {
    if (product == null || product.getId() == -1) {
      throw new SQLException("Product Catalog not found");
    }
    orderProduct = new OrderProduct();
    orderProduct.setProductId(product.getId());
    orderProduct.setExtendedPrice(this.getExtendedPrice());
    orderProduct.setRecurringAmount(this.getRecurringAmount());
    orderProduct.setRecurringCurrency(this.getRecurringCurrency());
    orderProduct.setRecurringType(this.getRecurringType());
    orderProduct.setPriceAmount(this.getPriceAmount());
    orderProduct.setPriceCurrency(this.getPriceCurrency());
    orderProduct.setQuantity(this.getQuantity());
    orderProduct.setOrderId(this.getOrderId());
    return orderProduct;
  }


  /**
   * Sets the quoteProduct attribute of the QuoteProductBean object
   *
   * @param tmp The new quoteProduct value
   */
  public void setOrderProduct(OrderProduct tmp) {
    this.orderProduct = tmp;
  }


  /**
   * Gets the pricing attribute of the QuoteProductBean object
   *
   * @return The pricing value
   * @throws SQLException Description of the Exception
   */
  public ProductCatalogPricing getPricing() throws SQLException {
    if (product == null || product.getId() == -1) {
      throw new SQLException("Product not found");
    }
    pricing = new ProductCatalogPricing();
    pricing.setProductId(product.getId());
    pricing.setPriceAmount(this.getPriceAmount());
    pricing.setPriceCurrency(this.getPriceCurrency());
    pricing.setRecurringAmount(this.getRecurringAmount());
    pricing.setRecurringCurrency(this.getRecurringCurrency());
    pricing.setRecurringType(this.getRecurringType());
    pricing.setStartDate(this.getStartDate());
    pricing.setExpirationDate(this.getExpirationDate());
    pricing.setEnabled(true);
    return pricing;
  }


  /**
   * Sets the pricing attribute of the QuoteProductBean object
   *
   * @param tmp The new pricing value
   */
  public void setPricing(ProductCatalogPricing tmp) {
    this.pricing = tmp;
  }


  /**
   * Gets the comment attribute of the QuoteProductBean object
   *
   * @return The comment value
   */
  public String getComment() {
    return comment;
  }


  /**
   * Sets the comment attribute of the QuoteProductBean object
   *
   * @param tmp The new comment value
   */
  public void setComment(String tmp) {
    this.comment = tmp;
  }


  /**
   * Gets the numberParams attribute of the QuoteProductBean class
   *
   * @return The numberParams value
   */
  public static ArrayList getNumberParams() {
    ArrayList thisList = new ArrayList();
    thisList.add("extendedPrice");
    thisList.add("totalPrice");
    thisList.add("msrpAmount");
    thisList.add("costAmount");
    thisList.add("priceAmount");
    thisList.add("recurringAmount");
    return thisList;
  }

}

