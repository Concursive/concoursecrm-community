<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.contacts.base.*, org.aspcfs.modules.admin.base.AccessType,org.aspcfs.utils.web.*" %>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="ContactTypeList" class="org.aspcfs.modules.contacts.base.ContactTypeList" scope="request"/>
<jsp:useBean id="DepartmentList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="UserList" class="org.aspcfs.modules.admin.base.UserList" scope="request"/>
<jsp:useBean id="AccessTypeList" class="org.aspcfs.modules.admin.base.AccessTypeList" scope="request"/>
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
<%
    for (int i=1; i<=(ContactDetails.getPhoneNumberList().size()+1); i++) {
%>
		<dhv:evaluate exp="<%=(i>1)%>">else </dhv:evaluate>if (!checkPhone(form.phone<%=i%>number.value)) { 
			message += "- At least one entered phone number is invalid.  Make sure there are no invalid characters and that you have entered the area code\r\n";
			formTest = false;
		}
<%
    }
    
    for (int i=1; i<=(ContactDetails.getEmailAddressList().size()+1); i++) {
%>
  <dhv:evaluate exp="<%=(i>1)%>">else </dhv:evaluate>if (!checkEmail(form.email<%=i%>address.value)) { 
      message += "- At least one entered email address is invalid.  Make sure there are no invalid characters\r\n";
      formTest = false;
    }
<%
    }

    if(ContactDetails.getOrgId() == -1){
%>

    if(document.forms[0].contactcategory[1].checked && document.forms[0].orgId.value == '-1') {
       message += "- Make sure you select an account.\r\n";
			 formTest = false;
    }
<%
  }
%>
  
    if (formTest == false) {
      alert("Form could not be saved, please check the following:\r\n\r\n" + message);
      return false;
    } else {
      var test = document.forms[0].selectedList;
      if (test != null) {
        return selectAllOptions(document.forms[0].selectedList);
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
  
   function updateCategoryInfo(category){
    if(category == "general"){
      document.forms[0].orgId.value = '-1';
      var url = "ExternalContacts.do?command=AccessTypeJSList&category=" + <%= AccessType.GENERAL_CONTACTS %>;
      window.frames['server_commands'].location.href=url;
    }else if(category == "account"){
      var url = "ExternalContacts.do?command=AccessTypeJSList&category=" + <%= AccessType.ACCOUNT_CONTACTS %>;
      window.frames['server_commands'].location.href=url;
    }else if(category == "employee"){
      document.forms[0].orgId.value = '-1';
      var url = "ExternalContacts.do?command=AccessTypeJSList&category=" + <%= AccessType.EMPLOYEES %>;
      window.frames['server_commands'].location.href=url;
    }
  }
  
  function selectAccount(){
   document.forms['addContact'].contactcategory[1].checked='t';
   updateCategoryInfo('account');
   popAccountsListSingle('orgId','changeaccount');
  }
  
</script>
<body onLoad="javascript:document.forms[0].nameFirst.focus();">
<%
  boolean popUp = false;
  if(request.getParameter("popup")!=null){
    popUp = true;
  }
%> 
  <form name="addContact" action="ExternalContacts.do?command=Save&auto-populate=true" onSubmit="return doCheck(this);" method="post">
  <dhv:evaluate exp="<%= !popUp %>">
  <a href="ExternalContacts.do">General Contacts</a> > 
  <% if (request.getParameter("return") != null) {%>
    <% if (request.getParameter("return").equals("list")) {%>
    <a href="ExternalContacts.do?command=SearchContacts">Search Results</a> >
    <%}%>
  <%} else {%>
  <a href="ExternalContacts.do?command=SearchContacts">Search Results</a> >
  <a href="ExternalContacts.do?command=ContactDetails&id=<%=ContactDetails.getId()%>">Contact Details</a> >
  <%}%>
  Modify Contact<br>
  <hr color="#BFBFBB" noshade>
  </dhv:evaluate>
<%@ include file="contact_details_header_include.jsp" %>
<% String param1 = "id=" + ContactDetails.getId(); 
   String param2 = addLinkParams(request, "popup|popupType|actionId"); %>
<dhv:container name="contacts" selected="details" param="<%= param1 %>" appendToUrl="<%= param2 %>" style="tabs"/>
<table cellpadding="4" cellspacing="0" border="0" width="100%">
  <tr>
    <td class="containerBack">
      <input type="submit" value="Update" name="Save" onClick="this.form.dosubmit.value='true';">
  <% if (request.getParameter("return") != null) {%>
    <% if (request.getParameter("return").equals("list")) {%>
      <input type="submit" value="Cancel" onClick="javascript:this.form.action='ExternalContacts.do?command=SearchContacts';this.form.dosubmit.value='false';">
    <%}%>
  <%} else {%>
      <input type="submit" value="Cancel" onClick="javascript:this.form.action='ExternalContacts.do?command=ContactDetails&id=<%= ContactDetails.getId() %>';this.form.dosubmit.value='false';">
  <% } %>
<input type=reset value="Reset">
<br>
<%= showError(request, "actionError") %>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong><%= ContactDetails.getId() > 0 ? "Update" : "Add" %> a Contact</strong>
    </th>
  </tr>
    <tr class="containerBody">
    <td class="formLabel" nowrap>
      Reassign To
    </td>
    <td>
      <%= UserList.getHtmlSelect("owner", ContactDetails.getOwner() ) %>
       <%= showAttribute(request, "accessReassignError") %>
    </td>
  </tr>
    <tr class="containerBody">
    <td class="formLabel" nowrap>
      Contact Category
    </td>
    <td>
     <dhv:evaluate if="<%= ContactDetails.getOrgId() == -1 %>">
        <input type="radio" name="contactcategory" value="1" onclick="javascript:document.forms[0].orgId.value = '-1';" onChange="javascript:updateCategoryInfo('general');" <%= ContactDetails.getOrgId() == -1 ? " checked":""%>>General Contact<br>
     </dhv:evaluate>
      <table cellspacing="0" cellpadding="0" border="0" class="empty">
          <tr>
            <td>
              <input type="radio" name="contactcategory" value="2" onChange="javascript:updateCategoryInfo('account');" <%= ContactDetails.getOrgId() > -1 ? " checked":""%>>
            </td>
            <td>
              Associated with Account: &nbsp;
            </td>
            <td>
              <div id="changeaccount"><%= ContactDetails.getOrgId() > -1 ? ContactDetails.getCompany() : "None Selected"%></div>
              <input type="hidden" name="orgId" id="orgId" value="<%= ContactDetails.getOrgId() %>">
            </td>
            <dhv:evaluate if="<%= ContactDetails.getOrgId() == -1 %>">
            <td>
              &nbsp;[<a href="javascript:selectAccount();">Select</a>]&nbsp;
            </td>
            </dhv:evaluate>
          </tr>
       </table>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Contact Type(s)
    </td>
    <td>
      <table border="0" cellspacing="0" cellpadding="0" class="empty">
        <tr>
          <td>
            <select multiple name="selectedList" id="selectedList" size="5">
          <%if(request.getAttribute("TypeList") != null){ %>
            <dhv:lookupHtml listName="TypeList" lookupName="ContactTypeList"/>
          <% }else{ %>
               <dhv:evaluate exp="<%= ContactDetails.getTypes().isEmpty() %>">
                  <option value="-1">None Selected</option>
                </dhv:evaluate>
                <dhv:evaluate exp="<%= !ContactDetails.getTypes().isEmpty() %>">
              <%
                Iterator i = ContactDetails.getTypes().iterator();
                while (i.hasNext()) {
                LookupElement thisElt = (LookupElement)i.next();
              %>
                <option value="<%= thisElt.getCode() %>"><%= thisElt.getDescription() %></option>
              <% } %>
              </dhv:evaluate>
           <% } %>
        </select>
            <input type="hidden" name="previousSelection" value="">
            <input type="hidden" name="category" value="<%= request.getParameter("category") %>">
          </td>
          <td valign="top">
            <%if(ContactDetails.getOrgId() == -1){%>
              &nbsp;[<a href="javascript:setCategoryPopContactType('selectedList', <%= ContactDetails.getId() %>);">Select</a>]
            <% }else{ %>
              &nbsp;[<a href="javascript:popContactTypeSelectMultiple('selectedList', 'accounts', <%= ContactDetails.getId() %>);">Select</a>]
           <% } %>
	   <%= showAttribute(request, "personalContactError") %>	
          </td>
        </tr>
      </table>
     </td>
  </tr>
  <tr class="containerBody"> 
  <td nowrap class="formLabel">
      Access Type
    </td>
    <td>
      <% 
          HtmlSelect thisSelect = AccessTypeList.getHtmlSelectObj(ContactDetails.getAccessType());
          thisSelect.addAttribute("id", "accessType");
      %>
      <%=  thisSelect.getHtml("accessType") %>
      <%= showAttribute(request, "accountAccessError") %>
      <iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>
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
      <td class="formLabel" nowrap>
        Company
      </td>
      <td>
        <% if(ContactDetails.getOrgId() > 0) {%>
          <div><%= toHtmlValue(ContactDetails.getCompany()) %></div>
          <input type="hidden" name="company" value="<%= toHtmlValue(ContactDetails.getCompany()) %>">
        <%}else{%>
          <input type="text" size="35" name="company" value="<%= toHtmlValue(ContactDetails.getCompany()) %>">
          <font color="red">-</font> <%= showAttribute(request, "lastcompanyError") %>
        <%}%>
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
&nbsp;<br>
<%--  include basic contact form --%>
<%@ include file="../contacts/contact_include.jsp" %>
<br>
  <input type="submit" value="Update" name="Save" onClick="this.form.dosubmit.value='true';">
  <% if (request.getParameter("return") != null) {%>
    <% if (request.getParameter("return").equals("list")) {%>
      <input type="submit" value="Cancel" onClick="javascript:this.form.action='ExternalContacts.do?command=SearchContacts';this.form.dosubmit.value='false';">
    <%}%>
  <% }else{ %>
    <input type="submit" value="Cancel" onClick="javascript:this.form.action='ExternalContacts.do?command=ContactDetails&id=<%= ContactDetails.getId() %>';this.form.dosubmit.value='false';">
  <% } %>
  <input type="reset" value="Reset">
    </td>
   </tr>
  </table>
<input type="hidden" name="source" value="<%= toHtmlValue(request.getParameter("source")) %>">
<input type="hidden" name="id" value="<%= ContactDetails.getId() %>">
<input type="hidden" name="primaryContact" value="<%=ContactDetails.getPrimaryContact()%>">
<input type="hidden" name="modified" value="<%= ContactDetails.getModified() %>">
<input type="hidden" name="dosubmit" value="true">
<input type="hidden" name="primaryContact" value="<%= ContactDetails.getPrimaryContact() %>">
<% if (request.getParameter("return") != null) {%>
<input type="hidden" name="return" value="<%= request.getParameter("return") %>">
<% } %>
</form>
</body>	
