<a href="Leads.do">Pipeline Management</a> > 
<a href="Leads.do?command=ViewOpp">View Opportunities</a> >
<a href="Leads.do?command=DetailsOpp&headerId=<%= request.getParameter("headerId") %>">Opportunity Details</a> >
<a href="LeadsCalls.do?command=View&headerId=<%= request.getParameter("headerId") %>">Calls</a> >
<a href="LeadsCalls.do?command=View&headerId=<%= request.getParameter("headerId") %>&id=<%= request.getParameter("id") %>">Call Details</a> >
Call Forward<br>
<hr color="#BFBFBB" noshade>
<%@ include file="../confirmsend.jsp" %>