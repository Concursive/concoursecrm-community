package com.darkhorseventures.apps;

import java.sql.*;
import java.util.*;
import java.io.*;
import java.net.*;
import com.darkhorseventures.utils.*;
import com.darkhorseventures.cfsbase.*;

/**
 *  Application that processes various kinds of Alerts in CFS, generating
 *  notifications for users.
 *
 *@author     matt
 *@created    October 16, 2001
 *@version    $Id$
 */
public class Notifier extends ReportBuilder {	

  /**
   *  Constructor for the Notifier object
   *
   *@since
   */
  public Notifier() { }


  /**
   *  Scans Opportunities for an Alert that is due today. The notification is
   *  stored so that repeat notifications are not sent.
   *
   *@param  db                Description of Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   *@since
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
      Opportunity thisOpportunity = (Opportunity)i.next();
      System.out.println(thisOpportunity.toString());
      Notification thisNotification = new Notification();
      thisNotification.setUserToNotify(thisOpportunity.getOwner());
      thisNotification.setModule("Opportunities");
      thisNotification.setItemId(thisOpportunity.getId());
      thisNotification.setItemModified(thisOpportunity.getModifiedDate());
      if (thisNotification.isNew(db)) {
        System.out.println("Notifier-> ...it's new");
        thisNotification.setSiteCode(baseName);
        thisNotification.setSubject("CFS Opportunity: " + thisOpportunity.getDescription());
        thisNotification.setMessageToSend(
          "The following opportunity in CFS has an alert set: <br>" + 
          "<br>" +
          thisOpportunity.getDescription() + "<br>");
        thisNotification.setType(Notification.EMAIL);
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
      Call thisCall = (Call)i.next();
      Notification thisNotification = new Notification();
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
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   *@since
   */
  private String buildCommunications(Connection db) throws SQLException {
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

    Iterator i = thisList.iterator();
    int notifyCount = 0;
    while (i.hasNext()) {
      int campaignCount = 0;
      int sentCount = 0;
      System.out.println("  Getting campaign ...");
      Campaign thisCampaign = (Campaign)i.next();
      System.out.println("  Getting message ...");
      Message thisMessage = new Message(db, "" + thisCampaign.getMessageId());

      System.out.println("  Getting recipient list ...");
      RecipientList recipientList = new RecipientList();
      recipientList.setCampaignId(thisCampaign.getId());
      recipientList.setHasNullSentDate(true);
      recipientList.setBuildContact(false);
      recipientList.buildList(db);

      int runId = -1;
      Iterator iList = recipientList.iterator();
      if (iList.hasNext()) {
        thisCampaign.setStatusId(Campaign.STARTED);
        thisCampaign.setStatus(Campaign.STARTED_TEXT);
        thisCampaign.update(db);
        runId = thisCampaign.insertRun(db);
      } else {
        thisCampaign.setStatusId(Campaign.ERROR);
        thisCampaign.setStatus("No Recipients");
        thisCampaign.update(db);
      }
      while (iList.hasNext()) {
        ++campaignCount;
        System.out.println("  Getting contact ...");
        Recipient thisRecipient = (Recipient)iList.next();
        Contact thisContact = new Contact(db, "" + thisRecipient.getContactId());

        Notification thisNotification = new Notification();
        thisNotification.setContactToNotify(thisContact.getId());
        thisNotification.setModule("Communications Manager");
        thisNotification.setItemId(thisCampaign.getId());
        //thisNotification.setItemModified(thisCampaign.getActiveDate());
        if (thisNotification.isNew(db)) {
          System.out.println("Sending message ...");
          thisNotification.setFrom(thisMessage.getReplyTo());
          thisNotification.setSubject(thisMessage.getDescription());
          thisNotification.setMessageToSend(thisMessage.getMessageText());
          thisNotification.setType(Notification.EMAIL);
          thisNotification.notifyContact(db);
          ++notifyCount;
          ++sentCount;
          thisRecipient.setRunId(runId);
          thisRecipient.setSentDate(new java.sql.Timestamp(System.currentTimeMillis()));
          thisRecipient.setStatusDate(new java.sql.Timestamp(System.currentTimeMillis()));
          thisRecipient.setStatusId(1);
          thisRecipient.setStatus("Sent");
          thisRecipient.update(db);
        } else {
          System.out.println("Notifier-> ...it's old");
        }
        if (thisNotification.hasErrors()) {
          System.out.println("Notifier Error-> " + thisNotification.getErrorMessage());
        }
      }
      if (campaignCount > 0) {
        thisCampaign.setStatusId(Campaign.FINISHED);
        thisCampaign.setStatus(Campaign.FINISHED_TEXT);
        thisCampaign.update(db);
        thisCampaign.setRecipientCount(campaignCount);
        thisCampaign.setSentCount(sentCount);
      }
    }
    thisReport.setHeader("Communications Report for " + start.toString() + "<br>" + "Total Records: " + notifyCount);
    return thisReport.getHtml();
  }


  /**
   *  Starts the process. Processes all of the enabled sites in the database.
   *
   *@param  args  Description of Parameter
   *@since
   */
  public static void main(String args[]) {

    if (args.length < 3) {
      System.out.println("usage: Notifier SitesDatabaseUrl DatabaseUser DatabasePassword");
      return;
    }

    Notifier thisNotifier = new Notifier();

    System.out.println("Generating and sending reports... ");

    thisNotifier.baseName = args[0];
    thisNotifier.dbUser = args[1];
    thisNotifier.dbPass = args[2];

    try {
      Class.forName("org.postgresql.Driver");

      Vector siteList = new Vector();

      Connection dbSites = DriverManager.getConnection(
          thisNotifier.baseName, thisNotifier.dbUser, thisNotifier.dbPass);
      Statement stSites = dbSites.createStatement();
      ResultSet rsSites = stSites.executeQuery(
          "SELECT * " +
          "FROM sites " +
          "WHERE enabled = true ");
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

        Hashtable siteInfo = (Hashtable)i.next();
        Class.forName((String)siteInfo.get("driver"));
        Connection db = DriverManager.getConnection(
            (String)siteInfo.get("host") + ":" +
            (String)siteInfo.get("port") + "/" +
            (String)siteInfo.get("name"),
            (String)siteInfo.get("user"),
            (String)siteInfo.get("password"));
        thisNotifier.baseName = (String)siteInfo.get("sitecode");

        System.out.println("Running Alerts...");
        thisNotifier.output.append(thisNotifier.buildOpportunityAlerts(db));
        //thisNotifier.output.append(thisNotifier.buildCallAlerts(db));
        thisNotifier.output.append("<br><hr><br>");
        
        System.out.println("Running Communications...");
        thisNotifier.output.append(thisNotifier.buildCommunications(db));
        thisNotifier.output.append("<br><hr><br>");
        
        db.close();
      }
      
      System.out.println(thisNotifier.output.toString());
      //thisNotifier.sendAdminReport(thisNotifier.output.toString());
      java.util.Date end = new java.util.Date();
    } catch (Exception exc) {
      System.out.println("Sending error email...");
      thisNotifier.sendAdminReport(exc.toString());
      System.err.println("BuildReport Error: " + exc.toString());
    }
    System.exit(0);
  }

  /*
   *  private String buildReport1(Connection db) throws SQLException {
   *  /Customers LOS Passed
   *  String whereLosPassed =
   *  "WHERE org_id in " +
   *  " (SELECT DISTINCT org_id FROM location l, location_los los " +
   *  "  WHERE l.rec_id = los.location_id " +
   *  "  AND los.los_status = 2 " +
   *  "  AND los.date_completed >= CURRENT_TIMESTAMP - 1)";
   *  Report rep = new Report();
   *  rep.setBorderSize(0);
   *  rep.addColumn("Company");
   *  Customer ds2 = new Customer();
   *  Vector customerList = ds2.getCustomerList(db, whereLosPassed);
   *  rep.setHeader("LOS Passed Report for " + start.toString() + "<br>" + "Total Records: " + customerList.size());
   *  java.util.Iterator i = customerList.iterator();
   *  while (i.hasNext()) {
   *  Customer thisCustomer = (Customer)i.next();
   *  ReportRow thisRow = new ReportRow();
   *  thisRow.addCell(thisCustomer.getName());
   *  rep.addRow(thisRow);
   *  ++totalRecords;
   *  }
   *  return (rep.getHtml());
   *  }
   */
}

