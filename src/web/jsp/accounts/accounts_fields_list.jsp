<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*" %>
<jsp:useBean id="OrgDetails" class="com.darkhorseventures.cfsbase.Organization" scope="request"/>
<jsp:useBean id="CategoryList" class="com.darkhorseventures.cfsbase.CustomFieldCategoryList" scope="request"/>
<jsp:useBean id="Category" class="com.darkhorseventures.cfsbase.CustomFieldCategory" scope="request"/>
<jsp:useBean id="Records" class="com.darkhorseventures.cfsbase.CustomFieldRecordList" scope="request"/>
<%@ include file="initPage.jsp" %>
<form name="details" action="/Accounts.do?command=Fields&orgId=<%= OrgDetails.getOrgId() %>" method="post">
<a href="/Accounts.do?command=View">Back to Account List</a><br>&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
      <strong><%= toHtml(OrgDetails.getName()) %></strong>
    </td>
  </tr>
  <tr class="containerMenu">
    <td>
      <a href="/Accounts.do?command=Details&orgId=<%= OrgDetails.getOrgId() %>"><font color="#000000">Details</font></a> | 
      <a href="/Accounts.do?command=Fields&orgId=<%= OrgDetails.getOrgId() %>"><font color="#0000FF">Folders</font></a> |
      <font color="#787878">Activities</font> | 
      <a href="/Contacts.do?command=View&orgId=<%= OrgDetails.getOrgId() %>"><font color="#000000">Contacts</font></a> | 
      <a href="/Opportunities.do?command=View&orgId=<%= OrgDetails.getOrgId() %>"><font color="#000000">Opportunities</font></a> | 
      <a href="/Accounts.do?command=ViewTickets&orgId=<%= OrgDetails.getOrgId() %>"><font color="#000000">Tickets</font></a> |
      <a href="AccountsDocuments.do?command=View&orgId=<%=OrgDetails.getOrgId()%>"><font color="#000000">Documents</font></a>
    </td>
  </tr>
  <tr>
    <td class="containerBack">
<%
  CategoryList.setJsEvent("ONCHANGE=\"javascript:document.forms[0].submit();\"");
  if (CategoryList.size() > 0) {
%>
    <%= CategoryList.getHtmlSelect("catId", (String)request.getAttribute("catId")) %><br>
    &nbsp;<br>
    <a href="/Accounts.do?command=AddFolderRecord&orgId=<%= OrgDetails.getOrgId() %>&catId=<%= (String)request.getAttribute("catId") %>">Add a record to this folder</a><br>
    &nbsp;<br>
    <table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
      <tr class="title">
        <td align="left">
          <strong>Record</strong>
        </td>
        <td align="left">
          <strong>Entered</strong>
        </td>
        <td align="left">
          <strong>Modified By</strong>
        </td>
        <td align="left">
          <strong>Last Modified</strong>
        </td>
      </tr>
<%
    if (Records.size() > 0) {
      Iterator records = Records.iterator();
      while (records.hasNext()) {
        CustomFieldRecord thisRecord = (CustomFieldRecord)records.next();
%>    
      <tr class="containerBody">
        <td align="left" width="100%" nowrap>
          <a href="/Accounts.do?command=Fields&orgId=<%= OrgDetails.getOrgId() %>&catId=<%= Category.getId() %>&recId=<%= thisRecord.getId() %>"><%= Category.getName() %> #<%= thisRecord.getId() %></a>
        </td>
        <td nowrap>
          <%= toHtml(thisRecord.getEnteredString()) %>
        </td>
        <td nowrap>
          <dhv:username id="<%= thisRecord.getModifiedBy() %>" />
        </td>
        <td nowrap>
          <%= toHtml(thisRecord.getModifiedDateTimeString()) %>
        </td>
      </tr>
<%    
      }
    } else {
%>
      <tr class="containerBody">
        <td colspan="4">
          <font color="#9E9E9E">No records have been entered.</font>
        </td>
      </tr>
<%  }  %>
<%} else {%>
  <table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
    <tr class="containerBody">
      <td>
        No custom folders available.
      </td>
    </tr>
<%}%>
  </table>
</td></tr>
</table>
</form>
