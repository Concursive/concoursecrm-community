<%-- 
  - Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. DARK HORSE
  - VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.contacts.base.*,org.aspcfs.utils.web.*" %>
<jsp:useBean id="ContactTypeList" class="org.aspcfs.modules.contacts.base.ContactTypeList" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkPhone.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkEmail.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popAccounts.js"></script>
<script language="JavaScript">
  function doCheck(form) {
    if (form.dosubmit.value == "false") {
      return true;
    } else {
      return(checkForm(form));
    }
  }
  function checkForm(form) {
    formTest = true;
    message = "";
    if ((!checkPhone(form.phone1number.value)) || (!checkPhone(form.phone2number.value)) || (!checkPhone(form.phone3number.value)) ) { 
      message += "- At least one entered phone number is invalid.  Make sure there are no invalid characters and that you have entered the area code\r\n";
      formTest = false;
    }
    if ((!checkEmail(form.email1address.value)) || (!checkEmail(form.email2address.value))){
      message += "- At least one entered email address is invalid.  Make sure there are no invalid characters\r\n";
      formTest = false;
    }
    if (formTest == false) {
      alert("Form could not be saved, please check the following:\r\n\r\n" + message);
      return false;
    } else {
      var test = document.addContact.selectedList;
      if (test != null) {
        return selectAllOptions(document.addContact.selectedList);
      }
    }
  }
  function update(countryObj, stateObj) {
  var country = document.forms['addContact'].elements[countryObj].value;
   if(country == "UNITED STATES" || country == "CANADA"){
      hideSpan('state2' + stateObj);
      showSpan('state1' + stateObj);
   }else{
      hideSpan('state1' + stateObj);
      showSpan('state2' + stateObj);
    }
  }
  
  function setCategoryPopContactType(selectedId, contactId){
    var category = 'general';
    if(document.addContact.contactcategory[1].checked){
      category = 'accounts';
    }
    popContactTypeSelectMultiple(selectedId, category, contactId); 
  }
</script>
<body onLoad="javascript:document.forms[0].nameFirst.focus();">
<%
  boolean popUp = false;
  if(request.getParameter("popup")!=null){
    popUp = true;
  }
%> 
  <form name="addContact" action="Contacts.do?command=Save&auto-populate=true<%= (request.getParameter("popup") != null?"&popup=true":"") %>" method="post">
  <dhv:evaluate exp="<%= !popUp %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td width="100%">
  <a href="Accounts.do"><dhv:label name="accounts.accounts">Accounts</dhv:label></a> > 
  <a href="Accounts.do?command=Search">Search Results</a> >
  <a href="Accounts.do?command=Details&orgId=<%= OrgDetails.getOrgId() %>"><dhv:label name="accounts.details">Account Details</dhv:label></a> >
  <a href="Contacts.do?command=View&orgId=<%= OrgDetails.getOrgId() %>">Contacts</a> >
  Add Contact
</td>
</tr>
</table>
<%-- End Trails --%>
  </dhv:evaluate>
  <%@ include file="accounts_details_header_include.jsp" %>
  <dhv:evaluate exp="<%= !popUp %>">
    <dhv:container name="accounts" selected="contacts" param="<%= "orgId=" + OrgDetails.getOrgId() %>" style="tabs"/>
  </dhv:evaluate>
  <table cellpadding="4" cellspacing="0" border="0" width="100%">
    <tr>
      <td class="containerBack">
  <input type="hidden" name="orgId" value="<%= OrgDetails.getOrgId() %>">
  <input type="submit" value="Save" onClick="return checkForm(this.form)">
  <dhv:evaluate exp="<%= !popUp %>">
  <input type="submit" value="Save & Clone" onClick="this.form.saveAndClone.value='true';return checkForm(this.form);">
  </dhv:evaluate>
  <input type="button" value="Cancel" onClick="javascript:<%= popUp ? "window.close();" : "window.location.href='Contacts.do?command=View&orgId=" + OrgDetails.getOrgId() + "'" %>">
<br />
<dhv:formMessage />
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong>Add a New Contact</strong>
    </th>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel" valign="top">
      Contact Type(s)
    </td>
    <td>
      <table border="0" cellspacing="0" cellpadding="0" class="empty">
        <tr>
          <td>
            <select multiple name="selectedList" id="selectedList" size="5">
               <dhv:lookupHtml listName="TypeList" lookupName="ContactTypeList"/>
            </select>
            <input type="hidden" name="previousSelection" value="">
            <input type="hidden" name="category" value="<%= request.getParameter("category") %>">
          </td>
          <td valign="top">
              &nbsp;[<a href="javascript:popContactTypeSelectMultiple('selectedList', 'accounts', <%= ContactDetails.getId() %>);">Select</a>]
          </td>
        </tr>
      </table>
     </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      First Name
    </td>
    <td>
      <input type="text" size="35" name="nameFirst" value="<%= toHtmlValue(ContactDetails.getNameFirst()) %>">
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
    Middle Name
    </td>
    <td>
      <input type="text" size="35" name="nameMiddle" value="<%= toHtmlValue(ContactDetails.getNameMiddle()) %>">
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Last Name
    </td>
    <td>
      <input type="text" size="35" name="nameLast" value="<%= toHtmlValue(ContactDetails.getNameLast()) %>">
      <font color="red">*</font> <%= showAttribute(request, "nameLastError") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Title
    </td>
    <td>
      <input type="text" size="35" name="title" value="<%= toHtmlValue(ContactDetails.getTitle()) %>">
    </td>
  </tr>
</table>
&nbsp;<br />  
<%--  include basic contact form --%>
<%@ include file="../contacts/contact_include.jsp" %>
<dhv:permission name="portal-user-add">
  <dhv:evaluate if="<%= !popUp %>">
    <table>
     <tr>
        <td valign="top" >
          <strong>Provide portal access?</strong>
        </td>
        <td>
        <input type="checkbox" name="providePortalAccess" value="true" />
        </td>
     </tr>
    </table>
  </dhv:evaluate>
</dhv:permission>
<br>
<input type="submit" value="Save" onClick="return checkForm(this.form)">
  <dhv:evaluate exp="<%= !popUp %>">
  <input type="submit" value="Save & Clone" onClick="this.form.saveAndClone.value='true';return checkForm(this.form);">
  </dhv:evaluate>
  <input type="button" value="Cancel" onClick="javascript:<%= popUp ? "window.close();" : "window.location.href='Contacts.do?command=View&orgId=" + OrgDetails.getOrgId() + "'" %>">
  </td>
  </tr>
</table>
<input type="hidden" name="orgName" value="<%= OrgDetails.getName() %>">
</form>
</body>
