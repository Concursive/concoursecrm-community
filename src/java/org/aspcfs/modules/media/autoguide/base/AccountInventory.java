//Copyright 2002 Dark Horse Ventures

package com.darkhorseventures.autoguide.base;

import org.theseus.beans.*;
import org.theseus.actions.*;
import java.sql.*;
import com.darkhorseventures.utils.DatabaseUtils;
import com.darkhorseventures.utils.ObjectUtils;

public class AccountInventory {

  private int id = -1;
  private int vehicleId = -1;
  private int accountId = -1;
  private String vin = null;
  private int adType = -1;
  private int mileage = -1;
  private boolean isNew = false;
  private String condition = null;
  private String comments = null;
  private String stockNo = null;
  private String exteriorColor = null;
  private String interiorColor = null;
  private double invoicePrice = -1;
  private double sellingPrice = -1;
  private String status = null;
  private java.sql.Timestamp entered = null;
  private int enteredBy = -1;
  private java.sql.Timestamp modified = null;
  private int modifiedBy = -1;
  private Vehicle vehicle = null;
  
  public AccountInventory() { }

  public AccountInventory(ResultSet rs) throws SQLException {
    buildRecord(rs);
    vehicle = new Vehicle(rs);
  }

  public void setId(int tmp) { id = tmp; }
  public void setId(String tmp) { id = Integer.parseInt(tmp); }
  public void setVehicleId(int tmp) { this.vehicleId = tmp; }
  public void setVehicleId(String tmp) { this.vehicleId = Integer.parseInt(tmp); }
  
  public void setAccountId(int tmp) { this.accountId = tmp; }
  public void setAccountId(String tmp) { this.accountId = Integer.parseInt(tmp); }
  public void setVin(String tmp) { this.vin = tmp; }
  public void setAdType(int tmp) { this.adType = tmp; }
  public void setAdType(String tmp) { this.adType = Integer.parseInt(tmp); }
  public void setMileage(int tmp) { this.mileage = tmp; }
  public void setMileage(String tmp) { this.mileage = Integer.parseInt(tmp); }
  public void setIsNew(boolean tmp) { this.isNew = tmp; }
  public void setIsNew(String tmp) { 
    this.isNew = ("on".equalsIgnoreCase(tmp) || "true".equalsIgnoreCase(tmp)); 
  }
  public void setCondition(String tmp) { this.condition = tmp; }
  public void setComments(String tmp) { this.comments = tmp; }
  public void setStockNo(String tmp) { this.stockNo = tmp; }
  public void setExteriorColor(String tmp) { this.exteriorColor = tmp; }
  public void setInteriorColor(String tmp) { this.interiorColor = tmp; }
  public void setInvoicePrice(double tmp) { this.invoicePrice = tmp; }
  public void setInvoicePrice(String tmp) { this.invoicePrice = Double.parseDouble(tmp); }
  public void setSellingPrice(double tmp) { this.sellingPrice = tmp; }
  public void setSellingPrice(String tmp) { this.sellingPrice = Double.parseDouble(tmp); }
  public void setStatus(String tmp) { this.status = tmp; }
  public void setEntered(java.sql.Timestamp tmp) { this.entered = tmp; }
  public void setEntered(String tmp) {
    this.entered = java.sql.Timestamp.valueOf(tmp);
  }
  public void setEnteredBy(int tmp) { this.enteredBy = tmp; }
  public void setEnteredBy(String tmp) { this.enteredBy = Integer.parseInt(tmp); }
  public void setModified(java.sql.Timestamp tmp) { this.modified = tmp; }
  public void setModified(String tmp) {
    this.modified = java.sql.Timestamp.valueOf(tmp);
  }
  public void setModifiedBy(int tmp) { this.modifiedBy = tmp; }
  public void setModifiedBy(String tmp) { this.modifiedBy = Integer.parseInt(tmp); }
  public void setVehicle(Vehicle tmp) { this.vehicle = tmp; }

  public int getId() { return id; }
  public int getVehicleId() { return vehicleId; }
  public int getAccountId() { return accountId; }
  public String getVin() { return vin; }
  public int getAdType() { return adType; }
  public int getMileage() { return mileage; }
  public boolean getIsNew() { return isNew; }
  public String getCondition() { return condition; }
  public String getComments() { return comments; }
  public String getStockNo() { return stockNo; }
  public String getExteriorColor() { return exteriorColor; }
  public String getInteriorColor() { return interiorColor; }
  public double getInvoicePrice() { return invoicePrice; }
  public double getSellingPrice() { return sellingPrice; }
  public String getStatus() { return status; }
  public java.sql.Timestamp getEntered() { return entered; }
  public int getEnteredBy() { return enteredBy; }
  public java.sql.Timestamp getModified() { return modified; }
  public int getModifiedBy() { return modifiedBy; }
  public String getGuid() {
    return ObjectUtils.generateGuid(entered, enteredBy, id);
  }
  public Vehicle getVehicle() { return vehicle; }

  public boolean insert(Connection db) throws SQLException {
    StringBuffer sql = new StringBuffer();
    sql.append(
        "INSERT INTO autoguide_account_inventory " +
        "(vehicle_id, vin, adtype, mileage, is_new, condition, comments, " +
        "stock_no, ext_color, int_color, invoice_price, selling_price, " +
        "status, enteredby, modifiedby) " +
        "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ");
    int i = 0;
    PreparedStatement pst = db.prepareStatement(sql.toString());
    pst.setInt(++i, vehicleId);
    pst.setString(++i, vin);
    pst.setInt(++i, adType);
    pst.setInt(++i, mileage);
    pst.setBoolean(++i, isNew);
    pst.setString(++i, condition);
    pst.setString(++i, comments);
    pst.setString(++i, stockNo);
    pst.setString(++i, exteriorColor);
    pst.setString(++i, interiorColor);
    pst.setDouble(++i, invoicePrice);
    pst.setDouble(++i, sellingPrice);
    pst.setString(++i, status);
    pst.setInt(++i, enteredBy);
    pst.setInt(++i, enteredBy);
    pst.execute();
    pst.close();

    id = DatabaseUtils.getCurrVal(db, "autoguide_acco_inventory_id_seq");
    return true;
  }


  public boolean delete(Connection db) throws SQLException {
    if (id == -1) {
      throw new SQLException("ID was not specified");
    }

    PreparedStatement pst = null;
    //Delete related records (mappings)

    //Delete the record
    int recordCount = 0;
    pst = db.prepareStatement(
        "DELETE FROM autoguide_account_inventory " +
        "WHERE inventory_id = ? ");
    pst.setInt(1, id);
    recordCount = pst.executeUpdate();
    pst.close();

    if (recordCount == 0) {
      //errors.put("actionError", "Record could not be deleted because it no longer exists.");
      return false;
    } else {
      return true;
    }
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@param  context           Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   */
  public int update(Connection db, ActionContext context) throws SQLException {
    if (id == -1) {
      throw new SQLException("Record ID was not specified");
    }

    int resultCount = 0;
    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();
    sql.append(
        "UPDATE autoguide_account_inventory " +
        "SET vehicle_id = ?, modifiedby = ?, " +
        "modified = CURRENT_TIMESTAMP " +
        "WHERE vehicle_id = ? " +
        "AND modified = ? ");
    int i = 0;
    pst = db.prepareStatement(sql.toString());
    pst.setInt(++i, vehicleId);
    pst.setInt(++i, modifiedBy);
    pst.setInt(++i, id);
    pst.setTimestamp(++i, this.getModified());
    resultCount = pst.executeUpdate();
    pst.close();
    return resultCount;
  }


  protected void buildRecord(ResultSet rs) throws SQLException {
    id = rs.getInt("inventory_id");
    vehicleId = rs.getInt("vehicle_id");
    entered = rs.getTimestamp("vehicle_entered");
    enteredBy = rs.getInt("vehicle_enteredby");
    modified = rs.getTimestamp("vehicle_modified");
    modifiedBy = rs.getInt("vehicle_modifiedby");
  }

}

