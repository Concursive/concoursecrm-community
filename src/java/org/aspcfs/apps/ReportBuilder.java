package com.darkhorseventures.apps;

import java.sql.*;
import java.util.Vector;
import java.util.Iterator;
import java.io.*;
import java.net.*;
import com.darkhorseventures.utils.*;
import com.darkhorseventures.cfsbase.*;

public class ReportBuilder {
  
  protected java.util.Date start = new java.util.Date();  
  protected StringBuffer output = new StringBuffer(); 
  protected String baseName = "";
  protected String dbUser = "";
  protected String dbPass = "";
  protected int totalRecords = 0;
  
  protected String getIP() {
    String tmp = "";
    try { 
      InetAddress localaddr = InetAddress.getLocalHost(); 
      tmp = localaddr.getHostAddress();
    } catch ( UnknownHostException e ) { 
    }
    return tmp;
  }
  
  protected String getHostName() {
    String tmp = "";
    try { 
      InetAddress localaddr = InetAddress.getLocalHost(); 
      tmp = localaddr.getHostName();
    } catch ( UnknownHostException e ) { 
    }
    if (tmp.indexOf(".") == -1) {
      tmp += ".darkhorseventures.com";
    }
    return tmp;
  }
  
  protected void sendReport(Connection db, String flag, StringBuffer output) throws SQLException {
    //Get list of recipients...
    
    UserList userList = new UserList();
    //need to set criteria here... otherwise sent to all!
    userList.setBuildContact(true);
    userList.buildList(db);
    Iterator i = userList.iterator();
    StringBuffer log = new StringBuffer();
    
    while (i.hasNext()) {
      User thisUser = (User)i.next();
      if (thisUser.getContact().getEmailAddress("Work").indexOf("@") > 0) {
        //Send the report
        SMTPMessage mail = new SMTPMessage();
        mail.setHost("127.0.0.1");
        mail.setFrom(baseName + "@" + this.getHostName());
        mail.addTo(thisUser.getContact().getEmailAddress("Work"));
        mail.setSubject("Report [1 day: " + totalRecords + " record" + ((totalRecords != 1)?"s":"") + "]");
        mail.setBody(output.toString());
        mail.setType("text/html");
        if (mail.send() == 2) {
          log.append("Send error: " + mail.getErrorMsg() + "<br><br>");
          System.err.println("ReportBuilder Error: Report could not be sent");
          System.err.println(mail.getErrorMsg());
        }
      }
    }
    
    //Send the log
    SMTPMessage mail = new SMTPMessage();
    mail.setHost("mail.darkhorseventures.com");
    mail.setFrom("notifier_error@" + this.getHostName());
    mail.addTo("mrajkowski@darkhorseventures.com");
    mail.addTo("chris@darkhorseventures.com");
    mail.setSubject("Report [1 day: " + totalRecords + " record" + ((totalRecords != 1)?"s":"") + "]");
    mail.setBody("Emails generated: " + userList.size() + "<br><br>" + log.toString());
    mail.setType("text/html");
    if (mail.send() == 2) {
      System.err.println("ReportBuilder Error: Report could not be sent");
      System.err.println(mail.getErrorMsg());
    }
    
    
  }
  
  protected void sendAdminReport(String exc) {
    SMTPMessage mail = new SMTPMessage();
    mail.setHost("mail.darkhorseventures.com");
    mail.setFrom("notifier_error@" + getHostName());
    mail.addTo("mrajkowski@darkhorseventures.com");
    mail.addTo("chris@darkhorseventures.com");
    mail.setSubject("Admin Alert");
    mail.setBody("<PRE>Any Errors Follow:<br>" + exc.toString() + "</PRE>");
    mail.setType("text/html");
    if (mail.send() == 2) {
      System.err.println("ReportBuilder Error: Mail could not be sent");
      System.err.println(mail.getErrorMsg());
    }
  }
}
