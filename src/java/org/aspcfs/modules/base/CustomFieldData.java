//Copyright 2002 Dark Horse Ventures

package org.aspcfs.modules.base;

import com.darkhorseventures.framework.beans.*;
import java.util.*;
import java.sql.*;
import java.text.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.aspcfs.utils.DatabaseUtils;

/**
 *  Represents a data field for a record. Multiple fields can make up a record.
 *
 *@author     matt rajkowski
 *@created    ---
 *@version    $Id$
 */
public class CustomFieldData extends GenericBean {

  private int recordId = -1;
  private int fieldId = -1;
  private int selectedItemId = -1;
  private String enteredValue = null;
  private int enteredNumber = 0;
  private double enteredDouble = 0;


  /**
   *  Constructor for the CustomFieldData object
   */
  public CustomFieldData() { }


  /**
   *  Constructor for the CustomFieldData object
   *
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public CustomFieldData(ResultSet rs) throws SQLException {
    build(rs);
  }


  /**
   *  Sets the recordId attribute of the CustomFieldData object
   *
   *@param  tmp  The new recordId value
   */
  public void setRecordId(int tmp) {
    this.recordId = tmp;
  }


  /**
   *  Sets the recordId attribute of the CustomFieldData object
   *
   *@param  tmp  The new recordId value
   */
  public void setRecordId(String tmp) {
    this.recordId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the fieldId attribute of the CustomFieldData object
   *
   *@param  tmp  The new fieldId value
   */
  public void setFieldId(int tmp) {
    this.fieldId = tmp;
  }


  /**
   *  Sets the fieldId attribute of the CustomFieldData object
   *
   *@param  tmp  The new fieldId value
   */
  public void setFieldId(String tmp) {
    this.fieldId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the selectedItemId attribute of the CustomFieldData object
   *
   *@param  tmp  The new selectedItemId value
   */
  public void setSelectedItemId(int tmp) {
    this.selectedItemId = tmp;
  }


  /**
   *  Sets the selectedItemId attribute of the CustomFieldData object
   *
   *@param  tmp  The new selectedItemId value
   */
  public void setSelectedItemId(String tmp) {
    this.selectedItemId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the enteredValue attribute of the CustomFieldData object
   *
   *@param  tmp  The new enteredValue value
   */
  public void setEnteredValue(String tmp) {
    this.enteredValue = tmp;
  }


  /**
   *  Sets the enteredNumber attribute of the CustomFieldData object
   *
   *@param  tmp  The new enteredNumber value
   */
  public void setEnteredNumber(int tmp) {
    this.enteredNumber = tmp;
  }


  /**
   *  Sets the enteredNumber attribute of the CustomFieldData object
   *
   *@param  tmp  The new enteredNumber value
   */
  public void setEnteredNumber(String tmp) {
    this.enteredNumber = Integer.parseInt(tmp);
  }


  /**
   *  Sets the enteredDouble attribute of the CustomFieldData object
   *
   *@param  tmp  The new enteredDouble value
   */
  public void setEnteredDouble(double tmp) {
    this.enteredDouble = tmp;
  }


  /**
   *  Sets the enteredDouble attribute of the CustomFieldData object
   *
   *@param  tmp  The new enteredDouble value
   */
  public void setEnteredDouble(String tmp) {
    this.enteredDouble = Double.parseDouble(tmp);
  }


  /**
   *  Gets the recordId attribute of the CustomFieldData object
   *
   *@return    The recordId value
   */
  public int getRecordId() {
    return recordId;
  }


  /**
   *  Gets the fieldId attribute of the CustomFieldData object
   *
   *@return    The fieldId value
   */
  public int getFieldId() {
    return fieldId;
  }


  /**
   *  Gets the selectedItemId attribute of the CustomFieldData object
   *
   *@return    The selectedItemId value
   */
  public int getSelectedItemId() {
    return selectedItemId;
  }


  /**
   *  Gets the enteredValue attribute of the CustomFieldData object
   *
   *@return    The enteredValue value
   */
  public String getEnteredValue() {
    return enteredValue;
  }


  /**
   *  Gets the enteredNumber attribute of the CustomFieldData object
   *
   *@return    The enteredNumber value
   */
  public int getEnteredNumber() {
    return enteredNumber;
  }


  /**
   *  Gets the enteredDouble attribute of the CustomFieldData object
   *
   *@return    The enteredDouble value
   */
  public double getEnteredDouble() {
    return enteredDouble;
  }


  /**
   *  Gets the type attribute of the CustomFieldData object
   *
   *@param  db                Description of the Parameter
   *@return                   The type value
   *@exception  SQLException  Description of the Exception
   */
  public int getType(Connection db) throws SQLException {
    int result = -1;
    PreparedStatement pst = db.prepareStatement(
        "SELECT field_type " +
        "FROM custom_field_info " +
        "WHERE field_id = ? ");
    pst.setInt(1, fieldId);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      result = rs.getInt("field_type");
    }
    rs.close();
    pst.close();
    return result;
  }


  /**
   *  Description of the Method
   *
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void build(ResultSet rs) throws SQLException {
    recordId = rs.getInt("record_id");
    fieldId = rs.getInt("field_id");
    selectedItemId = rs.getInt("selected_item_id");
    enteredValue = rs.getString("entered_value");
    enteredNumber = rs.getInt("entered_number");
    enteredDouble = rs.getDouble("entered_float");
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public boolean insert(Connection db) throws SQLException {
    int i = 0;
    PreparedStatement pst = db.prepareStatement(
        "INSERT INTO custom_field_data " +
        "(record_id, field_id, selected_item_id, entered_value, entered_number, entered_float ) " +
        "VALUES (?, ?, ?, ?, ?, ?)");
    pst.setInt(++i, recordId);
    pst.setInt(++i, fieldId);
    pst.setInt(++i, selectedItemId);
    pst.setString(++i, enteredValue);
    pst.setInt(++i, enteredNumber);
    pst.setDouble(++i, enteredDouble);
    pst.execute();
    pst.close();
    return true;
  }
}

