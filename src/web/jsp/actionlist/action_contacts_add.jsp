<%-- 
  - Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. DARK HORSE
  - VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
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
