package org.aspcfs.modules.components;

import org.aspcfs.apps.workFlowManager.ComponentContext;
import org.aspcfs.modules.base.Notification;
import org.aspcfs.utils.StringUtils;
import java.sql.*;
import org.aspcfs.modules.admin.base.User;
import org.aspcfs.modules.contacts.base.Contact;
import java.util.*;

public class EmailDigestUtil {

  /**
   *  This method separates out one or more specified email addresses in which a
   *  message will be associated with and eventually sent to.
   *
   *@param  mailList  Description of the Parameter
   *@param  emails    Description of the Parameter
   *@param  message   Description of the Parameter
   *@param  prefix    Description of the Parameter
   */
  public static void appendEmailAddresses(HashMap mailList, String emails, String message, String prefix) {
    if (emails != null) {
      if (emails.indexOf(",") > -1) {
        //multiple
        StringTokenizer st = new StringTokenizer(emails, ",");
        while (st.hasMoreTokens()) {
          String thisEmail = st.nextToken();
          addMessage(mailList, thisEmail.trim(), message, prefix);
        }
      } else {
        //single
        addMessage(mailList, emails, message, prefix);
      }
    }
  }


  /**
   *  This method separates out one or more specified user ids, looks up the
   *  contact record, gets the email address in which a message will be
   *  associated with and eventually sent to.
   *
   *@param  db                Description of the Parameter
   *@param  mailList          Description of the Parameter
   *@param  userIds           Description of the Parameter
   *@param  message           Description of the Parameter
   *@param  prefix            Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public static void appendEmailUsers(Connection db, HashMap mailList, String userIds, String message, String prefix) throws SQLException {
    if (userIds != null) {
      if (userIds.indexOf(",") > -1) {
        //multiple
        StringTokenizer st = new StringTokenizer(userIds, ",");
        while (st.hasMoreTokens()) {
          String thisId = st.nextToken();
          int id = -1;
          try {
            id = Integer.parseInt(thisId);
          } catch (Exception e) {
          }
          if (id > -1) {
            User thisUser = new User(db, id);
            thisUser.setBuildContact(true);
            thisUser.setBuildContactDetails(true);
            thisUser.buildResources(db);
            addMessage(mailList, thisUser.getContact().getEmailAddress("Business"), message, prefix);
          }
        }
      } else {
        //single
        int id = -1;
        try {
          id = Integer.parseInt(userIds);
        } catch (Exception e) {
        }
        if (id > -1) {
          User thisUser = new User(db, id);
          thisUser.setBuildContact(true);
          thisUser.setBuildContactDetails(true);
          thisUser.buildResources(db);
          addMessage(mailList, thisUser.getContact().getEmailAddress("Business"), message, prefix);
        }
      }
    }
  }


  /**
   *  This method separates out one or more specified contact ids, looks up the
   *  contact record, gets the email address in which a message will be
   *  associated with and eventually sent to.
   *
   *@param  db                Description of the Parameter
   *@param  mailList          Description of the Parameter
   *@param  contactIds        Description of the Parameter
   *@param  message           Description of the Parameter
   *@param  prefix            Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public static void appendEmailContacts(Connection db, HashMap mailList, String contactIds, String message, String prefix) throws SQLException {
    if (contactIds != null) {
      if (contactIds.indexOf(",") > -1) {
        //multiple
        StringTokenizer st = new StringTokenizer(contactIds, ",");
        while (st.hasMoreTokens()) {
          String thisId = st.nextToken();
          int id = -1;
          try {
            id = Integer.parseInt(thisId);
          } catch (Exception e) {
          }
          if (id > -1) {
            Contact thisContact = new Contact(db, id);
            addMessage(mailList, thisContact.getEmailAddress("Business"), message, prefix);
          }
        }
      } else {
        //single
        int id = -1;
        try {
          id = Integer.parseInt(contactIds);
        } catch (Exception e) {
        }
        if (id > -1) {
          Contact thisContact = new Contact(db, id);
          addMessage(mailList, thisContact.getEmailAddress("Business"), message, prefix);
        }
      }
    }
  }


  /**
   *  Appends a message to the specified email address. Each email address
   *  receives a single email that can have multiple appended messages.
   *
   *@param  mailList      The feature to be added to the Message attribute
   *@param  emailAddress  The feature to be added to the Message attribute
   *@param  thisMessage   The feature to be added to the Message attribute
   *@param  prefix        The feature to be added to the Message attribute
   */
  public static void addMessage(HashMap mailList, String emailAddress, String thisMessage, String prefix) {
    if (emailAddress != null && thisMessage != null) {
      Map emailToList = (Map) mailList.get(emailAddress);
      if (emailToList == null) {
        emailToList = new LinkedHashMap();
        mailList.put(emailAddress, emailToList);
      }
      emailToList.put(prefix, thisMessage);
    }
  }
  
  public static void sendMail(ComponentContext context, HashMap mailList) {
    //Process the HashMap and send emails
    Iterator toList = mailList.keySet().iterator();
    while (toList.hasNext()) {
      //Create a new notification directly, configure, and execute
      StringBuffer messageDigest = new StringBuffer();
      String emailAddressTo = (String) toList.next();
      Map emailToList = (Map) mailList.get(emailAddressTo);
      Iterator messages = emailToList.values().iterator();
      while (messages.hasNext()) {
        messageDigest.append((String) messages.next());
      }
      Notification thisNotification = new Notification();
      thisNotification.setSubject(StringUtils.toHtml(context.getParameter(SendUserNotification.SUBJECT)));
      String from = StringUtils.toHtmlValue(context.getParameter(SendUserNotification.FROM));
      if (from != null && !"".equals(from)) {
        thisNotification.setFrom(from);
      } else {
        thisNotification.setFrom(context.getParameter("EMAILADDRESS"));
      }
      thisNotification.setType(Notification.EMAIL);
      thisNotification.setEmailToNotify(emailAddressTo);
      thisNotification.setMessageToSend(StringUtils.toHtml(context.getParameter(SendUserNotification.BODY) + messageDigest.toString()));
      String host = context.getParameter(SendUserNotification.HOST);
      if (host != null && !"".equals(host)) {
        thisNotification.setHost(host);
      } else {
        thisNotification.setHost(context.getParameter("MAILSERVER"));
      }
      thisNotification.notifyAddress();
    }
  }
}
