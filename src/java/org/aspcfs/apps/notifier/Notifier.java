package com.darkhorseventures.apps;

import java.sql.*;
import java.util.*;
import java.io.*;
import java.net.*;
import java.text.*;
import com.darkhorseventures.utils.*;
import com.darkhorseventures.cfsbase.*;
import com.darkhorseventures.cfsmodule.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;
import org.xml.sax.SAXException;
import com.zeroio.iteam.base.*;
import java.util.*;
import java.util.zip.*;

/**
 *  Application that processes various kinds of Alerts in CFS, generating
 *  notifications for users.
 *
 *@author     matt
 *@created    October 16, 2001
 *@version    $Id$
 */
public class Notifier extends ReportBuilder {

  private HashMap config = new HashMap();
  public static final String fs = System.getProperty("file.separator");

  /**
   *  Constructor for the Notifier object public Notifier() { } ** Starts the
   *  process. Processes all of the enabled sites in the database.
   *
   *@param  args  Description of Parameter
   */
  public static void main(String args[]) {

    Notifier thisNotifier = new Notifier();
    AppUtils.loadConfig("notifier.xml", thisNotifier.config);

    System.out.println("Generating and sending reports... ");

    thisNotifier.baseName = (String) thisNotifier.config.get("GKHOST");
    thisNotifier.dbUser = (String) thisNotifier.config.get("GKUSER");
    thisNotifier.dbPass = (String) thisNotifier.config.get("GKUSERPW");

    if (thisNotifier.baseName.equals("debug")) {
      thisNotifier.sendAdminReport("Notifier manual sendmail test");
    } else {
      try {
        Class.forName((String) thisNotifier.config.get("DatabaseDriver"));

        Vector siteList = new Vector();

        Connection dbSites = DriverManager.getConnection(
            thisNotifier.baseName, thisNotifier.dbUser, thisNotifier.dbPass);
        Statement stSites = dbSites.createStatement();
        ResultSet rsSites = stSites.executeQuery(
            "SELECT * " +
            "FROM sites " +
            "WHERE enabled = " + DatabaseUtils.getTrue(dbSites));
        while (rsSites.next()) {
          Hashtable siteInfo = new Hashtable();
          siteInfo.put("driver", rsSites.getString("driver"));
          siteInfo.put("host", rsSites.getString("dbhost"));
          siteInfo.put("name", rsSites.getString("dbname"));
          siteInfo.put("port", rsSites.getString("dbport"));
          siteInfo.put("user", rsSites.getString("dbuser"));
          siteInfo.put("password", rsSites.getString("dbpw"));
          siteInfo.put("sitecode", rsSites.getString("sitecode"));
          siteList.add(siteInfo);
        }
        rsSites.close();
        stSites.close();
        dbSites.close();

        Iterator i = siteList.iterator();
        while (i.hasNext()) {

          Hashtable siteInfo = (Hashtable) i.next();
          Class.forName((String) siteInfo.get("driver"));
          Connection db = DriverManager.getConnection(
              (String) siteInfo.get("host") + ":" +
              (String) siteInfo.get("port") + "/" +
              (String) siteInfo.get("name"),
              (String) siteInfo.get("user"),
              (String) siteInfo.get("password"));
          thisNotifier.baseName = (String) siteInfo.get("sitecode");

          //TODO: Generate site XML for notifier
          //TODO: Check site XML for components to execute on this database connection
          
          System.out.println("Running Alerts...");
          thisNotifier.output.append(thisNotifier.buildOpportunityAlerts(db));
          //thisNotifier.output.append(thisNotifier.buildCallAlerts(db));
          thisNotifier.output.append("<br><hr><br>");

          System.out.println("Running Communications...");
          thisNotifier.output.append(thisNotifier.buildCommunications(db, (String) siteInfo.get("name")));
          thisNotifier.output.append("<br><hr><br>");

          db.close();
        }

        System.out.println(thisNotifier.output.toString());
        //thisNotifier.sendAdminReport(thisNotifier.output.toString());
        java.util.Date end = new java.util.Date();
      } catch (Exception exc) {
        System.out.println("Sending error email...");
        //thisNotifier.sendAdminReport(exc.toString());
        System.err.println("BuildReport Error: " + exc.toString());
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
    thisReport.setHeader("Opportunity Alerts Report for " + start.toString() + "<br>" + "Total Records: " + notifyCount);
    return thisReport.getHtml();
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
    return thisReport.getHtml();
  }


  /**
   *  Scans the Communications module to see if there are any recipients that
   *  need to be sent a message.
   *
   *@param  db                Description of Parameter
   *@param  dbName            Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  Exception     Description of Exception
   */
  private String buildCommunications(Connection db, String dbName) throws Exception {
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
      int campaignCount = 0;
      int sentCount = 0;
      Vector faxLog = new Vector();
      ContactReport letterLog = new ContactReport();
      System.out.println("  Getting campaign ...");
      Campaign thisCampaign = (Campaign) i.next();
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
        thisCampaign.setStatusId(Campaign.STARTED);
        thisCampaign.update(db);
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
        Contact thisContact = new Contact(db, "" + thisRecipient.getContactId());

        Notification thisNotification = new Notification();
        thisNotification.setHost((String) this.config.get("MailServer"));
        thisNotification.setContactToNotify(thisContact.getId());
        thisNotification.setModule("Communications Manager");
        thisNotification.setDatabaseName(dbName);
        thisNotification.setItemId(thisCampaign.getId());
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
            template.addParseElement("${surveyId=" + value + "}",  java.net.URLEncoder.encode(PrivateString.encrypt(thisKey.getKey(), "id=" + value + ",cid=" + thisContact.getId())));
          }
          template.addParseElement("${name}", StringUtils.toHtml(thisContact.getNameFirstLast()));
          template.addParseElement("${firstname}", StringUtils.toHtml(thisContact.getNameFirst()));
          template.addParseElement("${lastname}", StringUtils.toHtml(thisContact.getNameLast()));
          template.addParseElement("${company}", StringUtils.toHtml(thisContact.getCompany()));
          template.addParseElement("${department}", StringUtils.toHtml(thisContact.getDepartmentName()));
          thisNotification.setMessageToSend(template.getParsedText());
          //thisNotification.setMessageToSend(thisCampaign.getMessage());
          thisNotification.setType(thisCampaign.getSendMethodId());
          thisNotification.notifyContact(db);
          if (thisNotification.getFaxLogEntry() != null) {
            faxLog.add(thisNotification.getFaxLogEntry());
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
        outputFaxLog(faxLog);
        thisCampaign.setStatusId(Campaign.FINISHED);
        thisCampaign.update(db);
        thisCampaign.setRecipientCount(campaignCount);
        thisCampaign.setSentCount(sentCount);
      }
    }
    thisReport.setHeader("Communications Report for " + start.toString() + "<br>" + "Total Records: " + notifyCount);
    return thisReport.getHtml();
  }

  /**
   *  From a list of fax entries, a script is exported and executed to kick-off
   *  the fax process.
   *
   *@param  faxLog  Description of Parameter
   *@return         Description of the Returned Value
   */
  private boolean outputFaxLog(Vector faxLog) {
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
    SimpleDateFormat formatter1 = new SimpleDateFormat("yyyyMMddhhmmss");
    String uniqueScript = formatter1.format(new java.util.Date());
    try {
      out = new PrintWriter(new BufferedWriter(new FileWriter(baseDirectory + (String) config.get("BaseFilename") + uniqueScript + ".sh")));
      Iterator faxEntries = faxLog.iterator();
      while (faxEntries.hasNext()) {
        String thisEntry = (String) faxEntries.next();
        StringTokenizer st = new StringTokenizer(thisEntry, "|");
        String databaseName = st.nextToken();
        String messageId = st.nextToken();
        String faxNumber = st.nextToken();
        String uniqueId = formatter1.format(new java.util.Date());

        String baseFilename = baseDirectory + (String) config.get("BaseFilename") + uniqueId + messageId + "-" + faxNumber;
        out.println("perl /usr/local/bin/html2ps -o " + baseFilename + ".ps http://" + (String) config.get("CFSWebServer") + "/ProcessMessage.do?id=" + databaseName + "\\|" + messageId + " >/dev/null 2>&1");
        out.println("gs -q -sDEVICE=tiffg4 -dNOPAUSE -dBATCH -sOutputFile=" + baseFilename + ".tiff " + baseFilename + ".ps");
        out.println("rm " + baseFilename + ".ps");

        if (!"false".equals((String) config.get("FaxEnabled"))) {
          out.println("sendfax -n -h " + (String) config.get("FaxServer") + " -d " + faxNumber + " " + baseFilename + ".tiff");
        }
        out.println("rm " + baseFilename + ".tiff");
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
      java.lang.Process process = java.lang.Runtime.getRuntime().exec("/bin/sh " + baseDirectory + "cfsfax" + uniqueScript + ".sh");
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

