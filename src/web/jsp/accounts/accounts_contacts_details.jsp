<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*" %>
<jsp:useBean id="OrgDetails" class="com.darkhorseventures.cfsbase.Organization" scope="request"/>
<jsp:useBean id="ContactDetails" class="com.darkhorseventures.cfsbase.Contact" scope="request"/>
<%@ include file="initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="/javascript/confirmDelete.js"></script>
<form name="modContact" action="/Contacts.do?command=Modify&id=<%=ContactDetails.getId()%>&orgId=<%=ContactDetails.getOrgId()%>" method="post">
<a href="/Contacts.do?command=View&orgId=<%= OrgDetails.getOrgId() %>">Back to Contact List</a><br>&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
      <strong><%= toHtml(OrgDetails.getName()) %></strong>
    </td>
  </tr>
  <tr class="containerMenu">
    <td>
      <% String param1 = "orgId=" + OrgDetails.getOrgId(); %>      
      <dhv:container name="accounts" selected="contacts" param="<%= param1 %>" />
    </td>
  </tr>
  <tr>
    <td class="containerBack">
<dhv:permission name="accounts-accounts-contacts-edit"><input type='submit' value="Modify"	name="Modify"></dhv:permission>
<dhv:permission name="accounts-accounts-contacts-delete"><input type='submit' value="Delete" onClick="javascript:this.form.action='/Contacts.do?command=Delete&id=<%=ContactDetails.getId()%>&orgId=<%=ContactDetails.getOrgId()%>'"></dhv:permission>
<dhv:permission name="accounts-accounts-contacts-edit,accounts-accounts-contacts-delete"><br>&nbsp;</dhv:permission>

<input type=hidden name="typeId" value="<%=ContactDetails.getTypeId()%>">

<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan=2 valign=center align=left>
      <strong><%= toHtml(ContactDetails.getNameFull()) %></strong>
    </td>     
  </tr>
  <tr class="containerBody">
    <td class="formLabel">
      Title
    </td>
    <td>
      <%= toHtml(ContactDetails.getTitle()) %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Entered
    </td>
    <td>
      <%= ContactDetails.getEnteredByName() %>&nbsp;-&nbsp;<%= ContactDetails.getEnteredString() %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Modified
    </td>
    <td>
      <%= ContactDetails.getModifiedByName() %>&nbsp;-&nbsp;<%= ContactDetails.getModifiedString() %>
    </td>
  </tr>
</table>
&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan=2 valign=center align=left>
	    <strong>Email Addresses</strong>
	  </td>
  </tr>
<%  
  Iterator iemail = ContactDetails.getEmailAddressList().iterator();
  if (iemail.hasNext()) {
    while (iemail.hasNext()) {
      ContactEmailAddress thisEmailAddress = (ContactEmailAddress)iemail.next();
%>    
  <tr class="containerBody">
    <td class="formLabel">
      <%= toHtml(thisEmailAddress.getTypeName()) %>
    </td>
    <td>
      <a href="mailto:<%= toHtml(thisEmailAddress.getEmail()) %>"><%= toHtml(thisEmailAddress.getEmail()) %></a>
    </td>
  </tr>
<%    
    }
  } else {
%>
  <tr class="containerBody">
    <td>
      <font color="#9E9E9E">No email addresses entered.</font>
    </td>
  </tr>
<%}%>
</table>
&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan=2 valign=center align=left>
	    <strong>Phone Numbers</strong>
	  </td>
  </tr>
<%  
  Iterator inumber = ContactDetails.getPhoneNumberList().iterator();
  if (inumber.hasNext()) {
    while (inumber.hasNext()) {
      ContactPhoneNumber thisPhoneNumber = (ContactPhoneNumber)inumber.next();
%>    
  <tr class="containerBody">
    <td class="formLabel">
      <%= toHtml(thisPhoneNumber.getTypeName()) %>
    </td>
    <td>
      <%= toHtml(thisPhoneNumber.getPhoneNumber()) %>
    </td>
  </tr>
<%    
    }
  } else {
%>
  <tr class="containerBody">
    <td>
      <font color="#9E9E9E">No phone numbers entered.</font>
    </td>
  </tr>
<%}%>
</table>
&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan=2 valign=center align=left>
	    <strong>Addresses</strong>
	  </td>
  </tr>
<%  
  Iterator iaddress = ContactDetails.getAddressList().iterator();
  if (iaddress.hasNext()) {
    while (iaddress.hasNext()) {
      ContactAddress thisAddress = (ContactAddress)iaddress.next();
%>    
  <tr class="containerBody">
    <td class="formLabel">
      <%= toHtml(thisAddress.getTypeName()) %>
    </td>
    <td>
      <%= toHtml(thisAddress.toString()) %>
    </td>
  </tr>
<%    
    }
  } else {
%>
  <tr class="containerBody">
    <td>
      <font color="#9E9E9E">No addresses entered.</font>
    </td>
  </tr>
<%}%>
</table>
<dhv:permission name="accounts-accounts-contacts-edit,accounts-accounts-contacts-delete"><br></dhv:permission>
<dhv:permission name="accounts-accounts-contacts-edit"><input type='submit' value="Modify"	name="Modify"></dhv:permission>
<dhv:permission name="accounts-accounts-contacts-delete"><input type='submit' value="Delete" onClick="javascript:this.form.action='/Contacts.do?command=Delete&id=<%=ContactDetails.getId()%>&orgId=<%=ContactDetails.getOrgId()%>'"></dhv:permission>
 </td>
  </tr>
</table>
</form>
