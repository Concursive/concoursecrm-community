<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.troubletickets.base.Ticket,com.zeroio.iteam.base.*" %>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="TicList" class="org.aspcfs.modules.troubletickets.base.TicketList" scope="request"/>
<jsp:useBean id="AccountTicketInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<a href="Accounts.do">Account Management</a> > 
<a href="Accounts.do?command=Search">Search Results</a> >
<a href="Accounts.do?command=Details&orgId=<%=OrgDetails.getOrgId()%>">Account Details</a> >
Tickets<br>
<hr color="#BFBFBB" noshade>
<%@ include file="accounts_details_header_include.jsp" %>
<% String param1 = "orgId=" + OrgDetails.getOrgId(); %>      
<dhv:container name="accounts" selected="tickets" param="<%= param1 %>" style="tabs"/>
<table cellpadding="4" cellspacing="0" border="0" width="100%">
  <tr>
    <td class="containerBack">
<dhv:permission name="accounts-accounts-tickets-add"><a href="AccountTickets.do?command=AddTicket&orgId=<%= OrgDetails.getOrgId() %>">Add New Ticket</a>
<input type=hidden name="orgId" value="<%= OrgDetails.getOrgId() %>">
<br>
</dhv:permission>
<dhv:pagedListStatus title="<%= showError(request, "actionError") %>" object="AccountTicketInfo"/>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
  <tr>
    <dhv:permission name="accounts-accounts-tickets-edit,accounts-accounts-tickets-delete">
    <th>
      <strong>Action</strong>
    </th>
    </dhv:permission>
    <th valign="center" align="left">
      <strong>Number</strong>
    </th>
    <th>
      <b><strong><a href="Accounts.do?command=ViewTickets&orgId=<%= OrgDetails.getOrgId() %>&column=pri_code">Priority</a></strong></b>
      <%= AccountTicketInfo.getSortIcon("pri_code") %>
    </th>
    <th>
      <b>Age</b>
    </th>
		<th>
      <b>Assigned&nbsp;To</b>
    </th>
    <th>
      <b>Modified</b>
    </th>
    </tr>
<%
	Iterator j = TicList.iterator();
	if ( j.hasNext() ) {
		int rowid = 0;
    while (j.hasNext()) {
      rowid = (rowid != 1?1:2);
      Ticket thisTic = (Ticket)j.next();
%>   
	<tr class="containerBody">
    <dhv:permission name="accounts-accounts-tickets-edit,accounts-accounts-tickets-delete">
    <td rowspan="2" width="8" valign="top" nowrap class="row<%= rowid %>">
      <dhv:permission name="accounts-accounts-tickets-edit"><a href="AccountTickets.do?command=ModifyTicket&id=<%=thisTic.getId()%>&return=list">Edit</a></dhv:permission><dhv:permission name="accounts-accounts-tickets-edit,accounts-accounts-tickets-delete" all="true">|</dhv:permission><dhv:permission name="accounts-accounts-tickets-delete"><a href="javascript:popURL('AccountTickets.do?command=ConfirmDelete&orgId=<%=OrgDetails.getOrgId()%>&id=<%=thisTic.getId()%>&popup=true', 'Delete_ticket','320','200','yes','no');">Del</a></dhv:permission>
    </td>
    </dhv:permission>
    <td width="15" valign="top" nowrap>
			<a href="AccountTickets.do?command=TicketDetails&id=<%= thisTic.getId() %>"><%= thisTic.getPaddedId() %></a>
		</td>
		<td width="10" valign="top" nowrap>
			<%= toHtml(thisTic.getPriorityName()) %>
		</td>
		<td width="8%" align="right" valign="top" nowrap>
			<%= thisTic.getAgeOf() %>
		</td>
		<td width="150" nowrap valign="top">
			<dhv:username id="<%= thisTic.getAssignedTo() %>" default="-- unassigned --"/><dhv:evaluate exp="<%= !(thisTic.getHasEnabledOwnerAccount()) %>">&nbsp;<font color="red">*</font></dhv:evaluate>
		</td>
    <td width="150" nowrap valign="top">
      <% if (thisTic.getClosed() == null) { %>
        <%= thisTic.getModifiedDateTimeString() %>
      <%} else {%>
            <%= thisTic.getClosedDateTimeString() %>
      <%}%>
    </td>
   </tr>
   <tr class="row<%= rowid %>">
    <td colspan="6" valign="top">
      <%
        if (1==1) {
          Iterator files = thisTic.getFiles().iterator();
          while (files.hasNext()) {
            FileItem thisFile = (FileItem)files.next();
            if (".wav".equalsIgnoreCase(thisFile.getExtension())) {
      %>
        <a href="AccountTicketsDocuments.do?command=Download&stream=true&tId=<%= thisTic.getId() %>&fid=<%= thisFile.getId() %>"><img src="images/file-audio.gif" border="0" align="absbottom"></a>
      <%
            }
          }
        }
      %>
      <%= toHtml(thisTic.getProblemHeader()) %>&nbsp;
      <% if (thisTic.getClosed() == null) { %>
        [<font color="green">open</font>]
      <%} else {%>
        [<font color="red">closed</font>]
      <%}%>
    </td>
  </tr>
<%}%>
<%} else {%>
  <tr class="containerBody">
    <td colspan="7">
      No tickets found.
    </td>
  </tr>
<%}%>
</table>
	<br>
  <dhv:pagedListControl object="AccountTicketInfo"/>
<br>
</td>
</tr>
</table>

