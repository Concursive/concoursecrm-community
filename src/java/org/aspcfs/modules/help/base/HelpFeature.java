//Copyright 2003 Dark Horse Ventures

package org.aspcfs.modules.help.base;

import com.darkhorseventures.framework.beans.*;
import java.sql.*;
import org.aspcfs.utils.DatabaseUtils;
import java.io.*;
import java.util.*;
import java.text.*;

/**
 *  Represents a Help Feature on a page in CFS
 *
 *@author     akhi_m
 *@created    July 9, 2003
 *@version    $id:exp$
 */
public class HelpFeature extends GenericBean {
  //static variables
  public static int DONE = 1;

  //properties
  private int id = -1;
  private int linkHelpId = -1;
  private int linkFeatureId = -1;
  private String description = null;
  private int enteredBy = -1;
  private java.sql.Timestamp entered = null;
  private int modifiedBy = -1;
  private java.sql.Timestamp modified = null;
  private boolean complete = false;
  private java.sql.Timestamp completeDate = null;
  private int completedBy = -1;
  private boolean enabled = true;


  /**
   *Constructor for the HelpFeature object
   */
  public HelpFeature() { }



  /**
   *Constructor for the HelpFeature object
   *
   *@param  db                Description of the Parameter
   *@param  thisId            Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public HelpFeature(Connection db, int thisId) throws SQLException {
    if (thisId == -1) {
      throw new SQLException("Feature ID not specified");
    }

    PreparedStatement pst = db.prepareStatement(
        "SELECT f.* " +
        "FROM help_features f " +
        "WHERE feature_id = ? ");
    int i = 0;
    pst.setInt(++i, thisId);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    }
    rs.close();
    pst.close();
    if (thisId == -1) {
      throw new SQLException("Feature ID not found");
    }
  }


  /**
   *Constructor for the HelpFeature object
   *
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public HelpFeature(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }


  /**
   *  Sets the id attribute of the HelpFeature object
   *
   *@param  tmp  The new id value
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   *  Sets the id attribute of the HelpFeature object
   *
   *@param  tmp  The new id value
   */
  public void setId(String tmp) {
    this.id = Integer.parseInt(tmp);
  }


  /**
   *  Sets the linkHelpId attribute of the HelpFeature object
   *
   *@param  tmp  The new linkHelpId value
   */
  public void setLinkHelpId(int tmp) {
    this.linkHelpId = tmp;
  }


  /**
   *  Sets the linkHelpId attribute of the HelpFeature object
   *
   *@param  tmp  The new linkHelpId value
   */
  public void setLinkHelpId(String tmp) {
    this.linkHelpId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the description attribute of the HelpFeature object
   *
   *@param  tmp  The new description value
   */
  public void setDescription(String tmp) {
    this.description = tmp;
  }


  /**
   *  Sets the enteredBy attribute of the HelpFeature object
   *
   *@param  tmp  The new enteredBy value
   */
  public void setEnteredBy(int tmp) {
    this.enteredBy = tmp;
  }


  /**
   *  Sets the enteredBy attribute of the HelpFeature object
   *
   *@param  tmp  The new enteredBy value
   */
  public void setEnteredBy(String tmp) {
    this.enteredBy = Integer.parseInt(tmp);
  }


  /**
   *  Sets the entered attribute of the HelpFeature object
   *
   *@param  tmp  The new entered value
   */
  public void setEntered(java.sql.Timestamp tmp) {
    this.entered = tmp;
  }


  /**
   *  Sets the entered attribute of the HelpFeature object
   *
   *@param  tmp  The new entered value
   */
  public void setEntered(String tmp) {
    this.entered = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   *  Sets the modifiedBy attribute of the HelpFeature object
   *
   *@param  tmp  The new modifiedBy value
   */
  public void setModifiedBy(int tmp) {
    this.modifiedBy = tmp;
  }


  /**
   *  Sets the modifiedBy attribute of the HelpFeature object
   *
   *@param  tmp  The new modifiedBy value
   */
  public void setModifiedBy(String tmp) {
    this.modifiedBy = Integer.parseInt(tmp);
  }


  /**
   *  Sets the modified attribute of the HelpFeature object
   *
   *@param  tmp  The new modified value
   */
  public void setModified(java.sql.Timestamp tmp) {
    this.modified = tmp;
  }


  /**
   *  Sets the modified attribute of the HelpFeature object
   *
   *@param  tmp  The new modified value
   */
  public void setModified(String tmp) {
    this.modified = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   *  Sets the complete attribute of the HelpFeature object
   *
   *@param  tmp  The new complete value
   */
  public void setComplete(boolean tmp) {
    this.complete = tmp;
  }


  /**
   *  Sets the complete attribute of the HelpFeature object
   *
   *@param  tmp  The new complete value
   */
  public void setComplete(String tmp) {
    this.complete = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Sets the enabled attribute of the HelpFeature object
   *
   *@param  tmp  The new enabled value
   */
  public void setEnabled(boolean tmp) {
    this.enabled = tmp;
  }


  /**
   *  Sets the enabled attribute of the HelpFeature object
   *
   *@param  tmp  The new enabled value
   */
  public void setEnabled(String tmp) {
    this.enabled = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   *  Sets the completeDate attribute of the HelpFeature object
   *
   *@param  completeDate  The new completeDate value
   */
  public void setCompleteDate(java.sql.Timestamp completeDate) {
    this.completeDate = completeDate;
  }


  /**
   *  Gets the completeDate attribute of the HelpFeature object
   *
   *@return    The completeDate value
   */
  public java.sql.Timestamp getCompleteDate() {
    return completeDate;
  }


  /**
   *  Sets the completedBy attribute of the HelpFeature object
   *
   *@param  completedBy  The new completedBy value
   */
  public void setCompletedBy(int completedBy) {
    this.completedBy = completedBy;
  }


  /**
   *  Sets the linkFeatureId attribute of the HelpFeature object
   *
   *@param  linkFeatureId  The new linkFeatureId value
   */
  public void setLinkFeatureId(int linkFeatureId) {
    this.linkFeatureId = linkFeatureId;
  }


  /**
   *  Sets the linkFeatureId attribute of the HelpFeature object
   *
   *@param  linkFeatureId  The new linkFeatureId value
   */
  public void setLinkFeatureId(String linkFeatureId) {
    this.linkFeatureId = Integer.parseInt(linkFeatureId);
  }


  /**
   *  Gets the linkFeatureId attribute of the HelpFeature object
   *
   *@return    The linkFeatureId value
   */
  public int getLinkFeatureId() {
    return linkFeatureId;
  }


  /**
   *  Gets the completedBy attribute of the HelpFeature object
   *
   *@return    The completedBy value
   */
  public int getCompletedBy() {
    return completedBy;
  }


  /**
   *  Gets the completeDateString attribute of the HelpFeature object
   *
   *@return    The completeDateString value
   */
  public String getCompleteDateString() {
    String tmp = "";
    try {
      return DateFormat.getDateInstance(3).format(completeDate);
    } catch (NullPointerException e) {
    }
    return tmp;
  }


  /**
   *  Gets the id attribute of the HelpFeature object
   *
   *@return    The id value
   */
  public int getId() {
    return id;
  }


  /**
   *  Gets the linkHelpId attribute of the HelpFeature object
   *
   *@return    The linkHelpId value
   */
  public int getLinkHelpId() {
    return linkHelpId;
  }


  /**
   *  Gets the description attribute of the HelpFeature object
   *
   *@return    The description value
   */
  public String getDescription() {
    return description;
  }


  /**
   *  Gets the enteredBy attribute of the HelpFeature object
   *
   *@return    The enteredBy value
   */
  public int getEnteredBy() {
    return enteredBy;
  }


  /**
   *  Gets the entered attribute of the HelpFeature object
   *
   *@return    The entered value
   */
  public java.sql.Timestamp getEntered() {
    return entered;
  }


  /**
   *  Gets the modifiedBy attribute of the HelpFeature object
   *
   *@return    The modifiedBy value
   */
  public int getModifiedBy() {
    return modifiedBy;
  }


  /**
   *  Gets the modified attribute of the HelpFeature object
   *
   *@return    The modified value
   */
  public java.sql.Timestamp getModified() {
    return modified;
  }


  /**
   *  Gets the complete attribute of the HelpFeature object
   *
   *@return    The complete value
   */
  public boolean getComplete() {
    return complete;
  }


  /**
   *  Gets the enabled attribute of the HelpFeature object
   *
   *@return    The enabled value
   */
  public boolean getEnabled() {
    return enabled;
  }


  /**
   *  Insert a Help Feature
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public boolean insert(Connection db) throws SQLException {
    try {
      db.setAutoCommit(false);
      int i = 0;
      PreparedStatement pst = db.prepareStatement(
          "INSERT INTO help_features " +
          "(link_help_id, description, enteredby, modifiedby, enabled, " +
          (linkFeatureId > 0 ? " link_feature_id, " : "") + 
          "completedate, completedby) " +
          "VALUES (?, ?, ?, ?, ?, " +
          (linkFeatureId > 0 ? "?, " : "") +
          "?, ? ) "
          );
      pst.setInt(++i, this.getLinkHelpId());
      pst.setString(++i, this.getDescription());
      pst.setInt(++i, this.getEnteredBy());
      pst.setInt(++i, this.getModifiedBy());
      pst.setBoolean(++i, this.getEnabled());
      if(linkFeatureId > 0){
        pst.setInt(++i, linkFeatureId);
      }
      if (this.getComplete()) {
        pst.setTimestamp(++i, new Timestamp(System.currentTimeMillis()));
        pst.setInt(++i, completedBy);
      } else {
        pst.setTimestamp(++i, null);
        pst.setNull(++i, java.sql.Types.SMALLINT);
      }
      pst.execute();
      this.id = DatabaseUtils.getCurrVal(db, "help_features_feature_id_seq");
      pst.close();
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
   *  Update a Help Feature
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public int update(Connection db) throws SQLException {
    String sql = null;
    ResultSet rs = null;
    PreparedStatement pst = null;
    int count = 0;
    if (id == -1) {
      throw new SQLException("Feature ID not specified");
    }

    try {
      db.setAutoCommit(false);
      HelpFeature previousFeature = new HelpFeature(db, id);
      int i = 0;
      pst = db.prepareStatement(
          "UPDATE help_features " +
          "SET modifiedby = ?, description = ?, enabled = ?, " +
          (linkFeatureId > 0 ? " link_feature_id = ?, " : "") +
          "completedate = ?, completedby = ? " +
          "WHERE feature_id = ? AND modified = ? "
          );
      pst.setInt(++i, this.getModifiedBy());
      pst.setString(++i, this.getDescription());
      pst.setBoolean(++i, this.getEnabled());
      if(linkFeatureId > 0){
         pst.setInt(++i, linkFeatureId);
      }
      if (previousFeature.getComplete() && this.getComplete()) {
        pst.setTimestamp(++i, previousFeature.getCompleteDate());
        pst.setInt(++i, previousFeature.getCompletedBy());
      } else if (this.getComplete() && !previousFeature.getComplete()) {
        pst.setTimestamp(++i, new Timestamp(System.currentTimeMillis()));
        pst.setInt(++i, this.getCompletedBy());
      } else {
        pst.setTimestamp(++i, null);
        pst.setNull(++i, java.sql.Types.SMALLINT);
      }
      pst.setInt(++i, id);
      pst.setTimestamp(++i, this.getModified());
      count = pst.executeUpdate();
      pst.close();
      db.commit();
    } catch (SQLException e) {
      db.rollback();
      throw new SQLException(e.getMessage());
    } finally {
      db.setAutoCommit(true);
    }
    return count;
  }


  /**
   *  Delete a Help Feature
   *
   *@param  db                Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public boolean delete(Connection db) throws SQLException {
    if (this.getId() == -1) {
      throw new SQLException("Feature ID not specified");
    }
    try {
      db.setAutoCommit(false);
      PreparedStatement pst = db.prepareStatement(
          "DELETE from help_features " +
          "WHERE feature_id = ? ");
      pst.setInt(1, this.getId());
      pst.execute();
      pst.close();
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
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void buildRecord(ResultSet rs) throws SQLException {
    id = rs.getInt("feature_id");
    linkHelpId = rs.getInt("link_help_id");
    linkFeatureId = rs.getInt("link_feature_id");
    if (rs.wasNull()) {
      linkFeatureId = -1;
    }
    description = rs.getString("description");
    enteredBy = rs.getInt("enteredby");
    entered = rs.getTimestamp("entered");
    modifiedBy = rs.getInt("modifiedby");
    modified = rs.getTimestamp("modified");
    completeDate = rs.getTimestamp("completedate");
    if (!rs.wasNull()) {
      complete = true;
    }
    completedBy = rs.getInt("completedby");
    enabled = rs.getBoolean("enabled");
  }
}

