<%-- 
  - Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. DARK HORSE
  - VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.actionlist.base.*, org.aspcfs.modules.base.Constants"%>
<jsp:useBean id="ActionLists" class="org.aspcfs.modules.actionlist.base.ActionLists" scope="request"/>
<jsp:useBean id="ActionListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>
<%@ include file="action_lists_menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<script language="JavaScript" type="text/javascript">
  <%-- Preload image rollovers for drop-down menu --%>
  loadImages('select');
</script>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="MyCFS.do?command=Home">My Home Page</a> >
Action Lists
</td>
</tr>
</table>
<%-- End Trails --%>
<dhv:permission name="myhomepage-action-lists-add">
<a href="javascript:window.location.href='MyActionLists.do?command=Add&return=list&params=' + escape('filters=all|mycontacts|accountcontacts');">Add an Action List</a><br>
</dhv:permission>
<br>
<table width="100%" border="0">
  <tr>
    <form name="listView" method="post" action="MyActionLists.do?command=List&linkModuleId=<%= Constants.ACTIONLISTS_CONTACTS %>">
    <td align="left">
      <select size="1" name="listView" onChange="javascript:document.forms[0].submit();">
        <option <%= ActionListInfo.getOptionValue("inprogress") %>>All In Progress Lists</option>
        <option <%= ActionListInfo.getOptionValue("complete") %>>All Complete Lists</option>
        <option <%= ActionListInfo.getOptionValue("all") %>>All Lists</option>
      </select>
    </td>
    <td>
      <dhv:pagedListStatus title="<%= showError(request, "actionError") %>" object="ActionListInfo"/>
    </td>
    </form>
  </tr>
</table>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
  <tr>
    <th rowspan="2" valign="middle">
      <strong>Action</strong>
    </th>
    <th rowspan="2" valign="middle" width="100%">
      <strong><a href="MyActionLists.do?command=List&linkModuleId=<%= Constants.ACTIONLISTS_CONTACTS %>&column=al.description">Name</a></strong>
      <%= ActionListInfo.getSortIcon("al.description") %>
    </th>
    <th colspan="2" align="center">
      <strong>Progress</strong>
    </th>
    <th rowspan="2" valign="middle" nowrap>
      <strong><a href="MyActionLists.do?command=List&linkModuleId=<%= Constants.ACTIONLISTS_CONTACTS %>&column=al.modified">Last Updated</a></strong>
      <%= ActionListInfo.getSortIcon("al.modified") %>
    </th>
  </tr>
  <tr>
    <th>
      <strong>Complete</strong>
    </th>
    <th>
      <strong>Total</strong>
    </th>
  </tr>
<%
  Iterator j = ActionLists.iterator();
  if ( j.hasNext() ) {
  int rowid = 0;
  int i =0;
  while (j.hasNext()) {
      i++;
      rowid = (rowid != 1 ? 1 : 2);
      ActionList thisList = (ActionList) j.next();
%>
  <tr class="row<%= rowid %>">
    <td nowrap>
     <%-- Use the unique id for opening the menu, and toggling the graphics --%>
      <a href="javascript:displayMenu('select<%= i %>','menuAction','<%= thisList.getId() %>','<%=  toHtmlValue(request.getParameter("linkModuleId")) %>');" onMouseOver="over(0, <%= i %>)" onmouseout="out(0, <%= i %>); hideMenu('menuAction');"><img src="images/select.gif" name="select<%= i %>" id="select<%= i %>" align="absmiddle" border="0"></a>
    </td>
    <td width="100%">
      <a href="MyActionContacts.do?command=List&actionId=<%= thisList.getId() %>&reset=true"><%= toHtmlValue(thisList.getDescription()) %></a>
    </td>
    <td nowrap align="center">
      <%= thisList.getTotalComplete() %>
    </td>
    <td nowrap align="center">
      <%= thisList.getTotal() %>
    </td>
    <td nowrap align="center">
      <zeroio:tz timestamp="<%= thisList.getModified() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="yes" />
    </td>
  </tr>
<%}
}else{%>
      <tr>
        <td class="containerBody" colspan="5" valign="center">
          No Action Lists found in this view.
        </td>
      </tr>
<%}%>
</table>
&nbsp;<br>
<dhv:pagedListControl object="ActionListInfo" tdClass="row1"/>

