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
<script language="javascript">
  var thisHeaderId = -1;
  var thisCallId = -1;
  var thisView = "";
  var menu_init = false;
  //Set the action parameters for clicked item
  function displayMenu(loc, id, headerId, callId, view, trashed) {
    thisHeaderId = headerId;
    thisCallId = callId;
    thisView = view;
    updateMenu(trashed);
    if (!menu_init) {
      menu_init = true;
      new ypSlideOutMenu("menuCall", "down", 0, 0, 170, getHeight("menuCallTable"));
    }
    return ypSlideOutMenu.displayDropMenu(id, loc);
  }

  //Update menu for this Contact based on permissions
  function updateMenu(trashed){
    if (trashed == 'true'){
      hideSpan('menuModify');
      hideSpan('menuComplete');
      hideSpan('menuCancel');
      hideSpan('menuForward');
      hideSpan('menuReschedule');
    } else {
      showSpan('menuForward');
      if(thisView == 'pending'){
        showSpan('menuComplete');
        showSpan('menuCancel');
        showSpan('menuReschedule');
        hideSpan('menuModify');
      }else{
        hideSpan('menuComplete');
        hideSpan('menuCancel');
        hideSpan('menuReschedule');
        if(thisView != 'cancel'){
          showSpan('menuModify');
        }else{
          hideSpan('menuModify');
         }
        }
      }
    }

  //Menu link functions
  function details() {
    var url = 'LeadsCalls.do?command=Details&headerId=' + thisHeaderId + '&id=' + thisCallId + '<%= addLinkParams(request, "viewSource") %>';
    if(thisView == 'pending'){
      url += '&view=pending';
    }
    window.location.href=url;
  }
  
  function complete() {
    var url = 'LeadsCalls.do?command=Complete&headerId=' + thisHeaderId + '&id=' + thisCallId + '&return=list<%= addLinkParams(request, "viewSource") %>';
    if(thisView == 'pending'){
      url += '&view=pending';
    }
    window.location.href=url;
  }
  
  function modify() {
    var url = 'LeadsCalls.do?command=Modify&headerId=' + thisHeaderId + '&id=' + thisCallId + '&return=list<%= addLinkParams(request, "viewSource") %>';
    if(thisView == 'pending'){
      url += '&view=pending';
    }
    window.location.href=url;
  }
  
  function forward() {
    var url ='LeadsCallsForward.do?command=ForwardCall&headerId=' + thisHeaderId + '&id=' + thisCallId + '&forwardType=<%= Constants.TASKS %>&return=list<%= addLinkParams(request, "viewSource") %>';
    if(thisView == 'pending'){
      url += '&view=pending';
    }
    window.location.href=url;
  }
  
  
  function deleteCall() {
  var url = 'LeadsCalls.do?command=Cancel&headerId=' + thisHeaderId + '&id=' + thisCallId + '&return=list&action=cancel<%= addLinkParams(request, "viewSource") %>';
    if(thisView == 'pending'){
      url += '&view=pending';
    }
    window.location.href=url;
  }
</script>
<div id="menuCallContainer" class="menu">
  <div id="menuCallContent">
    <table id="menuCallTable" class="pulldown" width="170" cellspacing="0">
      <dhv:permission name="pipeline-opportunities-calls-view">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="details()">
        <th>
          <img src="images/icons/stock_zoom-page-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          <dhv:label name="accounts.accounts_calls_list_menu.ViewDetails">View Details</dhv:label>
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="pipeline-opportunities-calls-edit">
      <tr id="menuComplete" onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="complete()">
        <th>
          <img src="images/icons/stock_edit-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          <dhv:label name="accounts.accounts_calls_list_menu.CompleteActivity">Complete Activity</dhv:label>
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="pipeline-opportunities-calls-edit">
      <tr id="menuReschedule" onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="modify()">
        <th>
          <img src="images/icons/stock_edit-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          <dhv:label name="contact.call.modifyActivity">Modify Activity</dhv:label>
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="pipeline-opportunities-calls-edit">
      <tr id="menuModify" onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="modify()">
        <th>
          <img src="images/icons/stock_edit-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          <dhv:label name="contact.call.modifyActivity">Modify Activity</dhv:label>
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="pipeline-opportunities-calls-delete">
      <tr id="menuCancel" onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="deleteCall()">
        <th>
          <img src="images/icons/stock_delete-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          <dhv:label name="accounts.accounts_calls_list_menu.CancelActivity">Cancel Activity</dhv:label>
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="pipeline-opportunities-calls-view">
      <tr id="menuForward" onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="forward()">
        <th>
          <img src="images/icons/stock_forward_mail-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          <dhv:label name="accounts.accounts_calls_list_menu.Forward">Forward</dhv:label>
        </td>
      </tr>
      </dhv:permission>
    </table>
  </div>
</div>
