<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*" %>
<%@ page import="org.aspcfs.modules.admin.base.*" %>
<%@ page import="org.aspcfs.modules.reports.base.*" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="category" class="org.aspcfs.modules.admin.base.PermissionCategory" scope="request"/>
<jsp:useBean id="report" class="org.aspcfs.modules.reports.base.Report" scope="request"/>
<jsp:useBean id="criteria" class="org.aspcfs.modules.reports.base.Criteria" scope="request"/>
<jsp:useBean id="parameterList" class="org.aspcfs.modules.reports.base.ParameterList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkDate.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>
<form name="paramForm" method="post" action="Reports.do?command=GenerateReport&categoryId=<%= category.getId() %>&reportId=<%= report.getId() %>&criteriaId=<%= request.getParameter("criteriaId") %>">
<%-- trails --%>
<a href="Reports.do">Reports</a> >
<a href="Reports.do?command=RunReport">Run Report</a> >
<a href="Reports.do?command=ListReports&categoryId=<%= category.getId() %>">Reports</a> >
<a href="Reports.do?command=CriteriaList&categoryId=<%= category.getId() %>&reportId=<%= report.getId() %>">Criteria List</a> >
Parameters<br>
<hr color="#BFBFBB" noshade>
<%-- end trails --%>
<strong><%= toHtml(category.getCategory()) %></strong><br>
<strong><%= toHtml(report.getTitle()) %>:</strong>
<%= toHtml(report.getDescription()) %>
<p>The following parameters must be specified for this report:</p>
<table cellpadding="4" cellspacing="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong>Parameters</strong>
    </th>
  </tr>
<dhv:evaluate if="<%= parameterList.size() == 0 %>">
  <tr>
    <td colspan="2">No parameters required.</td>
  </tr>
</dhv:evaluate>
<%
  Iterator i = parameterList.iterator();
  while (i.hasNext()) {
    Parameter parameter = (Parameter) i.next();
    //Show only the parameters that require input from the user
%>
<dhv:evaluate if="<%= parameter.getIsForPrompting() %>">
  <tr>
    <td class="formLabel"><%= toHtml(parameter.getDisplayName()) %></td>
    <td><%= parameter.getHtml(request) %></td>
  </tr>
</dhv:evaluate>
<%
  }
%>
</table>
<br>
<table cellpadding="4" cellspacing="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong>Name the criteria for future reference</strong>
    </th>
  </tr>
  <tr>
    <td class="formLabel">Subject</td>
    <td><input type="text" name="criteria_subject" size="35" value="<%= toHtmlValue(criteria.getSubject()) %>"/>
    (optional)</td>
  </tr>
</table>
<%-- No previously saved criteria --%>
<dhv:evaluate if="<%= request.getParameter("criteriaId").equals("-1") %>">
<input type="checkbox" name="save" value="true"> Save this criteria for generating future reports<br />
</dhv:evaluate>
<%-- Using previously saved criteria --%>
<dhv:evaluate if="<%= !request.getParameter("criteriaId").equals("-1") %>">
<input type="radio" name="saveType" value="none" checked> Do not save criteria for generating future reports<br />
<input type="radio" name="saveType" value="overwrite"> Overwrite previously saved criteria<br />
<input type="radio" name="saveType" value="save"> Save a new copy of this criteria<br />
</dhv:evaluate>
<br />
<input type="submit" value="Generate Report"/>
</form>
