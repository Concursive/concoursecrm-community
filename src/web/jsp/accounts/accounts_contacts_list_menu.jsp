<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<script language="javascript">
  var thisOrgId = -1;
  var thisContactId = -1;
  var menu_init = false;
  var isPrimaryContact = false;
  //Set the action parameters for clicked item
  function displayMenu(loc, id, orgId, contactId, isPrimary) {
    thisOrgId = orgId;
    thisContactId = contactId;
    isPrimaryContact = isPrimary;
    if (!menu_init) {
      menu_init = true;
      new ypSlideOutMenu("menuContact", "down", 0, 0, 170, getHeight("menuContactTable"));
    }
    return ypSlideOutMenu.displayDropMenu(id, loc);
  }
  //Menu link functions
  function details() {
    window.location.href='Contacts.do?command=Details&id=' + thisContactId;
  }
  
  function modify() {
    window.location.href='Contacts.do?command=Modify&orgId=' + thisOrgId + '&id=' + thisContactId + '&return=list';
  }

  function move() {
    check('moveContact', thisOrgId, thisContactId, '&filters=all|my|disabled', isPrimaryContact);
  }
  
  function clone() {
    window.location.href='Contacts.do?command=Clone&orgId=' + thisOrgId + '&id=' + thisContactId + '&return=list';
  }
  
  function deleteContact() {
    popURLReturn('Contacts.do?command=ConfirmDelete&orgId=' + thisOrgId + '&id=' + thisContactId + '&popup=true','Contacts.do?command=View', 'Delete_contact','330','200','yes','no');
  }
</script>
<div id="menuContactContainer" class="menu">
  <div id="menuContactContent">
    <table id="menuContactTable" class="pulldown" width="170" cellspacing="0">
      <dhv:permission name="accounts-accounts-contacts-view">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)"
           onclick="details()">
        <th valign="top">
          <img src="images/icons/stock_zoom-page-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          View Details
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="accounts-accounts-contacts-edit">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)"
           onclick="modify()">
        <th>
          <img src="images/icons/stock_edit-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          Modify
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="accounts-accounts-contacts-add">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)"
           onclick="clone()">
        <th>
          <img src="images/icons/stock_copy-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          Clone
        </td>
      </tr>
      </dhv:permission>
      <%--
      <dhv:permission name="accounts-accounts-contacts-edit">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)"
           onclick="move()">
        <th>
          <img src="images/icons/stock_drag-mode-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          Move
        </td>
      </tr>
      </dhv:permission>
      --%>
      <dhv:permission name="accounts-accounts-contacts-delete">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)"
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
