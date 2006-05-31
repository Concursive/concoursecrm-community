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
  - Description: The form to add leads to the CRM
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,java.text.NumberFormat,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.contacts.base.*,org.aspcfs.utils.web.*, org.aspcfs.modules.admin.base.AccessType" %>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="SourceList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="IndustryList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="RatingList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="IndustryList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SalutationList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session" />
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkString.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkPhone.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkEmail.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popContacts.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/setSalutation.js"></script>
<script language="JavaScript">
  function getSiteId() {
    var site = document.getElementById('siteId');
    var siteId = '<%= User.getUserRecord().getSiteId() %>';
    <dhv:evaluate if="<%= User.getUserRecord().getSiteId() == -1 %>">
      siteId = site.options[site.options.selectedIndex].value;
    </dhv:evaluate>
    <dhv:evaluate if="<%= User.getUserRecord().getSiteId() != -1 %>">
      siteId = site.options[site.options.selectedIndex].value;
    </dhv:evaluate>
    return siteId;
  }
  
  function checkForm(form) {
    formTest = true;
    message = "";
    if (form.company.value != "" && checkNullString(form.company.value)) {
       message += label("check.company.blanks", "- Please enter a valid company name.\r\n");
			 formTest = false;
    }
    if (form.nameLast.value != "" && checkNullString(form.nameLast.value)) {
       message += label("check.name.last.blanks", "- Please enter a valid last name.\r\n");
			 formTest = false;
    }
<dhv:include name="contact.phoneNumbers" none="true">
    if ((!checkPhone(form.phone1number.value)) || (!checkPhone(form.phone2number.value)) || (!checkPhone(form.phone3number.value)) || (checkNullString(form.phone1number.value) && !checkNullString(form.phone1ext.value)) || (checkNullString(form.phone2number.value) && !checkNullString(form.phone2ext.value)) || (checkNullString(form.phone3number.value) && !checkNullString(form.phone3ext.value))) { 
      message += label("check.phone", "- At least one entered phone number is invalid.  Make sure there are no invalid characters and that you have entered the area code\r\n");
      formTest = false;
    }
    if ((checkNullString(form.phone1ext.value) && form.phone1ext.value != "") || (checkNullString(form.phone2ext.value) && form.phone2ext.value != "") || (checkNullString(form.phone3ext.value) && form.phone3ext.value != "")) {
      message += label("check.phone.ext","- Please enter a valid phone number extension\r\n");
      formTest = false;
    }
</dhv:include>
<dhv:include name="contact.emailAddresses" none="true">
    if ((!checkEmail(form.email1address.value)) || (!checkEmail(form.email2address.value)) || (!checkEmail(form.email3address.value))){
      message += label("check.email", "- At least one entered email address is invalid.  Make sure there are no invalid characters\r\n");
      formTest = false;
    }
</dhv:include>
<dhv:include name="contact.textMessageAddresses" none="true">
    if ((!checkEmail(form.textmessage1address.value)) || (!checkEmail(form.textmessage1address.value)) || (!checkEmail(form.textmessage1address.value))){
      message += label("check.textmessage", "- At least one entered text message address is invalid.  Make sure there are no invalid characters\r\n");
      formTest = false;
    }
</dhv:include>
    if (formTest == false) {
      alert(label("check.form", "Form could not be saved, please check the following:\r\n\r\n") + message);
      return false;
    } else {
      var test = document.addLead.selectedList;
      if (test != null) {
        return selectAllOptions(document.addLead.selectedList);
      }
    }
  }

  function update(countryObj, stateObj, selectedValue) {
    var country = document.forms['addLead'].elements[countryObj].value;
    var url = "ExternalContacts.do?command=States&country="+country+"&obj="+stateObj+"&selected="+selectedValue+"&form=addLead&stateObj=address"+stateObj+"state";
    window.frames['server_commands'].location.href=url;
  }

  function continueUpdateState(stateObj, showText) {
    if(showText == 'true'){
      hideSpan('state1' + stateObj);
      showSpan('state2' + stateObj);
    } else {
      hideSpan('state2' + stateObj);
      showSpan('state1' + stateObj);
    }
  }

  function resetFieldValue(fieldId){
    document.getElementById(fieldId).value = -1;
  }
    
  function popAssignToSingle(hiddenFieldId, displayFieldId, params) {
    var leadSiteId = <%=User.getSiteId()%>; 
    if (<%=User.getSiteId()%> == -1) {
     var siteIdWidget = document.forms['addLead'].elements['siteId'];
     leadSiteId = siteIdWidget.options[siteIdWidget.selectedIndex].value;
    }
    
    if (leadSiteId == -2){
      alert(label("lead.selectSiteFirst", "A site needs to be selected first"));
    } else {
      params = params + "&siteId=" + leadSiteId;
      popContactsListSingle(hiddenFieldId, displayFieldId, params);
    }
  }
  
</script>
<dhv:evaluate if="<%= User.getSiteId() == -1 %>" > 
  <body onLoad="javascript:document.addLead.siteId.focus();">
</dhv:evaluate>
<dhv:evaluate if="<%= User.getSiteId() != -1 %>" > 
  <body onLoad="javascript:document.addLead.listSalutation.focus();">
</dhv:evaluate>
  <form name="addLead" action="Sales.do?command=Save&auto-populate=true" onSubmit="return checkForm(this);" method="post">
<dhv:evaluate if="<%= !isPopup(request)  || isInLinePopup(request) %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
  <a href="Sales.do"><dhv:label name="Leads" mainMenuItem="true">Leads</dhv:label></a> >
  <dhv:label name="sales.addLead">Add Lead</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>
  <input type="submit" value="<dhv:label name="global.button.save">Save</dhv:label>" onClick="this.form.dosubmit.value='true';">
  <input type="submit" value="<dhv:label name="global.button.saveAndAddAnotherLead">Save and Add another Lead</dhv:label>" onClick="this.form.saveAndNew.value='true';this.form.dosubmit.value='true';">
  <input type="submit" value="<dhv:label name="global.button.saveAndViewDetails">Save and View Details</dhv:label>" onClick="this.form.saveAndClone.value='true';this.form.dosubmit.value='true';">
<br />
<dhv:formMessage />
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong><dhv:label name="sales.addLead">Add Lead</dhv:label></strong>    </th>
  </tr>
    <tr>
      <td nowrap class="formLabel">
        <dhv:label name="accounts.site">Site</dhv:label>
      </td>
      <td>
        <dhv:evaluate if="<%= User.getSiteId() == -1 %>" >
          <% SiteIdList.setJsEvent("id=\"siteId\" onChange=\"javascript:changeDivContent('changeowner',label('none.selected','None Selected'));javascript:resetFieldValue('ownerid');\"");%>
          <%= SiteIdList.getHtmlSelect("siteId",ContactDetails.getSiteId()) %>
          <font color="red">*</font> <%= showAttribute(request, "siteIdError") %>
        </dhv:evaluate>
        <dhv:evaluate if="<%= User.getSiteId() != -1 %>" >
           <%= SiteIdList.getSelectedValue(User.getSiteId()) %>
          <input type="hidden" name="siteId" value="<%=User.getSiteId()%>" >
        </dhv:evaluate>
      </td>
    </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel" valign="top">
      <dhv:label name="actionList.assignTo">Assign To</dhv:label>
    </td>
    <td>
      <table class="empty">
        <tr>
          <td>
            <div id="changeowner">
            <%if(ContactDetails.getOwner() > 0){ %>
              <dhv:username id="<%= ContactDetails.getOwner() %>"/>
            <% }else{ %>
              <dhv:label name="accounts.accounts_add.NoneSelected">None Selected</dhv:label>
            <%}%>
            </div>
          </td>
          <td>
            <input type="hidden" name="owner" id="ownerid" value="<%= ContactDetails.getOwner() %>">
            &nbsp;[<a href="javascript:popContactsListSingle('ownerid','changeowner', 'listView=employees&usersOnly=true&siteId='+getSiteId()+'&searchcodePermission=sales-leads-edit,myhomepage-action-plans-view&reset=true');"><dhv:label name="accounts.accounts_add.select">Select</dhv:label></a>]
            &nbsp; [<a href="javascript:changeDivContent('changeowner',label('none.selected','None Selected'));javascript:resetFieldValue('ownerid');"><dhv:label name="accounts.accountasset_include.clear">Clear</dhv:label></a>]
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <dhv:include name="contact-salutation" none="true">
     <tr class="containerBody">
      <td nowrap class="formLabel">
        <dhv:label name="accounts.accounts_contacts_add.Salutation">Salutation</dhv:label>
      </td>
      <td>
        <% SalutationList.setJsEvent("onchange=\"javascript:fillSalutation('addLead');\"");%>
        <%= SalutationList.getHtmlSelect("listSalutation",ContactDetails.getNameSalutation()) %> 
        <input type="hidden" size="35" maxlength="80" name="nameSalutation" value="<%= toHtmlValue(ContactDetails.getNameSalutation()) %>">
      </td>
    </tr>
  </dhv:include>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="accounts.accounts_add.FirstName">First Name</dhv:label>
    </td>
    <td>
      <input type="text" size="35" maxlength="80" name="nameFirst" value="<%= toHtmlValue(ContactDetails.getNameFirst()) %>">
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
    <dhv:label name="accounts.accounts_add.MiddleName">Middle Name</dhv:label>
    </td>
    <td>
      <input type="text" size="35" maxlength="80" name="nameMiddle" value="<%= toHtmlValue(ContactDetails.getNameMiddle()) %>">
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="accounts.accounts_add.LastName">Last Name</dhv:label>
    </td>
    <td>
      <input type="text" size="35" maxlength="80" name="nameLast" value="<%= toHtmlValue(ContactDetails.getNameLast()) %>">
      <font color="red">*</font> <%= showAttribute(request, "nameLastError") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      <dhv:label name="accounts.accounts_contacts_detailsimport.Company">Company</dhv:label>
    </td>
    <td>
      <input type="text" size="35" maxlength="255" name="company" value="<%= toHtmlValue(ContactDetails.getCompany()) %>">
      <font color="red">-</font> <%= showAttribute(request, "companyError") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="accounts.accounts_contacts_add.Title">Title</dhv:label>
    </td>
    <td>
      <input type="text" size="35" maxlength="80" name="title" value="<%= toHtmlValue(ContactDetails.getTitle()) %>">
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="contact.source">Source</dhv:label>
    </td>
    <td>
      <%= SourceList.getHtmlSelect("source",ContactDetails.getSource()) %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="sales.rating">Rating</dhv:label>
    </td>
    <td>
      <%= RatingList.getHtmlSelect("rating", ContactDetails.getRating()) %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="accounts.accounts_add.Industry">Industry</dhv:label>
    </td>
    <td>
      <%= IndustryList.getHtmlSelect("industryTempCode", ContactDetails.getIndustryTempCode()) %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="accounts.accounts_add.Potential">Potential</dhv:label>
    </td>
    <td>
      <%= applicationPrefs.get("SYSTEM.CURRENCY") %>
      <input type="text" name="potential" size="15" value="<%= (ContactDetails.getPotential() > -1?NumberFormat.getInstance(User.getLocale()).format(ContactDetails.getPotential()):"0") %>"/>
      <%= showAttribute(request, "potentialError") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <dhv:label name="campaign.comments">Comments</dhv:label>
    </td>
    <td>
      <textarea name="comments" rows="3" cols="50"><%= toString(ContactDetails.getComments()) %></textarea>
    </td>
  </tr>
</table>
&nbsp;<br>
<%--  include basic contact form --%>
<%@ include file="contact_include.jsp" %>
<br />
<input type="submit" value="<dhv:label name="global.button.save">Save</dhv:label>" onClick="this.form.dosubmit.value='true';">
<input type="submit" value="<dhv:label name="global.button.saveAndAddAnotherLead">Save and Add another Lead</dhv:label>" onClick="this.form.saveAndNew.value='true';this.form.dosubmit.value='true';">
<input type="submit" value="<dhv:label name="global.button.saveAndViewDetails">Save and View Details</dhv:label>" onClick="this.form.saveAndClone.value='true';this.form.dosubmit.value='true';">
<input type="hidden" name="dosubmit" value="true">
<%= addHiddenParams(request, "popup|popupType|actionId") %>
<iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>
</form>
</body>
