<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*,com.darkhorseventures.autoguide.base.*" %>
<jsp:useBean id="UserList" class="com.darkhorseventures.cfsbase.UserList" scope="request"/>
<html>
<head>
</head>
<body onload='page_init();'>
<script language='Javascript'>
function page_init() {
  var list = parent.document.forms['projectMemberForm'].elements['selTotalList'];
  list.options.length = 0;
  //list.options[list.length] = new Option("--None--", "-1");

<%
  Iterator i = UserList.iterator();
  while (i.hasNext()) {
    User thisUser = (User)i.next();
%>
  if ( !(inArray(parent.document.forms['projectMemberForm'].elements['selProjectList'], <%= thisUser.getId() %>)) ) {
  	list.options[list.length] = new Option("<%= thisUser.getContact().getNameFull() %>", "<%= thisUser.getId() %>");
  }
<%
  }
%>
}

function inArray(a, s) {
	var i = 0;
	
	for(i=0; i < a.length; i++) {
		//alert(s + ", " + a.options[i].value);
		if (a.options[i].value == s) {
			return true;
		}
	}
	
	return false;
}

</script>
</body>
</html>

