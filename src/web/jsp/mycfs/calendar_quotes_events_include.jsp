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
<%-- draws the quote events for a specific day --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="org.aspcfs.modules.quotes.base.Quote,org.aspcfs.modules.base.Constants" %>
<%
  QuoteEventList quoteEventList = (QuoteEventList) thisDay.get(category);
%>

<%-- include quotes --%>
<dhv:evaluate if="<%= quoteEventList.getTodaysQuotes().size() > 0 %>">
<table border="0" id="todaysquotesdetails<%= toFullDateString(thisDay.getDate()) %>" width="100%">
  <%-- title row --%>
  <tr>
    <td>&nbsp;</td>
    <td colspan="3" nowrap class="eventName">
      <img border="0" src="images/box.gif" align="absmiddle" title="Quotes" />
      <dhv:label name="calendar.quotesPendingApproval" param='<%= "size="+quoteEventList.getTodaysQuotes().size() %>'>Quotes pending your approval (<%= quoteEventList.getTodaysQuotes().size() %>)</dhv:label>
    </td>
  </tr>
  <%-- include quote details --%>
  <%
    Iterator j = quoteEventList.getTodaysQuotes().iterator();
    if(j.hasNext()){
  %>
    <tr>
      <th>
        &nbsp;
      </th>
      <th class="weekSelector" nowrap>
        <strong><dhv:label name="accounts.accounts_quotes_list.Quote">Quote</dhv:label> #</strong>
      </th>
      <th class="weekSelector">
        <strong><dhv:label name="calendar.due">Due</dhv:label></strong>
      </th>
      <th class="weekSelector" width="100%">
        <strong><dhv:label name="accounts.accountasset_include.Description">Description</dhv:label></strong>
      </th>
    </tr>
  <%  
      while(j.hasNext()){
      Quote thisQuote = (Quote) j.next();
      menuCount++;
    %>
    <tr>
     <td valign="top">
       <%-- Use the unique id for opening the menu, and toggling the graphics --%>
       <a href="javascript:displayQuoteMenu('select-arrow<%= menuCount %>','menuQuote', '<%=  thisQuote.getId() %>', '<%= thisQuote.getContactId() %>');"
       onMouseOver="over(0, <%= menuCount %>)" onmouseout="out(0, <%= menuCount %>);hideMenu('menuQuote');"><img
       src="images/select-arrow.gif" name="select-arrow<%= menuCount %>" id="select-arrow<%= menuCount %>" align="absmiddle" border="0" /></a>
     </td>
     <td nowrap valign="top">
       <%= thisQuote.getId() %>
     </td>
     <td nowrap valign="top">
       <dhv:tz timestamp="<%= thisQuote.getExpirationDate() %>" timeOnly="true"/>
     </td>
     <td valign="top">
       <%= StringUtils.trimToSizeNoDots(toString(thisQuote.getShortDescription()), 30) %>
     </td>
    </tr>
   <% }
   } %>
</table>
</dhv:evaluate>



