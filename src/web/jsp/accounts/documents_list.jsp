<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.zeroio.iteam.base.*,java.lang.*,java.text.*,org.aspcfs.modules.accounts.base.*" %>
<jsp:useBean id="fileFolderList" class="com.zeroio.iteam.base.FileFolderList" scope="request"/>
<jsp:useBean id="fileItemList" class="com.zeroio.iteam.base.FileItemList" scope="request"/>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>
<script language="JavaScript" type="text/javascript">
  loadImages('select');
</script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>

<%--TODO::START Document folder trails--%>
<table border="0" cellpadding="4" cellspacing="0" width="100%">
  <tr class="subtab">
    <td>
      <zeroio:folderHierarchy module="<%= documentModule %>" link="<%= documentFolderList %>"/>
    </td>
  </tr>
</table>
<%--TODO::END Document folder trails--%>
<br />
<dhv:permission name="<%= permission_doc_folders_add %>">
<img src="images/icons/stock_new-dir-16.gif" border="0" align="absmiddle"/>
<a href="<%= documentFolderAdd %>&parentId=<%= fileItemList.getFolderId() %>&folderId=<%= fileItemList.getFolderId() %>">New Folder</a>
</dhv:permission>
<dhv:permission name="<%= permission_doc_folders_add+","+ permission_doc_files_upload %>" all="true">
|
</dhv:permission>
<dhv:permission name="<%= permission_doc_files_upload %>">
<img src="images/icons/stock_insert-file-16.gif" border="0" align="absmiddle"/>
<a href="<%= documentFileAdd %>&parentId=<%= fileItemList.getFolderId() %>&folderId=<%= fileItemList.getFolderId() %>">Submit File</a>
</dhv:permission>
<dhv:evaluate if="<%= fileItemList.getFolderId() != -1 %>">
<dhv:permission name="<%= permission_doc_folders_edit %>">
  <dhv:permission name="<%= permission_doc_folders_add +","+permission_doc_files_upload %>" all="false">
|
  </dhv:permission>
<img src="images/icons/stock_rename-page-16.gif" border="0" align="absmiddle">
<a href="<%= documentFolderModify %>&folderId=<%= fileItemList.getFolderId() %>&id=<%= fileItemList.getFolderId() %>&parentId=<%= fileItemList.getFolderId() %>">Rename Folder</a>
</dhv:permission>
</dhv:evaluate>
<dhv:permission name="<%= permission_doc_folders_add +","+ permission_doc_files_upload +","+ permission_doc_folders_edit %>" all="false">
<br>
&nbsp;<br>
</dhv:permission>
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <tr>
    <th width="8" align="center" nowrap><strong>Action</strong></th>
    <th width="100%"><strong>File</strong></th>
    <th align="center"><strong>Type</strong></th>
    <th align="center"><strong>Size</strong></th>
    <th align="center"><strong>Version</strong></th>
    <th align="center" nowrap><strong>Date Modified</strong></th>
  </tr>
<dhv:evaluate if="<%= fileItemList.size() == 0 && fileFolderList.size() == 0 %>">
  <tr class="row2">
    <td colspan="6">No files to display.</td>
  </tr>
</dhv:evaluate>
<%
  int rowid = 0;
  if ( fileFolderList.size() > 0 ) {
    Iterator folders = fileFolderList.iterator();
    while (folders.hasNext()) {
      FileFolder thisFolder = (FileFolder) folders.next();
      rowid = (rowid != 1?1:2);
%>
  <tr>
    <td class="row<%= rowid %>" align="center" nowrap>
      <a href="javascript:displayMenu('selectfo<%= thisFolder.getId() %>', 'menuFolder', '<%= thisFolder.getId() %>','<%= thisFolder.getParentId() %>', '<%= specialID %>')"
         onMouseOver="over(0, 'fo<%= thisFolder.getId() %>')"
         onMouseOut="out(0, 'fo<%= thisFolder.getId() %>'); hideMenu('menuFolder');">
         <img src="images/select.gif" name="selectfo<%= thisFolder.getId() %>" id="selectfo<%= thisFolder.getId() %>" align="absmiddle" border="0"></a>
    </td>
    <td class="row<%= rowid %>" width="100%">
      <img src="images/stock_folder-23.gif" border="0" align="absmiddle">
      <a href="<%= documentFolderList %>&folderId=<%= thisFolder.getId() %><%= thisFolder.getDisplay() == 2?"&details=true":"" %>"><%= toHtml(thisFolder.getSubject()) %></a>
    </td>
    <td class="row<%= rowid %>" align="center" nowrap>
      folder
    </td>
    <td class="row<%= rowid %>" align="center" nowrap>
      <%= thisFolder.getItemCount() %> item<%= (thisFolder.getItemCount() == 1?"":"s") %>
    </td>
    <td class="row<%= rowid %>" align="center" nowrap>
      --
    </td>
    <td class="row<%= rowid %>" align="center" nowrap>
      <dhv:username id="<%= thisFolder.getModifiedBy() %>"/>
      <zeroio:tz timestamp="<%= thisFolder.getModified() %>"/>
    </td>
  </tr>
<%
    }
  }
  if ( fileItemList.size() > 0) {
    Iterator iterator = fileItemList.iterator();
    while (iterator.hasNext()) {
      rowid = (rowid != 1?1:2);
      FileItem thisFile = (FileItem)iterator.next();
%>    
  <tr>
    <td class="row<%= rowid %>" align="center" nowrap>
      <a href="javascript:displayMenu('selectfi<%= thisFile.getId() %>', 'menuFile', '<%= thisFile.getFolderId() %>', '<%= thisFile.getId() %>','<%= specialID %>')"
         onMouseOver="over(0, 'fi<%= thisFile.getId() %>')"
         onmouseout="out(0, 'fi<%= thisFile.getId() %>'); hideMenu('menuFile');">
         <img src="images/select.gif" name="selectfi<%= thisFile.getId() %>" id="selectfi<%= thisFile.getId() %>" align="absmiddle" border="0"></a>
     </td>
    <td class="row<%= rowid %>" width="100%">
      <%= thisFile.getImageTag("-23") %>
      <a href="<%= documentFileDetails %>&folderId=<%= thisFile.getFolderId() %>&fid=<%= thisFile.getId() %>"><%= toHtml(thisFile.getSubject()) %></a>
    </td>
    <td class="row<%= rowid %>" align="center" nowrap><%= toHtml(thisFile.getExtension()) %></td>
    <td class="row<%= rowid %>" align="right" nowrap>
      <%= thisFile.getRelativeSize() %> k&nbsp;
    </td>
    <td class="row<%= rowid %>" align="center" nowrap>
      <%= thisFile.getVersion() %>&nbsp;
    </td>
    <td class="row<%= rowid %>" align="center" nowrap>
      <zeroio:tz timestamp="<%= thisFile.getModified() %>"/><br />
      <dhv:username id="<%= thisFile.getModifiedBy() %>"/>
    </td>
  </tr>
<% }} %>
</table>
