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
    boolean contactOK = true;
    
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
    */
    
    logger.info("ImportBaseData-> Inserting accounts");
    writer.setAutoCommit(false);
    OrganizationList accounts = new OrganizationList();
    accounts.setShowMyCompany(true);
    accounts.setIncludeEnabled(-1);
    accounts.buildList(db);
    this.saveOrgList(db, accounts);
    
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
    */
    
    logger.info("ImportBaseData-> Inserting contacts");
    writer.setAutoCommit(false);
    ContactList contacts = new ContactList();
    contacts.setIncludeEnabled(-1);
    contacts.setPersonalId(-2);
    contacts.buildList(db);
    this.saveContactList(db, contacts);
    
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
  
  private void saveContactList(Connection db, ContactList contactList) throws SQLException{
    Iterator contacts = contactList.iterator();
    
    while (contacts.hasNext()) {
      Contact thisContact = (Contact)contacts.next();
      DataRecord thisRecord = mappings.createDataRecord(thisContact, "insert");
      writer.save(thisRecord);
      
      writer.commit();

      
      ContactEmailAddressList emailList = new ContactEmailAddressList();
      emailList.setContactId(thisContact.getId());
      emailList.buildList(db);
      
      logger.info("ImportBaseData-> Inserting " + emailList.size() + " Contact emails");
      
      Iterator emails = emailList.iterator();
      while (emails.hasNext()) {
              ContactEmailAddress thisAddress = (ContactEmailAddress)emails.next();
              DataRecord anotherRecord = mappings.createDataRecord(thisAddress, "insert");
              writer.save(anotherRecord);
              writer.commit();
      }
      
      ContactAddressList addressList = new ContactAddressList();
      addressList.setContactId(thisContact.getId());
      addressList.buildList(db);
      
      logger.info("ImportBaseData-> Inserting " + addressList.size() + " Contact addresses");
      
      Iterator addresses = addressList.iterator();
      while (addresses.hasNext()) {
              ContactAddress streetAddress = (ContactAddress)addresses.next();
              DataRecord addressRecord = mappings.createDataRecord(streetAddress, "insert");
              writer.save(addressRecord);
              writer.commit();
      }
      
      ContactPhoneNumberList phoneList = new ContactPhoneNumberList();
      phoneList.setContactId(thisContact.getId());
      phoneList.buildList(db);
      
      logger.info("ImportBaseData-> Inserting " + phoneList.size() + " Contact phone numbers");
      
      Iterator phones = phoneList.iterator();
      while (phones.hasNext()) {
              ContactPhoneNumber phone = (ContactPhoneNumber)phones.next();
              DataRecord phoneRecord = mappings.createDataRecord(phone, "insert");
              writer.save(phoneRecord);
              writer.commit();
      }
      
      
    }
  }
  
  private void saveOrgList(Connection db, OrganizationList orgList) throws SQLException{
    Iterator orgs = orgList.iterator();
    
    while (orgs.hasNext()) {
      Organization thisOrg = (Organization)orgs.next();
      DataRecord thisRecord = mappings.createDataRecord(thisOrg, "insert");
      writer.save(thisRecord);
      writer.commit();

      
      OrganizationEmailAddressList emailList = new OrganizationEmailAddressList();
      emailList.setOrgId(thisOrg.getId());
      emailList.buildList(db);
      
      logger.info("ImportBaseData-> Inserting " + emailList.size() + " Organization emails");
      
      Iterator emails = emailList.iterator();
      while (emails.hasNext()) {
              OrganizationEmailAddress thisAddress = (OrganizationEmailAddress)emails.next();
              DataRecord anotherRecord = mappings.createDataRecord(thisAddress, "insert");
              writer.save(anotherRecord);
              writer.commit();
      }
      
      /**
      ContactAddressList addressList = new ContactAddressList();
      addressList.setContactId(thisContact.getId());
      addressList.buildList(db);
      
      logger.info("ImportBaseData-> Inserting " + addressList.size() + " Contact addresses");
      
      Iterator addresses = addressList.iterator();
      while (addresses.hasNext()) {
              ContactAddress streetAddress = (ContactAddress)addresses.next();
              DataRecord addressRecord = mappings.createDataRecord(streetAddress, "insert");
              writer.save(addressRecord);
              writer.commit();
      }
      
      OrganizationPhoneNumberList phoneList = new OrganizationPhoneNumberList();
      phoneList.setOrgId(thisOrg.getId());
      phoneList.buildList(db);
      
      logger.info("ImportBaseData-> Inserting " + phoneList.size() + " Organization phone numbers");
      
      Iterator phones = phoneList.iterator();
      while (phones.hasNext()) {
              OrganizationPhoneNumber phone = (OrganizationPhoneNumber)phones.next();
              DataRecord phoneRecord = mappings.createDataRecord(phone, "insert");
              writer.save(phoneRecord);
              writer.commit();
      }
      
      */
    }
  }
  
}

