<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<script language="javascript">
  var thisOrgId = -1;
  var menu_init_account = false;
  //Set the action parameters for clicked item
  function displayAccountMenu(loc, id, orgId) {
    thisOrgId = orgId;
    if (!menu_init_account) {
      menu_init_account = true;
      new ypSlideOutMenu("menuAccount", "down", 0, 0, 170, getHeight("menuAccountTable"));
    }
    return ypSlideOutMenu.displayDropMenu(id, loc);
  }
  
  function modifyAccount() {
    popURL('Accounts.do?command=Modify&orgId=' + thisOrgId + '&popup=true&return=Calendar','Delete_task','500','475','yes','yes');
  }
</script>
<div id="menuAccountContainer" class="menu">
  <div id="menuAccountContent">
    <table id="menuAccountTable" class="pulldown" width="170" cellspacing="0">
      <dhv:permission name="accounts-accounts-edit">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)"
          onclick="modifyAccount()">
        <th>
          <img src="images/icons/stock_edit-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          Modify
        </td>
      </tr>
      </dhv:permission>
    </table>
  </div>
</div>
