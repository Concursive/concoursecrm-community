<%@page import="java.io.*"%>
<font color='red'>An Error Has Occurred</font>
<hr color="#BFBFBB" noshade>
The system administrator has been notified.<p>
You may be able to hit the back button on your browser, review your selection, and try your request again.<p>
<pre>
<%
  Object errorObject = request.getAttribute("Error");
  
  String errorMessage = "";
  
  if (errorObject instanceof java.lang.String) {
    errorMessage = (String)errorObject;
  } else if (errorObject instanceof java.lang.Exception) {
    Exception e = (Exception)errorObject;
    ByteArrayOutputStream outStream = new ByteArrayOutputStream();
    e.printStackTrace(new PrintStream(outStream));
    errorMessage = outStream.toString();
  }
  if (!errorMessage.equals("")) {
%>
The actual error is:<br><br><%= errorMessage %>
<%
  } else {
%>
An error message was not provided by this action.
<%
  }
%>
</pre>
