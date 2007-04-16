/*
 *  Copyright(c) 2007 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
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
package org.aspcfs.modules.website.base;

import com.darkhorseventures.framework.beans.GenericBean;
import org.apache.log4j.Level;
import org.apache.log4j.Logger;
import org.aspcfs.utils.DatabaseUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Description of the IceletPublicWebsite
 *
 * @author Artem.Zakolodkin
 * @created Feb 2, 2007
 */
public class IceletPublicWebsite extends GenericBean {

  /**
   * 
   */
  private static final long serialVersionUID = 1L;
  
  private int id = -1;
  private int iceletId = -1;
  private int enteredBy = -1;
  private java.sql.Timestamp entered = null;
  private int modifiedBy = -1;
  private java.sql.Timestamp modified = null;
  private boolean override = false;

  /**
   * Logger.
   */
  private static final Logger LOGGER = Logger
          .getLogger(IceletPublicWebsite.class.getName());
  static {
      if (System.getProperty("DEBUG") != null) {
          LOGGER.setLevel(Level.DEBUG);
      }
  }

  public IceletPublicWebsite() {
    
  }
  
  /**
   * @param rs
   * @throws SQLException
   */
  public IceletPublicWebsite(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }
  
  public void buildRecord(ResultSet rs) throws SQLException {
    id = rs.getInt("icelet_publicwebsite_id");
    iceletId = rs.getInt("icelet_id");
    entered = rs.getTimestamp("entered");
    enteredBy = rs.getInt("enteredby");
    modified = rs.getTimestamp("modified");
    modifiedBy = rs.getInt("modifiedby");
  }

  public boolean update(Connection db) throws SQLException {
    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();
    try {
        sql.append( "UPDATE web_icelet_publicwebsite " + 
                    "   SET " + 
                    "      icelet_id = ? ");
        if (!override) {
            sql.append(" , modified = "
                    + DatabaseUtils.getCurrentTimestamp(db)
                    + " , modifiedby = ? ");
        }
        sql.append("WHERE map_id = ? ");
        if (!override) {
            sql.append("AND modified "
                    + ((this.getModified() == null) ? "IS NULL " : "= ? "));
        }
        pst = db.prepareStatement(sql.toString());
        int i = 0;
        pst.setInt(++i, iceletId);
        if (!override) {
            pst.setInt(++i, modifiedBy);
        }
        pst.setInt(++i, id);
        if (!override && this.getModified() != null) {
            pst.setTimestamp(++i, modified);
        }
        id = DatabaseUtils.getCurrVal(db, "web_icelet_publicwebsite_icelet_publicwebsite_id_seq", id);
        pst.close();
    } catch (Exception e) {
        LOGGER.error(e, e);
        throw new SQLException(e.getMessage());
    }
    return true;

  }

  public boolean delete(Connection db) throws SQLException {
    boolean commit = db.getAutoCommit();
    try {
        if (commit) {
            db.setAutoCommit(false);
        }
        PreparedStatement pst = db
                .prepareStatement("DELETE FROM web_icelet_publicwebsite WHERE icelet_publicwebsite_id = ?");
        pst.setInt(1, id);
        pst.execute();
        pst.close();
        if (commit) {
            db.commit();
        }
    } catch (SQLException e) {
        if (commit) {
            db.rollback();
        }
        LOGGER.error(e, e);
        throw new SQLException(e.getMessage());
    } finally {
        if (commit) {
            db.setAutoCommit(true);
        }
    }
    return true;

  }

  public boolean insert(Connection db) throws SQLException {
    try {
    	id = DatabaseUtils.getNextSeq(db, "web_icelet_publicwebsite_icelet_publicwebsite_id_seq");
    	PreparedStatement pst = db
              .prepareStatement( "INSERT INTO web_icelet_publicwebsite " + 
              									 "(" + (id > -1 ? "icelet_publicwebsite_id, " : "") + 
                                 "    icelet_id, " + 
                                 "    enteredby, " + 
                                 "    modifiedby ) " + 
                                 " VALUES (" + (id > -1 ? "?," : "") + "?,?,?)");
      int i = 0;
      if (id > -1) {
      	pst.setInt(++i, id);
      }
      pst.setInt(++i, iceletId);
      pst.setInt(++i, enteredBy);
      pst.setInt(++i, modifiedBy);
      pst.execute();
      id = DatabaseUtils.getCurrVal(db, "web_icelet_publicwebsite_icelet_publicwebsite_id_seq", id);
      pst.close();
  } catch (Exception e) {
      LOGGER.error(e, e);
      throw new SQLException(e.getMessage());
  }
  return true;

  }

  /**
   * @return the entered
   */
  public java.sql.Timestamp getEntered() {
    return entered;
  }
  /**
   * @param entered the entered to set
   */
  public void setEntered(java.sql.Timestamp entered) {
    this.entered = entered;
  }
  /**
   * @return the enteredBy
   */
  public int getEnteredBy() {
    return enteredBy;
  }
  /**
   * @param enteredBy the enteredBy to set
   */
  public void setEnteredBy(int enteredBy) {
    this.enteredBy = enteredBy;
  }
  /**
   * @return the modified
   */
  public java.sql.Timestamp getModified() {
    return modified;
  }
  /**
   * @param modified the modified to set
   */
  public void setModified(java.sql.Timestamp modified) {
    this.modified = modified;
  }
  /**
   * @return the modifiedBy
   */
  public int getModifiedBy() {
    return modifiedBy;
  }
  /**
   * @param modifiedBy the modifiedBy to set
   */
  public void setModifiedBy(int modifiedBy) {
    this.modifiedBy = modifiedBy;
  }
  /**
   * @return the override
   */
  public boolean isOverride() {
    return override;
  }
  /**
   * @param override the override to set
   */
  public void setOverride(boolean override) {
    this.override = override;
  }
  /**
   * @return the iceletId
   */
  public int getIceletId() {
    return iceletId;
  }
  /**
   * @param iceletId the iceletId to set
   */
  public void setIceletId(int iceletId) {
    this.iceletId = iceletId;
  }
  /**
   * @return the Id
   */
  public int getId() {
    return id;
  }
  /**
   * @param id the iceletPublicWebsite_id to set
   */
  public void setId(int id) {
    this.id = id;
  }

}
