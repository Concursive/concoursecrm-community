<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<script language="javascript">
  var thisFolderId = -1;
  var thisHeaderId = -1;
  var thisFileId = -1;
  var menu_init = false;
  //Set the action parameters for clicked item
  function displayMenu(loc, id, folderId, fileId, headerId ) {
    thisFolderId = folderId
    thisHeaderId = headerId;
    thisFileId = fileId;
    if (!menu_init) {
      menu_init = true;
      new ypSlideOutMenu("menuFolder", "down", 0, 0, 170, getHeight("menuFolderTable"));
      new ypSlideOutMenu("menuFile", "down", 0, 0, 170, getHeight("menuFileTable"));
    }
    return ypSlideOutMenu.displayDropMenu(id, loc);
  }
  
  //Menu link functions

  //Folder operations
  function viewFolder() {
    window.location.href='LeadsDocuments.do?command=View&headerId=' + thisHeaderId + '&folderId=' + thisFolderId;
  }

  function editFolder() {
    window.location.href='LeadsDocumentsFolders.do?command=Modify&headerId=' + thisHeaderId + '&folderId=' + thisFolderId + '&id=' + thisFolderId + '&parentId='+thisFolderId;
  }
  function moveFolder() {
    popURL('LeadsDocumentsFolders.do?command=Move&headerId=' + thisHeaderId + '&id=' + thisFolderId + '&popup=true&return=LeadsDocuments&param='+ thisHeaderId +'&param2='+ thisFolderId ,'Files','400','375','yes','yes');
  }
  function deleteFolder() {
    confirmDelete('LeadsDocumentsFolders.do?command=Delete&headerId=' + thisHeaderId + '&id=' + thisFolderId + '&folderId=' + thisFileId );
  }


  //File operations
  function viewFileHistory() {
    document.location.href='LeadsDocuments.do?command=Details&headerId=' + thisHeaderId +'&fid=' + thisFileId + '&folderId='+thisFolderId + '<%= addLinkParams(request, "viewSource") %>';
  }
  function details() {
    window.location.href = 'LeadsDocuments.do?command=Details&headerId=' + thisHeaderId + '&fid=' + thisFileId + '&folderId='+thisFolderId + '<%= addLinkParams(request, "viewSource") %>';
  }
  function view() {
    popURL('LeadsDocuments.do?command=Download&headerId='+ thisHeaderId +'&fid=' + thisFileId + '&view=true', 'Content', 640,480, 1, 1);
  }
  function modify() {
    window.location.href = 'LeadsDocuments.do?command=Modify&fid=' + thisFileId + '&headerId=' + thisHeaderId  + '&folderId='+thisFolderId + '<%= addLinkParams(request, "viewSource") %>';
  }
  function download() {
    window.location.href = 'LeadsDocuments.do?command=Download&headerId=' + thisHeaderId + '&fid=' + thisFileId + '&folderId='+thisFolderId + '<%= addLinkParams(request, "viewSource") %>';
  }
  function addVersion() {
    document.location.href='LeadsDocuments.do?command=AddVersion&headerId=' + thisHeaderId + '&fid=' + thisFileId + '&folderId='+ thisFolderId + '<%= addLinkParams(request, "viewSource") %>';
  }
  function moveFile() {
    popURL('LeadsDocuments.do?command=Move&headerId=' + thisHeaderId + '&fid=' + thisFileId + '<%= addLinkParams(request, "viewSource") %>' + '&popup=true&return=LeadsDocuments&param=' + thisHeaderId +'&param2='+thisFolderId,'Files','400','375','yes','yes');
  }
  function deleteFile() {
    confirmDelete('LeadsDocuments.do?command=Delete&fid=' + thisFileId + '&headerId=' + thisHeaderId  + '&folderId='+thisFolderId + '<%= addLinkParams(request, "viewSource") %>');
  }
  
</script>
<div id="menuFileContainer" class="menu">
  <div id="menuFileContent">
    <table id="menuFileTable" class="pulldown" width="170" cellspacing="0">
      <dhv:permission name="pipeline-opportunities-documents-view">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)"
          onclick="viewFileHistory()">
        <th>
          <img src="images/icons/stock_zoom-page-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          View File History
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="pipeline-opportunities-documents-view">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="download();">
        <th>
          <img src="images/icons/stock_data-save-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          Download File
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="pipeline-opportunities-documents-view">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="view();">
        <th>
          <img src="images/icons/stock_zoom-page-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          View File Contents
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="pipeline-opportunities-documents-edit">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="modify();">
        <th>
          <img src="images/icons/stock_edit-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          Rename File
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="pipeline-opportunities-documents-edit">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)"
          onclick="addVersion()">
        <th>
          <img src="images/icons/stock_insert-file-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td>
          Add Version
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="pipeline-opportunities-documents-edit">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)"
          onclick="moveFile()">
        <th>
          <img src="images/icons/stock_drag-mode-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td>
          Move File
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="pipeline-opportunities-documents-delete">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="deleteFile();">
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
<div id="menuFolderContainer" class="menu">
  <div id="menuFolderContent">
    <table id="menuFolderTable" class="pulldown" width="170" cellspacing="0">
      <dhv:permission name="pipeline-opportunities-documents-view">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)"
          onclick="viewFolder();">
        <th valign="top">
          <img src="images/icons/stock_zoom-folder-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          View Folder
        </td>
      </tr>
      </dhv:permission>
      <dhv:permission name="pipeline-opportunities-documents-edit">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)"
          onclick="editFolder();">
        <th>
          <img src="images/icons/stock_rename-page-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          Rename Folder
        </td>
      </tr>
    </dhv:permission>
      <dhv:permission name="pipeline-opportunities-documents-edit">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)"
          onclick="moveFolder();">
        <th>
          <img src="images/icons/stock_drag-mode-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td>
          Move Folder
        </td>
      </tr>
    </dhv:permission>
      <dhv:permission name="pipeline-opportunities-documents-delete">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)"
          onclick="deleteFolder();">
        <th valign="top">
          <img src="images/icons/stock_left-with-subpoints-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td>
          Delete Folder and Move contents to current folder
        </td>
      </tr>
    </dhv:permission> 
    </table>
  </div>
</div>

