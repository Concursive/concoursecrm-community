//Copyright 2001-2002 Dark Horse Ventures

package org.aspcfs.modules.troubletickets.base;

import com.darkhorseventures.framework.beans.*;
import java.util.*;
import java.sql.*;
import java.text.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.aspcfs.utils.DatabaseUtils;

/**
 *  Represents a category in which a Ticket is classified
 *
 *@author     chris
 *@created    December 11, 2001
 *@version    $Id$
 */
public class TicketCategory extends GenericBean {

  private int id = -1;
  private int categoryLevel = -1;
  private int parentCode = -1;
  private String description = "";
  private boolean enabled = true;
  private int level = -1;


  /**
   *  Constructor for the TicketCategory object
   *
   *@since
   */
  public TicketCategory() { }


  /**
   *  Constructor for the TicketCategory object
   *
   *@param  rs                Description of Parameter
   *@exception  SQLException  Description of Exception
   *@since
   */
  public TicketCategory(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }


  /**
   *  Constructor for the TicketCategory object
   *
   *@param  db                Description of Parameter
   *@param  id                Description of the Parameter
   *@exception  SQLException  Description of Exception
   *@since
   */
  public TicketCategory(Connection db, int id) throws SQLException {
    if (id < 0) {
      throw new SQLException("Ticket Category not specified");
    }
    String sql =
        "SELECT tc.* " +
        "FROM ticket_category tc " +
        "WHERE tc.id > -1 " +
        "AND tc.id = ? ";
    PreparedStatement pst = db.prepareStatement(sql);
    pst.setInt(1, id);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    } else {
      rs.close();
      pst.close();
      throw new SQLException("Ticket Category record not found.");
    }
    rs.close();
    pst.close();
  }


  /**
   *  Sets the Code attribute of the TicketCategory object
   *
   *@param  tmp  The new Code value
   *@since
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   *  Sets the id attribute of the TicketCategory object
   *
   *@param  tmp  The new id value
   */
  public void setId(String tmp) {
    this.id = Integer.parseInt(tmp);
  }


  /**
   *  Sets the categoryLevel attribute of the TicketCategory object
   *
   *@param  tmp  The new categoryLevel value
   */
  public void setCategoryLevel(int tmp) {
    this.categoryLevel = tmp;
  }


  /**
   *  Sets the categoryLevel attribute of the TicketCategory object
   *
   *@param  tmp  The new categoryLevel value
   */
  public void setCategoryLevel(String tmp) {
    this.categoryLevel = Integer.parseInt(tmp);
  }


  /**
   *  Sets the Level attribute of the TicketCategory object
   *
   *@param  level  The new Level value
   *@since
   */
  public void setLevel(int level) {
    this.level = level;
  }


  /**
   *  Sets the Level attribute of the TicketCategory object
   *
   *@param  level  The new Level value
   *@since
   */
  public void setLevel(String level) {
    this.level = Integer.parseInt(level);
  }


  /**
   *  Sets the ParentCode attribute of the TicketCategory object
   *
   *@param  tmp  The new ParentCode value
   *@since
   */
  public void setParentCode(int tmp) {
    this.parentCode = tmp;
  }


  /**
   *  Sets the ParentCode attribute of the TicketCategory object
   *
   *@param  tmp  The new ParentCode value
   *@since
   */
  public void setParentCode(String tmp) {
    this.parentCode = Integer.parseInt(tmp);
  }


  /**
   *  Sets the Description attribute of the TicketCategory object
   *
   *@param  tmp  The new Description value
   *@since
   */
  public void setDescription(String tmp) {
    this.description = tmp;
  }


  /**
   *  Sets the Enabled attribute of the TicketCategory object
   *
   *@param  tmp  The new Enabled value
   *@since
   */
  public void setEnabled(boolean tmp) {
    this.enabled = tmp;
  }


  /**
   *  Sets the enabled attribute of the TicketCategory object
   *
   *@param  tmp  The new enabled value
   */
  public void setEnabled(String tmp) {
    this.enabled = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Gets the Level attribute of the TicketCategory object
   *
   *@return    The Level value
   *@since
   */
  public int getLevel() {
    return level;
  }


  /**
   *  Gets the Code attribute of the TicketCategory object
   *
   *@return    The Code value
   *@since
   */
  public int getId() {
    return id;
  }


  /**
   *  Gets the categoryLevel attribute of the TicketCategory object
   *
   *@return    The categoryLevel value
   */
  public int getCategoryLevel() {
    return categoryLevel;
  }


  /**
   *  Gets the ParentCode attribute of the TicketCategory object
   *
   *@return    The ParentCode value
   *@since
   */
  public int getParentCode() {
    return parentCode;
  }


  /**
   *  Gets the Description attribute of the TicketCategory object
   *
   *@return    The Description value
   *@since
   */
  public String getDescription() {
    return description;
  }


  /**
   *  Gets the Enabled attribute of the TicketCategory object
   *
   *@return    The Enabled value
   */
  public boolean getEnabled() {
    return enabled;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   */
  public boolean insert(Connection db) throws SQLException {
    StringBuffer sql = new StringBuffer();
    try {
      db.setAutoCommit(false);
      sql.append(
          "INSERT INTO ticket_category " +
          "(cat_level, parent_cat_code, description, level, enabled) " +
          "VALUES (?, ?, ?, ?, ?) ");
      int i = 0;
      PreparedStatement pst = db.prepareStatement(sql.toString());
      pst.setInt(++i, this.getCategoryLevel());
      if (parentCode > 0) {
        pst.setInt(++i, this.getParentCode());
      } else {
        pst.setInt(++i, 0);
      }
      pst.setString(++i, this.getDescription());
      pst.setInt(++i, this.getLevel());
      pst.setBoolean(++i, this.getEnabled());
      pst.execute();
      pst.close();
      id = DatabaseUtils.getCurrVal(db, "ticket_category_id_seq");
      db.commit();
    } catch (SQLException e) {
      db.rollback();
      db.setAutoCommit(true);
      throw new SQLException(e.getMessage());
    } finally {
      db.setAutoCommit(true);
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  rs                Description of Parameter
   *@exception  SQLException  Description of Exception
   *@since
   */
  protected void buildRecord(ResultSet rs) throws SQLException {
    id = rs.getInt("id");
    categoryLevel = rs.getInt("cat_level");
    parentCode = rs.getInt("parent_cat_code");
    description = rs.getString("description");
    level = rs.getInt("level");
    enabled = rs.getBoolean("enabled");
  }
}

