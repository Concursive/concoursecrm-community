<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.troubletickets.base.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.troubletickets.base.Ticket" scope="request"/>
<%@ include file="../initPage.jsp" %>
<body onLoad="document.inputForm.subject.focus();">
<a href="TroubleTickets.do">Tickets</a> > 
<a href="TroubleTickets.do?command=Home">View Tickets</a> >
<a href="TroubleTickets.do?command=Details&id=<%= TicketDetails.getId() %>">Ticket Details</a> >
<a href="TroubleTicketsDocuments.do?command=View&tId=<%=TicketDetails.getId()%>">Documents</a> >
Add Document<br>
<hr color="#BFBFBB" noshade>
<strong>Ticket # <%= TicketDetails.getPaddedId() %><br>
<%= toHtml(TicketDetails.getCompanyName()) %></strong>
<dhv:evaluate exp="<%= !(TicketDetails.getCompanyEnabled()) %>"><font color="red">(account disabled)</font></dhv:evaluate>
<% String param1 = "id=" + TicketDetails.getId(); %>
<dhv:container name="tickets" selected="documents" param="<%= param1 %>" style="tabs"/>
<table cellpadding="4" cellspacing="0" border="0" width="100%">
  <tr>
		<td class="containerBack">
    <dhv:evaluate if="<%= TicketDetails.getClosed() != null %>">
      <font color="red">This ticket was closed on <%= toHtml(TicketDetails.getClosedString()) %></font><br>
      &nbsp;<br>
    </dhv:evaluate>
    <form method="post" name="inputForm" action="TroubleTicketsDocuments.do?command=Upload" enctype="multipart/form-data" onSubmit="return checkFileForm(this);">
    <%-- include add document form --%>
      <%@ include file="documents_add_include.jsp" %>
      <p align="center">
        * Large files may take a while to upload.<br>
        Wait for file completion message when upload is complete.
      </p>
      <input type="submit" value=" Upload " name="upload">
      <input type="submit" value="Cancel" onClick="javascript:this.form.dosubmit.value='false';this.form.action='TroubleTicketsDocuments.do?command=View&tId=<%= TicketDetails.getId() %>';">
      <input type="hidden" name="dosubmit" value="true">
      <input type="hidden" name="id" value="<%= TicketDetails.getId() %>">
      </form>
    </td>
  </tr>
 </form>
</table>
   
