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
<%@ page import="org.aspcfs.utils.StringUtils" %>
<%@ page import="java.util.*"%>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="Message" class="org.aspcfs.modules.communications.base.Message" scope="request"/>
<jsp:useBean id="messageList" class="org.aspcfs.modules.communications.base.MessageList" scope="request"/>
<jsp:useBean id="clientType" class="org.aspcfs.utils.web.ClientType" scope="session"/>
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>
<%@ include file="../initPage.jsp" %>
<%-- Editor must go here, before the body onload --%>
<dhv:evaluate if="<%= !clientType.showApplet() %>">
<jsp:include page="../htmlarea_include.jsp" flush="true"/>
<body onload="initEditor('messageText');document.sendMessage.replyTo.focus();">
</dhv:evaluate>
<%-- Use applet instead --%>
<dhv:evaluate if="<%= clientType.showApplet() %>">
<body onload="document.sendMessage.replyTo.focus();">
</dhv:evaluate>
<script language="JavaScript">
  function updateMessageList() {
    document.forms['sendMessage'].elements['messageId'].selectedIndex = 0;
    messageType = "<%=request.getAttribute("messageType")%>";
    if (messageType == "addressRequest"){
      document.forms['sendMessage'].action = 'MyActionContacts.do?command=PrepareMessage&actionSource=MyActionContacts&messageType=addressRequest&orgId=<%=request.getAttribute("orgId")%><%= addLinkParams(request, "popup|popupType|contactId|actionId|actionListId")%>';
    }else{
      document.forms['sendMessage'].action = 'MyActionContacts.do?command=PrepareMessage&actionSource=MyActionContacts<%= addLinkParams(request, "popup|popupType|contactId|actionId|actionListId")%>';
    }
    document.forms['sendMessage'].submit();
  }
  function updateMessage(){
    messageType = "<%=request.getAttribute("messageType")%>";
    if (messageType == "addressRequest"){
      document.forms['sendMessage'].action = 'MyActionContacts.do?command=PrepareMessage&actionSource=MyActionContacts&messageType=addressRequest&orgId=<%=request.getAttribute("orgId")%><%= addLinkParams(request, "popup|popupType|contactId|actionId|actionListId") %>';
    }else{
      document.forms['sendMessage'].action = 'MyActionContacts.do?command=PrepareMessage&actionSource=MyActionContacts<%= addLinkParams(request, "popup|popupType|contactId|actionId|actionListId") %>';
    }
    document.forms['sendMessage'].submit();
  }
  function checkForm(form) {
    var formTest = true;
    var messageText = "";
<dhv:evaluate if="<%= clientType.showApplet() %>">
    document.sendMessage.messageText.value = document.Kafenio.getDocumentBody();
</dhv:evaluate>
    return true;
  }
</script>
<% if ("addressRequest".equals(request.getAttribute("messageType"))){%>
  <form name="sendMessage" action="MyActionContacts.do?command=SendAddressRequest&auto-populate=true&actionSource=MyActionContacts&orgId=<%=request.getAttribute("orgId")%>" method="post" onSubmit="return checkForm(this);">
<%}else{%>
  <form name="sendMessage" action="MyActionContacts.do?command=SendMessage&auto-populate=true&actionSource=MyActionContacts" method="post" onSubmit="return checkForm(this);">
<%}%>
<dhv:formMessage showSpace="false"/>
<dhv:label name="actionList.chooseCreateMessage.text">Start by choosing an existing message or create a new one:</dhv:label><br />
<SELECT SIZE="1" name="listView" onChange="javascript:updateMessageList();">
  <OPTION VALUE="my"<dhv:evaluate if="<%= "my".equals((String) request.getParameter("listView")) %>"> selected</dhv:evaluate>><dhv:label name="accounts.accounts_contacts_messages_view.MyMessages">My Messages</dhv:label></OPTION>
  <OPTION VALUE="all"<dhv:evaluate if="<%= "all".equals((String) request.getParameter("listView")) %>"> selected</dhv:evaluate>><dhv:label name="accounts.accounts_contacts_messages_view.AllMessages">All Messages</dhv:label></OPTION>
  <OPTION VALUE="hierarchy"<dhv:evaluate if="<%= "hierarchy".equals((String) request.getParameter("listView")) %>"> selected</dhv:evaluate>><dhv:label name="actionList.controlledHierarchyMessages">Controlled Hierarchy Messages</dhv:label></OPTION>
  <OPTION VALUE="personal"<dhv:evaluate if="<%= "personal".equals((String) request.getParameter("listView")) %>"> selected</dhv:evaluate>><dhv:label name="actionList.personalMessages">Personal Messages</dhv:label></OPTION>
  <OPTION VALUE="new"<dhv:evaluate if="<%= "new".equals((String) request.getParameter("listView")) %>"> selected</dhv:evaluate>><dhv:label name="actionList.newMessage">New Message</dhv:label></OPTION>
</SELECT>
<%if(!"new".equals(request.getParameter("listView"))){ %>
<% 
   messageList.setJsEvent("onChange=\"javascript:updateMessage();\""); 
   messageList.addItem(0, "--None--");
%>
<%= messageList.getHtmlSelect("messageId", (request.getParameter("messageId") != null ? Integer.parseInt(request.getParameter("messageId")) : -1)) %>
<% }else{ %>
  <select size="1" name="messageId">
    <option value="0"><dhv:label name="calendar.none.4dashes">--None--</dhv:label></option>
  </select>  
<% } %>
<%-- include the message form from create messages --%>
<%@ include file="../communications/message_include.jsp" %>
<br />
<% if ("addressRequest".equals(request.getAttribute("messageType"))){%>
  Note: The recipient's contact information will be attached with the chosen message.
<%}%>
<br />
<input type="submit" value="<dhv:label name="button.sendMessage">Send Message</dhv:label>" />
<input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:window.close();" />
<br />
<input type="hidden" name="contactId" value="<%= request.getParameter("contactId") %>" />
</form>
<iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>
</body>

