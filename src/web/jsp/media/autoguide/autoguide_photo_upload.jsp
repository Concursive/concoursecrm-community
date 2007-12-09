<%-- 
  - Copyright(c) 2004 Concursive Corporation (http://www.concursive.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Concursive Corporation. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. CONCURSIVE
  - CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL CONCURSIVE CORPORATION OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.media.autoguide.base.*" %>
<jsp:useBean id="InventoryItem" class="org.aspcfs.modules.media.autoguide.base.Inventory" scope="request"/>
<%@ include file="../../initPage.jsp" %>
<link rel="stylesheet" href="css/photolist.css" type="text/css">
<script language="JavaScript">
  function checkFileForm(form) {
    if (form.dosubmit.value == "false") {
      return true;
    }
    var formTest = true;
    var messageText = "";
    if (form.id<%= InventoryItem.getId() %>.value.length < 5) {
      messageText += label("file.required", "File is required");
      formTest = false;
    }
    if (formTest == false) {
      messageText = label("File.not.submitted", "Check form") + messageText;
      form.dosubmit.value = "true";
      alert(messageText);
      return false;
    } else {
      if (form.upload.value != label("button.pleasewait","Please Wait...")) {
        form.upload.value=label("button.pleasewait","Please Wait...");
        return true;
      } else {
        return false;
      }
    }
  }
</script>
<link rel="stylesheet" href="css/photolist.css" type="text/css">
<form name="uploadPhoto" action="AutoGuide.do?command=Upload&id=<%= InventoryItem.getId() %>&return=<%= java.net.URLEncoder.encode(request.getParameter("return")) %>" enctype="multipart/form-data" method='post' onSubmit="return checkFileForm(this);">
<input type="hidden" name="dosubmit" value="true">
<input type="hidden" name="id" value="<%= InventoryItem.getId() %>">
<table cellpadding="10" cellspacing="0" border="0" width="100%">
  <tr class="title">
    <td>
      Photo Upload
    </td>
  </tr>
  <tr>
    <td class="PhotoDetail">
      <span>
        <img src="<%= (InventoryItem.hasPictureId()?"AutoGuide.do?command=ShowImage&id=" + InventoryItem.getId() + "&fid=" + InventoryItem.getPictureId():"images/vehicle_unavailable.gif") %>" border="0"/><br>
        &nbsp;<br>
<dhv:evaluate if="<%= hasText(InventoryItem.getStockNo()) %>">
        #<%= toHtml(InventoryItem.getStockNo()) %><br>
</dhv:evaluate>
        <%= InventoryItem.getVehicle().getYear() %> <%= toHtml(InventoryItem.getVehicle().getMake().getName()) %> <%= toHtml(InventoryItem.getVehicle().getModel().getName()) %>
<dhv:evaluate if="<%= (InventoryItem.getSellingPrice() > 0) %>">
        <br><%= InventoryItem.getSellingPriceString() %>
</dhv:evaluate>
        <br>&nbsp;
        <br><input type="file" name="id<%= InventoryItem.getId() %>" size="45">
        <br>
<dhv:permission name="accounts-autoguide-inventory-edit">
        <input type='submit' value=' Upload ' name="upload">
</dhv:permission>
        <input type='submit' value='Cancel' onClick="javascript:this.form.dosubmit.value='false';window.close();">
      </span>
    </td>
  </tr>
</table>
</form>

