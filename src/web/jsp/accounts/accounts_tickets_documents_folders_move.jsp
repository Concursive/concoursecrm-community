<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.zeroio.iteam.base.*, org.aspcfs.modules.troubletickets.base.*" %>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.troubletickets.base.Ticket" scope="request"/>
<jsp:useBean id="TicketDocumentListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="FileFolder" class="com.zeroio.iteam.base.FileFolder" scope="request"/>
<jsp:useBean id="folderHierarchy" class="com.zeroio.iteam.base.FileFolderHierarchy" scope="request"/>
<%@ include file="../initPage.jsp" %>
<table cellpadding="0" cellspacing="0" width="100%" border="0">
<tr>
  <td>
    Select a folder to move the item to:<br>
    <img src="images/icons/stock_folder-16-19.gif" border="0" align="absmiddle">
    <%= toHtml(FileFolder.getSubject()) %>
  </td>
</tr>
</table>
&nbsp;<br>
<table cellpadding="0" cellspacing="0" width="100%" border="1" rules="cols">
  <tr class="section">
    <td valign="top" width="100%">
      <img alt="" src="images/tree7o.gif" border="0" align="absmiddle" height="16" width="19"/>
      <img alt="" src="images/icons/stock_open-16-19.gif" border="0" align="absmiddle" height="16" width="19"/>
    <dhv:evaluate if="<%= FileFolder.getParentId() != -1 %>">
      <a href="AccountTicketsDocumentsFolders.do?command=SaveMove&tId=<%= TicketDetails.getId() %>&id=<%= FileFolder.getId() %>&popup=true&folderId=0&return=AccountTicketsDocuments&param=<%= TicketDetails.getId() %>&param2=<%= FileFolder.getParentId() %>">Home</a>
    </dhv:evaluate>
    <dhv:evaluate if="<%= FileFolder.getParentId() == -1 %>">
      Home
      (current folder)
    </dhv:evaluate>
    </td>
  </tr>
<%
  int rowid = 0;
  Iterator i = folderHierarchy.getHierarchy().iterator();
  while (i.hasNext()) {
    rowid = (rowid != 1?1:2);
    FileFolder thisFolder = (FileFolder) i.next();
%>    
  <tr class="row<%= rowid %>">
    <td valign="top">
    <% for(int j=1;j<thisFolder.getLevel();j++){ %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%}%>
      <img border="0" src="images/treespace.gif" align="absmiddle" height="16" width="19">
      <img alt="" src="images/tree7o.gif" border="0" align="absmiddle" height="16" width="19"/>
      <img border="0" src="images/icons/stock_open-16-19.gif" align="absmiddle">
    <% if(FileFolder.getParentId() != thisFolder.getId() && (FileFolder.getId() != thisFolder.getId())){  %>
      <a href="AccountTicketsDocumentsFolders.do?command=SaveMove&tId=<%= TicketDetails.getId() %>&id=<%= FileFolder.getId() %>&popup=true&folderId=<%= thisFolder.getId() %>&return=AccountTicketsDocuments&param=<%= TicketDetails.getId() %>&param2=<%= FileFolder.getParentId() %>"><%= toHtml(thisFolder.getSubject()) %></a>
    <% } else if(FileFolder.getId() == thisFolder.getId()) { %>
        <%= toHtml(thisFolder.getSubject()) %>
        (selected folder)
    <% } else {%>
      <%= toHtml(thisFolder.getSubject()) %>
      (current folder)
    <% } %>
    </td>
  </tr>
<%
  }
%>
</table>
&nbsp;<br>
<input type="button" value="Cancel" onClick="javascript:window.close()">

