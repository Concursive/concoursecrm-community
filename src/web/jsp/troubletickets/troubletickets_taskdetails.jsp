<%-- 
  - Copyright(c) 2004 Concursive Corporation (http://www.concursive.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Concursive Corporation. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. CONCURSIVE
  - CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL CONCURSIVE CORPORATION OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*, org.aspcfs.modules.base.Constants"%>
<jsp:useBean id="Task" class="org.aspcfs.modules.tasks.base.Task" scope="request"/>
<jsp:useBean id="forward" class="java.lang.String" scope="request" />
<%@ include file="../initPage.jsp" %>
<SCRIPT language="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></script>
<dhv:formMessage showSpace="false"/>
<%@ include file="../tasks/task_details_include.jsp" %>
<br>
<% if (hasAuthority(pageContext, String.valueOf(Task.getOwner()))) { %>
 <input type="button" value="<dhv:label name="global.button.modify">Modify</dhv:label>" onClick="javascript:window.location.href='TroubleTicketTasks.do?command=Modify&id=<%= Task.getId() %>&forward=details<%= isPopup(request)?"&popup=true":"" %>';"> 
 <input type="button" value="<dhv:label name="global.button.delete">Delete</dhv:label>" onClick="javascript:popURLReturn('TroubleTicketTasks.do?command=ConfirmDelete&id=<%= Task.getId() %>&popup=true&sourcePopup=true','MyTasks.do?command=ListTasks', 'Delete_task','320','200','yes','no');"> 
<% } %>
<input type="button" value="<dhv:label name="button.close">Close</dhv:label>" onClick="javascript:window.close();">
<script type="text/javascript">
if ('<%= forward != null && !"".equals(forward.trim()) %>' == 'true') {
  try {
    opener.reopen();
  } catch (oException) {
  }
}
</script>

