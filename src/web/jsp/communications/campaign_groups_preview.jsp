<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*" %>
<jsp:useBean id="ContactList" class="com.darkhorseventures.cfsbase.ContactList" scope="request"/>
<jsp:useBean id="CampaignGroupsPreviewInfo" class="com.darkhorseventures.webutils.PagedListInfo" scope="session"/>
<%@ include file="initPage.jsp" %>
<a href="/CampaignManagerGroup.do?command=View">Back to Group List</a> |
<a href="/CampaignManagerGroup.do?command=Modify&id=<%= request.getAttribute("id") %>">Modify this Group</a>
<br>&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan="3" valign="center" align="left">
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
  </tr>
<%
	Iterator j = ContactList.iterator();
	
	if ( j.hasNext() ) {
		int rowid = 0;
		int count = CampaignGroupsPreviewInfo.getCurrentOffset();
		
	  while (j.hasNext()) {
			count++;		
			if (rowid != 1) {
				rowid = 1;
			} else {
				rowid = 2;
			}
		
		Contact thisContact = (Contact)j.next();
%>      
  <tr>
    <td align="right" nowrap>
      <%= count %>
    </td>
    <td nowrap>
      <%= toHtml(thisContact.getNameLastFirst()) %>
    </td>
    <td nowrap>
      <%= toHtml(thisContact.getCompany()) %>
    </td>
  </tr>
  <%}%>
</table>
<br>
[<%= CampaignGroupsPreviewInfo.getPreviousPageLink("<font class='underline'>Previous</font>", "Previous") %> <%= CampaignGroupsPreviewInfo.getNextPageLink("<font class='underline'>Next</font>", "Next") %>] <%= CampaignGroupsPreviewInfo.getNumericalPageLinks() %>
<%} else {%>
  <tr bgcolor="white">
    <td colspan="3" valign="center">
      No contacts matched query.
    </td>
  </tr>
</table>
<%}%>
