<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.zeroio.iteam.base.*,org.aspcfs.modules.contacts.base.*" %>
<jsp:useBean id="FileList" class="com.zeroio.iteam.base.FileItemList" scope="request"/>
<jsp:useBean id="ContactRptListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<%@ include file="../initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<script language="JavaScript" type="text/javascript" src="javascript/popURL.js"></script>
<a href="ExternalContacts.do">General Contacts</a> > 
Reports<br>
<hr color="#BFBFBB" noshade>
<dhv:permission name="contacts-external_contacts-reports-add"><a href="ExternalContacts.do?command=GenerateForm">Generate new report</a></dhv:permission>
<dhv:permission name="contacts-external_contacts-reports-add" none="true"><br></dhv:permission>
<center><%= ContactRptListInfo.getAlphabeticalPageLinks() %></center>
<table width="100%" border="0">
  <tr>
    <form name="listView" method="post" action="ExternalContacts.do?command=Reports">
    <td align="left">
      <select size="1" name="listView" onChange="javascript:document.forms[0].submit();">
        <option <%= ContactRptListInfo.getOptionValue("my") %>>My Reports</option>
        <option <%= ContactRptListInfo.getOptionValue("all") %>>All Reports</option>
      </select>
    </td>
    <td>
      <dhv:pagedListStatus title="<%= showError(request, "actionError") %>" object="ContactRptListInfo"/>
    </td>
    </form>
  </tr>
</table>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <dhv:permission name="contacts-external_contacts-reports-view,contacts-external_contacts-reports-delete">
    <td>
      <strong>Action</strong>
    </td>
    </dhv:permission>
    <td>
      <strong>Subject</strong>
    </td>
    <td>
      <strong>Size</strong>
    </td>
    <td nowrap>
      <strong>Create Date</strong>
    </td>
     <td nowrap>
      <strong>Created By</strong>
    </td>
    <td nowrap>
      <strong>D/L</strong>
    </td>
  </tr>
<%
	Iterator j = FileList.iterator();
	if ( j.hasNext() ) {
		int rowid = 0;
    while (j.hasNext()) {
      rowid = (rowid != 1?1:2);
      FileItem thisItem = (FileItem)j.next();
%>      
  <tr>
    <dhv:permission name="contacts-external_contacts-reports-view,contacts-external_contacts-reports-delete">
      <td valign="center" class="row<%= rowid %>" nowrap>
        <dhv:permission name="contacts-external_contacts-reports-view"><a href="ExternalContacts.do?command=DownloadCSVReport&fid=<%= thisItem.getId() %>">D/L</a></dhv:permission><dhv:permission name="contacts-external_contacts-reports-view,contacts-external_contacts-reports-delete" all="true">|</dhv:permission><dhv:permission name="contacts-external_contacts-reports-delete"><a href="javascript:confirmDelete('ExternalContacts.do?command=DeleteReport&pid=-1&fid=<%= thisItem.getId() %>');">Del</a></dhv:permission>
      </td>
    </dhv:permission>
    <td width="100%" class="row<%= rowid %>">
      <a href="javascript:popURL('ExternalContacts.do?command=ShowReportHtml&pid=-1&fid=<%= thisItem.getId() %>&popup=true&popup=true','Report','600','400','yes','yes');"><%=toHtml(thisItem.getSubject())%></a>
    </td>
    <td align="right" class="row<%= rowid %>" nowrap>
      <%= thisItem.getRelativeSize() %>k
    </td>
    <td class="row<%= rowid %>" nowrap>
      <%= toHtml(thisItem.getEnteredDateTimeString()) %>
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
    <td colspan="6">No reports found.</td>
  </tr>
</table>
<%}%>

