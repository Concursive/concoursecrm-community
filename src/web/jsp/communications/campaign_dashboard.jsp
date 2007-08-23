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
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.communications.base.*" %>
<jsp:useBean id="campList" class="org.aspcfs.modules.communications.base.CampaignList" scope="request"/>
<jsp:useBean id="CampaignDashboardListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../initPage.jsp" %>
<%@ include file="../initPopupMenu.jsp" %>
<%@ include file="campaign_dashboard_menu.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<script language="JavaScript" type="text/javascript">
  <%-- Preload image rollovers for drop-down menu --%>
  loadImages('select');
</script>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="CampaignManager.do"><dhv:label name="communications.campaign.Communications">Communications</dhv:label></a> >
<dhv:label name="communications.campaign.Dashboard">Dashboard</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<dhv:include name="pagedListInfo.alphabeticalLinks" none="true">
<center><dhv:pagedListAlphabeticalLinks object="CampaignDashboardListInfo"/></center></dhv:include>
<table width="100%" border="0">
  <tr>
    <form name="listView" method="post" action="CampaignManager.do?command=Dashboard">
    <td align="left">
      <select size="1" name="listView" onChange="javascript:document.listView.submit();">
        <option <%= CampaignDashboardListInfo.getOptionValue("my") %>><dhv:label name="campaign.myRunningCampaigns">My Running Campaigns</dhv:label></option>
        <option <%= CampaignDashboardListInfo.getOptionValue("all") %>><dhv:label name="campaign.allRunningCampaigns">All Running Campaigns</dhv:label></option>
        <option <%= CampaignDashboardListInfo.getOptionValue("instant") %>><dhv:label name="campaign.allInstantCampaigns">All Instant Campaigns</dhv:label></option>
        <%--<option <%= CampaignDashboardListInfo.getOptionValue("trashed") %>><dhv:label name="campaign.allTrashedCampaigns">All Trashed Campaigns</dhv:label></option>--%>
      </select>
    </td>
    <td>
      <dhv:pagedListStatus title='<%= showError(request, "actionError") %>' object="CampaignDashboardListInfo"/>
    </td>
    </form>
  </tr>
</table>
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
	<tr>
    <th width="8" align="left" nowrap>
      &nbsp;
    </th>
    <th align="left" nowrap>
      <a href="CampaignManager.do?command=Dashboard&column=c.name"><strong><dhv:label name="contacts.name">Name</dhv:label></strong></a>
      <%= CampaignDashboardListInfo.getSortIcon("c.name") %>
    </th>
    <th align="left" nowrap>
      <a href="CampaignManager.do?command=Dashboard&column=c.active_date"><strong><dhv:label name="documents.details.startDate">Start Date</dhv:label></strong></a>
      <%= CampaignDashboardListInfo.getSortIcon("c.active_date") %>
    </th>
    <th align="left" nowrap>
      <strong><dhv:label name="campaign.numberOfRecipients.symbol"># Recipients</dhv:label></strong>
    </th>
    <th align="left" nowrap>
      <a href="CampaignManager.do?command=Dashboard&column=status"><strong><dhv:label name="accounts.accountasset_include.Status">Status</dhv:label></strong></a>
      <%= CampaignDashboardListInfo.getSortIcon("status") %>
    </th>
    <th align="left" nowrap>
      <a href="CampaignManager.do?command=Dashboard&column=active"><strong><dhv:label name="campaign.active.question">Active?</dhv:label></strong></a>
      <%= CampaignDashboardListInfo.getSortIcon("active") %>
    </th>
	<%
	Iterator j = campList.iterator();
	if ( j.hasNext() ) {
		int rowid = 0;
    int count = 0;
    while (j.hasNext()) {
      count++;
      rowid = (rowid != 1?1:2);
      Campaign campaign = (Campaign)j.next();
	%>      
	<tr class="containerBody">
    <td width="8" valign="center" align="center" nowrap class="row<%= rowid %>">
      <%  boolean cancelPermission = false;
          boolean restartPermission = false;
          boolean deletePermission = false;
          int downloadAvailable = 0;
          if(!campaign.hasRun()) {
            restartPermission = true;
          }
          if(campaign.hasFiles()) {
            downloadAvailable  = 1;
          }
      %>
      <dhv:hasAuthority owner="<%= campaign.getEnteredBy() %>">
        <% 
          if(!campaign.hasRun()) {
            cancelPermission = true;
          }
          deletePermission = true;
        %>
      </dhv:hasAuthority>
      <%-- Use the unique id for opening the menu, and toggling the graphics --%>
      <a href="javascript:displayMenu('select<%= count %>','menuCampaign', '<%= campaign.getId() %>', '<%= cancelPermission %>', '<%= downloadAvailable %>','<%= restartPermission %>', '<%= deletePermission %>');" 
      onMouseOver="over(0, <%= count %>)" onmouseout="out(0, <%= count %>); hideMenu('menuCampaign');"><img src="images/select.gif" name="select<%= count %>" id="select<%= count %>" align="absmiddle" border="0"></a>
    </td>
    <td valign="center" width="100%" class="row<%= rowid %>">
      <a href="CampaignManager.do?command=Details&id=<%=campaign.getId()%>&reset=true"><%=toHtml(campaign.getName())%></a>
      <% if("true".equals(request.getParameter("notify")) && ("" + campaign.getId()).equals(request.getParameter("id"))) {%>
        <font color="red"><dhv:label name="campaign.added.brackets">(Added)</dhv:label></font>
      <%}%>
    </td>
    <td valign="center" align="center" nowrap class="row<%= rowid %>">
      <% if(!User.getTimeZone().equals(campaign.getActiveDateTimeZone())){%>
      <zeroio:tz timestamp="<%= campaign.getActiveDate() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="true" default="&nbsp;"/>
      <% } else { %>
      <zeroio:tz timestamp="<%= campaign.getActiveDate() %>"  timeZone="<%= campaign.getActiveDateTimeZone() %>" showTimeZone="true" default="&nbsp;"/>
      <% } %>
    </td>
    <td valign="center" align="center" nowrap class="row<%= rowid %>">
      <%=campaign.getRecipientCount()%>
    </td>
    <td valign="center" nowrap class="row<%= rowid %>">
      <%=toHtml(campaign.getStatus())%>
    </td>
    <td valign="center" align="center" nowrap class="row<%= rowid %>">
      <%=toHtml(campaign.getActiveYesNo())%>
    </td>
	</tr>
	<%}%>
<%} else {%>
  <tr class="containerBody">
    <td colspan="6">
      <dhv:label name="campaign.noRunningCampaignsFound">No running campaigns found.</dhv:label>
    </td>
  </tr>
<%}%>
</table>
<br>
<dhv:pagedListControl object="CampaignDashboardListInfo" tdClass="row1"/>

