<%-- 
  - Copyright(c) 2004 Concursive Corporation (http://www.concursive.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Concursive Corporation. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. CONCURSIVE
  - CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL CONCURSIVE CORPORATION OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id$
  - Description: 
  --%>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkDate.js"></script>
<script language="JavaScript">
  onLoad = 1;
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

    if (form.roleId.value < 1){ 
      message += label("PortalRole.required", "- Portal Role is required\r\n");
      formTest = false;
    }
    if (formTest == false) {
      alert(label("check.form", "Form could not be saved, please check the following:\r\n\r\n") + message);
      return false;
    }
  }
</script>
<input type="hidden" name="userId" value="<%=portalUserDetails.getId()%>">
<input type="hidden" name="enabled" value="<%=portalUserDetails.getEnabled()%>">
<input type="hidden" name="contactId" value="<%=ContactDetails.getId()%>">
<input type="hidden" name="orgId" value="<%=ContactDetails.getOrgId()%>">
<input type="hidden" name="dosubmit" value="true" />
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong><dhv:label name="contacts.details">Details</dhv:label></strong>
    </th>
  </tr>
  <dhv:evaluate if="<%= (portalUserDetails.getUsername() != null) %>" >
  <tr class="containerBody">
    <td class="formLabel">
      <dhv:label name="accounts.Username">Username</dhv:label>
    </td>
    <td>
      <%=portalUserDetails.getUsername()%>
    </td>
  </tr>
  </dhv:evaluate>
  <tr class="containerBody">
    <td class="formLabel">
      <dhv:label name="accounts.accounts_contacts_portal_include.PortalRole">Portal Role</dhv:label>
    </td>
    <td>
      <%= roleList.getHtmlSelect("roleId", portalUserDetails.getRoleId())%><font color="red">*</font>
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel">
      <dhv:label name="accounts.accountasset_include.ExpirationDate">Expiration Date</dhv:label>
    </td>
    <td>
      <zeroio:dateSelect form="contactPortal" field="expires" timestamp="<%= portalUserDetails.getExpires() %>" />
      <%= showAttribute(request, "expiresError") %>
    </td>
  </tr>
  <dhv:evaluate if="<%= (portalUserDetails.getId() != -1) %>" >
  <tr class="containerBody">
    <td class="formLabel" >
      <dhv:label name="accounts.accounts_contacts_portal_include.GenerateNewPassword">Generate new password</dhv:label>?
    </td>
    <td>
    <input type="checkbox" name="autoGenerate" value="on"  <%=("on".equals(request.getParameter("autoGenerate")) ? " checked" : "")%> ></input>
    </td>
  </tr>
  <input type="hidden" name="modified" value="<%=portalUserDetails.getModified()%>" />
  </dhv:evaluate>
  <tr class="containerBody">
    <td class="formLabel">
      <dhv:label name="accounts.accounts_add.Email">Email</dhv:label>
    </td>
    <td>
      <% 
        String tmpId = request.getParameter("emailAddressId");
        int emailId = -1;
        if ((tmpId != null) && (!"".equals(tmpId))){
          emailId = Integer.parseInt(tmpId);
        }
      %>
      <%= ContactDetails.getEmailAddressList().getHtmlSelect("emailAddressId", emailId)%><font color="red"> <dhv:label name="accounts.accounts_contacts_portal_include.LoginInformationSent">Login information would be sent to this email or to the primary email of the contact</dhv:label></font>
    </td>
  </tr>
</table>
