<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<script language="javascript">
  var thisTicId = -1;
  var thisOrgId = -1;
  var thisTaskId = -1;
  var menu_init = false;
  //Set the action parameters for clicked item
  function displayMenu(loc, id, orgId, ticId, taskId) {
    thisOrgId = orgId;
    thisTicId = ticId;
    thisTaskId = taskId;
    if (!menu_init) {
      menu_init = true;
      new ypSlideOutMenu("menuTask", "down", 0, 0, 170, getHeight("menuTaskTable"));
    }
    return ypSlideOutMenu.displayDropMenu(id, loc);
  }
  
  //Menu link functions
  function details() {
    popURL('AccountTicketTasks.do?command=Details&orgId=' + thisOrgId + '&ticketId=' + thisTicId + '&id=' + thisTaskId + '&popup=true','CRM_Task','600','425','yes','yes');
  }
  
  function modify() {
    popURL('AccountTicketTasks.do?command=Modify&orgId=' + thisOrgId + '&ticketId=' + thisTicId + '&id=' + thisTaskId + '&popup=true','CRM_Task','600','425','yes','yes');
  }

  function deleteTask() {
    popURL('AccountTicketTasks.do?command=ConfirmDelete&id=' + thisTaskId + '&popup=true', 'Delete_task','320','200','yes','no');
  }
</script>
<div id="menuTaskContainer" class="menu">
  <div id="menuTaskContent">
    <table id="menuTaskTable" class="pulldown" width="170" cellspacing="0">
      <dhv:permission name="accounts-accounts-tickets-tasks-view">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="details()">
        <th>
          <img src="images/icons/stock_zoom-page-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          View Details
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="accounts-accounts-tickets-tasks-edit">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="modify()">
        <th>
          <img src="images/icons/stock_edit-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          Modify
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="accounts-accounts-tickets-tasks-delete">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="deleteTask()">
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
