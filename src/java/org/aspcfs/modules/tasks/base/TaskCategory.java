package org.aspcfs.modules.tasks.base;

import com.darkhorseventures.framework.beans.*;
import com.darkhorseventures.framework.actions.*;
import java.util.*;
import java.sql.*;
import java.text.*;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.modules.base.Constants;

/**
 *  Description of the Class
 *
 *@author     mrajkowski
 *@created    January 14, 2003
 *@version    $Id$
 */
public class TaskCategory extends GenericBean {

  private int id = -1;
  private String description = null;
  private boolean defaultItem = false;
  private int level = 0;
  private boolean enabled = true;

  private int linkModuleId = -1;
  private int linkItemId = -1;
  private int taskCount = 0;
  private java.sql.Timestamp lastTaskEntered = null;


  /**
   *  Sets the id attribute of the TaskCategory object
   *
   *@param  tmp  The new id value
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   *  Sets the id attribute of the TaskCategory object
   *
   *@param  tmp  The new id value
   */
  public void setId(String tmp) {
    this.id = Integer.parseInt(tmp);
  }


  /**
   *  Sets the description attribute of the TaskCategory object
   *
   *@param  tmp  The new description value
   */
  public void setDescription(String tmp) {
    this.description = tmp;
  }


  /**
   *  Sets the defaultItem attribute of the TaskCategory object
   *
   *@param  tmp  The new defaultItem value
   */
  public void setDefaultItem(boolean tmp) {
    this.defaultItem = tmp;
  }


  /**
   *  Sets the defaultItem attribute of the TaskCategory object
   *
   *@param  tmp  The new defaultItem value
   */
  public void setDefaultItem(String tmp) {
    this.defaultItem = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Sets the level attribute of the TaskCategory object
   *
   *@param  tmp  The new level value
   */
  public void setLevel(int tmp) {
    this.level = tmp;
  }


  /**
   *  Sets the level attribute of the TaskCategory object
   *
   *@param  tmp  The new level value
   */
  public void setLevel(String tmp) {
    this.level = Integer.parseInt(tmp);
  }


  /**
   *  Sets the enabled attribute of the TaskCategory object
   *
   *@param  tmp  The new enabled value
   */
  public void setEnabled(boolean tmp) {
    this.enabled = tmp;
  }


  /**
   *  Sets the enabled attribute of the TaskCategory object
   *
   *@param  tmp  The new enabled value
   */
  public void setEnabled(String tmp) {
    this.enabled = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Sets the taskCount attribute of the TaskCategory object
   *
   *@param  tmp  The new taskCount value
   */
  public void setTaskCount(int tmp) {
    this.taskCount = tmp;
  }


  /**
   *  Sets the taskCount attribute of the TaskCategory object
   *
   *@param  tmp  The new taskCount value
   */
  public void setTaskCount(String tmp) {
    this.taskCount = Integer.parseInt(tmp);
  }


  /**
   *  Sets the lastTaskEntered attribute of the TaskCategory object
   *
   *@param  tmp  The new lastTaskEntered value
   */
  public void setLastTaskEntered(java.sql.Timestamp tmp) {
    this.lastTaskEntered = tmp;
  }


  /**
   *  Sets the lastTaskEntered attribute of the TaskCategory object
   *
   *@param  tmp  The new lastTaskEntered value
   */
  public void setLastTaskEntered(String tmp) {
    this.lastTaskEntered = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   *  Sets the linkModuleId attribute of the TaskCategory object
   *
   *@param  tmp  The new linkModuleId value
   */
  public void setLinkModuleId(int tmp) {
    this.linkModuleId = tmp;
  }


  /**
   *  Sets the linkModuleId attribute of the TaskCategory object
   *
   *@param  tmp  The new linkModuleId value
   */
  public void setLinkModuleId(String tmp) {
    this.linkModuleId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the linkItemId attribute of the TaskCategory object
   *
   *@param  tmp  The new linkItemId value
   */
  public void setLinkItemId(int tmp) {
    this.linkItemId = tmp;
  }


  /**
   *  Sets the linkItemId attribute of the TaskCategory object
   *
   *@param  tmp  The new linkItemId value
   */
  public void setLinkItemId(String tmp) {
    this.linkItemId = Integer.parseInt(tmp);
  }


  /**
   *  Gets the id attribute of the TaskCategory object
   *
   *@return    The id value
   */
  public int getId() {
    return id;
  }


  /**
   *  Gets the description attribute of the TaskCategory object
   *
   *@return    The description value
   */
  public String getDescription() {
    return description;
  }


  /**
   *  Gets the defaultItem attribute of the TaskCategory object
   *
   *@return    The defaultItem value
   */
  public boolean getDefaultItem() {
    return defaultItem;
  }


  /**
   *  Gets the level attribute of the TaskCategory object
   *
   *@return    The level value
   */
  public int getLevel() {
    return level;
  }


  /**
   *  Gets the enabled attribute of the TaskCategory object
   *
   *@return    The enabled value
   */
  public boolean getEnabled() {
    return enabled;
  }


  /**
   *  Gets the taskCount attribute of the TaskCategory object
   *
   *@return    The taskCount value
   */
  public int getTaskCount() {
    return taskCount;
  }


  /**
   *  Gets the lastTaskEntered attribute of the TaskCategory object
   *
   *@return    The lastTaskEntered value
   */
  public java.sql.Timestamp getLastTaskEntered() {
    return lastTaskEntered;
  }


  /**
   *  Constructor for the TaskCategory object
   */
  public TaskCategory() { }


  /**
   *  Constructor for the TaskCategory object
   *
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public TaskCategory(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }


  /**
   *  Constructor for the TaskCategory object
   *
   *@param  db                Description of the Parameter
   *@param  categoryId        Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public TaskCategory(Connection db, int categoryId) throws SQLException {
    if (categoryId == -1) {
      throw new SQLException("Category ID not specified");
    }
    PreparedStatement pst = db.prepareStatement(
        "SELECT * " +
        "FROM lookup_task_category " +
        "WHERE code = ? ");
    pst.setInt(1, categoryId);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    }
    rs.close();
    pst.close();
    if (id == -1) {
      throw new SQLException("Category ID not found");
    }
    buildResources(db);
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void buildResources(Connection db) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "SELECT max(entered) AS latest, count(task_id) AS count " +
        "FROM task " +
        "WHERE category_id = ? ");
    pst.setInt(1, id);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      lastTaskEntered = rs.getTimestamp("latest");
      taskCount = rs.getInt("count");
    }
    rs.close();
    pst.close();
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public boolean insert(Connection db) throws SQLException {
    String sql = null;
    if (!isValid()) {
      return false;
    }
    try {
      db.setAutoCommit(false);
      sql = "INSERT INTO lookup_task_category " +
          "(description, default_item, level, enabled) " +
          "VALUES (?, ?, ?, ?) ";
      int i = 0;
      PreparedStatement pst = db.prepareStatement(sql);
      pst.setString(++i, description);
      pst.setBoolean(++i, defaultItem);
      pst.setInt(++i, level);
      pst.setBoolean(++i, enabled);
      pst.execute();
      this.id = DatabaseUtils.getCurrVal(db, "lookup_task_category_code_seq");
      pst.close();
      if (linkModuleId == Constants.TASK_CATEGORY_PROJECTS) {
        pst = db.prepareStatement(
            "INSERT INTO taskcategory_project " +
            "(category_id, project_id) " +
            "VALUES " +
            "(?, ?) ");
        pst.setInt(1, id);
        pst.setInt(2, linkItemId);
        pst.execute();
        pst.close();
      }
      db.commit();
    } catch (SQLException e) {
      db.rollback();
      throw new SQLException(e.getMessage());
    } finally {
      db.setAutoCommit(true);
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public int update(Connection db) throws SQLException {
    if (this.getId() == -1) {
      throw new SQLException("Record ID was not specified");
    }

    int resultCount = 0;
    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();
    sql.append(
        "UPDATE lookup_task_category " +
        "SET description = ?, default_item = ?, level = ?, enabled = ? " +
        "WHERE code = ? ");
    int i = 0;
    pst = db.prepareStatement(sql.toString());
    pst.setString(++i, description);
    pst.setBoolean(++i, defaultItem);
    pst.setInt(++i, level);
    pst.setBoolean(++i, enabled);
    pst.setInt(++i, id);
    resultCount = pst.executeUpdate();
    pst.close();
    return resultCount;
  }


  /**
   *  Gets the valid attribute of the TaskCategory object
   *
   *@return    The valid value
   */
  private boolean isValid() {
    if (linkModuleId == -1) {
      return false;
    }

    if (linkItemId == -1) {
      return false;
    }

    if (description == null || "".equals(description.trim())) {
      return false;
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  private void buildRecord(ResultSet rs) throws SQLException {
    id = rs.getInt("code");
    description = rs.getString("description");
    defaultItem = rs.getBoolean("default_item");
    level = rs.getInt("level");
    enabled = rs.getBoolean("enabled");
  }
}

