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
package org.aspcfs.modules.communications.base;

import java.sql.*;
import org.aspcfs.utils.DatabaseUtils;
import java.util.ArrayList;

/**
 *  Description of the Class
 *
 *@author     akhi_m
 *@created    October 18, 2002
 *@version    $Id$
 */
public class Item {
  private int id = -1;
  private String description = null;
  private int questionId = -1;
  private int type = -1;


  /**
   *  Constructor for the Item object
   */
  public Item() { }


  /**
   *  Constructor for the Item object
   *
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public Item(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }


  /**
   *  Gets the id attribute of the Item object
   *
   *@return    The id value
   */
  public int getId() {
    return id;
  }


  /**
   *  Gets the description attribute of the Item object
   *
   *@return    The description value
   */
  public String getDescription() {
    return description;
  }


  /**
   *  Sets the id attribute of the Item object
   *
   *@param  tmp  The new id value
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   *  Sets the id attribute of the Item object
   *
   *@param  tmp  The new id value
   */
  public void setId(String tmp) {
    this.id = Integer.parseInt(tmp);
  }


  /**
   *  Sets the description attribute of the Item object
   *
   *@param  tmp  The new description value
   */
  public void setDescription(String tmp) {
    this.description = tmp;
  }


  /**
   *  Sets the questionId attribute of the Item object
   *
   *@param  tmp  The new questionId value
   */
  public void setQuestionId(int tmp) {
    this.questionId = tmp;
  }



  /**
   *  Sets the type attribute of the Item object
   *
   *@param  tmp  The new type value
   */
  public void setType(int tmp) {
    this.type = tmp;
  }


  /**
   *  Gets the questionId attribute of the Item object
   *
   *@return    The questionId value
   */
  public int getQuestionId() {
    return questionId;
  }


  /**
   *  Gets the type attribute of the Item object
   *
   *@return    The type value
   */
  public int getType() {
    return type;
  }


  /**
   *  Sets the questionId attribute of the Item object
   *
   *@param  tmp  The new questionId value
   */
  public void setQuestionId(String tmp) {
    this.questionId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the type attribute of the Item object
   *
   *@param  tmp  The new type value
   */
  public void setType(String tmp) {
    this.type = Integer.parseInt(tmp);
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  qid               Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void insert(Connection db, int qid) throws SQLException {
    try {
      db.setAutoCommit(false);
      PreparedStatement pst = db.prepareStatement(
          "INSERT INTO survey_items " +
          "(question_id, type, description ) " +
          "VALUES (?, ?, ?) ");
      int i = 0;
      pst.setInt(++i, qid);
      pst.setInt(++i, this.getType());
      pst.setString(++i, this.getDescription());
      pst.execute();
      pst.close();

      this.setId(DatabaseUtils.getCurrVal(db, "survey_items_item_id_seq"));
      db.commit();
    } catch (SQLException e) {
      db.rollback();
      throw new SQLException(e.getMessage());
    } finally {
      db.setAutoCommit(true);
    }
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  qId               Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public int update(Connection db, int qId) throws SQLException {
    int count = 0;
    try {
      db.setAutoCommit(false);
      PreparedStatement pst = db.prepareStatement(
          "UPDATE survey_items " +
          "SET description = ? " +
          "WHERE question_id = ? ");
      int i = 0;
      pst.setString(++i, description);
      pst.setInt(++i, qId);
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
   *  Description of the Method
   *
   *@param  rs                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  protected void buildRecord(ResultSet rs) throws SQLException {
    id = rs.getInt("item_id");
    questionId = rs.getInt("question_id");
    type = rs.getInt("type");
    description = rs.getString("description");
  }

}

