<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ include file="../initPage.jsp" %>
<form name="modifyTimeout" action="AdminConfig.do?command=Update" method="post">
<%-- Trails --%>
<table class="trails">
<tr>
<td>
<a href="Admin.do">Setup</a> >
<a href="AdminConfig.do?command=ListGlobalParams">Configure System</a> >
Modify Setting
</td>
</tr>
</table>
<%-- End Trails --%>
For system emails, what email address should be in the FROM field of the email?<br>
&nbsp;<br>
<dhv:permission name="admin-sysconfig-view">
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
    <tr>
      <th colspan="2">
        <strong>Modify Server's Email Address</strong>
      </th>
    </tr>
    <tr class="containerBody">
      <td class="formLabel">
        Email Address
      </td>
      <td>
         <input type="text" size="40" name="emailAddress" value="<%= toHtmlValue(getPref(getServletContext(), "EMAILADDRESS")) %>"/><font color="red">*</font>
         <%= showAttribute(request, "emailAddressError") %><br>
         (ex: darkhorse_crm@yourcompany.com)
      </td>
    </tr>
  </table>
  <br>
  <input type="submit" value="Update">
  <input type="button" value="Cancel" onClick="javascript:window.location.href='AdminConfig.do?command=ListGlobalParams';">
</dhv:permission>
</form>
