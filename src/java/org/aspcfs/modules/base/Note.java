//Copyright 2001 Dark Horse Ventures

package org.aspcfs.modules.base;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.darkhorseventures.framework.beans.*;
import java.util.*;
import java.text.*;

/**
 *  Represents a note
 *
 *@author     chris
 *@created    September 6, 2001
 *@version    $Id$
 */
public class Note extends GenericBean {

  protected boolean isContact = false;
  protected boolean isOrg = false;
  protected boolean isOpp = true;

  private int id = -1;
  private int orgId = -1;
  private int contactId = -1;
  private int oppId = -1;
  private String dateEntered = null;
  private String body = "";
  private String subject = "";
  private int enteredBy = -1;
  private int modifiedBy = -1;
  private boolean enabled = true;


  /**
   *  Sets the Subject attribute of the Note object
   *
   *@param  subject  The new Subject value
   */
  public void setSubject(String subject) {
    this.subject = subject;
  }


  /**
   *  Sets the Id attribute of the Note object
   *
   *@param  tmp  The new Id value
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   *  Sets the Id attribute of the Note object
   *
   *@param  tmp  The new Id value
   */
  public void setId(String tmp) {
    this.id = Integer.parseInt(tmp);
  }


  /**
   *  Sets the IsContact attribute of the Note object
   *
   *@param  tmp  The new IsContact value
   */
  public void setIsContact(boolean tmp) {
    this.isContact = tmp;
  }


  /**
   *  Sets the IsOrg attribute of the Note object
   *
   *@param  tmp  The new IsOrg value
   */
  public void setIsOrg(boolean tmp) {
    this.isOrg = tmp;
  }


  /**
   *  Sets the IsOpp attribute of the Note object
   *
   *@param  tmp  The new IsOpp value
   */
  public void setIsOpp(boolean tmp) {
    this.isOpp = tmp;
  }


  /**
   *  Sets the OrgId attribute of the Note object
   *
   *@param  tmp  The new OrgId value
   */
  public void setOrgId(int tmp) {
    this.orgId = tmp;
  }


  /**
   *  Sets the ContactId attribute of the Note object
   *
   *@param  tmp  The new ContactId value
   */
  public void setContactId(int tmp) {
    this.contactId = tmp;
  }


  /**
   *  Sets the OppId attribute of the Note object
   *
   *@param  tmp  The new OppId value
   */
  public void setOppId(int tmp) {
    this.oppId = tmp;
  }


  /**
   *  Sets the DateEntered attribute of the Note object
   *
   *@param  tmp  The new DateEntered value
   */
  public void setDateEntered(String tmp) {
    this.dateEntered = tmp;
  }


  /**
   *  Sets the Body attribute of the Note object
   *
   *@param  tmp  The new Body value
   */
  public void setBody(String tmp) {
    this.body = tmp;
  }


  /**
   *  Sets the EnteredBy attribute of the Note object
   *
   *@param  tmp  The new EnteredBy value
   */
  public void setEnteredBy(int tmp) {
    this.enteredBy = tmp;
  }


  /**
   *  Sets the ModifiedBy attribute of the Note object
   *
   *@param  tmp  The new ModifiedBy value
   */
  public void setModifiedBy(int tmp) {
    this.modifiedBy = tmp;
  }


  /**
   *  Sets the Enabled attribute of the Note object
   *
   *@param  tmp  The new Enabled value
   */
  public void setEnabled(boolean tmp) {
    this.enabled = tmp;
  }


  /**
   *  Gets the Valid attribute of the Note object
   *
   *@return    The Valid value
   */
  public boolean isValid() {
    return (subject != null && !subject.trim().equals("") && body != null && !body.trim().equals(""));
  }


  /**
   *  Gets the Subject attribute of the Note object
   *
   *@return    The Subject value
   */
  public String getSubject() {
    return subject;
  }


  /**
   *  Gets the IsContact attribute of the Note object
   *
   *@return    The IsContact value
   */
  public boolean getIsContact() {
    return isContact;
  }


  /**
   *  Gets the IsOrg attribute of the Note object
   *
   *@return    The IsOrg value
   */
  public boolean getIsOrg() {
    return isOrg;
  }


  /**
   *  Gets the IsOpp attribute of the Note object
   *
   *@return    The IsOpp value
   */
  public boolean getIsOpp() {
    return isOpp;
  }


  /**
   *  Gets the Id attribute of the Note object
   *
   *@return    The Id value
   */
  public int getId() {
    return id;
  }


  /**
   *  Gets the OrgId attribute of the Note object
   *
   *@return    The OrgId value
   */
  public int getOrgId() {
    return orgId;
  }


  /**
   *  Gets the ContactId attribute of the Note object
   *
   *@return    The ContactId value
   */
  public int getContactId() {
    return contactId;
  }


  /**
   *  Gets the OppId attribute of the Note object
   *
   *@return    The OppId value
   */
  public int getOppId() {
    return oppId;
  }


  /**
   *  Gets the DateEntered attribute of the Note object
   *
   *@return    The DateEntered value
   */
  public String getDateEntered() {
    return dateEntered;
  }


  /**
   *  Gets the Body attribute of the Note object
   *
   *@return    The Body value
   */
  public String getBody() {
    return body;
  }


  /**
   *  Gets the EnteredBy attribute of the Note object
   *
   *@return    The EnteredBy value
   */
  public int getEnteredBy() {
    return enteredBy;
  }


  /**
   *  Gets the ModifiedBy attribute of the Note object
   *
   *@return    The ModifiedBy value
   */
  public int getModifiedBy() {
    return modifiedBy;
  }


  /**
   *  Gets the Enabled attribute of the Note object
   *
   *@return    The Enabled value
   */
  public boolean getEnabled() {
    return enabled;
  }


  /**
   *  Description of the Method
   *
   *@param  rs                Description of Parameter
   *@exception  SQLException  Description of Exception
   *@since                    1.4
   */
  protected void buildRecord(ResultSet rs) throws SQLException {
    this.setId(rs.getInt("id"));
    this.setDateEntered(rs.getString("dateentered"));
    if (!isContact && !isOpp) {
      this.setOrgId(rs.getInt("org_id"));
    } else if (!isOpp && !isOrg) {
      this.setContactId(rs.getInt("contact_id"));
    } else {
      this.setOppId(rs.getInt("opp_id"));
    }

    this.setBody(rs.getString("body"));
    this.setSubject(rs.getString("subject"));

    this.setEnteredBy(rs.getInt("enteredby"));
    this.setModifiedBy(rs.getInt("modifiedby"));
  }


  /**
   *  Description of the Method
   *
   *@param  request    Description of Parameter
   *@param  parseItem  Description of Parameter
   *@since             1.4
   */
  public void buildRecord(HttpServletRequest request, int parseItem) {
    this.setDateEntered(request.getParameter("note" + parseItem + "date"));

    if (request.getParameter("note" + parseItem + "id") != null) {
      this.setId(request.getParameter("note" + parseItem + "id"));
    }

    this.setSubject(request.getParameter("note" + parseItem + "subject"));
    this.setBody(request.getParameter("note" + parseItem + "body"));

    if (request.getParameter("note" + parseItem + "delete") != null) {
      String action = request.getParameter("note" + parseItem + "delete").toLowerCase();
      if (action.equals("on")) {
        this.setEnabled(false);
      }
    }
  }
}

