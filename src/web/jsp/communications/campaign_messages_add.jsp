<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="Message" class="org.aspcfs.modules.communications.base.Message" scope="request"/>
<%@ include file="../initPage.jsp" %>
<%-- End HtmlArea + look at body onLoad --%>
<%
  boolean enhancedEditor = false;
  if (("ie".equals(User.getBrowserId()) && User.getBrowserVersion() >= 5.5) ||
      ("moz".equals(User.getBrowserId()) && User.getBrowserVersion() >= 1.3)) {
    enhancedEditor = true;
%>
<body onLoad="initEditor();document.forms[0].name.focus();">
<% 
  } else {
%>
<body onLoad="document.forms[0].name.focus();">
<%}%>
<form name="addMessage" method="post" action="CampaignManagerMessage.do?command=Insert&auto-populate=true">
<%-- Trails --%>
<table class="trails">
<tr>
<td>
<a href="CampaignManager.do">Communications</a> >
<a href="CampaignManagerMessage.do?command=View">Message List</a> >
Add Message
</td>
</tr>
</table>
<%-- End Trails --%>
<input type="submit" value="Save Message">
<input type="submit" value="Cancel" onClick="javascript:this.form.action='CampaignManagerMessage.do?command=View'">
<input type="reset" value="Reset">
<br>
<%= showError(request, "actionError") %>
<%@ include file="message_include.jsp" %>
<br>
<input type="submit" value="Save Message">
<input type="submit" value="Cancel" onClick="javascript:this.form.action='CampaignManagerMessage.do?command=View'">
<input type="reset" value="Reset">
</form>
</body>
