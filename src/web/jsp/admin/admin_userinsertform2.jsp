<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<jsp:useBean id="Contact" class="com.darkhorseventures.cfsbase.Contact" scope="request"/>
<jsp:useBean id="UserList" class="com.darkhorseventures.cfsbase.UserList" scope="request"/>
<jsp:useBean id="RoleList" class="com.darkhorseventures.cfsbase.RoleList" scope="request"/>
<jsp:useBean id="UserRecord" class="com.darkhorseventures.cfsbase.User" scope="request"/>
<%@ include file="initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="/javascript/checkDate.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="/javascript/popCalendar.js"></SCRIPT>
<body onLoad="javascript:document.forms[0].username.focus();">
<form name="addUser" action="/Users.do?command=AddUser&auto-populate=true" method="post">
<input type="hidden" name="typeId" value="<%= request.getParameter("typeId") %>">
<input type="hidden" name="contactId" value="<%= request.getParameter("contactId") %>">
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr bgcolor="#DEE0FA">
    <td colspan=2 valign=center align=left>
	    <strong>Insert a new user record</strong>
    </td>
  </tr>
  <tr><td nowrap class="formLabel">Contact Name</td><td><%= toHtml(Contact.getNameFirstLast()) %></td></tr>
  <tr><td nowrap class="formLabel">Department</td><td><%= toHtml(Contact.getDepartmentName()) %></td></tr>
  <tr><td nowrap class="formLabel">Unique Username</td><td><input type="text" name="username" value="<%= toHtmlValue(UserRecord.getUsername()) %>"><font color=red>*</font> <%= showAttribute(request, "usernameError") %></td></tr>
  <tr><td nowrap class="formLabel">Password</td><td><input type="password" name="password1"><font color=red>*</font> <%= showAttribute(request, "password1Error") %></td></tr>
  <tr><td nowrap class="formLabel">Type password again</td><td><input type="password" name="password2"><font color=red>*</font> <%= showAttribute(request, "password2Error") %></td></tr>
  <tr><td nowrap class="formLabel">Role (User Group)</td><td><%= RoleList.getHtmlSelect("roleId", UserRecord.getRoleId()) %><font color="red">*</font> <%= showAttribute(request, "roleError") %></td></tr>
  <tr>
    <td nowrap class="formLabel">Reports To</td>
    <td>
      <%= UserList.getHtmlSelect("managerId", UserRecord.getManagerId()) %>
      <%= showAttribute(request, "managerIdError") %>
    </td>
  </tr>
  
    <tr>
    <td nowrap class="formLabel">Alias User</td>
    <td>
      <%= UserList.getHtmlSelect("alias", UserRecord.getAlias()) %>
    </td>
  </tr>
  
  <tr>
    <td nowrap class="formLabel">Expire Date</td>
    <td>
    <input type=text size=10 name="expires" value="">
    <a href="javascript:popCalendar('addUser', 'expires');">Date</a> (mm/dd/yyyy)
    </td>
  </tr>
  

</table>
<input type="button" value="< Back" onClick="javascript:this.form.action='/Users.do?command=InsertUserForm';this.form.submit()">
<input type="submit" value="Add User">
</form>
</body>
