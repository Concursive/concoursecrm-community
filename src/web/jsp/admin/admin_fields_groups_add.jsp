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
<%@ page import="java.util.*,java.text.*,org.aspcfs.modules.admin.base.*" %>
<jsp:useBean id="CategoryList" class="org.aspcfs.modules.base.CustomFieldCategoryList" scope="request"/>
<jsp:useBean id="Category" class="org.aspcfs.modules.base.CustomFieldCategory" scope="request"/>
<jsp:useBean id="Group" class="org.aspcfs.modules.base.CustomFieldGroup" scope="request"/>
<jsp:useBean id="PermissionCategory" class="org.aspcfs.modules.admin.base.PermissionCategory" scope="request"/>
<jsp:useBean id="ModId" class="java.lang.String" scope="request"/>
<jsp:useBean id="ConstantId" class="java.lang.String" scope="request"/>
<%@ include file="../initPage.jsp" %>
<body onLoad="document.forms[0].name.focus();">
<form name="details" action="AdminFieldsGroup.do?command=InsertGroup&modId=<%= ModId %>&catId=<%= Category.getId() %>&auto-populate=true" method="post">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Admin.do">Admin</a> >
<a href="Admin.do?command=Config">Configure Modules</a> >
<a href="Admin.do?command=ConfigDetails&moduleId=<%=ModId%>"><%= PermissionCategory.getCategory() %></a> >
<a href="AdminFieldsFolder.do?command=ListFolders&modId=<%= ModId %>">Custom Folders</a> > 
<a href="AdminFieldsGroup.do?command=ListGroups&modId=<%= ModId %>&catId=<%= Category.getId() %>">Folder</a> >
New Group
</td>
</tr>
</table>
<%-- End Trails --%>
<dhv:formMessage showSpace="false" />
<strong>Module:</strong> <%= toHtml(PermissionCategory.getCategory()) %><br />
<strong>Folder:</strong> <%= toHtml(Category.getName()) %><br />
<br />
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      Add a Group
    </th>
  </tr>
  <tr class="containerBody">
    <td class="formLabel">
      Group Name
    </td>
    <td>
      <input type="text" name="name" maxlength="200" value="<%= toHtmlValue(Group.getName()) %>"><font color="red">*</font>
      <%= showAttribute(request, "nameError") %>
    </td>
  </tr>
</table>
&nbsp;<br>
<input type="hidden" name="categoryId" value="<%= Category.getId() %>">
<input type="hidden" name="moduleId" value="<%= ConstantId %>">
<input type="submit" value="Save">
<input type="submit" value="Cancel" onClick="javascript:this.form.action='AdminFieldsGroup.do?command=ListGroups&modId=<%= ModId %>&catId=<%= Category.getId() %>'">
</form>
</body>
