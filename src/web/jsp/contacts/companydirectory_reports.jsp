<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,java.text.DateFormat,com.zeroio.iteam.base.*,org.aspcfs.modules.contacts.base.*" %>
<jsp:useBean id="FileList" class="com.zeroio.iteam.base.FileItemList" scope="request"/>
<jsp:useBean id="ContactRptListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<%@ include file="../initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>
<%@ include file="companydirectory_reports_menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<script language="JavaScript" type="text/javascript" src="javascript/popURL.js"></script>
<script language="JavaScript" type="text/javascript">
  <%-- Preload image rollovers for drop-down menu --%>
  loadImages('select');
</script>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="ExternalContacts.do">Contacts</a> > 
Export Data
</td>
</tr>
</table>
<%-- End Trails --%>
<dhv:permission name="contacts-external_contacts-reports-add"><a href="ExternalContacts.do?command=GenerateForm">Generate new export</a></dhv:permission>
<dhv:permission name="contacts-external_contacts-reports-add" none="true"><br></dhv:permission>
<center><%= ContactRptListInfo.getAlphabeticalPageLinks() %></center>
<table width="100%" border="0">
  <tr>
    <form name="listView" method="post" action="ExternalContacts.do?command=Reports">
    <td align="left">
      <select size="1" name="listView" onChange="javascript:document.forms[0].submit();">
        <option <%= ContactRptListInfo.getOptionValue("my") %>>My Exported Data</option>
        <option <%= ContactRptListInfo.getOptionValue("all") %>>All Exported Data</option>
      </select>
    </td>
    <td>
      <dhv:pagedListStatus title="<%= showError(request, "actionError") %>" object="ContactRptListInfo"/>
    </td>
    </form>
  </tr>
</table>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
  <tr>
    <dhv:permission name="contacts-external_contacts-reports-view,contacts-external_contacts-reports-delete">
    <th>
      <strong>Action</strong>
    </th>
    </dhv:permission>
    <th>
      <strong>Subject</strong>
    </th>
    <th>
      <strong>Size</strong>
    </th>
    <th nowrap>
      <strong>Create Date</strong>
    </th>
    <th nowrap>
      <strong>Created By</strong>
    </th>
    <th nowrap>
      <strong>D/L</strong>
    </th>
  </tr>
<%
	Iterator j = FileList.iterator();
	if ( j.hasNext() ) {
		int rowid = 0;
    int count = 0;
    while (j.hasNext()) {
      count++;
      rowid = (rowid != 1?1:2);
      FileItem thisItem = (FileItem)j.next();
%>      
  <tr>
      <td valign="center" class="row<%= rowid %>" nowrap>
        <%-- Use the unique id for opening the menu, and toggling the graphics --%>
         <a href="javascript:displayMenu('menuReport','<%= thisItem.getId() %>');" onMouseOver="over(0, <%= count %>)" onmouseout="out(0, <%= count %>)"><img src="images/select.gif" name="select<%= count %>" align="absmiddle" border="0"></a>
      </td>
    <td width="100%" class="row<%= rowid %>">
      <a href="javascript:popURL('ExternalContacts.do?command=ShowReportHtml&pid=-1&fid=<%= thisItem.getId() %>&popup=true&popup=true','Report','600','400','yes','yes');"><%=toHtml(thisItem.getSubject())%></a>
    </td>
    <td align="right" class="row<%= rowid %>" nowrap>
      <%= thisItem.getRelativeSize() %>k
    </td>
    <td class="row<%= rowid %>" nowrap>
    <dhv:tz timestamp="<%= thisItem.getEntered() %>" dateFormat="<%= DateFormat.SHORT %>" timeFormat="<%= DateFormat.LONG %>"/>
    </td>
    <td class="row<%= rowid %>" nowrap>
      <%= toHtml(thisItem.getEnteredByString()) %>
    </td>
    <td align="right" class="row<%= rowid %>" nowrap>
      <%= thisItem.getDownloads() %>
    </td>
 </tr>
<%}%>
</table>
<br>
<dhv:pagedListControl object="ContactRptListInfo" tdClass="row1"/>
<%} else {%>
  <tr class="containerBody">
    <td colspan="6">No exported data found.</td>
  </tr>
</table>
<%}%>

