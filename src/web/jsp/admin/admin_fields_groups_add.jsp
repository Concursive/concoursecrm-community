<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,java.text.*,com.darkhorseventures.cfsbase.*" %>
<jsp:useBean id="ModuleList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="CategoryList" class="com.darkhorseventures.cfsbase.CustomFieldCategoryList" scope="request"/>
<jsp:useBean id="Category" class="com.darkhorseventures.cfsbase.CustomFieldCategory" scope="request"/>
<jsp:useBean id="Group" class="com.darkhorseventures.cfsbase.CustomFieldGroup" scope="request"/>
<%@ include file="initPage.jsp" %>
<body onLoad="document.forms[0].name.focus();">
<form name="details" action="/AdminFieldsGroup.do?command=InsertGroup&modId=<%= ModuleList.getSelectedKey() %>&catId=<%= Category.getId() %>&auto-populate=true" method="post">
<a href="/Admin.do">Setup</a> >
<a href="/Admin.do?command=Config">System Configuration</a> >
<a href="/AdminFieldsFolder.do?command=ListFolders&modId=<%= ModuleList.getSelectedKey() %>">Custom Folders</a> > 
<a href="/AdminFieldsGroup.do?command=ListGroups&modId=<%= ModuleList.getSelectedKey() %>&catId=<%= Category.getId() %>">Folder</a> >
New Group<br>
<%= showAttribute(request, "actionError") %><br>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
      <strong>Module: <%= toHtml(ModuleList.getSelectedValue(ModuleList.getSelectedKey())) %></strong>
    </td>
  </tr>
  <tr class="containerMenu">
    <td>
      <strong>Folder: <%= toHtml(Category.getName()) %></strong>
    </td>
  </tr>
  <tr>
    <td class="containerBack">
      <a href="/AdminFieldsGroup.do?command=ListGroups&modId=<%= ModuleList.getSelectedKey() %>&catId=<%= Category.getId() %>">Back to Folder</a><br>
      &nbsp;<br>
    
      <table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
        <tr class="title">
          <td colspan="2">
            Add a Group
          </td>
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
      <input type="hidden" name="moduleId" value="<%= ModuleList.getSelectedKey() %>">
      <input type="submit" value="Save">
      <input type="submit" value="Cancel" onClick="javascript:this.form.action='/AdminFieldsGroup.do?command=ListGroups&modId=<%= ModuleList.getSelectedKey() %>&catId=<%= Category.getId() %>'">
    </td>
  </tr>
</table>
</form>
</body>
