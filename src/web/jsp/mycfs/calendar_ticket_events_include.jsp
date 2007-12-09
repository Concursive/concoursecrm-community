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
<%-- draws the ticket events for a specific day --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="org.aspcfs.modules.troubletickets.base.Ticket,org.aspcfs.modules.base.Constants" %>
<%
  TicketEventList ticketEventList = (TicketEventList) thisDay.get(category);
%>

<%-- include tickets --%>
<dhv:evaluate if="<%= ticketEventList.getOpenProductTickets().size() > 0 %>">
<table border="0" id="productticketsdetails<%= toFullDateString(thisDay.getDate()) %>" width="100%">
  <%-- title row --%>
  <tr>
    <td>&nbsp;</td>
    <td colspan="3" nowrap class="eventName">
      <img border="0" src="images/box.gif" align="absmiddle" title="Tickets" />
      <dhv:label name="dependency.tickets">Tickets</dhv:label>
      (<%= ticketEventList.getOpenProductTickets().size() %>)
    </td>
  </tr>
  <%-- include ticket details --%>
  <%
    Iterator j = ticketEventList.getOpenProductTickets().iterator();
    if(j.hasNext()){
  %>
    <tr>
      <th>
        &nbsp
      </th>
      <th class="weekSelector" nowrap>
        <strong><dhv:label name="calendar.requestNumber.symbol">Request #</dhv:label></strong>
      </th>
      <th class="weekSelector" width="100%">
        <strong><dhv:label name="accounts.accounts_asset_history.Issue">Issue</dhv:label></strong>
      </th>
      <th class="weekSelector">
        <strong><dhv:label name="calendar.due">Due</dhv:label></strong>
      </th>
    </tr>
  <%  
      while(j.hasNext()){
      Ticket thisTicket = (Ticket) j.next();
      menuCount++;
    %>
    <tr>
     <td valign="top">
       <%-- Use the unique id for opening the menu, and toggling the graphics --%>
       <a href="javascript:displayTicketMenu('select-arrow<%= menuCount %>','menuTicket','<%=  thisTicket.getId() %>', '<%= thisTicket.getContactId() %>');"
       onMouseOver="over(0, <%= menuCount %>)" onmouseout="out(0, <%= menuCount %>);hideMenu('menuTicket');"><img
       src="images/select-arrow.gif" name="select-arrow<%= menuCount %>" id="select-arrow<%= menuCount %>" align="absmiddle" border="0" /></a>
     </td>
     <td nowrap valign="top">
       <%= thisTicket.getId() %>
     </td>
     <td nowrap valign="top">
       <%= toHtml(StringUtils.trimToSizeNoDots(toString(thisTicket.getProblem()), 30)) %>
     </td>
     <td valign="top">
       <dhv:tz timestamp="<%= thisTicket.getEstimatedResolutionDate() %>" timeOnly="true"/>
     </td>
    </tr>
   <% }
   } %>
</table>
</dhv:evaluate>

