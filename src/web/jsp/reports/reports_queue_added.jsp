<%-- 
  - Copyright Notice: (C) 2000-2004 Dark Horse Ventures, All Rights Reserved.
  - License: This source code cannot be modified, distributed or used without
  -          written permission from Dark Horse Ventures. This notice must
  -          remain in place.
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*" %>
<%@ page import="org.aspcfs.modules.admin.base.*" %>
<%@ page import="org.aspcfs.modules.reports.base.*" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="category" class="org.aspcfs.modules.admin.base.PermissionCategory" scope="request"/>
<jsp:useBean id="report" class="org.aspcfs.modules.reports.base.Report" scope="request"/>
<jsp:useBean id="queuePosition" class="java.lang.String" scope="request" />
<%@ include file="../initPage.jsp" %>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Reports.do">Reports</a> >
<a href="Reports.do">Queue</a> >
<a href="Reports.do?command=RunReport">Modules</a> >
<a href="Reports.do?command=ListReports&categoryId=<%= category.getId() %>"><%= toHtml(category.getCategory()) %></a> >
<a href="Reports.do?command=CriteriaList&categoryId=<%= category.getId() %>&reportId=<%= report.getId() %>&criteriaId=<%= request.getParameter("criteriaId") %>">Criteria List</a> >
<a href="Reports.do?command=ParameterList&categoryId=<%= category.getId() %>&reportId=<%= report.getId() %>&criteriaId=<%= request.getParameter("criteriaId") %>">Parameters</a> >
Report Added
</td>
</tr>
</table>
<%-- End Trails --%>
The following report has been added to the report queue.  The report can be
retrieved from the <a href="Reports.do?command=ViewQueue">queue</a> once the server 
has finished processing the report.<br>
<br>
<table cellpadding="4" cellspacing="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong>Report Added to Queue</strong>
    </th>
  </tr>
  <tr>
    <td class="formLabel">Module</td>
    <td><%= toHtml(category.getCategory()) %></td>
  </tr>
  <tr>
    <td class="formLabel">Title</td>
    <td><%= toHtml(report.getTitle()) %></td>
  </tr>
  <tr>
    <td class="formLabel">Description</td>
    <td><%= toHtml(report.getDescription()) %></td>
  </tr>
  <tr>
    <td class="formLabel">Queue Position</td>
    <td><%= queuePosition %> of <%= queuePosition %></td>
  </tr>
</table>
<br>
<input type="button" value="View Queue" onClick="javascript:window.location.href='Reports.do?command=ViewQueue'"/>
</form>
