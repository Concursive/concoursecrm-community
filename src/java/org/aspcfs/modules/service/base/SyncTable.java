//Copyright 2002 Dark Horse Ventures

package com.darkhorseventures.cfsbase;

import org.theseus.beans.*;
import org.theseus.actions.*;
import java.sql.*;
import com.darkhorseventures.utils.DatabaseUtils;

public class SyncTable extends GenericBean {

  private int id = -1;
  private int systemId = -1;
  private String tableName = null;
  private String mappedClassName = null;
  private java.sql.Timestamp entered = null;
  private java.sql.Timestamp modified = null;
  private String createStatement = null;
  private int orderId = -1;
  
  private boolean buildTextFields = true;

  public SyncTable() { }
  
  public SyncTable(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }

  public void setId(int tmp) { this.id = tmp; }
  public void setSystemId(int tmp) { this.systemId = tmp; }
  public void setTableName(String tmp) { this.tableName = tmp; }
  public void setMappedClassName(String tmp) { this.mappedClassName = tmp; }
  public void setEntered(java.sql.Timestamp tmp) { this.entered = tmp; }
  public void setModified(java.sql.Timestamp tmp) { this.modified = tmp; }
  public void setCreateStatement(String tmp) { this.createStatement = tmp; }
  public void setOrderId(int tmp) { this.orderId = tmp; }
  public void setBuildTextFields(boolean tmp) { this.buildTextFields = tmp; }

  public int getId() { return id; }
  public int getSystemId() { return systemId; }
  public String getTableName() { return tableName; }
  public String getMappedClassName() { return mappedClassName; }
  public java.sql.Timestamp getEntered() { return entered; }
  public java.sql.Timestamp getModified() { return modified; }
  public String getCreateStatement() { return createStatement; }
  public int getOrderId() { return orderId; }
  public boolean getBuildTextFields() { return buildTextFields; }

  public void buildRecord(ResultSet rs) throws SQLException {
    id = rs.getInt("table_id");
    systemId = rs.getInt("system_id");
    tableName = rs.getString("table_name");
    mappedClassName = rs.getString("mapped_class_name");
    System.out.println("SyncTable-> Getting entered");
    entered = rs.getTimestamp("entered");
    System.out.println("SyncTable-> Getting modified");
    modified = rs.getTimestamp("modified");
    if (buildTextFields) {
      createStatement = rs.getString("create_statement");
    }
    orderId = rs.getInt("order_id");
  }
}

