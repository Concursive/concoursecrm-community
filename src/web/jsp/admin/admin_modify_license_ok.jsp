<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<jsp:useBean id="APP_TEXT" class="java.lang.String" scope="application"/>
<jsp:useBean id="APP_ORGANIZATION" class="java.lang.String" scope="application"/>
<%@ include file="../initPage.jsp" %>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Admin.do">Admin</a> >
<a href="AdminConfig.do?command=ListGlobalParams">Configure System</a> >
<a href="AdminConfig.do?command=Modify&param=LICENSE">License</a> >
Status
</td>
</tr>
</table>
<%-- End Trails --%>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th>
      <strong>Status</strong>
    </th>
  </tr>
  <tr>
    <td>
      Transaction completed, however an updated license was not found.
    </td>
  </tr>
</table>
<br>
<input type="button" value="OK" onClick="javascript:window.location.href='AdminConfig.do?command=ListGlobalParams'"/>
