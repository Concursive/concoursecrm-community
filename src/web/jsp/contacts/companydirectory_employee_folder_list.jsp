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
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.contacts.base.*,org.aspcfs.modules.base.*" %>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="CategoryList" class="org.aspcfs.modules.base.CustomFieldCategoryList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<form name="details" action="ExternalContacts.do?command=Fields&contactId=<%= ContactDetails.getId() %>" method="post">
<dhv:evaluate if="<%= !isPopup(request) %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="CompanyDirectory.do?command=ListEmployees"><dhv:label name="employees.employees">Employees</dhv:label></a> >
<a href="CompanyDirectory.do?command=ListEmployees"><dhv:label name="employees.view">View Employees</dhv:label></a> >
<a href="CompanyDirectory.do?command=EmployeeDetails&empid=<%= ContactDetails.getId() %>"><dhv:label name="employees.details">Employee Details</dhv:label></a> >
<dhv:label name="accounts.Folders">Folders</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>
<dhv:container name="employees" selected="folders" object="ContactDetails" param="<%= "id=" + ContactDetails.getId() %>" appendToUrl="<%= addLinkParams(request, "popup|popupType|actionId") %>">
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
    <tr>
      <th>
        <dhv:label name="accounts.accounts_documents_folders_add.Folder">Folder</dhv:label>
      </th>
      <th>
        <dhv:label name="accounts.accounts_documents_folders_add.Records">Records</dhv:label>
      </th>
    </tr>
    <%
      Iterator j = CategoryList.iterator();
      if ( j.hasNext() ) {
        int rowid = 0;
        int i = 0;
        while (j.hasNext()) {
        i++;
        rowid = (rowid != 1 ? 1 : 2);
        CustomFieldCategory thisCategory = (CustomFieldCategory) j.next();
    %>
    <tr class="containerBody">
      <td class="row<%= rowid %>">
        <a href="CompanyDirectory.do?command=Fields&empid=<%= ContactDetails.getId() %>&catId=<%= thisCategory.getId() %>"><%= toHtml(thisCategory.getName()) %></a>
      </td>
      <td class="row<%= rowid %>">
        <%= thisCategory.getNumberOfRecords() %>
      </td>
    </tr>
    <% } %>
  <% } else { %>
    <tr class="row2">
      <td colspan="2">
        <dhv:label name="accounts.accounts_fields_list.NoCustomFoldersAvailable">No custom folders available.</dhv:label>
      </td>
    </tr>
    <% } %>
  </table>
  <%= addHiddenParams(request, "popup|popupType|actionId") %>
  </dhv:container>
</form>
