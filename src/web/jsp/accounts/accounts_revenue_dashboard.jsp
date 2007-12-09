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
<%@ page import="java.util.*,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.admin.base.User" %>
<jsp:useBean id="ShortChildList" class="org.aspcfs.modules.admin.base.UserList" scope="request"/>
<jsp:useBean id="MyRevList" class="org.aspcfs.modules.accounts.base.OrganizationList" scope="request"/>
<jsp:useBean id="RevenueTypeList" class="org.aspcfs.modules.accounts.base.RevenueTypeList" scope="request"/>
<jsp:useBean id="YearList" class="org.aspcfs.utils.web.HtmlSelect" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>
<%@ include file="../initPage.jsp" %>
<%-- Read in the image map for the graph --%>
<% String includePage = "../graphs/" + (String) request.getAttribute("GraphFileName") + ".map"; %>          
<jsp:include page="<%= includePage %>" flush="true"/>
<form name="Dashboard" action="RevenueManager.do?command=Dashboard" method="POST">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Accounts.do"><dhv:label name="accounts.accounts">Accounts</dhv:label></a> > 
<dhv:label name="accounts.accounts_revenue_dashboard.RevenueDashboard">Revenue Dashboard</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <%-- Left Column --%>
    <td width="275" valign="top">
      <%-- Graphic --%>
      <table cellpadding="3" cellspacing="0" width="275" class="details">
        <tr>
          <th width="255" valign="center" style="text-align: center;">
		<% if (((String)request.getSession().getAttribute("revenueoverride")) == null) {%>
      <dhv:label name="accounts.accounts_revenue_dashboard.MyDashboard">My Dashboard</dhv:label>
		<%} else {%>
      <dhv:label name="communications.campaign.Dashboard">Dashboard</dhv:label>: <%=toHtml((String)request.getSession().getAttribute("revenueothername"))%>
		<%}%>
          </th>
          <th width="20" valign="center" style="text-align: center;">
            <% YearList.setJsEvent("onChange=\"document.Dashboard.submit();\""); %>
<%
      if (request.getParameter("year") != null) {
        YearList.setDefaultValue(request.getParameter("year"));
      } else if (((String)request.getSession().getAttribute("revenueyear")) != null) {
        YearList.setDefaultValue(((String)request.getSession().getAttribute("revenueyear")));
      }
%>
            <%= YearList.getHtml() %>
          </th>
        </tr>
        <tr>
          <td colspan="2">
            <img src="graphs/<%= request.getAttribute("GraphFileName") %>.jpg" width="275" height="200" border="0" usemap="#<%= request.getAttribute("GraphFileName") %>">
          </td>
        </tr>
        <tr>
          <td width="275" valign="center" colspan="2" style="text-align: center;">
            <img src="images/icons/stock_chart-reorganize-16.gif" align="absMiddle" alt="" />
            <dhv:label name="accounts.accounts_add.Type">Type</dhv:label>&nbsp;
            <% if (request.getParameter("type") != null) { %>
              <%= RevenueTypeList.getHtmlSelect("type", Integer.parseInt(request.getParameter("type"))) %>&nbsp;
            <%} else if ((String)request.getSession().getAttribute("revenuetype") != null) {%>
              <%= RevenueTypeList.getHtmlSelect("type", Integer.parseInt((String)request.getSession().getAttribute("revenuetype"))) %>&nbsp;
            <%} else {%>
              <%= RevenueTypeList.getHtmlSelect("type", 0) %>&nbsp;
            <%}%>
          </td>
        </tr>
      </table>
      <%-- Up a level --%>
      <table width="285" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td style="text-align: center;" width="100%">
	<% if (!(((String)request.getSession().getAttribute("revenueoverride")) == null)) {%>
      <input type="hidden" name="oid" value="<%=((String)request.getSession().getAttribute("revenueoverride"))%>">
      <a href="RevenueManager.do?command=Dashboard&oid=<%= ((String)request.getSession().getAttribute("revenuepreviousId")) %>"><dhv:label name="accounts.accounts_revenue_dashboard.UpOneLevel">Up One Level</dhv:label></a> |
      <a href="RevenueManager.do?command=Dashboard&reset=1"><dhv:label name="accounts.accounts_revenue_dashboard.BackMyDashboard">Back to My Dashboard</dhv:label></a>
	<%} else {%>
      &nbsp;
  <%}%>
          </td>
        </tr>
      </table>
      <%-- User List --%>
      <table cellpadding="3" cellspacing="0" width="285" class="details">
        <tr>
          <th><dhv:label name="accounts.accounts_revenue_dashboard.ReportingStaff">Reporting Staff</dhv:label></th>
          <th><dhv:label name="accounts.accounts_revenue_dashboard.YTD">YTD</dhv:label></th>
        </tr>
<%
		Iterator x = ShortChildList.iterator();
		if ( x.hasNext() ) {
			int rowid = 0;
			while (x.hasNext()) {
				if (rowid != 1) {
          rowid = 1;
				} else {
          rowid = 2;
				}
			User thisRec = (User)x.next();
%>
        <tr>
          <td width="100%" class="row<%= rowid %>" valign="center" nowrap>
            <a href="RevenueManager.do?command=Dashboard&oid=<%=thisRec.getId()%>"><%= toHtml(thisRec.getContact().getNameLastFirst()) %></a>
            <dhv:evaluate if="<%=!(thisRec.getEnabled())%>"><font color="red">*</font></dhv:evaluate>
          </td>
          <td width="55" nowrap class="row<%= rowid %>" valign="center">
            <zeroio:currency value="<%= thisRec.getYTD() %>" code='<%= applicationPrefs.get("SYSTEM.CURRENCY") %>' locale="<%= User.getLocale() %>" default="&nbsp;"/>
          </td>
        </tr>
      <%}
    } else {
%>
        <tr>
          <td valign="center" colspan="2"><dhv:label name="accounts.accounts_revenue_dashboard.NoReportingStaff">No Reporting staff.</dhv:label></td>
        </tr>
    <%}%>
      </table>
    </td>
    <td valign="top" width="100%">
      <table cellpadding="3" cellspacing="0" width="100%" class="details">
        <tr>
          <th><dhv:label name="organization.name">Account Name</dhv:label></th>
          <th><dhv:label name="accounts.accounts_revenue_dashboard.YTD">YTD</dhv:label></th>
        </tr>
<%
	Iterator n = MyRevList.iterator();
		if ( n.hasNext() ) {
			int rowid = 0;
			while (n.hasNext()) {
        rowid = (rowid != 1?1:2);
				Organization thisOrg = (Organization)n.next();
%>
				<tr>
          <td class="row<%= rowid %>" valign="top">
            <a href="RevenueManager.do?command=View&orgId=<%=thisOrg.getId()%>"><%= toHtml(thisOrg.getName()) %></a>
          </td>
          <td class="row<%= rowid %>" valign="center" width="50" nowrap>
            <zeroio:currency value="<%= thisOrg.getYTD() %>" code='<%= applicationPrefs.get("SYSTEM.CURRENCY") %>' locale="<%= User.getLocale() %>" default="&nbsp;"/>
          </td>
        </tr>
<%    }
	  } else {
%>
        <tr>
          <td valign="center" colspan="7"><dhv:label name="accounts.revenue.dashboard.notFound">No account found with revenue.</dhv:label></td>
        </tr>
<%}%>
      </table>
      <br>
    </td>
  </table>
  <br>
</form>
