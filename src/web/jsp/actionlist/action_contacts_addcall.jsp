<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.contacts.base.*" %>
<jsp:useBean id="CallDetails" class="org.aspcfs.modules.contacts.base.Call" scope="request"/>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<%@ include file="../initPage.jsp" %>
<body onLoad="javascript:document.forms[0].subject.focus();">
<br>
<% if(ContactDetails.getOrgId() == -1){ %>
<form name="addCall" action="ExternalContactsCalls.do?command=Insert&auto-populate=true&actionSource=MyActionContacts" onSubmit="return doCheck(this);" method="post">
<% }else{ %>
<form name="addCall" action="AccountContactsCalls.do?command=Insert&auto-populate=true&actionSource=MyActionContacts" onSubmit="return doCheck(this);" method="post">
<% } %>

<%= showError(request, "actionError") %>

<%@ include file="../contacts/call_form.jsp" %>

&nbsp;
<br>
<input type="submit" value="Save" onClick="this.form.dosubmit.value='true';">
<input type="button" value="Cancel" onClick="javascript:window.close();">
<input type="reset" value="Reset">
<input type="hidden" name="dosubmit" value="true">
<input type="hidden" name="contactId" value="<%= ContactDetails.getId() %>">
</form>
</body>
