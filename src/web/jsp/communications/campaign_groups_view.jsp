<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.communications.base.*" %>
<jsp:useBean id="CampaignGroupListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="sclList" class="org.aspcfs.modules.communications.base.SearchCriteriaListList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>
<%@ include file="campaign_groups_view_menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></script>
<script language="JavaScript" type="text/javascript">
  <%-- Preload image rollovers for drop-down menu --%>
  loadImages('select');
</script>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="CampaignManager.do">Communications</a> >
View Groups
</td>
</tr>
</table>
<%-- End Trails --%>
<dhv:permission name="campaign-campaigns-groups-add"><a href="CampaignManagerGroup.do?command=Add">Add a Contact Group</a></dhv:permission>
<dhv:permission name="campaign-campaigns-messages-add" none="true"><br></dhv:permission>
<center><%= CampaignGroupListInfo.getAlphabeticalPageLinks() %></center>
<table width="100%" border="0">
  <tr>
    <form name="listView" method="post" action="CampaignManagerGroup.do?command=View">
    <td align="left">
      <select size="1" name="listView" onChange="javascript:document.forms[0].submit();">
        <option <%= CampaignGroupListInfo.getOptionValue("my") %>>My Groups</option>
        <option <%= CampaignGroupListInfo.getOptionValue("all") %>>All Groups</option>
      </select>
    </td>
    <td>
      <dhv:pagedListStatus title="<%= showError(request, "actionError") %>" object="CampaignGroupListInfo"/>
    </td>
    </form>
  </tr>
</table>
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
	<tr>
    <th width="8">
      <strong>Action</strong>
    </th>
    <th width="100%" nowrap>
      <a href="CampaignManagerGroup.do?command=View&column=name"><strong>Group Name</strong></a>
      <%= CampaignGroupListInfo.getSortIcon("name") %>
    </th>
    <th nowrap>
      <strong>Entered By</strong>
    </th>
    <th nowrap>
      <a href="CampaignManagerGroup.do?command=View&column=modified"><strong>Last Modified</strong></a>
      <%= CampaignGroupListInfo.getSortIcon("modified") %>
    </th>
<%
	Iterator j = sclList.iterator();
	if ( j.hasNext() ) {
		int rowid = 0;
    int count  = 0;
    while (j.hasNext()) {
      count++;
      rowid = (rowid != 1?1:2);
      SearchCriteriaList thisList = (SearchCriteriaList)j.next();
%>
	<tr class="containerBody">
    <td width="8" valign="center" nowrap class="row<%= rowid %>">
      <%-- Use the unique id for opening the menu, and toggling the graphics --%>
      <a href="javascript:displayMenu('menuGroup', '<%= thisList.getId() %>');"
      onMouseOver="over(0, <%= count %>)" onmouseout="out(0, <%= count %>)"><img src="images/select.gif" name="select<%= count %>" align="absmiddle" border="0"></a>
    </td>
    <td valign="center" class="row<%= rowid %>">
      <a href="CampaignManagerGroup.do?command=Details&id=<%= thisList.getId() %>"><%= toHtml(thisList.getGroupName()) %></a>
    </td>
    <td valign="center" align="left" class="row<%= rowid %>" nowrap>
      <dhv:username id="<%= thisList.getEnteredBy() %>" lastFirst="true"/>
    </td>
    <td valign="center" nowrap class="row<%= rowid %>">
      <dhv:tz timestamp="<%= thisList.getModified() %>" dateFormat="<%= DateFormat.SHORT %>" timeFormat="<%= DateFormat.LONG %>"/>
    </td>
  </tr>
	<%}%>
<%} else {%>
	<tr class="containerBody">
    <td colspan="4">
      No groups found.
    </td>
  </tr>
<%}%>
</table>
<br>
<dhv:pagedListControl object="CampaignGroupListInfo" tdClass="row1"/>
