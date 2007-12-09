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
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.accounts.base.*" %>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="Revenue" class="org.aspcfs.modules.accounts.base.Revenue" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<form name="listRevenue" action="RevenueManager.do" method="post">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Accounts.do"><dhv:label name="accounts.accounts">Accounts</dhv:label></a> > 
<a href="Accounts.do?command=Search"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
<a href="Accounts.do?command=Details&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="accounts.details">Account Details</dhv:label></a> >
<a href="RevenueManager.do?command=View&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="accounts.accounts_add.Revenue">Revenue</dhv:label></a> >
<dhv:label name="accounts.accounts_revenue_details.RevenueDetails">Revenue Details</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<dhv:container name="accounts" selected="revenue" object="OrgDetails" param='<%= "orgId=" + OrgDetails.getOrgId() %>' appendToUrl='<%= addLinkParams(request, "popup|popupType|actionId") %>'>
  <dhv:permission name="accounts-accounts-revenue-edit"><input type='button' value="<dhv:label name="global.button.modify">Modify</dhv:label>" onClick="javascript:this.form.action='RevenueManager.do?command=Modify&id=<%=Revenue.getId()%>&orgId=<%=Revenue.getOrgId()%>';submit();"></dhv:permission>
  <dhv:permission name="accounts-accounts-revenue-delete"><input type='button' value="<dhv:label name="global.button.delete">Delete</dhv:label>" onClick="javascript:this.form.action='RevenueManager.do?command=Delete&id=<%=Revenue.getId()%>&orgId=<%=Revenue.getOrgId()%>';confirmSubmit(this.form);"></dhv:permission>
  <dhv:permission name="accounts-accounts-revenue-edit,accounts-accounts-revenue-delete"><br>&nbsp;</dhv:permission>
  <input type="hidden" name="type" value="<%= Revenue.getType() %>">
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
    <tr>
      <th colspan="3">
        <strong><%= toHtml(Revenue.getDescription()) %></strong>
      </th>
    </tr>
    <tr class="containerBody">
      <td class="formLabel">
        <dhv:label name="accounts.accounts_contacts_detailsimport.Owner">Owner</dhv:label>
      </td>
      <td>
        <dhv:username id="<%= Revenue.getOwner() %>" />
        <dhv:evaluate if="<%= !(Revenue.getHasEnabledOwnerAccount()) %>"><font color="red">*</font></dhv:evaluate>
      </td>
    </tr>
    <tr class="containerBody">
      <td class="formLabel">
        <dhv:label name="accounts.accounts_add.Type">Type</dhv:label>
      </td>
      <td>
        <%= toHtml(Revenue.getTypeName()) %>
      </td>
    </tr>
    <tr class="containerBody">
      <td class="formLabel">
        <dhv:label name="accounts.accounts_revenue_add.Month">Month</dhv:label>
      </td>
      <td>
        <%= toHtml(Revenue.getMonthName()) %>
      </td>
    </tr>
    <tr class="containerBody">
      <td class="formLabel">
        <dhv:label name="accounts.accounts_revenue_add.Year">Year</dhv:label>
      </td>
      <td>
        <%= Revenue.getYear() %>
      </td>
    </tr>
    <tr class="containerBody">
      <td class="formLabel">
        <dhv:label name="accounts.accounts_revenue_add.Amount">Amount</dhv:label>
      </td>
      <td>
        <zeroio:currency value="<%= Revenue.getAmount() %>" code='<%= applicationPrefs.get("SYSTEM.CURRENCY") %>' locale="<%= User.getLocale() %>" default="&nbsp;"/>
      </td>
    </tr>
    <tr class="containerBody">
      <td nowrap class="formLabel">
        <dhv:label name="accounts.accounts_calls_list.Entered">Entered</dhv:label>
      </td>
      <td>
        <dhv:username id="<%= Revenue.getEnteredBy() %>" />
        -
        <%= Revenue.getEnteredDateTimeString() %>
      </td>
    </tr>
    <tr class="containerBody">
      <td nowrap class="formLabel">
        <dhv:label name="accounts.accounts_contacts_calls_details.Modified">Modified</dhv:label>
      </td>
      <td>
        <dhv:username id="<%= Revenue.getModifiedBy() %>" />
        -
        <%= Revenue.getModifiedDateTimeString() %>
      </td>
    </tr>
  </table>
  <br>
  <dhv:permission name="accounts-accounts-revenue-edit"><input type="button" value="<dhv:label name="global.button.modify">Modify</dhv:label>" onClick="javascript:this.form.action='RevenueManager.do?command=Modify&id=<%=Revenue.getId()%>&orgId=<%=Revenue.getOrgId()%>';submit();"></dhv:permission>
  <dhv:permission name="accounts-accounts-revenue-delete"><input type="button" value="<dhv:label name="global.button.delete">Delete</dhv:label>" onClick="javascript:this.form.action='RevenueManager.do?command=Delete&id=<%=Revenue.getId()%>&orgId=<%=Revenue.getOrgId()%>';confirmSubmit(this.form);"></dhv:permission>
</dhv:container>
</form>
