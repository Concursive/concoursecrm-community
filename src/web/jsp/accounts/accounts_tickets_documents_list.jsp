<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.troubletickets.base.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.troubletickets.base.Ticket" scope="request"/>
<jsp:useBean id="AccountTicketDocumentListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<%@ include file="../initPage.jsp" %>
<%@ include file="accounts_tickets_documents_list_menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<script language="JavaScript" type="text/javascript" src="javascript/confirmDelete.js"></script>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Accounts.do"><dhv:label name="accounts.accounts">Accounts</dhv:label></a> > 
<a href="Accounts.do?command=Search">Search Results</a> >
<a href="Accounts.do?command=Details&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="accounts.details">Account Details</dhv:label></a> >
<a href="Accounts.do?command=ViewTickets&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="accounts.tickets.tickets">Tickets</dhv:label></a> >
<a href="AccountTickets.do?command=TicketDetails&id=<%=TicketDetails.getId()%>"><dhv:label name="accounts.tickets.details">Ticket Details</dhv:label></a> >
Documents
</td>
</tr>
</table>
<%-- End Trails --%>
<%@ include file="accounts_details_header_include.jsp" %>
<% String param1 = "orgId=" + TicketDetails.getOrgId(); %>      
<dhv:container name="accounts" selected="tickets" param="<%= param1 %>" style="tabs"/>
<table cellpadding="4" cellspacing="0" border="0" width="100%">
  <tr>
  	<td class="containerBack">
      <%@ include file="accounts_ticket_header_include.jsp" %>
      <% String param2 = "id=" + TicketDetails.getId(); %>
      [ <dhv:container name="accountstickets" selected="documents" param="<%= param2 %>"/> ]
      <br><br>
      <%
        String permission_doc_folders_add = "accounts-accounts-tickets-documents-add";
        String permission_doc_files_upload = "accounts-accounts-tickets-documents-add";
        String permission_doc_folders_edit = "accounts-accounts-tickets-documents-edit";
        String documentFolderAdd ="AccountTicketsDocumentsFolders.do?command=Add&tId="+TicketDetails.getId();
        String documentFileAdd = "AccountTicketsDocuments.do?command=Add&tId="+TicketDetails.getId();
        String documentFolderModify = "AccountTicketsDocumentsFolders.do?command=Add&tId="+TicketDetails.getId();
        String documentFolderList = "AccountTicketsDocuments.do?command=View&tId="+TicketDetails.getId();
        String documentFileDetails = "AccountTicketsDocuments.do?command=Details&tId="+TicketDetails.getId();
        String documentModule = "AccountTickets";
        String specialID = ""+TicketDetails.getId();
      %>
      <%@ include file="../accounts/documents_list_include.jsp" %>&nbsp;
    </td>
  </tr>
</table>

