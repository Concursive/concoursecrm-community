//Copyright 2002 Dark Horse Ventures

package org.aspcfs.modules.communications.base;

import java.sql.*;
import org.aspcfs.utils.DatabaseUtils;

/**
 *  Description of the Class
 *
 *@author     Mathur
 *@created    January 14, 2003
 *@version    $Id$
 */
public class SavedCriteriaElement {

  private int savedCriteriaListId = -1;
  private int fieldId = -1;
  private String operator = null;
  private int operatorId = -1;
  private String value = null;


  /**
   *  Constructor for the SavedCriteriaElement object
   */
  public SavedCriteriaElement() { }


  /**
   *  Sets the savedCriteriaListId attribute of the SavedCriteriaElement object
   *
   *@param  tmp  The new savedCriteriaListId value
   */
  public void setSavedCriteriaListId(int tmp) {
    this.savedCriteriaListId = tmp;
  }


  /**
   *  Sets the savedCriteriaListId attribute of the SavedCriteriaElement object
   *
   *@param  tmp  The new savedCriteriaListId value
   */
  public void setSavedCriteriaListId(String tmp) {
    this.savedCriteriaListId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the fieldId attribute of the SavedCriteriaElement object
   *
   *@param  tmp  The new fieldId value
   */
  public void setFieldId(int tmp) {
    this.fieldId = tmp;
  }


  /**
   *  Sets the fieldId attribute of the SavedCriteriaElement object
   *
   *@param  tmp  The new fieldId value
   */
  public void setFieldId(String tmp) {
    this.fieldId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the operator attribute of the SavedCriteriaElement object
   *
   *@param  tmp  The new operator value
   */
  public void setOperator(String tmp) {
    this.operator = tmp;
  }


  /**
   *  Sets the operatorId attribute of the SavedCriteriaElement object
   *
   *@param  tmp  The new operatorId value
   */
  public void setOperatorId(int tmp) {
    this.operatorId = tmp;
  }


  /**
   *  Sets the operatorId attribute of the SavedCriteriaElement object
   *
   *@param  tmp  The new operatorId value
   */
  public void setOperatorId(String tmp) {
    this.operatorId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the value attribute of the SavedCriteriaElement object
   *
   *@param  tmp  The new value value
   */
  public void setValue(String tmp) {
    this.value = tmp;
  }


  /**
   *  Gets the savedCriteriaListId attribute of the SavedCriteriaElement object
   *
   *@return    The savedCriteriaListId value
   */
  public int getSavedCriteriaListId() {
    return savedCriteriaListId;
  }


  /**
   *  Gets the fieldId attribute of the SavedCriteriaElement object
   *
   *@return    The fieldId value
   */
  public int getFieldId() {
    return fieldId;
  }


  /**
   *  Gets the operator attribute of the SavedCriteriaElement object
   *
   *@return    The operator value
   */
  public String getOperator() {
    return operator;
  }


  /**
   *  Gets the operatorId attribute of the SavedCriteriaElement object
   *
   *@return    The operatorId value
   */
  public int getOperatorId() {
    return operatorId;
  }


  /**
   *  Gets the value attribute of the SavedCriteriaElement object
   *
   *@return    The value value
   */
  public String getValue() {
    return value;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public boolean insert(Connection db) throws SQLException {
    if (savedCriteriaListId == -1) {
      throw new SQLException("SavedCriteriaList ID not specified");
    }
    if (fieldId == -1) {
      throw new SQLException("Field ID not specified");
    }
    if (operatorId == -1) {
      throw new SQLException("Field ID not specified");
    }
    PreparedStatement pst = db.prepareStatement(
        "INSERT INTO saved_criteriaelement " +
        "(id, field, operator, operatorid, value) VALUES " +
        "(?, ?, ?, ?, ?) ");
    int i = 0;
    pst.setInt(++i, savedCriteriaListId);
    pst.setInt(++i, fieldId);
    pst.setString(++i, operator);
    pst.setInt(++i, operatorId);
    pst.setString(++i, value);
    pst.execute();
    pst.close();
    return true;
  }
}

