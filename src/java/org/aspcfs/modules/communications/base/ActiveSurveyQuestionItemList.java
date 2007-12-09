/*
 *  Copyright(c) 2004 Concursive Corporation (http://www.concursive.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Concursive Corporation. Permission to use, copy, and modify
 *  this material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. CONCURSIVE
 *  CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL CONCURSIVE CORPORATION OR ANY OF ITS AFFILIATES BE LIABLE FOR
 *  ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package org.aspcfs.modules.communications.base;

import org.aspcfs.modules.base.Constants;
import org.aspcfs.utils.DatabaseUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

/**
 * Maintains an Array of Items for a Active Survey Question.
 *
 * @author akhi_m
 * @version $Id: ActiveSurveyQuestionItemList.java,v 1.4 2003/01/14 16:11:33
 *          akhi_m Exp $
 * @created November 1, 2002
 */
public class ActiveSurveyQuestionItemList extends ArrayList {
  public final static String tableName = "active_survey_items";
  public final static String uniqueField = "item_id";
  private java.sql.Timestamp lastAnchor = null;
  private java.sql.Timestamp nextAnchor = null;
  private int syncType = Constants.NO_SYNC;

  private int questionId = -1;


  /**
   * Constructor for the ItemList object
   */
  public ActiveSurveyQuestionItemList() {
  }


  /**
   * Builds ActiveSurveyItemList from a ItemList object (copy)
   *
   * @param items Description of the Parameter
   */
  public ActiveSurveyQuestionItemList(ItemList items) {
    if (items != null) {
      Iterator thisList = items.iterator();
      while (thisList.hasNext()) {
        Item inactiveItem = (Item) thisList.next();
        ActiveSurveyQuestionItem thisItem = new ActiveSurveyQuestionItem(
            inactiveItem);
        this.add(thisItem);
      }
    }
  }

  /**
   * Sets the lastAnchor attribute of the ActiveSurveyQuestionItemList object
   *
   * @param tmp The new lastAnchor value
   */
  public void setLastAnchor(java.sql.Timestamp tmp) {
    this.lastAnchor = tmp;
  }


  /**
   * Sets the lastAnchor attribute of the ActiveSurveyQuestionItemList object
   *
   * @param tmp The new lastAnchor value
   */
  public void setLastAnchor(String tmp) {
    this.lastAnchor = java.sql.Timestamp.valueOf(tmp);
  }


  /**
   * Sets the nextAnchor attribute of the ActiveSurveyQuestionItemList object
   *
   * @param tmp The new nextAnchor value
   */
  public void setNextAnchor(java.sql.Timestamp tmp) {
    this.nextAnchor = tmp;
  }


  /**
   * Sets the nextAnchor attribute of the ActiveSurveyQuestionItemList object
   *
   * @param tmp The new nextAnchor value
   */
  public void setNextAnchor(String tmp) {
    this.nextAnchor = java.sql.Timestamp.valueOf(tmp);
  }


  /**
   * Sets the syncType attribute of the ActiveSurveyQuestionItemList object
   *
   * @param tmp The new syncType value
   */
  public void setSyncType(int tmp) {
    this.syncType = tmp;
  }

  /**
   * Gets the tableName attribute of the ActiveSurveyQuestionItemList object
   *
   * @return The tableName value
   */
  public String getTableName() {
    return tableName;
  }


  /**
   * Gets the uniqueField attribute of the ActiveSurveyQuestionItemList object
   *
   * @return The uniqueField value
   */
  public String getUniqueField() {
    return uniqueField;
  }


  /**
   * Gets the questionId attribute of the ActiveSurveyQuestionItemList object
   *
   * @return The questionId value
   */
  public int getQuestionId() {
    return questionId;
  }


  /**
   * Gets the object attribute of the ActiveSurveyQuestionItemList object
   *
   * @param rs Description of the Parameter
   * @return The object value
   * @throws SQLException Description of the Exception
   */
  public ActiveSurveyQuestionItem getObject(ResultSet rs) throws SQLException {
    ActiveSurveyQuestionItem thisItem = new ActiveSurveyQuestionItem(rs);
    return thisItem;
  }


  /**
   * Sets the questionId attribute of the ActiveSurveyQuestionItemList object
   *
   * @param questionId The new questionId value
   */
  public void setQuestionId(int questionId) {
    this.questionId = questionId;
  }


  /**
   * Sets the questionId attribute of the ActiveSurveyQuestionItemList object
   *
   * @param questionId The new questionId value
   */
  public void setQuestionId(String questionId) {
    this.questionId = Integer.parseInt(questionId);
  }


  /**
   * Gets the question attribute of the ActiveSurveyQuestionItemList object
   *
   * @param itemId Description of the Parameter
   * @return The question value
   */
  public ActiveSurveyQuestionItem getItem(int itemId) {
    Iterator thisList = this.iterator();
    ActiveSurveyQuestionItem item = null;
    while (thisList.hasNext()) {
      ActiveSurveyQuestionItem thisItem = (ActiveSurveyQuestionItem) thisList.next();
      if (thisItem.getId() == itemId) {
        item = thisItem;
      }
    }
    return item;
  }


  /**
   * Description of the Method
   *
   * @param db         Description of the Parameter
   * @param questionId Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public boolean updateResponse(Connection db, int questionId) throws SQLException {
    PreparedStatement pst = null;
    ResultSet rs = null;
    try {
      pst = db.prepareStatement(
          "SELECT item_id,total " +
              "FROM active_survey_answer_avg " +
              "WHERE question_id = ? ");
      int i = 0;
      pst.setInt(++i, questionId);
      rs = pst.executeQuery();
      while (rs.next()) {
        ActiveSurveyQuestionItem thisItem = getItem(rs.getInt("item_id"));
        if (thisItem != null) {
          thisItem.setTotalResponse(rs.getInt("total"));
        }
      }
      rs.close();
      pst.close();
    } catch (SQLException e) {
      throw new SQLException(e.toString());
    }
    return true;
  }


  /**
   * Delete all Items for a Active Survey Question
   *
   * @param db         Description of the Parameter
   * @param questionId Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public static boolean delete(Connection db, int questionId) throws SQLException {
    boolean commit = true;
    try {
      commit = db.getAutoCommit();
      if (commit) {
        db.setAutoCommit(false);
      }
      PreparedStatement pst = db.prepareStatement(
          "DELETE FROM active_survey_items WHERE question_id = ?");
      pst.setInt(1, questionId);
      pst.execute();
      pst.close();
      if (commit) {
        db.commit();
      }
    } catch (SQLException e) {
      if (commit) {
        db.rollback();
      }
      throw new SQLException(e.toString());
    } finally {
      if (commit) {
        db.setAutoCommit(true);
      }
    }
    return true;
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void buildList(Connection db) throws SQLException {
    PreparedStatement pst = prepareList(db);
    ResultSet rs = DatabaseUtils.executeQuery(db, pst);
    while (rs.next()) {
      ActiveSurveyQuestionItem thisItem = this.getObject(rs);
      this.add(thisItem);
    }
    rs.close();
    if (pst != null) {
      pst.close();
    }
  }


  /**
   * Description of the Method
   *
   * @param db  Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public PreparedStatement prepareList(Connection db) throws SQLException {
    String sql =
        "SELECT sq.* " +
            "FROM active_survey_items sq " +
            (questionId > -1 ? "WHERE question_id = ? " : "");
    PreparedStatement pst = db.prepareStatement(sql);
    int i = 0;
    if (questionId > -1) {
      pst.setInt(++i, questionId);
    }

    return pst;
  }
}

