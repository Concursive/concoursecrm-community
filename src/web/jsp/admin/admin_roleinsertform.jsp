<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="org.aspcfs.modules.admin.base.Permission, java.util.*" %>
<%@ include file="../initPage.jsp" %>
<jsp:useBean id="Role" class="org.aspcfs.modules.admin.base.Role" scope="request"/>
<jsp:useBean id="PermissionList" class="org.aspcfs.modules.admin.base.PermissionList" scope="request"/>
<body onLoad="javascript:document.forms[0].role.focus();">
<form action='Roles.do?command=InsertRole&auto-populate=true' method='post'>
<a href="Admin.do">Setup</a> >
Add Role<br>
<hr color="#BFBFBB" noshade>
<input type="submit" value="Add" name="Save">
<input type="submit" value="Cancel" onClick="javascript:this.form.action='Roles.do?command=ListRoles'">
<br>
<%= showError(request, "actionError") %>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan="2">
	    <strong>Add a Role</strong>
	  </td>
  </tr>
  <tr>
    <td class="formLabel">Role Name</td>
    <td><input type="text" name="role" maxlength="80" value="<%= toHtmlValue(Role.getRole()) %>"><font color="red">*</font> <%= showAttribute(request, "roleError") %></td>
  </tr>
  <tr>
    <td class="formLabel">Description</td>
    <td nowrap><input type="text" name="description" size="60" maxlength="255" value="<%= toHtmlValue(Role.getDescription()) %>"><font color="red">*</font> <%= showAttribute(request, "descriptionError") %></td>
  </tr>
</table>
&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan="5">
	    <strong>Configure permissions for this role</strong>
	  </td>
  </tr>
<%
  Iterator i = PermissionList.iterator();
  int idCount = 0;
  while (i.hasNext()) {
    ++idCount;
    Permission thisPermission = (Permission)i.next();
    if (PermissionList.isNewCategory(thisPermission.getCategoryName())) {
%>
    <tr bgcolor="#E5E5E5">
      <td>
        <%= toHtml(thisPermission.getCategoryName()) %>
      </td>
      <td width="40" align="center">Access/<br>View</td>
      <td width="40" align="center">Add</td>
      <td width="40" align="center">Edit</td>
      <td width="40" align="center">Delete</td>
  </tr>
<%
   }
%>  
  <tr>
    <td>
      <input type="hidden" name="permission<%= idCount %>id" value="<%= thisPermission.getId() %>">
      <%= toHtml(thisPermission.getDescription()) %>
    </td>
    <td align="center">
      <input type="checkbox" value="ON" name="permission<%= idCount %>view" <%= thisPermission.getView()?"":"disabled" %>>
    </td>
    <td align="center">
      <input type="checkbox" value="ON" name="permission<%= idCount %>add" <%= thisPermission.getAdd()?"":"disabled" %>>
    </td>
    <td align="center">
      <input type="checkbox" value="ON" name="permission<%= idCount %>edit" <%= thisPermission.getEdit()?"":"disabled" %>>
    </td>
    <td align="center">
      <input type="checkbox" value="ON" name="permission<%= idCount %>delete" <%= thisPermission.getDelete()?"":"disabled" %>>
    </td>
  </tr>
<%
  }
%>
</table>
<br>
<input type="submit" value="Add" name="Save">
<input type="submit" value="Cancel" onClick="javascript:this.form.action='Roles.do?command=ListRoles'">
</form>
</body>
