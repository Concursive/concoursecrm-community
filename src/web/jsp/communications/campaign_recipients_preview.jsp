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
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.communications.base.*,org.aspcfs.modules.contacts.base.Contact" %>
<jsp:useBean id="Campaign" class="org.aspcfs.modules.communications.base.Campaign" scope="request"/>
<jsp:useBean id="RecipientList" class="org.aspcfs.modules.communications.base.RecipientList" scope="request"/>
<jsp:useBean id="CampaignDashboardRecipientInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<%@ include file="../initPage.jsp" %>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="CampaignManager.do">Communications</a> >
<a href="CampaignManager.do?command=Dashboard">Dashboard</a> >
<a href="CampaignManager.do?command=Details&id=<%=Campaign.getId()%>">Campaign Details</a> >
Recipients
</td>
</tr>
</table>
<%-- End Trails --%>
<strong>Campaign: </strong><%= toHtml(Campaign.getName()) %>
<% String param1 = "id=" + Campaign.getId(); %>
<dhv:container name="communications" selected="recipients" param="<%= param1 %>" style="tabs"/>
<table cellpadding="4" cellspacing="0" width="100%">
  <tr>
    <td class="containerBack">
    <center><%= CampaignDashboardRecipientInfo.getAlphabeticalPageLinks() %></center>
    <dhv:pagedListStatus title="<%= showAttribute(request, "actionError") %>" object="CampaignDashboardRecipientInfo"/>
	<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
	  <tr>
	    <th colspan="6">
	      <strong>List of Recipients</strong>
	    </th>     
	  </tr>
	  <tr>
	    <th width="24" align="center" nowrap>
	      Count
	    </th>
	    <th>
	      Name
	    </th>
	    <th width="100%">
	      Company
	    </th>
	    <th align="center" nowrap>
	      Sent Date
	    </th>
	    <th align="center" nowrap>
	      Status
	    </th>
	  </tr>
	<%
		Iterator j = RecipientList.iterator();
		if ( j.hasNext() ) {
			int rowid = 0;
			int count = CampaignDashboardRecipientInfo.getCurrentOffset();
		  while (j.hasNext()) {
				count++;		
				rowid = (rowid != 1?1:2);
	      Recipient thisRecipient = (Recipient)j.next();
	      Contact thisContact = thisRecipient.getContact();
	%>      
	  <tr class="row<%= rowid %>">
	    <td align="right" nowrap>
	      <%= count %>
	    </td>
	    <td nowrap>
	      <%= toHtml(thisContact.getNameFull()) %>
	    </td>
	    <td width="100%">
	      <%= toHtml(thisContact.getCompany()) %>
	    </td>
	    <td align="center" nowrap>
        <zeroio:tz timestamp="<%= thisRecipient.getSentDate() %>" dateOnly="true" default="&nbsp;"/>
	    </td>
	    <td align="center" nowrap>
	      <%= toHtml(thisRecipient.getStatus()) %>
	    </td>
	  </tr>
	  <%}%>
	</table>
	<br>
	<dhv:pagedListControl object="CampaignDashboardRecipientInfo" />
	<%} else {%>
	  <tr class="containerBody">
	    <td colspan="6">
	      No recipients found.
	    </td>
	  </tr>
	</table>
	<%}%>
     </td>
   </tr>
</table>
