<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*" %>
<jsp:useBean id="NewsList" class="java.util.Vector" scope="request"/>
<jsp:useBean id="IndSelect" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="CompanyCalendar" class="com.darkhorseventures.utils.CalendarView" scope="request"/>
<jsp:useBean id="NewUserList" class="com.darkhorseventures.cfsbase.UserList" scope="request"/>
<jsp:useBean id="alertPaged" class="com.darkhorseventures.webutils.PagedListInfo" scope="session"/>
<table bgcolor=white border=0 width="100%">

	<tr>
	<td valign=top bgcolor=white width=300>
	
  <%  
    CompanyCalendar.setBorderSize(1);
    CompanyCalendar.setCellPadding(4);
    CompanyCalendar.setCellSpacing(0);
  %>
	<%= CompanyCalendar.getHtml() %>
	
	</td>

    <td bgcolor=white valign=top width=100%>
    <table bgcolor=white width=100% border=1 cellpadding=4 cellspacing=0 bordercolorlight="#000000" bordercolor="#FFFFFF">
    
    <tr bgcolor="#DEE0FA"><td valign=center>
    <table bgcolor="#DEE0FA" width=100% cellspacing="0" cellpadding="0" border="0">
    
    <tr bgcolor="#DEE0FA">
    <td width=60% valign=center>
    <strong>Alerts</strong>
    </td>
    <td valign=center align=right>
    <%= NewUserList.getHtmlSelect("userId",0) %>
    </td>
    </tr>
    
    </table>
    </td></tr>

	<tr><td>
	<%=CompanyCalendar.displayEvents(5).toString()%>
    
    </table>

<!-- End Table:Alerts -->
</td>
<!-- end ZZ:row one -->
</tr>
<!-- ZZ:row two (spans both row-one columns) -->
<tr>
<td colspan=2>
<%
  Iterator j = NewsList.iterator();
%>
	<form name="miner_select" type="get" action="MyCFS.do">
	<input type=hidden name=command value="Home">
	<table cellpadding="3" cellspacing="0" border="1" width="100%" class="pagedlist" bordercolorlight="#000000" bordercolor="#FFFFFF">
	<tr bgcolor="#DEE0FA"><td valign=center colspan=2>

	<table bgcolor="#DEE0FA" width=100% cellspacing="0" cellpadding="0" border="0">
	<tr><td width=60% valign=center>
	<strong>Personalized Industry News & Events</strong>
	</td>
	<td width= 40% align="right" valign=center>
    
    	<% if (request.getParameter("industry") == null || request.getParameter("industry").equals("")) { %>
    		<%=IndSelect.getHtmlSelect("industry",1)%>
	<% } else { %>
		<%=IndSelect.getHtmlSelect("industry",Integer.parseInt(request.getParameter("industry")))%>
	<%}%>
	
	</td>
	</tr>
	</table>
	</td>
</tr>
<%
	if ( j.hasNext() ) {
		while (j.hasNext()) {
      			NewsArticle thisNews = (NewsArticle)j.next();
		%>      

		<tr bgcolor="white">
		<td width=11% valign=center>
		<%= thisNews.getDateEntered() %>
		</td>

		<td valign=center><a href="<%= thisNews.getUrl() %>" target="_new"><%= thisNews.getHeadline() %></a></td></tr>
		<%}
	} else {%>
		<tr bgcolor="white"><td width=100% valign=center>No news found.</td></tr>
	<%}%>
			
	</table>
	</form>

<%  
%>
<!-- end ZZ:row two -->
</tr>
<!-- End Table ZZ -->
</table>


