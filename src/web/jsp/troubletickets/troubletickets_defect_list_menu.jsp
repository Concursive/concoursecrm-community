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
<script language="javascript">
  var thisDefectId = -1;
  var menu_init = false;
  var canEdit = false;
  var canDelete = false;
  //Set the action parameters for clicked item
  function displayMenu(loc, id, dId, tmpCanEdit, tmpCanDelete) {
    thisDefectId = dId;
    canEdit = tmpCanEdit;
    canDelete = tmpCanDelete;
    updateMenu();
    if (!menu_init) {
      menu_init = true;
      new ypSlideOutMenu("menuTicketDefect", "down", 0, 0, 170, getHeight("menuTicketDefectTable"));
    }
    return ypSlideOutMenu.displayDropMenu(id, loc);
  }

  function updateMenu(){
    if(canEdit){
      showSpan('menuTicketDefectModify');
    }else{
      hideSpan('menuTicketDefectModify');
    }
    if(canDelete){
      showSpan('menuTicketDefectDelete');
    }else{
      hideSpan('menuTicketDefectDelete');
    }
  }

  //Menu link functions
  function details() {
    window.location.href = 'TroubleTicketDefects.do?command=Details&defectId=' + thisDefectId;
  }
  
  function modify() {
    window.location.href = 'TroubleTicketDefects.do?command=Modify&defectId=' + thisDefectId + '&return=list';
  }
  
  function deleteTicketDefect() {
    popURL('TroubleTicketDefects.do?command=ConfirmDelete&defectId=' + thisDefectId + '&popup=true', 'Delete_Defect','320','200','yes','no');
  }
</script>
<div id="menuTicketDefectContainer" class="menu">
  <div id="menuTicketDefectContent">
    <table id="menuTicketDefectTable" class="pulldown" width="170" cellspacing="0">
      <dhv:permission name="tickets-tickets-view">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="details()">
        <th>
          <img src="images/icons/stock_zoom-page-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          <dhv:label name="accounts.accounts_calls_list_menu.ViewDetails">View Details</dhv:label>
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="tickets-tickets-view">
      <tr id="menuTicketDefectModify" onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="modify()">
        <th>
          <img src="images/icons/stock_edit-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          <dhv:label name="global.button.modify">Modify</dhv:label>
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="tickets-tickets-view">
      <tr id="menuTicketDefectDelete" onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="deleteTicketDefect()">
        <th>
          <img src="images/icons/stock_delete-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td>
          <dhv:label name="global.button.delete">Delete</dhv:label>
        </td>
      </tr>
      </dhv:permission>
    </table>
  </div>
</div>
