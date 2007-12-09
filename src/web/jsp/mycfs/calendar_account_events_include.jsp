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
<%-- draws the account events for a specific day --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.base.Constants" %>
<%
  OrganizationEventList orgEventList = (OrganizationEventList) thisDay.get(category);
%>

<%-- include pending accounts --%>
<dhv:evaluate if="<%= orgEventList.getAlertOrgs().size() > 0 %>">
<table border="0" id="alertorgdetails<%= toFullDateString(thisDay.getDate()) %>" width="100%">
  <%-- title row --%>
  <tr>
    <td>&nbsp;</td>
    <td colspan="3" nowrap class="eventName">
      <img border="0" src="images/accounts.gif" align="absmiddle" title="Accounts" />
      <dhv:label name="accounts.account.alerts">Account Alerts</dhv:label>
      (<%= orgEventList.getAlertOrgs().size() %>)
    </td>
  </tr>
  <%-- include account details --%>
  <%
    Iterator j = orgEventList.getAlertOrgs().iterator();
    if(j.hasNext()){
  %>
    <tr>
      <th>
        &nbsp;
      </th>
      <th class="weekSelector">
        <strong><dhv:label name="calendar.alert">Alert</dhv:label></strong>
      </th>
      <th class="weekSelector" nowrap>
        <strong><dhv:label name="organization.name">Account Name</dhv:label></strong>
      </th>
      <th class="weekSelector" nowrap>
        <strong><dhv:label name="accounts.accounts_contacts_detailsimport.Owner">Owner</dhv:label></strong>
      </th>
    </tr>
  <%  
      while(j.hasNext()){
      Organization thisOrg = (Organization) j.next();
      menuCount++;
    %>
    <tr>
     <td valign="top">
       <%-- Use the unique id for opening the menu, and toggling the graphics --%>
       <a href="javascript:displayAccountMenu('select-arrow<%= menuCount %>','menuAccount', '<%= thisOrg.getOrgId() %>');"
         onMouseOver="over(0, <%= menuCount %>)" onmouseout="out(0, <%= menuCount %>);hideMenu('menuAccount');"><img
         src="images/select-arrow.gif" name="select-arrow<%= menuCount %>" id="select-arrow<%= menuCount %>" align="absmiddle" border="0"></a>
     </td>
     <td width="100%" valign="top">
       <%= toHtml(thisOrg.getAlertText()) %>
     </td>
     <td nowrap valign="top">
       <%= thisOrg.getName() %>
     </td>
     <td nowrap valign="top">
       <dhv:username id="<%= thisOrg.getOwner() %>"/>
     </td>
    </tr>
   <% }
   } %>
</table>
</dhv:evaluate>

<dhv:evaluate if="<%= orgEventList.getContractEndOrgs().size() > 0 %>">
<table border="0" id="alertcontractorgdetails<%= toFullDateString(thisDay.getDate()) %>" width="100%">
  <%-- title row --%>
  <tr>
    <td>&nbsp;</td>
    <td colspan="2" nowrap class="eventName">
      <img border="0" src="images/accounts.gif" align="absmiddle" title="Accounts" />
      <dhv:label name="accounts.accountContractEndAlerts">Account Contract End Alerts</dhv:label>
      (<%= orgEventList.getContractEndOrgs().size() %>)
    </td>
  </tr>
  <%-- include account details --%>
  <%
    Iterator j = orgEventList.getContractEndOrgs().iterator();
    if(j.hasNext()){
  %>
    <tr>
      <th>
        &nbsp;
      </th>
      <th class="weekSelector" nowrap width="100%">
        <strong><dhv:label name="organization.name">Account Name</dhv:label></strong>
      </th>
      <th class="weekSelector" nowrap>
        <strong><dhv:label name="accounts.accounts_contacts_detailsimport.Owner">Owner</dhv:label></strong>
      </th>
    </tr>
  <%  
      while(j.hasNext()){
      Organization thisOrg = (Organization) j.next();
      menuCount++;
    %>
    <tr>
      <td valign="top">
       <%-- Use the unique id for opening the menu, and toggling the graphics --%>
       <a href="javascript:displayAccountMenu('select-arrow<%= menuCount %>','menuAccount', '<%= thisOrg.getOrgId() %>');"
         onMouseOver="over(0, <%= menuCount %>)" onmouseout="out(0, <%= menuCount %>);hideMenu('menuAccount');"><img
         src="images/select-arrow.gif" name="select-arrow<%= menuCount %>" id="select-arrow<%= menuCount %>" align="absmiddle" border="0" /></a>
      </td>
      <td valign="top">
       <%= thisOrg.getName() %>
      </td>
      <td nowrap valign="top">
        <dhv:username id="<%= thisOrg.getOwner() %>"/>
      </td>
    </tr>
   <% }
   } %>
</table>
</dhv:evaluate>

