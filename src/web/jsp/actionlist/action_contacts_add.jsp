<%-- 
  - Copyright Notice: (C) 2000-2004 Dark Horse Ventures, All Rights Reserved.
  - License: This source code cannot be modified, distributed or used without
  -          written permission from Dark Horse Ventures. This notice must
  -          remain in place.
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="org.aspcfs.modules.base.Constants" %>
<jsp:useBean id="SCL" class="org.aspcfs.modules.communications.base.SearchCriteriaList" scope="request"/>
<jsp:useBean id="ActionList" class="org.aspcfs.modules.actionlist.base.ActionList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript">
function saveCriteria() {
  saveValues();
  return true;
}
</SCRIPT>
<%
  String returnURL = "MyActionLists.do?command=List&linkModuleId=" + Constants.ACTIONLISTS_CONTACTS;
  if("details".equals(request.getParameter("return"))){
   returnURL = "MyActionContacts.do?command=List&actionId=" + ActionList.getId();
  }
%>
<form name="searchForm" method="post" action="MyActionContacts.do?command=Save&actionId=<%= ActionList.getId() %>" onSubmit="return saveCriteria();">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="MyCFS.do?command=Home">My Home Page</a> >
<a href="MyActionLists.do?command=List&linkModuleId=<%= Constants.ACTIONLISTS_CONTACTS %>">Action Lists</a> >
<a href="MyActionContacts.do?command=List&actionId=<%= request.getParameter("actionId") %>">List Details</a> >
Add Contacts
</td>
</tr>
</table>
<%-- End Trails --%>
<input type="submit" value="Save">
<input type="button" value="Cancel" onClick="javascript:window.location.href='<%= returnURL %>'">
<input type="button" value="Preview" onClick="javascript:popPreview()">
<br>
<%-- include jsp for contact criteria --%>
<%@ include file="../communications/group_criteria_include.jsp" %>
<br>
<input type="hidden" name="actionId" value="<%= ActionList.getId() %>">
<input type="submit" value="Save">
<input type="button" value="Cancel" onClick="javascript:window.location.href='<%= returnURL %>'">
<input type="button" value="Preview" onClick="javascript:popPreview()">
</form>
