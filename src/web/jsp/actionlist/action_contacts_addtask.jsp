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
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*"%>
<jsp:useBean id="Task" class="org.aspcfs.modules.tasks.base.Task" scope="request"/>
<%@ include file="../initPage.jsp" %>
<body onLoad="javascript:document.addTask.description.focus();">
<form name="addTask" action="MyTasks.do?command=<%= Task.getId()!=-1?"Update":"Insert" %>&id=<%= Task.getId() %>&auto-populate=true<%= (request.getParameter("popup") != null?"&popup=true":"") %>&actionSource=MyActionContacts" method="post" onSubmit="return validateTask();">
<% boolean popUp = request.getParameter("popup") != null; %>
<dhv:formMessage showSpace="false" />
<iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>
<%@ include file="../tasks/task_include.jsp" %>
<br />
<% if(Task.getId()==-1) {%>
  <input type="submit" value="<dhv:label name="button.save">Save</dhv:label>" />
<%} else {%>
  <input type="submit" value="<dhv:label name="button.update">Update</dhv:label>" />
<%}%>
<input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:window.close();" />
<br />
<input type="hidden" name="contactId" value="<%= request.getParameter("contactId") %>" />
</form>
</body>

