<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.accounts.base.*,org.aspcfs.modules.pipeline.base.OpportunityComponent,com.zeroio.iteam.base.*" %>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="opportunityHeader" class="org.aspcfs.modules.pipeline.base.OpportunityHeader" scope="request"/>
<jsp:useBean id="ComponentList" class="org.aspcfs.modules.pipeline.base.OpportunityComponentList" scope="request"/>
<jsp:useBean id="AccountsComponentListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<a href="Accounts.do">Account Management</a> > 
<a href="Accounts.do?command=View">View Accounts</a> >
<a href="Accounts.do?command=Details&orgId=<%= OrgDetails.getOrgId() %>">Account Details</a> >
<a href="Opportunities.do?command=View&orgId=<%= OrgDetails.getOrgId() %>">Opportunities</a> >
Opportunity Details<br>
<hr color="#BFBFBB" noshade>
<%-- Begin container --%>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
      <%@ include file="accounts_details_header_include.jsp" %>
    </td>
  </tr>
  <tr class="containerMenu">
    <td>
      <% String param1 = "orgId=" + OrgDetails.getOrgId(); %>      
      <dhv:container name="accounts" selected="opportunities" param="<%= param1 %>" />
    </td>
  </tr>
  <tr>
    <td class="containerBack">
      <%-- Begin container content --%>
      <img src="images/icons/stock_form-currency-field-16.gif" border="0" align="absmiddle">
      <strong><%= toHtml(opportunityHeader.getDescription()) %></strong>
      <% FileItem thisFile = new FileItem(); %>
      <dhv:evaluate if="<%= opportunityHeader.hasFiles() %>">
        <%= thisFile.getImageTag() %>
      </dhv:evaluate>
      <br>
      <dhv:permission name="accounts-accounts-opportunities-add">
        <br>
        <a href="OpportunitiesComponents.do?command=Prepare&headerId=<%= opportunityHeader.getId() %>&orgId=<%= opportunityHeader.getAccountLink() %>">Add a Component</a><br>
      </dhv:permission>
<dhv:pagedListStatus title="<%= showError(request, "actionError") %>" object="AccountsComponentListInfo"/>
 <table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <dhv:permission name="accounts-accounts-opportunities-edit,accounts-accounts-opportunities-delete">
    <td>
      <strong>Action</strong>
    </td>
    </dhv:permission>
    <td nowrap>
      <strong><a href="Opportunities.do?command=Details&headerId=<%= opportunityHeader.getId() %>&orgId=<%= OrgDetails.getId() %>&column=oc.description">Component</a></strong>
      <%= AccountsComponentListInfo.getSortIcon("oc.description") %>
    </td>
    <td nowrap>
      <strong><a href="Opportunities.do?command=Details&headerId=<%= opportunityHeader.getId() %>&orgId=<%= OrgDetails.getId() %>&column=oc.closed">Status</a></strong>
      <%= AccountsComponentListInfo.getSortIcon("oc.closed") %>
    </td>
    <td nowrap>
      <strong><a href="Opportunities.do?command=Details&headerId=<%= opportunityHeader.getId() %>&orgId=<%= OrgDetails.getId() %>&column=oc.guessvalue">Guess Amount</a></strong>
      <%= AccountsComponentListInfo.getSortIcon("oc.guessvalue") %>
    </td>
    <td nowrap>
      <strong><a href="Opportunities.do?command=Details&headerId=<%= opportunityHeader.getId() %>&orgId=<%=OrgDetails.getId()%>&column=oc.closedate">Close Date</a></strong>
      <%= AccountsComponentListInfo.getSortIcon("oc.closedate") %>
    </td>
    <td nowrap>
      <strong><a href="Opportunities.do?command=Details&headerId=<%= opportunityHeader.getId() %>&orgId=<%=OrgDetails.getId()%>&column=stagename">Current Stage</a></strong>
      <%= AccountsComponentListInfo.getSortIcon("stagename") %>
    </td>
    <td>
      <strong>Owner</strong>
    </td>
  </tr>
<%
	Iterator j = ComponentList.iterator();
	if (j.hasNext()) {
		int rowid = 0;
	    while (j.hasNext()) {
        rowid = (rowid != 1?1:2);
        OpportunityComponent oppComponent = (OpportunityComponent)j.next();
%>
  <tr class="row<%= rowid %>">
    <dhv:permission name="accounts-accounts-opportunities-edit,accounts-accounts-opportunities-delete">
    <td width="8" valign="top" align="center" nowrap>
      <dhv:permission name="accounts-accounts-opportunities-edit"><a href="OpportunitiesComponents.do?command=ModifyComponent&id=<%= oppComponent.getId() %>&orgId=<%=OrgDetails.getId()%>&headerId=<%= oppComponent.getHeaderId() %>&return=list">Edit</a></dhv:permission><dhv:permission name="accounts-accounts-opportunities-edit,accounts-accounts-opportunities-delete" all="true">|</dhv:permission><dhv:permission name="accounts-accounts-opportunities-delete"><a href="javascript:popURLReturn('OpportunitiesComponents.do?command=ConfirmComponentDelete&orgId=<%= OrgDetails.getId() %>&id=<%= oppComponent.getId() %>&popup=true','Opportunities.do?command=ViewOpps&orgId=<%= OrgDetails.getId() %>', 'Delete_opp','320','200','yes','no');">Del</a></dhv:permission>
    </td>
    </dhv:permission>
    <td width="100%" valign="top">
      <a href="OpportunitiesComponents.do?command=DetailsComponent&orgId=<%= OrgDetails.getId() %>&id=<%=oppComponent.getId()%>">
      <%= toHtml(oppComponent.getDescription()) %></a>
    </td>
    <td valign="top" align="center" nowrap>
      <%= oppComponent.getClosed() != null ? "<font color=\"red\">closed</font>" : "<font color=\"green\">open</font>" %>
    </td>
    <td valign="top" align="right" nowrap>
      $<%= oppComponent.getGuessCurrency() %>
    </td>
    <td valign="top" align="center" nowrap>
      <%= toHtml(oppComponent.getCloseDateString()) %>
    </td>
    <td valign="top" align="center" nowrap>
      <%= toHtml(oppComponent.getStageName()) %>
    </td>
    <td valign="top" align="center" nowrap>
      <dhv:username id="<%= oppComponent.getOwner() %>"/>
    </td>
  </tr>
<%}%>
<%} else {%>
  <tr class="containerBody">
    <td colspan="7">
      No opportunity components found.
    </td>
  </tr>
<%}%>
</table>
<br>
<dhv:pagedListControl object="AccountsComponentListInfo"/>
&nbsp;<br>
<dhv:permission name="accounts-accounts-opportunities-edit"><input type="button" value="Rename Opportunity" onClick="javascript:window.location.href='Opportunities.do?command=Modify&headerId=<%= opportunityHeader.getId() %>&orgId=<%= opportunityHeader.getAccountLink() %>';"></dhv:permission>
<dhv:permission name="accounts-accounts-opportunities-delete"><input type="button" value="Delete Opportunity" onClick="javascript:popURLReturn('Opportunities.do?command=ConfirmDelete&orgId=<%= OrgDetails.getId() %>&headerId=<%= opportunityHeader.getId() %>&popup=true','Opportunities.do?command=View&orgId=<%= OrgDetails.getId() %>', 'Delete_opp','320','200','yes','no')"></dhv:permission>
</td>
</tr>
</table>

