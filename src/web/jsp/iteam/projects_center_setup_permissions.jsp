<%-- 
  - Copyright Notice: (C) 2000-2004 Team Elements, All Rights Reserved.
  - License: This source code cannot be modified, distributed or used without
  -          written permission from Team Elements. This notice must remain in
  -          place.
  - Author(s): Matt Rajkowski
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="Project" class="com.zeroio.iteam.base.Project" scope="request"/>
<jsp:useBean id="categories" class="com.zeroio.iteam.base.PermissionCategoryLookupList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" type="text/javascript" src="javascript/swapClass.js"></script>
<script language="JavaScript" type="text/javascript">
  function updateRole() {}
</script>
<form method="POST" name="inputForm" action="ProjectManagement.do?command=UpdatePermissions">
<table border="0" cellpadding="1" cellspacing="0" width="100%">
  <tr class="subtab">
    <td>
      <img src="images/icons/stock_macro-objects-16.gif" border="0" align="absmiddle">
      <a href="ProjectManagement.do?command=ProjectCenter&section=Setup&pid=<%= Project.getId() %>">Setup</a> >
      Configure Permissions
    </td>
  </tr>
</table>
<br>
<input type="submit" value=" Update ">
<input type="button" value="Cancel" onClick="javascript:window.location.href='ProjectManagement.do?command=ProjectCenter&section=Setup&pid=<%= Project.getId() %>'"><br>
&nbsp;
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <input type="hidden" name="pid" value="<%= Project.getId() %>">
  <input type="hidden" name="id" value="<%= Project.getId() %>">
  <input type="hidden" name="modified" value="<%= Project.getModified() %>">
  <tr>
    <th colspan="4" valign="center">
      <strong>Permissions</strong>
    </th>
  </tr>
<%
   int permissionCount = 0;
   Iterator i = categories.iterator();
   while (i.hasNext()) {
     PermissionCategoryLookup thisCategory = (PermissionCategoryLookup) i.next();
%>
<%-- For each category --%>
  <tr class="row1">
    <td width="100%" nowrap><%= toHtml(thisCategory.getDescription()) %></td>
    <td>Lowest Role</td>
  </tr>
<%
    Iterator j = thisCategory.getPermissions().iterator();
    while (j.hasNext()) {
      ++permissionCount;
      PermissionLookup thisPermission = (PermissionLookup) j.next();
%>
<%-- For each permission --%>
  <tr class="row2" onmouseover="swapClass(this,'rowHighlight')" onmouseout="swapClass(this,'row2')">
    <td width="100%" nowrap>&nbsp; &nbsp;<%= toHtml(thisPermission.getDescription()) %></td>
    <td align="center">
      <input type="hidden" name="perm<%= permissionCount %>" value="<%= thisPermission.getId() %>">
      <zeroio:roleSelect
          name="<%= "perm" + permissionCount + "level" %>"
          value="<%= Project.getAccessUserLevel(thisPermission.getPermission()) %>"/>
    </td>
  </tr>
<%-- End Content --%>
<%
     }
   }
%>
</table>
<br>
<input type="submit" value=" Update ">
<input type="button" value="Cancel" onClick="javascript:window.location.href='ProjectManagement.do?command=ProjectCenter&section=Setup&pid=<%= Project.getId() %>'">
</form>
