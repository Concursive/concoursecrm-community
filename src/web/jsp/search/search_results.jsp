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
<%@ page import="java.util.*" %>
<%@ page import="org.aspcfs.modules.accounts.base.Organization" %>
<%@ page import="org.aspcfs.modules.base.*" %> 
<%@ page import="org.aspcfs.modules.contacts.base.Contact" %> 
<%@ page import="org.aspcfs.modules.troubletickets.base.Ticket" %> 
<%@ page import="org.aspcfs.modules.pipeline.beans.OpportunityBean" %>
<%@ page import="org.aspcfs.modules.pipeline.base.OpportunityComponent" %>
<jsp:useBean id="ContactList" class="org.aspcfs.modules.contacts.base.ContactList" scope="request"/>
<jsp:useBean id="EmployeeList" class="org.aspcfs.modules.contacts.base.ContactList" scope="request"/>
<jsp:useBean id="OrganizationList" class="org.aspcfs.modules.accounts.base.OrganizationList" scope="request"/>
<jsp:useBean id="OpportunityList" class="org.aspcfs.modules.pipeline.base.OpportunityList" scope="request"/>
<jsp:useBean id="TicketList" class="org.aspcfs.modules.troubletickets.base.TicketList" scope="request"/>
<jsp:useBean id="SearchSiteContactInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="SearchSiteEmployeeInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="SearchSiteAccountInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="SearchSiteOppInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="SearchSiteTicketInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>
<%@ include file="../initPage.jsp" %>
<%
  String paramSearchText = "searchText=" + toHtml(request.getParameter("search"));
%>
<dhv:label name="search.results.searchString" param="<%= paramSearchText %>">Your search for <b><%= toHtml(request.getParameter("search")) %></b> returned:</dhv:label>
<br>&nbsp;<br> 
<dhv:permission name="contacts-external_contacts-view,accounts-accounts-contacts-view">
<% if(ContactList.size() < SearchSiteContactInfo.getMaxRecords()){ %>
<% String temp_contactSize = "tempContactSize"+ContactList.size()+"|tempMaxRecords="+SearchSiteContactInfo.getMaxRecords();%>
<dhv:label name="search.showingNumberOfTotal.text" param="<%= temp_contactSize %>">Showing <strong><%= ContactList.size() %></strong> result(s) of <%= SearchSiteContactInfo.getMaxRecords() %> in <strong>Contacts</strong>.</dhv:label>
<% }else{ 
  String temp_listSize = "ContactListSize="+ContactList.size();
%>
<dhv:label name="search.totalResultsInContacts.text" param="<%= temp_listSize %>"><strong><%= ContactList.size() %></strong> result(s) in <strong>Contacts</strong>.</dhv:label>
<% } 
Iterator i = ContactList.iterator();
if (i.hasNext()) {
%>
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <tr>
    <th>
      <strong><dhv:label name="contacts.name">Name</dhv:label></strong>
    </th>
    <th width="100%">
      <strong><dhv:label name="accounts.accounts_contacts_detailsimport.Company">Company</dhv:label></strong>
    </th>
    <th width="100" nowrap>
      <strong><dhv:label name="accounts.accounts_contacts_add.Title">Title</dhv:label></strong>
    </th>
    <th width="100">
      <strong><dhv:label name="accounts.accounts_add.Phone">Phone</dhv:label></strong>
    </th>
    <th width="100">
      <strong><dhv:label name="accounts.accounts_add.Email">Email</dhv:label></strong>
    </th>
  </tr>
<%    
	int rowid = 0;
		while (i.hasNext()) {
      rowid = (rowid != 1?1:2);
      Contact thisContact = (Contact)i.next();
%>      
      <tr class="row<%= rowid %>">
        <td nowrap>
          <%if(thisContact.getOrgId() < 0){%>
          <a href="ExternalContacts.do?command=ContactDetails&id=<%= thisContact.getId() %>"><%= toHtml(thisContact.getNameLastFirst()) %></a>
          <%}else{%>
          <a href="Contacts.do?command=Details&id=<%= thisContact.getId() %>"><%= toHtml(thisContact.getNameLastFirst()) %></a>
          <%}%>
          <%= thisContact.getEmailAddressTag("Business", "<img border=0 src=\"images/icons/stock_mail-16.gif\" alt=\"<dhv:label name='alt.sendEmail'>Send Email</dhv:label>\" align=\"absmiddle\">", "") %>
          <dhv:evaluate if="<%= thisContact.getOrgId() > 0 %>">
            [<a href="Accounts.do?command=Details&orgId=<%=  thisContact.getOrgId() %>"><dhv:label name="accounts.account">Account</dhv:label></a>]
          </dhv:evaluate>
        </td>
        <td>
          <%= toHtml(thisContact.getCompany()) %>
        </td>
        <td nowrap>
          <%= toHtml(thisContact.getTitle()) %>
        </td>
        <td nowrap>
          <% if (thisContact.getPhoneNumberList().size() > 1) { %>
            <%= thisContact.getPhoneNumberList().getHtmlSelect("contactphone", -1) %>
        <% } else if (thisContact.getPhoneNumberList().size() == 1) { 
             PhoneNumber thisNumber = (PhoneNumber) thisContact.getPhoneNumberList().get(0);
         %>
             <%= String.valueOf(thisNumber.getTypeName().charAt(0)) + ":" + thisNumber.getNumber() %>
        <%}else{%>
          &nbsp;
        <%}%>
        </td>
        <td nowrap>
          <% if (thisContact.getEmailAddressList().size() > 1) { %>
            <%= thisContact.getEmailAddressList().getHtmlSelect("contactemail", -1) %>
        <% } else if (thisContact.getEmailAddressList().size() == 1) { 
             EmailAddress thisAddress = (EmailAddress) thisContact.getEmailAddressList().get(0);
         %>
             <%= String.valueOf(thisAddress.getTypeName().charAt(0)) + ":" + thisAddress.getEmail() %>
        <%}else{%>
          &nbsp;
        <%}%>
        </td>
      </tr>
<%}%>
</table>
<br>
<%} else {%>
	<br>&nbsp;<br>
<%}%>
</dhv:permission>
<dhv:permission name="contacts-internal_contacts-view">
<% if(EmployeeList.size() < SearchSiteEmployeeInfo.getMaxRecords()){ 
      String temp_empSize = "EmployeeSize="+EmployeeList.size()+"|totalEmployees="+SearchSiteEmployeeInfo.getMaxRecords();
%>
<dhv:label name="search.showingNumberOfTotalEmployees.text" param="<%= temp_empSize %>">Showing <strong><%= EmployeeList.size() %></strong> result(s) of <%= SearchSiteEmployeeInfo.getMaxRecords() %> in <strong>Employees</strong>.</dhv:label>
<% }else{ 
      String temp_employeeSize = "EmployeeSize="+EmployeeList.size();
%>
<dhv:label name="search.totalResultsInEmployees.text" param="<%= temp_employeeSize %>"><strong><%= EmployeeList.size() %></strong> result(s) in <strong>Employees</strong>.</dhv:label>
<% }
  Iterator j = EmployeeList.iterator();
  if (j.hasNext()) {
    int rowid = 0;
%>
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <tr>
    <th>
      <strong><dhv:label name="contacts.name">Name</dhv:label></strong>
    </th>
    <th width="175">
      <strong><dhv:label name="project.department">Department</dhv:label></strong>
    </th>
    <th width="100">
      <strong><dhv:label name="accounts.accounts_contacts_add.Title">Title</dhv:label></strong>
    </th>
    <th width="100" nowrap>
      <strong><dhv:label name="accounts.accounts_contacts_detailsimport.PhoneBusiness">Phone: Business</dhv:label></strong>
    </th>
  </tr>
<%    
    while (j.hasNext()) {
      rowid = (rowid != 1?1:2);
      Contact thisEmployee = (Contact)j.next();
%>      
      <tr class="row<%= rowid %>">
        <td>
          <a href="CompanyDirectory.do?command=EmployeeDetails&empid=<%= thisEmployee.getId() %>"><%= toHtml(thisEmployee.getNameLastFirst()) %></a>
          <%= thisEmployee.getEmailAddressTag("Business", "<img border=0 src=\"images/icons/stock_mail-16.gif\" alt=\"<dhv:label name='alt.sendEmail'>Send Email</dhv:label>\" align=\"absmiddle\">", "") %>
        </td>
        <td>
          <%= toHtml(thisEmployee.getDepartmentName()) %>
        </td>
        <td>
          <%= toHtml(thisEmployee.getTitle()) %>
        </td>
        <td>
          <%= toHtml(thisEmployee.getPhoneNumber("Business")) %>
        </td>
      </tr>
<%      
    }
%>
</table><br>
<%
  } else {
%>
	<br>&nbsp;<br>  
<%}%>
</dhv:permission>
<dhv:permission name="accounts-accounts-view">
<% if(OrganizationList.size() < SearchSiteAccountInfo.getMaxRecords()){ 
      String temp_accountsSize = "AccountSize="+OrganizationList.size()+"|TotalAccounts="+SearchSiteAccountInfo.getMaxRecords();
%>
<dhv:label name="search.showingNumberOfAccounts.text" param="<%= temp_accountsSize %>">Showing <strong><%= OrganizationList.size() %></strong> result(s) of <%= SearchSiteAccountInfo.getMaxRecords() %> in <strong>Accounts</strong>.</dhv:label>
<% }else{ 
      String temp_accountsSize = "AccountSize="+OrganizationList.size();
%>
<dhv:label name="search.totalResultsInAccounts" param="<%= temp_accountsSize %>"><strong><%= OrganizationList.size() %></strong> result(s) in <strong>Accounts</strong>.</dhv:label>
<% }

  Iterator k = OrganizationList.iterator();
  if (k.hasNext()) {
    int rowid = 0;
%>
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <tr>
    <th width="100%">
      <strong><dhv:label name="organization.name">Account Name</dhv:label></strong>
    </th>
    <dhv:include name="sitesearch-account-email" none="true">
    <th width="175">
      <strong><dhv:label name="accounts.accounts_add.Email">Email</dhv:label></strong>
    </th>
    </dhv:include>
    <th width="100">
      <strong><dhv:label name="accounts.accounts_add.Phone">Phone</dhv:label></strong>
    </th>
  </tr>
<%    
    while (k.hasNext()) {
      rowid = (rowid != 1?1:2);
      Organization thisOrg = (Organization)k.next();
%>
  <tr class="row<%= rowid %>">
		<td>
      <a href="Accounts.do?command=Details&orgId=<%=thisOrg.getOrgId()%>"><%= toHtml(thisOrg.getName()) %></a>
		</td>
    <dhv:include name="sitesearch-account-email" none="true">
		<td valign="center" nowrap>
      <a href="mailto:<%= toHtml(thisOrg.getEmailAddress("Primary")) %>"><%= toHtml(thisOrg.getEmailAddress("Primary")) %></a>
    </td>
    </dhv:include>
		<td valign="center" nowrap>
      <% if (thisOrg.getPhoneNumberList().size() > 1) { %>
            <%= thisOrg.getPhoneNumberList().getHtmlSelect("contactphone", -1) %>
      <% } else if (thisOrg.getPhoneNumberList().size() == 1) { 
           PhoneNumber thisNumber = (PhoneNumber) thisOrg.getPhoneNumberList().get(0);
       %>
           <%= String.valueOf(thisNumber.getTypeName().charAt(0)) + ":" + thisNumber.getNumber() %>
      <%}else{%>
          &nbsp;
        <%}%>
    </td>
  </tr>
<%
    }
%>
</table><br>
<%
  } else {
%>
	<br>&nbsp;<br>
<%}%>
</dhv:permission>
<dhv:permission name="pipeline-opportunities-view">
<% if(OpportunityList.size() < SearchSiteOppInfo.getMaxRecords()){ 
      String temp_oppSize = "OppSize="+OpportunityList.size()+"|TotalOpps="+SearchSiteOppInfo.getMaxRecords();
%>
<dhv:label name="search.showingNumberOfOpportunities.text" param="<%= temp_oppSize %>">Showing <strong><%= OpportunityList.size() %></strong> result(s) of <%= SearchSiteOppInfo.getMaxRecords() %> in <strong>Opportunities</strong>.</dhv:label>
<% }else{ 
      String temp_oppSize = "OppSize="+OpportunityList.size();
%> 
<dhv:label name="search.totalResultsInOpportunities.text" param="<%= temp_oppSize %>"><strong><%= OpportunityList.size() %></strong> result(s) in <strong>Opportunities</strong>.</dhv:label>
<% } 
  Iterator m = OpportunityList.iterator();
  if (m.hasNext()) {
    int rowid = 0;
%>
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <tr>
    <th valign="center">
      <strong><dhv:label name="quotes.opportunity">Opportunity</dhv:label></strong>
    </th>
    <th width="175" valign="center">
      <strong><dhv:label name="documents.details.organization">Organization</dhv:label></strong>
    </th>
    <th width="100" valign="center">
      <strong><dhv:label name="accounts.accounts_revenue_add.Amount">Amount</dhv:label></strong>
    </th>
    <th width="100" valign="center" nowrap>
      <strong><dhv:label name="pipeline.revenueStart">Revenue Start</dhv:label></strong>
    </th>
  </tr>
  <%
    while (m.hasNext()) {
			rowid = (rowid != 1?1:2);
      OpportunityBean thisOpp = (OpportunityBean) m.next();
%>      
	<tr class="row<%= rowid %>">
      <td valign="center">
        <%if(thisOpp.getHeader().getContactLink() > 0){ %>
        <a href="ExternalContactsOpps.do?command=DetailsOpp&headerId=<%= thisOpp.getHeader().getId() %>&contactId=<%= thisOpp.getHeader().getContactLink() %>">
        <%= toHtml(thisOpp.getHeader().getDescription()) %>: <%= toHtml(thisOpp.getComponent().getDescription()) %></a>
        <%
        } else { %>
        <a href="Leads.do?command=DetailsOpp&headerId=<%= thisOpp.getHeader().getId() %>">
        <%= toHtml(thisOpp.getHeader().getDescription()) %>: <%= toHtml(thisOpp.getComponent().getDescription()) %></a>
        <%
        }%>
      </td>
      <td valign="center">
<%
      if (thisOpp.getHeader().getAccountLink() > -1) {
%>        
        <a href="Opportunities.do?command=View&orgId=<%= thisOpp.getHeader().getAccountLink() %>">
<%
      }
%>        
        <%= toHtml(thisOpp.getHeader().getAccountName()) %>
<%
      if (thisOpp.getHeader().getAccountLink() > -1) {
%>     
        </a>
<%
      }
%>        
      </td>
      <td valign="center" nowrap>
        <zeroio:currency value="<%= thisOpp.getComponent().getGuess() %>" code="<%= applicationPrefs.get("SYSTEM.CURRENCY") %>" locale="<%= User.getLocale() %>" default="&nbsp;"/>
      </td>
      <td valign="center" nowrap>
        <%= toHtml(thisOpp.getComponent().getCloseDateString()) %>
      </td>
    </tr>
<%}%>
</table>
<br>
<%} else {%>
  <br>&nbsp;<br> 
<%}%>
</dhv:permission>
<dhv:permission name="tickets-tickets-view">
<%
  String paramTicketCount = "ticketList.count=" + TicketList.size();
  String paramTicketMaxRecords = "ticketListInfo.maxRecords=" + SearchSiteTicketInfo.getMaxRecords();
  if (TicketList.size() < SearchSiteTicketInfo.getMaxRecords()) { %>
<dhv:label name="search.results.tickets.multiPagecount" param="<%= paramTicketCount + "|" + paramTicketMaxRecords %>">Showing <strong><%= TicketList.size() %></strong> result(s) of <%= SearchSiteTicketInfo.getMaxRecords() %> in <strong>Tickets</strong>.</dhv:label>
<% }else{ %>
<dhv:label name="search.results.tickets.count" param="<%= paramTicketCount %>"><strong><%= TicketList.size() %></strong> result(s) in <strong>Tickets</strong>.</dhv:label>
<% }
  Iterator n = TicketList.iterator();
  if (n.hasNext()) {
    int rowid = 0;
%>
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <tr>
    <th valign="center">
      <strong><dhv:label name="quotes.number">Number</dhv:label></strong>
    </th>
    <th><b><dhv:label name="accounts.accounts_contacts_calls_details_followup_include.Priority">Priority</dhv:label></b></th>
    <th><b><dhv:label name="ticket.age">Age</dhv:label></b></th>
    <th><b><dhv:label name="accounts.accounts_contacts_detailsimport.Company">Company</dhv:label></b></th>
    <th><b><dhv:label name="accounts.accounts_contacts_calls_list.AssignedTo">Assigned To</dhv:label></b></th>
  </tr>
  <%
  	while (n.hasNext()) {
      rowid = (rowid != 1?1:2);
      Ticket thisTic = (Ticket) n.next();
%>   
  <tr class="row<%= rowid %>">
		<td rowspan="2" width="15" valign="top" nowrap>
      <a href="TroubleTickets.do?command=Details&id=<%=thisTic.getId()%>"><%=thisTic.getPaddedId()%></a>
		</td>
		<td width="10" valign="top" nowrap>
      <%= toHtml(thisTic.getPriorityName()) %>
		</td>
		<td width="8%" align="right" valign="top" nowrap>
      <%= thisTic.getAgeOf() %>
		</td>
		<td width="90%" valign="top">
      <%= toHtml(thisTic.getCompanyName()) %>
		</td>
    <td width="150" nowrap valign="top">
      <dhv:username id="<%= thisTic.getAssignedTo() %>" default="ticket.unassigned.text"/>
    </td>
  </tr>
  <tr class="row<%= rowid %>">
		<td colspan="4" valign="top">
      <%= toHtml(thisTic.getProblemHeader()) %>
		</td>
  </tr>
<%}%>
</table>
<br>
<%} else {%>
  <br>&nbsp;<br> 
<%}%>
</dhv:permission>
