<%-- 
  - Copyright(c) 2004 Concursive Corporation (http://www.concursive.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Concursive Corporation. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. CONCURSIVE
  - CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL CONCURSIVE CORPORATION OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.utils.web.*, org.aspcfs.modules.troubletickets.base.*,org.aspcfs.modules.tasks.base.*, org.aspcfs.modules.base.EmailAddress" %>
<jsp:useBean id="ticketDetails" class="org.aspcfs.modules.troubletickets.base.Ticket" scope="request"/>
<jsp:useBean id="maintenanceDetails" class="org.aspcfs.modules.troubletickets.base.TicketMaintenanceNote" scope="request"/>
<jsp:useBean id="onsiteModelList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/images.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/tasks.js"></SCRIPT>
<SCRIPT language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<form name="details" action="TroubleTicketMaintenanceNotes.do?command=Modify&id=<%=ticketDetails.getId()%>&formId=<%=maintenanceDetails.getId()%>&return=view" method="post">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="TroubleTickets.do?"><dhv:label name="tickets.helpdesk">Help Desk</dhv:label></a> > 
<% if ("yes".equals((String)session.getAttribute("searchTickets"))) {%>
  <a href="TroubleTickets.do?command=SearchTicketsForm"><dhv:label name="tickets.searchForm">Search Form</dhv:label></a> >
  <a href="TroubleTickets.do?command=SearchTickets"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
<%}else{%> 
  <a href="TroubleTickets.do?command=Home"><dhv:label name="tickets.view">View Tickets</dhv:label></a> >
<%}%>
<a href="TroubleTickets.do?command=Details&id=<%= ticketDetails.getId() %>"><dhv:label name="tickets.details">Ticket Details</dhv:label></a> >
<a href="TroubleTicketMaintenanceNotes.do?command=List&id=<%=ticketDetails.getId()%>"><dhv:label name="tickets.maintenancenotes.long_html">Maintenance Notes</dhv:label></a> >
<dhv:label name="ticket.viewMaintenanceNote">View Maintenance Note</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<% String param1 = "id=" + ticketDetails.getId(); %>
<dhv:container name="tickets" selected="maintenancenotes" object="ticketDetails" param="<%= param1 %>">
  <%@ include file="ticket_header_include.jsp" %>
  <dhv:permission name="tickets-maintenance-report-edit">
    <input type="submit" value="<dhv:label name="global.button.modify">Modify</dhv:label>" />
  </dhv:permission>
  <dhv:permission name="tickets-maintenance-report-delete">
    <input type="button" value="<dhv:label name="global.button.delete">Delete</dhv:label>" onClick="javascript:popURLReturn('TroubleTicketMaintenanceNotes.do?command=ConfirmDelete&id=<%=ticketDetails.getId()%>&formId=<%=maintenanceDetails.getId()%>&popup=true','TroubleTicketMaintenanceNotes.do?command=List&id=<%=ticketDetails.getId()%>', 'Delete_maintenancenote','320','200','yes','no');">
  </dhv:permission>
    <br /><br />
    <%@ include file="troubletickets_view_maintenancenote_include.jsp" %>
    <br />
  <dhv:permission name="tickets-maintenance-report-edit">
    <input type="submit" value="<dhv:label name="global.button.modify">Modify</dhv:label>" />
  </dhv:permission>
  <dhv:permission name="tickets-maintenance-report-delete">
    <input type="button" value="<dhv:label name="global.button.delete">Delete</dhv:label>" onClick="javascript:popURLReturn('TroubleTicketMaintenanceNotes.do?command=ConfirmDelete&id=<%=ticketDetails.getId()%>&formId=<%=maintenanceDetails.getId()%>&popup=true','TroubleTicketMaintenanceNotes.do?command=List&id=<%=ticketDetails.getId()%>', 'Delete_maintenancenote','320','200','yes','no');">
  </dhv:permission>
</dhv:container>
</form>
