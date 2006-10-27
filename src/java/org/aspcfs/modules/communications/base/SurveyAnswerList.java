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

import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.contacts.base.Contact;
import org.aspcfs.utils.web.PagedListInfo;

import javax.servlet.http.HttpServletRequest;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Vector;

/**
 * Contains a list of survey answers for a campaign
 *
 * @author chris price
 * @version $Id: SurveyAnswerList.java,v 1.4 2002/08/27 19:28:31 mrajkowski
 *          Exp $
 * @created August 13, 2002
 */
public class SurveyAnswerList extends Vector {
  public final static String tableName = "active_survey_answers";
  public final static String uniqueField = "answer_id";
  private java.sql.Timestamp lastAnchor = null;
  private java.sql.Timestamp nextAnchor = null;
  private int syncType = Constants.NO_SYNC;

  private int questionId = -1;
  private int hasComments = -1;
  private int responseId = -1;
  private int contactId = -1;
  private boolean lastAnswers = false;
  private int itemsPerPage = 10;
  private HashMap contacts = null;
  protected PagedListInfo pagedListInfo = null;


  /**
   * Constructor for the SurveyAnswerList object
   */
  public SurveyAnswerList() {
  }

  /**
   * Sets the lastAnchor attribute of the SurveyAnswerList object
   *
   * @param tmp The new lastAnchor value
   */
  public void setLastAnchor(java.sql.Timestamp tmp) {
    this.lastAnchor = tmp;
  }


  /**
   * Sets the lastAnchor attribute of the SurveyAnswerList object
   *
   * @param tmp The new lastAnchor value
   */
  public void setLastAnchor(String tmp) {
    this.lastAnchor = java.sql.Timestamp.valueOf(tmp);
  }


  /**
   * Sets the nextAnchor attribute of the SurveyAnswerList object
   *
   * @param tmp The new nextAnchor value
   */
  public void setNextAnchor(java.sql.Timestamp tmp) {
    this.nextAnchor = tmp;
  }


  /**
   * Sets the nextAnchor attribute of the SurveyAnswerList object
   *
   * @param tmp The new nextAnchor value
   */
  public void setNextAnchor(String tmp) {
    this.nextAnchor = java.sql.Timestamp.valueOf(tmp);
  }


  /**
   * Sets the syncType attribute of the SurveyAnswerList object
   *
   * @param tmp The new syncType value
   */
  public void setSyncType(int tmp) {
    this.syncType = tmp;
  }

  /**
   * Gets the tableName attribute of the SurveyAnswerList object
   *
   * @return The tableName value
   */
  public String getTableName() {
    return tableName;
  }


  /**
   * Gets the uniqueField attribute of the SurveyAnswerList object
   *
   * @return The uniqueField value
   */
  public String getUniqueField() {
    return uniqueField;
  }


  /**
   * Constructor for the SurveyAnswerList object
   *
   * @param db         Description of the Parameter
   * @param questionId Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public SurveyAnswerList(Connection db, int questionId) throws SQLException {
    this.questionId = questionId;
    buildList(db);
  }


  /**
   * Constructor for the SurveyAnswerList object
   *
   * @param request Description of the Parameter
   */
  public SurveyAnswerList(HttpServletRequest request) {
    int i = 0;
    while (request.getParameter("quest" + (++i) + "id") != null) {
      SurveyAnswer thisAnswer = new SurveyAnswer();
      thisAnswer.buildRecord(request, i);
      this.addElement(thisAnswer);
      if (System.getProperty("DEBUG") != null) {
        System.out.println("Added an answer: " + thisAnswer.getQuestionId());
      }
    }
  }


  /**
   * Gets the questionId attribute of the SurveyAnswerList object
   *
   * @return The questionId value
   */
  public int getQuestionId() {
    return questionId;
  }


  /**
   * Sets the questionId attribute of the SurveyAnswerList object
   *
   * @param questionId The new questionId value
   */
  public void setQuestionId(int questionId) {
    this.questionId = questionId;
  }


  /**
   * Sets the pagedListInfo attribute of the SurveyAnswerList object
   *
   * @param tmp The new pagedListInfo value
   */
  public void setPagedListInfo(PagedListInfo tmp) {
    this.pagedListInfo = tmp;
  }


  /**
   * Sets the hasComments attribute of the SurveyAnswerList object
   *
   * @param tmp The new hasComments value
   */
  public void setHasComments(int tmp) {
    this.hasComments = tmp;
  }


  /**
   * Set if Most recently entered survey answers are needed
   *
   * @param lastAnswers The new lastAnswers value
   */
  public void setLastAnswers(boolean lastAnswers) {
    this.lastAnswers = lastAnswers;
  }


  /**
   * Sets the itemsPerPage attribute of the SurveyAnswerList object
   *
   * @param itemsPerPage The new itemsPerPage value
   */
  public void setItemsPerPage(int itemsPerPage) {
    this.itemsPerPage = itemsPerPage;
  }


  /**
   * Contacts HashMap for storing Contact Id and Names
   *
   * @param contacts The new contacts value
   */
  public void setContacts(HashMap contacts) {
    this.contacts = contacts;
  }


  /**
   * Sets the responseId attribute of the SurveyAnswerList object
   *
   * @param responseId The new responseId value
   */
  public void setResponseId(int responseId) {
    this.responseId = responseId;
  }


  /**
   * Sets the contactId attribute of the SurveyAnswerList object
   *
   * @param contactId The new contactId value
   */
  public void setContactId(int contactId) {
    this.contactId = contactId;
  }


  /**
   * Gets the contactId attribute of the SurveyAnswerList object
   *
   * @return The contactId value
   */
  public int getContactId() {
    return contactId;
  }


  /**
   * Gets the responseId attribute of the SurveyAnswerList object
   *
   * @return The responseId value
   */
  public int getResponseId() {
    return responseId;
  }


  /**
   * Gets the contacts HashMap
   *
   * @return The contacts value
   */
  public HashMap getContacts() {
    return contacts;
  }


  /**
   * Gets the hasComments attribute of the SurveyAnswerList object
   *
   * @return The hasComments value
   */
  public int getHasComments() {
    return hasComments;
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void buildList(Connection db) throws SQLException {
    PreparedStatement pst = null;

    ResultSet rs = queryList(db, pst);
    if (pagedListInfo != null) {
      pagedListInfo.doManualOffset(db, rs);
    }
    while (rs.next()) {
      SurveyAnswer thisAnswer = new SurveyAnswer(rs);
      this.add(thisAnswer);
      if (contacts == null) {
        contacts = new HashMap();
      }
      String contactName = Contact.getNameLastFirst(
          rs.getString("lastname"), rs.getString("firstname"));
      contacts.put(new Integer(rs.getInt("contactid")), contactName);
    }
    rs.close();
    if (pst != null) {
      pst.close();
    }

    Iterator ans = this.iterator();
    while (ans.hasNext()) {
      SurveyAnswer thisAnswer = (SurveyAnswer) ans.next();
      thisAnswer.setContactId(db);
      thisAnswer.buildItems(db, thisAnswer.getId());
    }
  }


  /**
   * Returns SQL ResultSet after executing the query
   *
   * @param db  Description of the Parameter
   * @param pst Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public ResultSet queryList(Connection db, PreparedStatement pst) throws SQLException {

    ResultSet rs = null;
    int items = -1;
    StringBuffer sqlSelect = new StringBuffer();
    StringBuffer sqlCount = new StringBuffer();
    StringBuffer sqlFilter = new StringBuffer();
    StringBuffer sqlOrder = new StringBuffer();

    //Need to build a base SQL statement for counting records
    sqlCount.append(
        "SELECT COUNT(*) AS recordcount " +
            "FROM active_survey_answers sa, active_survey_responses sr " +
            "WHERE sa.question_id > -1 AND sa.response_id = sr.response_id ");

    createFilter(sqlFilter);

    if (pagedListInfo == null && lastAnswers) {
      pagedListInfo = new PagedListInfo();
      pagedListInfo.setItemsPerPage(itemsPerPage);
    }

    if (pagedListInfo != null) {
      //Get the total number of records matching filter
      pst = db.prepareStatement(sqlCount.toString() + sqlFilter.toString());
      items = prepareFilter(pst);
      if (pagedListInfo != null) {
        pagedListInfo.doManualOffset(db, pst);
      }
      rs = pst.executeQuery();
      if (rs.next()) {
        int maxRecords = rs.getInt("recordcount");
        pagedListInfo.setMaxRecords(maxRecords);
      }
      rs.close();
      pst.close();

      //Determine the offset, based on the filter, for the first record to show
      if (!pagedListInfo.getCurrentLetter().equals("")) {
        pst = db.prepareStatement(
            sqlCount.toString() +
                sqlFilter.toString() +
                "AND sa.comments < ? ");
        items = prepareFilter(pst);
        pst.setString(++items, pagedListInfo.getCurrentLetter().toLowerCase());
        if (pagedListInfo != null) {
          pagedListInfo.doManualOffset(db, pst);
        }
        rs = pst.executeQuery();
        if (rs.next()) {
          int offsetCount = rs.getInt("recordcount");
          pagedListInfo.setCurrentOffset(offsetCount);
        }
        rs.close();
        pst.close();
      }

      //Determine column to sort by
      pagedListInfo.setDefaultSort("sr.entered DESC", null);
      pagedListInfo.appendSqlTail(db, sqlOrder);
    } else {
      sqlOrder.append("ORDER BY sa.response_id, sa.question_id ");
    }

    //Need to build a base SQL statement for returning records
    if (pagedListInfo != null) {
      pagedListInfo.appendSqlSelectHead(db, sqlSelect);
    } else {
      sqlSelect.append("SELECT ");
    }
    sqlSelect.append(
        "sa.*, c.namelast as lastname, c.namefirst as firstname, " +
            "c.contact_id as contactid, sr.entered as entered " +
            "FROM active_survey_answers sa, active_survey_responses sr " +
            "LEFT JOIN contact c ON (c.contact_id = sr.contact_id) " +
            "WHERE sa.question_id > -1 AND sa.response_id = sr.response_id ");
    pst = db.prepareStatement(
        sqlSelect.toString() + sqlFilter.toString() + sqlOrder.toString());
    items = prepareFilter(pst);
    if (pagedListInfo != null) {
      pagedListInfo.doManualOffset(db, pst);
    }
    rs = pst.executeQuery();
    return rs;
  }


  /**
   * Description of the Method
   *
   * @param sqlFilter Description of the Parameter
   */
  protected void createFilter(StringBuffer sqlFilter) {
    if (sqlFilter == null) {
      sqlFilter = new StringBuffer();
    }

    if (questionId != -1) {
      sqlFilter.append("AND sa.question_id = ? ");
    }

    if (responseId != -1) {
      sqlFilter.append("AND sr.response_id = ? ");
    }

    if (contactId != -1) {
      sqlFilter.append("AND sr.contact_id = ? ");
    }

    if (hasComments > -1) {
      if (hasComments == Constants.TRUE) {
        sqlFilter.append("AND sa.comments NOT LIKE '' ");
      } else {
        sqlFilter.append("AND sa.comments LIKE '' ");
      }
    }
    if (syncType == Constants.SYNC_INSERTS) {
      if (lastAnchor != null) {
        sqlFilter.append("AND o.entered > ? ");
      }
      sqlFilter.append("AND o.entered < ? ");
    }
    if (syncType == Constants.SYNC_UPDATES) {
      sqlFilter.append("AND o.modified > ? ");
      sqlFilter.append("AND o.entered < ? ");
      sqlFilter.append("AND o.modified < ? ");
    }
  }


  /**
   * Description of the Method
   *
   * @param pst Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  protected int prepareFilter(PreparedStatement pst) throws SQLException {
    int i = 0;

    if (questionId != -1) {
      pst.setInt(++i, questionId);
    }

    if (responseId != -1) {
      pst.setInt(++i, responseId);
    }

    if (contactId != -1) {
      pst.setInt(++i, contactId);
    }
    if (syncType == Constants.SYNC_INSERTS) {
      if (lastAnchor != null) {
        pst.setTimestamp(++i, lastAnchor);
      }
      pst.setTimestamp(++i, nextAnchor);
    }
    if (syncType == Constants.SYNC_UPDATES) {
      pst.setTimestamp(++i, lastAnchor);
      pst.setTimestamp(++i, lastAnchor);
      pst.setTimestamp(++i, nextAnchor);
    }
    return i;
  }


  /**
   * Description of the Method
   *
   * @param db         Description of the Parameter
   * @param responseId Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public boolean insert(Connection db, int responseId) throws SQLException {
    Iterator ans = this.iterator();
    while (ans.hasNext()) {
      SurveyAnswer thisAnswer = (SurveyAnswer) ans.next();
      thisAnswer.insert(db, responseId);
    }
    return true;
  }
}

