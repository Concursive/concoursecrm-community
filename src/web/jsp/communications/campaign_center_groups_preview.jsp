<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*" %>
<jsp:useBean id="Campaign" class="com.darkhorseventures.cfsbase.Campaign" scope="request"/>
<jsp:useBean id="SCL" class="com.darkhorseventures.cfsbase.SearchCriteriaList" scope="request"/>
<jsp:useBean id="ContactList" class="com.darkhorseventures.cfsbase.ContactList" scope="request"/>
<jsp:useBean id="CampaignCenterPreviewInfo" class="com.darkhorseventures.webutils.PagedListInfo" scope="session"/>
<%@ include file="initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="/javascript/confirmDelete.js"></script>
<a href="/CampaignManager.do?command=View">Back to Campaign List</a><br>&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
      <strong><%= toHtml(Campaign.getName()) %></strong>
    </td>
  </tr>
  <tr class="containerMenu">
    <td>
      <a href="/CampaignManager.do?command=ViewDetails&id=<%= Campaign.getId() %>"><font color="#000000">Details</font></a> |
      <a href="/CampaignManager.do?command=ViewGroups&id=<%= Campaign.getId() %>"><font color="#0000FF">Groups</font></a> | 
      <a href="/CampaignManager.do?command=ViewMessage&id=<%= Campaign.getId() %>"><font color="#000000">Message</font></a> | 
      <a href="/CampaignManager.do?command=ViewSchedule&id=<%= Campaign.getId() %>"><font color="#000000">Schedule</font></a>
    </td>
  </tr>
  <tr>
    <td class="containerBack">
<a href="/CampaignManager.do?command=ViewGroups&id=<%= Campaign.getId() %>">Back to Group List</a>
<br>&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr bgcolor="#DEE0FA">
    <td colspan="4" valign="center" align="left">
      <strong>List of Matching Contacts</strong>
    </td>     
  </tr>
  <tr class="title">
    <td width="8" align="right" nowrap>
      Count
    </td>
    <td width="50%" nowrap>
      Name
    </td>
    <td width="50%" nowrap>
      Company
    </td>
    <td align="center">
      Enabled
    </td>
  </tr>
<%
	Iterator j = ContactList.iterator();
	
	if ( j.hasNext() ) {
		int rowid = 0;
		int count = CampaignCenterPreviewInfo.getCurrentOffset();
		
	  while (j.hasNext()) {
			count++;		
			if (rowid != 1) {
				rowid = 1;
			} else {
				rowid = 2;
			}
		
		Contact thisContact = (Contact)j.next();
%>      
  <tr class="containerBody">
    <td align="right" nowrap>
      <%= count %>
    </td>
    <td nowrap>
      <%= toHtml(thisContact.getNameLast()) %>, <%= toHtml(thisContact.getNameFirst()) %>
    </td>
    <td nowrap>
      <%= toHtml(thisContact.getCompany()) %>
    </td>
    <td align="center" nowrap>
      <a href="/CampaignManager.do?command=ToggleRecipient&scl=<%=SCL.getId()%>&id=<%= Campaign.getId() %>&contactId=<%= thisContact.getId() %>"><%= (thisContact.excludedFromCampaign()? "No" : "Yes") %></a>
    </td>
  </tr>
  <%}%>
</table>
<br>
[<%= CampaignCenterPreviewInfo.getPreviousPageLink("<font class='underline'>Previous</font>", "Previous") %> <%= CampaignCenterPreviewInfo.getNextPageLink("<font class='underline'>Next</font>", "Next") %>] <%= CampaignCenterPreviewInfo.getNumericalPageLinks() %>
<%} else {%>
  <tr class="containerBody">
    <td colspan="4" valign="center">
      No contacts matched query.
    </td>
  </tr>
</table>
<%}%>
  </td>
  </tr>
</table>
