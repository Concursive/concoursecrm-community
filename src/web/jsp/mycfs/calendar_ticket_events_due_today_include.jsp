<%-- 
  - Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. DARK HORSE
  - VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id$
  - Description: 
  --%>
<%-- draws the ticket events for a specific day --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="org.aspcfs.modules.troubletickets.base.Ticket,org.aspcfs.modules.base.Constants" %>
<%@ include file="calendar_ticket_events_menu.jsp" %>
<%
  TicketEventList ticketEventList = (TicketEventList) thisDay.get(category);
%>

<%-- include tickets --%>
<dhv:evaluate if="<%= ticketEventList.getOpenTickets().size() > 0 %>">
<table border="0">
  <tr>
    <td colspan="6">
      <%-- event name --%>
      <img border="0" src="images/tree0.gif" align="texttop" title="Tickets"><a href="javascript:changeImages('ticketsimage<%=toFullDateString(thisDay.getDate()) %>','images/arrowdown.gif','images/arrowright.gif');javascript:switchStyle(document.getElementById('ticketsdetails<%=toFullDateString(thisDay.getDate()) %>'));" onMouseOver="window.status='View Details';return true;" onMouseOut="window.status='';return true;"><img src="<%= firstEvent ? "images/arrowdown.gif" : "images/arrowright.gif"%>" name="ticketsimage<%=toFullDateString(thisDay.getDate())%>" id="<%= firstEvent ? "0" : "1"%>" border="0" title="Click To View Details">These requests assigned to you are due today.</a>&nbsp;(<%= ticketEventList.getOpenTickets().size() %>)
    </td>
  </tr>
</table>
<table border="0" id="ticketsdetails<%= toFullDateString(thisDay.getDate()) %>" style="<%= firstEvent ? "display:" : "display:none"%>">
  <%-- include ticket details --%>
  <%
    Iterator j = ticketEventList.getOpenTickets().iterator();
    if(j.hasNext()){
  %>
    <tr>
      <th>
        &nbsp
      </th>
      <th class="weekSelector" nowrap>
        <strong>Request #</strong>
      </th>
      <th class="weekSelector" nowrap>
        <strong>Company</strong>
      </th>
      <th class="weekSelector" width="100%">
        <strong>Issue</strong>
      </th>
    </tr>
  <%  
      while(j.hasNext()){
      Ticket thisTicket = (Ticket) j.next();
      menuCount++;
    %>
    <tr>
     <td>
       <%-- Use the unique id for opening the menu, and toggling the graphics --%>
       <a href="javascript:displayTicketMenu('select<%= menuCount %>','menuTicket','<%=  thisTicket.getId() %>');"
       onMouseOver="over(0, <%= menuCount %>)" onmouseout="out(0, <%= menuCount %>);hideMenu('menuTicket');">
       <img src="images/select.gif" name="select<%= menuCount %>" id="select<%= menuCount %>" align="absmiddle" border="0"></a>
     </td>
     <td nowrap>
       <%= thisTicket.getPaddedId() %>
     </td>
     <td nowrap>
       <%= thisTicket.getCompanyName() %>
     </td>
     <td nowrap>
       <%= StringUtils.trimToSizeNoDots(toString(thisTicket.getProblem()), 30) %>
     </td>
    </tr>
   <% }
   } %>
</table>
</dhv:evaluate>
