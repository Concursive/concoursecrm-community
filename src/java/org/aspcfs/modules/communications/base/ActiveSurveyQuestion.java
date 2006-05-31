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

import org.aspcfs.utils.DatabaseUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;

/**
 * Description of the Class
 *
 * @author
 * @version $Id: ActiveSurveyQuestion.java,v 1.4 2002/11/25 00:34:20 akhi_m
 *          Exp $
 * @created November 1, 2002
 */
public class ActiveSurveyQuestion {
  private int id = -1;
  private String description = null;
  private int activeSurveyId = -1;
  private int type = -1;
  private int position = 0;
  private double average = 0.0;
  private boolean required = false;
  private ActiveSurveyQuestionItemList itemList = null;
  private SurveyAnswerList answerList = null;
  private ArrayList responseTotals = new ArrayList();
  LinkedHashMap comments = null;


  /**
   * Constructor for the ActiveSurveyQuestion object
   */
  public ActiveSurveyQuestion() {
  }


  /**
   * Constructor for the ActiveSurveyQuestion object
   *
   * @param question Description of the Parameter
   */
  public ActiveSurveyQuestion(SurveyQuestion question) {
    this.description = question.getDescription();
    this.type = question.getType();
    this.required = question.getRequired();
    this.position = question.getPosition();
    this.itemList = new ActiveSurveyQuestionItemList(question.getItemList());
  }


  /**
   * Constructor for the ActiveSurveyQuestion object
   *
   * @param rs Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public ActiveSurveyQuestion(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }


  /**
   * Gets the id attribute of the ActiveSurveyQuestion object
   *
   * @return The id value
   */
  public int getId() {
    return id;
  }


  /**
   * Gets the description attribute of the ActiveSurveyQuestion object
   *
   * @return The description value
   */
  public String getDescription() {
    return description;
  }


  /**
   * Sets the comments attribute of the ActiveSurveyQuestion object
   *
   * @param comments The new comments value
   */
  public void setComments(LinkedHashMap comments) {
    this.comments = comments;
  }


  /**
   * Gets the comments attribute of the ActiveSurveyQuestion object
   *
   * @return The comments value
   */
  public LinkedHashMap getComments() {
    return comments;
  }


  /**
   * Sets the id attribute of the ActiveSurveyQuestion object
   *
   * @param tmp The new id value
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   * Sets the id attribute of the ActiveSurveyQuestion object
   *
   * @param tmp The new id value
   */
  public void setId(String tmp) {
    this.id = Integer.parseInt(tmp);
  }


  /**
   * Sets the description attribute of the ActiveSurveyQuestion object
   *
   * @param tmp The new description value
   */
  public void setDescription(String tmp) {
    this.description = tmp;
  }


  /**
   * Sets the activeSurveyId attribute of the ActiveSurveyQuestion object
   *
   * @param tmp The new activeSurveyId value
   */
  public void setActiveSurveyId(int tmp) {
    this.activeSurveyId = tmp;
  }


  /**
   * Sets the type attribute of the ActiveSurveyQuestion object
   *
   * @param tmp The new type value
   */
  public void setType(int tmp) {
    this.type = tmp;
  }


  /**
   * Sets the required attribute of the ActiveSurveyQuestion object
   *
   * @param required The new required value
   */
  public void setRequired(boolean required) {
    this.required = required;
  }


  /**
   * Sets the itemList attribute of the ActiveSurveyQuestion object
   *
   * @param itemList The new itemList value
   */
  public void setItemList(ActiveSurveyQuestionItemList itemList) {
    this.itemList = itemList;
  }


  /**
   * Sets the answerList attribute of the ActiveSurveyQuestion object
   *
   * @param answerList The new answerList value
   */
  public void setAnswerList(SurveyAnswerList answerList) {
    this.answerList = answerList;
  }


  /**
   * Gets the answerList attribute of the ActiveSurveyQuestion object
   *
   * @return The answerList value
   */
  public SurveyAnswerList getAnswerList() {
    return answerList;
  }


  /**
   * Gets the itemList attribute of the ActiveSurveyQuestion object
   *
   * @return The itemList value
   */
  public ActiveSurveyQuestionItemList getItemList() {
    return itemList;
  }


  /**
   * Gets the required attribute of the ActiveSurveyQuestion object
   *
   * @return The required value
   */
  public boolean getRequired() {
    return required;
  }


  /**
   * Gets the activeSurveyId attribute of the ActiveSurveyQuestion object
   *
   * @return The activeSurveyId value
   */
  public int getActiveSurveyId() {
    return activeSurveyId;
  }


  /**
   * Gets the type attribute of the ActiveSurveyQuestion object
   *
   * @return The type value
   */
  public int getType() {
    return type;
  }


  /**
   * Gets the typeString attribute of the ActiveSurveyQuestion object
   *
   * @return The typeString value
   */
  public String getTypeString() {
    if (type == SurveyQuestion.OPEN_ENDED) {
      return "Open Ended";
    } else if (type == SurveyQuestion.QUANT_NOCOMMENTS) {
      return "Quantitative";
    } else if (type == SurveyQuestion.QUANT_COMMENTS) {
      return "Quantitative with Comments";
    } else if (type == SurveyQuestion.ITEMLIST) {
      return "Item List";
    }
    return "-";
  }


  /**
   * Sets the activeSurveyId attribute of the ActiveSurveyQuestion object
   *
   * @param tmp The new activeSurveyId value
   */
  public void setActiveSurveyId(String tmp) {
    this.activeSurveyId = Integer.parseInt(tmp);
  }


  /**
   * Sets the type attribute of the ActiveSurveyQuestion object
   *
   * @param tmp The new type value
   */
  public void setType(String tmp) {
    this.type = Integer.parseInt(tmp);
  }


  /**
   * Gets the responseTotals attribute of the ActiveSurveyQuestion object
   *
   * @return The responseTotals value
   */
  public ArrayList getResponseTotals() {
    return responseTotals;
  }


  /**
   * Sets the responseTotals attribute of the ActiveSurveyQuestion object
   *
   * @param responseTotals The new responseTotals value
   */
  public void setResponseTotals(ArrayList responseTotals) {
    this.responseTotals = responseTotals;
  }


  /**
   * Gets the average attribute of the ActiveSurveyQuestion object
   *
   * @return The average value
   */
  public double getAverage() {
    return average;
  }


  /**
   * Sets the average attribute of the ActiveSurveyQuestion object
   *
   * @param average The new average value
   */
  public void setAverage(double average) {
    this.average = average;
  }


  /**
   * Sets the position attribute of the ActiveSurveyQuestion object
   *
   * @param position The new position value
   */
  public void setPosition(int position) {
    this.position = position;
  }


  /**
   * Gets the position attribute of the ActiveSurveyQuestion object
   *
   * @return The position value
   */
  public int getPosition() {
    return position;
  }


  /**
   * Gets the averageValue attribute of the ActiveSurveyQuestion object
   *
   * @return The averageValue value
   */
  public String getAverageValue() {
    double value_2dp = (double) Math.round(average * 100.0) / 100.0;
    String toReturn = "" + value_2dp;
    if (toReturn.endsWith(".0")) {
      return (toReturn.substring(0, toReturn.length() - 2));
    } else {
      return toReturn;
    }
  }


  /**
   * Returns a HashMap of Item Objects with count of each selected as values.
   *
   * @param answerList Description of the Parameter
   * @return The itemListResponse value
   */
  public HashMap getItemListResponse(SurveyAnswerList answerList) {
    HashMap itemListResponse = new HashMap();
    Iterator answers = answerList.iterator();
    while (answers.hasNext()) {
      SurveyAnswer thisAnswer = (SurveyAnswer) answers.next();
      if (thisAnswer.getItemList() != null) {
        Iterator itemList = thisAnswer.getItemList().iterator();
        while (itemList.hasNext()) {
          ActiveSurveyQuestionItem thisItem = ((SurveyAnswerItem) itemList.next()).getItem();
          if (itemListResponse.containsKey((Object) thisItem)) {
            Integer count = (Integer) itemListResponse.get((Object) thisItem);
            itemListResponse.remove((Object) thisItem);
            itemListResponse.put(thisItem, new Integer(count.intValue() + 1));
          } else {
            itemListResponse.put(thisItem, new Integer(1));
          }
        }
      }
    }
    return itemListResponse;
  }


  /**
   * Description of the Method
   *
   * @param db             Description of the Parameter
   * @param activeSurveyId Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void insert(Connection db, int activeSurveyId) throws SQLException {
    id = DatabaseUtils.getNextSeq(db, "active_survey_q_question_id_seq");
    PreparedStatement pst = null;
    int i = 0;
    pst = db.prepareStatement(
        "INSERT INTO active_survey_questions " +
        "(" + (id > -1 ? "question_id, " : "") + "active_survey_id, \"type\", description, required, \"position\") " +
        "VALUES " +
        "(" + (id > -1 ? "?, " : "") + "?, ?, ?, ?, ?) ");
    if (id > -1) {
      pst.setInt(++i, id);
    }
    pst.setInt(++i, activeSurveyId);
    pst.setInt(++i, this.getType());
    pst.setString(++i, description);
    pst.setBoolean(++i, required);
    pst.setInt(++i, this.getPosition());
    pst.execute();
    pst.close();
    this.setId(
        DatabaseUtils.getCurrVal(db, "active_survey_q_question_id_seq", id));
    if (this.getType() == SurveyQuestion.ITEMLIST) {
      Iterator y = this.getItemList().iterator();
      while (y.hasNext()) {
        ActiveSurveyQuestionItem thisItem = (ActiveSurveyQuestionItem) y.next();
        thisItem.insert(db, this.getId());
      }
    }
  }


  /**
   * Description of the Method
   *
   * @param db             Description of the Parameter
   * @param activeSurveyId Description of the Parameter
   * @param surveyType     Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void update(Connection db, int activeSurveyId, int surveyType) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "UPDATE active_survey_questions " +
        "SET active_survey_id = ?, \"type\" = ?, description = ?, required = ?, \"position\" = ? " +
        "WHERE question_id = ? ");
    int i = 0;
    pst.setInt(++i, activeSurveyId);
    pst.setInt(++i, surveyType);
    pst.setString(++i, description);
    pst.setBoolean(++i, required);
    pst.setInt(++i, position);
    pst.setInt(++i, this.getId());
    pst.execute();
    pst.close();
    if (this.getType() == SurveyQuestion.ITEMLIST) {
      if (ActiveSurveyQuestionItemList.delete(db, this.getId())) {
        Iterator y = this.getItemList().iterator();
        while (y.hasNext()) {
          ActiveSurveyQuestionItem thisItem = (ActiveSurveyQuestionItem) y.next();
          thisItem.insert(db, this.getId());
        }
      }
    }
  }


  /**
   * Description of the Method
   *
   * @param rs Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  protected void buildRecord(ResultSet rs) throws SQLException {
    id = rs.getInt("question_id");
    activeSurveyId = rs.getInt("active_survey_id");
    type = rs.getInt("type");
    description = rs.getString("description");
    required = rs.getBoolean("required");
    position = rs.getInt("position");
    average = rs.getDouble("average");
    responseTotals.add(0, new Integer(rs.getInt("total1")));
    responseTotals.add(1, new Integer(rs.getInt("total2")));
    responseTotals.add(2, new Integer(rs.getInt("total3")));
    responseTotals.add(3, new Integer(rs.getInt("total4")));
    responseTotals.add(4, new Integer(rs.getInt("total5")));
    responseTotals.add(5, new Integer(rs.getInt("total6")));
    responseTotals.add(6, new Integer(rs.getInt("total7")));
  }

}

