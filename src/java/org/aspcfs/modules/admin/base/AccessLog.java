//Copyright 2001-2002 Dark Horse Ventures

package org.aspcfs.modules.admin.base;

import java.util.*;
import java.sql.*;
import java.text.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.darkhorseventures.database.Connection;
import com.darkhorseventures.framework.beans.*;
import org.aspcfs.modules.utils.DatabaseUtils;
import org.aspcfs.modules.utils.DateUtils;
import org.aspcfs.modules.contacts.base.Contact;

/**
 *  Description of the Class
 *
 *@author     Mathur
 *@created    January 13, 2003
 *@version    $Id$
 */
public class AccessLog extends GenericBean {

  private int id = -1;
  private int userId = -1;
  private String username = "";
  private String ip = "";
  private String browser = "";
  private java.sql.Timestamp entered = null;


  /**
   *  Constructor for the AccessLog object
   */
  public AccessLog() { }


  /**
   *  Constructor for the AccessLog object
   *
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public AccessLog(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }


  /**
   *  Constructor for the AccessLog object
   *
   *@param  db                Description of the Parameter
   *@param  id                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public AccessLog(Connection db, int id) throws SQLException {
    queryRecord(db, id);
  }


  /**
   *  Constructor for the AccessLog object
   *
   *@param  db                Description of the Parameter
   *@param  id                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public AccessLog(Connection db, String id) throws SQLException {
    queryRecord(db, Integer.parseInt(id));
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  id                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void queryRecord(Connection db, int id) throws SQLException {

    if (id == -1) {
      throw new SQLException("Invalid Access Log ID");
    }

    PreparedStatement pst = db.prepareStatement(
        "SELECT a.* " +
        "FROM access_log a " +
        "WHERE a.id = ? ");
    pst.setInt(1, id);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    } else {
      rs.close();
      pst.close();
      throw new SQLException("Access Log not found");
    }
    rs.close();
    pst.close();
  }


  /**
   *  Gets the id attribute of the AccessLog object
   *
   *@return    The id value
   */
  public int getId() {
    return id;
  }


  /**
   *  Gets the userId attribute of the AccessLog object
   *
   *@return    The userId value
   */
  public int getUserId() {
    return userId;
  }


  /**
   *  Gets the username attribute of the AccessLog object
   *
   *@return    The username value
   */
  public String getUsername() {
    return username;
  }


  /**
   *  Gets the ip attribute of the AccessLog object
   *
   *@return    The ip value
   */
  public String getIp() {
    return ip;
  }


  /**
   *  Gets the browser attribute of the AccessLog object
   *
   *@return    The browser value
   */
  public String getBrowser() {
    return browser;
  }


  /**
   *  Gets the entered attribute of the AccessLog object
   *
   *@return    The entered value
   */
  public java.sql.Timestamp getEntered() {
    return entered;
  }


  /**
   *  Sets the id attribute of the AccessLog object
   *
   *@param  tmp  The new id value
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   *  Sets the id attribute of the AccessLog object
   *
   *@param  tmp  The new id value
   */
  public void setId(String tmp) {
    this.id = Integer.parseInt(tmp);
  }


  /**
   *  Sets the userId attribute of the AccessLog object
   *
   *@param  tmp  The new userId value
   */
  public void setUserId(int tmp) {
    this.userId = tmp;
  }


  /**
   *  Sets the userId attribute of the AccessLog object
   *
   *@param  tmp  The new userId value
   */
  public void setUserId(String tmp) {
    this.userId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the username attribute of the AccessLog object
   *
   *@param  tmp  The new username value
   */
  public void setUsername(String tmp) {
    this.username = tmp;
  }


  /**
   *  Sets the ip attribute of the AccessLog object
   *
   *@param  tmp  The new ip value
   */
  public void setIp(String tmp) {
    this.ip = tmp;
  }


  /**
   *  Sets the browser attribute of the AccessLog object
   *
   *@param  tmp  The new browser value
   */
  public void setBrowser(String tmp) {
    this.browser = tmp;
  }


  /**
   *  Sets the entered attribute of the AccessLog object
   *
   *@param  tmp  The new entered value
   */
  public void setEntered(String tmp) {
    this.entered = DateUtils.parseTimestampString(tmp);
  }


  /**
   *  Gets the enteredString attribute of the AccessLog object
   *
   *@return    The enteredString value
   */
  public String getEnteredString() {
    String tmp = "";
    try {
      return DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.LONG).format(entered);
    } catch (NullPointerException e) {
    }
    return tmp;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void insert(Connection db) throws SQLException {
    if (userId == -1) {
      throw new SQLException("Log Entry must be associated to a CFS User");
    }

    StringBuffer sql = new StringBuffer();
    try {
      db.setAutoCommit(false);
      sql.append(
          "INSERT INTO access_log (user_id, username, ip, ");
      if (entered != null) {
        sql.append("entered, ");
      }
      sql.append("browser ) ");
      sql.append("VALUES (?, ?, ?, ");
      if (entered != null) {
        sql.append("?, ");
      }
      sql.append("?) ");

      int i = 0;
      PreparedStatement pst = db.prepareStatement(sql.toString());
      pst.setInt(++i, this.getUserId());
      pst.setString(++i, this.getUsername());
      pst.setString(++i, this.getIp());
      if (entered != null) {
        pst.setTimestamp(++i, entered);
      }
      pst.setString(++i, this.getBrowser());
      pst.execute();
      pst.close();

      id = DatabaseUtils.getCurrVal(db, "access_log_id_seq");

      db.commit();
    } catch (SQLException e) {
      db.rollback();
      db.setAutoCommit(true);
      throw new SQLException(e.getMessage());
    } finally {
      db.setAutoCommit(true);
    }
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public boolean delete(Connection db) throws SQLException {
    if (this.getId() == -1) {
      throw new SQLException("Access Log ID not specified.");
    }

    try {
      db.setAutoCommit(false);
      PreparedStatement pst = db.prepareStatement(
          "DELETE FROM access_log " +
          "WHERE id = ? ");
      pst.setInt(1, this.getId());
      pst.executeUpdate();
      pst.close();
      db.commit();
    } catch (SQLException e) {
      db.rollback();
    } finally {
      db.setAutoCommit(true);
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  protected void buildRecord(ResultSet rs) throws SQLException {
    this.setId(rs.getInt("id"));
    userId = rs.getInt("user_id");
    username = rs.getString("username");
    ip = rs.getString("ip");
    browser = rs.getString("browser");
    entered = rs.getTimestamp("entered");
  }
}

