<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*" %>
<jsp:useBean id="User" class="com.darkhorseventures.cfsbase.User" scope="request"/>
<jsp:useBean id="EmployeeBean" class="com.darkhorseventures.cfsbase.Contact" scope="request"/>
<%@ include file="initPage.jsp" %>
<body onLoad="javascript:document.forms[0].password.focus();">
<form action="MyCFSPassword.do?command=UpdatePassword&auto-populate=true" method="post">
<a href="MyCFS.do?command=Home">My Home Page</a> > 
<a href="MyCFS.do?command=MyProfile">My Settings</a> >
Password<br>
<hr color="#BFBFBB" noshade>
<dhv:permission name="myhomepage-profile-password-edit">
<input type="submit" value="Update" name="Save">
<input type="submit" value="Cancel" onClick="javascript:this.form.action='MyCFS.do?command=MyProfile'">
<input type="reset" value="Reset">
</dhv:permission>
<br>
<%= showError(request, "actionError") %>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr bgcolor="#DEE0FA">
    <td colspan=2 valign=center align=left>
      <strong>Update Password</strong>
    </td>
  </tr>
  <tr><td nowrap class="formLabel">Current Password</td><td><input type="password" name="password" value=""><font color="red">*</font> <%= showAttribute(request, "passwordError") %></td></tr>
  <tr><td nowrap class="formLabel">New Password</td><td><input type="password" name="password1" value=""><font color="red">*</font> <%= showAttribute(request, "password1Error") %></td></tr>
  <tr><td nowrap class="formLabel">Verify New Password</td><td><input type="password" name="password2" value=""><font color="red">*</font> <%= showAttribute(request, "password2Error") %></td></tr>
</table>

<dhv:permission name="myhomepage-profile-password-edit">
<br>
<input type=hidden value="<%=User.getId()%>" name="id">
<input type="submit" value="Update" name="Save">
<input type="submit" value="Cancel" onClick="javascript:this.form.action='MyCFS.do?command=MyProfile'">
<input type="reset" value="Reset">
</dhv:permission>

</form>
</body>
