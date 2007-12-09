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
<%@ page import="java.util.*,org.aspcfs.modules.help.base.*" %>
<jsp:useBean id="helpModule" class="org.aspcfs.modules.help.base.HelpModule" scope="request"/>
<link rel="stylesheet" href="css/template-help.css" type="text/css">
<html>
<body>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/images.js"></SCRIPT>
<%@ include file="../initPage.jsp" %>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <%-- Introduction --%>
  <tr>
    <td>
      <table cellpadding="4" cellspacing="0" width="100%" class="empty">
<dhv:evaluate if="<%= hasText(helpModule.getModuleName()) %>">
      <tr>
       <td><h2><%= toHtml(helpModule.getModuleName())%></h2></td>
      </tr>
</dhv:evaluate>
      <tr>
       <td><h3><dhv:label name="help.briefDescription">Brief Description</dhv:label></h3></td>
      </tr>
       <tr>
         <td>
          <% if(!"".equals(toString(helpModule.getBriefDescription()))) {%>
            <%= toHtml(helpModule.getBriefDescription()) %>
          <%} else {%>
            <dhv:label name="help.noDescriptionAvailable">No Description available</dhv:label>
          <%}%>
        </td>
       </tr>
     </table><br>
    </td>
  </tr>
  <tr>
    <td>
     <table cellpadding="4" cellspacing="0" width="100%" class="empty">
     <tr>
       <td><h3><dhv:label name="help.moduleDetailDescription">Module Detail Description</dhv:label></h3></td>
      </tr>
       <tr>
         <td>
          <% if(!"".equals(toString(helpModule.getDetailDescription()))) {%>
            <%= toHtml(helpModule.getDetailDescription()) %>
          <%} else {%>
            <dhv:label name="help.noDescriptionAvailable">No Description available</dhv:label>
          <%}%>
        </td>
       </tr>
     </table>
    </td>
 </tr>
</table>
</body>
</html>

