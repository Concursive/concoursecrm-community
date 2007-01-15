<%-- 
  - Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. DARK HORSE
  - VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id: accounts_contacts_calls_forward.jsp 15115 2006-05-31 16:47:51Z matt $
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.contacts.base.*" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<script type="text/javascript">
  function hideSendButton() {
    try {
      var send1 = document.getElementById('send1');
      send1.value = label('label.sending','Sending...');
      send1.disabled=true;
    } catch (oException) {}
    try {
      var send2 = document.getElementById('send2');
      send2.value = label('label.sending','Sending...');
      send2.disabled=true;
    } catch (oException) {}
  }
</script>
<form name="newMessageForm" action="AccountsCalls.do?command=SendCall&contactId=<%= ContactDetails.getId() %>&id=<%= request.getParameter("id") %>&orgId=<%= OrgDetails.getId()%>" method="post" onSubmit="return sendMessage();">

<%
  String trailSource = request.getParameter("trailSource");
%>
<dhv:evaluate if="<%= !isPopup(request) %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Accounts.do"><dhv:label name="accounts.accounts">Accounts</dhv:label></a> > 
<% if (request.getParameter("return") == null || (request.getParameter("return") != null && "list".equals(request.getParameter("return")))) { %>
<a href="Accounts.do?command=Search"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
<%} else if (request.getParameter("return").equals("dashboard")) {%>
<a href="Accounts.do?command=Dashboard"><dhv:label name="communications.campaign.Dashboard">Dashboard</dhv:label></a> >
<%}%>
<a href="Accounts.do?command=Details&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="accounts.details">Account Details</dhv:label></a> >
<% if("accounts".equals(trailSource)){ %>
<a href="AccountsCalls.do?command=View&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="accounts.accounts_calls_list.Activities">Activities</dhv:label></a> >
<% } %>
<dhv:evaluate if='<%= !"list".equals(request.getParameter("return")) %>'>
<a href="AccountsCalls.do?command=Details&id=<%= request.getParameter("id") %>&contactId=<%=ContactDetails.getId()%>&orgId=<%=OrgDetails.getOrgId()%><%= addLinkParams(request, "view") %>"><dhv:label name="accounts.accounts_contacts_calls_add.ActivityDetails">Activity Details</dhv:label></a> >
</dhv:evaluate>
<dhv:label name="accounts.accounts_contacts_calls_forward.ForwardActivity">Forward Activity</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>
<dhv:container name="accounts" selected="activities" object="OrgDetails" param='<%= "orgId=" + OrgDetails.getOrgId() %>' appendToUrl='<%= addLinkParams(request, "popup|popupType|actionId") %>'>
    <input type="submit" value="<dhv:label name="global.button.send">Send</dhv:label>">
    <% if("list".equals(request.getParameter("return"))){ %>
      <input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:window.location.href='AccountsCalls.do?command=View&contactId=<%= request.getParameter("contactId") %><%= addLinkParams(request, "view|trailSource") %>'">
    <% }else{ %>
      <input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:window.location.href='AccountsCalls.do?command=Details&id=<%= request.getParameter("id") %>&contactId=<%= request.getParameter("contactId") %><%= addLinkParams(request, "view|trailSource") %>'">
    <% } %>
    <br><br>
    <%-- include the message form --%>
    <%@ include file="../newmessage_include.jsp" %>
    <br>
    <input type="submit" value="<dhv:label name="global.button.send">Send</dhv:label>">
    <% if("list".equals(request.getParameter("return"))){ %>
      <input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:window.location.href='AccountsCalls.do?command=View&contactId=<%= request.getParameter("contactId") %><%= addLinkParams(request, "view|trailSource") %>'">
    <% }else{ %>
      <input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:window.location.href='AccountsCalls.do?command=Details&id=<%= request.getParameter("id") %>&contactId=<%= request.getParameter("contactId") %><%= addLinkParams(request, "view|trailSource") %>'">
    <% } %>
  </dhv:container>
<input type="hidden" name="id" value="<%= request.getParameter("id") %>">
<input type="hidden" name="trailSource" value="accounts">
</form>
