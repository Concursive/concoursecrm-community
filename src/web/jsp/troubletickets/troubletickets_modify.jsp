<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="org.aspcfs.modules.troubletickets.base.*,org.aspcfs.modules.communications.base.Campaign,org.aspcfs.modules.communications.base.CampaignList,org.aspcfs.utils.web.HtmlSelect" %>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.troubletickets.base.Ticket" scope="request"/>
<jsp:useBean id="DepartmentList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SeverityList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SourceList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="PriorityList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="CategoryList" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="UserList" class="org.aspcfs.modules.admin.base.UserList" scope="request"/>
<jsp:useBean id="SubList1" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="SubList2" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="SubList3" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="ContactList" class="org.aspcfs.modules.contacts.base.ContactList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>
<SCRIPT LANGUAGE="JavaScript">
function updateSubList1() {
  var sel = document.forms['details'].elements['catCode'];
  var value = sel.options[sel.selectedIndex].value;
  var url = "TroubleTickets.do?command=CategoryJSList&catCode=" + escape(value);
  window.frames['server_commands'].location.href=url;
}
function updateSubList2() {
  var sel = document.forms['details'].elements['subCat1'];
  var value = sel.options[sel.selectedIndex].value;
  var url = "TroubleTickets.do?command=CategoryJSList&subCat1=" + escape(value);
  window.frames['server_commands'].location.href=url;
}
function updateSubList3() {
  var sel = document.forms['details'].elements['subCat2'];
  var value = sel.options[sel.selectedIndex].value;
  var url = "TroubleTickets.do?command=CategoryJSList&subCat2=" + escape(value);
  window.frames['server_commands'].location.href=url;
}
function updateUserList() {
  var sel = document.forms['details'].elements['departmentCode'];
  var value = sel.options[sel.selectedIndex].value;
  var url = "TroubleTickets.do?command=DepartmentJSList&departmentCode=" + escape(value);
  window.frames['server_commands'].location.href=url;
}
</SCRIPT>
<body>
<form name="details" action="TroubleTickets.do?command=Update&auto-populate=true" method="post">
<%-- Trails --%>
<table class="trails">
<tr>
<td>
<a href="TroubleTickets.do">Help Desk</a> > 
<% if (request.getParameter("return") != null) {%>
	<% if (request.getParameter("return").equals("list")) {%>
	<a href="TroubleTickets.do?command=Home">View Tickets</a> >
  <%}%>
<%} else {%>
<a href="TroubleTickets.do?command=Home">View Tickets</a> >
<a href="TroubleTickets.do?command=Details&id=<%= TicketDetails.getId() %>">Ticket Details</a> >
<%}%>
Modify Ticket
</td>
</tr>
</table>
<%-- End Trails --%>
<strong>Ticket # <%= TicketDetails.getPaddedId() %><br>
<%= toHtml(TicketDetails.getCompanyName()) %></strong>
<dhv:evaluate if="<%= !(TicketDetails.getCompanyEnabled()) %>">
  <font color="red">(account disabled)</font>
</dhv:evaluate>
<iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>
<% String param1 = "id=" + TicketDetails.getId(); %>
<dhv:container name="tickets" selected="details" param="<%= param1 %>" style="tabs"/>
<table cellpadding="4" cellspacing="0" border="0" width="100%">
  <tr>
  	<td class="containerBack">
      <dhv:evaluate if="<%= TicketDetails.getClosed() != null %>">
        <font color="red">This ticket was closed on <%= toHtml(TicketDetails.getClosedString()) %></font><br>
        &nbsp;<br>
      </dhv:evaluate>
      <% if (TicketDetails.getClosed() != null) { %>
        <input type="button" value="Reopen">
        <input type="submit" value="Cancel" onClick="javascript:this.form.action='TroubleTickets.do?command=Details&id=<%= TicketDetails.getId() %>'">
      <%} else {%>
        <input type="submit" value="Update">
        <% if ("list".equals(request.getParameter("return"))) {%>
          <input type="submit" value="Cancel" onClick="javascript:this.form.action='TroubleTickets.do?command=Home'">
        <%} else {%>
          <input type="submit" value="Cancel" onClick="javascript:this.form.action='TroubleTickets.do?command=Details&id=<%= TicketDetails.getId() %>'">
        <%}%>
      <%}%>
      <br>
<%= showError(request, "actionError") %>
<% if (request.getAttribute("closedError") != null) { %>
  <%= showAttribute(request, "closedError") %>
<%}%>
  <table cellpadding="4" cellspacing="0" width="100%" class="details">
		<tr>
      <th colspan="2">
        <strong>Ticket Information</strong>
      </th>
		</tr>
		<tr class="containerBody">
      <td class="formLabel">
        Ticket Source
      </td>
      <td>
        <%= SourceList.getHtmlSelect("sourceCode",  TicketDetails.getSourceCode()) %>
      </td>
		</tr>
		<tr class="containerBody">
      <td class="formLabel">
        Contact
      </td>
      <td>
      <% if ( TicketDetails.getThisContact() == null ) {%>
        <%= ContactList.getHtmlSelect("contactId", 0 ) %>
      <%} else {%>
        <%= ContactList.getHtmlSelect("contactId", TicketDetails.getContactId() ) %>
      <%}%>
        <font color="red">*</font> <%= showAttribute(request, "contactIdError") %>
      </td>
		</tr>
  </table>
  <br>
  <a name="categories"></a> 
  <table cellpadding="4" cellspacing="0" width="100%" class="details">
		<tr>
      <th colspan="2">
        <strong>Classification</strong>
      </th>
		</tr>
		<tr class="containerBody">
      <td valign="top" class="formLabel">
        <dhv:label name="ticket.issue">Issue</dhv:label>
      </td>
      <td>
        <table border="0" cellspacing="0" cellpadding="0" class="empty">
          <tr>
            <td>
              <textarea name="problem" cols="55" rows="3"><%= toString(TicketDetails.getProblem()) %></textarea>
            </td>
            <td valign="top">
              <font color="red">*</font> <%= showAttribute(request, "problemError") %>
              <input type="hidden" name="modified" value="<%= TicketDetails.getModified() %>">
              <input type="hidden" name="orgId" value="<%=TicketDetails.getOrgId()%>">
              <input type="hidden" name="id" value="<%=TicketDetails.getId()%>">
              <input type="hidden" name="companyName" value="<%=toHtml(TicketDetails.getCompanyName())%>">
              <input type="hidden" name="refresh" value="-1">
            </td>
          </tr>
        </table>
		<% if (request.getParameter("return") != null) {%>
			<input type="hidden" name="return" value="<%=request.getParameter("return")%>">
		<%}%>
      </td>
		</tr>
    <tr class="containerBody">
      <td valign="top" class="formLabel">
        Location
      </td>
      <td>
        <input type="text" name="location" value="<%= toHtmlValue(TicketDetails.getLocation()) %>" size="50" maxlength="256" />
      </td>
    </tr>
  <dhv:include name="ticket.catCode" none="true">
		<tr class="containerBody">
      <td class="formLabel">
        Category
      </td>
      <td>
        <%= CategoryList.getHtmlSelect("catCode", TicketDetails.getCatCode()) %>
      </td>
		</tr>
  </dhv:include>
  <dhv:include name="ticket.subCat1" none="true">
		<tr class="containerBody">
      <td class="formLabel">
        Sub-level 1
      </td>
      <td>
        <%= SubList1.getHtmlSelect("subCat1", TicketDetails.getSubCat1()) %>
      </td>
		</tr>
  </dhv:include>
  <dhv:include name="ticket.subCat2" none="true">
		<tr class="containerBody">
      <td class="formLabel">
        Sub-level 2
      </td>
      <td>
        <%= SubList2.getHtmlSelect("subCat2", TicketDetails.getSubCat2()) %>
      </td>
		</tr>
  </dhv:include>
  <dhv:include name="ticket.subCat3" none="true">
		<tr class="containerBody">
      <td class="formLabel">
        Sub-level 3
      </td>
      <td>
        <%= SubList3.getHtmlSelect("subCat3", TicketDetails.getSubCat3()) %>
      </td>
		</tr>
  </dhv:include>
  <dhv:include name="ticket.severity" none="true">
		<tr class="containerBody">
      <td class="formLabel">
        Severity
      </td>
      <td>
        <%= SeverityList.getHtmlSelect("severityCode", TicketDetails.getSeverityCode()) %>
      </td>
		</tr>
  </dhv:include>
  </table>
  <br>
  <table cellpadding="4" cellspacing="0" width="100%" class="details">
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
        <%= PriorityList.getHtmlSelect("priorityCode", TicketDetails.getPriorityCode()) %>
      </td>
		</tr>
  </dhv:include>
		<tr class="containerBody">
      <td class="formLabel">
        Department
      </td>
      <td>
        <%= DepartmentList.getHtmlSelect("departmentCode", TicketDetails.getDepartmentCode()) %>
      </td>
		</tr>
		<tr class="containerBody">
      <td nowrap class="formLabel">
        Resource Assigned
      </td>
      <td>
        <%= UserList.getHtmlSelect("assignedTo", TicketDetails.getAssignedTo() ) %>
      </td>
		</tr>
    <tr class="containerBody">
      <td nowrap class="formLabel">
        Assignment Date
      </td>
      <td>
        <input type="text" size="10" name="assignedDate" value="<dhv:tz timestamp="<%= TicketDetails.getAssignedDate() %>" dateOnly="true" dateFormat="<%= DateFormat.SHORT %>"/>">
        <a href="javascript:popCalendar('details', 'assignedDate');"><img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle" height="16" width="16"/></a> (mm/dd/yyyy)
      </td>
    </tr>
    <tr class="containerBody">
      <td class="formLabel">
        Estimated Resolution Date
      </td>
      <td>
        <input type="text" size="10" name="estimatedResolutionDate" value="<dhv:tz timestamp="<%= TicketDetails.getEstimatedResolutionDate() %>" dateOnly="true" dateFormat="<%= DateFormat.SHORT %>"/>">
        <a href="javascript:popCalendar('details', 'estimatedResolutionDate');"><img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle" height="16" width="16"/></a> (mm/dd/yyyy)
      </td>
    </tr>
		<tr class="containerBody">
      <td valign="top" class="formLabel">
        Issue Notes
      </td>
      <td>
        <textarea name="comment" cols="55" rows="3"><%= toString(TicketDetails.getComment()) %></textarea>
      </td>
		</tr>
  </table>
  <br>
  <table cellpadding="4" cellspacing="0" width="100%" class="details">
    <tr>
      <th colspan="2">
        <strong>Resolution</strong>
      </th>
		</tr>
    <tr class="containerBody">
      <td valign="top" class="formLabel">
        Cause
      </td>
      <td>
        <textarea name="cause" cols="55" rows="3"><%= toString(TicketDetails.getCause()) %></textarea>
      </td>
		</tr>
		<tr class="containerBody">
      <td valign="top" class="formLabel">
        Resolution
      </td>
      <td>
        <textarea name="solution" cols="55" rows="3"><%= toString(TicketDetails.getSolution()) %></textarea><br>
        <input type="checkbox" name="closeNow">Close ticket
        <%--
        <br>
        <input type="checkbox" name="kbase">Add this solution to Knowledge Base
        --%>
<%-- Added for voice demo, will show a list of surveys that can be emailed... --%>
<%--
<%
        CampaignList campaignList = (CampaignList) request.getAttribute("CampaignList");
        if (campaignList != null && campaignList.size() > 0) {
          HtmlSelect campaignSelect = new HtmlSelect();
          campaignSelect.addItem(-1, "-- None --");
          Iterator campaigns = campaignList.iterator();
          while (campaigns.hasNext()) {
            Campaign thisCampaign = (Campaign)campaigns.next();
            campaignSelect.addItem(thisCampaign.getId(), thisCampaign.getName());
          }
%>
        <br>Send contact a follow-up message: <%= campaignSelect.getHtml("campaignId", TicketDetails.getCampaignId()) %>
<%
        }
%>
--%>
<%-- End voice demo --%>
      </td>
		</tr>
    <tr class="containerBody">
      <td class="formLabel">
        Resolution Date
      </td>
      <td>
        <input type="text" size="10" name="resolutionDate" value="<dhv:tz timestamp="<%= TicketDetails.getResolutionDate() %>" dateOnly="true" dateFormat="<%= DateFormat.SHORT %>"/>">
        <a href="javascript:popCalendar('details', 'resolutionDate');"><img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle" height="16" width="16"/></a> (mm/dd/yyyy)
      </td>
    </tr>
	</table>
&nbsp;<br>
<% if (TicketDetails.getClosed() != null) { %>
  <input type="button" value="Reopen">
<%} else {%>
  <input type="submit" value="Update">
<%}%>
<% if (request.getParameter("return") != null) {%>
	<% if (request.getParameter("return").equals("list")) {%>
	<input type="submit" value="Cancel" onClick="javascript:this.form.action='TroubleTickets.do?command=Home'">
	<%}%>
<%} else {%>
	<input type="submit" value="Cancel" onClick="javascript:this.form.action='TroubleTickets.do?command=Details&id=<%= TicketDetails.getId() %>'">
<%}%>
  </td>
  </tr>
</table>
</form>
</body>
