<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.text.DateFormat" %>
<jsp:useBean id="ImportDetails" class="org.aspcfs.modules.contacts.base.ContactImport" scope="request"/>
<%@ include file="../initPage.jsp" %>
<table class="trails" cellspacing="0">
<tr>
  <td>
    <a href="Accounts.do"><dhv:label name="accounts.accounts">Accounts</dhv:label></a> >
    <a href="AccountContactsImports.do?command=View">Import</a> >
    <a href="AccountContactsImports.do?command=New">New Import</a> >
    Upload Complete
  </td>
</tr>
</table>
<%-- End Trails --%>
<table class="note" cellspacing="0">
  <tr>
    <th><img src="images/icons/stock_about-16.gif" border="0" align="absmiddle"/></th>
    <td>Your file to import has been received, but has not been processed.<br />
    To begin processing, use the &quot;Process Now&quot; button. 
    However, since processing requires a few minutes of configuration, you can choose to process the file later by using the &quot;Process Later&quot; button.</td>
  </tr>
</table>
<%-- Import Details --%>
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
    <%= ImportDetails.getFile().getClientFilename() %>&nbsp;&nbsp;[ <a href="javascript:window.location.href='AccountContactsImports.do?command=Download&importId=<%= ImportDetails.getId() %>&fid=<%= ImportDetails.getFile().getId() %>'">Download File</a> ]
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
<input type="button" value="Process Now" onClick="javascript:window.location.href='AccountContactsImports.do?command=InitValidate&importId=<%= ImportDetails.getId() %>';">&nbsp;
<input type="button" value="Process Later" onClick="javascript:window.location.href='AccountContactsImports.do';">

