<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*" %>
<jsp:useBean id="NewsList" class="java.util.Vector" scope="request"/>
<jsp:useBean id="alertsList" class="java.util.Vector" scope="request"/>
<jsp:useBean id="IndustryList" class="com.darkhorseventures.webutils.HtmlSelect" scope="request"/>
<jsp:useBean id="dateRangeList" class="com.darkhorseventures.webutils.HtmlSelect" scope="request"/>
<jsp:useBean id="reportTypeList" class="com.darkhorseventures.webutils.HtmlSelect" scope="request"/>
<jsp:useBean id="AlertsListSelection" class="com.darkhorseventures.webutils.HtmlSelect" scope="request"/>
<jsp:useBean id="AlertOppsList" class="com.darkhorseventures.cfsbase.OpportunityList" scope="request"/>
<table bgcolor=white border=0 width="100%">

	<tr>
	<td valign=top bgcolor=white width=300>
	<table bgcolor=white width=275 border=1 cellpadding=2 cellspacing=0 bordercolorlight="#000000" bordercolor="#FFFFFF">
		<tr bgcolor="#DEE0FA">
		<td width=100% valign=center align=center colspan=2>
		<strong>Current Weather</strong>
		</td>
		</tr>
		
		<tr><td valign=center>
		<a href="http://oap.weather.com/fcgi-bin/oap/redirect_magnet?loc_id=USVA0557&par=internal&site=magnet&code=357451&promo=english">
		<img border=0 width=270 height=140 SRC="http://oap.weather.com/fcgi-bin/oap/generate_magnet?loc_id=USVA0557&code=357451"></a>
		</td>
		</tr>
	</table>
	</td>
		
	  <!--tr>
    <td valign=top bgcolor=white width=300>
      <form name="dashboard" type="get" action="MyCFS.do">
      <input type=hidden name=command value="Home">
      <table bgcolor=white width=275 border=1 cellpadding=2 cellspacing=0 class="pagedlist" bordercolorlight="#000000" bordercolor="#FFFFFF">
        <tr bgcolor="#DEE0FA">
          <td valign=center align=center colspan=2>
            <strong>Performance Dashboard</strong>
          </td>
        </tr>
        
        <tr>
          <td valign=center width=35%>
            <strong>Activities</strong>
          </td>
          <td valign=center width=65%>
            <%= reportTypeList.getHtml() %>
          </td>
        </tr>
        <tr>
          <td valign=center width=50%>
            <strong>Period</strong>
          </td>
          <td valign=center width=50%>
<%
            dateRangeList.setJsEvent("onChange=\"document.forms['dashboard'].submit();\"");
%>
            <%= dateRangeList.getHtml() %>
          </td>
        </tr>
	
	
        <tr>
          <td align=center valign=center colspan=2>
            <br>
            <img border=0 width=275 height=179 src="/servlet/ChartServlet?graphRange=<%=request.getAttribute("graphRange")%>&rptType=<%=request.getAttribute("rptType")%>">
          </td>
        </tr>
      </table>
      </form>
    </td-->
<!-- ZZ:row one, column two -->
    <td bgcolor=white valign=top width=100%>
    <table bgcolor=white width=100% border=1 cellpadding=4 cellspacing=0 class="pagedlist" bordercolorlight="#000000" bordercolor="#FFFFFF">
      <form name="alerts" type="post" action="MyCFS.do">
      <input type=hidden name="auto-populate" value="true">
      <input type=hidden name=command value="Home">
      <tr bgcolor="#DEE0FA">
        <td width=100% valign=center align=center>
          <strong>Alerts</strong>
        </td>
      </tr>
      <tr>
        <td bgcolor=white>
          Select Alert Type:
<%
          AlertsListSelection.setJsEvent ("onChange=\"document.forms['alerts'].submit();\"");
%>
          <%= AlertsListSelection.getHtml() %>
        </td>
      </tr>
      </form>
    </table>
   <table border=0 cellpadding=2 cellspacing=1 width="100%" bgcolor="#D4D4D4">
     <tr bgcolor=white>
     <th align=left>Description</th>
     <th align=left width=150>Account</th>
     <th width=100 align=left>Alert Date</th>
       <!--th>Date</th>
       <th>Email</th-->
     </tr>
<!--
<%
	Iterator el = null;
	if (alertsList == null) {
		alertsList = new Vector ();
	}
	el = alertsList.iterator ();
	while (el.hasNext ()) {
		Alert alert = (Alert) el.next();
%>
      <tr>
        <td bgcolor=white>
          <a href="/TroubleTickets.do?command=Home&linkaction=ModT&ticketid=<%=alert.getId()%>" >
          <%= alert.getDescription() %></a>
        </td>
        <td bgcolor=<%=alert.getColor()%> align=center><%=alert.getStatus()%></td>
        <td bgcolor=white align=center><%=alert.getShortDateString()%></td>
        <td bgcolor=white align=center>
          <a href="mailto:<%=alert.getEmail()%>" >
          <img src="/images/envelope.jpg" border=0></img></a>
        </td>
      </tr>
<%
	}
%>
-->

<%
	Iterator n = AlertOppsList.iterator();
		
	if ( n.hasNext() ) {
		int rowid = 0;
		while (n.hasNext()) {
			if (rowid != 1) {
				rowid = 1;
			} else {
				rowid = 2;
			}
	          	
			Opportunity thisOpp = (Opportunity)n.next();
%>    
			<tr>
			<td class="row<%= rowid %>" valign=center><a href="/Leads.do?command=DetailsOpp&id=<%= thisOpp.getId() %>&orgId=<%= thisOpp.getAccountLink() %>&contactId=<%= thisOpp.getContactLink() %>&return=list"><%=thisOpp.getShortDescription()%></a></td>
			<td class="row<%= rowid %>" valign=center><%=thisOpp.getAccountName()%></td>
			<td class="row<%= rowid %>" valign=center width=100><%=thisOpp.getAlertDate()%></td>
			</tr>
<%    		}
	}
%>


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
	<table cellpadding="4" cellspacing="0" border="1" width="100%" class="pagedlist" bordercolorlight="#000000" bordercolor="#FFFFFF">
	<tr bgcolor="#DEE0FA"><td valign=center colspan=2>

	<table bgcolor="#DEE0FA" width=100% cellspacing="0" cellpadding="0" border="0">
	<tr><td width=60% valign=center>
	<strong>Personalized Industry News & Events</strong>
	</td>
	<td width= 40% align="right" valign=center>
<%
    IndustryList.setJsEvent("onChange=\"document.forms['miner_select'].submit();\"");
	String thisElt = (String)IndustryList.getHtml();
	out.println(thisElt);
%>
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


