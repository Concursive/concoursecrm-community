<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.troubletickets.base.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.troubletickets.base.Ticket" scope="request"/>
<jsp:useBean id="TicketDocumentListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="FileItemList" class="com.zeroio.iteam.base.FileItemList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" type="text/javascript" src="javascript/confirmDelete.js"></script>
<a href="TroubleTickets.do">Tickets</a> > 
<a href="TroubleTickets.do?command=Home">View Tickets</a> >
<a href="TroubleTickets.do?command=Details&id=<%= TicketDetails.getId() %>">Ticket Details</a> >
Documents<br>
<hr color="#BFBFBB" noshade>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
    <strong>Ticket # <%= TicketDetails.getPaddedId() %><br>
    <%= toHtml(TicketDetails.getCompanyName()) %></strong>
    <dhv:evaluate exp="<%= !(TicketDetails.getCompanyEnabled()) %>"><font color="red">(account disabled)</font></dhv:evaluate>
    </td>
  </tr>
  <tr class="containerMenu">
    <td>
      <% String param1 = "id=" + TicketDetails.getId(); %>
      <dhv:container name="tickets" selected="documents" param="<%= param1 %>"/>
      <dhv:evaluate if="<%= TicketDetails.getClosed() != null %>">
      <font color="red">This ticket was closed on <%= toHtml(TicketDetails.getClosedString()) %></font>
      </dhv:evaluate>
   </td>
  </tr>
  <tr>
		<td class="containerBack">
      <dhv:permission name="tickets-tickets-edit"><a href="TroubleTicketsDocuments.do?command=Add&tId=<%= TicketDetails.getId() %>&folderId=<%= FileItemList.getFolderId() %>">Add a Document</a><br></dhv:permission>
      <center><%= TicketDocumentListInfo.getAlphabeticalPageLinks() %></center>
<dhv:pagedListStatus title="<%= showError(request, "actionError") %>" object="TicketDocumentListInfo"/>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td width="10" align="center">Action</td>
    <td>
      <strong><a href="TroubleTicketsDocuments.do?command=View&tId=<%= TicketDetails.getId() %>&column=subject">Item</a></strong>
      <%= TicketDocumentListInfo.getSortIcon("subject") %>
    </td>
    <td align="center">Ext</td>
    <td align="center">Size</td>
    <td align="center">Version</td>
    <dhv:permission name="tickets-tickets-edit">
      <td>&nbsp;</td>
    </dhv:permission>
    <td align="center">Submitted</td>
  </tr>
    <%
      Iterator j = FileItemList.iterator();
      if ( j.hasNext() ) {
        int rowid = 0;
        while (j.hasNext()) {
          rowid = (rowid != 1?1:2);
          FileItem thisFile = (FileItem)j.next();
    %>      
        <tr class="row<%= rowid %>">
          <td width="10" valign="middle" align="center" nowrap>
            <a href="TroubleTicketsDocuments.do?command=Download&tId=<%= TicketDetails.getId() %>&fid=<%= thisFile.getId() %>">Download</a><br>
            <dhv:permission name="tickets-tickets-edit"><a href="TroubleTicketsDocuments.do?command=Modify&fid=<%= thisFile.getId() %>&tId=<%= TicketDetails.getId()%>">Edit</a></dhv:permission><dhv:permission name="tickets-tickets-edit" all="true">|</dhv:permission><dhv:permission name="tickets-tickets-edit"><a href="javascript:confirmDelete('TroubleTicketsDocuments.do?command=Delete&fid=<%= thisFile.getId() %>&tId=<%= TicketDetails.getId()%>');">Del</a></dhv:permission>
          </td>
          <td valign="middle" width="100%">
            <a href="TroubleTicketsDocuments.do?command=Details&tId=<%= TicketDetails.getId() %>&fid=<%= thisFile.getId() %>"><%= thisFile.getImageTag() %><%= toHtml(thisFile.getSubject()) %></a>
          </td>
          <td align="center"><%= toHtml(thisFile.getExtension()) %>&nbsp;</td>
          <td align="center" valign="middle" nowrap>
            <%= thisFile.getRelativeSize() %> k&nbsp;
          </td>
          <td align="right" valign="middle" nowrap>
            <%= thisFile.getVersion() %>&nbsp;
          </td>
        <dhv:permission name="tickets-tickets-edit">
          <td align="right" valign="middle" nowrap>
            [<a href="TroubleTicketsDocuments.do?command=AddVersion&tId=<%= TicketDetails.getId() %>&fid=<%= thisFile.getId() %>">Add Version</a>]
          </td>
        </dhv:permission>
          <td nowrap>
            <%= thisFile.getModifiedDateTimeString() %><br>
            <dhv:username id="<%= thisFile.getEnteredBy() %>"/>
          </td>
        </tr>
    <%}%>
      </table>
      <br>
      <dhv:pagedListControl object="TicketDocumentListInfo"/>
    <%} else {%>
        <tr class="containerBody">
          <td colspan="7">
            No documents found.
          </td>
        </tr>
      </table>
    <%}%>
    </td>
  </tr>
</table>
