<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.mycfs.base.*" %>
<jsp:useBean id="UserList" class="org.aspcfs.modules.admin.base.UserList" scope="request"/>
<jsp:useBean id="UserSelectList" class="org.aspcfs.modules.admin.base.UserList" scope="request"/>
<jsp:useBean id="SourceUser" class="org.aspcfs.modules.admin.base.User" scope="request"/>
<jsp:useBean id="SourceAccounts" class="org.aspcfs.modules.accounts.base.OrganizationList" scope="request"/>
<jsp:useBean id="SourceContacts" class="org.aspcfs.modules.contacts.base.ContactList" scope="request"/>
<jsp:useBean id="SourceUsers" class="org.aspcfs.modules.admin.base.UserList" scope="request"/>
<jsp:useBean id="SourceOpenTickets" class="org.aspcfs.modules.troubletickets.base.TicketList" scope="request"/>
<jsp:useBean id="SourceRevenue" class="org.aspcfs.modules.accounts.base.RevenueList" scope="request"/>
<jsp:useBean id="SourceOpportunities" class="org.aspcfs.modules.pipeline.base.OpportunityList" scope="request"/>
<jsp:useBean id="SourceOpenOpportunities" class="org.aspcfs.modules.pipeline.base.OpportunityList" scope="request"/>
<jsp:useBean id="SourceAssignments" class="com.zeroio.iteam.base.AssignmentList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/checkDate.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></SCRIPT>
<a href="MyCFS.do?command=Home">My Home Page</a> > 
Re-assignments<br>
<hr color="#BFBFBB" noshade>
<% if (request.getAttribute("actionError") != null) { %>
<%= showError(request, "actionError") %>
<%}%>
<table width="100%" border="0">
  <tr>
    <form name="listView" method="post" action="Reassignments.do?command=Reassign">
    <td align="left" valign="center">
    <% UserSelectList.setJsEvent("onChange=\"javascript:document.forms['listView'].submit();\""); %>
    User to re-assign data from:&nbsp;<%= UserSelectList.getHtmlSelect("userId", SourceUser.getId()) %>
    </td>
    </form>
  </tr>
</table>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
<form name="adminReassign" action="Reassignments.do?command=DoReassign" method="post">
  <tr class="title">
    <td nowrap>
      <strong>Re-assign</strong>
    </td>
    <td width="150" nowrap>
      <strong>From User</strong>
    </td>
    <td width="150" nowrap>
      <strong>To User</strong>
    </td>
  </tr>
<% int rowid = 0; %>
<% rowid = (rowid != 1?1:2); %>
  <tr class="row<%= rowid %>">
		<td valign="top">
      Accounts (<%= SourceAccounts.size() %>)
		</td>
    <td valign="top" nowrap>
    <% if (SourceUser.getId() > -1) { %>
      <%= SourceUser.getContact().getNameLastFirst() %>
    <%} else {%>
		  None Selected
    <%}%>
    </td>
		<td valign="top" nowrap>
      <%= UserList.getHtmlSelect("ownerToAccounts") %>
    </td>
  </tr>
<% rowid = (rowid != 1?1:2); %>
  <tr class="row<%= rowid %>">
		<td valign="top">
      Contacts (<%= SourceContacts.size() %>)
		</td>
    <td valign="top" nowrap>
		<% if (SourceUser.getId() > -1) { %>
		  <%= SourceUser.getContact().getNameLastFirst() %>
    <%} else {%>
		  None Selected
    <%}%>
    </td>
		<td valign="top" nowrap>
      <%= UserList.getHtmlSelect("ownerToContacts") %>
    </td>
  </tr>  
<% rowid = (rowid != 1?1:2); %>
  <tr class="row<%= rowid %>">
		<td valign="top">
      Opportunities (Open Only) (<%= SourceOpenOpportunities.size() %>)
		</td>
    <td valign="top" nowrap>
		<% if (SourceUser.getId() > -1) { %>
		  <%= SourceUser.getContact().getNameLastFirst() %>
    <%} else {%>
		  None Selected
    <%}%>
    </td>
		<td valign="top" nowrap>
      <%= UserList.getHtmlSelect("ownerToOpenOpps") %>
    </td>
  </tr>  
<% rowid = (rowid != 1?1:2); %>
  <tr class="row<%= rowid %>">
		<td valign="top">
      Opportunities (Open &amp; Closed) (<%= SourceOpportunities.size() %>)
		</td>
    <td valign="top" nowrap>
		<% if (SourceUser.getId() > -1) { %>
		  <%= SourceUser.getContact().getNameLastFirst() %>
    <%} else {%>
		  None Selected
    <%}%>
    </td>
		<td valign="top" nowrap>
      <%= UserList.getHtmlSelect("ownerToOpenClosedOpps") %>
    </td>
  </tr>  
<% rowid = (rowid != 1?1:2); %>
  <tr class="row<%= rowid %>">
		<td valign="top">
      Project Activities (Incomplete) (<%= SourceAssignments.size() %>)
		</td>
    <td valign="top" nowrap>
		<% if (SourceUser.getId() > -1) { %>
		  <%= SourceUser.getContact().getNameLastFirst() %>
    <%} else {%>
		  None Selected
    <%}%>
    </td>
		<td valign="top" nowrap>
      <%= UserList.getHtmlSelect("ownerToActivities") %>
    </td>
  </tr>  
<% rowid = (rowid != 1?1:2); %>
  <tr class="row<%= rowid %>">
		<td valign="top">
      Account Revenue (<%= SourceRevenue.size() %>)
		</td>
    <td valign="top" nowrap>
		<% if (SourceUser.getId() > -1) { %>
		  <%= SourceUser.getContact().getNameLastFirst() %>
    <%} else {%>
		  None Selected
    <%}%>
    </td>
		<td valign="top" nowrap>
      <%= UserList.getHtmlSelect("ownerToRevenue") %>
    </td>
  </tr>  
<% rowid = (rowid != 1?1:2); %>
  <tr class="row<%= rowid %>">
		<td valign="top">
      Tickets (Open) (<%= SourceOpenTickets.size() %>)
		</td>
    <td valign="top" nowrap>
		<% if (SourceUser.getId() > -1) { %>
		  <%= SourceUser.getContact().getNameLastFirst() %>
    <%} else {%>
		  None Selected
    <%}%>
    </td>
		<td valign="top" nowrap>
      <%= UserList.getHtmlSelect("ownerToOpenTickets") %>
    </td>
  </tr> 
<% rowid = (rowid != 1?1:2); %>
  <tr class="row<%= rowid %>">
		<td valign="top">
      Users Reporting-to (<%= SourceUsers.size() %>)
		</td>
    <td valign="top" nowrap>
		<% if (SourceUser.getId() > -1) { %>
		  <%= SourceUser.getContact().getNameLastFirst() %>
    <%} else {%>
		  None Selected
    <%}%>
    </td>
		<td valign="top" nowrap>
      <%= UserList.getHtmlSelect("ownerToUsers") %>
    </td>
  </tr>  
</table>
&nbsp;<br>
<dhv:permission name="myhomepage-reassign-edit">
<input type="submit" value="Update">
<input type="submit" value="Cancel" onClick="javascript:this.form.action='MyCFS.do?command=Home'">
<input type="reset" value="Reset">
<input type="hidden" name="userId" value="<%= SourceUser.getId() %>">
</dhv:permission>
</form>
</body>
