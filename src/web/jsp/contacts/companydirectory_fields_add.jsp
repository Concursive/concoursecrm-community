<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.contacts.base.*, org.aspcfs.modules.base.*" %>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="Category" class="org.aspcfs.modules.base.CustomFieldCategory" scope="request"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkDate.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>
<form name="details" action="ExternalContacts.do?command=Fields&contactId=<%= ContactDetails.getId() %>&catId=<%= Category.getId() %>" method="post">
<dhv:evaluate exp="<%= !isPopup(request) %>">
<a href="ExternalContacts.do">General Contacts</a> > 
<a href="ExternalContacts.do?command=ListContacts">View Contacts</a> >
<a href="ExternalContacts.do?command=ContactDetails&id=<%=ContactDetails.getId()%>">Contact Details</a> >
<dhv:evaluate if="<%= (Category.getAllowMultipleRecords()) %>">
  <a href="ExternalContacts.do?command=Fields&contactId=<%=ContactDetails.getId()%>&catId=<%= Category.getId() %>">List of Folder Records</a> >
</dhv:evaluate>
<dhv:evaluate if="<%= (!Category.getAllowMultipleRecords()) %>">
  <a href="ExternalContacts.do?command=Fields&contactId=<%=ContactDetails.getId()%>&catId=<%= Category.getId() %>">Folder Record Details</a> >
</dhv:evaluate>
Add Folder Record
<hr color="#BFBFBB" noshade>
</dhv:evaluate>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
      <strong><%= toHtml(ContactDetails.getNameFull()) %></strong>
    </td>
  </tr>
  <tr class="containerMenu">
    <td>
      <% String param1 = "id=" + ContactDetails.getId(); 
          String param2 = addLinkParams(request, "popup|popupType|actionId"); %>
      <dhv:container name="contacts" selected="folders" param="<%= param1 %>" appendToUrl="<%= param2 %>"/>
    </td>
  </tr>
  <tr>
    <td class="containerBack">
      Folder: <strong><%= Category.getName() %></strong><br>
      <dhv:evaluate exp="<%= !Category.isEmpty() %>">
        &nbsp;<br>
        <input type="submit" value="Save" onClick="javascript:this.form.action='ExternalContacts.do?command=InsertFields&contactId=<%= ContactDetails.getId() %>&catId=<%= Category.getId() %>'">
        <input type="submit" value="Cancel" onClick="javascript:this.form.action='ExternalContacts.do?command=Fields&contactId=<%= ContactDetails.getId() %>&catId=<%= Category.getId() %>'"><br>
        &nbsp;<br>
      </dhv:evaluate>
<%
  Iterator groups = Category.iterator();
  if(groups.hasNext()){
  while (groups.hasNext()) {
    CustomFieldGroup thisGroup = (CustomFieldGroup)groups.next();
%>    
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan=2 valign=center align=left>
	    <strong><%= thisGroup.getName() %></strong>
	  </td>
  </tr>
<%  
  Iterator fields = thisGroup.iterator();
  if (fields.hasNext()) {
    while (fields.hasNext()) {
      CustomField thisField = (CustomField)fields.next();
%>    
    <tr class="containerBody">
      <%-- Do not use toHtml() here, it's done by CustomField --%>
      <td valign="center" nowrap class="formLabel">
        <%= thisField.getNameHtml() %>
      </td>
      <td valign="center">
        <%= thisField.getHtmlElement() %> <font color="red"><%= (thisField.getRequired()?"*":"") %></font>
        <font color='#006699'><%= toHtml(thisField.getError()) %></font>
        <%= toHtml(thisField.getAdditionalText()) %>
      </td>
    </tr>
<%    
    }
  } else {
%>
    <tr class="containerBody">
      <td colspan="2">
        <font color="#9E9E9E">No fields available.</font>
      </td>
    </tr>
<%}%>
</table>
&nbsp;
<%}%>
    <dhv:evaluate exp="<%= !Category.isEmpty() %>">
        <br>
        <input type="submit" value="Save" onClick="javascript:this.form.action='ExternalContacts.do?command=InsertFields&contactId=<%= ContactDetails.getId() %>&catId=<%= Category.getId() %>'">
        <input type="submit" value="Cancel" onClick="javascript:this.form.action='ExternalContacts.do?command=Fields&contactId=<%= ContactDetails.getId() %>&catId=<%= Category.getId() %>'">
        </td></tr>
    </dhv:evaluate>
<%}else{%>
  <tr class="containerBody">
      <td colspan="2">
        <font color="#9E9E9E">No groups available.</font>
      </td>
    </tr>
<%}%>
</table>
<%= addHiddenParams(request, "popup|popupType|actionId") %>
</form>
