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
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.contacts.base.*, org.aspcfs.modules.communications.base.Campaign" %>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="CampaignList" class="org.aspcfs.modules.communications.base.CampaignList" scope="request"/>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="AccountContactMessageListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<%@ include file="../initPage.jsp" %>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Accounts.do"><dhv:label name="accounts.accounts">Accounts</dhv:label></a> > 
<% if (request.getParameter("return") == null) { %>
<a href="Accounts.do?command=Search">Search Results</a> >
<%} else if (request.getParameter("return").equals("dashboard")) {%>
<a href="Accounts.do?command=Dashboard">Dashboard</a> >
<%}%>
<a href="Accounts.do?command=Details&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="accounts.details">Account Details</dhv:label></a> >
<a href="Contacts.do?command=View&orgId=<%=OrgDetails.getOrgId()%>">Contacts</a> >
<a href="Contacts.do?command=Details&id=<%=ContactDetails.getId()%>">Contact Details</a> >
Messages
</td>
</tr>
</table>
<%-- End Trails --%>
<%@ include file="accounts_details_header_include.jsp" %>
<dhv:container name="accounts" selected="contacts" param="<%= "orgId=" + OrgDetails.getOrgId() %>" style="tabs"/>
<table cellpadding="4" cellspacing="0" border="0" width="100%">
  <tr>
    <td class="containerBack">
    <% String param1 = "id=" + ContactDetails.getId(); 
    %>
        <strong><%= ContactDetails.getNameLastFirst() %>:</strong>
        [ <dhv:container name="accountscontacts" selected="messages" param="<%= param1 %>"/> ]
      <br>
      <br>
      <table width="100%" border="0">
        <tr>
          <td align="left">
          <form name="listView" method="post" action="Contacts.do?command=ViewMessages&contactId=<%=ContactDetails.getId()%>">
            <select size="1" name="listView" onChange="javascript:document.forms[0].submit();">
              <option <%= AccountContactMessageListInfo.getOptionValue("my") %>>My Messages</option>
              <option <%= AccountContactMessageListInfo.getOptionValue("all") %>>All Messages</option>
            </select>
            </form>
          </td>
          <td>
            <dhv:pagedListStatus title="<%= showError(request, "actionError") %>" object="AccountContactMessageListInfo"/>
          </td>
        </tr>
      </table>
      <table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
        <tr>
          <th width="20%" nowrap>
            <a href="Contacts.do?command=ViewMessages&column=c.name&contactId=<%= ContactDetails.getId() %>"><strong>Name</strong></a>
            <%= AccountContactMessageListInfo.getSortIcon("c.name") %>
          </th>
          <th width="45%" ><strong>Message Subject</strong></th>
          <th width="20%" nowrap>
            <a href="Contacts.do?command=ViewMessages&column=active_date&contactId=<%= ContactDetails.getId() %>"><strong>Run Date</strong></a>
            <%= AccountContactMessageListInfo.getSortIcon("active_date") %>
          </th>
          <th width="15%">
            <strong>Status</strong>
          </th>
        </tr>
  <%
    Iterator j = CampaignList.iterator();
    if ( j.hasNext() ) {
      int rowid = 0;
      while (j.hasNext()) {
        rowid = (rowid != 1?1:2);
        Campaign campaign = (Campaign)j.next();
  %>
        <tr class="containerBody">
          <td class="row<%= rowid %>">
            <a href="Contacts.do?command=MessageDetails&id=<%= campaign.getId() %>&contactId=<%=ContactDetails.getId()%>">
            <%= toHtml(campaign.getMessageName() != null && !"".equals(campaign.getMessageName()) ? campaign.getMessageName() : "\"No name available\"") %></a>
            <%= (("true".equals(request.getParameter("notify")) && ("" + campaign.getId()).equals(request.getParameter("id")))?" <font color=\"red\">(Canceled)</font>":"") %>
          </td>
          <td class="row<%= rowid %>"><%= toHtml(campaign.getMessageSubject()) %></td>
          <td valign="top" align="left" nowrap class="row<%= rowid %>">
            <zeroio:tz timestamp="<%= campaign.getActiveDate() %>" dateOnly="true" default="&nbsp;"/>
          </td>
          <td valign="top" nowrap class="row<%= rowid %>">
            <%=toHtml(campaign.getStatus())%>
          </td>
        </tr>
	<%}%>
 <%} else {%>
  <tr class="containerBody">
    <td colspan="4">
      No messages found.
    </td>
  </tr>
<%}%>
</table>
<br>
<dhv:pagedListControl object="AccountContactMessageListInfo"/>
<br>
<input type="hidden" name="id" value="<%=ContactDetails.getId()%>">
    </td>
  </tr>
</table>
