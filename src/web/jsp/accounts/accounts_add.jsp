<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<jsp:useBean id="IndustryList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="OrgPhoneTypeList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="OrgAddressTypeList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="OrgEmailTypeList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="AccountTypeList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="OrgDetails" class="com.darkhorseventures.cfsbase.Organization" scope="request"/>
<jsp:useBean id="StateSelect" class="com.darkhorseventures.webutils.StateSelect" scope="request"/>
<jsp:useBean id="CountrySelect" class="com.darkhorseventures.webutils.CountrySelect" scope="request"/>
<%@ include file="initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="/javascript/checkDate.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="/javascript/checkPhone.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="/javascript/popCalendar.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="/javascript/popLookupSelect.js"></script>

<script language="JavaScript">
  indSelected = 0;
  orgSelected = 1;
  
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
      if ((!form.alertDate.value == "") && (!checkDate(form.alertDate.value))) { 
        message += "- Check that Alert Date is entered correctly\r\n";
        formTest = false;
      }
      if ((!form.alertDate.value == "") && (!checkAlertDate(form.alertDate.value))) { 
        message += "- Check that Alert Date is on or after today's date\r\n";
        formTest = false;
      }
      if ((!form.contractEndDate.value == "") && (!checkDate(form.contractEndDate.value))) { 
        message += "- Check that Contract End Date is entered correctly\r\n";
        formTest = false;
      }
      if ((!form.alertText.value == "") && (form.alertDate.value == "")) { 
        message += "- Please specify an alert date\r\n";
        formTest = false;
      }
      if ((!form.alertDate.value == "") && (form.alertText.value == "")) { 
        message += "- Please specify an alert description\r\n";
        formTest = false;
      }
      if ((!checkPhone(form.phone1number.value)) || (!checkPhone(form.phone2number.value))) { 
        message += "- At least one entered phone number is invalid.  Make sure there are no invalid characters and that you have entered the area code\r\n";
        formTest = false;
      }
      if (formTest == false) {
        alert("Form could not be saved, please check the following:\r\n\r\n" + message);
        return false;
      } else {
        var test = document.addAccount.selectedList;
        if (test != null) {
          return selectAllOptions(document.addAccount.selectedList);
        }
      }
    }
    
  function resetFormElements() {
    //some checks
    isNS4 = (document.layers) ? true : false;
    isIE4 = (document.all && !document.getElementById) ? true : false;
    isIE5 = (document.all && document.getElementById) ? true : false;
    isNS6 = (!document.all && document.getElementById) ? true : false;  
    //end checks 
    
    if (isNS4){
      elm1 = document.layers["nameFirst1"];
      elm2 = document.layers["nameMiddle1"];
      elm3 = document.layers["nameLast1"];
      elm4 = document.layers["orgname1"];
      elm5 = document.layers["ticker1"];
    }
    else if (isIE4) {
      elm1 = document.all["nameFirst1"];
      elm2 = document.all["nameMiddle1"];
      elm3 = document.all["nameLast1"];
      elm4 = document.all["orgname1"];
      elm5 = document.all["ticker1"];
    }    
    else if (isIE5 || isNS6) {
      elm1 = document.getElementById("nameFirst1");
      elm2 = document.getElementById("nameMiddle1");
      elm3 = document.getElementById("nameLast1");
      elm4 = document.getElementById("orgname1");
      elm5 = document.getElementById("ticker1");
      
      elm1.style.color = "#000000";
      document.addAccount.nameFirst.style.background = "#ffffff";
      
      elm2.style.color = "#000000";      
      document.addAccount.nameMiddle.style.background = "#ffffff";
      
      elm3.style.color = "#000000";          
      document.addAccount.nameLast.style.background = "#ffffff";
      
      elm4.style.color = "#000000"; 
      document.addAccount.name.style.background = "#ffffff";
      
      elm5.style.color = "#000000";      
      document.addAccount.ticker.style.background = "#ffffff";
    }
  }  
    
  function updateFormElements(index) {
    //some checks
    isNS4 = (document.layers) ? true : false;
    isIE4 = (document.all && !document.getElementById) ? true : false;
    isIE5 = (document.all && document.getElementById) ? true : false;
    isNS6 = (!document.all && document.getElementById) ? true : false;  
    //end checks 
    
    if (isNS4){
      elm1 = document.layers["nameFirst1"];
      elm2 = document.layers["nameMiddle1"];
      elm3 = document.layers["nameLast1"];
      elm4 = document.layers["orgname1"];
      elm5 = document.layers["ticker1"];
    }
    else if (isIE4) {
      elm1 = document.all["nameFirst1"];
      elm2 = document.all["nameMiddle1"];
      elm3 = document.all["nameLast1"];
      elm4 = document.all["orgname1"];
      elm5 = document.all["ticker1"];
    }
    else if (isIE5 || isNS6) {
      elm1 = document.getElementById("nameFirst1");
      elm2 = document.getElementById("nameMiddle1");
      elm3 = document.getElementById("nameLast1");
      elm4 = document.getElementById("orgname1");
      elm5 = document.getElementById("ticker1");
      
      if (index == 1) {
        indSelected = 1;
        orgSelected = 0;        
        
        resetFormElements();
      
        elm4.style.color="#cccccc";
        document.addAccount.name.style.background = "#cccccc";
        document.addAccount.name.value = "";

        elm5.style.color="#cccccc";
        document.addAccount.ticker.style.background = "#cccccc";
        document.addAccount.ticker.value = "";        
      } else {
        indSelected = 0;
        orgSelected = 1;
        
        resetFormElements();        
        
        elm1.style.color = "#cccccc";
        document.addAccount.nameFirst.style.background = "#cccccc";
        document.addAccount.nameFirst.value = "";
        
        elm2.style.color = "#cccccc";  
        document.addAccount.nameMiddle.style.background = "#cccccc";
        document.addAccount.nameMiddle.value = ""; 
        
        elm3.style.color = "#cccccc";      
        document.addAccount.nameLast.style.background = "#cccccc";
        document.addAccount.nameLast.value = "";     
      }
    }
    var url = "Accounts.do?command=RebuildFormElements&index=" + index;
    window.frames['server_commands'].location.href=url;
  }    
  
  //-------------------------------------------------------------------
  // getElementIndex(input_object)
  //   Pass an input object, returns index in form.elements[] for the object
  //   Returns -1 if error
  //-------------------------------------------------------------------
  function getElementIndex(obj) {
    var theform = obj.form;
    for (var i=0; i<theform.elements.length; i++) {
      if (obj.name == theform.elements[i].name) {
        return i;
        }
      }
      return -1;
    }

  // -------------------------------------------------------------------
  // tabNext(input_object)
  //   Pass an form input object. Will focus() the next field in the form
  //   after the passed element.
  //   a) Will not focus to hidden or disabled fields
  //   b) If end of form is reached, it will loop to beginning
  //   c) If it loops through and reaches the original field again without
  //      finding a valid field to focus, it stops
  // -------------------------------------------------------------------
  function tabNext(obj) {
    if (navigator.platform.toUpperCase().indexOf("SUNOS") != -1) {
      obj.blur(); return; // Sun's onFocus() is messed up
      }
    var theform = obj.form;
    var i = getElementIndex(obj);
    var j=i+1;
    if (j >= theform.elements.length) { j=0; }
    if (i == -1) { return; }
    while (j != i) {
      if ((theform.elements[j].type!="hidden") && 
          (theform.elements[j].name != theform.elements[i].name) && 
        (!theform.elements[j].disabled)) {
        theform.elements[j].focus();
        break;
        }
      j++;
      if (j >= theform.elements.length) { j=0; }
      }
  }
  
    
</script>

<body onLoad="javascript:document.forms[0].name.focus();updateFormElements(0);">

<form name="addAccount" action="/Accounts.do?command=Insert&auto-populate=true" onSubmit="return doCheck(this);" method="post">
<a href="/Accounts.do">Account Management</a> > 
Add Account<br>
<hr color="#BFBFBB" noshade>
<input type="submit" value="Insert" name="Save" onClick="this.form.dosubmit.value='true';">
<input type="submit" value="Cancel" onClick="javascript:this.form.action='/Accounts.do?command=View';this.form.dosubmit.value='false';">
<input type="reset" value="Reset">
<br>
<%= showError(request, "actionError") %>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>
  <tr bgcolor="#DEE0FA">
    <td colspan=2 valign=center align=left>
      <strong>Add a New Account</strong>
    </td>     
  </tr>
  
   <tr>
    <td nowrap class="formLabel" valign="top">
      Account Type(s)
    </td>
	<td valign=center>
      <select multiple name="selectedList" id="selectedList" size="5">
      <option value="-1">None Selected</option>
			</select>
      <input type="hidden" name="previousSelection" value="">
      <a href="javascript:popLookupSelectMultiple('selectedList','1','lookup_account_types');">Select</a>
  </td>
  
	</tr>
  
  <tr>
    <td nowrap class="formLabel">
      Classification
    </td>
    <td>
        <input type="radio" name="form_type" value="organization" checked onClick="javascript:updateFormElements(0);">Organization
        <input type="radio" name="form_type" value="individual" onClick="javascript:updateFormElements(1);">Individual
    </td>
  </tr>  
  
  <tr>
    <td nowrap class="formLabel" name="orgname1" id="orgname1">
      Organization Name
    </td>
    <td>
        <input onFocus="if (indSelected == 1) { tabNext(this) }" type=text size=35 name="name" value="<%= toHtmlValue(OrgDetails.getName()) %>"><font color="red">*</font> <%= showAttribute(request, "nameError") %>
    </td>
  </tr>
  
  <tr>
    <td name="nameFirst1" id="nameFirst1" nowrap class="formLabel">
      First Name
    </td>
    <td>
        <input onFocus="if (orgSelected == 1) { tabNext(this) }" type=text size=35 name="nameFirst" value="<%= toHtmlValue(OrgDetails.getNameFirst()) %>">
    </td>
  </tr>

  <tr>
    <td name="nameMiddle1" id="nameMiddle1" nowrap class="formLabel">
      Middle Name
    </td>
    <td>
        <input onFocus="if (orgSelected == 1) { tabNext(this) }" type=text size=35 name="nameMiddle" value="<%= toHtmlValue(OrgDetails.getNameMiddle()) %>">
    </td>
  </tr>

  <tr>
    <td name="nameLast1" id="nameLast1" nowrap class="formLabel">
      Last Name
    </td>
    <td>
        <input onFocus="if (orgSelected == 1) { tabNext(this) }" type=text size=35 name="nameLast" value="<%= toHtmlValue(OrgDetails.getNameLast()) %>"><font color="red">*</font> <%= showAttribute(request, "nameLastError") %>
    </td>
  </tr>  
  
  <tr>
    <td nowrap class="formLabel">
      Account Number
    </td>
    <td>
      <input type=text size=50 name="accountNumber" maxlength=50>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      Web Site URL
    </td>
    <td>
      <input type=text size=50 name="url" value="<%= toHtmlValue(OrgDetails.getUrl()) %>">
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      Industry
    </td>
    <td valign=center colspan=1>
      <%=IndustryList.getHtmlSelect("industry",0)%>
    </td>
  </tr>
  
  <dhv:include name="accounts-employees" none="true">
  <tr>
    <td nowrap class="formLabel">
      No. of Employees
    </td>
    <td valign=center colspan=1>
      <input type=text size=10 name="employees">
    </td>
  </tr>
  </dhv:include>
  
  <dhv:include name="accounts-revenue" none="true">
  <tr>
    <td nowrap class="formLabel">
      Revenue
    </td>
    <td valign=center colspan=1>
      <input type=text size=10 name="revenue">
    </td>
  </tr>
  </dhv:include>
  
        <tr>
    <td name="ticker1" id="ticker1" nowrap class="formLabel">
      Ticker Symbol
    </td>
    <td valign=center colspan=1>
      <input onFocus="if (indSelected == 1) { tabNext(this) }" type=text size=10 name="ticker">
    </td>
  </tr>
  
          <tr>
    <td nowrap class="formLabel">
      Contract End Date
    </td>
    <td valign=center colspan=1>
      <input type=text size=10 name="contractEndDate" value="<%= toHtmlValue(OrgDetails.getContractEndDateString()) %>">
      <a href="javascript:popCalendar('addAccount', 'contractEndDate');">Date</a> (mm/dd/yyyy)
    </td>
  </tr>
  
            <tr>
    <td nowrap class="formLabel">
      Alert Description
    </td>
    <td valign=center colspan=1>
      <input type=text size=50 name="alertText" value="<%= toHtmlValue(OrgDetails.getAlertText()) %>"><br>
    </td>
  </tr>
  
   <tr>
    <td nowrap class="formLabel">
      Alert Date
    </td>
    <td valign=center colspan=1>
              <input type=text size=10 name="alertDate" value="<%= toHtmlValue(OrgDetails.getAlertDateString()) %>">
      <a href="javascript:popCalendar('addAccount', 'alertDate');">Date</a> (mm/dd/yyyy)
    </td>
  </tr>
  
  

  
</table>
&nbsp;<br>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr bgcolor="#DEE0FA">
    <td valign=center align=left>
	    <strong>Phone Numbers</strong>
	  </td>
  </tr>
  <tr>
    <td>
      <%= OrgPhoneTypeList.getHtmlSelect("phone1type", "Main") %>
      <!--input type=text size=3 name="phone1ac" maxlength=3>-
      <input type=text size=3 name="phone1pre" maxlength=3>- -->
      <input type=text size=20 name="phone1number">&nbsp;ext.
      <input type=text size=5 name="phone1ext" maxlength=10>
    </td>
  </tr>
  <tr>
    <td>
      <%= OrgPhoneTypeList.getHtmlSelect("phone2type", "Fax") %>
      <!--input type=text size=3 name="phone2ac" maxlength=3>- 
      <input type=text size=3 name="phone2pre" maxlength=3>- -->
      <input type=text size=20 name="phone2number">&nbsp;ext.
      <input type=text size=5 name="phone2ext" maxlength=10>
    </td>
  </tr>
</table>
&nbsp;<br>  
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr bgcolor="#DEE0FA">
    <td valign=center align=left colspan="2">
      <strong>Addresses</strong>
    </td>
  </tr>
  <tr>
    <td>
      &nbsp;
    </td>
    <td>
      <%= OrgAddressTypeList.getHtmlSelect("address1type", "Primary") %>
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
      <%= OrgAddressTypeList.getHtmlSelect("address2type", "Auxiliary") %>
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
    <%=CountrySelect.getHtml("address2country")%>
      <!--input type=text size=28 name="address2country" maxlength=80-->
    </td>
  </tr>
</table>
&nbsp;<br>  
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr bgcolor="#DEE0FA">
    <td valign=center align=left>
	    <strong>Email Addresses</strong>
	  </td>
  </tr>
  <tr>
    <td>
      <%= OrgEmailTypeList.getHtmlSelect("email1type", "Primary") %>
      <input type=text size=40 name="email1address" maxlength=255>
    </td>
  </tr>
  <tr>
    <td>
      <%= OrgEmailTypeList.getHtmlSelect("email2type", "Auxiliary") %>
      <input type=text size=40 name="email2address" maxlength=255>
    </td>
  </tr>
</table>
&nbsp;<br>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr bgcolor="#DEE0FA">
    <td colspan=2 valign=center align=left>
	    <strong>Additional Details</strong>
	  </td>
  </tr>
  <tr>
    <td valign="top" nowrap class="formLabel">Notes</td>
    <td><TEXTAREA NAME='notes' ROWS=3 COLS=50><%= toString(OrgDetails.getNotes()) %></TEXTAREA></td>
  </tr>
</table>
<br>
<input type="submit" value="Insert" name="Save" onClick="this.form.dosubmit.value='true';">
<input type="submit" value="Cancel" onClick="javascript:this.form.action='/Accounts.do?command=View';this.form.dosubmit.value='false';">
<input type="reset" value="Reset">
<input type="hidden" name="dosubmit" value="true">
</form>
</body>
