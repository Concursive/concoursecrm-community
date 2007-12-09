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
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="Message" class="org.aspcfs.modules.communications.base.Message" scope="request"/>
<jsp:useBean id="bcc" class="java.lang.String" scope="request"/>
<jsp:useBean id="cc" class="java.lang.String" scope="request"/>
<jsp:useBean id="commandName" class="java.lang.String" scope="request"/>
<%@ include file="../initPage.jsp" %>
<dhv:evaluate if="<%= !isPopup(request) %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="ExternalContacts.do"><dhv:label name="Contacts" mainMenuItem="true">Contacts</dhv:label></a> >
<a href="ExternalContacts.do?command=SearchContacts"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
<a href="ExternalContacts.do?command=ContactDetails&id=<%=ContactDetails.getId()%>"><dhv:label name="accounts.accounts_contacts_add.ContactDetails">Contact Details</dhv:label></a> >
<a href="ExternalContacts.do?command=ViewMessages&contactId=<%= ContactDetails.getId() %>"><dhv:label name="accounts.Messages">Messages</dhv:label></a> >
<dhv:label name="contacts.messageConfirmation">Message Confirmation</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>
<% if (commandName != null && !"".equals(commandName) && commandName.equals("executeCommandPrepareQuickMessage") ) { %>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th>
      <dhv:label name="actionList.messageSentToContacts.text">Your message has been queued and will be sent to the following contacts:</dhv:label>
    </th>
  </tr>
  <tr class="row2">
    <td>
      <%= ContactDetails.getNameFull() %> (<%= ContactDetails.getPrimaryEmailAddress() %>)
    </td>
  </tr>
  <dhv:evaluate if='<%= cc != null && !"".equals(cc) %>'>
  <tr class="row2">
    <td>
      <dhv:label name="quotes.cc">CC</dhv:label>: <%= toHtml(cc) %>
    </td>
  </tr>
  </dhv:evaluate>
  <dhv:evaluate if='<%= bcc != null && !"".equals(bcc) %>'>
  <tr class="row2">
    <td>
      <dhv:label name="quotes.bcc">BCC</dhv:label>: <%= toHtml(bcc) %>
    </td>
  </tr>
  </dhv:evaluate>
</table>
<% } else { %>
<dhv:container name="contacts" selected="messages" object="ContactDetails" param='<%= "id=" + ContactDetails.getId() %>' appendToUrl='<%= addLinkParams(request, "popup|popupType|actionId") %>'>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th>
      <dhv:label name="actionList.messageSentToContacts.text">Your message has been queued and will be sent to the following contacts:</dhv:label>
    </th>
  </tr>
  <tr class="row2">
    <td>
      <%= ContactDetails.getNameFull() %> (<%= ContactDetails.getPrimaryEmailAddress() %>)
    </td>
  </tr>
  <dhv:evaluate if='<%= cc != null && !"".equals(cc) %>'>
  <tr class="row2">
    <td>
      <dhv:label name="quotes.cc">CC</dhv:label>: <%= toHtml(cc) %>
    </td>
  </tr>
  </dhv:evaluate>
  <dhv:evaluate if='<%= bcc != null && !"".equals(bcc) %>'>
  <tr class="row2">
    <td>
      <dhv:label name="quotes.bcc">BCC</dhv:label>: <%= toHtml(bcc) %>
    </td>
  </tr>
  </dhv:evaluate>
</table>
</dhv:container>
<% } %>