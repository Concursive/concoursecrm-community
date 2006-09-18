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
package org.aspcfs.modules.orders.base;

import java.security.Key;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;

import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.PrivateString;

import com.darkhorseventures.framework.beans.GenericBean;

/**
 * This represents a Payment's Credit Card
 *
 * @author Olga.Kaptyug
 * @version 
 * @created Aug 21, 2006
 */
public class CreditCard extends GenericBean {
 
  private int id = -1;
  private int cardType = -1;
  private String cardTypeName = null;
  private String cardNumber = null;
  private String cardSecurityCode = null;
  private int expirationMonth = -1;
  private int expirationYear = -1;
  private String nameOnCard = null;
  private String companyNameOnCard = null;

  private Timestamp entered = null;
  private int enteredBy = -1;
  private Timestamp modified = null;
  private int modifiedBy = -1;
  // payment encryption
  private Key publicKey = null;
  private Key privateKey = null;



  /**
   * Gets the cardTypeName attribute of the CreditCard object
   *
   * @return cardTypeName The cardTypeName value
   */
  public String getCardTypeName() {
    return this.cardTypeName;
  }


  /**
   * Sets the cardTypeName attribute of the CreditCard object
   *
   * @param cardTypeName The new cardTypeName value
   */
  public void setCardTypeName(String cardTypeName) {
    this.cardTypeName = cardTypeName;
  }


  /**
   * Sets the id attribute of the PaymentCreditCard object
   *
   * @param tmp The new id value
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   * Sets the id attribute of the PaymentCreditCard object
   *
   * @param tmp The new id value
   */
  public void setId(String tmp) {
    this.id = Integer.parseInt(tmp);
  }


  /**
   * Sets the cardType attribute of the PaymentCreditCard object
   *
   * @param tmp The new cardType value
   */
  public void setCardType(int tmp) {
    this.cardType = tmp;
  }


  /**
   * Sets the cardType attribute of the PaymentCreditCard object
   *
   * @param tmp The new cardType value
   */
  public void setCardType(String tmp) {
    this.cardType = Integer.parseInt(tmp);
  }


  /**
   * Sets the cardNumber attribute of the PaymentCreditCard object
   *
   * @param tmp The new cardNumber value
   */
  public void setCardNumber(String tmp) {
    this.cardNumber = tmp;
  }


  /**
   * Sets the cardSecurityCode attribute of the PaymentCreditCard object
   *
   * @param tmp The new cardSecurityCode value
   */
  public void setCardSecurityCode(String tmp) {
    this.cardSecurityCode = tmp;
  }


  /**
   * Sets the expirationMonth attribute of the PaymentCreditCard object
   *
   * @param tmp The new expirationMonth value
   */
  public void setExpirationMonth(int tmp) {
    this.expirationMonth = tmp;
  }


  /**
   * Sets the expirationMonth attribute of the PaymentCreditCard object
   *
   * @param tmp The new expirationMonth value
   */
  public void setExpirationMonth(String tmp) {
    this.expirationMonth = Integer.parseInt(tmp);
  }


  /**
   * Sets the expirationYear attribute of the PaymentCreditCard object
   *
   * @param tmp The new expirationYear value
   */
  public void setExpirationYear(int tmp) {
    this.expirationYear = tmp;
  }


  /**
   * Sets the expirationYear attribute of the PaymentCreditCard object
   *
   * @param tmp The new expirationYear value
   */
  public void setExpirationYear(String tmp) {
    this.expirationYear = Integer.parseInt(tmp);
  }


  /**
   * Sets the nameOnCard attribute of the PaymentCreditCard object
   *
   * @param tmp The new nameOnCard value
   */
  public void setNameOnCard(String tmp) {
    this.nameOnCard = tmp;
  }


  /**
   * Sets the companyNameOnCard attribute of the PaymentCreditCard object
   *
   * @param tmp The new companyNameOnCard value
   */
  public void setCompanyNameOnCard(String tmp) {
    this.companyNameOnCard = tmp;
  }


  /**
   * Sets the enteredBy attribute of the PaymentCreditCard object
   *
   * @param tmp The new enteredBy value
   */
  public void setEnteredBy(int tmp) {
    this.enteredBy = tmp;
  }


  /**
   * Sets the enteredBy attribute of the PaymentCreditCard object
   *
   * @param tmp The new enteredBy value
   */
  public void setEnteredBy(String tmp) {
    this.enteredBy = Integer.parseInt(tmp);
  }


  /**
   * Sets the entered attribute of the PaymentCreditCard object
   *
   * @param tmp The new entered value
   */
  public void setEntered(Timestamp tmp) {
    this.entered = tmp;
  }


  /**
   * Sets the entered attribute of the PaymentCreditCard object
   *
   * @param tmp The new entered value
   */
  public void setEntered(String tmp) {
    this.entered = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   * Sets the modifiedBy attribute of the PaymentCreditCard object
   *
   * @param tmp The new modifiedBy value
   */
  public void setModifiedBy(int tmp) {
    this.modifiedBy = tmp;
  }


  /**
   * Sets the modifiedBy attribute of the PaymentCreditCard object
   *
   * @param tmp The new modifiedBy value
   */
  public void setModifiedBy(String tmp) {
    this.modifiedBy = Integer.parseInt(tmp);
  }


  /**
   * Sets the modified attribute of the PaymentCreditCard object
   *
   * @param tmp The new modified value
   */
  public void setModified(Timestamp tmp) {
    this.modified = tmp;
  }


  /**
   * Sets the modified attribute of the PaymentCreditCard object
   *
   * @param tmp The new modified value
   */
  public void setModified(String tmp) {
    this.modified = DatabaseUtils.parseTimestamp(tmp);
  }


  /**
   * Sets the publicKey attribute of the PaymentCreditCard object
   *
   * @param tmp The new publicKey value
   */
  public void setPublicKey(Key tmp) {
    this.publicKey = tmp;
  }


  /**
   * Gets the publicKey attribute of the PaymentCreditCard object
   *
   * @return The publicKey value
   */
  public Key getPublicKey() {
    return publicKey;
  }


  /**
   * Sets the privateKey attribute of the PaymentCreditCard object
   *
   * @param tmp The new privateKey value
   */
  public void setPrivateKey(Key tmp) {
    this.privateKey = tmp;
  }


  /**
   * Gets the privateKey attribute of the PaymentCreditCard object
   *
   * @return The privateKey value
   */
  public Key getPrivateKey() {
    return privateKey;
  }


  /**
   * Gets the id attribute of the PaymentCreditCard object
   *
   * @return The id value
   */
  public int getId() {
    return id;
  }


  /**
   * Gets the cardType attribute of the PaymentCreditCard object
   *
   * @return The cardType value
   */
  public int getCardType() {
    return cardType;
  }


  /**
   * Gets the cardNumber attribute of the PaymentCreditCard object
   *
   * @return The cardNumber value
   */
  public String getCardNumber() {
    return cardNumber;
  }


  /**
   * Gets the encryptedCardNumber attribute of the PaymentCreditCard object
   *
   * @return The encryptedCardNumber value
   */
  public String getEncryptedCardNumber() {
    return PrivateString.encryptAsymmetric(publicKey, this.getCardNumber());
  }


  /**
   * Gets the cardSecurityCode attribute of the PaymentCreditCard object
   *
   * @return The cardSecurityCode value
   */
  public String getCardSecurityCode() {
    return cardSecurityCode;
  }


  /**
   * Gets the expirationMonth attribute of the PaymentCreditCard object
   *
   * @return The expirationMonth value
   */
  public int getExpirationMonth() {
    return expirationMonth;
  }


  /**
   * Gets the expirationYear attribute of the PaymentCreditCard object
   *
   * @return The expirationYear value
   */
  public int getExpirationYear() {
    return expirationYear;
  }


  /**
   * Gets the nameOnCard attribute of the PaymentCreditCard object
   *
   * @return The nameOnCard value
   */
  public String getNameOnCard() {
    return nameOnCard;
  }


  /**
   * Gets the companyNameOnCard attribute of the PaymentCreditCard object
   *
   * @return The companyNameOnCard value
   */
  public String getCompanyNameOnCard() {
    return companyNameOnCard;
  }


  /**
   * Gets the enteredBy attribute of the PaymentCreditCard object
   *
   * @return The enteredBy value
   */
  public int getEnteredBy() {
    return enteredBy;
  }


  /**
   * Gets the entered attribute of the PaymentCreditCard object
   *
   * @return The entered value
   */
  public Timestamp getEntered() {
    return entered;
  }


  /**
   * Gets the modifiedBy attribute of the PaymentCreditCard object
   *
   * @return The modifiedBy value
   */
  public int getModifiedBy() {
    return modifiedBy;
  }


  /**
   * Gets the modified attribute of the PaymentCreditCard object
   *
   * @return The modified value
   */
  public Timestamp getModified() {
    return modified;
  }


  /**
   * Constructor for the PaymentCreditCard object
   */
  public CreditCard() {
  }


  /**
   * Constructor for the PaymentCreditCard object
   *
   * @param db Description of the Parameter
   * @param id Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public CreditCard(Connection db, int id) throws SQLException {
    queryRecord(db, id);
  }


  /**
   * Constructor for the PaymentCreditCard object
   *
   * @param rs Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public CreditCard(ResultSet rs) throws SQLException {
    buildRecord(rs);
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @param id Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void queryRecord(Connection db, int id) throws SQLException {
    if (id == -1) {
      throw new SQLException("Invalid Credit Card ID");
    }

    PreparedStatement pst = db.prepareStatement(
        " SELECT pc.creditcard_id, pc.card_type, pc.card_number, pc.card_security_code, " +
        "		     pc.expiration_month, pc.expiration_year, pc.name_on_card, pc.company_name_on_card, " +
        "	       pc.entered, pc.enteredby, pc.modified, pc.modifiedby, lct.description as card_type_name " +
        " FROM credit_card pc " +
        " LEFT JOIN lookup_creditcard_types lct on (pc.card_type = lct.code) "+
        " WHERE pc.creditcard_id = ? ");
    pst.setInt(1, id);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      buildRecord(rs);
    }
    rs.close();
    pst.close();
    if (this.id == -1) {
      throw new SQLException("Credit Card Entry not found");
    }
  }


  /**
   * Description of the Method
   *
   * @param rs Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  private void buildRecord(ResultSet rs) throws SQLException {
    //payment_creditcard table
    this.setId(rs.getInt("creditcard_id"));
    cardType = DatabaseUtils.getInt(rs, "card_type");
    cardTypeName = rs.getString("card_type_name");
    cardNumber = rs.getString("card_number");
    cardSecurityCode = rs.getString("card_security_code");

    expirationMonth = DatabaseUtils.getInt(rs, "expiration_month");
    expirationYear = DatabaseUtils.getInt(rs, "expiration_year");

    nameOnCard = rs.getString("name_on_card");
    companyNameOnCard = rs.getString("company_name_on_card");

    entered = rs.getTimestamp("entered");
    enteredBy = rs.getInt("enteredby");
    modified = rs.getTimestamp("modified");
    modifiedBy = rs.getInt("modifiedby");

  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public boolean insert(Connection db) throws SQLException {
    boolean result = false;
    id = DatabaseUtils.getNextSeq(db, "creditcard_creditcard_id_seq");
    StringBuffer sql = new StringBuffer();
    sql.append(
        " INSERT INTO credit_card(card_type, card_number, card_security_code, " +
        " 	expiration_month, expiration_year, name_on_card, company_name_on_card, ");
    if (id > -1) {
      sql.append("creditcard_id, ");
    }
    if (entered != null) {
      sql.append("entered, ");
    }
    sql.append("enteredby, ");
    if (modified != null) {
      sql.append("modified, ");
    }
    sql.append("modifiedby )");
    sql.append("VALUES( ?, ?, ?, ?, ?, ?, ?, ");
    if (id > -1) {
      sql.append("?, ");
    }
    if (entered != null) {
      sql.append("?, ");
    }
    sql.append("?, ");
    if (modified != null) {
      sql.append("?, ");
    }
    sql.append("? )");
    int i = 0;
    PreparedStatement pst = db.prepareStatement(sql.toString());
    DatabaseUtils.setInt(pst, ++i, this.getCardType());
    pst.setString(++i, this.getCardNumber());
    pst.setString(++i, this.getCardSecurityCode());
    DatabaseUtils.setInt(pst, ++i, this.getExpirationMonth());
    DatabaseUtils.setInt(pst, ++i, this.getExpirationYear());
    pst.setString(++i, this.getNameOnCard());
    pst.setString(++i, this.getCompanyNameOnCard());
    if (id > -1) {
      pst.setInt(++i, id);
    }
    if (entered != null) {
      pst.setTimestamp(++i, this.getEntered());
    }
    pst.setInt(++i, this.getEnteredBy());
    if (modified != null) {
      pst.setTimestamp(++i, this.getModified());
    }
    pst.setInt(++i, this.getModifiedBy());
    pst.execute();
    pst.close();
    id = DatabaseUtils.getCurrVal(
        db, "creditcard_creditcard_id_seq", id);
    result = true;
    return result;
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public boolean delete(Connection db) throws SQLException {
    if (this.getId() == -1) {
      throw new SQLException("Credit Card ID not specified");
    }
    // delete the credit card info
    PreparedStatement pst = db.prepareStatement(
        "DELETE FROM credit_card WHERE creditcard_id = ? ");
    pst.setInt(1, this.getId());
    pst.execute();
    pst.close();
    return true;
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public int update(Connection db) throws SQLException {
    int resultCount = 0;
    if (this.getId() == -1) {
      return -1;
    }
    PreparedStatement pst = null;
    StringBuffer sql = new StringBuffer();
    sql.append(
        "UPDATE credit_card " +
        "SET card_type = ?, " +
        "     card_number = ?, " +
        "     card_security_code = ?, " +
        "     expiration_month = ?, " +
        "     expiration_year = ?, " +
        "     name_on_card = ?, " +
        "     company_name_on_card = ?, " +
        "     modified = " + DatabaseUtils.getCurrentTimestamp(db) + ", " +
        "     modifiedby = ? " +
        "WHERE creditcard_id = ? ");

    int i = 0;
    pst = db.prepareStatement(sql.toString());
    DatabaseUtils.setInt(pst, ++i, this.getCardType());
    pst.setString(++i, this.getCardNumber());
    pst.setString(++i, this.getCardSecurityCode());
    pst.setInt(++i, this.getExpirationMonth());
    pst.setInt(++i, this.getExpirationYear());
    pst.setString(++i, this.getNameOnCard());
    pst.setString(++i, this.getCompanyNameOnCard());
    pst.setInt(++i, this.getModifiedBy());
    pst.setInt(++i, this.getId());

    resultCount = pst.executeUpdate();
    pst.close();
    return resultCount;
  }

}

