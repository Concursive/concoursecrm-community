<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*" %>
<jsp:useBean id="TicList" class="com.darkhorseventures.cfsbase.TicketList" scope="request"/>
<jsp:useBean id="TicListInfo" class="com.darkhorseventures.webutils.PagedListInfo" scope="session"/>
<%@ include file="initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="/javascript/confirmDelete.js"></SCRIPT>
<dhv:permission name="tickets-tickets-view"><a href="/TroubleTickets.do?command=SearchTickets&reset=true">New Search</a></dhv:permission>
<br>
<%= showAttribute(request, "actionError") %>

<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
    <% if (!(TicListInfo.getSavedCriteria().isEmpty())) { %>
      <strong>Last Search Results</strong>
     <%}%>
    </td>
  </tr>

    <tr>
    <td>
    
<table cellpadding="4" cellspacing="0" border="1" width="100%" class="pagedlist" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
  <dhv:permission name="tickets-tickets-edit,tickets-tickets-delete">
		<td valign="center" align="left">
      <strong>Action</strong>
    </td>
    </dhv:permission>
    <td valign="center" align="left">
      <strong>Number</strong>
    </td>
    <td><b>Priority</b></td>
    <td><b>Age</b></td>
    <td><b>Company</b></td>
    <td><b><dhv:label name="tickets-problem">Issue</dhv:label></b></td>
		<td><b>Assigned&nbsp;To</b></td>
  </tr>
  
  <%
	Iterator j = TicList.iterator();
	
	if ( j.hasNext() ) {
		int rowid = 0;
		while (j.hasNext()) {
		if (rowid != 1) {
			rowid = 1;
		} else {
			rowid = 2;
		}
	
		Ticket thisTic = (Ticket)j.next();
%>   
	<tr>
	<dhv:permission name="tickets-tickets-edit,tickets-tickets-delete">
    <td width="8" valign="top" nowrap class="row<%= rowid %>">
      <dhv:permission name="tickets-tickets-edit"><a href="/TroubleTickets.do?command=Modify&id=<%= thisTic.getId() %>&return=list">Edit</a></dhv:permission><dhv:permission name="tickets-tickets-edit,tickets-tickets-delete" all="true">|</dhv:permission><dhv:permission name="tickets-tickets-delete"><a href="javascript:confirmDelete('/TroubleTickets.do?command=Delete&id=<%= thisTic.getId() %>');">Del</a></dhv:permission>
    </td>
    	</dhv:permission>
		<td width="15" valign="top" nowrap class="row<%= rowid %>">
			<a href="/TroubleTickets.do?command=Details&id=<%=thisTic.getId()%>"><%=thisTic.getPaddedId()%></a>
		</td>
		<td width="10" valign="top" nowrap class="row<%= rowid %>">
			<%=toHtml(thisTic.getPriorityName())%>
		</td>
		<td width="8%" valign="top" nowrap class="row<%= rowid %>">
			<%=thisTic.getAgeOf()%>
		</td>
		<td width="40%" valign="top" nowrap class="row<%= rowid %>">
			<%=toHtml(thisTic.getCompanyName())%><dhv:evaluate exp="<%=!(thisTic.getCompanyEnabled())%>">&nbsp;<font color="red">*</font></dhv:evaluate>
		</td>
		<td width="52%" valign="top" class="row<%= rowid %>">
			<%= toHtml(thisTic.getProblemHeader()) %> <% if (thisTic.getCategoryName() != null) { %>[<%=toHtml(thisTic.getCategoryName())%>]<%}%>
		</td>
		<td valign="top" nowrap class="row<%= rowid %>">
			<%=toHtml(thisTic.getOwnerName())%>
		</td>
	</tr>
	<%}%>
	</table>
	<br>
  <dhv:pagedListControl object="TicListInfo" tdClass="row1"/>
  
	<%} else {%>
		<tr bgcolor="white"><td colspan="7" valign="center">No tickets found.</td></tr>
		</table>
	<%}%>
  
  </td>
  </tr>
  </table>
  
