<%-- 
  - Copyright Notice: (C) 2000-2004 Dark Horse Ventures, All Rights Reserved.
  - License: This source code cannot be modified, distributed or used without
  -          written permission from Dark Horse Ventures. This notice must
  -          remain in place.
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<form name="modifyTimeout" action="AdminConfig.do?command=UpdateTimeout" method="post">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Admin.do">Admin</a> >
<a href="AdminConfig.do?command=ListGlobalParams">Configure System</a> >
Modify Timeout
</td>
</tr>
</table>
<%-- End Trails --%>
<table class="note" cellspacing="0">
  <tr>
    <th><img src="images/icons/stock_about-16.gif" border="0" align="absmiddle"/></th>
    <td><b>What
should the session timeout be for users?</b><br />
The session timeout is the time in which a user will automatically be logged out 
if the specified period of inactivity is reached.
</td></tr></table>
<dhv:permission name="admin-sysconfig-view">
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
    <tr>
      <th colspan="2">
        <strong>Modify Timeout</strong>
      </th>
    </tr>
    <tr class="containerBody">
      <td class="formLabel">
        Timeout 
      </td>
      <%  String[] timeouts = { "5", "10", "15", "30", "45", "60", "90"} ;
          String currentTimeout = request.getParameter("timeout");
      %>
      <td align="left">
         <select size="1" name="timeout">
          <% for(int i = 0 ; i < timeouts.length; i++){ %>
            <option value="<%=timeouts[i]%>" <%= currentTimeout.equals(timeouts[i])?" selected":"" %>><%= timeouts[i] %></option>
          <%}%>
         </select> minutes
      </td>
    </tr>
  </table>
  <br>
  <input type="submit" value="Update">
  &nbsp;<input type="button" value="Cancel" onClick="javascript:window.location.href='AdminConfig.do?command=ListGlobalParams';">
</dhv:permission>
</form>
