<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.troubletickets.base.*" %>
<jsp:useBean id="DepartmentList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="CategoryList" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="TicketDetails" class="org.aspcfs.modules.troubletickets.base.Ticket" scope="request"/>
<jsp:useBean id="PriorityList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SeverityList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="SourceList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="OrgList" class="org.aspcfs.modules.accounts.base.OrganizationList" scope="request"/>
<jsp:useBean id="SubList1" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="SubList2" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="SubList3" class="org.aspcfs.modules.troubletickets.base.TicketCategoryList" scope="request"/>
<jsp:useBean id="UserList" class="org.aspcfs.modules.admin.base.UserList" scope="request"/>
<jsp:useBean id="ContactList" class="org.aspcfs.modules.contacts.base.ContactList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="/javascript/checkPhone.js"></script>
<script language="JavaScript">
  function updateSubList1() {
    var sel = document.forms['addticket'].elements['catCode'];
    var value = sel.options[sel.selectedIndex].value;
    var url = "TroubleTickets.do?command=CategoryJSList&catCode=" + escape(value);
    window.frames['server_commands'].location.href=url;
  }
  function updateSubList2() {
    var sel = document.forms['addticket'].elements['subCat1'];
    var value = sel.options[sel.selectedIndex].value;
    var url = "TroubleTickets.do?command=CategoryJSList&subCat1=" + escape(value);
    window.frames['server_commands'].location.href=url;
  }
  function updateSubList3() {
    var sel = document.forms['addticket'].elements['subCat2'];
    var value = sel.options[sel.selectedIndex].value;
    var url = "TroubleTickets.do?command=CategoryJSList&subCat2=" + escape(value);
    window.frames['server_commands'].location.href=url;
  }
  function updateUserList() {
    var sel = document.forms['addticket'].elements['departmentCode'];
    var value = sel.options[sel.selectedIndex].value;
    var url = "TroubleTickets.do?command=DepartmentJSList&departmentCode=" + escape(value);
    window.frames['server_commands'].location.href=url;
  }
  function updateContactList() {
    var sel = document.forms['addticket'].elements['orgId'];
    var value = sel.options[sel.selectedIndex].value;
    var url = "TroubleTickets.do?command=OrganizationJSList&orgId=" + escape(value);
    window.frames['server_commands'].location.href=url;
  }
  function checkForm(form) {
    formTest = true;
    message = "";
    if ((!checkPhone(form.phone1number.value))) { 
      message += "- The entered phone number is invalid.  Make sure there are no invalid characters and that you have entered the area code\r\n";
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
<form name="addticket" action="TroubleTickets.do?command=Insert&auto-populate=true" method="post">
<a href="TroubleTickets.do">Tickets</a> > 
Add Ticket<br>
<hr color="#BFBFBB" noshade>
<% if (request.getParameter("contact") != null) {%>
<input type="submit" value="Insert" name="Save" onClick="return checkForm(this.form)">
<%} else {%>
<input type="submit" value="Insert" name="Save">
<%}%>
<input type="submit" value="Cancel" onClick="javascript:this.form.action='TroubleTickets.do?command=Home'">
<input type="reset" value="Reset">	
<br>
<%= showError(request, "actionError") %><iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>
<% if (request.getAttribute("closedError") != null) { %>
  <%= showAttribute(request, "closedError") %>
<%}%>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
	<tr class="title">
    <td colspan="2">
      <strong>Add a new Ticket</strong>
    </td>
	</tr>
	<tr>
    <td class="formLabel">
      Ticket Source
    </td>
    <td>
      <%= SourceList.getHtmlSelect("sourceCode",  TicketDetails.getSourceCode()) %>
    </td>
	</tr>	
	<tr>
    <td class="formLabel">
      Organization
    </td>
    <td>
	<% if (TicketDetails == null || TicketDetails.getOrgId() == -1) { %>
      <%= OrgList.getHtmlSelectDefaultNone("orgId")%>
	<%} else {%>
      <%= OrgList.getHtmlSelect("orgId", TicketDetails.getOrgId()) %>
	<%}%>
      <font color="red">*</font> <%= showAttribute(request, "orgIdError") %>
    </td>
	</tr>	
	<tr>
    <td class="formLabel">
      Contact
    </td>
    <td>
	<% if (TicketDetails == null || TicketDetails.getOrgId() == -1 || ContactList.size() == 0) { %>
      <%= ContactList.getEmptyHtmlSelect("contactId") %>
	<%} else {%>
      <%= ContactList.getHtmlSelect("contactId", TicketDetails.getContactId() ) %>
	<%}%>
      <font color="red">*</font><%= showAttribute(request, "contactIdError") %>
      <input type="checkbox" name="contact"<dhv:evaluate if="<%= request.getParameter("contact") != null %>"> checked</dhv:evaluate>
      onClick="javascript:this.form.action='TroubleTickets.do?command=Add&auto-populate=true#newcontact';this.form.submit()">Add new
      <a name="newcontact"></a> 
    </td>
	</tr>
</table>
<dhv:evaluate if="<%= request.getParameter("contact") != null %>">
<br>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
	<tr class="title">
    <td colspan="2">
      <strong>New Contact</strong>
    </td>
	</tr>
	<tr>
    <td class="formLabel">
      First Name
    </td>
    <td>
      <input type="text" size="35" name="thisContact_nameFirst" value="<%=TicketDetails.getThisContact().getNameFirst()%>">
    </td>
  </tr>
  <tr>
    <td class="formLabel">
      Last Name
    </td>
    <td valign="center">
      <input type=text size=35 name="thisContact_nameLast" value="<%=TicketDetails.getThisContact().getNameLast()%>">
      <font color="red">*</font> <%= showAttribute(request, "nameLastError") %>
    </td>
  </tr>
  <tr>
    <td class="formLabel">
      Title
    </td>
    <td>
      <input type="text" size="35" name="thisContact_title" value="<%=TicketDetails.getThisContact().getTitle()%>">
    </td>
  </tr>
  <tr>
    <td class="formLabel">
      Email
    </td>
    <td>
      <input type="hidden" name="email1type" value="1">
      <input type="text" size="40" name="email1address" maxlength="255">
    </td>
  </tr>
  <tr>
    <td class="formLabel">
      Phone
    </td>
    <td>
      <input type="hidden" name="phone1type" value="1">
      <input type="text" size="20" name="phone1number">&nbsp;ext.
      <input type="text" size="5" name="phone1ext" maxlength="10">
    </td>
  </tr>
</table>
</dhv:evaluate>
<br>
<a name="categories"></a> 
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan="2">
      <strong>Classification</strong>
    </td>
	</tr>
	<tr>
    <td valign="top" class="formLabel">
      <dhv:label name="tickets-problem">Issue</dhv:label>
    </td>
    <td>
      <table border="0" cellspacing="0" cellpadding="0">
        <tr>
          <td>
            <textarea name="problem" cols="55" rows="3"><%= toString(TicketDetails.getProblem()) %></textarea>
            <input type="hidden" name="refresh" value="-1">
          </td>
          <td valign="top">
            <font color="red">*</font> <%= showAttribute(request, "problemError") %>
          </td>
        </tr>
      </table>
    </td>
	</tr>
<dhv:include name="tickets-code" none="true">
	<tr>
    <td class="formLabel">
      Category
    </td>
    <td>
      <%= CategoryList.getHtmlSelect("catCode", TicketDetails.getCatCode()) %>
    </td>
	</tr>
</dhv:include>
<dhv:include name="tickets-subcat1" none="true">
	<tr>
    <td class="formLabel">
      Sub-level 1
    </td>
    <td>
      <%= SubList1.getHtmlSelect("subCat1", TicketDetails.getSubCat1()) %>
      <input type="hidden" name="close" value="">
    </td>
	</tr>
</dhv:include>
<dhv:include name="tickets-subcat2" none="true">
	<tr>
    <td class="formLabel">
      Sub-level 2
    </td>
    <td>
      <%= SubList2.getHtmlSelect("subCat2", TicketDetails.getSubCat2()) %>
    </td>
	</tr>
</dhv:include>
<dhv:include name="tickets-subcat3" none="true">
	<tr>
    <td class="formLabel">
      Sub-level 3
    </td>
    <td>
      <%= SubList3.getHtmlSelect("subCat3", TicketDetails.getSubCat3()) %>
    </td>
	</tr>
</dhv:include>
</table>
<br>
<a name="department"></a> 
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
	<tr class="title">
    <td colspan="2">
      <strong>Assignment</strong>
    </td>
	</tr>
<dhv:include name="tickets-severity" none="true">
	<tr>
    <td class="formLabel">
      Severity
    </td>
    <td>
      <%= SeverityList.getHtmlSelect("severityCode",  TicketDetails.getSeverityCode()) %>
    </td>
	</tr>
</dhv:include>
<dhv:include name="tickets-priority" none="true">
	<tr>
    <td class="formLabel">
      Priority
    </td>
    <td>
      <%= PriorityList.getHtmlSelect("priorityCode", TicketDetails.getPriorityCode()) %>
    </td>
	</tr>
</dhv:include>
	<tr>
    <td class="formLabel">
      Department
    </td>
    <td>
      <%= DepartmentList.getHtmlSelect("departmentCode", TicketDetails.getDepartmentCode()) %>
    </td>
	</tr>
	<tr>
    <td class="formLabel">
      Assign To
    </td>
    <td>
      <%= UserList.getHtmlSelect("assignedTo", TicketDetails.getAssignedTo() ) %>
    </td>
	</tr>
	<tr>
    <td valign="top" class="formLabel">
      Entry Comments
    </td>
    <td>
      <textarea name="comment" cols="55" rows="3"><%= toString(TicketDetails.getComment()) %></textarea>
    </td>
	</tr>
</table>
<br>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
	<tr class="title">
    <td colspan="2">
      <strong>Resolution</strong>
    </td>
	</tr>
	<tr>
    <td valign="top" class="formLabel">
      Solution
    </td>
    <td>
      <textarea name="solution" cols="55" rows="3"><%= toString(TicketDetails.getSolution()) %></textarea><br>
      <input type="checkbox" name="closeNow">Close ticket<br>
      <input type="checkbox" name="kbase">Add this solution to Knowledge Base
    </td>
	</tr>
</table>
<br>
<% if (request.getParameter("contact") != null) {%>
<input type="submit" value="Insert" name="Save" onClick="return checkForm(this.form)">
<%} else {%>
<input type="submit" value="Insert" name="Save">
<%}%>
<input type="submit" value="Cancel" onClick="javascript:this.form.action='TroubleTickets.do?command=Home'">
<input type="reset" value="Reset">
</form>
