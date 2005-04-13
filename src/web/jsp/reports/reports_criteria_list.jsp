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
<%@ page import="org.aspcfs.modules.admin.base.*" %>
<%@ page import="org.aspcfs.modules.reports.base.*" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="category" class="org.aspcfs.modules.admin.base.PermissionCategory" scope="request"/>
<jsp:useBean id="report" class="org.aspcfs.modules.reports.base.Report" scope="request"/>
<jsp:useBean id="criteriaList" class="org.aspcfs.modules.reports.base.CriteriaList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>
<%@ include file="reports_criteria_menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<script language="JavaScript" type="text/javascript">
  <%-- Preload image rollovers for drop-down menu --%>
  loadImages('select');
</script>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Reports.do"><dhv:label name="qa.reports">Reports</dhv:label></a> >
<a href="Reports.do"><dhv:label name="reports.queue">Queue</dhv:label></a> >
<a href="Reports.do?command=RunReport"><dhv:label name="admin.modules">Modules</dhv:label></a> >
<a href="Reports.do?command=ListReports&categoryId=<%= category.getId() %>"><%= toHtml(category.getCategory()) %></a> >
<dhv:label name="reports.criteriaList">Criteria List</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<strong><%= toHtml(report.getTitle()) %>:</strong>
<%= toHtml(report.getDescription()) %>
<p><dhv:label name="reports.baseReportOnSavedCriteria.text">Choose to base this report on previously saved criteria, or continue and create new criteria:</dhv:label></p>
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <tr>
    <th>
      &nbsp;
    </th>
    <th width="100%">
      <strong><dhv:label name="accounts.accounts_contacts_calls_details_include.Subject">Subject</dhv:label></strong>
    </th>
    <th>
      <strong><dhv:label name="quotes.date">Date</dhv:label></strong>
    </th>
  </tr>
<dhv:evaluate if="<%= criteriaList.size() == 0 %>">
  <tr>
    <td colspan="3"><dhv:label name="reports.noCriteriaFound">No criteria found, choose continue to create new criteria.</dhv:label></td>
  </tr>
</dhv:evaluate>
<%
  Iterator i = criteriaList.iterator();
  int row = 0;
  while (i.hasNext()) {
    Criteria criteria = (Criteria) i.next();
%>
  <tr class="row<%= ++row%2 == 0 ? "2" : "1" %>">
    <td><a href="javascript:displayMenu('select<%= criteria.getId() %>','menu1','<%= criteria.getId() %>');" onMouseOver="over(0, <%= criteria.getId() %>)" onmouseout="out(0, <%= criteria.getId() %>); hideMenu('menu1');"><img src="images/select.gif" name="select<%= criteria.getId() %>" id="select<%= criteria.getId() %>" align="absmiddle" border="0"></a></td>
    <td><a href="Reports.do?command=ParameterList&categoryId=<%= category.getId() %>&reportId=<%= report.getId() %>&criteriaId=<%= criteria.getId() %>"><%= toHtml(criteria.getSubject()) %></a></td>
    <td nowrap><%= criteria.getModified() %></td>
  </tr>
<%
  }
%>
</table>
<br>
<input type="button" value="<dhv:label name="button.continue">Continue</dhv:label>" onClick="javascript:window.location.href='Reports.do?command=ParameterList&categoryId=<%= category.getId() %>&reportId=<%= report.getId() %>&criteriaId=-1'"/>
