<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.contacts.base.*" %>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<form name="details" action="CompanyDirectory.do?command=ModifyEmployee&empid=<%= ContactDetails.getId() %>" method="post">
<a href="MyCFS.do?command=Home">My Home Page</a> >
<a href="CompanyDirectory.do?command=ListEmployees">View Employees</a> >
Employee Details<br>
<hr color="#BFBFBB" noshade>
<dhv:permission name="contacts-internal_contacts-edit"><input type="button" value="Modify" onClick="javascript:this.form.action='CompanyDirectory.do?command=ModifyEmployee&empid=<%= ContactDetails.getId() %>';submit();"></dhv:permission>
<dhv:permission name="contacts-internal_contacts-delete"><input type="button" value="Delete" onClick="javascript:this.form.action='CompanyDirectory.do?command=DeleteEmployee&empid=<%=ContactDetails.getId() %>';confirmSubmit(document.details);"></dhv:permission>
<dhv:permission name="contacts-internal_contacts-edit,contacts-internal_contacts-delete"><br>&nbsp;</dhv:permission>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan="2">
	    <strong><%= toHtml(ContactDetails.getNameFull()) %></strong>
      <dhv:evaluate exp="<%=!(ContactDetails.hasEnabledAccount())%>"><font color="red">*</font></dhv:evaluate>          
	  </td>
  </tr>
  <tr>
    <td class="formLabel" nowrap>Department</td>
    <td><%= toHtml(ContactDetails.getDepartmentName()) %>&nbsp;</td>
  </tr>
  <tr>
    <td class="formLabel" nowrap>Title</td>
    <td><%= toHtml(ContactDetails.getTitle()) %>&nbsp;</td>
  </tr>
</table>
&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan="2">
	    <strong>Email Addresses</strong>
	  </td>
  </tr>
<%  
  Iterator iemail = ContactDetails.getEmailAddressList().iterator();
  if (iemail.hasNext()) {
    while (iemail.hasNext()) {
      ContactEmailAddress thisEmailAddress = (ContactEmailAddress)iemail.next();
%>    
  <tr>
    <td nowrap class="formLabel"><%= toHtml(thisEmailAddress.getTypeName()) %></td>
    <td><a href="mailto:<%= toHtml(thisEmailAddress.getEmail()) %>"><%= toHtml(thisEmailAddress.getEmail()) %></a></td>
  </tr>
<%    
    }
  } else {
%>
  <tr>
    <td colspan="2"><font color="#9E9E9E">No email addresses entered.</font></td>
  </tr>
<%}%>
</table>
&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan="2">
	    <strong>Phone Numbers</strong>
	  </td>
  </tr>
<%  
  Iterator inumber = ContactDetails.getPhoneNumberList().iterator();
  if (inumber.hasNext()) {
    while (inumber.hasNext()) {
      ContactPhoneNumber thisPhoneNumber = (ContactPhoneNumber)inumber.next();
%>    
  <tr>
    <td class="formLabel" nowrap><%= toHtml(thisPhoneNumber.getTypeName()) %></td>
    <td><%= toHtml(thisPhoneNumber.getPhoneNumber()) %>&nbsp;</td>
  </tr>
<%
    }
  } else {
%>
  <tr>
    <td colspan="2"><font color="#9E9E9E">No phone numbers entered.</font></td>
  </tr>
<%}%>
</table>
&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan="2">
	    <strong>Addresses</strong>
	  </td>
  </tr>
<%  
  Iterator iaddress = ContactDetails.getAddressList().iterator();
  if (iaddress.hasNext()) {
    while (iaddress.hasNext()) {
      ContactAddress thisAddress = (ContactAddress)iaddress.next();
%>    
    <tr>
      <td class="formLabel" valign="top" nowrap><%= toHtml(thisAddress.getTypeName()) %></td>
      <td><%= toHtml(thisAddress.toString()) %>&nbsp;</td>
    </tr>
<%    
    }
  } else {
%>
  <tr>
    <td colspan="2"><font color="#9E9E9E">No addresses entered.</font></td>
  </tr>
<%}%>
</table>
&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan="2">
	    <strong>Additional Details</strong>
	  </td>
  </tr>
  <tr>
    <td class="formLabel" nowrap>Notes</td>
    <td><%= toHtml(ContactDetails.getNotes()) %>&nbsp;</td>
  </tr>
</table>
<dhv:permission name="contacts-internal_contacts-edit,contacts-internal_contacts-delete"><br></dhv:permission>
<dhv:permission name="contacts-internal_contacts-edit"><input type="button" value="Modify" onClick="javascript:this.form.action='CompanyDirectory.do?command=ModifyEmployee&empid=<%= ContactDetails.getId() %>';submit();"></dhv:permission>
<dhv:permission name="contacts-internal_contacts-delete"><input type="button" value="Delete" onClick="javascript:this.form.action='CompanyDirectory.do?command=DeleteEmployee&empid=<%=ContactDetails.getId() %>';confirmSubmit(document.details);"></dhv:permission>
</form>

