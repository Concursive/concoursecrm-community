//Copyright 2002 Dark Horse Ventures

package com.darkhorseventures.cfsbase;

import org.theseus.actions.*;
import org.theseus.beans.*;
import java.util.*;
import java.sql.*;
import java.text.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.darkhorseventures.utils.DatabaseUtils;

public class SurveyResponse {

  protected int id = -1;
  private int activeSurveyId = -1;
  private int contactId = -1;
  private String uniqueCode = null;
  private String ipAddress = null;
  private java.sql.Timestamp entered = null;
  private SurveyAnswerList answers = new SurveyAnswerList();
  
  public SurveyResponse() { }
  
  public SurveyResponse(ActionContext context) {
    //this.setActiveSurveyId(Integer.parseInt(context.getRequest().getParameter("id")));
    //this.setContactId(-1);
    this.setIpAddress(context.getIpAddress());
    answers = new SurveyAnswerList(context.getRequest());
  }
  
  public void setId(int tmp) { this.id = tmp; }
  public void setActiveSurveyId(int tmp) { this.activeSurveyId = tmp; }
  public void setContactId(int tmp) { this.contactId = tmp; }
  public void setUniqueCode(String tmp) { this.uniqueCode = tmp; }
  public void setIpAddress(String tmp) { this.ipAddress = tmp; }
  public void setEntered(java.sql.Timestamp tmp) { this.entered = tmp; }
  public void setAnswers(SurveyAnswerList tmp) { this.answers = tmp; }
  
  public int getId() { return id; }
  public int getActiveSurveyId() { return activeSurveyId; }
  public int getContactId() { return contactId; }
  public String getUniqueCode() { return uniqueCode; }
  public String getIpAddress() { return ipAddress; }
  public java.sql.Timestamp getEntered() { return entered; }
  public String getEnteredString() {
    try {
      return DateFormat.getDateInstance(DateFormat.SHORT).format(entered);
    } catch (NullPointerException e) {
    }
    return ("");
  }
  public String getEnteredDateTimeString() {
    try {
      return DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.SHORT).format(entered);
    } catch (NullPointerException e) {
    }
    return ("");
  }
  
  public SurveyAnswerList getAnswers() { return answers; }

  public boolean insert(Connection db) throws SQLException {
    try {
      db.setAutoCommit(false);
      String sql = 
        "INSERT INTO active_survey_responses " +
        "(active_survey_id, contact_id, unique_code, ip_address) VALUES (?, ?, ?, ?) ";
      PreparedStatement pst = db.prepareStatement(sql);
      pst.setInt(1, activeSurveyId);
      pst.setInt(2, contactId);
      pst.setString(3, uniqueCode);
      pst.setString(4, ipAddress);
      pst.execute();
      pst.close();
      
      id = DatabaseUtils.getCurrVal(db, "active_survey_r_response_id_seq");
      answers.insert(db, id);
        
      db.commit();
    } catch (SQLException e) {
      db.rollback();
      throw new SQLException(e.getMessage());
    } finally {
      db.setAutoCommit(true);
    }
    return true;
  }
}

