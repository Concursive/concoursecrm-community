<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="ImportDetails" class="org.aspcfs.modules.base.Import" scope="request"/>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.contacts.base.*" %>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></script>
<script language="JavaScript">
  function confirmDeleteContact() {
    url = 'AccountContactsImports.do?command=DeleteContact&contactId=<%= ContactDetails.getId() %>&importId=<%= ImportDetails.getId() %>';
    confirmDelete(url);
  }
</script>
<table class="trails">
<tr>
  <td>
    <a href="Accounts.do">Accounts</a> >
    <a href="AccountContactsImports.do?command=View">View Imports</a> >
    <a href="AccountContactsImports.do?command=Details&importId=<%= ImportDetails.getId() %>">Import Details</a> >
    <a href="AccountContactsImports.do?command=ViewResults&importId=<%= ImportDetails.getId() %>">View Results</a> >
    Contact Details
  </td>
</tr>
</table>
<%-- End Trails --%>
<%@ include file="../accounts/accounts_importcontact_details_include.jsp" %>
<dhv:evaluate if="<%= request.getParameter("actionError") != null %>">
<font color="red">*toHtml((String) request.getParameter("actionError"))</font>
</dhv:evaluate>
<dhv:permission name="accounts-accounts-contacts-imports-edit">
<dhv:evaluate if="<%= !ContactDetails.isApproved()  %>">
<br><input type="button" value="Delete" onClick="javascript:confirmDeleteContact();"><br><br>
</dhv:evaluate>
</dhv:permission>
<table cellpadding="4" cellspacing="0" border="1" width="100%">
  <tr>
    <td class="containerBack">
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
	    <strong>Email Addresses</strong>
	  </th>
  </tr>
<%
  Iterator iemail = ContactDetails.getEmailAddressList().iterator();
  if (iemail.hasNext()) {
    while (iemail.hasNext()) {
      ContactEmailAddress thisEmailAddress = (ContactEmailAddress)iemail.next();
%>
    <tr class="containerBody">
      <td class="formLabel" nowrap>
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
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
	    <strong>Phone Numbers</strong>
	  </th>
  </tr>
<%  
  Iterator inumber = ContactDetails.getPhoneNumberList().iterator();
  if (inumber.hasNext()) {
    while (inumber.hasNext()) {
      ContactPhoneNumber thisPhoneNumber = (ContactPhoneNumber)inumber.next();
%>
    <tr class="containerBody">
      <td class="formLabel" nowrap>
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
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
	    <strong>Addresses</strong>
	  </th>
  </tr>
<%
  Iterator iaddress = ContactDetails.getAddressList().iterator();
  if (iaddress.hasNext()) {
    while (iaddress.hasNext()) {
      ContactAddress thisAddress = (ContactAddress)iaddress.next();
%>    
    <tr class="containerBody">
      <td class="formLabel" valign="top" nowrap>
        <%= toHtml(thisAddress.getTypeName()) %>
      </td>
      <td>
        <%= toHtml(thisAddress.toString()) %>&nbsp;
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
&nbsp;
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
	    <strong>Additional Details</strong>
	  </th>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap>Notes</td>
    <td><%= toHtml(ContactDetails.getNotes()) %></td>
  </tr>
</table>
&nbsp;
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong>Record Information</strong>
    </th>
  </tr>
  <tr class="containerBody">
    <td class="formLabel">
      Owner
    </td>
    <td>
      <dhv:username id="<%= ContactDetails.getOwner() %>"/>
      <dhv:evaluate exp="<%=!(ContactDetails.getHasEnabledOwnerAccount())%>"><font color="red">(No longer has access)</font></dhv:evaluate>
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Entered
    </td>
    <td>
      <dhv:username id="<%= ContactDetails.getEnteredBy() %>"/>
      -
      <dhv:tz timestamp="<%= ContactDetails.getEntered()  %>" dateFormat="<%= DateFormat.SHORT %>" timeFormat="<%= DateFormat.LONG %>"/>
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Modified
    </td>
    <td>
      <dhv:username id="<%= ContactDetails.getModifiedBy() %>"/>
      -
      <dhv:tz timestamp="<%= ContactDetails.getModified()  %>" dateFormat="<%= DateFormat.SHORT %>" timeFormat="<%= DateFormat.LONG %>"/>
    </td>
   </tr>
  </table>
 </td>
</tr>
</table><br>
<dhv:permission name="accounts-accounts-contacts-imports-edit">
<dhv:evaluate if="<%= !ContactDetails.isApproved()  %>">
<input type="button" value="Delete" onClick="javascript:confirmDeleteContact();">
</dhv:evaluate>
</dhv:permission>

