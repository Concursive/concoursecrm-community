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
package org.aspcfs.apps.transfer.reader.cfs;

import org.aspcfs.apps.transfer.DataRecord;
import org.aspcfs.apps.transfer.DataWriter;
import org.aspcfs.apps.transfer.reader.csvreader.CSVReader;
import org.aspcfs.modules.accounts.base.*;
import org.aspcfs.modules.contacts.base.*;
import org.aspcfs.utils.StringUtils;
import org.aspcfs.utils.formatter.AddressFormatter;
import org.aspcfs.utils.formatter.ContactNameFormatter;
import org.aspcfs.utils.formatter.EmailAddressFormatter;
import org.aspcfs.utils.formatter.PhoneNumberFormatter;

import java.io.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;

/**
 * Imports a list of contacts and account names into CFS Accounts, merging
 * contacts into existing Account names
 *
 * @author matt rajkowski
 * @version $Id: ImportAccountContacts.java,v 1.7 2004/06/16 17:24:53
 *          mrajkowski Exp $
 * @created June 9, 2003
 */
public class ImportAccountContacts extends CSVReader {

  private int KEY_CONTACT = 0;
  private int KEY_COMPANY = 0;
  private int OWNER = 0;
  private int NAME_SALUTATION = 0;
  private int CONTACT_NAME = 0;
  private int FIRST_NAME = 0;
  private int MIDDLE_NAME = 0;
  private int LAST_NAME = 0;
  private int SUFFIX = 0;
  private int COMPANY_NAME = 0;
  private int TITLE = 0;
  private int BUSINESS_ADDRESS_1 = 0;
  private int BUSINESS_ADDRESS_2 = 0;
  private int BUSINESS_ADDRESS_3 = 0;
  private int BUSINESS_CITY = 0;
  private int BUSINESS_STATE = 0;
  private int BUSINESS_ZIP = 0;
  private int BUSINESS_COUNTRY = 0;
  private int HOME_ADDRESS_1 = 0;
  private int HOME_ADDRESS_2 = 0;
  private int HOME_ADDRESS_3 = 0;
  private int HOME_CITY = 0;
  private int HOME_STATE = 0;
  private int HOME_ZIP = 0;
  private int HOME_COUNTRY = 0;
  private int BUSINESS_PHONE = 0;
  private int BUSINESS_PHONE_EXT = 0;
  private int BUSINESS_2_PHONE = 0;
  private int BUSINESS_FAX = 0;
  private int HOME_PHONE = 0;
  private int HOME_2_PHONE = 0;
  private int HOME_FAX = 0;
  private int MOBILE_PHONE = 0;
  private int OTHER_PHONE = 0;
  private int PAGER = 0;
  private int BUSINESS_EMAIL = 0;
  private int PERSONAL_EMAIL = 0;
  private int OTHER_EMAIL = 0;
  private int NOTES = 0;
  private int MODIFIED = 0;
  private int ENTERED = 0;
  private int LIST_SALUTATION = 0;
  private int SITE_ID = 0;
  private int NO_EMAIL = 0;
  private int NO_MAIL = 0;
  private int CONTACT_SOURCE = 0;
  private int TYPE_ID = 0;
  private int CLIENT_ID = 0;
  private int DEPARTMENT = 0;
  private int EMPLOYEES = 0;


  /**
   * Gets the version attribute of the ImportAccounts object
   *
   * @return The version value
   */
  public double getVersion() {
    return 1.0d;
  }


  /**
   * Gets the name attribute of the ImportAccounts object
   *
   * @return The name value
   */
  public String getName() {
    return "Centric CRM Account Contacts Importer";
  }


  /**
   * Gets the description attribute of the ImportAccounts object
   *
   * @return The description value
   */
  public String getDescription() {
    return "Reads contacts from a text file based on specifications";
  }


  /**
   * A required method which actually performs the processing of reading
   * contact records.
   *
   * @param writer Description of the Parameter
   * @return Description of the Return Value
   */
  public boolean execute(DataWriter writer) {
    boolean processOK = true;

    try {
      PrintWriter out = new PrintWriter(
          new BufferedWriter(new FileWriter("import.out", false)));

      //Create a new invisible user who will import these records (enterdBy) so
      //that records can be backed out if necessary
      //TODO: create user record
      int userId = 1;
      int contactId = 1;
      int orgId = 1;
      Map organizationMap = new HashMap();

      //Create the user, associated with the contact
      DataRecord newUserRecord = new DataRecord();
      newUserRecord.setName("user");
      newUserRecord.setAction("insert");
      newUserRecord.addField("guid", userId);
      newUserRecord.addField("username", "Electronic Import");
      //newUserRecord.addField("contactId", contactId, "contact", null);
      newUserRecord.addField("encryptedPassword", "none");
      newUserRecord.addField("enteredBy", userId);
      newUserRecord.addField("modifiedBy", userId);
      writer.save(newUserRecord);

      //Need a new contact
      DataRecord newContactRecord = new DataRecord();
      newContactRecord.setName("contact");
      newContactRecord.setAction("insert");
      newContactRecord.addField("guid", contactId);
      newContactRecord.addField("accessType", "2");
      newContactRecord.addField("userId", userId, "user", null);
      newContactRecord.addField("nameFirst", "");
      newContactRecord.addField("nameLast", "Electronic Import");
      newContactRecord.addField("orgId", "0");
      newContactRecord.addField("enteredBy", userId);
      newContactRecord.addField("modifiedBy", userId);
      newContactRecord.addField("enabled", "false");
      writer.save(newContactRecord);
      //Prepare the formatters
      AddressFormatter addressFormatter = new AddressFormatter();
      EmailAddressFormatter emailFormatter = new EmailAddressFormatter();
      PhoneNumberFormatter phoneFormatter = new PhoneNumberFormatter();
      ContactNameFormatter contactNameFormatter = new ContactNameFormatter();

      //Parse the text file
      BufferedReader in = new BufferedReader(new FileReader(csvFile));
      String line = null;
      int lineNumber = 0;
      while ((line = in.readLine()) != null) {
        ++lineNumber;
        //For each line use the parseExcelCSVLine method to get a record
        ArrayList thisRecord = new ArrayList(
            StringUtils.parseExcelCSVLine(line));
        if (lineNumber == 1) {
          //Process the column mappings
          OWNER = findColumn(thisRecord, new String[]{"OWNER", "Owner"});
          NAME_SALUTATION = findColumn(
              thisRecord, new String[]{"NAME_SALUTATION", "Salutation"});
          CONTACT_NAME = findColumn(
              thisRecord, new String[]{"CONTACT", "Contact"});
          FIRST_NAME = findColumn(
              thisRecord, new String[]{"FIRST_NAME", "FirstName", "First Name"});
          MIDDLE_NAME = findColumn(
              thisRecord, new String[]{"MIDDLE_NAME", "Middle Name"});
          LAST_NAME = findColumn(
              thisRecord, new String[]{"LAST_NAME", "LastName", "Last Name"});
          SUFFIX = findColumn(thisRecord, new String[]{"SUFFIX", "Suffix"});
          COMPANY_NAME = findColumn(
              thisRecord, new String[]{"COMPANY_NAME", "Company", "Company Name", "Account Name"});
          TITLE = findColumn(thisRecord, new String[]{"TITLE", "Title"});
          BUSINESS_ADDRESS_1 = findColumn(
              thisRecord, new String[]{"BUSINESS_ADDRESS_1", "Business Address Line 1", "Mailing Street"});
          BUSINESS_ADDRESS_2 = findColumn(
              thisRecord, new String[]{"BUSINESS_ADDRESS_2", "Business Address Line 2", "Mailing Address Line2"});
          BUSINESS_ADDRESS_3 = findColumn(
              thisRecord, new String[]{"BUSINESS_ADDRESS_3", "Business Address Line 3", "Mailing Address Line3"});
          BUSINESS_CITY = findColumn(
              thisRecord, new String[]{"BUSINESS_CITY", "BusinessCity", "Business City", "Mailing City"});
          BUSINESS_STATE = findColumn(
              thisRecord, new String[]{"BUSINESS_STATE", "Business State", "Business State/Province", "Mailing State"});
          BUSINESS_ZIP = findColumn(
              thisRecord, new String[]{"BUSINESS_ZIP", "Business Zip", "Business Postal Code", "Mailing Zip/Postal Code"});
          BUSINESS_COUNTRY = findColumn(
              thisRecord, new String[]{"BUSINES_COUNTRY", "Business Country", "Mailing Country"});
          HOME_ADDRESS_1 = findColumn(
              thisRecord, new String[]{"HOME_ADDRESS_1", "Home Address Line 1"});
          HOME_ADDRESS_2 = findColumn(
              thisRecord, new String[]{"HOME_ADDRESS_2", "Home Address Line 2"});
          HOME_ADDRESS_3 = findColumn(
              thisRecord, new String[]{"HOME_ADDRESS_3", "Home Address Line 3"});
          HOME_CITY = findColumn(
              thisRecord, new String[]{"HOME_CITY", "HomeCity", "Home City"});
          HOME_STATE = findColumn(
              thisRecord, new String[]{"HOME_STATE", "Home State/Province"});
          HOME_ZIP = findColumn(
              thisRecord, new String[]{"HOME_ZIP", "Home Postal Code"});
          HOME_COUNTRY = findColumn(
              thisRecord, new String[]{"HOME_COUNTRY", "Home Country"});
          BUSINESS_PHONE = findColumn(
              thisRecord, new String[]{"BUSINESS_PHONE", "BusinessPhone", "Business Phone", "Phone"});
          BUSINESS_PHONE_EXT = findColumn(
              thisRecord, new String[]{"BUSINESS_PHONE_EXT", "BusinessPhoneExt", "Business Phone Ext"});
          BUSINESS_2_PHONE = findColumn(
              thisRecord, new String[]{"BUSINESS_2_PHONE", "Business2 Phone"});
          BUSINESS_FAX = findColumn(
              thisRecord, new String[]{"BUSINESS_FAX", "BusinessFax", "Business Fax", "Fax"});
          HOME_PHONE = findColumn(
              thisRecord, new String[]{"HOME_HOME", "Home Phone"});
          HOME_2_PHONE = findColumn(
              thisRecord, new String[]{"HOME_2_PHONE", "Home2 Phone"});
          HOME_FAX = findColumn(
              thisRecord, new String[]{"HOME_FAX", "Home Fax"});
          MOBILE_PHONE = findColumn(
              thisRecord, new String[]{"MOBILE_PHONE", "Mobile Phone", "Mobile"});
          OTHER_PHONE = findColumn(
              thisRecord, new String[]{"OTHER_PHONE", "Other Phone"});
          PAGER = findColumn(thisRecord, new String[]{"PAGER", "Pager"});
          BUSINESS_EMAIL = findColumn(
              thisRecord, new String[]{"BUSINESS_EMAIL", "Business Email", "Email"});
          PERSONAL_EMAIL = findColumn(
              thisRecord, new String[]{"PERSONAL_EMAIL", "Home Email", "Personal Email"});
          OTHER_EMAIL = findColumn(
              thisRecord, new String[]{"OTHER_EMAIL", "Other Email"});
          NOTES = findColumn(thisRecord, new String[]{"NOTES", "Notes"});
          EMPLOYEES = findColumn(
              thisRecord, new String[]{"EMPLOYEES", "Employees"});
          MODIFIED = findColumn(thisRecord, new String[]{"DATE_MODIFIED", "Modified"});
          ENTERED = findColumn(thisRecord, new String[]{"DATE_ENTERED", "DATE_CREATED", "Entered"});
          LIST_SALUTATION = findColumn(thisRecord, new String[]{"LIST_SALUTATION"});
          SITE_ID = findColumn(thisRecord, new String[]{"SITE_ID"});
          NO_EMAIL = findColumn(thisRecord, new String[]{"NO_EMAIL"});
          NO_MAIL = findColumn(thisRecord, new String[]{"NO_MAIL"});
          CONTACT_SOURCE = findColumn(thisRecord, new String[]{"CONTACT_SOURCE"});
          TYPE_ID = findColumn(thisRecord, new String[]{"TYPE_ID","CONTACT_TYPE"});
          CLIENT_ID = findColumn(thisRecord, new String[]{"CLIENT_ID", "MARESA_CODE"});
          DEPARTMENT = findColumn(thisRecord, new String[]{"DEPARTMENT"});
          continue;
        }
        ++contactId;
        ++orgId;

        //Contact Record Fields first, then generate Account Record from Contact
        Contact thisContact = new Contact();
        ContactEmailAddressList emailAddressList = thisContact.getEmailAddressList();
        ContactPhoneNumberList phoneNumberList = thisContact.getPhoneNumberList();
        ContactAddressList addressList = thisContact.getAddressList();

        thisContact.setAccessType(2);
        thisContact.setId(contactId);
        if (getValue(thisRecord, KEY_CONTACT) != null) {
           thisContact.setId(getValue(thisRecord, KEY_CONTACT));
        } else {
           thisContact.setId(contactId);
        }
        thisContact.setEnteredBy(userId);
        if (OWNER > 0) {
          thisContact.setOwner(getValue(thisRecord, OWNER));
        } else {
          thisContact.setOwner(userId);
        }
        thisContact.setModified(getValue(thisRecord, MODIFIED));
        thisContact.setEntered(getValue(thisRecord, ENTERED));
        thisContact.setModifiedBy(userId);
        //Contact Fields
        thisContact.setNameSalutation(getValue(thisRecord, NAME_SALUTATION));

        // Simple parse to format a name, only supports one format
        if (CONTACT_NAME > 0) {
          contactNameFormatter.format(
              thisContact, getValue(thisRecord, CONTACT_NAME));
        } else {
          thisContact.setNameFirst(getValue(thisRecord, FIRST_NAME));
          thisContact.setNameMiddle(getValue(thisRecord, MIDDLE_NAME));
          thisContact.setNameLast(getValue(thisRecord, LAST_NAME));
          thisContact.setNameSuffix(getValue(thisRecord, SUFFIX));
        }
        thisContact.setCompany(getValue(thisRecord, COMPANY_NAME));
        thisContact.setOrgName(getValue(thisRecord, COMPANY_NAME));
        thisContact.setTitle(getValue(thisRecord, TITLE));
        String listSalutation = getValue(thisRecord, LIST_SALUTATION);
        if (listSalutation != null && !"".equals(listSalutation)) {
          thisContact.setListSalutation(listSalutation);
        }
        thisContact.setNoEmail(getValue(thisRecord, NO_EMAIL));
        thisContact.setNoMail(getValue(thisRecord, NO_MAIL));
        String source = getValue(thisRecord, CONTACT_SOURCE);
        if (source != null && !"".equals(source.trim())) {
          thisContact.setSource(source);
        }
        String type = getValue(thisRecord, TYPE_ID);
        if (type != null && !"".equals(type.trim())) {
          String[] types = new String [1];
          types[0] = type;
          thisContact.setTypeList(types);
        }
        String clientId = getValue(thisRecord, CLIENT_ID);
        if (clientId != null && !"".equals(clientId.trim())) {
          thisContact.setClientId(getValue(thisRecord, CLIENT_ID));
        }
        //thisContact.setTitle(getValue(thisRecord, DEPARTMENT));
        String site = getValue(thisRecord, SITE_ID);
        if (site != null && !"".equals(site.trim())) {
          thisContact.setSite(site);
        }          

        //ContactAddress Record Fields
        ContactAddress businessAddress = new ContactAddress();
        businessAddress.setContactId(contactId);
        businessAddress.setType(1);
        businessAddress.setEnteredBy(userId);
        businessAddress.setModifiedBy(userId);
        //ContactAddress Fields
        businessAddress.setStreetAddressLine1(
            getValue(thisRecord, BUSINESS_ADDRESS_1));
        businessAddress.setStreetAddressLine2(
            getValue(thisRecord, BUSINESS_ADDRESS_2));
        businessAddress.setStreetAddressLine3(
            getValue(thisRecord, BUSINESS_ADDRESS_3));
        businessAddress.setCity(getValue(thisRecord, BUSINESS_CITY));
        businessAddress.setState(getValue(thisRecord, BUSINESS_STATE));
        businessAddress.setZip(getValue(thisRecord, BUSINESS_ZIP));
        businessAddress.setCountry(getValue(thisRecord, BUSINESS_COUNTRY));
        if (businessAddress.isValid()) {
          addressFormatter.format(businessAddress);
          addressList.add(businessAddress);
        }

        //ContactAddress Record Fields
        ContactAddress homeAddress = new ContactAddress();
        homeAddress.setContactId(contactId);
        homeAddress.setType(2);
        homeAddress.setEnteredBy(userId);
        homeAddress.setModifiedBy(userId);
        //ContactAddress Fields
        homeAddress.setStreetAddressLine1(
            getValue(thisRecord, HOME_ADDRESS_1));
        homeAddress.setStreetAddressLine2(
            getValue(thisRecord, HOME_ADDRESS_2));
        homeAddress.setStreetAddressLine3(
            getValue(thisRecord, HOME_ADDRESS_3));
        homeAddress.setCity(getValue(thisRecord, HOME_CITY));
        homeAddress.setState(getValue(thisRecord, HOME_STATE));
        homeAddress.setZip(getValue(thisRecord, HOME_ZIP));
        homeAddress.setCountry(getValue(thisRecord, HOME_COUNTRY));
        if (homeAddress.isValid()) {
          addressFormatter.format(homeAddress);
          addressList.add(homeAddress);
        }

        //Determine the locale to be used for formatting
        Locale thisLocale = businessAddress.getLocale();
        if (thisLocale == null) {
          thisLocale = homeAddress.getLocale();
        }

        ContactPhoneNumber businessPhone = new ContactPhoneNumber();
        businessPhone.setContactId(contactId);
        businessPhone.setType(1);
        businessPhone.setEnteredBy(userId);
        businessPhone.setModifiedBy(userId);

        if (getValue(thisRecord, BUSINESS_PHONE_EXT) != null && !"".equals(
            getValue(thisRecord, BUSINESS_PHONE_EXT))) {
          businessPhone.setNumber(
              getValue(thisRecord, BUSINESS_PHONE) + " x" + getValue(
                  thisRecord, BUSINESS_PHONE_EXT));
        } else {
          businessPhone.setNumber(getValue(thisRecord, BUSINESS_PHONE));
        }
        if (businessPhone.isValid()) {
          phoneFormatter.format(businessPhone, thisLocale);
          phoneNumberList.add(businessPhone);
        }

        ContactPhoneNumber business2Phone = new ContactPhoneNumber();
        business2Phone.setContactId(contactId);
        business2Phone.setType(2);
        business2Phone.setEnteredBy(userId);
        business2Phone.setModifiedBy(userId);
        business2Phone.setNumber(getValue(thisRecord, BUSINESS_2_PHONE));
        if (business2Phone.isValid()) {
          phoneFormatter.format(business2Phone, thisLocale);
          phoneNumberList.add(business2Phone);
        }

        ContactPhoneNumber businessFax = new ContactPhoneNumber();
        businessFax.setContactId(contactId);
        businessFax.setType(3);
        businessFax.setEnteredBy(userId);
        businessFax.setModifiedBy(userId);
        businessFax.setNumber(getValue(thisRecord, BUSINESS_FAX));
        if (businessFax.isValid()) {
          phoneFormatter.format(businessFax, thisLocale);
          phoneNumberList.add(businessFax);
        }

        ContactPhoneNumber homePhone = new ContactPhoneNumber();
        homePhone.setContactId(contactId);
        homePhone.setType(4);
        homePhone.setEnteredBy(userId);
        homePhone.setModifiedBy(userId);
        homePhone.setNumber(getValue(thisRecord, HOME_PHONE));
        if (homePhone.isValid()) {
          phoneFormatter.format(homePhone, thisLocale);
          phoneNumberList.add(homePhone);
        }

        ContactPhoneNumber home2Phone = new ContactPhoneNumber();
        home2Phone.setContactId(contactId);
        home2Phone.setType(5);
        home2Phone.setEnteredBy(userId);
        home2Phone.setModifiedBy(userId);
        home2Phone.setNumber(getValue(thisRecord, HOME_2_PHONE));
        if (home2Phone.isValid()) {
          phoneFormatter.format(home2Phone, thisLocale);
          phoneNumberList.add(home2Phone);
        }

        ContactPhoneNumber homeFax = new ContactPhoneNumber();
        homeFax.setContactId(contactId);
        homeFax.setType(6);
        homeFax.setEnteredBy(userId);
        homeFax.setModifiedBy(userId);
        homeFax.setNumber(getValue(thisRecord, HOME_FAX));
        if (homeFax.isValid()) {
          phoneFormatter.format(homeFax, thisLocale);
          phoneNumberList.add(homeFax);
        }

        ContactPhoneNumber mobilePhone = new ContactPhoneNumber();
        mobilePhone.setContactId(contactId);
        mobilePhone.setType(7);
        mobilePhone.setEnteredBy(userId);
        mobilePhone.setModifiedBy(userId);
        mobilePhone.setNumber(getValue(thisRecord, MOBILE_PHONE));
        if (mobilePhone.isValid()) {
          phoneFormatter.format(mobilePhone, thisLocale);
          phoneNumberList.add(mobilePhone);
        }

        ContactPhoneNumber otherPhone = new ContactPhoneNumber();
        otherPhone.setContactId(contactId);
        otherPhone.setType(9);
        otherPhone.setEnteredBy(userId);
        otherPhone.setModifiedBy(userId);
        otherPhone.setNumber(getValue(thisRecord, OTHER_PHONE));
        if (otherPhone.isValid()) {
          phoneFormatter.format(otherPhone, thisLocale);
          phoneNumberList.add(otherPhone);
        }

        ContactPhoneNumber pager = new ContactPhoneNumber();
        pager.setContactId(contactId);
        pager.setType(8);
        pager.setEnteredBy(userId);
        pager.setModifiedBy(userId);
        pager.setNumber(getValue(thisRecord, PAGER));
        if (pager.isValid()) {
          phoneFormatter.format(pager, thisLocale);
          phoneNumberList.add(pager);
        }

        ContactEmailAddress businessEmail = new ContactEmailAddress();
        businessEmail.setContactId(contactId);
        businessEmail.setType(1);
        businessEmail.setEnteredBy(userId);
        businessEmail.setModifiedBy(userId);
        businessEmail.setEmail(getValue(thisRecord, BUSINESS_EMAIL));
        if (businessEmail.isValid()) {
          emailFormatter.format(businessEmail);
          emailAddressList.add(businessEmail);
        }

        ContactEmailAddress personalEmail = new ContactEmailAddress();
        personalEmail.setContactId(contactId);
        personalEmail.setType(2);
        personalEmail.setEnteredBy(userId);
        personalEmail.setModifiedBy(userId);
        personalEmail.setEmail(getValue(thisRecord, PERSONAL_EMAIL));
        if (personalEmail.isValid()) {
          emailFormatter.format(personalEmail);
          emailAddressList.add(personalEmail);
        }

        ContactEmailAddress otherEmail = new ContactEmailAddress();
        otherEmail.setContactId(contactId);
        otherEmail.setType(3);
        otherEmail.setEnteredBy(userId);
        otherEmail.setModifiedBy(userId);
        otherEmail.setEmail(getValue(thisRecord, OTHER_EMAIL));
        if (otherEmail.isValid()) {
          emailFormatter.format(otherEmail);
          emailAddressList.add(otherEmail);
        }

        thisContact.setNotes(getValue(thisRecord, NOTES));

        //Generate the Account Record from the Contact
        Organization thisOrganization = new Organization();
        OrganizationPhoneNumberList organizationNumberList = thisOrganization.getPhoneNumberList();
        OrganizationAddressList organizationAddressList = thisOrganization.getAddressList();

        thisOrganization.setEnteredBy(userId);
        if (OWNER > 0) {
          thisOrganization.setOwner(getValue(thisRecord, OWNER));
        } else {
          thisOrganization.setOwner(userId);
        }
        thisOrganization.setModifiedBy(userId);
        thisOrganization.setName(getValue(thisRecord, COMPANY_NAME));
        //Prevent duplicate account names by doing a lookup on the previous account names
        if (organizationMap.containsKey(thisOrganization.getName())) {
          thisOrganization.setOrgId(
              ((Integer) organizationMap.get(thisOrganization.getName())).intValue());
        } else {
          thisOrganization.setOrgId(orgId);
          organizationMap.put(
              thisOrganization.getName(), new Integer(
                  thisOrganization.getOrgId()));
        }
        thisOrganization.setEmployees(getValue(thisRecord, EMPLOYEES));

        //Business Phone
        OrganizationPhoneNumber organizationPhone = new OrganizationPhoneNumber();
        organizationPhone.setOrgId(thisOrganization.getOrgId());
        organizationPhone.setType(1);
        organizationPhone.setEnteredBy(userId);
        organizationPhone.setModifiedBy(userId);
        organizationPhone.setNumber(getValue(thisRecord, BUSINESS_PHONE));
        if (organizationPhone.isValid()) {
          phoneFormatter.format(organizationPhone, thisLocale);
          organizationNumberList.add(organizationPhone);
        }
        //Business Fax
        OrganizationPhoneNumber organizationFax = new OrganizationPhoneNumber();
        organizationFax.setOrgId(thisOrganization.getOrgId());
        organizationFax.setType(2);
        organizationFax.setEnteredBy(userId);
        organizationFax.setModifiedBy(userId);
        organizationFax.setNumber(getValue(thisRecord, BUSINESS_FAX));
        if (organizationFax.isValid()) {
          phoneFormatter.format(organizationFax, thisLocale);
          organizationNumberList.add(organizationFax);
        }
        //Business Address
        OrganizationAddress organizationAddress = new OrganizationAddress();
        organizationAddress.setOrgId(thisOrganization.getOrgId());
        organizationAddress.setType(1);
        organizationAddress.setEnteredBy(userId);
        organizationAddress.setModifiedBy(userId);
        //OrganizationAddress Fields
        organizationAddress.setStreetAddressLine1(
            getValue(thisRecord, BUSINESS_ADDRESS_1));
        organizationAddress.setStreetAddressLine2(
            getValue(thisRecord, BUSINESS_ADDRESS_2));
        organizationAddress.setStreetAddressLine3(
            getValue(thisRecord, BUSINESS_ADDRESS_3));
        organizationAddress.setCity(getValue(thisRecord, BUSINESS_CITY));
        organizationAddress.setState(getValue(thisRecord, BUSINESS_STATE));
        organizationAddress.setZip(getValue(thisRecord, BUSINESS_ZIP));
        organizationAddress.setCountry(getValue(thisRecord, BUSINESS_COUNTRY));
        if (organizationAddress.isValid()) {
          addressFormatter.format(organizationAddress);
          organizationAddressList.add(organizationAddress);
        }

        //Save all new records now
        if (thisOrganization.getOrgId() == orgId) {
          processOK = writer.save(
              mappings.createDataRecord(thisOrganization, "insert"));
          if (processOK) {
            //TODO: Insert address and phone
            processOK = mappings.saveList(
                writer, organizationAddressList, "insert");
            processOK = mappings.saveList(
                writer, organizationNumberList, "insert");
          }
        } else {
          processOK = true;
        }
        //If Account inserts OK, then save the Contact as an Account Contact
        if (processOK) {
          thisContact.setOrgId(thisOrganization.getOrgId());
          processOK = writer.save(
              mappings.createDataRecord(thisContact, "insert"));
          if (processOK) {
            processOK = mappings.saveList(writer, addressList, "insert");
            processOK = mappings.saveList(writer, phoneNumberList, "insert");
            processOK = mappings.saveList(writer, emailAddressList, "insert");
          }
        }
        writeln(out, thisRecord);
      }
      out.flush();
      out.close();
    } catch (Exception e) {
      logger.info("ImportAccounts-> Error: " + e.toString());
      e.printStackTrace(System.out);
      processOK = false;
    }
    return processOK;
  }
}

