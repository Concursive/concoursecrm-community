<%@ page import="java.util.*" %>
<html>
<script>
<% int level = Integer.parseInt(request.getParameter("level"));
  if(level > 0){
%>
  parent.opener.window.opener.loadCategories('<%= (level - 1)  %>');
 <% }else{ %>
  parent.opener.window.opener.loadTopCategories();
 <% } %>
  parent.window.close();parent.opener.window.close();
</script>
</html>
