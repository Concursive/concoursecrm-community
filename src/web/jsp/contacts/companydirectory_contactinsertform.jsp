<jsp:useBean id="ContactDetails" class="com.darkhorseventures.cfsbase.Contact" scope="request"/>
<jsp:useBean id="ContactTypeList" class="com.darkhorseventures.cfsbase.ContactTypeList" scope="request"/>
<jsp:useBean id="ContactPhoneTypeList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="ContactEmailTypeList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="ContactAddressTypeList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="StateSelect" class="com.darkhorseventures.webutils.StateSelect" scope="request"/>
<jsp:useBean id="CountrySelect" class="com.darkhorseventures.webutils.CountrySelect" scope="request"/>
<%@ include file="initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="/javascript/checkPhone.js"></script>
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
      if (formTest == false) {
        alert("Form could not be saved, please check the following:\r\n\r\n" + message);
        return false;
      } else {
        return true;
      }
    }
</script>
<body onLoad="javascript:document.forms[0].nameFirst.focus();">
<form name="addContact" action="/ExternalContacts.do?command=InsertContact&auto-populate=true" onSubmit="return doCheck(this);" method="post">
<a href="/ExternalContacts.do">Contacts &amp; Resources</a> > 
Add Contact<br>
<hr color="#BFBFBB" noshade>
<input type="submit" value="Save" onClick="this.form.dosubmit.value='true';">
<input type="submit" value="Cancel" onClick="javascript:this.form.action='/ExternalContacts.do?command=ListContacts';this.form.dosubmit.value='false';">
<input type="reset" value="Reset">
<br>
&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan=2 valign=center align=left>
      <strong>Add a New Contact</strong>
    </td>     
  </tr>
  
  <tr>
    <td nowrap class="formLabel">
      Contact Type
    </td>
    <td>
      <%=ContactTypeList.getHtmlSelect("typeId", ContactDetails.getTypeId())%>
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

  <tr>
    <td>
      <%= ContactEmailTypeList.getHtmlSelect("email1type", ((ContactDetails.getEmailAddressTypeId(1)==-1)?1:ContactDetails.getEmailAddressTypeId(1))) %>
      <input type=text size=40 name="email1address" maxlength=255>
    </td>
  </tr>
  <tr>
    <td>
      <%= ContactEmailTypeList.getHtmlSelect("email2type", ((ContactDetails.getEmailAddressTypeId(2)==-1)?2:ContactDetails.getEmailAddressTypeId(2))) %>
      <input type=text size=40 name="email2address" maxlength=255>
    </td>
  </tr>
</table>
&nbsp;<br>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td valign=center align=left>
	    <strong>Phone Numbers</strong>
	  </td>
  </tr>
  <tr>
    <td>
      <%= ContactPhoneTypeList.getHtmlSelect("phone1type", "Business") %>
      <!--input type=text size=3 name="phone1ac" maxlength=3>-
      <input type=text size=3 name="phone1pre" maxlength=3>-
      <input type=text size=4 name="phone1number" maxlength=4>ext. -->
      <input type=text size=20 name="phone1number">&nbsp;ext.
      <input type=text size=5 name="phone1ext" maxlength=10>
    </td>
  </tr>
  <tr>
    <td>
      <%= ContactPhoneTypeList.getHtmlSelect("phone2type", "Home") %>
      <!--input type=text size=3 name="phone2ac" maxlength=3>-
      <input type=text size=3 name="phone2pre" maxlength=3>-
      <input type=text size=4 name="phone2number" maxlength=4>ext. -->
      <input type=text size=20 name="phone2number">&nbsp;ext.
      <input type=text size=5 name="phone2ext" maxlength=10>
    </td>
  </tr>
  <tr>
    <td>
      <%= ContactPhoneTypeList.getHtmlSelect("phone3type", "Mobile") %>
      <!--input type=text size=3 name="phone3ac" maxlength=3>-
      <input type=text size=3 name="phone3pre" maxlength=3>-
      <input type=text size=4 name="phone3number" maxlength=4>ext. -->
      <input type=text size=20 name="phone3number">&nbsp;ext.
      <input type=text size=5 name="phone3ext" maxlength=10>
    </td>
  </tr>
</table>
&nbsp;<br>  
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td valign=center align=left colspan="2">
      <strong>Addresses</strong>
    </td>
  </tr>
  <tr>
    <td>
      &nbsp;
    </td>
    <td>
      <%= ContactAddressTypeList.getHtmlSelect("address1type", "Business") %>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      Address Line 1
    </td>
    <td>
      <input type=text size=40 name="address1line1" maxlength=80>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      Address Line 2
    </td>
    <td>
      <input type=text size=40 name="address1line2" maxlength=80>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      City
    </td>
    <td>
      <input type=text size=28 name="address1city" maxlength=80>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      State/Province
    </td>
    <td>
      <%=StateSelect.getHtml("address1state")%>
      <!--input type=text size=12 name="address1state" maxlength=80-->
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      Zip/Postal Code
    </td>
    <td>
      <input type=text size=28 name="address1zip" maxlength=12>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      Country
    </td>
    <td>
      <%=CountrySelect.getHtml("address1country")%>
      <!--input type=text size=28 name="address1country" maxlength=80-->
    </td>
  </tr>
  <tr><td colspan="2">&nbsp;</td></tr>
  <tr>
    <td>
      &nbsp;
    </td>
    <td>
      <%= ContactAddressTypeList.getHtmlSelect("address2type", "Home") %>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      Address Line 1
    </td>
    <td>
      <input type=text size=40 name="address2line1" maxlength=80>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      Address Line 2
    </td>
    <td>
      <input type=text size=40 name="address2line2" maxlength=80>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      City
    </td>
    <td>
      <input type=text size=28 name="address2city" maxlength=80>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      State/Province
    </td>
    <td>
      <%=StateSelect.getHtml("address2state")%>
      <!--input type=text size=12 name="address2state" maxlength=80-->
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      Zip/Postal Code
    </td>
    <td>
      <input type=text size=28 name="address2zip" maxlength=12>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      Country
    </td>
    <td>
      <!--input type=text size=28 name="address2country" maxlength=80-->
      <%=CountrySelect.getHtml("address2country")%>
    </td>
  </tr>
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
<input type="submit" value="Cancel" onClick="javascript:this.form.action='/ExternalContacts.do?command=ListContacts';this.form.dosubmit.value='false';">
<input type="reset" value="Reset">
<input type="hidden" name="dosubmit" value="true">
</form>
</body>
