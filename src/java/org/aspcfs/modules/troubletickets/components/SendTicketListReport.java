//Copyright 2003 Dark Horse Ventures

package org.aspcfs.modules.troubletickets.components;

import org.aspcfs.controller.*;
import org.aspcfs.apps.workFlowManager.*;
import org.aspcfs.controller.objectHookManager.*;
import org.aspcfs.modules.troubletickets.base.*;
import org.aspcfs.modules.components.SendUserNotification;
import org.aspcfs.modules.components.EmailDigestUtil;
import java.util.*;
import java.sql.Connection;

/**
 *  Using a supplied ticket list, SendTicketListReport will compile the tickets
 *  and send notifications based on the process parameters.
 *
 *@author     matt rajkowski
 *@created    May 22, 2003
 *@version    $Id$
 */
public class SendTicketListReport extends ObjectHookComponent implements ComponentInterface {

  public final static String REPORT_TICKET_CONTENT = "report.ticket.content";
  private final static String PREFIX = "TICKET";


  /**
   *  Gets the description attribute of the SendTicketListReport object
   *
   *@return    The description value
   */
  public String getDescription() {
    return "Sends a ticket report to specified users with the specified parameters";
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public boolean execute(ComponentContext context) {
    if (!context.hasObjects()) {
      return false;
    }
    boolean result = false;
    Connection db = null;
    HashMap mailList = new HashMap();
    TicketList tickets = (TicketList) context.getObjects();
    try {
      db = this.getConnection(context);
      //Prepare the LoadTicketDetails component to load each ticket into the context
      LoadTicketDetails loadTicket = new LoadTicketDetails();
      Iterator i = tickets.iterator();
      while (i.hasNext()) {
        Ticket thisTicket = (Ticket) i.next();
        context.setThisObject(thisTicket);
        loadTicket.execute(context);
        //Determine the content of the message to send
        String thisMessage = context.getParameter(REPORT_TICKET_CONTENT, thisTicket, null);
        //emailTo gets all the messages
        EmailDigestUtil.appendEmailAddresses(mailList, context.getParameter(SendUserNotification.EMAIL_TO), thisMessage, PREFIX + thisTicket.getId());
        //Users: Lookup each user id specified
        EmailDigestUtil.appendEmailUsers(db, mailList, context.getParameter(SendUserNotification.USER_TO, thisTicket, null), thisMessage, PREFIX + thisTicket.getId());
        //Contacts: Lookup each contact id specified
        EmailDigestUtil.appendEmailContacts(db, mailList, context.getParameter(SendUserNotification.CONTACT_TO, thisTicket, null), thisMessage, PREFIX + thisTicket.getId());
        //Departments: Get list of enabled users in the specified department, lookup each user id
        //EmailDigestUtil.appendDepartmentContacts(db, mailList, context.getParameter(SendUserNotification.DEPARTMENT_TO, thisTicket, null), thisMessage, PREFIX + thisTicket.getId());
      }
      //Send the compiled messages
      EmailDigestUtil.sendMail(context, mailList);
      result = true;
    } catch (Exception e) {
      e.printStackTrace(System.out);
    } finally {
      this.freeConnection(context, db);
    }
    return result;
  }

}

