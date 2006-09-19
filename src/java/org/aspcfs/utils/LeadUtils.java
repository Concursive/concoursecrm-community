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
package org.aspcfs.utils;

import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.actionplans.base.ActionPlan;
import org.aspcfs.modules.contacts.base.Contact;
import org.aspcfs.modules.contacts.base.ContactList;
import java.sql.*;

import java.util.Calendar;

/**
 *  Description of the Class
 *
 * @author     partha
 * @version    $Id: LeadUtils.java,v 1.1.4.4 2005/03/17 18:12:57 mrajkowski Exp
 *      $
 * @created    March 2, 2005
 */
public class LeadUtils {

  /**
   *  This method checks and sets the read status of the Lead. If the lead is
   *  being read by someone else, it returns false. If the lead is being read by
   *  the user or its not being read before, it returns true.
   *
   * @param  db             Description of the Parameter
   * @param  contactId      Description of the Parameter
   * @param  userId         The new readStatus value
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public static synchronized int setReadStatus(Connection db, int contactId, int userId) throws SQLException {
    if (contactId == -1) {
      return -1;
    }
    int readId = -1;
    PreparedStatement pst = null;
    ResultSet rs = null;
    pst = db.prepareStatement(
        "SELECT user_id " +
        "FROM contact_lead_read_map clrm " +
        "WHERE clrm.contact_id = ? ");
    pst.setInt(1, contactId);
    rs = pst.executeQuery();
    if (rs.next()) {
      readId = DatabaseUtils.getInt(rs, "user_id");
    }
    rs.close();
    pst.close();

    if (readId == userId) {
      pst = db.prepareStatement(
          "DELETE FROM contact_lead_skipped_map WHERE contact_id= ? AND user_id = ? ");
      pst.setInt(1, contactId);
      pst.setInt(2, userId);
      pst.execute();
      pst.close();
      return readId;
    } else if (readId != -1) {
      return readId;
    } else if (readId == -1) {
      pst = db.prepareStatement(
          "DELETE FROM contact_lead_skipped_map WHERE contact_id= ? AND user_id = ? ");
      pst.setInt(1, contactId);
      pst.setInt(2, userId);
      pst.execute();
      pst.close();
      int mapId = DatabaseUtils.getNextSeq(
          db, "contact_lead_read_map_map_id_seq");
      pst = db.prepareStatement(
          "INSERT INTO contact_lead_read_map " +
          "(" + (mapId > -1 ? "map_id, " : "") + "contact_id, user_id) " +
          "VALUES(" + (mapId > -1 ? "?, " : "") + "?, ?)");
      int i = 0;
      if (mapId > -1) {
        pst.setInt(++i, mapId);
      }
      pst.setInt(++i, contactId);
      pst.setInt(++i, userId);
      pst.execute();
      pst.close();
      mapId = DatabaseUtils.getCurrVal(
          db, "contact_lead_read_map_map_id_seq", mapId);
      return userId;
    }
    return -1;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @param  contactId      Description of the Parameter
   * @param  userId         Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public static synchronized boolean skipLead(Connection db, int contactId, int userId) throws SQLException {
    PreparedStatement pst = null;
    ResultSet rs = null;
    int mapId = -1;
    int readId = -1;

    //Check to see if the user is the owner of the record being skipped
    int ownerId = 0;
    pst = db.prepareStatement(
        "SELECT owner FROM contact WHERE contact_id = ?");
    pst.setInt(1, contactId);
    rs = pst.executeQuery();
    if (rs.next()) {
      ownerId = DatabaseUtils.getInt(rs, "owner");
    }
    rs.close();
    pst.close();

    //Check the read_map table to see who is reading the lead
    pst = db.prepareStatement(
        "SELECT map_id, user_id FROM contact_lead_read_map WHERE contact_id = ?");
    pst.setInt(1, contactId);
    rs = pst.executeQuery();
    if (rs.next()) {
      mapId = DatabaseUtils.getInt(rs, "map_id");
      readId = DatabaseUtils.getInt(rs, "user_id");
    }
    rs.close();
    pst.close();

    if (mapId == -1) {
      //This case is impossible unless there is a programming error
      return false;
    } else {
      if (userId != readId || ownerId == userId) {
        //User wants to skip the lead that has been read by another user.
        //OR User wants to skip the lead that has already been assigned to the user.
        //Allow the skip.
      } else if (userId == readId && ownerId == -1) {
        //Remove the mapping of the user and the contact from the read map
        pst = db.prepareStatement(
            "DELETE FROM contact_lead_read_map WHERE map_id = ?");
        pst.setInt(1, mapId);
        pst.execute();
        pst.close();

        //User wants to skip the lead. Add an entry to the skipped table
        int skipMapId = -1;
        skipMapId = DatabaseUtils.getNextSeq(
            db, "contact_lead_skipped_map_map_id_seq");
        pst = db.prepareStatement(
            "INSERT INTO contact_lead_skipped_map " +
            "(" + (skipMapId > -1 ? "map_id, " : "") + "contact_id, user_id) " +
            "VALUES (" + (skipMapId > -1 ? "?, " : "") + "?, ?)");
        int i = 0;
        if (skipMapId > -1) {
          pst.setInt(++i, skipMapId);
        }
        pst.setInt(++i, contactId);
        pst.setInt(++i, userId);
        pst.execute();
        pst.close();
        skipMapId = DatabaseUtils.getCurrVal(
            db, "contact_lead_skipped_map_map_id_seq", skipMapId);
      }
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @param  contactId      Description of the Parameter
   * @param  userId         Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public static synchronized int cleanUpContact(Connection db, int contactId, int userId) throws SQLException {
    PreparedStatement pst = null;
    //delete the contact_id related record in the contact_lead_read_map
    pst = db.prepareStatement(
        "DELETE FROM contact_lead_read_map WHERE contact_id = ?");
    pst.setInt(1, contactId);
    int size = pst.executeUpdate();
    pst.close();

    //delete the contact_id related record in the contact_lead_skipped_map
    pst = db.prepareStatement(
        "DELETE FROM contact_lead_skipped_map WHERE contact_id = ?");
    pst.setInt(1, contactId);
    size = size + pst.executeUpdate();
    pst.close();

    return size;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @param  contactId      Description of the Parameter
   * @param  userId         Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public static synchronized boolean tryToAssignLead(Connection db, int contactId, int userId) throws SQLException {
    boolean lead = true;
    PreparedStatement pst = null;
    ResultSet rs = null;
    pst = db.prepareStatement(
        "SELECT lead " +
        "FROM contact c " +
        "WHERE c.contact_id = ? ");
    pst.setInt(1, contactId);
    rs = pst.executeQuery();
    if (rs.next()) {
      lead = rs.getBoolean("lead");
    }
    rs.close();
    pst.close();

    if (!lead) {
      return false;
    }

    //delete the read status
    pst = db.prepareStatement(
        "DELETE FROM contact_lead_read_map WHERE contact_id = ? ");
    pst.setInt(1, contactId);
    pst.execute();
    pst.close();

    pst = db.prepareStatement(
        "UPDATE contact SET owner = ? WHERE contact_id = ?");
    pst.setInt(1, userId);
    pst.setInt(2, contactId);
    int result = pst.executeUpdate();
    pst.close();

    int mapId = DatabaseUtils.getNextSeq(
        db, "contact_lead_read_map_map_id_seq");
    pst = db.prepareStatement(
        "INSERT INTO contact_lead_read_map " +
        "(" + (mapId > -1 ? "map_id, " : "") + "contact_id, user_id) " +
        "VALUES(" + (mapId > -1 ? "?, " : "") + "?, ?)");
    int i = 0;
    if (mapId > -1) {
      pst.setInt(++i, mapId);
    }
    pst.setInt(++i, contactId);
    pst.setInt(++i, userId);
    pst.execute();
    pst.close();
    mapId = DatabaseUtils.getCurrVal(
        db, "contact_lead_read_map_map_id_seq", mapId);
    return true;
  }


  /**
   *  Description of the Method
   *
   * @param  db             Description of the Parameter
   * @param  contactId      Description of the Parameter
   * @param  userId         Description of the Parameter
   * @param  ownerId        Description of the Parameter
   * @return                Description of the Return Value
   * @throws  SQLException  Description of the Exception
   */
  public static synchronized boolean tryToAssignLead(Connection db, int contactId, int userId, int ownerId) throws SQLException {
    boolean lead = true;
    PreparedStatement pst = null;
    ResultSet rs = null;
    pst = db.prepareStatement(
        "SELECT lead " +
        "FROM contact c " +
        "WHERE c.contact_id = ? ");
    pst.setInt(1, contactId);
    rs = pst.executeQuery();
    if (rs.next()) {
      lead = rs.getBoolean("lead");
    }
    rs.close();
    pst.close();

    if (!lead) {
      return false;
    }

    //delete the read status
    pst = db.prepareStatement(
        "DELETE FROM contact_lead_read_map WHERE contact_id = ? ");
    pst.setInt(1, contactId);
    pst.execute();
    pst.close();

    pst = db.prepareStatement(
        "UPDATE contact SET owner = ? WHERE contact_id = ?");
    pst.setInt(1, ownerId);
    pst.setInt(2, contactId);
    int result = pst.executeUpdate();
    pst.close();

    if (userId == ownerId) {
      int mapId = DatabaseUtils.getNextSeq(
          db, "contact_lead_read_map_map_id_seq");
      pst = db.prepareStatement(
          "INSERT INTO contact_lead_read_map " +
          "(" + (mapId > -1 ? "map_id, " : "") + "contact_id, user_id) " +
          "VALUES(" + (mapId > -1 ? "?, " : "") + "?, ?)");
      int i = 0;
      if (mapId > -1) {
        pst.setInt(++i, mapId);
      }
      pst.setInt(++i, contactId);
      pst.setInt(++i, userId);
      pst.execute();
      pst.close();
      mapId = DatabaseUtils.getCurrVal(
          db, "contact_lead_read_map_map_id_seq", mapId);
    }
    return true;
  }


  /**
   *  Gets the nextLead attribute of the LeadUtils class
   *
   * @param  db                       Description of the Parameter
   * @param  contactId                Description of the Parameter
   * @param  criteria                 Description of the Parameter
   * @param  siteId                   Description of the Parameter
   * @param  includeContactsAllSites  Description of the Parameter
   * @return                          The nextLead value
   * @throws  SQLException            Description of the Exception
   */
  public static synchronized int getNextLead(Connection db, int contactId, ContactList criteria, int siteId, boolean includeContactsAllSites) throws SQLException {
    int nextContactId = -1;
    PreparedStatement pst = null;
    ResultSet rs = null;
    /**
     *  For the oldestFirst ordering, contactId is 0. If the newestFirst
     *  ordering is selected, oldestFirst is false. Hence contactId is
     *  Max(contact_id) + 1 if contactId = 0. Get the maximum contact_id in this
     *  case and set it to contactId
     */
    if (criteria.getOldestFirst() == Constants.FALSE && contactId == 0) {
      pst = db.prepareStatement(
          "SELECT MAX(contact_id) as contact_id FROM contact ");
      rs = pst.executeQuery();
      if (rs.next()) {
        contactId = DatabaseUtils.getInt(rs, "contact_id") + 1;
      }
      rs.close();
      pst.close();
    }
    StringBuffer sql = new StringBuffer("");
    if (criteria.getOldestFirst() != Constants.FALSE) {
      /**
       *  In the oldest first ordering, get the minimum record greater than the
       *  contactId
       */
      sql.append("SELECT MIN(c.contact_id) AS contact_id ");
    } else {
      /**
       *  In the newest first ordering, get the maximum record less than the
       *  contactId
       */
      sql.append("SELECT MAX(c.contact_id) AS contact_id ");
    }
    sql.append("FROM contact c ");
    if (criteria.getOldestFirst() != Constants.FALSE) {
      sql.append("WHERE c.contact_id > ? AND c.trashed_date IS NULL ");
    } else {
      sql.append("WHERE c.contact_id < ? AND c.trashed_date IS NULL ");
    }
    createFilter(db, sql, criteria, siteId, includeContactsAllSites);
    pst = db.prepareStatement(sql.toString());
    DatabaseUtils.setInt(pst, 1, contactId);
    prepareFilter(pst, criteria, siteId, includeContactsAllSites);
    rs = pst.executeQuery();
    if (rs.next()) {
      /**
       *  If the required contactId does not exist, DatabaseUtils ensures that
       *  the returned id is -1
       */
      nextContactId = DatabaseUtils.getInt(rs, "contact_id");
    }
    rs.close();
    pst.close();
    return nextContactId;
  }


  /**
   *  Description of the Method
   *
   * @param  db                       Description of the Parameter
   * @param  sqlFilter                Description of the Parameter
   * @param  criteria                 Description of the Parameter
   * @param  siteId                   Description of the Parameter
   * @param  includeContactsAllSites  Description of the Parameter
   * @throws  SQLException            Description of the Exception
   */
  private static void createFilter(Connection db, StringBuffer sqlFilter, ContactList criteria, int siteId, boolean includeContactsAllSites) throws SQLException {
    // NOTE: Unfortunately this must be kept up to date with the ContactList code and would best be merged
    int owner = criteria.getOwner();
    int leadStatus = criteria.getLeadStatus();
    int leadsOnly = criteria.getLeadsOnly();
    int readBy = criteria.getReadBy();
    int source = criteria.getSource();
    int rating = criteria.getRating();
    int leadStatusExists = criteria.getLeadStatusExists();
    String postalCode = criteria.getPostalCode();
    int employeesOnly = criteria.getEmployeesOnly();
    boolean ownerOrReader = criteria.getOwnerOrReader();
    int hasConversionDate = criteria.getHasConversionDate();
    String country = criteria.getCountry();
    String emailAddress = criteria.getEmailAddress();
    Timestamp enteredStart = criteria.getEnteredStart();
    Timestamp enteredEnd = criteria.getEnteredEnd();
    Timestamp conversionDateStart = criteria.getConversionDateStart();
    Timestamp conversionDateEnd = criteria.getConversionDateEnd();
    String company = criteria.getCompany();
    String firstName = criteria.getFirstName();
    String lastName = criteria.getLastName();

    sqlFilter.append("AND c.lead = ? ");

    if (owner != -1) {
      sqlFilter.append("AND c.owner = ? ");
    }

    if (leadStatus > 0 && employeesOnly == Constants.UNDEFINED) {
      if (leadStatus == Contact.LEAD_UNPROCESSED || leadStatus == Contact.LEAD_TRASHED || leadStatus == Contact.LEAD_ASSIGNED) {
        sqlFilter.append("AND c.lead_status = ? ");
      }
    } else if (leadsOnly == Constants.TRUE && leadStatus == Contact.LEAD_UNREAD && readBy == -1 && !ownerOrReader && employeesOnly == Constants.UNDEFINED) {
      sqlFilter.append("AND c.lead_status = ? ");
      sqlFilter.append(
          "AND c.contact_id NOT IN ( " +
          "SELECT clm.contact_id AS contact_id FROM contact_lead_read_map clm WHERE clm.user_id <> ? ) " +
          "AND c.contact_id NOT IN ( " +
          "SELECT clsm.contact_id AS contact_id FROM contact_lead_skipped_map clsm WHERE clsm.user_id = ?) " +
          "");
    } else if (leadStatus == -1 && readBy == -1 && employeesOnly == Constants.UNDEFINED && leadsOnly == Constants.TRUE) {
      sqlFilter.append("AND c.lead_status IN (?, ?, ?) ");
    }
    if (source > -1) {
      sqlFilter.append("AND c.source = ? ");
    }

    if (rating > -1) {
      sqlFilter.append("AND c.rating = ? ");
    }

    if (leadsOnly == Constants.TRUE && readBy > -1 && !ownerOrReader) {
      sqlFilter.append(
          "AND c.contact_id NOT IN ( " +
          "SELECT clsm.contact_id AS contact_id FROM contact_lead_skipped_map clsm WHERE clsm.user_id = ?) " +
          "AND c.contact_id IN ( " +
          "SELECT clrm.contact_id AS contact_id FROM contact_lead_read_map clrm WHERE clrm.user_id = ? ) ");
    }

    if (leadStatusExists == Constants.TRUE) {
      sqlFilter.append("AND c.lead_status IS NOT NULL ");
    } else if (leadStatusExists == Constants.FALSE) {
      sqlFilter.append("AND c.lead_status IS NULL ");
    }

    if (enteredStart != null) {
      sqlFilter.append("AND c.entered >= ? ");
    }

    if (enteredEnd != null) {
      sqlFilter.append("AND c.entered <= ? ");
    }

    if (conversionDateStart != null) {
      sqlFilter.append("AND c.conversion_date >= ? ");
    }

    if (conversionDateEnd != null) {
      sqlFilter.append("AND c.conversion_date <= ? ");
    }

    if (emailAddress != null) {
      sqlFilter.append(
          "AND c.contact_id IN (SELECT cc.contact_id FROM " +
          "contact cc LEFT JOIN contact_emailaddress ce ON (cc.contact_id = ce.contact_id ) " +
          "WHERE cc.contact_id = c.contact_id AND ce.email = ? )");
    }

    if (postalCode != null) {
      sqlFilter.append(
          "AND c.contact_id IN (" +
          "SELECT cc.contact_id FROM contact cc LEFT JOIN contact_address ca " +
          "ON (cc.contact_id = ca.contact_id) " +
          "WHERE ca.postalcode = ? ) ");
    }

    if (hasConversionDate == Constants.TRUE) {
      sqlFilter.append("AND c.conversion_date IS NOT NULL ");
    } else if (hasConversionDate == Constants.FALSE) {
      sqlFilter.append("AND c.conversion_date IS NULL ");
    }

    if (country != null && !"-1".equals(country)) {
      sqlFilter.append(
          "AND c.contact_id IN (SELECT cc.contact_id FROM " +
          "contact cc LEFT JOIN contact_address ca ON (cc.contact_id = ca.contact_id) " +
          "WHERE ca.country = ? ) ");
    }

    if (ownerOrReader) {
      sqlFilter.append(
          "AND c.contact_id NOT IN ( " +
          "SELECT clsm.contact_id AS contact_id FROM contact_lead_skipped_map clsm WHERE clsm.user_id = ?) " +
          "AND (c.owner = ? OR c.contact_id IN (SELECT cr.contact_id AS contact_id " +
          "FROM contact_lead_read_map cr WHERE cr.user_id = ?)) ");
    }

    if (siteId != -1) {
      sqlFilter.append("AND c.site_id = ? ");
    } else if (!includeContactsAllSites) {
      sqlFilter.append("AND c.site_id IS NULL ");
    }

    if (company != null) {
      if (company.indexOf("%") >= 0) {
        sqlFilter.append(
            "AND " + DatabaseUtils.toLowerCase(db) + "(c.org_name) LIKE ? ");
      } else {
        sqlFilter.append(
            "AND " + DatabaseUtils.toLowerCase(db) + "(c.org_name) = ? ");
      }
    }

    if (firstName != null) {
      if (firstName.indexOf("%") >= 0) {
        sqlFilter.append(
            "AND " + DatabaseUtils.toLowerCase(db) + "(c.namefirst) LIKE ? ");
      } else {
        sqlFilter.append(
            "AND " + DatabaseUtils.toLowerCase(db) + "(c.namefirst) = ? ");
      }
    }

    if (lastName != null) {
      if (lastName.indexOf("%") >= 0) {
        sqlFilter.append(
            "AND " + DatabaseUtils.toLowerCase(db) + "(c.namelast) LIKE ? ");
      } else {
        sqlFilter.append(
            "AND " + DatabaseUtils.toLowerCase(db) + "(c.namelast) = ? ");
      }
    }
  }


  /**
   *  Description of the Method
   *
   * @param  pst                      Description of the Parameter
   * @param  criteria                 Description of the Parameter
   * @param  siteId                   Description of the Parameter
   * @param  includeContactsAllSites  Description of the Parameter
   * @return                          Description of the Return Value
   * @throws  SQLException            Description of the Exception
   */
  private static int prepareFilter(PreparedStatement pst, ContactList criteria, int siteId, boolean includeContactsAllSites) throws SQLException {
    int i = 1;
    int owner = criteria.getOwner();
    int leadStatus = criteria.getLeadStatus();
    int leadsOnly = criteria.getLeadsOnly();
    int readBy = criteria.getReadBy();
    int source = criteria.getSource();
    int rating = criteria.getRating();
    int leadStatusExists = criteria.getLeadStatusExists();
    String postalCode = criteria.getPostalCode();
    int userId = criteria.getUserId();
    int employeesOnly = criteria.getEmployeesOnly();
    boolean ownerOrReader = criteria.getOwnerOrReader();
    int hasConversionDate = criteria.getHasConversionDate();
    String country = criteria.getCountry();
    String emailAddress = criteria.getEmailAddress();
    Timestamp enteredStart = criteria.getEnteredStart();
    Timestamp enteredEnd = criteria.getEnteredEnd();
    Timestamp conversionDateStart = criteria.getConversionDateStart();
    Timestamp conversionDateEnd = criteria.getConversionDateEnd();
    String company = criteria.getCompany();
    String firstName = criteria.getFirstName();
    String lastName = criteria.getLastName();

    pst.setBoolean(++i, true);

    if (owner != -1) {
      pst.setInt(++i, owner);
    }
    if (leadStatus > 0 && employeesOnly == Constants.UNDEFINED) {
      if (leadStatus == Contact.LEAD_UNPROCESSED || leadStatus == Contact.LEAD_TRASHED || leadStatus == Contact.LEAD_ASSIGNED) {
        pst.setInt(++i, leadStatus);
      }
    } else if (leadsOnly == Constants.TRUE && leadStatus == Contact.LEAD_UNREAD && readBy == -1 && !ownerOrReader && employeesOnly == Constants.UNDEFINED) {
      pst.setInt(++i, Contact.LEAD_UNPROCESSED);
      pst.setInt(++i, userId);
      pst.setInt(++i, userId);
    } else if (leadStatus == -1 && readBy == -1 && employeesOnly == Constants.UNDEFINED && leadsOnly == Constants.TRUE) {
      pst.setInt(++i, Contact.LEAD_TRASHED);
      pst.setInt(++i, Contact.LEAD_ASSIGNED);
      pst.setInt(++i, Contact.LEAD_UNPROCESSED);
    }
    if (source > -1) {
      pst.setInt(++i, source);
    }
    if (rating > -1) {
      pst.setInt(++i, rating);
    }
    if (leadsOnly == Constants.TRUE && readBy > -1 && !ownerOrReader) {
      pst.setInt(++i, readBy);
      pst.setInt(++i, readBy);
    }

    if (enteredStart != null) {
      pst.setTimestamp(++i, enteredStart);
    }

    if (enteredEnd != null) {
      pst.setTimestamp(++i, enteredEnd);
    }

    if (conversionDateStart != null) {
      pst.setTimestamp(++i, conversionDateStart);
    }

    if (conversionDateEnd != null) {
      pst.setTimestamp(++i, conversionDateEnd);
    }

    if (emailAddress != null) {
      pst.setString(++i, emailAddress);
    }

    if (postalCode != null) {
      pst.setString(++i, postalCode);
    }

    if (country != null && !"-1".equals(country)) {
      pst.setString(++i, country);
    }

    if (ownerOrReader) {
      pst.setInt(++i, readBy);
      pst.setInt(++i, owner);
      pst.setInt(++i, readBy);
    }

    if (siteId != -1) {
      pst.setInt(++i, siteId);
    }

    if (company != null) {
      pst.setString(++i, company.toLowerCase());
    }

    if (firstName != null) {
      pst.setString(++i, firstName.toLowerCase());
    }

    if (lastName != null) {
      pst.setString(++i, lastName.toLowerCase());
    }

    return i;
  }



  /**
   *  Gets the leadsAssigned attribute of the LeadUtils class
   *
   * @param  db                Description of the Parameter
   * @param  startDate         Description of the Parameter
   * @param  endDate           Description of the Parameter
   * @return                   The leadsAssigned value
   * @exception  SQLException  Description of the Exception
   */
  public static int getLeadsAssigned(Connection db, Timestamp startDate, Timestamp endDate) throws SQLException {
    int count = 0;
    PreparedStatement pst = db.prepareStatement(
        "SELECT count(*) AS resultcount " +
        "FROM contact c " +
        "WHERE c.lead = ? AND c.lead_status = ? " +
        "AND c.assigned_date >= ? AND c.assigned_date <= ? ");
    int i = 0;
    pst.setBoolean(++i, true);
    pst.setInt(++i, Contact.LEAD_ASSIGNED);
    DatabaseUtils.setTimestamp(pst, ++i, startDate);
    DatabaseUtils.setTimestamp(pst, ++i, endDate);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      count = rs.getInt("resultcount");
    }
    rs.close();
    pst.close();
    return count;
  }



  /**
   *  Gets the leadsActive attribute of the LeadUtils class
   *
   * @param  db                Description of the Parameter
   * @param  startDate         Description of the Parameter
   * @param  endDate           Description of the Parameter
   * @return                   The leadsActive value
   * @exception  SQLException  Description of the Exception
   */
  public static int getLeadsActive(Connection db, Timestamp startDate, Timestamp endDate) throws SQLException {
    int count = 0;
    PreparedStatement pst = db.prepareStatement(
        "SELECT count(*) AS resultcount " +
        "FROM contact c " +
        "WHERE c.lead = ? AND c.lead_status = ? ");
    pst.setBoolean(1, true);
    pst.setInt(2, Contact.LEAD_ASSIGNED);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      count = rs.getInt("resultcount");
    }
    rs.close();
    pst.close();
    return count;
  }



  /**
   *  Gets the leadsUnassigned attribute of the LeadUtils class
   *
   * @param  db                Description of the Parameter
   * @param  startDate         Description of the Parameter
   * @param  endDate           Description of the Parameter
   * @return                   The leadsUnassigned value
   * @exception  SQLException  Description of the Exception
   */
  public static int getLeadsUnassigned(Connection db, Timestamp startDate, Timestamp endDate) throws SQLException {
    int count = 0;
    PreparedStatement pst = db.prepareStatement(
        "SELECT count(*) AS resultcount " +
        "FROM contact c " +
        "WHERE c.lead = ? AND c.lead_status = ? ");
    pst.setBoolean(1, true);
    pst.setInt(2, Contact.LEAD_UNPROCESSED);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      count = rs.getInt("resultcount");
    }
    rs.close();
    pst.close();
    return count;
  }



  /**
   *  Gets the accountsWon attribute of the LeadUtils class
   *
   * @param  db                Description of the Parameter
   * @param  startDate         Description of the Parameter
   * @param  endDate           Description of the Parameter
   * @return                   The accountsWon value
   * @exception  SQLException  Description of the Exception
   */
  public static int getAccountsWon(Connection db, Timestamp startDate, Timestamp endDate) throws SQLException {
    int count = 0;
    PreparedStatement pst = db.prepareStatement(
        "SELECT count(*) AS resultcount " +
        "FROM contact c " +
        "LEFT JOIN organization o ON (c.org_id = o.org_id) " + 
        "LEFT JOIN action_plan_work apw ON (o.org_id = apw.link_item_id) " + 
        "LEFT JOIN action_phase_work aphw ON (apw.plan_work_id = aphw.plan_work_id) " + 
        "LEFT JOIN action_item_work aiw ON (aphw.phase_work_id = aiw.phase_work_id) " +
        "LEFT JOIN opportunity_component oc ON (aiw.link_item_id = oc.id) " +
        "LEFT JOIN lookup_stage ls ON (oc.stage = ls.code) " +
        "WHERE c.lead = ? AND c.lead_status = ? " +
        "AND c.conversion_date IS NOT NULL " + 
        "AND apw.link_module_id IN (SELECT map_id FROM action_plan_constants WHERE constant_id = ?) " +
        "AND aiw.link_module_id IN (SELECT map_id FROM action_plan_constants WHERE constant_id = ?) " + 
        "AND oc.stagedate >= ? " + 
        "AND oc.stagedate <= ? " + 
        "AND oc.stage = ? ");
    int i = 0;
    pst.setBoolean(++i, false);
    pst.setInt(++i, Contact.LEAD_ASSIGNED);
    pst.setInt(++i, ActionPlan.ACCOUNTS);
    pst.setInt(++i, ActionPlan.PIPELINE_COMPONENT);
    DatabaseUtils.setTimestamp(pst, ++i, startDate);
    DatabaseUtils.setTimestamp(pst, ++i, endDate);
    pst.setInt(++i, 8); // opportunity component stage "Closed Won"
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      count = rs.getInt("resultcount");
    }
    rs.close();
    pst.close();
    return count;
  }



  /**
   *  Gets the accountsLost attribute of the LeadUtils class
   *
   * @param  db                Description of the Parameter
   * @param  startDate         Description of the Parameter
   * @param  endDate           Description of the Parameter
   * @return                   The accountsLost value
   * @exception  SQLException  Description of the Exception
   */
  public static int getAccountsLost(Connection db, Timestamp startDate, Timestamp endDate) throws SQLException {
    int count = 0;
    PreparedStatement pst = db.prepareStatement(
        "SELECT count(*) AS resultcount " +
        "FROM contact c " +
        "LEFT JOIN organization o ON (c.org_id = o.org_id) " + 
        "LEFT JOIN action_plan_work apw ON (o.org_id = apw.link_item_id) " + 
        "LEFT JOIN action_phase_work aphw ON (apw.plan_work_id = aphw.plan_work_id) " + 
        "LEFT JOIN action_item_work aiw ON (aphw.phase_work_id = aiw.phase_work_id) " +
        "LEFT JOIN opportunity_component oc ON (aiw.link_item_id = oc.id) " +
        "LEFT JOIN lookup_stage ls ON (oc.stage = ls.code) " +
        "WHERE c.lead = ? AND c.lead_status = ? " +
        "AND c.conversion_date IS NOT NULL " + 
        "AND apw.link_module_id IN (SELECT map_id FROM action_plan_constants WHERE constant_id = ?) " +
        "AND aiw.link_module_id IN (SELECT map_id FROM action_plan_constants WHERE constant_id = ?) " + 
        "AND oc.stagedate >= ? " + 
        "AND oc.stagedate <= ? " + 
        "AND oc.stage = ? ");
    int i = 0;
    pst.setBoolean(++i, false);
    pst.setInt(++i, Contact.LEAD_ASSIGNED);
    pst.setInt(++i, ActionPlan.ACCOUNTS);
    pst.setInt(++i, ActionPlan.PIPELINE_COMPONENT);
    DatabaseUtils.setTimestamp(pst, ++i, startDate);
    DatabaseUtils.setTimestamp(pst, ++i, endDate);
    pst.setInt(++i, 9); // opportunity component stage "Closed Lost"
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      count = rs.getInt("resultcount");
    }
    rs.close();
    pst.close();
    return count;
  }



  /**
   *  Gets the leadsTrashed attribute of the LeadUtils class
   *
   * @param  db                Description of the Parameter
   * @param  startDate         Description of the Parameter
   * @param  endDate           Description of the Parameter
   * @return                   The leadsTrashed value
   * @exception  SQLException  Description of the Exception
   */
  public static int getLeadsTrashed(Connection db, Timestamp startDate, Timestamp endDate) throws SQLException {
    int count = 0;
    PreparedStatement pst = db.prepareStatement(
        "SELECT count(*) AS resultcount " +
        "FROM contact c " +
        "WHERE c.lead = ? AND c.lead_status = ? " +
        "AND c.lead_trashed_date >= ? " +
        "AND c.lead_trashed_date <= ? ");
    int i = 0;
    pst.setBoolean(++i, true);
    pst.setInt(++i, Contact.LEAD_TRASHED);
    DatabaseUtils.setTimestamp(pst, ++i, startDate);
    DatabaseUtils.setTimestamp(pst, ++i, endDate);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      count = rs.getInt("resultcount");
    }
    rs.close();
    pst.close();
    return count;
  }



  /**
   *  Gets number of leads converted into accounts in the last so many days
   *
   * @param  db                Description of the Parameter
   * @param  days              Description of the Parameter
   * @return                   The leadsUnassigned value
   * @exception  SQLException  Description of the Exception
   */
  public static int getAccountsWon(Connection db, int days) throws SQLException {
    int count = 0;
    Calendar cal = Calendar.getInstance();
    Timestamp endDate = new Timestamp(cal.getTimeInMillis());

    cal.add(cal.DATE, days);
    Timestamp startDate = new Timestamp(cal.getTimeInMillis());

    PreparedStatement pst = db.prepareStatement(
        "SELECT count(*) AS resultcount " +
        "FROM contact c " +
        "LEFT JOIN organization o ON (c.org_id = o.org_id) " + 
        "LEFT JOIN action_plan_work apw ON (o.org_id = apw.link_item_id) " + 
        "LEFT JOIN action_phase_work aphw ON (apw.plan_work_id = aphw.plan_work_id) " + 
        "LEFT JOIN action_item_work aiw ON (aphw.phase_work_id = aiw.phase_work_id) " +
        "LEFT JOIN opportunity_component oc ON (aiw.link_item_id = oc.id) " +
        "LEFT JOIN lookup_stage ls ON (oc.stage = ls.code) " +
        "WHERE c.lead = ? AND c.lead_status = ? " +
        "AND c.conversion_date IS NOT NULL " + 
        "AND apw.link_module_id IN (SELECT map_id FROM action_plan_constants WHERE constant_id = ?) " +
        "AND aiw.link_module_id IN (SELECT map_id FROM action_plan_constants WHERE constant_id = ?) " + 
        "AND oc.stagedate >= ? " + 
        "AND oc.stagedate <= ? " + 
        "AND oc.stage = ? ");
    int i = 0;
    pst.setBoolean(++i, false);
    pst.setInt(++i, Contact.LEAD_ASSIGNED);
    pst.setInt(++i, ActionPlan.ACCOUNTS);
    pst.setInt(++i, ActionPlan.PIPELINE_COMPONENT);
    DatabaseUtils.setTimestamp(pst, ++i, startDate);
    DatabaseUtils.setTimestamp(pst, ++i, endDate);
    pst.setInt(++i, 8); // opportunity component stage "Closed Won"
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      count = rs.getInt("resultcount");
    }
    rs.close();
    pst.close();
    return count;
  }


  /**
   *  Gets the averageDays attribute of the LeadUtils class
   *
   * @param  db                Description of the Parameter
   * @param  startDate         Description of the Parameter
   * @param  endDate           Description of the Parameter
   * @param  result            Description of the Parameter
   * @return                   The averageDays value
   * @exception  SQLException  Description of the Exception
   */
  public static int getAverageDays(Connection db, Timestamp startDate, Timestamp endDate, String result) throws SQLException {
    int count = 0;
    int days = 0;
    Calendar assigned = Calendar.getInstance();
    Calendar conversion = Calendar.getInstance();

    PreparedStatement pst = db.prepareStatement(
        "SELECT c.assigned_date, oc.stagedate as conversion_date " +
        "FROM contact c " +
        "LEFT JOIN organization o ON (c.org_id = o.org_id) " + 
        "LEFT JOIN action_plan_work apw ON (o.org_id = apw.link_item_id) " + 
        "LEFT JOIN action_phase_work aphw ON (apw.plan_work_id = aphw.plan_work_id) " + 
        "LEFT JOIN action_item_work aiw ON (aphw.phase_work_id = aiw.phase_work_id) " +
        "LEFT JOIN opportunity_component oc ON (aiw.link_item_id = oc.id) " +
        "LEFT JOIN lookup_stage ls ON (oc.stage = ls.code) " +
        "WHERE c.lead = ? AND c.lead_status = ? " +
        "AND c.conversion_date IS NOT NULL " + 
        "AND apw.link_module_id IN (SELECT map_id FROM action_plan_constants WHERE constant_id = ?) " +
        "AND aiw.link_module_id IN (SELECT map_id FROM action_plan_constants WHERE constant_id = ?) " + 
        "AND oc.stagedate >= ? " + 
        "AND oc.stagedate <= ? " + 
        "AND oc.stage = ? ");
    int i = 0;
    pst.setBoolean(++i, false);
    pst.setInt(++i, Contact.LEAD_ASSIGNED);
    pst.setInt(++i, ActionPlan.ACCOUNTS);
    pst.setInt(++i, ActionPlan.PIPELINE_COMPONENT);
    DatabaseUtils.setTimestamp(pst, ++i, startDate);
    DatabaseUtils.setTimestamp(pst, ++i, endDate);
    if ("WIN".equals(result.toUpperCase())) {
      pst.setInt(++i, 8); // opportunity component stage "Closed Won"
    } else {
      pst.setInt(++i, 9); // opportunity component stage "Closed Lost"
    }
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      Timestamp assignedDate = rs.getTimestamp("assigned_date");
      Timestamp conversionDate = rs.getTimestamp("conversion_date");
      if (assignedDate != null && conversionDate != null) {
        assigned.setTimeInMillis(assignedDate.getTime());
        conversion.setTimeInMillis(conversionDate.getTime());
        days += DateUtils.getDaysBetween(
            assigned, conversion);
        count++;
      }
    }
    rs.close();
    pst.close();
    return (days > 0 ? days / count : 0);
  }


  /**
   *  Gets the daysToWin attribute of the LeadUtils class
   *
   * @param  db                Description of the Parameter
   * @param  assignedDate      Description of the Parameter
   * @param  conversionDate    Description of the Parameter
   * @return                   The daysToWin value
   * @exception  SQLException  Description of the Exception
   */
  public static int getDaysToWin(Connection db, Timestamp assignedDate, Timestamp conversionDate) throws SQLException {
    Calendar assigned = Calendar.getInstance();
    Calendar conversion = Calendar.getInstance();

    assigned.setTimeInMillis(assignedDate.getTime());
    conversion.setTimeInMillis(conversionDate.getTime());

    return DateUtils.getDaysBetween(assigned, conversion);
  }
}

