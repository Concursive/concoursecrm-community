<%-- 
  - Copyright Notice: (C) 2000-2004 Dark Horse Ventures, All Rights Reserved.
  - License: This source code cannot be modified, distributed or used without
  -          written permission from Dark Horse Ventures. This notice must
  -          remain in place.
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.accounts.base.*,org.aspcfs.utils.web.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="opportunityHeader" class="org.aspcfs.modules.pipeline.base.OpportunityHeader" scope="request"/>
<%@ include file="../initPage.jsp" %>
<form name="modifyOpp" action="Opportunities.do?command=Update&orgId=<%= OrgDetails.getId() %>&auto-populate=true" method="post">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Accounts.do"><dhv:label name="accounts.accounts">Accounts</dhv:label></a> > 
<a href="Accounts.do?command=Search">Search Results</a> >
<a href="Accounts.do?command=Details&orgId=<%=OrgDetails.getOrgId()%>"><dhv:label name="accounts.details">Account Details</dhv:label></a> >
<a href="Opportunities.do?command=View&orgId=<%=OrgDetails.getOrgId()%>">Opportunities</a> >
<% if (request.getParameter("return") == null) {%>
	<a href="Opportunities.do?command=Details&headerId=<%= opportunityHeader.getId() %>&orgId=<%= OrgDetails.getOrgId() %>">Opportunity Details</a> >
<%}%>
Modify Opportunity
</td>
</tr>
</table>
<%-- End Trails --%>
<%@ include file="accounts_details_header_include.jsp" %>
<% String param1 = "orgId=" + OrgDetails.getOrgId(); %>      
<dhv:container name="accounts" selected="opportunities" param="<%= param1 %>" style="tabs"/>
<table cellpadding="4" cellspacing="0" border="0" width="100%">
  <tr>
    <td class="containerBack">
      <input type="hidden" name="headerId" value="<%= opportunityHeader.getId() %>">
      <input type="hidden" name="modified" value="<%= opportunityHeader.getModified() %>">
<% if (request.getParameter("return") != null) {%>
      <input type="hidden" name="return" value="<%=request.getParameter("return")%>">
<%}%>
      <input type="submit" value="Update" onClick="this.form.dosubmit.value='true';">
<% if (request.getParameter("return") != null) {%>
	<% if (request.getParameter("return").equals("list")) {%>
      <input type="submit" value="Cancel" onClick="javascript:this.form.action='Opportunities.do?command=View&orgId=<%= OrgDetails.getOrgId() %>';this.form.dosubmit.value='false';">
	<%}%>
<%} else {%>
      <input type="submit" value="Cancel" onClick="javascript:this.form.action='Opportunities.do?command=Details&headerId=<%= opportunityHeader.getId() %>&orgId=<%= OrgDetails.getOrgId() %>';this.form.dosubmit.value='false';">
<%}%>
      <br>
      <%= showError(request, "actionError") %>
      <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
      <tr>
        <th colspan="2">
          <strong><%= opportunityHeader.getDescription() %></strong>
        </th>
      </tr>
      <tr class="containerBody">
        <td nowrap class="formLabel">
          Description
        </td>
        <td>
          <input type="text" size="50" name="description" value="<%= toHtmlValue(opportunityHeader.getDescription()) %>">
          <font color="red">*</font> <%= showAttribute(request, "descriptionError") %>
        </td>
      </tr>
      </table>
      &nbsp;
      <br>
      <input type="submit" value="Update" onClick="this.form.dosubmit.value='true';">
      <% if (request.getParameter("return") != null) {%>
        <% if (request.getParameter("return").equals("list")) {%>
        <input type="submit" value="Cancel" onClick="javascript:this.form.action='Opportunities.do?command=View&orgId=<%= OrgDetails.getOrgId() %>';this.form.dosubmit.value='false';">
        <%}%>
      <%} else {%>
      <input type="submit" value="Cancel" onClick="javascript:this.form.action='Opportunities.do?command=Details&headerId=<%= opportunityHeader.getId() %>&orgId=<%= OrgDetails.getOrgId() %>';this.form.dosubmit.value='false';">
      <%}%>
      <input type="hidden" name="dosubmit" value="true">
    </td>
  </tr>
</table>
</form>
