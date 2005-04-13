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
<form name="addTask" action="MyTasks.do?command=<%= Task.getId()!=-1?"Update":"Insert" %>&id=<%= Task.getId() %>&auto-populate=true<%= (request.getParameter("popup") != null?"&popup=true":"") %>" method="post" onSubmit="return validateTask();">
<%boolean popUp = false;
  if(request.getParameter("popup")!=null){
    popUp = true;
  }%>
<dhv:evaluate if="<%= !popUp %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="MyCFS.do?command=Home"><dhv:label name="actionList.myHomePage">My Home Page</dhv:label></a> > 
<a href="MyTasks.do?command=ListTasks"><dhv:label name="myitems.tasks">Tasks</dhv:label></a> >
<% if(Task.getId()==-1) {%>
  <dhv:label name="quickactions.addTask">Add a Task</dhv:label>
<%} else {%>
  <dhv:label name="tasks.updateATask">Update a Task</dhv:label>
<%}%>
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>
<% if(Task.getId()==-1) {%>
  <input type="submit" value="<dhv:label name="button.save">Save</dhv:label>">
<%} else {%>
  <input type="submit" value="<dhv:label name="button.update">Update</dhv:label>">
<%}%>
<input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="<%=popUp?"javascript:window.close();":"javascript:window.location.href='MyTasks.do?command=ListTasks';"%>"><br>
<dhv:formMessage />
<%@ include file="task_include.jsp" %>
<br>
<% if(Task.getId()==-1) {%>
  <input type="submit" value="<dhv:label name="button.save">Save</dhv:label>">
<%} else {%>
  <input type="submit" value="<dhv:label name="button.update">Update</dhv:label>">
<%}%>
<input type="hidden" name="return" value="<%= request.getParameter("return") %>">
<input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="<%=popUp?"javascript:window.close();":"javascript:window.location.href='MyTasks.do?command=ListTasks';"%>">
</form>
</body>

