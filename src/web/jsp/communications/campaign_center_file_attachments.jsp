<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="Campaign" class="com.darkhorseventures.cfsbase.Campaign" scope="request"/>
<jsp:useBean id="fileItemList" class="com.zeroio.iteam.base.FileItemList" scope="request"/>
<%@ include file="initPage.jsp" %>
<script language="JavaScript" type="text/javascript" src="/javascript/confirmDelete.js"></script>
<script language="JavaScript">
  function checkFileForm(form) {
    var formTest = true;
    var messageText = "";

    if (form.id<%= Campaign.getId() %>.value.length < 5) {
      messageText += "- File is required\r\n";
      formTest = false;
    }
    
    if (formTest == false) {
      messageText = "The file could not be submitted.          \r\nPlease verify the following items:\r\n\r\n" + messageText;
      alert(messageText);
      return false;
    } else {
      if (form.upload.value != 'Please Wait...') {
        form.upload.value='Please Wait...';
        return true;
      } else {
        return false;
      }
    }
  }
</script>
<a href="CampaignManager.do">Communications Manager</a> >
<a href="CampaignManager.do?command=View">Campaign List</a> >
<a href="CampaignManager.do?command=ViewDetails&id=<%= Campaign.getId() %>">Campaign Details</a> >
<a href="CampaignManager.do?command=ViewAttachmentsOverview&id=<%= Campaign.getId() %>">Attachments</a> >
File Attachments
<hr color="#BFBFBB" noshade>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
      <strong>Campaign: </strong><%= toHtml(Campaign.getName()) %>
    </td>
  </tr>
  <tr>
    <td width="100%" class="containerBack">
      <ul>
        <li>Begin by selecting "Browse" then locate the file on your system to attach</li>
        <li>Send the file to the server by selecting "Upload"</li>
        <li>Attached files will be sent to email recipients</li>
        <li>Attached files cannot be sent to fax recipients</li>
        <li>Attached files can be exported for mail merge recipients</li>
        <li>Files cannot be larger than 2 megabytes (2048k)</li>
      </ul>
<table border="0" width="100%">
<tr>
<td width="100%" valign="top">
<%-- List of Documents --%>
<table cellpadding="4" cellspacing="0" border="1" width="100%" class="pagedlist" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan="4" align="left">
      <strong>Attached files...</strong>
    </td>
  </tr>
  <tr class="title">
    <td width="10" align="center">Action</td>
    <td>File Name</td>
    <td align="center">Size</td>
    <td align="center">Date</td>
  </tr>
<%
  Iterator j = fileItemList.iterator();
  if ( j.hasNext() ) {
    int rowid = 0;
    while (j.hasNext()) {
      if (rowid != 1) rowid = 1; else rowid = 2;
      FileItem thisFile = (FileItem)j.next();
%>      
    <tr class="row<%= rowid %>">
      <td width="10" valign="middle" align="center" nowrap>
        <a href="CampaignManager.do?command=DownloadFile&id=<%= Campaign.getId() %>&fid=<%= thisFile.getId() %>">Download</a>
        <dhv:permission name="campaign-campaigns-edit"><a href="javascript:confirmDelete('CampaignManager.do?command=RemoveFile&fid=<%= thisFile.getId() %>&id=<%= Campaign.getId()%>');"><br>Remove</a></dhv:permission>
      </td>
      <td valign="middle" width="100%">
        <%= thisFile.getImageTag() %><%= toHtml(thisFile.getClientFilename()) %>
      </td>
      <td align="center" valign="middle" nowrap>
        <%= thisFile.getRelativeSize() %> k&nbsp;
      </td>
      <td nowrap>
        <%= thisFile.getModifiedDateTimeString() %><br>
        <dhv:username id="<%= thisFile.getEnteredBy() %>"/>
      </td>
    </tr>
  <%}%>
<%} else {%>
    <tr class="containerBody">
      <td colspan="4" valign="center">
        No files attached.
      </td>
    </tr>
<%}%>
</table>
</td>
<%-- File upload form, if permission --%>
<dhv:permission name="campaign-campaigns-edit">
<td width="200" valign="top">
<table cellpadding="4" cellspacing="0" border="0" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerBody">
    <form method="post" name="inputForm" action="CampaignManager.do?command=UploadFile&id=<%= Campaign.getId() %>" enctype="multipart/form-data" onSubmit="return checkFileForm(this);">
      <td align="center" width="100%">
        <input type="file" name="id<%= Campaign.getId() %>" size="30"><br>
        * Large files may take a while to upload.<br>
        Wait for file completion message when upload is complete.<br>
        <input type="submit" value=" Upload File " name="upload">
      </td>
    </form>
  </tr>
</table>
</td>
</dhv:permission>
</tr>
<tr>
  <td colspan="2" align="left">
    &nbsp;<br>
    <input type="button" value="Done" onClick="javascript:window.location.href='CampaignManager.do?command=ViewAttachmentsOverview&id=<%= Campaign.getId() %>'">
  </td>
</tr>
</table>
  </td>
  </tr>
</table>
