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
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.pipeline.base.*,com.zeroio.iteam.base.*" %>
<%@ page import="org.aspcfs.modules.quotes.base.*" %>
<jsp:useBean id="opportunityHeader" class="org.aspcfs.modules.pipeline.base.OpportunityHeader" scope="request"/>
<jsp:useBean id="quoteList" class="org.aspcfs.modules.quotes.base.QuoteList" scope="request"/>
<jsp:useBean id="quoteStatusList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="LeadsQuoteListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="PipelineViewpointInfo" class="org.aspcfs.utils.web.ViewpointInfo" scope="session"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>
<%@ include file="../initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>
<%@ include file="leads_quotes_list_menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<script language="JavaScript" type="text/javascript">
  <%-- Preload image rollovers for drop-down menu --%>
  loadImages('select');
</script>
<script type="text/javascript">
function reopenOpportunity(id) {
  if (id == '<%= opportunityHeader.getId() %>') {
    if ('<%= "dashboard".equals(request.getParameter("viewSource")) %>' == 'true') {
      scrollReload('Leads.do?command=Dashboard');
    } else {
      scrollReload('Leads.do?command=Search');
    }
    return id;
  } else {
    return '<%= opportunityHeader.getId() %>';
  }
}
</script>
<%-- Trails --%>
<%
  boolean allowMultipleQuote = allowMultipleQuote(pageContext);
  boolean allowMultipleVersion = allowMultipleVersion(pageContext);
%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Leads.do"><dhv:label name="pipeline.pipeline">Pipeline</dhv:label></a> >
<% if ("dashboard".equals(request.getParameter("viewSource"))){ %>
	<a href="Leads.do?command=Dashboard"><dhv:label name="communications.campaign.Dashboard">Dashboard</dhv:label></a> >
<% }else{ %>
	<a href="Leads.do?command=Search"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
<% } %>
<a href="Leads.do?command=DetailsOpp&headerId=<%= opportunityHeader.getId() %><%= addLinkParams(request, "viewSource") %>"><dhv:label name="accounts.accounts_contacts_oppcomponent_add.OpportunityDetails">Opportunity Details</dhv:label></a> >
<dhv:label name="dependency.quotes">Quotes</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<dhv:evaluate if="<%= PipelineViewpointInfo.isVpSelected(User.getUserId()) %>">
  <dhv:label name="pipeline.viewpoint.colon" param='<%= "username="+PipelineViewpointInfo.getVpUserName() %>'><b>Viewpoint: </b><b class="highlight"><%= PipelineViewpointInfo.getVpUserName() %></b></dhv:label><br />
  &nbsp;<br>
</dhv:evaluate>
<dhv:container name="opportunities" selected="quotes" object="opportunityHeader" param='<%= "id=" + opportunityHeader.getId() %>' appendToUrl='<%= addLinkParams(request, "viewSource") %>'>
  <dhv:hasAuthority owner="<%= opportunityHeader.getManagerOwnerIdRange() %>">
  <dhv:evaluate if="<%= !opportunityHeader.isTrashed() %>" >
    <dhv:permission name="pipeline-opportunities-add">
    <dhv:evaluate if="<%= (allowMultipleQuote) || (quoteList.size() == 0)%>" >    
      <a href="LeadsQuotes.do?command=AddQuoteForm&headerId=<%= opportunityHeader.getId()%><%= addLinkParams(request, "viewSource") %>"><dhv:label name="accounts.accounts_quotes_list.AddAQuote">Add a Quote</dhv:label></a>
    </dhv:evaluate>
    </dhv:permission>
  </dhv:evaluate>
  </dhv:hasAuthority>
  <dhv:pagedListStatus title='<%= showError(request, "actionError") %>' object="LeadsQuoteListInfo"/>
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
    <tr>
      <th width="10">
        &nbsp;
      </th>
      <th nowrap>
        <strong><a href="LeadsQuotes.do?command=QuoteList&headerId=<%= opportunityHeader.getId() %>&column=qe.group_id<%= addLinkParams(request, "viewSource") %>"><dhv:label name="quotes.number">Number</dhv:label></a></strong>
        <%= LeadsQuoteListInfo.getSortIcon("qe.group_id") %>
      </th>
      <th nowrap>
        <strong><a href="LeadsQuotes.do?command=QuoteList&headerId=<%= opportunityHeader.getId() %>&column=qe.version<%= addLinkParams(request, "viewSource") %>"><dhv:label name="accounts.accounts_documents_details.Version">Version</dhv:label></a></strong>
        <%= LeadsQuoteListInfo.getSortIcon("qe.version") %>
      </th>
      <th align="center" nowrap>
        <strong><a href="LeadsQuotes.do?command=QuoteList&headerId=<%= opportunityHeader.getId() %>&column=qe.short_description<%= addLinkParams(request, "viewSource") %>"><dhv:label name="accounts.accountasset_include.Description">Description</dhv:label></a></strong>
        <%= LeadsQuoteListInfo.getSortIcon("qe.short_description") %>
      </th>
      <th nowrap>
        <strong><a href="LeadsQuotes.do?command=QuoteList&headerId=<%= opportunityHeader.getId() %>&column=statusName<%= addLinkParams(request, "viewSource") %>"><dhv:label name="accounts.accountasset_include.Status">Status</dhv:label></a></strong>
        <%= LeadsQuoteListInfo.getSortIcon("statusName") %>
      </th>
      <th nowrap>
        <strong><a href="LeadsQuotes.do?command=QuoteList&headerId=<%= opportunityHeader.getId() %>&column=qe.entered<%= addLinkParams(request, "viewSource") %>"><dhv:label name="accounts.accounts_calls_list.Entered">Created</dhv:label></a></strong>
        <%= LeadsQuoteListInfo.getSortIcon("qe.entered") %>
      </th>
      <th nowrap>
        <strong><a href="LeadsQuotes.do?command=QuoteList&headerId=<%= opportunityHeader.getId() %>&column=qe.issued<%= addLinkParams(request, "viewSource") %>"><dhv:label name="quotes.issued">Issued</dhv:label></a></strong>
        <%= LeadsQuoteListInfo.getSortIcon("qe.issued") %>
      </th>
      <th>
        <strong><a href="LeadsQuotes.do?command=QuoteList&headerId=<%= opportunityHeader.getId() %>&column=qe.closed<%= addLinkParams(request, "viewSource") %>"><dhv:label name="quotes.closed">Closed</dhv:label></a></strong>
        <%= LeadsQuoteListInfo.getSortIcon("qe.closed") %>
      </th>
    </tr>
  <%
    Iterator j = quoteList.iterator();
    if ( j.hasNext() ) {
      int rowid = 0;
      int i =0;
        while (j.hasNext()) {
          i++;
          rowid = (rowid != 1?1:2);
          Quote thisQuote = (Quote) j.next();
          boolean hasPermission = false;
  %>
  <dhv:hasAuthority owner="<%= opportunityHeader.getManagerOwnerIdRange() %>">
    <% hasPermission = true; %>
  </dhv:hasAuthority>
    <tr class="row<%= rowid %>">
      <td valign="center" nowrap class="row<%= rowid %>">
        <% if(!thisQuote.getLock()){%>
          <%-- Use the unique id for opening the menu, and toggling the graphics --%>
           <a href="javascript:displayMenu('select<%= i %>','menuQuote', '<%= thisQuote.getId() %>', '&headerId=<%= thisQuote.getHeaderId() %><%= addLinkParams(request, "viewSource") %>' , '<%= (thisQuote.getClosed() == null) ? "true" : "false" %>','<%= thisQuote.isTrashed() %>','<%= hasPermission %>','<%=allowMultipleQuote%>','<%=allowMultipleVersion%>');"
           onMouseOver="over(0, <%= i %>)" onmouseout="out(0, <%= i %>); hideMenu('menuQuote');">
           <img src="images/select.gif" name="select<%= i %>" id="select<%= i %>" align="absmiddle" border="0"></a>
       <% }else{ %>
          <font color="red"><dhv:label name="pipeline.locked">Locked</dhv:label></font>
       <% } %>
      </td>
      <td valign="center" width="10%">
      <dhv:permission name="pipeline-quotes-view">
        <a href="LeadsQuotes.do?command=Details&quoteId=<%= thisQuote.getId() %><%= addLinkParams(request, "viewSource") %>">
          <%= thisQuote.getPaddedGroupId() %></a>
      </dhv:permission><dhv:permission name="pipeline-quotes-view" none="true">
        <%= thisQuote.getPaddedGroupId() %>
      </dhv:permission>
      </td>
      <td valign="center">
        <%= toHtml(thisQuote.getVersion()) %>
      </td>
      <td valign="center" width="50%">
        <%= toHtml(thisQuote.getShortDescription()) %>
      </td>
      <td valign="center" nowrap>
        <%= toHtml(quoteStatusList.getValueFromId(thisQuote.getStatusId())) %>
      </td>
      <td valign="center" width="10%">
        <dhv:tz timestamp="<%= thisQuote.getEntered() %>" dateOnly="true" dateFormat="<%= DateFormat.SHORT %>"/>
      </td>
      <td valign="center" width="10%">
        <% if(thisQuote.getIssuedDate() != null){ %>
            <dhv:tz timestamp="<%= thisQuote.getIssuedDate() %>" dateOnly="true" dateFormat="<%= DateFormat.SHORT %>"/>
        <% } else { %>&nbsp;<% } %>
      </td>
      <td valign="center" width="10%">
        <% if(thisQuote.getClosed() != null ){ %>
            <dhv:tz timestamp="<%= thisQuote.getClosed() %>" dateOnly="true" dateFormat="<%= DateFormat.SHORT %>"/>
        <% }else{ %>&nbsp;<% } %>
      </td>
    </tr>
  <%}%>
  <%} else {%>
    <tr class="containerBody">
      <td colspan="8">
        <dhv:label name="accounts.accounts_quotes_list.NoQuotesFound">No quotes found.</dhv:label>
      </td>
    </tr>
  <%}%>
  </table>
  <br>
  <dhv:pagedListControl object="LeadsQuoteListInfo"/>
</dhv:container>
