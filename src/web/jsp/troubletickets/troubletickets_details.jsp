<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.troubletickets.base.*,com.zeroio.iteam.base.*, org.aspcfs.modules.base.EmailAddress" %>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.troubletickets.base.Ticket" scope="request"/>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<%@ include file="../initPage.jsp" %>
<form name="details" action="TroubleTickets.do?command=Modify&auto-populate=true" method="post">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="TroubleTickets.do">Help Desk</a> > 
<a href="TroubleTickets.do?command=Home">View Tickets</a> >
Ticket Details
</td>
</tr>
</table>
<%-- End Trails --%>
<%@ include file="ticket_header_include.jsp" %>
<% String param1 = "id=" + TicketDetails.getId(); %>
<dhv:container name="tickets" selected="details" param="<%= param1 %>" style="tabs"/>
<table cellpadding="4" cellspacing="0" border="0" width="100%">
  <tr>
		<td class="containerBack">
    <% if (TicketDetails.getClosed() != null) { %>
      <dhv:permission name="tickets-tickets-edit"><input type="button" value="Reopen" onClick="javascript:this.form.action='TroubleTickets.do?command=Reopen&id=<%= TicketDetails.getId()%>';submit();"></dhv:permission>
    <%} else {%>
      <dhv:permission name="tickets-tickets-edit"><input type="button" value="Modify" onClick="javascript:this.form.action='TroubleTickets.do?command=Modify&auto-populate=true';submit();"></dhv:permission>
      <dhv:permission name="tickets-tickets-delete">
      <% if ("searchResults".equals(request.getParameter("return"))){ %>
        <input type="button" value="Delete" onClick="javascript:popURL('TroubleTickets.do?command=ConfirmDelete&id=<%= TicketDetails.getId() %>&return=searchResults&popup=true', 'Delete_ticket','320','200','yes','no');">
      <%}else{%>
        <input type="button" value="Delete" onClick="javascript:popURL('TroubleTickets.do?command=ConfirmDelete&id=<%= TicketDetails.getId() %>&popup=true', 'Delete_ticket','320','200','yes','no');">
      <%}%>
      </dhv:permission>
    <%}%>
<dhv:permission name="tickets-tickets-edit,tickets-tickets-delete"><br>&nbsp;<br></dhv:permission>
<%-- Ticket Information --%>
<table cellpadding="4" cellspacing="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong>Ticket Information</strong>
    </th>
  </tr>
  <tr class="containerBody">
		<td nowrap class="formLabel">
      Ticket Source
		</td>
		<td>
      <%= toHtml(TicketDetails.getSourceName()) %>
		</td>
  </tr>
  <tr class="containerBody">
		<td nowrap class="formLabel">
      Service Contract Number
		</td>
		<td>
      <%= toHtml(TicketDetails.getServiceContractNumber()) %>
		</td>
  </tr>
  <tr class="containerBody">
		<td nowrap class="formLabel">
      Asset Serial Number
		</td>
		<td>
      <%= toHtml(TicketDetails.getAssetSerialNumber()) %>
		</td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" valign="top">
      <dhv:label name="ticket.issue">Issue</dhv:label>
    </td>
    <td valign="top">
<%
  //Show audio files so that they can be streamed
  Iterator files = TicketDetails.getFiles().iterator();
  while (files.hasNext()) {
    FileItem thisFile = (FileItem)files.next();
    if (".wav".equalsIgnoreCase(thisFile.getExtension())) {
%>
  <a href="TroubleTicketsDocuments.do?command=Download&stream=true&tId=<%= TicketDetails.getId() %>&fid=<%= thisFile.getId() %>"><img src="images/file-audio.gif" border="0" align="absbottom">Play Audio Message</a><br>
<%
    }
  }
%>
      <%= toHtml(TicketDetails.getProblem()) %>
      <input type="hidden" name="problem" value="<%=toHtml(TicketDetails.getProblem())%>">
      <input type="hidden" name="orgId" value="<%=TicketDetails.getOrgId()%>">
      <input type="hidden" name="id" value="<%=TicketDetails.getId()%>">
    </td>
  </tr>
  <tr class="containerBody">
		<td class="formLabel">
      Location
		</td>
		<td>
      <%= toHtml(TicketDetails.getLocation()) %>
		</td>
  </tr>
<dhv:include name="ticket.catCode" none="true">
  <tr class="containerBody">
		<td class="formLabel">
      Category
		</td>
		<td>
      <%= toHtml(TicketDetails.getCategoryName()) %>
		</td>
  </tr>
</dhv:include>
<dhv:include name="ticket.severity" none="true">
  <tr class="containerBody">
		<td class="formLabel">
      Severity
    </td>
		<td>
      <%= toHtml(TicketDetails.getSeverityName()) %>
		</td>
  </tr>
</dhv:include>
  <tr class="containerBody">
		<td class="formLabel">
      Entered
    </td>
		<td>
      <dhv:username id="<%= TicketDetails.getEnteredBy() %>"/>
      -
      <dhv:tz timestamp="<%= TicketDetails.getEntered() %>" dateFormat="<%= DateFormat.SHORT %>" timeFormat="<%= DateFormat.LONG %>"/>
		</td>
  </tr>
  <tr class="containerBody">
		<td class="formLabel">
      Modified
    </td>
		<td>
      <dhv:username id="<%= TicketDetails.getModifiedBy() %>"/>
      -
      <dhv:tz timestamp="<%= TicketDetails.getModified() %>" dateFormat="<%= DateFormat.SHORT %>" timeFormat="<%= DateFormat.LONG %>"/>
		</td>
  </tr>
</table>
&nbsp;
<%-- Primary Contact --%>
<dhv:evaluate if="<%= TicketDetails.getThisContact() != null %>">
<table cellpadding="4" cellspacing="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong>Primary Contact</strong>
    </th>
  </tr>
  <tr class="containerBody">
    <td class="formLabel">
      Name
    </td>
    <td>
      <dhv:permission name="accounts-accounts-contacts-view">
        <a href="Contacts.do?command=Details&id=<%= TicketDetails.getContactId() %>"><%= toHtml(TicketDetails.getThisContact().getNameLastFirst()) %></a>
      </dhv:permission>
      <dhv:permission name="accounts-accounts-contacts-view" none="true">
        <%= toHtml(TicketDetails.getThisContact().getNameLastFirst()) %>
      </dhv:permission>
    </td>
  </tr>
	<tr class="containerBody">
    <td class="formLabel">
      Title
    </td>
    <td>
      <%= toHtml(TicketDetails.getThisContact().getTitle()) %>
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel">
      Email
    </td>
    <td>
      <%= TicketDetails.getThisContact().getEmailAddressTag("Business", toHtml(TicketDetails.getThisContact().getEmailAddress("Business")), "&nbsp;") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel">
      Phone
    </td>
    <td>
      <%= toHtml(TicketDetails.getThisContact().getPhoneNumber("Business")) %>
    </td>
  </tr>
</table>
&nbsp;
</dhv:evaluate>
<%-- Assignment --%>
<table cellpadding="4" cellspacing="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong>Assignment</strong>
    </th>
  </tr>
<dhv:include name="ticket.priority" none="true">
  <tr class="containerBody">
		<td class="formLabel">
      Priority
    </td>
		<td>
      <%= toHtml(TicketDetails.getPriorityName()) %>
		</td>
  </tr>
</dhv:include>
  <tr class="containerBody">
		<td class="formLabel">
      Department
		</td>
		<td>
      <%= toHtml(TicketDetails.getDepartmentCode() > 0 ? TicketDetails.getDepartmentName() : "-- unassigned --") %>
		</td>
  </tr>
  <tr class="containerBody">
		<td class="formLabel">
      Resource Assigned
		</td>
		<td>
      <dhv:username id="<%= TicketDetails.getAssignedTo() %>" default="-- unassigned --"/>
      <dhv:evaluate if="<%= !(TicketDetails.getHasEnabledOwnerAccount()) %>"><font color="red">*</font></dhv:evaluate>
		</td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Assignment Date
    </td>
    <td>
      <dhv:tz timestamp="<%= TicketDetails.getAssignedDate() %>" dateOnly="true" dateFormat="<%= DateFormat.SHORT %>" default="&nbsp;"/>
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel">
      Estimated Resolution Date
    </td>
    <td>
      <dhv:tz timestamp="<%= TicketDetails.getEstimatedResolutionDate() %>" dateOnly="true" dateFormat="<%= DateFormat.SHORT %>" default="&nbsp;"/>
    </td>
  </tr>
</table>
&nbsp;
<%-- Resolution --%>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong>Resolution</strong>
    </th>
  </tr>
  <tr class="containerBody">
		<td class="formLabel" valign="top">
      Cause
		</td>
		<td>
      <%= toHtml(TicketDetails.getCause()) %>
		</td>
  </tr>
  <tr class="containerBody">
		<td class="formLabel" valign="top">
      Resolution
		</td>
		<td>
      <%= toHtml(TicketDetails.getSolution()) %>
		</td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel">
      Resolution Date
    </td>
    <td>
      <dhv:tz timestamp="<%= TicketDetails.getResolutionDate() %>" dateOnly="true" dateFormat="<%= DateFormat.SHORT %>" default="&nbsp;"/>
    </td>
  </tr>
</table>
&nbsp;
<br>
<% if (TicketDetails.getClosed() != null) { %>
  <dhv:permission name="tickets-tickets-edit">
    <input type="button" value="Reopen" onClick="javascript:this.form.action='TroubleTickets.do?command=Reopen&id=<%= TicketDetails.getId()%>';submit();">
  </dhv:permission>
<%} else {%>
  <dhv:permission name="tickets-tickets-edit"><input type="button" value="Modify" onClick="javascript:this.form.action='TroubleTickets.do?command=Modify&auto-populate=true';submit();"></dhv:permission>
  <dhv:permission name="tickets-tickets-delete">
    <% if ("searchResults".equals(request.getParameter("return"))){ %>
      <input type="button" value="Delete" onClick="javascript:popURL('TroubleTickets.do?command=ConfirmDelete&id=<%= TicketDetails.getId() %>&return=searchResults&popup=true', 'Delete_ticket','320','200','yes','no');">
    <%}else{%>
      <input type="button" value="Delete" onClick="javascript:popURL('TroubleTickets.do?command=ConfirmDelete&id=<%= TicketDetails.getId() %>&popup=true', 'Delete_ticket','320','200','yes','no');">
    <%}%>
  </dhv:permission>
<%}%>
	</td>
  </tr>
</table>
</form>
