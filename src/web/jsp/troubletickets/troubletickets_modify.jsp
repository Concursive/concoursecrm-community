<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="org.aspcfs.modules.troubletickets.base.*,org.aspcfs.modules.communications.base.Campaign,org.aspcfs.modules.communications.base.CampaignList,org.aspcfs.utils.web.HtmlSelect" %>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.troubletickets.base.Ticket" scope="request"/>
<jsp:useBean id="DepartmentList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SeverityList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SourceList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="PriorityList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="CategoryList" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="UserList" class="org.aspcfs.modules.admin.base.UserList" scope="request"/>
<jsp:useBean id="SubList1" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="SubList2" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="SubList3" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="ContactList" class="org.aspcfs.modules.contacts.base.ContactList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<body>
<form name="details" action="TroubleTickets.do?command=Update&auto-populate=true" method="post">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="TroubleTickets.do">Help Desk</a> > 
<% if (("list".equals((String)request.getParameter("return"))) ||
      ("searchResults".equals((String)request.getParameter("return")))) {%>
    <% if ("yes".equals((String)session.getAttribute("searchTickets"))) {%>
      <a href="TroubleTickets.do?command=SearchTicketsForm">Search Form</a> >
      <a href="TroubleTickets.do?command=SearchTickets">Search Results</a> >
    <%}else{%> 
      <a href="TroubleTickets.do?command=Home">View Tickets</a> >
    <%}%>
<%} else {%>
  <% if ("yes".equals((String)session.getAttribute("searchTickets"))) {%>
    <a href="TroubleTickets.do?command=SearchTickets">Search Tickets</a> >
  <%}else{%> 
    <a href="TroubleTickets.do?command=Home">View Tickets</a> >
  <%}%>
    <a href="TroubleTickets.do?command=Details&id=<%= TicketDetails.getId() %>">Ticket Details</a> >
<%}%>
Modify Ticket
</td>
</tr>
</table>
<%-- End Trails --%>
<%@ include file="ticket_header_include.jsp" %>
<iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>
<% String param1 = "id=" + TicketDetails.getId(); %>
<dhv:container name="tickets" selected="details" param="<%= param1 %>" style="tabs"/>
<table cellpadding="4" cellspacing="0" border="0" width="100%">
  <tr>
  	<td class="containerBack">
      <dhv:evaluate if="<%= TicketDetails.getClosed() != null %>">
        <font color="red">This ticket was closed on
        <dhv:tz timestamp="<%= TicketDetails.getClosed() %>" dateFormat="<%= DateFormat.SHORT %>" timeFormat="<%= DateFormat.LONG %>"/>
        </font><br>
        <br>
      </dhv:evaluate>
      <% if (TicketDetails.getClosed() != null) { %>
        <input type="button" value="Reopen" onClick="javascript:this.form.action='TroubleTickets.do?command=Reopen&id=<%= TicketDetails.getId()%>';submit();">
        <input type="submit" value="Cancel" onClick="javascript:this.form.action='TroubleTickets.do?command=Details&id=<%= TicketDetails.getId() %>'">
      <%} else {%>
        <input type="submit" value="Update" onClick="return checkForm(this.form)">
        <% if ("list".equals(request.getParameter("return"))) {%>
          <input type="submit" value="Cancel" onClick="javascript:this.form.action='TroubleTickets.do?command=Home'">
        <%} else if ("searchResults".equals(request.getParameter("return"))){%> 
          <input type="submit" value="Cancel" onClick="javascript:this.form.action='TroubleTickets.do?command=SearchTickets'">
        <% }else {%>
          <input type="submit" value="Cancel" onClick="javascript:this.form.action='TroubleTickets.do?command=Details&id=<%= TicketDetails.getId() %>'">
        <%}%>
      <%}%>
      <br /><br />
<%@ include file="troubletickets_modify_include.jsp" %>
<% if (TicketDetails.getClosed() != null) { %>
  <input type="button" value="Reopen" onClick="javascript:this.form.action='TroubleTickets.do?command=Reopen&id=<%= TicketDetails.getId()%>';submit();">
<%} else {%>
  <input type="submit" value="Update" onClick="return checkForm(this.form)">
<%}%>
	<% if ("list".equals(request.getParameter("return"))) {%>
	<input type="submit" value="Cancel" onClick="javascript:this.form.action='TroubleTickets.do?command=Home'">
  <%} else if ("searchResults".equals(request.getParameter("return"))){%> 
    <input type="submit" value="Cancel" onClick="javascript:this.form.action='TroubleTickets.do?command=SearchTickets'">
  <%} else {%>
	<input type="submit" value="Cancel" onClick="javascript:this.form.action='TroubleTickets.do?command=Details&id=<%= TicketDetails.getId() %>'">
  <%}%>
  </td>
  </tr>
</table>
</form>
</body>
