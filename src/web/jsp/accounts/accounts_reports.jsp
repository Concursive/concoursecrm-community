<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.zeroio.iteam.base.*,org.aspcfs.modules.accounts.base.*" %>
<jsp:useBean id="FileList" class="com.zeroio.iteam.base.FileItemList" scope="request"/>
<jsp:useBean id="RptListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<%@ include file="../initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="/javascript/confirmDelete.js"></SCRIPT>
<script language="JavaScript" type="text/javascript" src="/javascript/popURL.js"></script>
<a href="/Accounts.do">Account Management</a> > 
Reports<br>
<hr color="#BFBFBB" noshade>
<dhv:permission name="accounts-accounts-reports-add"><a href="Accounts.do?command=GenerateForm">Generate new report</a></dhv:permission>
<dhv:permission name="accounts-accounts-reports-add" none="true"><br></dhv:permission>
<center><%= RptListInfo.getAlphabeticalPageLinks() %></center>
<table width="100%" border="0">
  <tr>
    <form name="listView" method="post" action="Accounts.do?command=Reports">
    <td align="left">
      <select size="1" name="listView" onChange="javascript:document.forms[0].submit();">
        <option <%= RptListInfo.getOptionValue("my") %>>My Reports</option>
        <option <%= RptListInfo.getOptionValue("all") %>>All Reports</option>
      </select>
    </td>
    <td>
      <dhv:pagedListStatus title="<%= showError(request, "actionError") %>" object="RptListInfo"/>
    </td>
    </form>
  </tr>
</table>
<table cellpadding="4" cellspacing="0" border="1" width="100%" class="pagedlist" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <dhv:permission name="accounts-accounts-reports-view,accounts-accounts-reports-delete">
    <td>
      <strong>Action</strong>
    </td>
    </dhv:permission>
    <td nowrap>
      <strong><a href="Accounts.do?command=Reports&column=subject">File Subject</a></strong>
      <%= RptListInfo.getSortIcon("subject") %>
    </td>
    <td>
      <strong>Size</strong>
    </td>
    <td nowrap>
      <strong><a href="Accounts.do?command=Reports&column=entered">Create Date</a></strong>
      <%= RptListInfo.getSortIcon("entered") %>
    </td>
     <td>
      <strong>Created By</strong>
    </td>
    <td>
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
    <dhv:permission name="accounts-accounts-reports-view,accounts-accounts-reports-delete">
      <td width="8" valign="center" nowrap class="row<%= rowid %>">
        <dhv:permission name="accounts-accounts-reports-view"><a href="Accounts.do?command=DownloadCSVReport&fid=<%= thisItem.getId() %>">D/L</a></dhv:permission><dhv:permission name="accounts-accounts-reports-view,accounts-accounts-reports-delete" all="true">|</dhv:permission><dhv:permission name="accounts-accounts-reports-delete"><a href="javascript:confirmDelete('/Accounts.do?command=DeleteReport&pid=-1&fid=<%= thisItem.getId() %>');">Del</a></dhv:permission>
      </td>
    </dhv:permission>
    <td width="40%" class="row<%= rowid %>">
      <a href="javascript:popURL('Accounts.do?command=ShowReportHtml&pid=-1&fid=<%= thisItem.getId() %>&popup=true','Report','600','400','yes','yes');"><%=toHtml(thisItem.getSubject())%></a>
    </td>
    <td width="20" class="row<%= rowid %>">
      <%= thisItem.getRelativeSize() %>k
    </td>
    <td width="30%" class="row<%= rowid %>">
      <%=toHtml(thisItem.getEnteredDateTimeString())%>
    </td>
    <td width="30%" class="row<%= rowid %>">
      <%=toHtml(thisItem.getEnteredByString())%>
    </td>
    <td width="8" class="row<%= rowid %>">
      <%= thisItem.getDownloads() %>
    </td>
 </tr>
<%}%>
</table>
<br>
<dhv:pagedListControl object="RptListInfo"/>
<%} else {%>
  <tr>
    <td colspan="6">No reports found.</td>
  </tr>
</table>
<%}%>

