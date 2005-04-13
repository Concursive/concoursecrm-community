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
<%@ page import="java.util.*,org.aspcfs.modules.communications.base.*,org.aspcfs.modules.contacts.base.Contact,org.aspcfs.utils.web.CustomForm" %>
<jsp:useBean id="Campaign" class="org.aspcfs.modules.communications.base.Campaign" scope="request"/>
<jsp:useBean id="SCL" class="org.aspcfs.modules.communications.base.SearchCriteriaList" scope="request"/>
<jsp:useBean id="ContactList" class="org.aspcfs.modules.contacts.base.ContactList" scope="request"/>
<jsp:useBean id="CampaignCenterPreviewInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/div.js"></script>
<script language="JavaScript">
  function toggleRecipient(id) {
    //Send request to iframe
    var url = "CampaignManager.do?command=ToggleRecipient&scl=<%= SCL.getId() %>&id=<%= Campaign.getId() %>&contactId=" + id + "&popup=true";
    window.frames['server_commands'].location.href=url;
    //Returning iframe will set the change+id to the new value (Yes/No)
  }
</script>
<table cellpadding="4" cellspacing="0" width="100%" style="border: 1px solid #000;">
  <tr class="containerHeader">
    <td style="border-bottom: 1px solid #000;">
      <dhv:label name="campaign.groupPreview.colon" param="<%= "scl.groupName="+toHtml(SCL.getGroupName()) %>"><strong>Group Preview:</strong> <%= toHtml(SCL.getGroupName()) %></dhv:label> 
    </td>
  </tr>
  <tr>
    <td class="containerBack">
      <ul>
        <li><dhv:label name="campaign.removeRecipient.text">A recipient can be removed from this campaign</dhv:label></li>
        <li><dhv:label name="campaign.canNotRemoveRecipient.text">The removed recipient will not be deleted from the group or from other campaigns</dhv:label></li>
      </ul>
<table cellpadding="4" cellspacing="0" width="100%" class="details">
  <tr>
    <th colspan="5">
      <strong><dhv:label name="campaign.contactsInTheGroup">Contacts in this group</dhv:label></strong>
    </th>
  </tr>
  <tr>
    <th style="text-align: right;">
      <dhv:label name="campaign.count">Count</dhv:label>
    </th>
    <th width="33%">
      <dhv:label name="contacts.name">Name</dhv:label>
    </th>
    <th width="33%">
      <dhv:label name="accounts.accounts_contacts_detailsimport.Company">Company</dhv:label>
    </th>
    <th width="34%">
      <dhv:label name="accounts.accounts_add.Email">Email</dhv:label>
    </th>
    <th align="center">
      <dhv:label name="campaign.included">Included</dhv:label>
    </th>
  </tr>
<%
	Iterator j = ContactList.iterator();
	if ( j.hasNext() ) {
		int rowid = 0;
		int count = CampaignCenterPreviewInfo.getCurrentOffset();
	  while (j.hasNext()) {
			count++;		
			rowid = (rowid != 1?1:2);
      Contact thisContact = (Contact)j.next();
%>      
  <tr class="containerBody">
    <td align="right" nowrap>
      <%= count %>
    </td>
    <td>
      <%= toHtml(thisContact.getNameLastFirst()) %>
    </td>
    <td>
      <%= toHtml(thisContact.getAffiliation()) %>
    </td>
    <td nowrap>
      <%= toHtml(thisContact.getPrimaryEmailAddress()) %>
    </td>
    <td align="center" nowrap>
      <div id="change<%= thisContact.getId() %>">
        <dhv:permission name="campaign-campaigns-edit"><a href="javascript:toggleRecipient(<%= thisContact.getId()%>)"></dhv:permission><%= (thisContact.excludedFromCampaign()? "No" : "Yes") %><dhv:permission name="campaign-campaigns-edit"></a></dhv:permission>
      </div>
    </td>
  </tr>
  <%}%>
  <iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>
  <input type="hidden" name="id" value="<%= Campaign.getId() %>">
  <input type="hidden" name="scl" value="<%= SCL.getId() %>">
</table>
<br>
<dhv:pagedListControl object="CampaignCenterPreviewInfo"/>
<%} else {%>
  <tr class="containerBody">
    <td colspan="5">
      <dhv:label name="campaign.noContactsMatchedQuery">No contacts matched query.</dhv:label>
    </td>
  </tr>
</table>
<%}%>
  </td>
  </tr>
</table>
<input type="button" value="<dhv:label name="button.closeWindow">Close Window</dhv:label>" onClick="javascript:window.close()">
