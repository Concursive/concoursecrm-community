//Copyright 2001 Dark Horse Ventures

package com.darkhorseventures.webutils;

import java.sql.*;
import java.util.*;
import com.darkhorseventures.utils.*;

/**
 *  Represents an item from a LookupListLookup table.
 *
 *@author     Mathur
 *@created    December 18, 2002
 *@version    $Id$
 */

public class LookupListElement {

  protected int moduleId = -1;
  protected int lookupId = -1;
  protected String tableName = null;
  protected String className = null;
  protected int level = 0;
  protected String description = "";
  protected java.sql.Timestamp entered = null;
  protected LookupList lookupList = null;


  /**
   *  Constructor for the LookupListElement object
   *
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public LookupListElement(ResultSet rs) throws SQLException { 
    buildRecord(rs);
  }


  /**
   *  Sets the moduleId attribute of the LookupListElement object
   *
   *@param  moduleId  The new moduleId value
   */
  public void setModuleId(int moduleId) {
    this.moduleId = moduleId;
  }


  /**
   *  Sets the lookupId attribute of the LookupListElement object
   *
   *@param  lookupId  The new lookupId value
   */
  public void setLookupId(int lookupId) {
    this.lookupId = lookupId;
  }


  /**
   *  Sets the tableName attribute of the LookupListElement object
   *
   *@param  tableName  The new tableName value
   */
  public void setTableName(String tableName) {
    this.tableName = tableName;
  }


  /**
   *  Sets the level attribute of the LookupListElement object
   *
   *@param  level  The new level value
   */
  public void setLevel(int level) {
    this.level = level;
  }


  /**
   *  Sets the description attribute of the LookupListElement object
   *
   *@param  description  The new description value
   */
  public void setDescription(String description) {
    this.description = description;
  }


  /**
   *  Sets the entered attribute of the LookupListElement object
   *
   *@param  entered  The new entered value
   */
  public void setEntered(java.sql.Timestamp entered) {
    this.entered = entered;
  }


  /**
   *  Sets the lookupList attribute of the LookupListElement object
   *
   *@param  lookupList  The new lookupList value
   */
  public void setLookupList(LookupList lookupList) {
    this.lookupList = lookupList;
  }


  /**
   *  Sets the className attribute of the LookupListElement object
   *
   *@param  className  The new className value
   */
  public void setClassName(String className) {
    this.className = className;
  }


  /**
   *  Gets the className attribute of the LookupListElement object
   *
   *@return    The className value
   */
  public String getClassName() {
    return className;
  }


  /**
   *  Gets the lookupList attribute of the LookupListElement object
   *
   *@return    The lookupList value
   */
  public LookupList getLookupList() {
    return lookupList;
  }


  /**
   *  Gets the moduleId attribute of the LookupListElement object
   *
   *@return    The moduleId value
   */
  public int getModuleId() {
    return moduleId;
  }


  /**
   *  Gets the lookupId attribute of the LookupListElement object
   *
   *@return    The lookupId value
   */
  public int getLookupId() {
    return lookupId;
  }


  /**
   *  Gets the tableName attribute of the LookupListElement object
   *
   *@return    The tableName value
   */
  public String getTableName() {
    return tableName;
  }


  /**
   *  Gets the level attribute of the LookupListElement object
   *
   *@return    The level value
   */
  public int getLevel() {
    return level;
  }


  /**
   *  Gets the description attribute of the LookupListElement object
   *
   *@return    The description value
   */
  public String getDescription() {
    return description;
  }


  /**
   *  Gets the entered attribute of the LookupListElement object
   *
   *@return    The entered value
   */
  public java.sql.Timestamp getEntered() {
    return entered;
  }


  /**
   *  Description of the Method
   *
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  protected void buildRecord(ResultSet rs) throws SQLException {
    moduleId = rs.getInt("module_id");
    lookupId = rs.getInt("lookup_id");
    className = rs.getString("class_name");
    tableName = rs.getString("table_name");
    level = rs.getInt("level");
    description = rs.getString("description");
    entered = rs.getTimestamp("entered");
  }

}

