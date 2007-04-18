<%@ page import="org.aspcfs.utils.StringUtils"%>
<%@ page import="java.util.Iterator"%>
<%@ page import="org.aspcfs.modules.base.CustomFieldGroup"%>
<%@ page import="org.aspcfs.modules.base.CustomField"%>

<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ taglib uri="/WEB-INF/portlet.tld" prefix="portlet" %>
<jsp:useBean id="Category" class="org.aspcfs.modules.base.CustomFieldCategory" scope="request"/>
<jsp:useBean id="systemStatus" class="org.aspcfs.controller.SystemStatus" scope="request"/>
<portlet:defineObjects/>

<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkDate.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>
<form name="details" action="<portlet:actionURL/>" method="post">

<table cellspacing="0" cellpadding="0" border="0" width="100%" class="pagedList">
    <tr>
      <td><font size="2"><dhv:label name="accounts.accounts_documents_folders_add.Folder">Folder</dhv:label>: <strong><%= Category.getName() %></strong></font></td>
      <% if (!Category.getAllowMultipleRecords()) { %>
        <td align="right"><img src="images/icons/16_edit_comment.gif" border="0">&nbsp;<font size="2"><dhv:label name="accounts.accounts_fields.FolderOneRecord">This folder can have only one record</dhv:label></font></td>
      <% } else { %>
        <td align="right"><img src="images/icons/16_edit_comment.gif" border="0">&nbsp;<font size="2"><dhv:label name="accounts.accounts_fields.FolderHaveMultipleRecords">This folder can have multiple records</dhv:label></font></td>
      <% } %>
    </tr>
  </table>
  <dhv:evaluate if="<%= !Category.isEmpty() %>">
    <br>
    <input type=hidden name="actionType" value="insert" />
    <input type="submit" value="<dhv:label name="global.button.save">Save</dhv:label>" onClick="javascript:this.form.action='<portlet:actionURL></portlet:actionURL>'">
    <input type="submit" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:this.form.action='<portlet:renderURL/>'">
    <br><br><dhv:formMessage showSpace="false" />
  </dhv:evaluate>
<%
  Iterator groups = Category.iterator();
  if(groups.hasNext()){
  while (groups.hasNext()) {
    CustomFieldGroup thisGroup = (CustomFieldGroup)groups.next();
%>
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
    <tr>
      <th colspan="2" valign="center">
        <strong><dhv:label name="portlets.folder.group">Group:</dhv:label></strong><%= StringUtils.toHtml(thisGroup.getName())%>
      </th>
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
        <%= thisField.getHtmlElement(systemStatus) %> <font color="red"><%= (thisField.getRequired()?"*":"") %></font>
        <font color='#006699'><%= toHtml(thisField.getError()) %></font>
        <%=toHtml(thisField.getAdditionalText())%>
      </td>
    </tr>
<%
    }
  } else {
%>
    <tr class="containerBody">
      <td colspan="2">
        <font color="#9E9E9E"><dhv:label name="accounts.accounts_fields.NoFieldsAvailable">No fields available.</dhv:label></font>
      </td>
    </tr>
<%}%>
  </table>
  &nbsp;
<%}%>
    <dhv:evaluate if="<%= !Category.isEmpty() %>">
        <br>
        <input type="submit" value="<dhv:label name="global.button.save">Save</dhv:label>" onClick="javascript:this.form.action='<portlet:actionURL></portlet:actionURL>'">
        <input type="submit" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:this.form.action='<portlet:renderURL/>'">
    </dhv:evaluate>
<%}else{%>
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
    <tr class="containerBody">
        <td colspan="2">
          <font color="#9E9E9E"><dhv:label name="accounts.accounts_fields_add.NoGroupsAvailable">No groups available.</dhv:label></font>
        </td>
      </tr>
  </table>
<%}%>


</form>