//Copyright 2002 Dark Horse Ventures

package com.darkhorseventures.cfsbase;

import org.theseus.beans.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.darkhorseventures.utils.DatabaseUtils;


public class PermissionCategory extends GenericBean {

  private int id = -1;
  private String category = null;
  private String description = null;
  private int level = -1;
  private boolean enabled = false;
  private boolean active = false;
  private boolean lookups = false;
  private boolean folders = false;
  
  public static final int PERMISSION_CAT_LEADS = 4;
  public static final int LOOKUP_LEADS_STAGE = 1;
  public static final int LOOKUP_LEADS_TYPE = 2;
  
  public static final int PERMISSION_CAT_ACCOUNTS = 1;
  public static final int LOOKUP_ACCOUNTS_TYPE = 1;
  public static final int LOOKUP_ACCOUNTS_REVENUE_TYPE = 2;
  
  public static final int PERMISSION_CAT_CONTACTS = 2;
  public static final int LOOKUP_CONTACTS_TYPE = 1;
  public static final int LOOKUP_CONTACTS_EMAIL = 2;
  public static final int LOOKUP_CONTACTS_ADDRESS = 3;
  public static final int LOOKUP_CONTACTS_PHONE = 4;
  public static final int LOOKUP_CONTACTS_DEPT = 5;
  
  public static final int PERMISSION_CAT_TICKETS = 8;
  public static final int LOOKUP_TICKETS_SOURCE = 1;
  public static final int LOOKUP_TICKETS_SEVERITY = 2;
  public static final int LOOKUP_TICKETS_PRIORITY = 3;  

  public PermissionCategory() { }

  public PermissionCategory(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }

  public PermissionCategory(Connection db, int id) throws SQLException {
    queryRecord(db, id);
  }
  
  private void queryRecord(Connection db, int id) throws SQLException {
    if (id == -1) {
      throw new SQLException("Invalid Permission Category ID");
    }
    PreparedStatement pst = db.prepareStatement(
      "SELECT * " +
      "FROM permission_category " +
      "WHERE category_id = ? ");
    pst.setInt(1, id);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    } else {
      rs.close();
      pst.close();
      throw new SQLException("Permission category not found");
    }
    rs.close();
    pst.close();
  }
  
  public void setId(int tmp) { this.id = tmp; }
  public void setId(String tmp) { this.id = Integer.parseInt(tmp); }
  public void setCategory(String tmp) { this.category = tmp; }
  public void setDescription(String tmp) { this.description = tmp; }
  public void setLevel(int tmp) { this.level = tmp; }
  public void setLevel(String tmp) { this.level = Integer.parseInt(tmp); }
  public void setEnabled(boolean tmp) { this.enabled = tmp; }
  public void setEnabled(String tmp) { this.enabled = DatabaseUtils.parseBoolean(tmp); }
  public void setActive(boolean tmp) { this.active = tmp; }
  public void setActive(String tmp) { this.active = DatabaseUtils.parseBoolean(tmp); }
  public int getId() { return id; }
  public String getCategory() { return category; }
  public String getDescription() { return description; }
  public int getLevel() { return level; }
  public boolean getEnabled() { return enabled; }
  public boolean getActive() { return active; }
  public boolean getLookups() { return lookups; }
  public boolean getFolders() { return folders; }
  public void setLookups(boolean tmp) { this.lookups = tmp; }
  public void setLookups(String tmp) { this.lookups = DatabaseUtils.parseBoolean(tmp); }
  public void setFolders(boolean tmp) { this.folders = tmp; }
  public void setFolders(String tmp) { this.folders = DatabaseUtils.parseBoolean(tmp); }


  public boolean insert(Connection db) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "INSERT INTO permission_category (category, description, " +
        "level, enabled, active) " +
        "VALUES ( ?, ?, ?, ?, ? ) ");
    int i = 0;
    pst.setString(++i, category);
    pst.setString(++i, description);
    pst.setInt(++i, level);
    pst.setBoolean(++i, enabled);
    pst.setBoolean(++i, active);
    pst.execute();
    pst.close();
    id = DatabaseUtils.getCurrVal(db, "permission_cate_category_id_seq");
    return true;
  }

  protected void buildRecord(ResultSet rs) throws SQLException {
    id = rs.getInt("category_id");
    category = rs.getString("category");
    description = rs.getString("description");
    level = rs.getInt("level");
    enabled = rs.getBoolean("enabled");
    active = rs.getBoolean("active");
    folders = rs.getBoolean("folders");
    lookups = rs.getBoolean("lookups");
  }

}

