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
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.contacts.base.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="opportunityHeader" class="org.aspcfs.modules.pipeline.base.OpportunityHeader" scope="request"/>
<jsp:useBean id="oppComponentDetails" class="org.aspcfs.modules.pipeline.base.OpportunityComponent" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></script>
<form name="componentDetails" action="ExternalContactsOpps.do?command=ModifyComponent&id=<%= oppComponentDetails.getId() %>" method="post">
<dhv:evaluate exp="<%= !isPopup(request) %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="ExternalContacts.do">Contacts</a> > 
<a href="ExternalContacts.do?command=SearchContacts">Search Results</a> >
<a href="ExternalContacts.do?command=ContactDetails&id=<%= ContactDetails.getId() %>">Contact Details</a> >
<a href="ExternalContactsOpps.do?command=ViewOpps&contactId=<%= ContactDetails.getId() %>">Opportunities</a> >
<a href="ExternalContactsOpps.do?command=DetailsOpp&headerId=<%= oppComponentDetails.getHeaderId() %>&contactId=<%= ContactDetails.getId() %>">Opportunity Details</a> >
Component Details
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>
<%@ include file="contact_details_header_include.jsp" %>
<% String param1 = "id=" + ContactDetails.getId(); 
   String param2 = addLinkParams(request, "popup|popupType|actionId"); %>
<dhv:container name="contacts" selected="opportunities" param="<%= param1 %>" appendToUrl="<%= param2 %>" style="tabs"/>
<table cellpadding="4" cellspacing="0" border="0" width="100%">
  <tr>
    <td class="containerBack">
      <%-- Begin container content --%>
      <img src="images/icons/stock_form-currency-field-16.gif" border="0" align="absmiddle">
      <strong><%= toHtml(opportunityHeader.getDescription()) %></strong>
      <% FileItem thisFile = new FileItem(); %>
      <dhv:evaluate if="<%= opportunityHeader.hasFiles() %>">
        <%= thisFile.getImageTag() %>
      </dhv:evaluate>
      <dhv:permission name="contacts-external_contacts-opportunities-edit,contacts-external_contacts-opportunities-delete">
      <br>
      <br>
      </dhv:permission>
<dhv:sharing primaryBean="opportunityHeader" secondaryBeans="ContactDetails" action="edit"><input type="button" value="Modify" onClick="javascript:this.form.action='ExternalContactsOppComponents.do?command=ModifyComponent&id=<%= oppComponentDetails.getId() %>&headerId=<%= oppComponentDetails.getHeaderId() %>&contactId=<%= ContactDetails.getId() %>';submit();"></dhv:sharing>
<dhv:sharing primaryBean="opportunityHeader" secondaryBeans="ContactDetails" action="delete"><input type="button" value="Delete" onClick="javascript:popURLReturn('ExternalContactsOppComponents.do?command=ConfirmComponentDelete&contactId=<%= ContactDetails.getId() %>&id=<%= oppComponentDetails.getId() %>&popup=true<%= addLinkParams(request, "popupType|actionId") %>','ExternalContactsOpps.do?command=DetailsOpp&contactId=<%= ContactDetails.getId() %>', 'Delete_opp','320','200','yes','no')"></dhv:sharing>
<dhv:permission name="contacts-external_contacts-opportunities-edit,contacts-external_contacts-opportunities-delete">
<br>&nbsp;
</dhv:permission>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong><%= toHtml(oppComponentDetails.getDescription()) %></strong>
    </th>
  </tr>  
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Owner
    </td>
    <td valign="center">
      <dhv:username id="<%= oppComponentDetails.getOwner() %>"/>
      <dhv:evaluate exp="<%= !(oppComponentDetails.getHasEnabledOwnerAccount()) %>"><font color="red">*</font></dhv:evaluate>
    </td>
  </tr>
  <dhv:evaluate exp="<%= hasText(oppComponentDetails.getTypes().valuesAsString()) %>">
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Opportunity Type(s)
    </td>
    <td>  
      <%= toHtml(oppComponentDetails.getTypes().valuesAsString()) %>
     </td>
  </tr>
  </dhv:evaluate>  
  <dhv:evaluate exp="<%= hasText(oppComponentDetails.getNotes()) %>">
  <tr class="containerBody">
    <td valign="top" nowrap class="formLabel">Additional Notes</td>
    <td valign="top"><%= toHtml(oppComponentDetails.getNotes()) %></td>
  </tr>
  </dhv:evaluate>
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Prob. of Close
    </td>
    <td>
      <%= oppComponentDetails.getCloseProbValue() %>%
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Est. Close Date
    </td>
    <td>
      <zeroio:tz timestamp="<%= oppComponentDetails.getCloseDate() %>" dateOnly="true" timeZone="<%= oppComponentDetails.getCloseDateTimeZone() %>" showTimeZone="yes" default="&nbsp;"/>
      <% if(!User.getTimeZone().equals(oppComponentDetails.getCloseDateTimeZone())){%>
      <br />
      <zeroio:tz timestamp="<%= oppComponentDetails.getCloseDate() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="yes" default="&nbsp;"/>
      <% } %>
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Low Estimate
    </td>
    <td>
      <zeroio:currency value="<%= oppComponentDetails.getLow() %>" code="<%= applicationPrefs.get("SYSTEM.CURRENCY") %>" locale="<%= User.getLocale() %>" default="&nbsp;"/>
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Best Guess
    </td>
    <td>
      <zeroio:currency value="<%= oppComponentDetails.getGuess() %>" code="<%= applicationPrefs.get("SYSTEM.CURRENCY") %>" locale="<%= User.getLocale() %>" default="&nbsp;"/>
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      High Estimate
    </td>
    <td>
      <zeroio:currency value="<%= oppComponentDetails.getHigh() %>" code="<%= applicationPrefs.get("SYSTEM.CURRENCY") %>" locale="<%= User.getLocale() %>" default="&nbsp;"/>
    </td>
  </tr>  
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Est. Term
    </td>
    <td>
      <%= oppComponentDetails.getTerms() %> months
    </td>
  </tr>  
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Current Stage
    </td>
    <td>
      <%= toHtml(oppComponentDetails.getStageName()) %>&nbsp;
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Current Stage Date
    </td>
    <td>
      <zeroio:tz timestamp="<%= oppComponentDetails.getStageDate() %>" dateOnly="true" default="&nbsp;"/>
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Est. Commission
    </td>
    <td>
      <%= oppComponentDetails.getCommissionValue() %>%
    </td>
  </tr>
<dhv:evaluate exp="<%= hasText(oppComponentDetails.getAlertText()) %>">
   <tr class="containerBody">
    <td class="formLabel" nowrap>
      Alert Description
    </td>
    <td>
       <%= toHtml(oppComponentDetails.getAlertText()) %>
    </td>
  </tr>
</dhv:evaluate>
<dhv:evaluate exp="<%= oppComponentDetails.getAlertDate() != null %>">
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Alert Date
    </td>
    <td>
      <zeroio:tz timestamp="<%= oppComponentDetails.getAlertDate() %>" dateOnly="true" timeZone="<%= oppComponentDetails.getAlertDateTimeZone() %>" showTimeZone="yes"  default="&nbsp;"/>
      <% if(!User.getTimeZone().equals(oppComponentDetails.getAlertDateTimeZone())){%>
      <br>
      <zeroio:tz timestamp="<%= oppComponentDetails.getAlertDate() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="yes"  default="&nbsp;" />
      <% } %>
    </td>
  </tr>
</dhv:evaluate>  
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Entered
    </td>
    <td>
      <dhv:username id="<%= oppComponentDetails.getEnteredBy() %>"/>
      <zeroio:tz timestamp="<%= oppComponentDetails.getEntered() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="yes" />
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Modified
    </td>
    <td>
      <dhv:username id="<%= oppComponentDetails.getModifiedBy() %>"/>
      <zeroio:tz timestamp="<%= oppComponentDetails.getModified() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="yes" />
    </td>
  </tr>
</table>
<dhv:permission name="contacts-external_contacts-opportunities-edit,contacts-external_contacts-opportunities-delete"><br></dhv:permission>
<dhv:sharing primaryBean="opportunityHeader" secondaryBeans="ContactDetails" action="edit"><input type="button" value="Modify" onClick="javascript:this.form.action='ExternalContactsOppComponents.do?command=ModifyComponent&id=<%= oppComponentDetails.getId() %>&headerId=<%= oppComponentDetails.getHeaderId() %>&contactId=<%= ContactDetails.getId() %>';submit();"></dhv:sharing>
<dhv:sharing primaryBean="opportunityHeader" secondaryBeans="ContactDetails" action="delete"><input type="button" value="Delete" onClick="javascript:popURLReturn('ExternalContactsOppComponents.do?command=ConfirmComponentDelete&contactId=<%= ContactDetails.getId() %>&id=<%= oppComponentDetails.getId() %>&popup=true<%= addLinkParams(request, "popupType|actionId") %>','ExternalContactsOpps.do?command=DetailsOpp&contactId=<%= ContactDetails.getId() %>', 'Delete_opp','320','200','yes','no')"></dhv:sharing>
<dhv:permission name="contacts-external_contacts-opportunities-edit,contacts-external_contacts-opportunities-delete"></dhv:permission></td>
</td></tr>
</table>
<input type="hidden" name="headerId" value="<%= oppComponentDetails.getHeaderId() %>">
<input type="hidden" name="id" value="<%= oppComponentDetails.getId() %>">
<input type="hidden" name="contactId" value="<%= ContactDetails.getId() %>">
<input type="hidden" name="actionSource" value="ExternalContactsOppComponents">
<%= addHiddenParams(request, "popup|popupType|actionId") %>
</form>
