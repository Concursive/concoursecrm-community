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
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<SCRIPT LANGUAGE="JavaScript">
function setField(formField,thisValue,thisForm) {
        var frm = document.forms[thisForm];
        var len = document.forms[thisForm].elements.length;
        var i=0;
        for( i=0 ; i<len ; i++) {
                if (frm.elements[i].name.indexOf(formField)!=-1) {
                  if(thisValue){
                    frm.elements[i].value = "1";
                  }
                  else {
                    frm.elements[i].value = "0";
                  }
              }
        }
}
</SCRIPT>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong>Action List</strong>
    </th>
  </tr>
  <tr class="containerBody">
    <td class="formLabel">
      Description
    </td>
    <td>
      <input type="text" name="description" value="<%= toHtmlValue(ActionList.getDescription()) %>" size="50" maxlength="80">
      <font color="red">*</font> <%= showAttribute(request, "descriptionError") %>
    </td>
  </tr>
  <%-- Commented for the time being as it complicates things 
  <tr class="containerBody">
    <td nowrap class="formLabel" valign="top">
      Assign To
    </td>
    <td>
      <table>
        <tr>
          <td>
            <div id="changeowner">
            <dhv:username id="<%= ActionList.getOwner() == -1 ? User.getUserRecord().getId() : ActionList.getOwner() %>"/>
            <font color="red">*</font>
            </div>
          </td>
          <td>
            <input type="hidden" name="ownerContactId" id="ownerid" value="<%= ActionList.getOwner() == -1 ? User.getUserRecord().getContactId() : ActionList.getOwner() %>">
            &nbsp;[<a href="javascript:popContactsListSingle('ownerid','changeowner', 'usersOnly=true&reset=true');">Change Owner</a>]
          </td>
        </tr>
      </table>
    </td>
  </tr>
  --%>
  <input type="hidden" name="owner" id="ownerid" value="<%= User.getUserId() %>">
  <tr class="containerBody"> 
    <td class="formLabel">Status</td>
    <td>
      <table cellpadding="3" cellspacing="0" border="0" class="empty">
        <tr>
          <td>
            <input type="checkbox" name="chk1" value="true" onclick="javascript:setField('complete',document.searchForm.chk1.checked,'searchForm');" <%= ActionList.getComplete() ? " checked" : "" %>>
          </td>
          <td>Complete</td>
        </tr>
      </table>
    </td>
  </tr>
  </table>
