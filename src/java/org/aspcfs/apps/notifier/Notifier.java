package org.aspcfs.apps.notifier;

import java.sql.*;
import java.util.*;
import java.io.*;
import java.net.*;
import java.text.*;
import org.aspcfs.utils.*;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.admin.base.Usage;
import org.aspcfs.modules.communications.base.*;
import org.aspcfs.modules.contacts.base.*;
import org.aspcfs.modules.pipeline.base.*;
import org.aspcfs.modules.base.*;
import org.aspcfs.modules.actions.*;
import org.aspcfs.apps.ReportBuilder;
import javax.xml.parsers.*;
import org.w3c.dom.*;
import com.zeroio.iteam.base.*;
import java.util.*;
import java.util.zip.*;


/**
 *  Application that processes various kinds of Alerts in CFS, generating
 *  notifications for users.
 *
 *@author     matt rajkowski
 *@created    October 16, 2001
 *@version    $Id$
 */
public class Notifier extends ReportBuilder {

  private HashMap config = new HashMap();
  /**
   *  Description of the Field
   */
  public final static String fs = System.getProperty("file.separator");
  public final static String lf = System.getProperty("line.separator");


  /**
   *  Constructor for the Notifier object public Notifier() { } ** Starts the
   *  process. Processes all of the enabled sites in the database.
   *
   *@param  args  Description of Parameter
   */
  public static void main(String args[]) {

    Notifier thisNotifier = new Notifier();
    if (args[0] != null) {
      AppUtils.loadConfig(args[0], thisNotifier.config);
    } else {
      AppUtils.loadConfig("notifier.xml", thisNotifier.config);
    }

    System.out.println("Generating and sending reports... ");

    thisNotifier.baseName = (String) thisNotifier.config.get("GATEKEEPER.URL");
    thisNotifier.dbUser = (String) thisNotifier.config.get("GATEKEEPER.USER");
    thisNotifier.dbPass = (String) thisNotifier.config.get("GATEKEEPER.PASSWORD");

    if (thisNotifier.baseName.equals("debug")) {
      thisNotifier.sendAdminReport("Notifier manual sendmail test");
    } else {
      try {
        Class.forName((String) thisNotifier.config.get("GATEKEEPER.DRIVER"));

        ArrayList siteList = new ArrayList();

        Connection dbSites = DriverManager.getConnection(
            thisNotifier.baseName, thisNotifier.dbUser, thisNotifier.dbPass);
        PreparedStatement pstSites = dbSites.prepareStatement(
            "SELECT * " +
            "FROM sites " +
            "WHERE enabled = ? ");
        pstSites.setBoolean(1, true);
        ResultSet rsSites = pstSites.executeQuery();
        while (rsSites.next()) {
          HashMap siteInfo = new HashMap();
          siteInfo.put("sitecode", rsSites.getString("sitecode"));
          siteInfo.put("vhost", rsSites.getString("vhost"));
          siteInfo.put("host", rsSites.getString("dbhost"));
          siteInfo.put("name", rsSites.getString("dbname"));
          siteInfo.put("port", rsSites.getString("dbport"));
          siteInfo.put("user", rsSites.getString("dbuser"));
          siteInfo.put("password", rsSites.getString("dbpw"));
          siteInfo.put("driver", rsSites.getString("driver"));
          siteInfo.put("code", rsSites.getString("code"));
          siteList.add(siteInfo);
        }
        rsSites.close();
        pstSites.close();
        dbSites.close();

        Iterator i = siteList.iterator();
        while (i.hasNext()) {
          HashMap siteInfo = (HashMap) i.next();
          Class.forName((String) siteInfo.get("driver"));
          Connection db = DriverManager.getConnection(
              (String) siteInfo.get("host") + ":" +
              (String) siteInfo.get("port") + "/" +
              (String) siteInfo.get("name"),
              (String) siteInfo.get("user"),
              (String) siteInfo.get("password"));
          thisNotifier.baseName = (String) siteInfo.get("sitecode");

          System.out.println("Running Alerts...");
          thisNotifier.output.append(thisNotifier.buildOpportunityAlerts(db));
          //thisNotifier.output.append(thisNotifier.buildCallAlerts(db));
          thisNotifier.output.append(lf+lf+lf);

          System.out.println("Running Communications...");
          thisNotifier.output.append(thisNotifier.buildCommunications(db, siteInfo));
          thisNotifier.output.append(lf+lf+lf);

          db.close();
        }

        System.out.println(thisNotifier.output.toString());
        //thisNotifier.sendAdminReport(thisNotifier.output.toString());
        java.util.Date end = new java.util.Date();
      } catch (Exception exc) {
        System.out.println("Sending error email...");
        //thisNotifier.sendAdminReport(exc.toString());
        System.err.println("BuildReport Error: " + exc.toString());
        System.exit(2);
      }
      System.exit(0);
    }
  }


  /**
   *  Scans Opportunities for an Alert that is due today. The notification is
   *  stored so that repeat notifications are not sent.
   *
   *@param  db                Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   */
  private String buildOpportunityAlerts(Connection db) throws SQLException {
    Report thisReport = new Report();
    thisReport.setBorderSize(0);
    thisReport.addColumn("User");

    Calendar thisCalendar = Calendar.getInstance();

    OpportunityList thisList = new OpportunityList();
    java.sql.Date thisDate = new java.sql.Date(System.currentTimeMillis());
    thisDate = thisDate.valueOf(
        thisCalendar.get(Calendar.YEAR) + "-" +
        (thisCalendar.get(Calendar.MONTH) + 1) + "-" +
        thisCalendar.get(Calendar.DAY_OF_MONTH));
    System.out.println("Notifier-> " +
        thisCalendar.get(Calendar.YEAR) + "-" +
        (thisCalendar.get(Calendar.MONTH) + 1) + "-" +
        thisCalendar.get(Calendar.DAY_OF_MONTH));
    thisList.setAlertDate(thisDate);
    thisList.buildList(db);

    int notifyCount = 0;
    Iterator i = thisList.iterator();
    while (i.hasNext()) {
      Opportunity thisOpportunity = (Opportunity) i.next();
      System.out.println(thisOpportunity.toString());
      Notification thisNotification = new Notification();
      thisNotification.setHost((String) this.config.get("MailServer"));
      thisNotification.setUserToNotify(thisOpportunity.getOwner());
      thisNotification.setModule("Opportunities");
      thisNotification.setItemId(thisOpportunity.getId());
      thisNotification.setItemModified(thisOpportunity.getModified());
      if (thisNotification.isNew(db)) {
        System.out.println("Notifier-> ...it's new");
        thisNotification.setSiteCode(baseName);
        thisNotification.setSubject("CFS Opportunity: " + thisOpportunity.getDescription());
        thisNotification.setMessageToSend(
            "The following opportunity in CFS has an alert set: <br>" +
            "<br>" +
            thisOpportunity.getDescription() + "<br>");
        thisNotification.setType(Notification.EMAIL);
        thisNotification.setTypeText(Notification.EMAIL_TEXT);
        thisNotification.notifyUser(db);
        ++notifyCount;
      } else {
        System.out.println("Notifier-> ...it's old");
      }
      if (thisNotification.hasErrors()) {
        System.out.println("Notifier Error-> " + thisNotification.getErrorMessage());
      }
    }
    thisReport.setHeader("Opportunity Alerts Report for " + start.toString() + lf + "Total Records: " + notifyCount);
    return thisReport.getDelimited();
  }


  /**
   *  Processes a list of calls to see if any alerts are due today that haven't
   *  already been alerted.
   *
   *@param  db                Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   */
  private String buildCallAlerts(Connection db) throws SQLException {
    Report thisReport = new Report();
    thisReport.setBorderSize(0);
    thisReport.addColumn("User");

    Calendar thisCalendar = Calendar.getInstance();

    CallList thisList = new CallList();
    java.sql.Date thisDate = new java.sql.Date(System.currentTimeMillis());
    thisDate = thisDate.valueOf(
        thisCalendar.get(Calendar.YEAR) + "-" +
        (thisCalendar.get(Calendar.MONTH) + 1) + "-" +
        thisCalendar.get(Calendar.DAY_OF_MONTH));
    thisList.setAlertDate(thisDate);
    thisList.buildList(db);

    int notifyCount = 0;
    Iterator i = thisList.iterator();
    while (i.hasNext()) {
      Call thisCall = (Call) i.next();
      Notification thisNotification = new Notification();
      thisNotification.setHost((String) this.config.get("MailServer"));
      thisNotification.setUserToNotify(thisCall.getEnteredBy());
      thisNotification.setModule("Calls");
      thisNotification.setItemId(thisCall.getId());
      thisNotification.setItemModified(null);
      if (thisNotification.isNew(db)) {
        System.out.println("Notifier-> ...it's new");
        thisNotification.setSiteCode(baseName);
        thisNotification.setSubject(
            "Call Alert: " + thisCall.getSubject());
        thisNotification.setMessageToSend(
            "The following call in CFS has an alert set: <br>" +
            "<br>" +
            "Contact: " + thisCall.getContactName() + "<br>" +
            "<br>" +
            thisCall.getNotes() + "<br>" +
            "<br>");
        thisNotification.setType(Notification.EMAIL);
        thisNotification.setTypeText(Notification.EMAIL_TEXT);
        thisNotification.notifyUser(db);
        ++notifyCount;
      } else {
        System.out.println("Notifier-> ...it's old");
      }
      if (thisNotification.hasErrors()) {
        System.err.println("Notifier Error-> " + thisNotification.getErrorMessage());
      }
    }
    thisReport.setHeader("Opportunity Alerts Report for " + start.toString() + "<br>" + "Total Records: " + notifyCount);
    return thisReport.getDelimited();
  }


  /**
   *  Scans the Communications module to see if there are any recipients that
   *  need to be sent a message.
   *
   *@param  db             Description of Parameter
   *@param  siteInfo       Description of the Parameter
   *@return                Description of the Returned Value
   *@exception  Exception  Description of Exception
   */
  private String buildCommunications(Connection db, HashMap siteInfo) throws Exception {
    String dbName = (String) siteInfo.get("name");
    Report thisReport = new Report();
    thisReport.setBorderSize(0);
    thisReport.addColumn("Report");

    Calendar thisCalendar = Calendar.getInstance();

    System.out.print("Getting campaign list...");
    CampaignList thisList = new CampaignList();
    java.sql.Date thisDate = new java.sql.Date(System.currentTimeMillis());
    thisDate = thisDate.valueOf(
        thisCalendar.get(Calendar.YEAR) + "-" +
        (thisCalendar.get(Calendar.MONTH) + 1) + "-" +
        thisCalendar.get(Calendar.DAY_OF_MONTH));
    thisList.setActiveDate(thisDate);
    thisList.setActive(CampaignList.TRUE);
    thisList.setReady(CampaignList.TRUE);
    thisList.setEnabled(CampaignList.TRUE);
    thisList.buildList(db);
    System.out.println("...got the list: " + thisList.size() + " active");

    //Get this database's key
    String filePath = (String) config.get("FileLibrary") + fs + dbName + fs + "keys" + fs;
    File f = new File(filePath);
    f.mkdirs();
    PrivateString thisKey = new PrivateString(filePath + "survey.key");

    //Process each campaign that is active and not processed
    Iterator i = thisList.iterator();
    int notifyCount = 0;
    while (i.hasNext()) {
      System.out.println("  Getting campaign ...");
      //Lock the campaign so the user cannot cancel, and so that another process
      //does not execute this campaign
      Campaign thisCampaign = (Campaign) i.next();
      thisCampaign.setStatusId(Campaign.STARTED);
      if (thisCampaign.lockProcess(db) != 1) {
        continue;
      }
      //Now that the campaign is locked, process it
      int campaignCount = 0;
      int sentCount = 0;
      ArrayList faxLog = new ArrayList();
      ContactReport letterLog = new ContactReport();

      //Read the file attachments list, and copy into another FileItemList
      //with the clientFilename, and the server's filename for the notification
      FileItemList attachments = new FileItemList();
      FileItemList fileItemList = new FileItemList();
      fileItemList.setLinkModuleId(Constants.COMMUNICATIONS_FILE_ATTACHMENTS);
      fileItemList.setLinkItemId(thisCampaign.getId());
      fileItemList.buildList(db);
      System.out.println("  Campaign file attachments: " + fileItemList.size());
      Iterator files = fileItemList.iterator();
      while (files.hasNext()) {
        FileItem thisItem = (FileItem) files.next();
        FileItem actualItem = new FileItem();
        actualItem.setClientFilename(thisItem.getClientFilename());
        actualItem.setDirectory((String) config.get("FileLibrary") + fs + dbName + fs + "communications" + fs);
        actualItem.setFilename(thisItem.getFilename());
        actualItem.setSize(thisItem.getSize());
        attachments.add(actualItem);
      }

      //Load in the recipients
      System.out.println("  Getting recipient list ...");
      RecipientList recipientList = new RecipientList();
      recipientList.setCampaignId(thisCampaign.getId());
      recipientList.setHasNullSentDate(true);
      recipientList.setBuildContact(false);
      recipientList.buildList(db);

      //Generate a campaign run --> Information about when a campaign was processed
      int runId = -1;
      Iterator iList = recipientList.iterator();
      if (iList.hasNext()) {
        runId = thisCampaign.insertRun(db);
      } else {
        thisCampaign.setStatusId(Campaign.ERROR);
        thisCampaign.setStatus("No Recipients");
        thisCampaign.update(db);
      }
      //Send each recipient a message
      while (iList.hasNext()) {
        ++campaignCount;
        System.out.println("  Getting contact ...");
        Recipient thisRecipient = (Recipient) iList.next();
        Contact thisContact = new Contact(db, thisRecipient.getContactId());

        Notification thisNotification = new Notification();
        thisNotification.setHost((String) this.config.get("MailServer"));
        thisNotification.setContactToNotify(thisContact.getId());
        thisNotification.setModule("Communications Manager");
        thisNotification.setDatabaseName(dbName);
        thisNotification.setItemId(thisCampaign.getId());
        thisNotification.setFileAttachments(attachments);
        //thisNotification.setItemModified(thisCampaign.getActiveDate());
        if (thisNotification.isNew(db)) {
          System.out.println("Sending message ...");
          thisNotification.setFrom(thisCampaign.getReplyTo());
          thisNotification.setSubject(thisCampaign.getSubject());
          thisNotification.setMessageIdToSend(thisCampaign.getMessageId());
          //If a survey is attached, encode the url for this recipient
          Template template = new Template();
          template.setText(thisCampaign.getMessage());
          String value = template.getValue("surveyId");
          if (value != null) {
            template.addParseElement("${surveyId=" + value + "}", java.net.URLEncoder.encode(PrivateString.encrypt(thisKey.getKey(), "id=" + value + ",cid=" + thisContact.getId())));
          }
          //NOTE: The following items are the same as the ProcessMessage.java items
          template.addParseElement("${name}", StringUtils.toHtml(thisContact.getNameFirstLast()));
          template.addParseElement("${firstname}", StringUtils.toHtml(thisContact.getNameFirst()));
          template.addParseElement("${lastname}", StringUtils.toHtml(thisContact.getNameLast()));
          template.addParseElement("${company}", StringUtils.toHtml(thisContact.getCompany()));
          template.addParseElement("${department}", StringUtils.toHtml(thisContact.getDepartmentName()));
          thisNotification.setMessageToSend(template.getParsedText());
          thisNotification.setType(thisCampaign.getSendMethodId());
          thisNotification.notifyContact(db);
          if (thisNotification.getType() == Notification.EMAIL) {
            Usage emailUsage = new Usage();
            emailUsage.setEnteredBy(thisCampaign.getModifiedBy());
            emailUsage.setAction(Constants.USAGE_COMMUNICATIONS_EMAIL);
            emailUsage.setRecordId(thisCampaign.getId());
            emailUsage.setRecordSize(thisNotification.getSize());
            emailUsage.insert(db);
          }
          if (thisNotification.getFaxLogEntry() != null) {
            faxLog.add(thisNotification.getFaxLogEntry() + "|" + thisCampaign.getEnteredBy() + "|" + thisCampaign.getId());
          } else if (thisNotification.getContact() != null) {
            letterLog.add(thisNotification.getContact());
          }
          ++notifyCount;
          ++sentCount;
          thisRecipient.setRunId(runId);
          thisRecipient.setSentDate(new java.sql.Timestamp(System.currentTimeMillis()));
          thisRecipient.setStatusDate(new java.sql.Timestamp(System.currentTimeMillis()));
          thisRecipient.setStatusId(1);
          thisRecipient.setStatus(thisNotification.getStatus());
          System.out.println("Notifier-> Notification status: " + thisNotification.getStatus());
          thisRecipient.update(db);
        } else {
          System.out.println("Notifier-> ...it's old");
        }
        if (thisNotification.hasErrors()) {
          System.out.println("Notifier Error-> " + thisNotification.getErrorMessage());
        }
      }
      if (campaignCount > 0) {
        outputLetterLog(thisCampaign, letterLog, dbName, db);
        outputFaxLog(faxLog, db, siteInfo);
        thisCampaign.setStatusId(Campaign.FINISHED);
        thisCampaign.setRecipientCount(campaignCount);
        thisCampaign.setSentCount(sentCount);
        thisCampaign.update(db);
      }
    }
    thisReport.setHeader("Communications Report for " + start.toString() + lf + "Total Records: " + notifyCount);
    return thisReport.getDelimited();
  }


  /**
   *  From a list of fax entries, a script is exported and executed to kick-off
   *  the fax process.
   *
   *@param  faxLog         Description of Parameter
   *@param  db             Description of the Parameter
   *@param  siteInfo       Description of the Parameter
   *@return                Description of the Returned Value
   *@exception  Exception  Description of the Exception
   */
  private boolean outputFaxLog(ArrayList faxLog, Connection db, HashMap siteInfo) throws Exception {
    System.out.println("Notifier-> Outputting fax log");
    if (faxLog == null || faxLog.size() == 0) {
      return false;
    }
    PrintWriter out = null;
    String baseDirectory = (String) config.get("BaseDirectory");
    if (baseDirectory != null && !baseDirectory.equals("")) {
      if (!baseDirectory.endsWith(fs)) {
        baseDirectory += fs;
      }
      File dir = new File(baseDirectory);
      dir.mkdirs();
    }
    SimpleDateFormat formatter1 = new SimpleDateFormat("yyyyMMddHHmmss");
    String uniqueScript = formatter1.format(new java.util.Date());
    try {
      out = new PrintWriter(new BufferedWriter(new FileWriter(baseDirectory + (String) config.get("BaseFilename") + uniqueScript + ".sh")));
      Iterator faxEntries = faxLog.iterator();
      while (faxEntries.hasNext()) {
        String uniqueId = formatter1.format(new java.util.Date());
        String thisEntry = (String) faxEntries.next();
        StringTokenizer st = new StringTokenizer(thisEntry, "|");
        String databaseName = st.nextToken();
        String messageId = st.nextToken();
        String faxNumber = st.nextToken();
        String contactId = null;
        if (st.hasMoreTokens()) {
          contactId = st.nextToken();
        }
        String enteredBy = null;
        if (st.hasMoreTokens()) {
          enteredBy = st.nextToken();
        }
        String recordId = null;
        if (st.hasMoreTokens()) {
          recordId = st.nextToken();
        }

        if (!"false".equals((String) config.get("FaxEnabled"))) {
          //Faxing is enabled
          String baseFilename = baseDirectory + (String) config.get("BaseFilename") + uniqueId + messageId + "-" + faxNumber;
          //Must escape the & for Linux shell script
          String url = "http://" + (String) siteInfo.get("vhost") + "/ProcessMessage.do?code=" + (String) siteInfo.get("code") + "\\&messageId=" + messageId + (contactId != null ? "\\&contactId=" + contactId : "");
          if (HTTPUtils.convertUrlToPostscriptFile(url, baseFilename) == 1) {
            continue;
          }
          if (ImageUtils.convertPostscriptToTiffG3File(baseFilename) == 1) {
            continue;
          }
          File psFile = new File(baseFilename + ".ps");
          psFile.delete();

          //TODO: Create a wrapper class for HylaFax to simplify and reuse this

          //Info for log file which can be parsed later and queried against HylaFax
          out.println("echo \"### SendFax Script, transcript in .log file\"");
          out.println("echo \"# database:" + databaseName + "\"");
          out.println("echo \"# campaignId:" + recordId + "\"");
          out.println("echo \"# enteredBy:" + enteredBy + "\"");
          out.println("echo \"# contactId:" + contactId + "\"");
          //Fax command -- only removes file if sendfax is successful
          out.println(
              "sendfax -n " +
              "-h " + (String) config.get("FaxServer") + " " +
              "-d " + faxNumber + " " +
              baseFilename + ".tiff > " + baseDirectory + (String) config.get("BaseFilename") + uniqueScript + ".log " +
              "&& rm " + baseFilename + ".tiff ");

          //Track usage
          //NOTE: Could add a URL post in the script to let the server know the file was actually faxed instead
          File faxFile = new File(baseFilename + ".tiff");
          if (faxFile.exists()) {
            Usage faxUsage = new Usage();
            faxUsage.setEnteredBy(Integer.parseInt(enteredBy));
            faxUsage.setAction(Constants.USAGE_COMMUNICATIONS_FAX);
            faxUsage.setRecordId(Integer.parseInt(recordId));
            faxUsage.setRecordSize(faxFile.length());
            faxUsage.insert(db);
          }
        }
      }
    } catch (IOException e) {
      e.printStackTrace(System.err);
      return false;
    } finally {
      if (out != null) {
        out.close();
      }
    }

    try {
      java.lang.Process process = java.lang.Runtime.getRuntime().exec(
          "/bin/sh " + baseDirectory + (String) config.get("BaseFilename") + uniqueScript + ".sh");
    } catch (Exception e) {
      e.printStackTrace(System.out);
    }

    return true;
  }


  /**
   *  Saves a list of contacts to a file and inserts a file reference in the
   *  database.
   *
   *@param  thisCampaign   Description of Parameter
   *@param  contactReport  Description of Parameter
   *@param  dbName         Description of Parameter
   *@param  db             Description of Parameter
   *@return                Description of the Returned Value
   *@exception  Exception  Description of Exception
   */
  private boolean outputLetterLog(Campaign thisCampaign, ContactReport contactReport, String dbName, Connection db) throws Exception {
    System.out.println("Notifier-> Outputting letter log");
    if (contactReport == null || contactReport.size() == 0) {
      return false;
    }
    String filePath = (String) config.get("FileLibrary") + fs + dbName + fs + "communications" + fs + "id" + thisCampaign.getId() + fs + CFSModule.getDatePath(new java.util.Date()) + fs;
    String baseFilename = contactReport.generateFilename();
    File f = new File(filePath);
    f.mkdirs();

    String[] fields = {"nameLast", "nameMiddle", "nameFirst", "company", "title", "department", "businessPhone", "businessAddress", "city", "state", "zip", "country"};
    contactReport.setCriteria(fields);
    contactReport.setFilePath(filePath);
    contactReport.setEnteredBy(0);
    contactReport.setModifiedBy(0);
    contactReport.setHeader("Communications mail merge");
    contactReport.buildReportBaseInfo();
    contactReport.buildReportHeaders();
    contactReport.buildReportData(null);
    CFSModule.saveTextFile(contactReport.getRep().getHtml(), filePath + baseFilename + ".html");

    //Stream communications data to Zip file
    ZipOutputStream zip = new ZipOutputStream(new FileOutputStream(filePath + baseFilename));
    ZipUtils.addTextEntry(zip, "contacts-" + baseFilename + ".csv", contactReport.getRep().getDelimited());

    //Get this database's key
    String keyFilePath = (String) config.get("FileLibrary") + fs + dbName + fs + "keys" + fs;
    File keys = new File(keyFilePath);
    keys.mkdirs();
    PrivateString thisKey = new PrivateString(keyFilePath + "survey.key");

    Template template = new Template();
    template.setText(thisCampaign.getMessage());
    String value = template.getValue("surveyId");
    if (value != null) {
      template.addParseElement("${surveyId=" + value + "}", java.net.URLEncoder.encode(PrivateString.encrypt(thisKey.getKey(), "id=" + value)));
    }
    ZipUtils.addTextEntry(zip, "letter-" + baseFilename + ".txt", template.getParsedText());
    zip.close();
    int fileSize = (int) (new File(filePath + baseFilename)).length();

    FileItem thisItem = new FileItem();
    thisItem.setLinkModuleId(Constants.COMMUNICATIONS);
    thisItem.setLinkItemId(thisCampaign.getId());
    thisItem.setEnteredBy(thisCampaign.getEnteredBy());
    thisItem.setModifiedBy(thisCampaign.getModifiedBy());
    thisItem.setSubject(thisCampaign.getName());
    thisItem.setClientFilename("cfs-" + baseFilename + ".zip");
    thisItem.setFilename(baseFilename);
    thisItem.setSize(fileSize);
    thisItem.insert(db);

    return true;
  }
}



