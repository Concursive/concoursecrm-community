<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<script language="javascript">
  var thisContactId = -1;
  var menu_init = false;
  //Set the action parameters for clicked item
  function displayMenu(loc, id, contactId, deletePermission) {
    thisContactId = contactId;
    updateMenu(deletePermission);
    if (!menu_init) {
      menu_init = true;
      new ypSlideOutMenu("menuContact", "down", 0, 0, 170, getHeight("menuContactTable"));
    }
    return ypSlideOutMenu.displayDropMenu(id, loc);
  }
  
  //Update menu for this Contact based on permissions
  function updateMenu(hasDeletePermission){
    if(document.getElementById('menuDelete') != null){
      if(hasDeletePermission == 0){
        hideSpan('menuDelete');
      }else{
        showSpan('menuDelete');
      }
    }
  }
  //Menu link functions
  function details() {
    window.location.href = 'AccountContactsImports.do?command=ContactDetails&contactId=' + thisContactId;
  }
  
  function deleteContact() {
    url = 'AccountContactsImports.do?command=DeleteContact&contactId=' + thisContactId + '&importId=<%= ImportDetails.getId() %>&return=list';
    confirmDelete(url);
  }
  
</script>
<div id="menuContactContainer" class="menu">
  <div id="menuContactContent">
    <table id="menuContactTable" class="pulldown" width="170" cellspacing="0">
      <dhv:permission name="accounts-accounts-contacts-imports-view">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)"
          onclick="details()">
        <th>
          <img src="images/icons/stock_zoom-page-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          View Details
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="accounts-accounts-contacts-imports-edit">
      <tr id="menuDelete" onmouseover="cmOver(this)" onmouseout="cmOut(this)"
          onclick="deleteContact()">
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
