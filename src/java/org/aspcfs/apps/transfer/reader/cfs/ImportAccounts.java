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

import org.apache.log4j.Logger;
import org.aspcfs.apps.transfer.DataRecord;
import org.aspcfs.apps.transfer.DataWriter;
import org.aspcfs.apps.transfer.reader.csvreader.CSVReader;
import org.aspcfs.modules.accounts.base.*;
import org.aspcfs.utils.StringUtils;
import org.aspcfs.utils.formatter.AddressFormatter;
import org.aspcfs.utils.formatter.EmailAddressFormatter;
import org.aspcfs.utils.formatter.PhoneNumberFormatter;

import java.io.*;
import java.util.ArrayList;
import java.util.Locale;

/**
 * Imports a list of accounts into the Accounts module
 *
 * @author matt rajkowski
 * @version $Id: ImportAccounts.java,v 1.2 2003/12/04 20:45:27 mrajkowski Exp
 *          $
 * @created November 17, 2003
 */
public class ImportAccounts extends CSVReader {
  
  private static final Logger logger = Logger.getLogger(org.aspcfs.apps.transfer.reader.cfs.ImportAccounts.class);

  //Column positions matching the file column number
  private int KEY_COMPANY = 0;
  private int OWNER = 0;
  private int COMPANY_NAME = 0;
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
  private int URL = 0;
  private int MODIFIED = 0;
  private int ENTERED = 0;
  private int SEGMENT_ID = 0;
  private int COMPANY_SIZE_ID = 0;
  private int DIRECT_BILL = 0;


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
    return "Centric CRM Accounts Importer";
  }


  /**
   * Gets the description attribute of the ImportAccounts object
   *
   * @return The description value
   */
  public String getDescription() {
    return "Reads accounts from a text file based on specifications";
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
      int userId = 1;
      int contactId = 1;
      int orgId = 1;

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

      //Parse the text file
      ArrayList thisRecord = null;
      BufferedReader in = new BufferedReader(new FileReader(csvFile));
      String line = null;
      int lineNumber = 0;
      while ((line = in.readLine()) != null) {
        ++lineNumber;
        //For each line use the parseExcelCSVLine method to get a record
        thisRecord = new ArrayList(
            StringUtils.parseExcelCSVLine(line));
        if (lineNumber == 1) {
          //Process the column mappings
          KEY_COMPANY = findColumn(thisRecord, new String[]{"KEY_COMPANY"});
          OWNER = findColumn(thisRecord, new String[]{"OWNER", "Owner"});
          COMPANY_NAME = findColumn(
              thisRecord, new String[]{"COMPANY_NAME", "Company", "Company Name", "Account Name"});
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
          URL = findColumn(thisRecord, new String[]{"URL", "WEB_ADDRESS"});
          MODIFIED = findColumn(
              thisRecord, new String[]{"DATE_MODIFIED", "Modified"});
          ENTERED = findColumn(
              thisRecord, new String[]{"DATE_ENTERED", "Entered"});
          SEGMENT_ID = findColumn(thisRecord, new String[]{"SEGMENT_ID"});
          COMPANY_SIZE_ID = findColumn(thisRecord, new String[]{"COMPANY_SIZE_ID"});
          DIRECT_BILL = findColumn(thisRecord, new String[]{"DIRECT_BILL"});
          continue;
        }
        ++orgId;

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
        thisOrganization.setModified(getValue(thisRecord, MODIFIED));
        thisOrganization.setEntered(getValue(thisRecord, ENTERED));
        thisOrganization.setName(getValue(thisRecord, COMPANY_NAME));
        thisOrganization.setNotes(getValue(thisRecord, NOTES));
        thisOrganization.setUrl(getValue(thisRecord, URL));
        if (getValue(thisRecord, SEGMENT_ID) != null) {
          thisOrganization.setSegmentId(getValue(thisRecord, SEGMENT_ID));
        }
        if (getValue(thisRecord, COMPANY_SIZE_ID) != null) {
          thisOrganization.setAccountSize(getValue(thisRecord, COMPANY_SIZE_ID));
        }
        if (getValue(thisRecord, DIRECT_BILL) != null) {
          thisOrganization.setDirectBill(getValue(thisRecord, DIRECT_BILL));
        }
        if (getValue(thisRecord, KEY_COMPANY) != null) {
          thisOrganization.setOrgId(getValue(thisRecord, KEY_COMPANY));
        } else {
          thisOrganization.setOrgId(orgId);
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
        //Determine the locale to be used for formatting
        Locale thisLocale = organizationAddress.getLocale();
        if (thisLocale == null) {
          thisLocale = organizationAddress.getLocale();
        }

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

        //Save all new records now
        processOK = writer.save(
            mappings.createDataRecord(thisOrganization, "insert"));
        boolean processOK2 = true;
        boolean processOK3 = true;
        if (processOK) {
          processOK2 = mappings.saveList(
              writer, organizationAddressList, "insert");
          processOK3 = mappings.saveList(
              writer, organizationNumberList, "insert");
        }
        if (!processOK || !processOK2 || !processOK3) {
          writeln(out, thisRecord);
        }
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

