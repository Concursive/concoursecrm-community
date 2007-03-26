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
package org.aspcfs.modules.base;

import com.darkhorseventures.framework.beans.GenericBean;

import org.aspcfs.utils.DatabaseUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *  Represents a data field for a record. Multiple fields can make up a record.
 *
 * @author     matt rajkowski
 * @created    ---
 * @version    $Id$
 */
public class CustomFieldData extends GenericBean {

  private int id = -1;
  private int recordId = -1;
  private int fieldId = -1;
  private int selectedItemId = -1;
  private String enteredValue = null;
  private int enteredNumber = 0;
  private double enteredDouble = 0;
  private java.sql.Timestamp entered = null;
  private java.sql.Timestamp modified = null;


  /**
   *  Gets the id attribute of the CustomFieldData object
   *
   * @return    The id value
   */
  public int getId() {
    return id;
  }


  /**
   *  Sets the id attribute of the CustomFieldData object
   *
   * @param  tmp  The new id value
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   *  Sets the id attribute of the CustomFieldData object
   *
   * @param  tmp  The new id value
   */
  public void setId(String tmp) {
    this.id = Integer.parseInt(tmp);
  }


  /**
   *  Gets the entered attribute of the CustomFieldData object
   *
   * @return    The entered value
   */
  public java.sql.Timestamp getEntered() {
    return entered;
  }


  /**
   *  Sets the entered attribute of the CustomFieldData object
   *
   * @param  tmp  The new entered value
   */
  public void setEntered(java.sql.Timestamp tmp) {
    this.entered = tmp;
  }


  /**
   *  Sets the entered attribute of the CustomFieldData object
   *
   * @param  tmp  The new entered value
   */
  public void setEntered(String tmp) {
    this.entered = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   *  Gets the modified attribute of the CustomFieldData object
   *
   * @return    The modified value
   */
  public java.sql.Timestamp getModified() {
    return modified;
  }


  /**
   *  Sets the modified attribute of the CustomFieldData object
   *
   * @param  tmp  The new modified value
   */
  public void setModified(java.sql.Timestamp tmp) {
    this.modified = tmp;
  }


  /**
   *  Sets the modified attribute of the CustomFieldData object
   *
   * @param  tmp  The new modified value
   */
  public void setModified(String tmp) {
    this.modified = DatabaseUtils.parseTimestamp(tmp);
  }



  /**
   *  Constructor for the CustomFieldData object
   */
  public CustomFieldData() { }


  /**
   *  Constructor for the CustomFieldData object
   *
   * @param  rs                Description of the Parameter
   * @exception  SQLException  Description of the Exception
   * @throws  SQLException     Description of the Exception
   */
  public CustomFieldData(ResultSet rs) throws SQLException {
    build(rs);
  }


  /**
   *  Sets the recordId attribute of the CustomFieldData object
   *
   * @param  tmp  The new recordId value
   */
  public void setRecordId(int tmp) {
    this.recordId = tmp;
  }


  /**
   *  Sets the recordId attribute of the CustomFieldData object
   *
   * @param  tmp  The new recordId value
   */
  public void setRecordId(String tmp) {
    this.recordId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the fieldId attribute of the CustomFieldData object
   *
   * @param  tmp  The new fieldId value
   */
  public void setFieldId(int tmp) {
    this.fieldId = tmp;
  }


  /**
   *  Sets the fieldId attribute of the CustomFieldData object
   *
   * @param  tmp  The new fieldId value
   */
  public void setFieldId(String tmp) {
    this.fieldId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the selectedItemId attribute of the CustomFieldData object
   *
   * @param  tmp  The new selectedItemId value
   */
  public void setSelectedItemId(int tmp) {
    this.selectedItemId = tmp;
  }


  /**
   *  Sets the selectedItemId attribute of the CustomFieldData object
   *
   * @param  tmp  The new selectedItemId value
   */
  public void setSelectedItemId(String tmp) {
    this.selectedItemId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the enteredValue attribute of the CustomFieldData object
   *
   * @param  tmp  The new enteredValue value
   */
  public void setEnteredValue(String tmp) {
    this.enteredValue = tmp;
  }


  /**
   *  Sets the enteredNumber attribute of the CustomFieldData object
   *
   * @param  tmp  The new enteredNumber value
   */
  public void setEnteredNumber(int tmp) {
    this.enteredNumber = tmp;
  }


  /**
   *  Sets the enteredNumber attribute of the CustomFieldData object
   *
   * @param  tmp  The new enteredNumber value
   */
  public void setEnteredNumber(String tmp) {
    this.enteredNumber = Integer.parseInt(tmp);
  }


  /**
   *  Sets the enteredDouble attribute of the CustomFieldData object
   *
   * @param  tmp  The new enteredDouble value
   */
  public void setEnteredDouble(double tmp) {
    this.enteredDouble = tmp;
  }


  /**
   *  Sets the enteredDouble attribute of the CustomFieldData object
   *
   * @param  tmp  The new enteredDouble value
   */
  public void setEnteredDouble(String tmp) {
    this.enteredDouble = Double.parseDouble(tmp);
  }


  /**
   *  Gets the recordId attribute of the CustomFieldData object
   *
   * @return    The recordId value
   */
  public int getRecordId() {
    return recordId;
  }


  /**
   *  Gets the fieldId attribute of the CustomFieldData object
   *
   * @return    The fieldId value
   */
  public int getFieldId() {
    return fieldId;
  }


  /**
   *  Gets the selectedItemId attribute of the CustomFieldData object
   *
   * @return    The selectedItemId value
   */
  public int getSelectedItemId() {
    return selectedItemId;
  }


  /**
   *  Gets the enteredValue attribute of the CustomFieldData object
   *
   * @return    The enteredValue value
   */
  public String getEnteredValue() {
    return enteredValue;
  }


  /**
   *  Gets the enteredNumber attribute of the CustomFieldData object
   *
   * @return    The enteredNumber value
   */
  public int getEnteredNumber() {
    return enteredNumber;
  }


  /**
   *  Gets the enteredDouble attribute of the CustomFieldData object
   *
   * @return    The enteredDouble value
   */
  public double getEnteredDouble() {
    return enteredDouble;
  }


  /**
   *  Gets the type attribute of the CustomFieldData object
   *
   * @param  db             Description of the Parameter
   * @return                The type value
   * @throws  SQLException  Description of the Exception
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
   * @param  rs             Description of the Parameter
   * @throws  SQLException  Description of the Exception
   */
  public void build(ResultSet rs) throws SQLException {
    id = rs.getInt("data_id");
    recordId = rs.getInt("record_id");
    fieldId = rs.getInt("field_id");
    selectedItemId = rs.getInt("selected_item_id");
    enteredValue = rs.getString("entered_value");
    enteredNumber = rs.getInt("entered_number");
    enteredDouble = rs.getDouble("entered_float");
    entered = rs.getTimestamp("entered");
    modified = rs.getTimestamp("modified");
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public boolean insert(Connection db) throws SQLException {
    StringBuffer sql = new StringBuffer();
    sql.append(
        "INSERT INTO custom_field_data " +
        "(record_id, field_id, selected_item_id, entered_value, entered_number, ");
    if (id > -1) {
      sql.append("data_id, ");
    }
    sql.append("entered, modified, ");
    sql.append("entered_float ) ");
    sql.append("VALUES (?, ?, ?, ?, ?, ");
    if (id > -1) {
      sql.append("?, ");
    }
    if (entered != null) {
      sql.append("?, ");
    } else {
      sql.append(DatabaseUtils.getCurrentTimestamp(db) + ", ");
    }
    if (modified != null) {
      sql.append("?, ");
    } else {
      sql.append(DatabaseUtils.getCurrentTimestamp(db) + ", ");
    }
    sql.append("?) ");
    int i = 0;
    PreparedStatement pst = db.prepareStatement(sql.toString());
    pst.setInt(++i, recordId);
    pst.setInt(++i, fieldId);
    pst.setInt(++i, selectedItemId);
    pst.setString(++i, enteredValue);
    pst.setInt(++i, enteredNumber);
    if (id > -1) {
      pst.setInt(++i, id);
    }
    if (entered != null) {
      pst.setTimestamp(++i, entered);
    }
    if (modified != null) {
      pst.setTimestamp(++i, modified);
    }
    pst.setDouble(++i, enteredDouble);
    pst.execute();
    pst.close();
    return true;
  }
}

