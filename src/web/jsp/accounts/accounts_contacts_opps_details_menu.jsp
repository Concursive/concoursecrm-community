<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<script language="javascript">
  var thisHeaderId = -1;
  var thisContactId = -1;
  var thisId = -1;
  var menu_init = false;
  //Set the action parameters for clicked item
  function displayMenu(id, headerId, compId, contactId) {
    thisHeaderId = headerId;
    thisId = compId;
    thisContactId = contactId;
    if (!menu_init) {
      menu_init = true;
      new ypSlideOutMenu("menuOpp", "down", 0, 0, 170, getHeight("menuOppTable"));
    }
    return ypSlideOutMenu.displayMenu(id);
  }
  
  //Menu link functions
  function details() {
    window.location.href='AccountContactsOppComponents.do?command=DetailsComponent&id=' + thisId + '&contactId=' + thisContactId;
  }
  
  function modify() {
    window.location.href='AccountContactsOppComponents.do?command=ModifyComponent&headerId=' + thisHeaderId + '&contactId=' + thisContactId + '&id=' + thisId + '&return=list&actionSource=AccountContactsOppComponents';
  }
  
  function deleteOpp() {
    popURLReturn('AccountContactsOppComponents.do?command=ConfirmComponentDelete&contactId=' + thisContactId + '&id=' + thisId + '&popup=true','AccountContactsOpps.do?command=ViewOpps' + '&contactId=' + thisContactId, 'Delete_contact','330','200','yes','no');
  }
</script>
<div id="menuOppContainer" class="menu">
  <div id="menuOppContent">
    <table id="menuOppTable" class="pulldown" width="170">
      <dhv:permission name="accounts-accounts-contacts-opportunities-view">
      <tr>
        <td>
          <img src="images/icons/stock_zoom-page-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </td>
        <td width="100%">
          <a href="javascript:details()">View Details</a>
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="accounts-accounts-contacts-opportunities-edit">
      <tr>
        <td>
          <img src="images/icons/stock_edit-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </td>
        <td width="100%">
          <a href="javascript:modify()">Modify</a>
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="accounts-accounts-contacts-opportunities-delete">
      <tr>
        <td>
          <img src="images/icons/stock_delete-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </td>
        <td width="100%">
          <a href="javascript:deleteOpp()">Delete</a>
        </td>
      </tr>
      </dhv:permission>
    </table>
  </div>
</div>
