<jsp:useBean id="Dialog" class="com.darkhorseventures.webutils.HtmlDialog" scope="session"/>
<jsp:useBean id="User" class="com.darkhorseventures.cfsbase.UserBean" scope="session"/>
<%@ include file="initPage.jsp" %>

<%if(Dialog.getShowAndConfirm()){
  if(Dialog.getText().equals("")){
%>
  <html>
   <title><%=Dialog.getTitle()%></title>
    <frameset rows="29%,42%,29%" frameborder="0">
    
        <% if ("true".equals((String)getServletConfig().getServletContext().getAttribute("ForceSSL"))) { %>
          <frame name="topframe" src="https://<%= request.getServerName() %>/loadframes.jsp">
          
          <frame marginheight="0" name="middleframe" src="https://<%= request.getServerName() %>/loadmiddleframe.jsp">
          <frame name="bottomframe" src="https://<%= request.getServerName() %>/loadbottomframe.jsp">          
        <%} else {%>
          <frame name="topframe" src="loadframes.jsp">
          
          <frame marginheight="0" name="middleframe" src="loadmiddleframe.jsp">
          <frame name="bottomframe" src="loadbottomframe.jsp">
        <%}%>
    </frameset>
  </html>
<%}
else{%>
  <%=toHtml(Dialog.getText())%>
<%}
}else{%>
<html>
        <link rel="stylesheet" href="css/template0<%= User.getBrowserIdAndOS() %>.css" type="text/css">
        <link rel="stylesheet" href="css/template0.css" type="text/css">
  <title><%=Dialog.getTitle()%></title>
  <body>
    <br>
    <table cellpadding="4" cellspacing="0" border="0" width="95%" bordercolorlight="#000000" bordercolor="#FFFFFF">
      <tr valign="center">
      <td>
       Are you sure you wish to permanently delete this object from CFS?
      </td>
      </tr>
      
      <tr><td>&nbsp;</td></tr>
      <tr><td>&nbsp;</td></tr>
      <tr><td>&nbsp;</td></tr>
      <tr><td>&nbsp;</td></tr>
      
      <tr align="center">
      <td>
        <input type="button" value="Yes" onClick="<%=toHtml(Dialog.getDeleteUrl())%>">
        <input type="button" value="Cancel" onClick="javascript:window.close();">
        </td>
      </tr>
     </table>
 </body>
</html>
<%}%>
