<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<script language="javascript">
  var thisTicketId = -1;
  var thisCatId = -1;
  var thisRecId = -1;
  var menu_init = false;
  //Set the action parameters for clicked item
  function displayMenu(loc, id, ticketId, catId, recId) {
    thisTicketId = ticketId;
    thisCatId = catId;
    thisRecId = recId;
    if (!menu_init) {
      menu_init = true;
      new ypSlideOutMenu("menuFolders", "down", 0, 0, 170, getHeight("menuFoldersTable"));
    }
    return ypSlideOutMenu.displayDropMenu(id, loc);
  }

  //Menu link functions
  function folderDetails() {
    window.location.href='TroubleTicketsFolders.do?command=Fields&ticketId=' + thisTicketId + '&catId=' + thisCatId + '&recId=' + thisRecId;
  }
  
  function modify() {
    window.location.href = 'TroubleTicketsFolders.do?command=ModifyFields&ticketId=' + thisTicketId + '&catId=' + thisCatId + '&recId=' + thisRecId + '&return=list';
  }
  
  function deleteFolder() {
    confirmDelete('TroubleTicketsFolders.do?command=DeleteFields&ticketId='+ thisTicketId + '&catId=' + thisCatId + '&recId=' + thisRecId + '&return=list');
  }
</script>
<div id="menuFoldersContainer" class="menu">
  <div id="menuFoldersContent">
    <table id="menuFoldersTable" class="pulldown" width="170" cellspacing="0">
      <dhv:permission name="accounts-accounts-folders-view">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="folderDetails()">
        <th>
          <img src="images/icons/stock_zoom-page-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          View Details
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="accounts-accounts-folders-edit">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="modify()">
        <th>
          <img src="images/icons/stock_edit-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          Modify
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="accounts-accounts-folders-delete">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="deleteFolder()">
        <th>
          <img src="images/icons/stock_delete-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          Delete
        </td>
      </tr>
      </dhv:permission>
    </table>
  </div>
</div>
