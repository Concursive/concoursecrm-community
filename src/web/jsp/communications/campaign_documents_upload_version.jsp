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
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.communications.base.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="Campaign" class="org.aspcfs.modules.communications.base.Campaign" scope="request"/>
<jsp:useBean id="FileItem" class="com.zeroio.iteam.base.FileItem" scope="request"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript">
  function checkFileForm(form) {
    if (form.dosubmit.value == "false") {
      return true;
    }
    var formTest = true;
    var messageText = "";
    if (form.subject.value == "") {
      messageText += "- Subject is required\r\n";
      formTest = false;
    }
    if (form.id<%= Campaign.getId() %>.value.length < 5) {
      messageText += "- File is required\r\n";
      formTest = false;
    }
    if (formTest == false) {
      messageText = "The file could not be submitted.          \r\nPlease verify the following items:\r\n\r\n" + messageText;
      form.dosubmit.value = "true";
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
<body onLoad="document.inputForm.subject.focus();">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="CampaignManager.do">Communications</a> >
<a href="CampaignManager.do?command=Dashboard">Dashboard</a> >
<a href="CampaignManager.do?command=Details&id=<%= Campaign.getId() %>">Campaign Details</a> >
<a href="CampaignDocuments.do?command=View&id=<%= Campaign.getId() %>">Documents</a> >
Upload New Version
</td>
</tr>
</table>
<%-- End Trails --%>
<strong>Campaign: </strong><%= toHtml(Campaign.getName()) %>
<% String param1 = "id=" + Campaign.getId(); %>
<dhv:container name="communications" selected="documents" param="<%= param1 %>" style="tabs"/>
<form method="post" name="inputForm" action="CampaignDocuments.do?command=UploadVersion" enctype="multipart/form-data" onSubmit="return checkFileForm(this);">
<table cellpadding="4" cellspacing="0" width="100%">
  <tr>
    <td class="containerBack">
<dhv:formMessage />
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <tr>
    <th colspan="2">
      <img border="0" src="images/file.gif" align="absmiddle"><b>Upload a New Version of Document</b>
    </th>
  </tr>
  <tr class="containerBody">
    <td class="formLabel">
      Subject
    </td>
    <td>
      <input type="hidden" name="folderId" value="<%= (String)request.getAttribute("folderId") %>">
      <input type="text" name="subject" size="59" maxlength="255" value="<%= FileItem.getSubject() %>"><font color="red">*</font>
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel">
      File
    </td>
    <td>
      Current Version:<br>
       &nbsp;&nbsp;
       <strong><%= FileItem.getVersion() %></strong><br>
      New Version: <br>
       &nbsp;&nbsp;
       <strong><%= FileItem.getVersionNextMajor() %></strong><br>
       <input type="hidden" value="<%= FileItem.getVersionNextMajor() %>" name="versionId">
    </td>
  </tr>
	<tr class="containerBody">
    <td class="formLabel">
      File
    </td>
    <td>
      <input type="file" name="id<%= Campaign.getId() %>" size="45">
    </td>
  </tr>
</table>
  <p align="center">
    * Large files may take a while to upload.<br>
    Wait for file completion message when upload is complete.
  </p>
  <input type="submit" value=" Upload " name="upload">
  <input type="submit" value="Cancel" onClick="javascript:this.form.dosubmit.value='false';this.form.action='CampaignDocuments.do?command=View&id=<%= Campaign.getId() %>';">
  <input type="hidden" name="dosubmit" value="true">
  <input type="hidden" name="id" value="<%= Campaign.getId() %>">
	<input type="hidden" name="fid" value="<%= FileItem.getId() %>">
</td>
</tr>
</table>
</form>
</body>
