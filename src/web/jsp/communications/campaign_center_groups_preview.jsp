<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*" %>
<jsp:useBean id="Campaign" class="com.darkhorseventures.cfsbase.Campaign" scope="request"/>
<jsp:useBean id="SCL" class="com.darkhorseventures.cfsbase.SearchCriteriaList" scope="request"/>
<jsp:useBean id="ContactList" class="com.darkhorseventures.cfsbase.ContactList" scope="request"/>
<jsp:useBean id="CampaignCenterPreviewInfo" class="com.darkhorseventures.webutils.PagedListInfo" scope="session"/>
<%@ include file="initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="/javascript/confirmDelete.js"></script>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
      <strong>Group Preview: </strong><%= toHtml(SCL.getGroupName()) %>
    </td>
  </tr>
  <tr>
    <td class="containerBack">
      <ul>
        <li>A recipient can be removed from this campaign</li>
        <li>The removed recipient will not be deleted from the group or from other campaigns</li>
      </ul>
<%--
<a href="/CampaignManager.do?command=ViewGroups&id=<%= Campaign.getId() %>">Back to Group List</a>
<br>&nbsp;
--%>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr bgcolor="#DEE0FA">
    <td colspan="4" valign="center" align="left">
      <strong>Contacts in this group</strong>
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
      Included
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
      <%= toHtml(thisContact.getNameLastFirst()) %>
    </td>
    <td nowrap>
      <%= toHtml(thisContact.getCompany()) %>
    </td>
    <td align="center" nowrap>
      <dhv:permission name="campaign-campaigns-edit"><a href="/CampaignManager.do?command=ToggleRecipient&scl=<%=SCL.getId()%>&id=<%= Campaign.getId() %>&contactId=<%= thisContact.getId()%>"></dhv:permission><%= (thisContact.excludedFromCampaign()? "No" : "Yes") %><dhv:permission name="campaign-campaigns-edit"></a></dhv:permission>
    </td>
  </tr>
  <input type="hidden" name="id" value="<%= Campaign.getId() %>">
  <input type="hidden" name="scl" value="<%= SCL.getId() %>">
  <%}%>
</table>
<br>
<dhv:pagedListControl object="CampaignCenterPreviewInfo"/>
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
