<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.contacts.base.*" %>
<jsp:useBean id="ImportResults" class="org.aspcfs.modules.contacts.base.ContactList" scope="request"/>
<jsp:useBean id="ImportDetails" class="org.aspcfs.modules.base.Import" scope="request"/>
<jsp:useBean id="ExternalContactsImportResultsInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<%@ include file="../initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>
<%@ include file="companydirectory_importresults_menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<script language="JavaScript" type="text/javascript">
  <%-- Preload image rollovers for drop-down menu --%>
  loadImages('select');
</script>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
  <td>
    <a href="ExternalContacts.do">Contacts</a> >
    <a href="ExternalContactsImports.do?command=View">View Imports</a> >
    <a href="ExternalContactsImports.do?command=Details&importId=<%= ImportDetails.getId() %>">Import Details</a> >
    View Results
  </td>
</tr>
</table>
<%-- End Trails --%>
<center><%= ExternalContactsImportResultsInfo.getAlphabeticalPageLinks() %></center>
<table width="100%" border="0">
  <tr>
    <td>
      <dhv:pagedListStatus title="<%= showError(request, "actionError") %>" object="ExternalContactsImportResultsInfo"/>
    </td>
  </tr>
</table>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
  <tr>
    <th valign="center">
      <strong>Action</strong>
    </th>
    <th nowrap>
      <strong><a href="ExternalContactsImports.do?command=ViewResults&importId=<%= ImportDetails.getId() %>&column=c.namelast">Name</a></strong>
      <%= ExternalContactsImportResultsInfo.getSortIcon("c.namelast") %>
    </th>
    <th nowrap>
      <strong><a href="ExternalContactsImports.do?command=ViewResults&importId=<%= ImportDetails.getId() %>&column=c.company">Company</a></strong>
      <%= ExternalContactsImportResultsInfo.getSortIcon("c.company") %>
    </th>
    <th>
      <strong>Phone: Business</strong>
    </th>
    <th>
      <strong>Phone: Mobile</strong>
    </th>
    <dhv:evaluate if="<%= !"my".equals(ExternalContactsImportResultsInfo.getListView()) && !"".equals(ExternalContactsImportResultsInfo.getListView()) %>">
      <th>
        <strong>Owner</strong>
      </th>
    </dhv:evaluate>
  </tr>
<%    
	Iterator i = ImportResults.iterator();
	if (i.hasNext()) {
	int rowid = 0;
  int count  =0;
		while (i.hasNext()) {
      count++;
      rowid = (rowid != 1 ? 1 : 2);
      Contact thisContact = (Contact)i.next();
%>    
      <tr>
        <td width="8" class="row<%= rowid %>" nowrap>
         <%-- check if user has edit or delete based on the type of contact --%>
        <%
          int hasDeletePermission = 0;
          if(!thisContact.isApproved()){
            if(thisContact.getOrgId() < 0){ %>
            <dhv:permission name="contacts-external_contacts-delete">
              <% hasDeletePermission = 1; %>
            </dhv:permission>
          <% }else{ %>
              <dhv:permission name="contacts-external_contacts-delete,accounts-accounts-contacts-delete" all="true">
                <% hasDeletePermission = 1; %>
              </dhv:permission>
          <% } %>
        <% } %>
        <%-- Use the unique id for opening the menu, and toggling the graphics --%>
         <a href="javascript:displayMenu('select<%= count %>','menuContact','<%= thisContact.getId() %>','<%= hasDeletePermission %>');" onMouseOver="over(0, <%= count %>)" onmouseout="out(0, <%= count %>); hideMenu('menuContact');"><img src="images/select.gif" name="select<%= count %>" id="select<%= count %>" align="absmiddle" border="0"></a>
        </td>
        <td class="row<%= rowid %>" <%= "".equals(toString(thisContact.getNameLastFirst())) ? "width=\"10\"" : ""  %> nowrap>
          <% if(!"".equals(toString(thisContact.getNameLastFirst()))){ %>
          <a href="ExternalContactsImports.do?command=ContactDetails&contactId=<%= thisContact.getId() %>"><%= toHtml(thisContact.getNameLastFirst()) %></a>
          <%= thisContact.getEmailAddressTag("Business", "<img border=0 src=\"images/icons/stock_mail-16.gif\" alt=\"Send email\" align=\"absmiddle\">", "") %>
          <dhv:permission name="accounts-view,accounts-accounts-view"><%= ((thisContact.getOrgId() > 0 )?"<a href=\"Accounts.do?command=Details&orgId=" + thisContact.getOrgId() + "\">[Account]</a>":"")%></dhv:permission>
          <% }else{ %>
            &nbsp;
          <%}%>
        </td>
        <td class="row<%= rowid %>">
          <% if(!"".equals(toString(thisContact.getNameLastFirst()))){ %>
            <%= toHtml(thisContact.getOrgName()) %>
          <%}else{%>
            <a href="ExternalContacts.do?command=ContactDetails&id=<%= thisContact.getId() %>"><%= toHtml(thisContact.getOrgName()) %></a>
            <%= thisContact.getEmailAddressTag("Business", "<img border=0 src=\"images/icons/stock_mail-16.gif\" alt=\"Send email\" align=\"absmiddle\">", "") %>
          <%}%>
        </td>
        <td class="row<%= rowid %>" nowrap>
          <%= toHtml(thisContact.getPhoneNumber("Business")) %>
        </td>
        <td class="row<%= rowid %>" nowrap>
          <%= toHtml(thisContact.getPhoneNumber("Mobile")) %>
        </td>
        <dhv:evaluate if="<%= !"my".equals(ExternalContactsImportResultsInfo.getListView()) && !"".equals(ExternalContactsImportResultsInfo.getListView()) %>">
          <td class="row<%= rowid %>" nowrap>
            <dhv:username id="<%= thisContact.getOwner() %>"/>
          </td>
        </dhv:evaluate>
      </tr>
<%
    }
  } else {%>  
  <tr>
    <td class="containerBody" colspan="5">
      No contacts found.
    </td>
  </tr>
<%}%>
</table>
<br>
<dhv:pagedListControl object="ExternalContactsImportResultsInfo" tdClass="row1"/>
