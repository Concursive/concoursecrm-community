<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*" %>
<jsp:useBean id="Campaign" class="com.darkhorseventures.cfsbase.Campaign" scope="request"/>
<jsp:useBean id="sclList" class="com.darkhorseventures.cfsbase.SearchCriteriaListList" scope="request"/>
<%@ include file="initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="/javascript/confirmDelete.js"></script>
<form name="modForm" action="/CampaignManager.do?command=RemoveGroups&id=<%= Campaign.getId() %>" method="post">
<a href="/CampaignManager.do?command=View">Back to Campaign List</a><br>&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
      <strong><%= toHtml(Campaign.getName()) %></strong>
    </td>
  </tr>
  <tr class="containerMenu">
    <td>
      <a href="/CampaignManager.do?command=ViewDetails&id=<%= Campaign.getId() %>"><font color="#000000">Details</font></a><dhv:permission name="campaign-campaigns-groups-view"> |
      <a href="/CampaignManager.do?command=ViewGroups&id=<%= Campaign.getId() %>"><font color="#0000FF">Groups</font></a></dhv:permission><dhv:permission name="campaign-campaigns-messages-view"> | 
      <a href="/CampaignManager.do?command=ViewMessage&id=<%= Campaign.getId() %>"><font color="#000000">Message</font></a></dhv:permission><dhv:permission name="campaign-campaigns-view"> | 
      <a href="/CampaignManager.do?command=ViewSchedule&id=<%= Campaign.getId() %>"><font color="#000000">Schedule</font></a></dhv:permission>
    </td>
  </tr>
  <tr>
    <td class="containerBack">
<dhv:permission name="campaign-campaigns-edit"><a href="/CampaignManager.do?command=AddGroups&id=<%= Campaign.getId() %>">Add/Manage Groups</a><br>&nbsp;</dhv:permission>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">

  <tr class="title">
    <td colspan=3 valign=center align=left>
      <strong>Selected groups for this campaign</strong>
    </td>     
  </tr>
<%
  Iterator i = sclList.iterator();
  int rowid = 0;
  while (i.hasNext()) {
    if (rowid != 1) { rowid = 1; } else { rowid = 2; }
    SearchCriteriaList thisList = (SearchCriteriaList)i.next();
%>  
  <tr class="containerBody">
    <dhv:permission name="campaign-campaigns-edit">
    <td width=8 valign=center nowrap class="row<%= rowid %>">
      <input type="checkbox" name="<%= thisList.getId() %>">
    </td>
    </dhv:permission>
    <td width="100%" valign="center" nowrap class="row<%= rowid %>">
      <%= toHtml(thisList.getGroupName()) %>
    </td>
    <td nowrap class="row<%= rowid %>">
      <a href="/CampaignManager.do?command=PreviewGroups&id=<%= Campaign.getId() %>&scl=<%= thisList.getId() %>">Preview Recipients</a>
    </td>
  </tr>
<%
  }
  if (sclList.size() == 0) {
%>  
  <tr class="containerBody">
    <td colspan="3">
      No groups selected.
    </td>
  </tr>
<%  
  }
%>
</table>
<dhv:permission name="campaign-campaigns-edit">
<br>
<input type='submit' value="Remove Selected Groups" name="Remove">
</dhv:permission>
  </td>
  </tr>
</table>
</form>
