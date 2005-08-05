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
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.contacts.base.*,org.aspcfs.utils.web.*" %>
<jsp:useBean id="ContactTypeList" class="org.aspcfs.modules.contacts.base.ContactTypeList" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkString.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkPhone.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkEmail.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popAccounts.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>
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
    if (checkNullString(form.nameLast.value)){
      message += label("check.lastname", "- Last name is a required field\r\n");
      formTest = false;
    }
    if ((!checkPhone(form.phone1number.value)) || (!checkPhone(form.phone2number.value)) || (!checkPhone(form.phone3number.value)) || (checkNullString(form.phone1number.value) && !checkNullString(form.phone1ext.value)) || (checkNullString(form.phone2number.value) && !checkNullString(form.phone2ext.value)) || (checkNullString(form.phone3number.value) && !checkNullString(form.phone3ext.value))) { 
      message += label("check.phone", "- At least one entered phone number is invalid.  Make sure there are no invalid characters and that you have entered the area code\r\n");
      formTest = false;
    }
    if ((checkNullString(form.phone1ext.value) && form.phone1ext.value != "") || (checkNullString(form.phone2ext.value) && form.phone2ext.value != "") || (checkNullString(form.phone3ext.value) && form.phone3ext.value != "")) {
      message += label("check.phone.ext","- Please enter a valid phone number extension\r\n");
      formTest = false;
    }
    if ((!checkEmail(form.email1address.value)) || (!checkEmail(form.email2address.value))){
      message += label("check.email", "- At least one entered email address is invalid.  Make sure there are no invalid characters\r\n");
      formTest = false;
    }
    if ((!checkEmail(form.textmessage1address.value)) || (!checkEmail(form.textmessage1address.value)) || (!checkEmail(form.textmessage1address.value))){
      message += label("check.textmessage", "- At least one entered text message address is invalid.  Make sure there are no invalid characters\r\n");
      formTest = false;
    }
    if (formTest == false) {
      alert(label("check.form", "Form could not be saved, please check the following:\r\n\r\n") + message);
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
<body onLoad="javascript:document.addContact.nameFirst.focus();">
<%
  boolean popUp = false;
  if(request.getParameter("popup")!=null){
    popUp = true;
  }
%> 
  <form name="addContact" action="Contacts.do?command=Save&auto-populate=true<%= (request.getParameter("popup") != null?"&popup=true":"") %>" method="post">
<%-- Trails --%>
<dhv:evaluate if="<%= !popUp %>">
<table class="trails" cellspacing="0">
<tr>
<td width="100%">
  <a href="Accounts.do"><dhv:label name="accounts.accounts">Accounts</dhv:label></a> > 
  <a href="Accounts.do?command=Search"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
  <a href="Accounts.do?command=Details&orgId=<%= OrgDetails.getOrgId() %>"><dhv:label name="accounts.details">Account Details</dhv:label></a> >
  <a href="Contacts.do?command=View&orgId=<%= OrgDetails.getOrgId() %>"><dhv:label name="accounts.Contacts">Contacts</dhv:label></a> >
  <dhv:label name="accounts.AddContact">Add Contact</dhv:label>
</td>
</tr>
</table>
</dhv:evaluate>
<%-- End Trails --%>
<dhv:container name="accounts" selected="contacts" object="OrgDetails" param="<%= "orgId=" + OrgDetails.getOrgId() %>" hideContainer="<%= isPopup(request) %>">
  <input type="hidden" name="orgId" value="<%= OrgDetails.getOrgId() %>">
  <input type="submit" value="<dhv:label name="global.button.save">Save</dhv:label>" onClick="return checkForm(this.form)">
  <dhv:evaluate if="<%= !popUp %>">
    <input type="submit" value="<dhv:label name="accounts.accounts_contacts_add.SaveClone">Save & Clone</dhv:label>" onClick="this.form.saveAndClone.value='true';return checkForm(this.form);">
  </dhv:evaluate>
  <input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:<%= popUp ? "window.close();" : "window.location.href='Contacts.do?command=View&orgId=" + OrgDetails.getOrgId() + "'" %>">
  <br />
  <dhv:formMessage />
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
    <tr>
      <th colspan="2">
        <strong><dhv:label name="accounts.accounts_contacts_add.AddNewContact">Add a New Contact</dhv:label></strong>
      </th>
    </tr>
    <tr class="containerBody">
      <td nowrap class="formLabel" valign="top">
        <dhv:label name="accounts.accounts_contacts_add.ContactTypes">Contact Type(s)</dhv:label>
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
                &nbsp;[<a href="javascript:popContactTypeSelectMultiple('selectedList', 'accounts', <%= ContactDetails.getId() %>);"><dhv:label name="accounts.accounts_add.select">Select</dhv:label></a>]
            </td>
          </tr>
        </table>
       </td>
    </tr>
    <tr class="containerBody">
      <td nowrap class="formLabel">
        <dhv:label name="accounts.accounts_add.FirstName">First Name</dhv:label>
      </td>
      <td>
        <input type="text" size="35" name="nameFirst" value="<%= toHtmlValue(ContactDetails.getNameFirst()) %>">
      </td>
    </tr>
    <tr class="containerBody">
      <td nowrap class="formLabel">
        <dhv:label name="accounts.accounts_add.MiddleName">Middle Name</dhv:label>
      </td>
      <td>
        <input type="text" size="35" name="nameMiddle" value="<%= toHtmlValue(ContactDetails.getNameMiddle()) %>">
      </td>
    </tr>
    <tr class="containerBody">
      <td nowrap class="formLabel">
        <dhv:label name="accounts.accounts_add.LastName">Last Name</dhv:label>
      </td>
      <td>
        <input type="text" size="35" name="nameLast" value="<%= toHtmlValue(ContactDetails.getNameLast()) %>">
        <font color="red">*</font> <%= showAttribute(request, "nameLastError") %>
      </td>
    </tr>
    <tr class="containerBody">
      <td nowrap class="formLabel">
        <dhv:label name="accounts.accounts_add.additionalNames">Additional Names</dhv:label>
      </td>
      <td>
        <input type="text" size="35" name="additionalNames" value="<%= toHtmlValue(ContactDetails.getAdditionalNames()) %>">
      </td>
    </tr>
    <tr class="containerBody">
      <td nowrap class="formLabel">
        <dhv:label name="accounts.accounts_add.nickname">Nickname</dhv:label>
      </td>
      <td>
        <input type="text" size="35" name="nickname" value="<%= toHtmlValue(ContactDetails.getNickname()) %>">
      </td>
    </tr>
    <tr class="containerBody">
      <td nowrap class="formLabel">
        <dhv:label name="accounts.accounts_add.dateOfBirth">Date of Birth</dhv:label>
      </td>
      <td>
        <zeroio:dateSelect form="addContact" field="birthDate" timestamp="<%= ContactDetails.getBirthDate() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="false"/>
        <%= showAttribute(request, "birthDateError") %>
      </td>
    </tr>
    <tr class="containerBody">
      <td nowrap class="formLabel">
        <dhv:label name="accounts.accounts_contacts_add.Title">Title</dhv:label>
      </td>
      <td>
        <input type="text" size="35" name="title" value="<%= toHtmlValue(ContactDetails.getTitle()) %>">
      </td>
    </tr>
    <tr class="containerBody">
      <td nowrap class="formLabel">
        <dhv:label name="accounts.accounts_contacts_add.Role">Role</dhv:label>
      </td>
      <td>
        <input type="text" size="35" name="role" value="<%= toHtmlValue(ContactDetails.getRole()) %>">
      </td>
    </tr>
  </table>
  <br />
  <%--  include basic contact form --%>
  <%@ include file="../contacts/contact_include.jsp" %>
  <dhv:permission name="portal-user-add">
    <dhv:evaluate if="<%= !popUp %>">
      <table>
       <tr>
          <td valign="top" >
            <strong><dhv:label name="accounts.accounts_contacts_add.ProvidePortalAccess">Provide portal access?</dhv:label></strong>
          </td>
          <td>
          <input type="checkbox" name="providePortalAccess" value="true" />
          </td>
       </tr>
      </table>
    </dhv:evaluate>
  </dhv:permission>
  <br>
  <input type="submit" value="<dhv:label name="global.button.save">Save</dhv:label>" onClick="return checkForm(this.form)">
  <dhv:evaluate if="<%= !popUp %>">
    <input type="submit" value="<dhv:label name="accounts.accounts_contacts_add.SaveClone">Save & Clone</dhv:label>" onClick="this.form.saveAndClone.value='true';return checkForm(this.form);">
  </dhv:evaluate>
  <input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:<%= popUp ? "window.close();" : "window.location.href='Contacts.do?command=View&orgId=" + OrgDetails.getOrgId() + "'" %>">
  <input type="hidden" name="orgName" value="<%= OrgDetails.getName() %>">
</dhv:container>
</form>
</body>
