<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*" %>
<jsp:useBean id="ContactDetails" class="com.darkhorseventures.cfsbase.Contact" scope="request"/>
<jsp:useBean id="CategoryList" class="com.darkhorseventures.cfsbase.CustomFieldCategoryList" scope="request"/>
<jsp:useBean id="Category" class="com.darkhorseventures.cfsbase.CustomFieldCategory" scope="request"/>
<jsp:useBean id="Records" class="com.darkhorseventures.cfsbase.CustomFieldRecordList" scope="request"/>
<%@ include file="initPage.jsp" %>
<form name="details" action="/ExternalContacts.do?command=Fields&contactId=<%= ContactDetails.getId() %>" method="post">
<a href="/ExternalContacts.do?command=ListContacts">Back to Contact List</a><br>&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
      <strong><%= toHtml(ContactDetails.getNameFull()) %></strong>
    </td>
  </tr>
  <tr class="containerMenu">
    <td>
      <% String param1 = "id=" + ContactDetails.getId(); %>      
      <dhv:container name="contacts" selected="folders" param="<%= param1 %>" />
    </td>
  </tr>
  <tr>
    <td class="containerBack">
<%
  CategoryList.setJsEvent("ONCHANGE=\"javascript:document.forms[0].submit();\"");
  if (CategoryList.size() > 0) {
%>
    <%= CategoryList.getHtmlSelect("catId", (String)request.getAttribute("catId")) %><br>
    
    <dhv:permission name="contacts-external_contacts-folders-add">&nbsp;<br><a href="/ExternalContacts.do?command=AddFolderRecord&contactId=<%= ContactDetails.getId() %>&catId=<%=(String)request.getAttribute("catId") %>">Add a record to this folder</a><br></dhv:permission>
    &nbsp;<br>
    <table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
      <tr class="title">
        <td align="left">
          <strong>Record</strong>
        </td>
        <td align="left">
          <strong>Entered</strong>
        </td>
        <td align="left">
          <strong>Modified By</strong>
        </td>
        <td align="left">
          <strong>Last Modified</strong>
        </td>
      </tr>
<%
    if (Records.size() > 0) {
      Iterator records = Records.iterator();
      while (records.hasNext()) {
        CustomFieldRecord thisRecord = (CustomFieldRecord)records.next();
%>    
      <tr class="containerBody">
        <td align="left" width="100%" nowrap>
          <a href="/ExternalContacts.do?command=Fields&contactId=<%= ContactDetails.getId() %>&catId=<%= Category.getId() %>&recId=<%= thisRecord.getId() %>"><%= Category.getName() %> #<%= thisRecord.getId() %></a>
        </td>
        <td nowrap>
          <%= toHtml(thisRecord.getEnteredString()) %>
        </td>
        <td nowrap>
          <dhv:username id="<%= thisRecord.getModifiedBy() %>" />
        </td>
        <td nowrap>
          <%= toHtml(thisRecord.getModifiedDateTimeString()) %>
        </td>
      </tr>
<%    
      }
    } else {
%>
      <tr class="containerBody">
        <td colspan="4">
          <font color="#9E9E9E">No records have been entered.</font>
        </td>
      </tr>
<%  }  %>
<%} else {%>
  <table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
    <tr class="containerBody">
      <td>
        No custom folders available.
      </td>
    </tr>
<%}%>
  </table>
</td></tr>
</table>
</form>
