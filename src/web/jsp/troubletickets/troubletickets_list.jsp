<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.troubletickets.base.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="CreatedByMeList" class="org.aspcfs.modules.troubletickets.base.TicketList" scope="request"/>
<jsp:useBean id="CreatedByMeInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="AssignedToMeList" class="org.aspcfs.modules.troubletickets.base.TicketList" scope="request"/>
<jsp:useBean id="AssignedToMeInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="OpenList" class="org.aspcfs.modules.troubletickets.base.TicketList" scope="request"/>
<jsp:useBean id="OpenInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<%@ include file="../initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<a href="TroubleTickets.do">Tickets</a> > 
View Tickets<br>
<hr color="#BFBFBB" noshade>
<% if ((request.getParameter("pagedListSectionId") == null && !(OpenInfo.getExpandedSelection()) && !(CreatedByMeInfo.getExpandedSelection())) || AssignedToMeInfo.getExpandedSelection()) { %>
<dhv:pagedListStatus showExpandLink="true" title="Tickets Assigned to Me" object="AssignedToMeInfo"/>
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <tr>
    <dhv:permission name="tickets-tickets-edit,tickets-tickets-delete">
		<th valign="center" align="left">
      <strong>Action</strong>
    </th>
    </dhv:permission>
    <th valign="center" align="left">
      <strong>Number</strong>
    </th>
    <th><b>Priority</b></th>
    <th><b>Age</b></th>
    <th><b>Company</b></th>
		<th><b>Assigned&nbsp;To</b></th>
  </tr>
<%
	Iterator k = AssignedToMeList.iterator();
	if ( k.hasNext() ) {
		int rowid = 0;
		while (k.hasNext()) {
		  rowid = (rowid != 1?1:2);
      Ticket assignedTic = (Ticket)k.next();
%>   
	<tr class="row<%= rowid %>">
  <dhv:permission name="tickets-tickets-edit,tickets-tickets-delete">
    <td rowspan="2" width="8" valign="top" nowrap>
      <dhv:permission name="tickets-tickets-edit"><a href="TroubleTickets.do?command=Modify&id=<%= assignedTic.getId() %>&return=list">Edit</a></dhv:permission><dhv:permission name="tickets-tickets-edit,tickets-tickets-delete" all="true">|</dhv:permission><dhv:permission name="tickets-tickets-delete"><a href="javascript:popURL('TroubleTickets.do?command=ConfirmDelete&id=<%= assignedTic.getId() %>&popup=true', 'Delete_ticket','320','200','yes','no');">Del</a></dhv:permission>
    </td>
  </dhv:permission>
		<td width="15" valign="top" nowrap>
			<a href="TroubleTickets.do?command=Details&id=<%= assignedTic.getId() %>"><%= assignedTic.getPaddedId() %></a>
		</td>
		<td width="10" valign="top" nowrap>
			<%= toHtml(assignedTic.getPriorityName()) %>
		</td>
		<td width="8%" align="right" valign="top" nowrap>
			<%= assignedTic.getAgeOf() %>
		</td>
		<td width="90%" valign="top">
			<%= toHtml(assignedTic.getCompanyName()) %><dhv:evaluate exp="<%= !(assignedTic.getCompanyEnabled()) %>">&nbsp;<font color="red">*</font></dhv:evaluate>
		</td>
		<td width="150" nowrap valign="top">
			<dhv:username id="<%= assignedTic.getAssignedTo() %>" default="-- unassigned --"/><dhv:evaluate exp="<%= !(assignedTic.getHasEnabledOwnerAccount()) %>">&nbsp;<font color="red">*</font></dhv:evaluate>
		</td>
	</tr>
  <tr class="row<%= rowid %>">
    <td colspan="6" valign="top">
<%
  if (1==1) {
    Iterator files = assignedTic.getFiles().iterator();
    while (files.hasNext()) {
      FileItem thisFile = (FileItem)files.next();
      if (".wav".equalsIgnoreCase(thisFile.getExtension())) {
%>
  <a href="TroubleTicketsDocuments.do?command=Download&stream=true&tId=<%= assignedTic.getId() %>&fid=<%= thisFile.getId() %>"><img src="images/file-audio.gif" border="0" align="absbottom"></a>
<%
      }
    }
  }
%>
      <%= toHtml(assignedTic.getProblemHeader()) %>&nbsp;
      <% if (assignedTic.getClosed() == null) { %>
        [<font color="green">open</font>]
      <%} else {%>
        [<font color="red">closed</font>]
      <%}%>
    </td>
  </tr>
	<%}%>
</table>
  <% if (AssignedToMeInfo.getExpandedSelection()) {%>
<br>
<dhv:pagedListControl object="AssignedToMeInfo" tdClass="row1"/>
  <%}%>
<%} else {%>
  <tr class="containerBody">
    <td colspan="7">
      No tickets found.
    </td>
  </tr>
</table>
	<%}%>
<br>
<%}%>
<% if ( (request.getParameter("pagedListSectionId") == null && !(AssignedToMeInfo.getExpandedSelection()) && !(CreatedByMeInfo.getExpandedSelection())) || OpenInfo.getExpandedSelection()) { %>
<dhv:pagedListStatus showExpandLink="true" title="Other Tickets in My Department" object="OpenInfo"/>
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <tr>
  <dhv:permission name="tickets-tickets-edit,tickets-tickets-delete">
		<th valign="center" align="left">
      <strong>Action</strong>
    </th>
    </dhv:permission>
    <th valign="center" align="left">
      <strong>Number</strong>
    </th>
    <th><b>Priority</b></th>
    <th><b>Age</b></th>
    <th><b>Company</b></th>
		<th><b>Assigned&nbsp;To</b></th>
  </tr>
<%
	Iterator n = OpenList.iterator();
	if ( n.hasNext() ) {
		int rowid = 0;
		while (n.hasNext()) {
      rowid = (rowid != 1?1:2);
      Ticket openTic = (Ticket)n.next();
%>   
	<tr>
	<dhv:permission name="tickets-tickets-edit,tickets-tickets-delete">
    <td rowspan="2" width="8" valign="top" nowrap class="row<%= rowid %>">
      <dhv:permission name="tickets-tickets-edit"><a href="TroubleTickets.do?command=Modify&id=<%= openTic.getId() %>&return=list">Edit</a></dhv:permission><dhv:permission name="tickets-tickets-edit,tickets-tickets-delete" all="true">|</dhv:permission><dhv:permission name="tickets-tickets-delete"><a href="javascript:popURL('TroubleTickets.do?command=ConfirmDelete&id=<%= openTic.getId() %>&popup=true', 'Delete_ticket','320','200','yes','no');">Del</a></dhv:permission>
    </td>
    	</dhv:permission>
		<td width="15" valign="top" nowrap class="row<%= rowid %>">
			<a href="TroubleTickets.do?command=Details&id=<%= openTic.getId() %>"><%= openTic.getPaddedId() %></a>
		</td>
		<td width="10" valign="top" nowrap class="row<%= rowid %>">
			<%= toHtml(openTic.getPriorityName()) %>
		</td>
		<td width="8%" align="right" valign="top" nowrap class="row<%= rowid %>">
			<%= openTic.getAgeOf() %>
		</td>
		<td width="90%" valign="top" class="row<%= rowid %>">
			<%= toHtml(openTic.getCompanyName()) %><dhv:evaluate exp="<%= !(openTic.getCompanyEnabled()) %>">&nbsp;<font color="red">*</font></dhv:evaluate>
		</td>
		<td width="150" nowrap valign="top" class="row<%= rowid %>">
      <dhv:evaluate if="<%= openTic.isAssigned() %>">
        <dhv:username id="<%= openTic.getAssignedTo() %>" default="-- unassigned --"/>
      </dhv:evaluate>
      <dhv:evaluate if="<%= !(openTic.getHasEnabledOwnerAccount()) %>"><font color="red">*</font></dhv:evaluate>
      <dhv:evaluate if="<%= (!openTic.isAssigned()) %>">
        <font color="red"><dhv:username id="<%= openTic.getAssignedTo() %>" default="-- unassigned --"/></font>
      </dhv:evaluate>
		</td>
	</tr>
  <tr>
    <td colspan="6" valign="top" class="row<%= rowid %>">
<%
  if (1==1) {
    Iterator files = openTic.getFiles().iterator();
    while (files.hasNext()) {
      FileItem thisFile = (FileItem)files.next();
      if (".wav".equalsIgnoreCase(thisFile.getExtension())) {
%>
  <a href="TroubleTicketsDocuments.do?command=Download&stream=true&tId=<%= openTic.getId() %>&fid=<%= thisFile.getId() %>"><img src="images/file-audio.gif" border="0" align="absbottom"></a>
<%
      }
    }
  }
%>
      <%= toHtml(openTic.getProblemHeader()) %>
      <% if (openTic.getClosed() == null) { %>
        [<font color="green">open</font>]
      <%} else {%>
        [<font color="red">closed</font>]
      <%}%>
    </td>
  </tr>
	<%}%>
</table>
  <% if (OpenInfo.getExpandedSelection()) {%>
  <br>
  <dhv:pagedListControl object="OpenInfo" tdClass="row1"/>
  <%}%>
	<%} else {%>
		<tr class="containerBody">
      <td colspan="7">
        No tickets found.
      </td>
    </tr>
  </table>
	<%}%>
<br>
<%}%>
<% if ( (request.getParameter("pagedListSectionId") == null && !(AssignedToMeInfo.getExpandedSelection()) && !(OpenInfo.getExpandedSelection())) || CreatedByMeInfo.getExpandedSelection()) { %>
<dhv:pagedListStatus showExpandLink="true" title="Tickets Created by Me" object="CreatedByMeInfo"/>
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <tr>
  <dhv:permission name="tickets-tickets-edit,tickets-tickets-delete">
		<th valign="center" align="left">
      <strong>Action</strong>
    </th>
    </dhv:permission>
    <th valign="center" align="left">
      <strong>Number</strong>
    </th>
    <th><b>Priority</b></th>
    <th><b>Age</b></th>
    <th><b>Company</b></th>
		<th><b>Assigned&nbsp;To</b></th>
  </tr>
<%
	Iterator j = CreatedByMeList.iterator();
	if ( j.hasNext() ) {
		int rowid = 0;
		while (j.hasNext()) {
      rowid = (rowid != 1?1:2);
      Ticket thisTic = (Ticket)j.next();
%>   
	<tr class="row<%= rowid %>">
	<dhv:permission name="tickets-tickets-edit,tickets-tickets-delete">
    <td rowspan="2" width="8" valign="top" nowrap>
      <dhv:permission name="tickets-tickets-edit"><a href="TroubleTickets.do?command=Modify&id=<%= thisTic.getId() %>&return=list">Edit</a></dhv:permission><dhv:permission name="tickets-tickets-edit,tickets-tickets-delete" all="true">|</dhv:permission><dhv:permission name="tickets-tickets-delete"><a href="javascript:popURL('TroubleTickets.do?command=ConfirmDelete&id=<%= thisTic.getId() %>&popup=true', 'Delete_ticket','320','200','yes','no');">Del</a></dhv:permission>
    </td>
    	</dhv:permission>
		<td width="15" valign="top" nowrap>
			<a href="TroubleTickets.do?command=Details&id=<%= thisTic.getId() %>"><%= thisTic.getPaddedId() %></a>
		</td>
		<td width="10" valign="top" nowrap>
			<%= toHtml(thisTic.getPriorityName()) %>
		</td>
		<td width="8%" align="right" valign="top" nowrap>
			<%= thisTic.getAgeOf() %>
		</td>
		<td width="90%" valign="top">
			<%= toHtml(thisTic.getCompanyName()) %><dhv:evaluate exp="<%= !(thisTic.getCompanyEnabled()) %>">&nbsp;<font color="red">*</font></dhv:evaluate>
		</td>
		<td width="150" nowrap valign="top">
      <dhv:evaluate exp="<%= thisTic.isAssigned() %>">
        <dhv:username id="<%= thisTic.getAssignedTo() %>" default="-- unassigned --"/>
      </dhv:evaluate>
      <dhv:evaluate exp="<%= !(thisTic.getHasEnabledOwnerAccount()) %>"><font color="red">*</font></dhv:evaluate>
      <dhv:evaluate exp="<%= (!thisTic.isAssigned()) %>">
        <font color="red"><dhv:username id="<%= thisTic.getAssignedTo() %>" default="-- unassigned --"/></font>
      </dhv:evaluate>
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
  <a href="TroubleTicketsDocuments.do?command=Download&stream=true&tId=<%= thisTic.getId() %>&fid=<%= thisFile.getId() %>"><img src="images/file-audio.gif" border="0" align="absbottom"></a>
<%
      }
    }
  }
%>
      <%= toHtml(thisTic.getProblemHeader()) %>
      <% if (thisTic.getClosed() == null) { %>
        [<font color="green">open</font>]
      <%} else {%>
        [<font color="red">closed</font>]
      <%}%>
    </td>
  </tr>
	<%}%>
</table>
  <% if (CreatedByMeInfo.getExpandedSelection()) {%>
<br>
<dhv:pagedListControl object="CreatedByMeInfo" tdClass="row1"/>
  <%}%>
	<%} else {%>
		<tr class="containerBody">
      <td colspan="7">
        No tickets found.
      </td>
    </tr>
  </table>
	<%}%>
<%}%>
