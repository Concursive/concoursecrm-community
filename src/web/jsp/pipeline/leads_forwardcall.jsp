<a href="Leads.do">Pipeline Management</a> > 
<a href="Leads.do?command=ViewOpp">View Components</a> >
<a href="Leads.do?command=DetailsOpp&headerId=<%= request.getParameter("headerId") %>">Opportunity Details</a> >
<a href="LeadsCalls.do?command=View&headerId=<%= request.getParameter("headerId") %>">Calls</a> >
<a href="LeadsCalls.do?command=Details&headerId=<%= request.getParameter("headerId") %>&id=<%= request.getParameter("id") %>">Call Details</a> >
Call Forward<br>
<hr color="#BFBFBB" noshade>
<form name="newMessageForm" action="LeadsCallsForward.do?command=SendMessage&headerId=<%= request.getParameter("headerId") %>&id=<%= request.getParameter("id") %>" method="post" onSubmit="return sendMessage();">
<%@ include file="../newmessage.jsp" %>
<br>
<input type="submit" value="Send">
<input type="button" value="Cancel" onClick="javascript:window.location.href='LeadsCalls.do?command=Details&id=<%= request.getParameter("id")%>&headerId=<%= request.getParameter("headerId") %>'">
</form>
