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
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.contacts.base.*,org.aspcfs.modules.pipeline.base.OpportunityHeader,com.zeroio.iteam.base.*" %>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="OpportunityHeaderList" class="org.aspcfs.modules.pipeline.base.OpportunityHeaderList" scope="request"/>
<jsp:useBean id="AccountContactOppsPagedListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>
<%@ include file="../initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<script type="text/javascript">
  function reopenOpportunity(id) {
    scrollReload('AccountContactsOpps.do?command=ViewOpps&contactId=<%= ContactDetails.getId() %><%= isPopup(request)?"&popup=true":"" %>');
    return id;
  }
</script>
<dhv:evaluate if="<%= !isPopup(request) %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Accounts.do"><dhv:label name="accounts.accounts">Accounts</dhv:label></a> > 
<% if (request.getParameter("return") == null) { %>
<a href="Accounts.do?command=Search"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
<%} else if (request.getParameter("return").equals("dashboard")) {%>
<a href="Accounts.do?command=Dashboard"><dhv:label name="communications.campaign.Dashboard">Dashboard</dhv:label></a> >
<%}%>
<a href="Accounts.do?command=Details&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="accounts.details">Account Details</dhv:label></a> >
<a href="Contacts.do?command=View&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="accounts.Contacts">Contacts</dhv:label></a> >
<a href="Contacts.do?command=Details&id=<%=ContactDetails.getId()%>&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="accounts.accounts_contacts_add.ContactDetails">Contact Details</dhv:label></a> >
<dhv:label name="accounts.accounts_contacts_oppcomponent_add.Opportunities">Opportunities</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>
<dhv:container name="accounts" selected="contacts" object="OrgDetails" param="<%= "orgId=" + OrgDetails.getOrgId() %>" appendToUrl="<%= addLinkParams(request, "popup|popupType|actionId") %>">
  <dhv:container name="accountscontacts" selected="opportunities" object="ContactDetails" param="<%= "id=" + ContactDetails.getId() %>" appendToUrl="<%= addLinkParams(request, "popup|popupType|actionId") %>">
    <dhv:permission name="accounts-accounts-contacts-opportunities-add"><a href="AccountContactsOpps.do?command=Prepare&contactId=<%= ContactDetails.getId() %>&actionSource=AccountContactsOpps<%= addLinkParams(request, "popup|popupType|actionId") %>"><dhv:label name="accounts.accounts_contacts_oppcomponent_list.AddAnOpportunity">Add an Opportunity</dhv:label></a></dhv:permission>
    <dhv:include name="pagedListInfo.alphabeticalLinks" none="true">
    <center><dhv:pagedListAlphabeticalLinks object="AccountContactOppsPagedListInfo"/></center></dhv:include>
    <table width="100%" border="0">
      <tr>
        <form name="listView" method="post" action="AccountContactsOpps.do?command=ViewOpps&contactId=<%= ContactDetails.getId() %><%= addLinkParams(request, "popup|popupType|actionId") %>">
        <td align="left">
          <select size="1" name="listView" onChange="javascript:document.listView.submit();">
            <option <%= AccountContactOppsPagedListInfo.getOptionValue("my") %>><dhv:label name="accounts.accounts_contacts_oppcomponent_list.MyOpenOpportunities">My Open Opportunities</dhv:label> </option>
            <option <%= AccountContactOppsPagedListInfo.getOptionValue("all") %>><dhv:label name="accounts.accounts_contacts_oppcomponent_list.AllOpenOpportunities">All Open Opportunities</dhv:label></option>
            <option <%= AccountContactOppsPagedListInfo.getOptionValue("closed") %>><dhv:label name="accounts.accounts_contacts_oppcomponent_list.AllClosedOpportunities">All Closed Opportunities</dhv:label></option>
          </select>
        </td>
        <td>
          <dhv:pagedListStatus title="<%= showError(request, "actionError") %>" object="AccountContactOppsPagedListInfo"/>
        </td>
        </form>
      </tr>
    </table>
    <table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
      <tr>
      <dhv:permission name="accounts-accounts-contacts-opportunities-edit,accounts-accounts-contacts-opportunities-delete">
        <th>
          &nbsp;
        </th>
      </dhv:permission>
        <th nowrap>
          <strong><a href="AccountContactsOpps.do?command=ViewOpps&contactId=<%= ContactDetails.getId() %>&column=x.description<%= addLinkParams(request, "popup|popupType|actionId") %>"><dhv:label name="accounts.accounts_contacts_oppcomponent_list.OpportunityName">Opportunity Name</dhv:label></a></strong>
          <%= AccountContactOppsPagedListInfo.getSortIcon("x.description") %>
        </th>
        <th nowrap>
          <strong><dhv:label name="accounts.accounts_contacts_oppcomponent_list.BestGuessTotal">Best Guess Total</dhv:label></strong>
        </th>
        <th nowrap>
          <strong><a href="AccountContactsOpps.do?command=ViewOpps&contactId=<%= ContactDetails.getId() %>&column=x.modified<%= addLinkParams(request, "popup|popupType|actionId") %>"><dhv:label name="accounts.accounts_contacts_oppcomponent_list.LastModified">Last Modified</dhv:label></a></strong>
          <%= AccountContactOppsPagedListInfo.getSortIcon("x.modified") %>
        </th>
      </tr>
    <%
      Iterator j = OpportunityHeaderList.iterator();
      FileItem thisFile = new FileItem();
      if ( j.hasNext() ) {
        int rowid = 0;
          while (j.hasNext()) {
            rowid = (rowid != 1?1:2);
            OpportunityHeader oppHeader = (OpportunityHeader)j.next();
    %>
        <tr class="containerBody">
          <dhv:permission name="accounts-accounts-contacts-opportunities-edit,accounts-accounts-contacts-opportunities-delete">
          <td width="8" valign="top" align="center" class="row<%= rowid %>" nowrap>
            <dhv:permission name="accounts-accounts-contacts-opportunities-edit"><a href="AccountContactsOpps.do?command=ModifyOpp&headerId=<%= oppHeader.getId() %>&contactId=<%= oppHeader.getContactLink() %>&return=list<%= addLinkParams(request, "popup|popupType|actionId") %>"><dhv:label name="accounts.accounts_contacts_oppcomponent_list.Edit">Edit</dhv:label></a></dhv:permission><dhv:permission name="accounts-accounts-contacts-opportunities-edit,accounts-accounts-contacts-opportunities-delete" all="true">|</dhv:permission><dhv:permission name="accounts-accounts-contacts-opportunities-delete"><a href="javascript:popURLReturn('AccountContactsOpps.do?command=ConfirmDelete&contactId=<%= ContactDetails.getId() %>&headerId=<%= oppHeader.getId() %>&popup=true<%= addLinkParams(request, "popupType|actionId") %>','AccountContactsOpps.do?command=ViewOpps&contactId=<%= ContactDetails.getId() %>', 'Delete_opp','320','200','yes','no');"><dhv:label name="accounts.accounts_contacts_oppcomponent_list.Del">Del</dhv:label></a></dhv:permission>
          </td>
          </dhv:permission>
          <td width="100%" valign="top" class="row<%= rowid %>">
            <a href="AccountContactsOpps.do?command=DetailsOpp&headerId=<%= oppHeader.getId() %>&contactId=<%= ContactDetails.getId() %><%= addLinkParams(request, "popup|popupType|actionId") %>">
            <%= toHtml(oppHeader.getDescription()) %></a>
            (<%= oppHeader.getComponentCount() %>)
            <dhv:evaluate if="<%= oppHeader.hasFiles() %>">
              <%= thisFile.getImageTag("-23") %>
            </dhv:evaluate>
          </td>
          <td valign="top" align="right" class="row<%= rowid %>" nowrap>
            <zeroio:currency value="<%= oppHeader.getTotalValue() %>" code="<%= applicationPrefs.get("SYSTEM.CURRENCY") %>" locale="<%= User.getLocale() %>" default="&nbsp;"/>
          </td>
          <td valign="top" align="center" class="row<%= rowid %>" nowrap>
            <zeroio:tz timestamp="<%= oppHeader.getModified() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="true"/>
          </td>
        </tr>
    <%
        }
      } else {
    %>
        <tr class="containerBody">
          <td colspan="6">
            <dhv:label name="accounts.accounts_contacts_oppcomponent_list.NoOpportunitiesFound">No opportunities found.</dhv:label>
          </td>
        </tr>
    <%}%>
    </table>
    <br>
    <dhv:pagedListControl object="AccountContactOppsPagedListInfo"/>
  </dhv:container>
</dhv:container>