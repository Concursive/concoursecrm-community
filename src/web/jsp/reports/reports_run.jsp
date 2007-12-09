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
<%@ page import="java.util.*" %>
<%@ page import="org.aspcfs.modules.admin.base.*" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="categories" class="org.aspcfs.modules.admin.base.PermissionCategoryList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Reports.do"><dhv:label name="qa.reports">Reports</dhv:label></a> >
<a href="Reports.do"><dhv:label name="reports.queue">Queue</dhv:label></a> >
<dhv:label name="admin.modules">Modules</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<dhv:label name="reports.toAddReportToQueue.text">To add a report to the queue, choose a module to see a list of corresponding reports:</dhv:label><br>
<br>
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <tr>
    <th width="100%">
      <strong><dhv:label name="qa.module">Module</dhv:label></strong>
    </th>
  </tr>
<dhv:evaluate if="<%= categories.size() == 0 %>">
  <tr>
    <td><dhv:label name="reports.noModulesFound.text">No modules found with reports enabled</dhv:label></td>
  </tr>
</dhv:evaluate>
<%
  Iterator i = categories.iterator();
  int row = 0;
  while (i.hasNext()) {
    PermissionCategory category = (PermissionCategory) i.next();
%>
  <tr class="row<%= ++row%2 == 0 ? "2" : "1" %>">
    <td><a href="Reports.do?command=ListReports&categoryId=<%= category.getId() %>"><%= toHtml(category.getCategory()) %></a></td>
  </tr>
<%
  }
%>
</table>
