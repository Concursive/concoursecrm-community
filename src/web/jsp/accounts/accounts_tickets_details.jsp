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
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.troubletickets.base.*, org.aspcfs.modules.base.*" %>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.troubletickets.base.Ticket" scope="request"/>
<jsp:useBean id="product" class="org.aspcfs.modules.products.base.ProductCatalog" scope="request"/>
<jsp:useBean id="customerProduct" class="org.aspcfs.modules.products.base.CustomerProduct" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<%@ include file="../initPage.jsp" %>
<form name="details" action="AccountTickets.do?command=ModifyTicket&auto-populate=true" method="post">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Accounts.do"><dhv:label name="accounts.accounts">Accounts</dhv:label></a> > 
<a href="Accounts.do?command=Search">Search Results</a> >
<a href="Accounts.do?command=Details&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="accounts.details">Account Details</dhv:label></a> >
<a href="Accounts.do?command=ViewTickets&orgId=<%=TicketDetails.getOrgId()%>"><dhv:label name="accounts.tickets.tickets">Tickets</dhv:label></a> >
<dhv:label name="accounts.tickets.details">Ticket Details</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<%-- Begin container --%>
<%@ include file="accounts_details_header_include.jsp" %>
<% String param1 = "orgId=" + TicketDetails.getOrgId(); %>      
<dhv:container name="accounts" selected="tickets" param="<%= param1 %>" style="tabs"/>
<table cellpadding="4" cellspacing="0" border="0" width="100%">
  <tr>
  	<td class="containerBack">
      <%-- Begin container content --%>
        <%@ include file="accounts_ticket_header_include.jsp" %>
        <% String param2 = "id=" + TicketDetails.getId(); %>
        [ <dhv:container name="accountstickets" selected="details" param="<%= param2 %>"/> ]
      <br />
      <br />
       <% if (TicketDetails.getClosed() != null) { %>
              <dhv:permission name="accounts-accounts-tickets-edit"><input type="button" value="Reopen" onClick="javascript:this.form.action='AccountTickets.do?command=ReopenTicket&id=<%=TicketDetails.getId()%>';submit();"> </dhv:permission>
        <%} else {%>
              <dhv:permission name="accounts-accounts-tickets-edit"><input type="button" value="Modify" onClick="javascript:this.form.action='AccountTickets.do?command=ModifyTicket&id=<%=TicketDetails.getId()%>';submit();"></dhv:permission>
              <dhv:permission name="accounts-accounts-tickets-delete"><input type="button" value="Delete" onClick="javascript:popURL('AccountTickets.do?command=ConfirmDelete&orgId=<%= TicketDetails.getOrgId() %>&id=<%= TicketDetails.getId() %>&popup=true', 'Delete_ticket','320','200','yes','no');"></dhv:permission>
        <%}%>
        <dhv:permission name="quotes-view">
          <dhv:evaluate if="<%= TicketDetails.getProductId() > 0 %>">
            <input type="button" value="Generate Quote" onClick="javascript:this.form.action='Quotes.do?command=Display&productId=<%= thisTicket.getProductId() %>&ticketId=<%= thisTicket.getId() %>';submit();"/>
          </dhv:evaluate>
        </dhv:permission>
        <dhv:permission name="accounts-accounts-tickets-edit,accounts-accounts-tickets-delete"><br />&nbsp;</dhv:permission>
        <%-- Primary Contact --%>
        <%
          if (TicketDetails.getThisContact() != null ) {
        %>
        <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
          <tr>
            <th colspan="2">
              <strong>Primary Contact</strong>
            </th>     
          </tr>
          <tr class="containerBody">
            <td class="formLabel">
              Name
            </td>
            <td>
              <%= toHtml(TicketDetails.getThisContact().getNameLastFirst()) %>
            </td>
          </tr>
          <tr class="containerBody">
            <td class="formLabel">
              Title
            </td>
            <td>
              <%=toHtml(TicketDetails.getThisContact().getTitle())%>
            </td>
          </tr>
          <tr class="containerBody">
            <td class="formLabel">
              Email
            </td>
            <td>
              <%= TicketDetails.getThisContact().getEmailAddressTag("Business", toHtml(TicketDetails.getThisContact().getEmailAddress("Business")), "&nbsp;") %>
            </td>
          </tr>
          <tr class="containerBody">
            <td class="formLabel">
              Phone
            </td>
            <td>
              <%= toHtml(TicketDetails.getThisContact().getPhoneNumber("Business")) %>
            </td>
          </tr>
        </table>
        <br />
        <%}%>
        <%-- Ticket Information --%>
        <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
          <tr>
            <th colspan="2">
              <strong><dhv:label name="accounts.tickets.information">Ticket Information</dhv:label></strong>
            </th>     
          </tr>
          <tr class="containerBody">
            <td class="formLabel">
              <dhv:label name="accounts.tickets.source">Ticket Source</dhv:label>
            </td>
            <td>
              <%= toHtml(TicketDetails.getSourceName()) %>
            </td>
            </tr>
            <tr class="containerBody">
              <td nowrap class="formLabel">
                Service Contract Number
              </td>
              <td>
                <%= toHtml(TicketDetails.getServiceContractNumber()) %>
              </td>
            </tr>
            <tr class="containerBody">
              <td nowrap class="formLabel">
                Asset Serial Number
              </td>
              <td>
                <%= toHtml(TicketDetails.getAssetSerialNumber()) %>
              </td>
            </tr>
            <dhv:evaluate if="<%= TicketDetails.getProductId() != -1 %>">
            <tr class="containerBody">
              <td nowrap class="formLabel">
                Labor Category
              </td>
              <td>
                <%= toHtml(product.getSku()) %>:&nbsp;<%= toHtml(product.getName()) %>
<%
                    if(!"".equals(product.getShortDescription()) && (product.getShortDescription() != null)){
%>
                / <%= toHtml(product.getShortDescription()) %>
<%
    }
%>
              </td>
            </tr>
            </dhv:evaluate>
            <dhv:evaluate if="<%= TicketDetails.getCustomerProductId() != -1 %>">
            <tr class="containerBody">
              <td nowrap class="formLabel">
                Customer Product
              </td>
              <td>
                <%= toHtml(customerProduct.getDescription()) %> <input type="button" value="Display" onClick="javascript:popURL('Publish.do?command=DisplayCustomerProduct&adId=<%= customerProduct.getId() %>&ticketId=<%= TicketDetails.getId() %>','Customer Product','500','200','yes','yes');"/>
              </td>
            </tr>
            </dhv:evaluate>
            <tr class="containerBody">
              <td valign="top" class="formLabel">
                <dhv:label name="ticket.issue">Issue</dhv:label>
              </td>
            <td>
              <%= toHtml(TicketDetails.getProblem()) %>
              <input type="hidden" name="problem" value="<%= toHtml(TicketDetails.getProblem()) %>">
              <input type="hidden" name="orgId" value="<%= TicketDetails.getOrgId() %>">
              <input type="hidden" name="id" value="<%= TicketDetails.getId() %>">
            </td>
          </tr>
          <tr class="containerBody">
            <td class="formLabel">
              Location
            </td>
            <td>
              <%= toHtml(TicketDetails.getLocation()) %>
            </td>
          </tr>
        <dhv:include name="ticket.catCode" none="true">
          <tr class="containerBody">
            <td class="formLabel">
              Category
            </td>
            <td>
              <%=toHtml(TicketDetails.getCategoryName())%>
            </td>
          </tr>
        </dhv:include>
        <dhv:include name="ticket.severity" none="true">
          <tr class="containerBody">
            <td class="formLabel">
              Severity
            </td>
            <td>
              <%=toHtml(TicketDetails.getSeverityName())%>
            </td>
          </tr>
        </dhv:include>
          <tr class="containerBody">
            <td class="formLabel">
              Entered
            </td>
            <td>
              <dhv:username id="<%= TicketDetails.getEnteredBy() %>"/>
              <zeroio:tz timestamp="<%= TicketDetails.getEntered() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="true" />
            </td>
          </tr>
          <tr class="containerBody">
            <td class="formLabel">
              Modified
            </td>
            <td>
              <dhv:username id="<%= TicketDetails.getModifiedBy() %>"/>
              <zeroio:tz timestamp="<%= TicketDetails.getModified() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="true" />
            </td>
          </tr>
        </table>
        <br />
        <%-- Assignment --%>
        <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
          <tr>
            <th colspan="2">
              <strong>Assignment</strong>
            </th>
          </tr>
          <dhv:include name="ticket.priority" none="true">
          <tr class="containerBody">
            <td class="formLabel">
              Priority
            </td>
            <td>
              <%=toHtml(TicketDetails.getPriorityName())%>
            </td>
          </tr>
          </dhv:include>
          <tr class="containerBody">
            <td class="formLabel">
              Department
            </td>
            <td>
              <%= toHtml(TicketDetails.getDepartmentCode() > 0 ? TicketDetails.getDepartmentName() : "-- unassigned --") %>
            </td>
          </tr>
          <tr class="containerBody">
            <td class="formLabel">
              Resource Assigned
            </td>
            <td>
              <dhv:username id="<%= TicketDetails.getAssignedTo() %>" default="-- unassigned --"/>
              <dhv:evaluate if="<%= !(TicketDetails.getHasEnabledOwnerAccount()) %>"><font color="red">*</font></dhv:evaluate>
            </td>
          </tr>
          <tr class="containerBody">
            <td nowrap class="formLabel">
              Assignment Date
            </td>
            <td>
            <zeroio:tz timestamp="<%= TicketDetails.getAssignedDate() %>" dateOnly="true" timeZone="<%= TicketDetails.getAssignedDateTimeZone() %>" showTimeZone="true" default="&nbsp;"/>
            <% if (!User.getTimeZone().equals(TicketDetails.getAssignedDateTimeZone())) { %>
            <br />
            <zeroio:tz timestamp="<%= TicketDetails.getAssignedDate() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="true" default="&nbsp;"/>
            <% } %>
            </td>
          </tr>
          <tr class="containerBody">
            <td class="formLabel">
              Estimated Resolution Date
            </td>
            <td>
              <zeroio:tz timestamp="<%= TicketDetails.getEstimatedResolutionDate() %>" dateOnly="true" timeZone="<%= TicketDetails.getEstimatedResolutionDateTimeZone() %>" showTimeZone="true"  default="&nbsp;"/>
              <% if(!User.getTimeZone().equals(TicketDetails.getEstimatedResolutionDateTimeZone())){%>
              <br>
              <zeroio:tz timestamp="<%= TicketDetails.getEstimatedResolutionDate() %>" default="&nbsp;" timeZone="<%= User.getTimeZone() %>" showTimeZone="true"  default="&nbsp;" />
              <% } %>
            </td>
          </tr>
          <tr class="containerBody">
            <td class="formLabel">
              Issue Notes
            </td>
            <td>
              <font color="red"><dhv:label name="accounts.tickets.ticket.previousTicket">(Previous notes for this ticket are listed under the history tab.)</dhv:label></font>
            </td>
          </tr>
        </table>
        <br />
        <%-- Resolution --%>
        <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
          <tr>
            <th colspan="2">
              <strong>Resolution</strong>
            </th>     
          </tr>
          <tr class="containerBody">
            <td class="formLabel" valign="top">
              Cause
            </td>
            <td>
              <%= toHtml(TicketDetails.getCause()) %>
            </td>
          </tr>
          <tr class="containerBody">
            <td class="formLabel" valign="top">
              Resolution
            </td>
            <td>
              <%= toHtml(TicketDetails.getSolution()) %>
            </td>
          </tr>
          <tr class="containerBody">
            <td class="formLabel">
              Resolution Date
            </td>
            <td>
            <zeroio:tz timestamp="<%= TicketDetails.getResolutionDate() %>" dateOnly="true" timeZone="<%= TicketDetails.getResolutionDateTimeZone() %>" showTimeZone="true" default="&nbsp;"/>
            <% if (!User.getTimeZone().equals(TicketDetails.getResolutionDateTimeZone())) { %>
            <br />
            <zeroio:tz timestamp="<%= TicketDetails.getResolutionDate() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="true" default="&nbsp;"/>
            <% } %>
            </td>
          </tr>
          <tr class="containerBody">
            <td class="formLabel">
              Have our services met or exceeded your expectations?
            </td>
            <td>
              <dhv:evaluate if="<%= TicketDetails.getExpectation() == 1 %>">
                Yes
              </dhv:evaluate>
              <dhv:evaluate if="<%= TicketDetails.getExpectation() == 0 %>">
                No
              </dhv:evaluate>
              <dhv:evaluate if="<%= TicketDetails.getExpectation() == -1 %>">
                Undecided
              </dhv:evaluate>
            </td>
          </tr>
        </table>
        &nbsp;
        <dhv:permission name="accounts-accounts-tickets-edit,accounts-accounts-tickets-delete"><br /></dhv:permission>
        <% if (TicketDetails.getClosed() != null) { %>
              <dhv:permission name="accounts-accounts-tickets-edit"><input type="button" value="Reopen" onClick="javascript:this.form.action='AccountTickets.do?command=ReopenTicket&id=<%=TicketDetails.getId()%>';submit();"></dhv:permission>
        <%} else {%>
              <dhv:permission name="accounts-accounts-tickets-edit"><input type="button" value="Modify" onClick="javascript:this.form.action='AccountTickets.do?command=ModifyTicket&id=<%=TicketDetails.getId()%>';submit();"></dhv:permission>
              <dhv:permission name="accounts-accounts-tickets-delete"><input type="button" value="Delete" onClick="javascript:popURL('AccountTickets.do?command=ConfirmDelete&orgId=<%=TicketDetails.getOrgId()%>&id=<%=TicketDetails.getId()%>&popup=true', 'Delete_ticket','320','200','yes','no');"></dhv:permission>
        <%}%>
        <dhv:permission name="quotes-view">
          <dhv:evaluate if="<%= TicketDetails.getProductId() > 0 %>">
            <input type="button" value="Generate Quote" onClick="javascript:this.form.action='Quotes.do?command=Display&productId=<%= thisTicket.getProductId() %>&ticketId=<%= thisTicket.getId() %>';submit();"/>
          </dhv:evaluate>
        </dhv:permission>
      </td>
    </tr>
  </table>
</form>
