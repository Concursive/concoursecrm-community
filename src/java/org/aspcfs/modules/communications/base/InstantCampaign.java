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

import org.aspcfs.modules.contacts.base.Contact;
import org.aspcfs.modules.contacts.base.ContactList;
import org.aspcfs.utils.Template;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.Iterator;

/**
 * This class bypasses the typical campaign process. Now a campaign can be
 * quickly created with a message and recipients without having to build
 * criteria.
 *
 * @author akhi_m
 * @version $id:exp$
 * @created May 13, 2003
 */
public class InstantCampaign extends Campaign {
  private Message instantMessage = null;
  private ContactList recipients = null;


  /**
   * Sets the instantMessage attribute of the InstantCampaign object
   *
   * @param instantMessage The new instantMessage value
   */
  public void setMessage(Message instantMessage) {
    this.instantMessage = instantMessage;
  }


  /**
   * Sets the recipients attribute of the InstantCampaign object
   *
   * @param recipients The new recipients value
   */
  public void setRecipients(ContactList recipients) {
    this.recipients = recipients;
  }


  /**
   * Gets the recipients attribute of the InstantCampaign object
   *
   * @return The recipients value
   */
  public ContactList getRecipients() {
    return recipients;
  }


  /**
   * Gets the instantMessage attribute of the InstantCampaign object
   *
   * @return The instantMessage value
   */
  public Message getInstantMessage() {
    return instantMessage;
  }


  /**
   * Adds a feature to the Recipient attribute of the InstantCampaign object
   *
   * @param db        The feature to be added to the Recipient attribute
   * @param contactId The feature to be added to the Recipient attribute
   * @throws SQLException Description of the Exception
   */
  public void addRecipient(Connection db, int contactId) throws SQLException {
    if (recipients == null) {
      recipients = new ContactList();
    }
    recipients.add(new Contact(db, contactId));
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public boolean activate(Connection db) throws SQLException {
    int resultCount = 0;
    PreparedStatement pst = null;
    try {
      db.setAutoCommit(false);
      //Replace tags
      Template template = new Template();
      template.setText(instantMessage.getMessageText());

      //insert the campaign
      java.util.Date dtNow = new java.util.Date();
      java.sql.Timestamp today = new java.sql.Timestamp(dtNow.getTime());
      this.setMessageId(instantMessage.getId());
      this.setReplyTo(instantMessage.getReplyTo());
      this.setSubject(instantMessage.getMessageSubject());
      this.setMessage(template.getParsedText());
      this.setSendMethodId(1);
      this.setActiveDate(today);
      this.setType(Campaign.INSTANT);
      this.insert(db);

      //activate it
      //See if the campaign is not already active
      pst = db.prepareStatement(
          "UPDATE campaign " +
          "SET status_id = ?, " +
          "status = ?, " +
          "modifiedby = ?, " +
          "modified = CURRENT_TIMESTAMP " +
          "WHERE campaign_id = ? ");
      int i = 0;
      pst.setInt(++i, QUEUE);
      pst.setString(++i, QUEUE_TEXT);
      pst.setInt(++i, this.getModifiedBy());
      pst.setInt(++i, this.getId());
      resultCount = pst.executeUpdate();
      pst.close();

      //Activate the campaign...
      if (resultCount == 1) {
        this.setActive(true);
        //Lock in the recipient
        Iterator j = recipients.iterator();
        while (j.hasNext()) {
          Contact thisContact = (Contact) j.next();
          Recipient thisRecipient = new Recipient();
          thisRecipient.setCampaignId(this.getId());
          thisRecipient.setContactId(thisContact.getId());
          thisRecipient.insert(db);
        }

        //Finalize the campaign activation
        pst = db.prepareStatement(
            "UPDATE campaign " +
            "SET active = ?, " +
            "reply_addr = ?, " +
            "subject = ?, " +
            "message = ?, " +
            "modifiedby = ?, " +
            "modified = CURRENT_TIMESTAMP " +
            "WHERE campaign_id = ? ");
        i = 0;
        pst.setBoolean(++i, true);
        pst.setString(++i, instantMessage.getReplyTo());
        pst.setString(++i, instantMessage.getMessageSubject());
        pst.setString(++i, template.getParsedText());
        pst.setInt(++i, this.getModifiedBy());
        pst.setInt(++i, this.getId());
        resultCount = pst.executeUpdate();
        pst.close();
        db.commit();
      }
      return true;
    } catch (SQLException e) {
      db.rollback();
      throw new SQLException(e.getMessage());
    } catch (Exception ee) {
      db.rollback();
      throw new SQLException(ee.getMessage());
    } finally {
      db.setAutoCommit(true);
    }
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public int updateInstantCampaignMessage(Connection db, Message tmpMessage) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "UPDATE campaign " +
        "SET message = ? " +
        "WHERE campaign_id = ? ");
    int i = 0;
    pst.setString(++i, tmpMessage.getMessageText());
    pst.setInt(++i, this.getId());
    int resultCount = pst.executeUpdate();
    pst.close();
    return resultCount;
  }
}

