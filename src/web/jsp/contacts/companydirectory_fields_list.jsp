<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.contacts.base.*,org.aspcfs.modules.base.*" %>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="CategoryList" class="org.aspcfs.modules.base.CustomFieldCategoryList" scope="request"/>
<jsp:useBean id="Category" class="org.aspcfs.modules.base.CustomFieldCategory" scope="request"/>
<jsp:useBean id="Records" class="org.aspcfs.modules.base.CustomFieldRecordList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<form name="details" action="ExternalContacts.do?command=Fields&contactId=<%= ContactDetails.getId() %>" method="post">
<dhv:evaluate exp="<%= !isPopup(request) %>">
<a href="ExternalContacts.do">General Contacts</a> > 
<a href="ExternalContacts.do?command=ListContacts">View Contacts</a> >
<a href="ExternalContacts.do?command=ContactDetails&id=<%= ContactDetails.getId() %>">Contact Details</a> >
List of Folder Records<br>
<hr color="#BFBFBB" noshade>
</dhv:evaluate>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
      <%@ include file="contact_details_header_include.jsp" %>
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
<%
  CategoryList.setJsEvent("ONCHANGE=\"javascript:document.forms[0].submit();\"");
  if (CategoryList.size() > 0) {
%>
    Folder: <%= CategoryList.getHtmlSelect("catId", (String)request.getAttribute("catId")) %><%= (Category.getReadOnly()?"&nbsp;<img border='0' valign='absBottom' src='images/lock.gif' alt='Folder is read-only'>":"") %><br>
    &nbsp;<br>
    This folder can have multiple records...<br>
    &nbsp;<br>
    <dhv:evaluate exp="<%= (!Category.getReadOnly()) %>"><dhv:permission name="contacts-external_contacts-folders-add"><a href="ExternalContacts.do?command=AddFolderRecord&contactId=<%= ContactDetails.getId() %>&catId=<%=(String)request.getAttribute("catId") %><%= addLinkParams(request, "popup|popupType|actionId") %>">Add a record to this folder</a><br>&nbsp;<br></dhv:permission></dhv:evaluate>
    <table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
      <tr class="title">
        <dhv:evaluate exp="<%= (!Category.getReadOnly()) %>">
        <dhv:permission name="contacts-external_contacts-folders-edit,contacts-external_contacts-folders-delete">
          <td valign="center">
            <strong>Action</strong>
          </td>
        </dhv:permission>
        </dhv:evaluate>
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
      int rowid = 0;
      Iterator records = Records.iterator();
      while (records.hasNext()) {
        rowid = (rowid == 1 ? 2 : 1);
        CustomFieldRecord thisRecord = (CustomFieldRecord)records.next();
%>    
      <tr class="containerBody">
        <dhv:evaluate exp="<%= (!Category.getReadOnly()) %>">
        <dhv:permission name="contacts-external_contacts-folders-edit,contacts-external_contacts-folders-delete">
        <td width="8" valign="center" nowrap class="row<%= rowid %>">
          <dhv:permission name="contacts-external_contacts-folders-edit"><a href="ExternalContacts.do?command=ModifyFields&contactId=<%= ContactDetails.getId() %>&catId=<%= Category.getId() %>&recId=<%= thisRecord.getId() %>&return=list<%= addLinkParams(request, "popup|popupType|actionId") %>">Edit</a></dhv:permission><dhv:permission name="contacts-external_contacts-folders-edit,contacts-external_contacts-folders-delete" all="true">|</dhv:permission><dhv:permission name="contacts-external_contacts-folders-delete"><a href="javascript:confirmDelete('ExternalContacts.do?command=DeleteFields&contactId=<%= ContactDetails.getId() %>&catId=<%= Category.getId() %>&recId=<%= thisRecord.getId() %><%= addLinkParams(request, "popup|popupType|actionId") %>');">Del</a></dhv:permission>
          </td>
        </dhv:permission>
        </dhv:evaluate>
        <td align="left" width="100%" nowrap class="row<%= rowid %>">
          <a href="ExternalContacts.do?command=Fields&contactId=<%= ContactDetails.getId() %>&catId=<%= Category.getId() %>&recId=<%= thisRecord.getId() %><%= addLinkParams(request, "popup|popupType|actionId") %>"><%= thisRecord.getFieldData() != null ? thisRecord.getFieldData().getValueHtml(false) : "&nbsp;" %></a>
        </td>
        <td nowrap class="row<%= rowid %>">
          <%= toHtml(thisRecord.getEnteredString()) %>
        </td>
        <td nowrap class="row<%= rowid %>">
          <dhv:username id="<%= thisRecord.getModifiedBy() %>" />
        </td>
        <td nowrap class="row<%= rowid %>">
          <%= toHtml(thisRecord.getModifiedDateTimeString()) %>
        </td>
      </tr>
<%    
      }
    } else {
%>
      <tr class="containerBody">
        <td colspan="5">
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
<%= addHiddenParams(request, "popup|popupType|actionId") %>
</form>
