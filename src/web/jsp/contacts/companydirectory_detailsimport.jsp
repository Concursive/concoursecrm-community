<%-- 
  - Copyright Notice: (C) 2000-2004 Dark Horse Ventures, All Rights Reserved.
  - License: This source code cannot be modified, distributed or used without
  -          written permission from Dark Horse Ventures. This notice must
  -          remain in place.
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.text.DateFormat,org.aspcfs.modules.base.Import" %>
<jsp:useBean id="ImportDetails" class="org.aspcfs.modules.contacts.base.ContactImport" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<script language="JavaScript">
  function confirmApprove() {
    if(confirmAction('Are you sure?')){
      window.location.href='ExternalContactsImports.do?command=Approve&importId=<%= ImportDetails.getId() %>';
    }
  }
</script>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
  <td>
    <a href="ExternalContacts.do">Contacts</a> >
    <a href="ExternalContactsImports.do?command=View">View Imports</a> >
    Import Details
  </td>
</tr>
</table>
<%-- Import Details --%>
<% if(ImportDetails.canProcess()){ %>
<dhv:permission name="contacts-external_contacts-imports-add">
<input type="button" value="Process" onClick="javascript:window.location.href='ExternalContactsImports.do?command=InitValidate&importId=<%= ImportDetails.getId() %>'">
</dhv:permission>
<% } %>
<dhv:evaluate if="<%= ImportDetails.canApprove() %>">
<dhv:permission name="contacts-external_contacts-imports-edit">
<input type="button" value="Approve" onClick="javascript:confirmApprove();">
</dhv:permission>
</dhv:evaluate>
<dhv:evaluate if="<%= ImportDetails.canDelete() %>">
<dhv:permission name="contacts-external_contacts-imports-delete">
<input type="button" value="Delete" onClick="javascript:popURL('ExternalContactsImports.do?command=ConfirmDelete&importId=<%= ImportDetails.getId() %>','Delete_message','320','200','yes','no');">
</dhv:permission>
</dhv:evaluate>
<dhv:evaluate if="<%= ImportDetails.hasBeenProcessed() %>">
<dhv:permission name="contacts-external_contacts-imports-view">
<input type="button" value="View Results" onClick="javascript:window.location.href='ExternalContactsImports.do?command=ViewResults&importId=<%= ImportDetails.getId() %>';">
</dhv:permission>
</dhv:evaluate>
<% boolean breakAdded = false; %>
<dhv:evaluate if="<%= ImportDetails.canDelete() && !breakAdded %>">
<dhv:permission name="contacts-external_contacts-imports-delete">
<br><br>
<% breakAdded = true; %>
</dhv:permission>
</dhv:evaluate>
<dhv:evaluate if="<%= (ImportDetails.canProcess() || ImportDetails.canApprove()) && !breakAdded %>">
<dhv:permission name="contacts-external_contacts-imports-edit">
<br><br>
<% breakAdded = true; %>
</dhv:permission>
</dhv:evaluate>
<dhv:evaluate if="<%= ImportDetails.hasBeenProcessed() && !breakAdded %>">
<dhv:permission name="contacts-external_contacts-imports-view">
<br><br>
<% breakAdded = true; %>
</dhv:permission>
</dhv:evaluate>
<dhv:formMessage showSpace="false" />
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong>Details</strong>
    </th>
  </tr>
  <tr class="containerBody">
  <td class="formLabel" nowrap>
    Name
  </td>
  <td>
    <%= toString(ImportDetails.getName()) %>
  </td>
  </tr>
  <tr class="containerBody">
  <td valign="top" class="formLabel" nowrap>
    Description
  </td>
  <td>
    <%= toHtml(ImportDetails.getDescription()) %>
  </td>
  </tr>
  <tr class="containerBody">
  <td class="formLabel" nowrap>
    File
  </td>
  <td>
    <%= ImportDetails.getFile().getVersion(Import.IMPORT_FILE_VERSION).getClientFilename() %>&nbsp;&nbsp;[ <a href="javascript:window.location.href='ExternalContactsImports.do?command=Download&importId=<%= ImportDetails.getId() %>&fid=<%= ImportDetails.getFile().getId() %>&ver=<%= Import.IMPORT_FILE_VERSION %>'">Download File</a> ]
  </td>
  </tr>
  <tr class="containerBody">
  <td class="formLabel" nowrap>
    File Size
  </td>
  <td>
    <%= ImportDetails.getFile().getRelativeSize() %> k&nbsp;
  </td>
  </tr>
  <tr class="containerBody">
  <td class="formLabel" nowrap>
    Status
  </td>
  <td>
    <%= ImportDetails.getStatusString() %> &nbsp;
  </td>
  </tr>
  <dhv:evaluate if="<%= !ImportDetails.canProcess() %>">
  <tr class="containerBody">
  <td class="formLabel" nowrap>
    Imported Records
  </td>
  <td>
    <%= ImportDetails.getTotalImportedRecords() %> &nbsp;
  </td>
  </tr>
  <tr class="containerBody">
  <td class="formLabel" nowrap>
    Failed Records
  </td>
  <td>
    <%= ImportDetails.getTotalFailedRecords() %> &nbsp;
    <dhv:evaluate if="<%= ImportDetails.getFile().hasVersion(Import.ERROR_FILE_VERSION) %>">
      &nbsp;<%= ImportDetails.getFile().getImageTag() %>[ <a href="javascript:window.location.href='ExternalContactsImports.do?command=Download&importId=<%= ImportDetails.getId() %>&fid=<%= ImportDetails.getFile().getId() %>&ver=<%= Import.ERROR_FILE_VERSION %>';">  Download Error File</a> ]
    </dhv:evaluate>
  </td>
  </tr>
  </dhv:evaluate>
  
  <tr class="containerBody">
  <td class="formLabel" nowrap>
    Entered
  </td>
  <td>
    <dhv:username id="<%= ImportDetails.getEnteredBy() %>"/>
    <zeroio:tz timestamp="<%= ImportDetails.getEntered()  %>" />
  </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Modified
    </td>
    <td>
      <dhv:username id="<%= ImportDetails.getModifiedBy() %>"/>
      <zeroio:tz timestamp="<%= ImportDetails.getModified()  %>" />
    </td>
  </tr>
</table><br>
<% if(ImportDetails.canProcess()){ %>
<dhv:permission name="contacts-external_contacts-imports-add">
<input type="button" value="Process" onClick="javascript:window.location.href='ExternalContactsImports.do?command=InitValidate&importId=<%= ImportDetails.getId() %>'">
</dhv:permission>
<% } %>
<dhv:evaluate if="<%= ImportDetails.canApprove() %>">
<dhv:permission name="contacts-external_contacts-imports-edit">
<input type="button" value="Approve" onClick="javascript:confirmApprove();">
</dhv:permission>
</dhv:evaluate>
<dhv:evaluate if="<%= ImportDetails.canDelete() %>">
<dhv:permission name="contacts-external_contacts-imports-delete">
<input type="button" value="Delete" onClick="javascript:popURL('ExternalContactsImports.do?command=ConfirmDelete&importId=<%= ImportDetails.getId() %>','Delete_message','320','200','yes','no');">
</dhv:permission>
</dhv:evaluate>
<dhv:evaluate if="<%= ImportDetails.hasBeenProcessed() %>">
<dhv:permission name="contacts-external_contacts-imports-view">
<input type="button" value="View Results" onClick="javascript:window.location.href='ExternalContactsImports.do?command=ViewResults&importId=<%= ImportDetails.getId() %>';">
</dhv:permission>
</dhv:evaluate>
