<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.help.base.*" %>
<jsp:useBean id="helpModule" class="org.aspcfs.modules.help.base.HelpModule" scope="request"/>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/images.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<%@ include file="../initPage.jsp" %>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <%-- Title --%>
  <tr>
  <td> <strong>Module Name:<%=helpModule.getModuleName()%></strong><dhv:permission name="qa-edit">[<a href="javascript:popURL('Help.do?command=ModifyDescription&id=<%= helpModule.getId() %>&action=<%= helpModule.getRelatedAction()%>&popup=true', 'Help_Description','700','500','yes','yes');">Edit</a>]</td></dhv:permission>
  </tr>
  <tr>
    <td>
      <table cellpadding="4" cellspacing="0" width="100%" class="details">
      <tr>
       <th>
          <strong>Brief Description</strong> 
       </th>
      </tr>
       <tr>
         <td>
          <%=toHtml(helpModule.getBriefDescription())%>
        </td>
       </tr>
     </table><br>
    </td>
  </tr>
  <tr>
    <td>
      <table cellpadding="4" cellspacing="0" width="100%" class="details">
      <tr>
       <th>
          <strong>Detail Description</strong>
       </th>
      </tr>
       <tr>
         <td>
          <%=toHtml(helpModule.getDetailDescription())%>
        </td>
       </tr>
     </table><br>
    </td>
  </tr>
  </table>
