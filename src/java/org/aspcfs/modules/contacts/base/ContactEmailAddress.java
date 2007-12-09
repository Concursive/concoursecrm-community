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
package org.aspcfs.modules.contacts.base;

import org.aspcfs.modules.base.EmailAddress;
import org.aspcfs.utils.DatabaseUtils;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Description of the Class
 *
 * @author matt rajkowski
 * @version $Id: ContactEmailAddress.java,v 1.13 2004/04/13 19:06:33
 *          mrajkowski Exp $
 * @created January 13, 2003
 */
public class ContactEmailAddress
    extends EmailAddress {

  /**
   * Constructor for the ContactEmailAddress object
   */
  public ContactEmailAddress() {
    isContact = true;
  }

  /**
   * Constructor for the ContactEmailAddress object
   *
   * @param rs Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public ContactEmailAddress(ResultSet rs) throws SQLException {
    isContact = true;
    buildRecord(rs);
  }

  /**
   * Constructor for the ContactEmailAddress object
   *
   * @param db             Description of the Parameter
   * @param emailAddressId Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public ContactEmailAddress(Connection db, int emailAddressId) throws
      SQLException {
    queryRecord(db, emailAddressId);
  }

  /**
   * Constructor for the ContactEmailAddress object
   *
   * @param db             Description of the Parameter
   * @param emailAddressId Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public ContactEmailAddress(Connection db, String emailAddressId) throws
      SQLException {
    queryRecord(db, Integer.parseInt(emailAddressId));
  }

  /**
   * Description of the Method
   *
   * @param db             Description of the Parameter
   * @param emailAddressId Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void queryRecord(Connection db, int emailAddressId) throws
      SQLException {
    isContact = true;

    if (emailAddressId < 0) {
      throw new SQLException("Valid Email Address ID not specified.");
    }

    PreparedStatement pst = db.prepareStatement(
        "SELECT * " +
        "FROM contact_emailaddress c, lookup_contactemail_types l " +
        "WHERE c.emailaddress_type = l.code " +
        "AND emailaddress_id = " +
        emailAddressId + " ");
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    }
    rs.close();
    pst.close();
    if (this.getId() == -1) {
      throw new SQLException("Email record not found.");
    }
  }

  /**
   * Determines what to do if this record is marked for INSERT, UPDATE, or
   * DELETE
   *
   * @param db         Description of Parameter
   * @param contactId  Description of Parameter
   * @param enteredBy  Description of Parameter
   * @param modifiedBy Description of Parameter
   * @throws SQLException Description of Exception
   */
  public void process(Connection db, int contactId, int enteredBy,
                      int modifiedBy) throws SQLException {
    if (this.getEnabled() == true) {
      if (this.getId() == -1) {
        this.setContactId(contactId);
        this.setEnteredBy(enteredBy);
        this.setModifiedBy(modifiedBy);
        this.insert(db);
      } else {
        this.setModifiedBy(modifiedBy);
        this.update(db, modifiedBy);
      }
    } else {
      this.delete(db);
    }
  }

  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void insert(Connection db) throws SQLException {
    insert(db, this.getContactId(), this.getEnteredBy());
  }

  /**
   * Description of the Method
   *
   * @param db        Description of the Parameter
   * @param contactId Description of the Parameter
   * @param enteredBy Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void insert(Connection db, int contactId, int enteredBy) throws
      SQLException {
    StringBuffer sql = new StringBuffer();
    this.setId(
        DatabaseUtils.getNextSeq(db, "contact_email_emailaddress__seq"));
    int id = getId();
    sql.append(
        "INSERT INTO contact_emailaddress " +
        "(contact_id, emailaddress_type, email, primary_email, ");
    if (id > -1) {
      sql.append("emailaddress_id, ");
    }
    sql.append("entered, modified, ");
    sql.append("enteredBy, modifiedBy ) ");
    sql.append("VALUES (?, ?, ?, ?, ");
    if (id > -1) {
      sql.append("?, ");
    }
    if (this.getEntered() != null) {
      sql.append("?, ");
    } else {
      sql.append(DatabaseUtils.getCurrentTimestamp(db) + ", ");
    }
    if (this.getModified() != null) {
      sql.append("?, ");
    } else {
      sql.append(DatabaseUtils.getCurrentTimestamp(db) + ", ");
    }
    sql.append("?, ?) ");
    int i = 0;
    PreparedStatement pst = db.prepareStatement(sql.toString());
    if (contactId > -1) {
      pst.setInt(++i, this.getContactId());
    } else {
      pst.setNull(++i, java.sql.Types.INTEGER);
    }

    if (this.getType() > -1) {
      pst.setInt(++i, this.getType());
    } else {
      pst.setNull(++i, java.sql.Types.INTEGER);
    }

    pst.setString(++i, this.getEmail());
    pst.setBoolean(++i, this.getPrimaryEmail());
    if (id > -1) {
      pst.setInt(++i, id);
    }
    if (this.getEntered() != null) {
      pst.setTimestamp(++i, this.getEntered());
    }
    if (this.getModified() != null) {
      pst.setTimestamp(++i, this.getModified());
    }
    pst.setInt(++i, this.getEnteredBy());
    pst.setInt(++i, this.getModifiedBy());

    pst.execute();
    pst.close();

    this.setId(
        DatabaseUtils.getCurrVal(db, "contact_email_emailaddress__seq", id));
  }

  /**
   * Description of the Method
   *
   * @param db         Description of Parameter
   * @param modifiedBy Description of Parameter
   * @throws SQLException Description of Exception
   */
  public void update(Connection db, int modifiedBy) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "UPDATE contact_emailaddress " +
        "SET emailaddress_type = ?, email = ?, primary_email = ?, modifiedby = ?, " +
        "modified = " + DatabaseUtils.getCurrentTimestamp(db) + " " +
        "WHERE emailaddress_id = ? ");
    int i = 0;
    if (this.getType() > -1) {
      pst.setInt(++i, this.getType());
    } else {
      pst.setNull(++i, java.sql.Types.INTEGER);
    }
    pst.setString(++i, this.getEmail());
    pst.setBoolean(++i, this.getPrimaryEmail());
    pst.setInt(++i, modifiedBy);
    pst.setInt(++i, this.getId());
    pst.execute();
    pst.close();
  }

  /**
   * Description of the Method
   *
   * @param db Description of Parameter
   * @throws SQLException Description of Exception
   */
  public void delete(Connection db) throws SQLException {
    String where = "";
    if(this.getContactId() != -1){
      where += " contact_id = ?";
    }
    if(this.getId() != -1){
      where += " emailaddress_id = ?";
    }

    PreparedStatement pst = db.prepareStatement(
        "DELETE FROM contact_emailaddress " +
        "WHERE " + (where.length() != 0?where:"1 = 0"));
    int i = 0;
    if(this.getContactId() != -1){
      pst.setInt(++i, this.getContactId());
    }
    if(this.getId() != -1){
      pst.setInt(++i, this.getId());
    }
    pst.execute();
    pst.close();
  }

}
