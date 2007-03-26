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
package org.aspcfs.modules.contacts.base;

import org.aspcfs.modules.base.Address;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.web.StateSelect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Builds an address for a contact using a custom query that extends the fields
 * and methods of a typical Address.
 *
 * @author mrajkowski
 * @version $Id: ContactAddress.java,v 1.8 2003/01/13 20:48:10 mrajkowski Exp
 *          $
 * @created September 1, 2001
 */
public class ContactAddress extends Address {

  /**
   * Constructor for the ContactAddress object
   *
   * @since 1.1
   */
  public ContactAddress() {
    isContact = true;
  }


  /**
   * Constructor for the ContactAddress object
   *
   * @param rs Description of Parameter
   * @throws SQLException Description of Exception
   * @since 1.1
   */
  public ContactAddress(ResultSet rs) throws SQLException {
    isContact = true;
    buildRecord(rs);
  }


  /**
   * Constructor for the ContactAddress object
   *
   * @param db        Description of Parameter
   * @param addressId Description of Parameter
   * @throws SQLException Description of Exception
   * @since 1.1
   */
  public ContactAddress(Connection db, String addressId) throws SQLException {
    queryRecord(db, Integer.parseInt(addressId));
  }


  /**
   * Constructor for the ContactAddress object
   *
   * @param db        Description of the Parameter
   * @param addressId Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public ContactAddress(Connection db, int addressId) throws SQLException {
    queryRecord(db, addressId);
  }


  /**
   * Description of the Method
   *
   * @param db        Description of the Parameter
   * @param addressId Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void queryRecord(Connection db, int addressId) throws SQLException {
    isContact = true;
    PreparedStatement pst = db.prepareStatement(
        "SELECT c.address_id, c.contact_id, c.address_type, c.addrline1, c.addrline1,  " +
            "c.addrline2, c.addrline3, c.addrline4, c.city, c.state, c.country, c.postalcode, c.county, c.latitude, c.longitude, c.entered, c.enteredby, " +
            "c.modified, c.modifiedby, c.primary_address, l.description " +
            "FROM contact_address c, lookup_contactaddress_types l " +
            "WHERE c.address_type = l.code " +
            "AND address_id = " + addressId + " ");
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    }
    rs.close();
    pst.close();
    if (this.getId() == -1) {
      throw new SQLException("Address record not found.");
    }
  }


  /**
   * Description of the Method
   *
   * @param db         Description of the Parameter
   * @param contactId  Description of the Parameter
   * @param enteredBy  Description of the Parameter
   * @param modifiedBy Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void process(Connection db, int contactId, int enteredBy, int modifiedBy) throws SQLException {
    if (this.getEnabled() == true) {
      if ("-1".equals(this.getState())) {
        this.setState("");
      }
      if ("-1".equals(this.getCountry())) {
        this.setCountry("");
      }
      if (this.getId() == -1) {
        this.setContactId(contactId);
        this.setEnteredBy(enteredBy);
        this.setModifiedBy(modifiedBy);
        this.insert(db, contactId, enteredBy);
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
  public void insert(Connection db, int contactId, int enteredBy) throws SQLException {
    StringBuffer sql = new StringBuffer();
    this.setId(DatabaseUtils.getNextSeq(db, "contact_address_address_id_seq"));
    sql.append(
        "INSERT INTO contact_address " +
            "(contact_id, address_type, addrline1, addrline2, addrline3, addrline4, city, state, postalcode, country, county, latitude, longitude, primary_address, ");
    if (getId() > -1) {
      sql.append("address_id, ");
    }
    sql.append("entered, modified, ");
    sql.append("enteredBy, modifiedBy ) ");
    sql.append("VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?,");
    if (getId() > -1) {
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

    if (this.getContactId() > -1) {
      pst.setInt(++i, this.getContactId());
    } else {
      pst.setNull(++i, java.sql.Types.INTEGER);
    }
    if (this.getType() > -1) {
      pst.setInt(++i, this.getType());
    } else {
      pst.setNull(++i, java.sql.Types.INTEGER);
    }
    pst.setString(++i, this.getStreetAddressLine1());
    pst.setString(++i, this.getStreetAddressLine2());
    pst.setString(++i, this.getStreetAddressLine3());
    pst.setString(++i, this.getStreetAddressLine4());
    pst.setString(++i, this.getCity());
    pst.setString(++i, this.getState());
    pst.setString(++i, this.getZip());
    pst.setString(++i, this.getCountry());
    pst.setString(++i, this.getCounty());
    pst.setDouble(++i, this.getLatitude());
    pst.setDouble(++i, this.getLongitude());
    pst.setBoolean(++i, this.getPrimaryAddress());
    if (getId() > -1) {
      pst.setInt(++i, getId());
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
        DatabaseUtils.getCurrVal(
            db, "contact_address_address_id_seq", getId()));
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
        "UPDATE contact_address " +
            "SET address_type = ?, addrline1 = ?, addrline2 = ?, addrline3 = ?, addrline4 = ?, city = ?, state = ?, postalcode = ?, country = ?, county = ?, latitude = ?, longitude =? , primary_address = ?, " +
            "modifiedby = ?, " + 
            "modified = " + DatabaseUtils.getCurrentTimestamp(db) + " " +
            "WHERE address_id = ? ");
    int i = 0;
    if (this.getType() > -1) {
      pst.setInt(++i, this.getType());
    } else {
      pst.setNull(++i, java.sql.Types.INTEGER);
    }
    pst.setString(++i, this.getStreetAddressLine1());
    pst.setString(++i, this.getStreetAddressLine2());
    pst.setString(++i, this.getStreetAddressLine3());
    pst.setString(++i, this.getStreetAddressLine4());
    pst.setString(++i, this.getCity());
    pst.setString(++i, this.getState());
    pst.setString(++i, this.getZip());
    pst.setString(++i, this.getCountry());
    pst.setString(++i, this.getCounty());
    pst.setDouble(++i, this.getLatitude());
    pst.setDouble(++i, this.getLongitude());
    pst.setBoolean(++i, this.getPrimaryAddress());
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
    PreparedStatement pst = db.prepareStatement(
        "DELETE FROM contact_address " +
            "WHERE address_id = ? ");
    int i = 0;
    pst.setInt(++i, this.getId());
    pst.execute();
    pst.close();
  }

}

