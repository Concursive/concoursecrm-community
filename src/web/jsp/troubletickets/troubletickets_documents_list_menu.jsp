<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<script language="javascript">
  var thisTicId = -1;
  var thisFileId = -1;
  var menu_init = false;
  //Set the action parameters for clicked item
  function displayMenu(id, ticId, fileId) {
    thisTicId = ticId;
    thisFileId = fileId;
    if (!menu_init) {
      menu_init = true;
      new ypSlideOutMenu("menuFile", "down", 0, 0, 170, getHeight("menuFileTable"));
    }
    return ypSlideOutMenu.displayMenu(id);
  }
  
  //Menu link functions
  function details() {
    window.location.href='TroubleTicketsDocuments.do?command=Details&tId=' + thisTicId + '&fid=' + thisFileId;
  }
  
  function modify() {
    window.location.href='TroubleTicketsDocuments.do?command=Modify&fid=' + thisFileId + '&tId=' + thisTicId;
  }
  
  function download() {
    window.location.href='TroubleTicketsDocuments.do?command=Download&tId=' + thisTicId + '&fid=' + thisFileId;
  }
  
  function deleteFile() {
    confirmDelete('TroubleTicketsDocuments.do?command=Delete&fid='+ thisFileId + '&tId=' + thisTicId);
  }
  
</script>
<div id="menuFileContainer" class="menu">
  <div id="menuFileContent">
    <table id="menuFileTable" class="pulldown" width="170">
      <dhv:permission name="tickets-tickets-view">
      <tr>
        <td>
          <img src="images/icons/stock_zoom-page-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </td>
        <td width="100%">
          <a href="javascript:details()">View Details</a>
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="tickets-tickets-edit">
      <tr>
        <td>
          <img src="images/icons/stock_edit-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </td>
        <td width="100%">
          <a href="javascript:modify()">Modify</a>
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="tickets-tickets-view">
      <tr>
        <td>
          <img src="images/icons/stock_data-save-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </td>
        <td width="100%">
          <a href="javascript:download()">Download</a>
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="tickets-tickets-delete">
      <tr>
        <td>
          <img src="images/icons/stock_delete-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </td>
        <td width="100%">
          <a href="javascript:deleteFile()">Delete</a>
        </td>
      </tr>
      </dhv:permission>
    </table>
  </div>
</div>
