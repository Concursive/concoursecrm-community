<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="org.aspcfs.utils.web.HtmlSelectLanguage" %>
<%@ page import="org.aspcfs.utils.web.HtmlSelect" %>
<%@ include file="../initPage.jsp" %>
<form name="modify" action="AdminConfig.do?command=Update" method="post">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Admin.do">Admin</a> >
<a href="AdminConfig.do?command=ListGlobalParams">Configure System</a> >
Modify Setting
</td>
</tr>
</table>
<%-- End Trails --%>
<table class="note" cellspacing="0">
  <tr>
    <th><img src="images/icons/stock_about-16.gif" border="0" align="absmiddle"/></th>
    <td><b>What should the 
default locale be for the system?</b><br />
</td></tr></table>
<dhv:permission name="admin-sysconfig-view">
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
    <tr>
      <th colspan="2">
        <strong>Modify Default Locale</strong>
      </th>
    </tr>
    <tr class="containerBody">
      <td class="formLabel">
        Locale
      </td>
      <td>
         <%= HtmlSelectLanguage.getSelect("language", getPref(getServletContext(), "SYSTEM.LANGUAGE")).getHtml() %><font color="red">*</font>
         <%= showAttribute(request, "languageError") %>
      </td>
    </tr>
  </table>
  <br>
  <input type="submit" value="Update">
  <input type="button" value="Cancel" onClick="javascript:window.location.href='AdminConfig.do?command=ListGlobalParams';">
</dhv:permission>
</form>
