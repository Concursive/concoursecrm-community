package com.darkhorseventures.apps.dataimport.cfsdatabasereader;

import java.sql.*;
import com.darkhorseventures.apps.dataimport.*;
import com.darkhorseventures.cfsbase.*;
import com.zeroio.iteam.base.*;
import java.util.*;

/**
 *  Processes Users, Accounts, and Contacts based on the user hierarchy that
 *  created each item.
 *
 *@author     matt rajkowski
 *@created    September 4, 2002
 *@version    $Id$
 */
public class ImportBaseData implements CFSDatabaseReaderImportModule {
  
  DataWriter writer = null;
  PropertyMapList mappings = null;
  
  /**
   *  Description of the Method
   *
   *@param  writer  Description of the Parameter
   *@param  db      Description of the Parameter
   *@return         Description of the Return Value
   */
  public boolean process(DataWriter writer, Connection db, PropertyMapList mappings) throws SQLException {
    this.writer = writer; 
    this.mappings = mappings;
    boolean processOK = true;
    
    //Copy Users
    logger.info("ImportBaseData-> Inserting users");
    UserList userList = new UserList();
    User baseUser = new User(db, "0");
    userList.add(baseUser);
    writer.setAutoCommit(false);
    this.saveUserList(db, userList);
    processOK = writer.commit();
    userList = null;
    baseUser = null;
    if (!processOK) {
      return false;
    }
    
    
    //TODO: update all user managers

    //Copy Accounts
    /**
    logger.info("ImportBaseData-> Inserting accounts");
    writer.setAutoCommit(false);
    OrganizationList accounts = new OrganizationList();
    accounts.setShowMyCompany(true);
    accounts.setIncludeEnabled(-1);
    accounts.buildList(db);
    mappings.saveList(writer, accounts, "insert");
    writer.commit();
    */
    
    logger.info("ImportBaseData-> Inserting accounts");
    OrganizationList accounts = new OrganizationList();
    accounts.setShowMyCompany(true);
    accounts.setIncludeEnabled(-1);
    accounts.buildList(db);
    writer.setAutoCommit(false);
    this.saveOrgList(db, accounts);
    writer.commit();

    processOK = writer.commit();
    if (!processOK) {
      return false;
    }
    
    //Iterate and get emails, addresses
    
    //Copy Contacts
    /**
    logger.info("ImportBaseData-> Inserting contacts");
    writer.setAutoCommit(false);
    ContactList contacts = new ContactList();
    contacts.setIncludeEnabled(-1);
    contacts.setPersonalId(-2);
    contacts.buildList(db);
    mappings.saveList(writer, contacts, "insert");
    writer.commit();
    writer.setAutoCommit(true);
    */
    
    logger.info("ImportBaseData-> Inserting contacts");
    ContactList contacts = new ContactList();
    contacts.setIncludeEnabled(-1);
    contacts.setPersonalId(-2);
    contacts.buildList(db);
    writer.setAutoCommit(false);
    this.saveContactList(db, contacts);
    writer.commit();

    processOK = writer.commit();
    if (!processOK) {
      return false;
    }
    
    return true;
  }
  
  private void saveUserList(Connection db, UserList userList) throws SQLException{
    Iterator users = userList.iterator();
    while (users.hasNext()) {
      User thisUser = (User)users.next();
      DataRecord thisRecord = mappings.createDataRecord(thisUser, "insert");
      thisRecord.removeField("enteredBy");
      thisRecord.removeField("contactId");
      thisRecord.removeField("roleId");
      thisRecord.removeField("managerId");
      thisRecord.removeField("assistant");
      thisRecord.removeField("alias"); 
      writer.save(thisRecord);
      
      UserList newUserList = new UserList();
      newUserList.setEnteredBy(thisUser.getId());
      newUserList.buildList(db);
      saveUserList(db, newUserList);
    }
  }
  private void saveOrgList(Connection db, OrganizationList orgList) throws SQLException {
          Iterator orgs = orgList.iterator();
        
            while (orgs.hasNext()) {
              Organization thisOrg = (Organization)orgs.next();
              DataRecord thisRecord = mappings.createDataRecord(thisOrg, "insert");
              writer.save(thisRecord);
              
              logger.info("ImportBaseData-> Inserting Organization Calls");
              
              CallList callList = new CallList();
              callList.setOrgId(thisOrg.getId());
              callList.buildList(db);
              Iterator calls = callList.iterator();
              
                      while(calls.hasNext()) {
                              Call thisCall = (Call)calls.next();
                              DataRecord anotherRecord = mappings.createDataRecord(thisCall, "insert");
                              writer.save(anotherRecord);
                      }
            }
  }
  
  private void saveContactList(Connection db, ContactList contactList) throws SQLException {
          Iterator contacts = contactList.iterator();
        
            while (contacts.hasNext()) {
              Contact thisContact = (Contact)contacts.next();
              DataRecord thisRecord = mappings.createDataRecord(thisContact, "insert");
              writer.save(thisRecord);
              
              CallList callList = new CallList();
              callList.setContactId(thisContact.getId());
              callList.buildList(db);
              
              logger.info("ImportBaseData-> Inserting Contact Calls (" + callList.size() + ")");
              
              Iterator calls = callList.iterator();
              
                      while(calls.hasNext()) {
                              Call thisCall = (Call)calls.next();
                              DataRecord anotherRecord = mappings.createDataRecord(thisCall, "insert");
                              writer.save(anotherRecord);
                      }
              
            }
  }
  
}

