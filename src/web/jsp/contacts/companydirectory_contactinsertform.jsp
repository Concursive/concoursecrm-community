<%@ page import="java.util.*,org.aspcfs.modules.*,org.aspcfs.webutils.*" %>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="ContactTypeList" class="org.aspcfs.modules.contacts.base.ContactTypeList" scope="request"/>
<jsp:useBean id="ContactPhoneTypeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ContactEmailTypeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ContactAddressTypeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="StateSelect" class="org.aspcfs.utils.web.StateSelect" scope="request"/>
<jsp:useBean id="CountrySelect" class="org.aspcfs.utils.web.CountrySelect" scope="request"/>
<jsp:useBean id="OrgList" class="org.aspcfs.modules.accounts.base.OrganizationList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="/javascript/checkPhone.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="/javascript/popLookupSelect.js"></script>
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
      if(document.forms[0].contactcategory[1].checked && document.forms[0].orgId.value == '-1'){
       message += "- Make sure you select an account.\r\n";
			 formTest = false;
      }
      if (formTest == false) {
        alert("Form could not be saved, please check the following:\r\n\r\n" + message);
        return false;
      }else {
        var test = document.addContact.selectedList;
        if (test != null) {
          return selectAllOptions(document.addContact.selectedList);
        }
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
<form name="addContact" action="ExternalContacts.do?command=InsertContact&auto-populate=true" onSubmit="return doCheck(this);" method="post">
<a href="ExternalContacts.do">Contacts &amp; Resources</a> > 
Add Contact<br>
<hr color="#BFBFBB" noshade>
<input type="submit" value="Save" onClick="this.form.dosubmit.value='true';">
<input type="submit" value="Save & New" onClick="this.form.saveAndNew.value='true';this.form.dosubmit.value='true';">
<input type="submit" value="Cancel" onClick="javascript:this.form.action='ExternalContacts.do?command=ListContacts';this.form.dosubmit.value='false';">
<input type="reset" value="Reset">
<br>
<%= showError(request, "actionError") %>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan=2 valign=center align=left>
      <strong>Add a New Contact</strong>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      Contact Category
    </td>
    <td>
      <input type="radio" name="contactcategory" value="1" onclick="javascript:document.forms[0].orgId.selectedIndex = 0;" <%= ContactDetails.getOrgId() == -1 ? " checked":""%>>General Contact<br>
      <input type="radio" name="contactcategory" value="2" <%= ContactDetails.getOrgId() > -1 ? " checked":""%>> Associated with Account &nbsp; <%= OrgList.getHtmlSelectDefaultNone("orgId", ContactDetails.getOrgId())%>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      Contact Type(s)
    </td>
    <td valign="center">
      <select multiple name="selectedList" id="selectedList" size="5">
        <dhv:evaluate exp="<%= ContactDetails.getTypes().isEmpty() %>">
        <%if(ContactDetails.getTypes().isEmpty()) {%>
          <option value="-1">None Selected</option>
        <%}else{
            Iterator i = ContactDetails.getTypes().iterator();
            while (i.hasNext()) {
              LookupElement thisElt = (LookupElement)i.next();
            %>
               <option value="<%=thisElt.getCode()%>"><%=thisElt.getDescription()%></option>
            <%}%>
         <%}%>
			</select>
      <input type="hidden" name="previousSelection" value="">
      <%-- Check for cloned contact --%>
      <% if(request.getParameter("id") == null) {%>
        <a href="javascript:setCategoryPopContactType('selectedList', <%= ContactDetails.getId() %>);">Select</a>
      <%}else{%>
          <a href="javascript:setCategoryPopContactType('selectedList', <%= request.getParameter("id") %>);">Select</a>
      <%}%>
     </td>
  </tr>
  
  <tr>
    <td nowrap class="formLabel">
      First Name
    </td>
    <td>
      <input type=text size=35 name="nameFirst" value="<%= toHtmlValue(ContactDetails.getNameFirst()) %>">
    </td>
  </tr>
  
  <tr>
    <td nowrap class="formLabel">
      Middle Name
    </td>
    <td>
      <input type=text size=35 name="nameMiddle" value="<%= toHtmlValue(ContactDetails.getNameMiddle()) %>">
    </td>
  </tr>
  
  <tr>
    <td nowrap class="formLabel">
      Last Name
    </td>
    <td>
      <input type=text size=35 name="nameLast" value="<%= toHtmlValue(ContactDetails.getNameLast()) %>">
      <font color="red">-</font> <%= showAttribute(request, "lastcompanyError") %>
    </td>
  </tr>
  
  <tr>
    <td nowrap class="formLabel">
      Company
    </td>
    <td>
      <input type=text size=35 name="company" value="<%= toHtmlValue(ContactDetails.getCompany()) %>">
      <font color="red">-</font> <%= showAttribute(request, "lastcompanyError") %>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      Title
    </td>
    <td>
      <input type=text size=35 name="title" value="<%= toHtmlValue(ContactDetails.getTitle()) %>">
    </td>
  </tr>
</table>
&nbsp;<br>  
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td valign=center align=left>
	    <strong>Email Addresses</strong>
	  </td>
  </tr>
<%
  int ecount = 0;
  int etotal = 2;
  Iterator enumber = ContactDetails.getEmailAddressList().iterator();
  while (enumber.hasNext()) {
    ++ecount;
    ContactEmailAddress thisEmailAddress = (ContactEmailAddress)enumber.next();
%>  

  <tr class="containerBody">
    <td>
      <%= ContactEmailTypeList.getHtmlSelect("email"+ecount+"type", thisEmailAddress.getType()) %>
      <input type=text size=40 name="email<%= ecount %>address" maxlength=255 value="<%= toHtmlValue(thisEmailAddress.getEmail()) %>">
    </td>
  </tr>
<%    
  }
%>  

<% 
  while (ecount < etotal) {
    ++ecount;
%>

  <tr class="containerBody">
    <td>
      <%= ContactEmailTypeList.getHtmlSelect("email" + ecount + "type", ((ContactDetails.getEmailAddressTypeId(1)==-1)?1:ContactDetails.getEmailAddressTypeId(1))) %>
      <input type=text size=40 name="email<%=ecount%>address" maxlength=255>
    </td>
  </tr>
<%
  }
%>
</table>
<div align="center" style="padding:3px;">Note: All international phone numbers must be preceded by a "+" symbol.</div>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td valign=center align=left>
	    <strong>Phone Numbers</strong>
	  </td>
  </tr>
<%  
  int icount = 0;
  int itotal = 3;
  Iterator inumber = ContactDetails.getPhoneNumberList().iterator();
  
  while (inumber.hasNext()) {
    ++icount;
    ContactPhoneNumber thisPhoneNumber = (ContactPhoneNumber)inumber.next();
%>    
  <tr class="containerBody">
    <td>
      <%= ContactPhoneTypeList.getHtmlSelect("phone" + icount + "type", thisPhoneNumber.getType()) %>
      <input type=text size=20 name="phone<%= icount %>number" value="<%= toHtmlValue(thisPhoneNumber.getNumber()) %>">&nbsp;ext.
      <input type="text" size="5" name="phone<%= icount %>ext" maxlength="10" value="<%= toHtmlValue(thisPhoneNumber.getExtension()) %>">
    </td>
  </tr>    
<%    
  }
%>

<% 
  while (icount < itotal) {
    ++icount;
%>
  
  <tr class="containerBody">
    <td>
      <%= ContactPhoneTypeList.getHtmlSelect("phone"+icount+"type", "Business") %>
      <input type=text size=20 name="phone<%=icount%>number">&nbsp;ext.
      <input type=text size=5 name="phone<%=icount%>ext" maxlength=10>
    </td>
  </tr>
<%}%>  

</table>
&nbsp;<br>  
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td valign=center align=left colspan="2">
      <strong>Addresses</strong>
    </td>
  </tr>
  <%  
  int acount = 0;
  int atotal = 2;
  Iterator anumber = ContactDetails.getAddressList().iterator();
  while (anumber.hasNext()) {
    ++acount;
    ContactAddress thisAddress = (ContactAddress)anumber.next();
%>    
  <tr class="containerBody">
    <input type="hidden" name="address<%= acount %>id" value="<%= thisAddress.getId() %>">
    <td>
      &nbsp;
    </td>
    <td>
      <%= ContactAddressTypeList.getHtmlSelect("address" + acount + "type", thisAddress.getType()) %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Address Line 1
    </td>
    <td>
      <input type=text size=40 name="address<%= acount %>line1" maxlength=80 value="<%= toHtmlValue(thisAddress.getStreetAddressLine1()) %>">
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Address Line 2
    </td>
    <td>
      <input type=text size=40 name="address<%= acount %>line2" maxlength=80 value="<%= toHtmlValue(thisAddress.getStreetAddressLine2()) %>">
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      City
    </td>
    <td>
      <input type=text size=28 name="address<%= acount %>city" maxlength=80 value="<%= toHtmlValue(thisAddress.getCity()) %>">
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      State/Province
    </td>
    <td>
      <%=StateSelect.getHtml("address" + acount + "state", thisAddress.getState())%>
      <% StateSelect = new StateSelect(); %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Zip/Postal Code
    </td>
    <td>
      <input type=text size=10 name="address<%= acount %>zip" maxlength=12 value="<%= toHtmlValue(thisAddress.getZip()) %>">
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Country
    </td>
    <td>
      <%=CountrySelect.getHtml("address" + acount + "country", thisAddress.getCountry())%>
      <% CountrySelect = new CountrySelect(); %>
    </td>
  </tr>
  <tr class="containerBody">
    <td colspan="2">
      &nbsp;
    </td>
  </tr>
<%    
  }
%>

<% 
  while (acount < atotal) {
%>
  
  <tr class="containerBody">
    <td>
      &nbsp;
    </td>
    <td>
      <%= ContactAddressTypeList.getHtmlSelect("address" + (++acount) + "type", "Business") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Address Line 1
    </td>
    <td>
      <input type=text size=40 name="address<%= acount %>line1" maxlength=80>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Address Line 2
    </td>
    <td>
      <input type=text size=40 name="address<%= acount %>line2" maxlength=80>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      City
    </td>
    <td>
      <input type=text size=28 name="address<%= acount %>city" maxlength=80>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      State/Province
    </td>
    <td>
      <%=StateSelect.getHtml("address" + acount + "state")%>
      <% StateSelect = new StateSelect(); %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Zip/Postal Code
    </td>
    <td>
      <input type=text size=10 name="address<%= acount %>zip" maxlength=12>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Country
    </td>
    <td>
      <%=CountrySelect.getHtml("address" + acount + "country")%>
      <% CountrySelect = new CountrySelect(); %>
    </td>
  </tr>
  
  <% if (acount != atotal) { %>
    <tr class="containerBody">
    <td colspan="2">
      &nbsp;
    </td>
  </tr>
  <%}%>
  
<%}%>  
</table>
&nbsp;<br>  
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td valign=center align=left colspan="2">
      <strong>Additional Details</strong>
    </td>
  </tr>  
  <tr>
    <td valign="top" class="formLabel">
      Notes
    </td>
    <td>
      <TEXTAREA NAME='notes' ROWS=3 COLS=50><%= toString(ContactDetails.getNotes()) %></TEXTAREA>
    </td>
  </tr>
</table>
<br>
<input type="submit" value="Save" onClick="this.form.dosubmit.value='true';">
<input type="submit" value="Save & New" onClick="this.form.saveAndNew.value='true';this.form.dosubmit.value='true';">
<input type="submit" value="Cancel" onClick="javascript:this.form.action='ExternalContacts.do?command=ListContacts';this.form.dosubmit.value='false';">
<input type="reset" value="Reset">
<input type="hidden" name="dosubmit" value="true">
<input type="hidden" name="saveAndNew" value="">
</form>
</body>
