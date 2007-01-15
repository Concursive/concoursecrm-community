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
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,java.text.*,java.text.DateFormat,org.aspcfs.modules.contacts.base.*,org.aspcfs.modules.products.base.*,org.aspcfs.utils.web.*,org.aspcfs.modules.quotes.base.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="quote" class="org.aspcfs.modules.quotes.base.Quote" scope="request"/>
<jsp:useBean id="quoteStatusList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="quoteDeliveryList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="quoteBean" class="org.aspcfs.modules.quotes.base.Quote" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="quoteNoteList" class="org.aspcfs.modules.quotes.base.QuoteNoteList" scope="request"/>
<jsp:useBean id="version" class="java.lang.String" scope="request"/>
<jsp:useBean id="opportunityHeader" class="org.aspcfs.modules.pipeline.base.OpportunityHeader" scope="request"/>
<jsp:useBean id="PipelineViewpointInfo" class="org.aspcfs.utils.web.ViewpointInfo" scope="session"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>
<%@ include file="../initPage.jsp" %>
<script type="text/javascript">
  function checkComplete() {
    var note = document.forms['form_notes'].notes.value;
    if( note == ""){
      alert(label("check.quotes.notes.empty","Please enter the notes to be saved"));
      return false;
    }
    return true;
  }
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
<form method="post" name="form_notes" action="LeadsQuotes.do?command=SaveNotes&quoteId=<%= quote.getId() %>&auto-populate=true" onSubmit="return checkComplete();">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Leads.do"><dhv:label name="pipeline.pipeline">Pipeline</dhv:label></a> > 
<% if ("dashboard".equals(request.getParameter("viewSource"))){ %>
	<a href="Leads.do?command=Dashboard"><dhv:label name="communications.campaign.Dashboard">Dashboard</dhv:label></a> > 
<% }else{ %>
	<a href="Leads.do?command=Search"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> > 
<% } %>
<a href="Leads.do?command=DetailsOpp&headerId=<%= quote.getHeaderId() %>&reset=true<%= addLinkParams(request, "viewSource") %>"><dhv:label name="accounts.accounts_contacts_oppcomponent_add.OpportunityDetails">Opportunity Details</dhv:label></a> > 
<a href="LeadsQuotes.do?command=QuotesList&headerId=<%= opportunityHeader.getId() %>&reset=true<%= addLinkParams(request, "viewSource") %>"><dhv:label name="dependency.quotes">Quotes</dhv:label></a> > 
<a href="LeadsQuotes.do?command=Details&quoteId=<%= quote.getId() %>&version=<%= (version!=null && !"".equals(version))?version:"" %>"><dhv:label name="quotes.quoteDetails">Quote Details</dhv:label></a> > 
<dhv:label name="quotes.quoteNotes">Quote Notes</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<%= showError(request, "actionError", false) %>
<dhv:evaluate if="<%= PipelineViewpointInfo.isVpSelected(User.getUserId()) %>">
  <dhv:label name="pipeline.viewpoint.colon" param='<%= "username="+PipelineViewpointInfo.getVpUserName() %>'><b>Viewpoint: </b><b class="highlight"><%= PipelineViewpointInfo.getVpUserName() %></b></dhv:label><br />
  &nbsp;<br>
</dhv:evaluate>
<dhv:container name="opportunities" selected="quotes" object="opportunityHeader" param='<%= "id=" + opportunityHeader.getId() %>' appendToUrl='<%= addLinkParams(request, "viewSource") %>'>
  <dhv:container name="opportunitiesQuotes" selected="notes" object="quote" param='<%= "quoteId=" + quote.getId() + "|version=" + version %>' appendToUrl='<%= addLinkParams(request, "viewSource") %>'>
    <%@ include file="../quotes/quotes_header_include.jsp" %>
    <% String status = quoteStatusList.getValueFromId(quote.getStatusId()); %>
    <dhv:hasAuthority owner="<%= opportunityHeader.getManagerOwnerIdRange() %>">
    <dhv:evaluate if="<%= !quote.isTrashed() %>" >
      <dhv:evaluate if="<%= quote.getClosed() == null%>" >
        <dhv:permission name="pipeline-opportunities-edit">
          <input type="submit" value="<dhv:label name="button.save">Save</dhv:label>"/>
        </dhv:permission>
        <input type="button" value="<dhv:label name="button.cancel">Cancel</dhv:label>" onClick="javascript:window.location.href='LeadsQuotes.do?command=Details&quoteId=<%= quote.getId() %>&orgId=<%= OrgDetails.getOrgId()%>&version=<%= version %><%= addLinkParams(request, "viewSource") %>'"/><br /><br />
      </dhv:evaluate>
    </dhv:evaluate>
    </dhv:hasAuthority>
    <table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
      <tr><th colspan="3"><strong><dhv:label name="accounts.accountasset_include.Notes">Notes</dhv:label></strong></th></tr>
      <tr class="containerBody">
        <td><strong><dhv:label name="quotes.date">Date</dhv:label></strong></td>
        <td nowrap><strong><dhv:label name="accounts.accounts_calls_list.EnteredBy">Entered By</dhv:label></strong></td>
        <td><strong><dhv:label name="contacts.details">Details</dhv:label></strong></td>
      </tr>
    <%
      int rowid=0;
      int i=0;
      Iterator iterator = (Iterator) quoteNoteList.iterator();
      while(iterator.hasNext()){
        QuoteNote quoteNote = (QuoteNote) iterator.next();
        i++;
        rowid = ( rowid != 1 ? 1:2 );
    %>
      <tr class="row<%= rowid %>">
        <td valign="top" nowrap>
          <dhv:tz timestamp="<%= quoteNote.getEntered() %>" dateOnly="false" dateFormat="<%= DateFormat.SHORT %>"/>
        </td>
        <td valign="top" nowrap>
          <dhv:username id="<%= quoteNote.getEnteredBy() %>" />
        </td>
        <td width="100%">
          <%= toHtml(quoteNote.getNotes())%>
        </td>
      </tr>
    <%}%>
    </table>
    <br />
    <dhv:hasAuthority owner="<%= opportunityHeader.getManagerOwnerIdRange() %>">
    <dhv:evaluate if="<%= !quote.isTrashed() %>" >
      <dhv:evaluate if="<%= quote.getClosed() == null%>" >
        <dhv:permission name="pipeline-opportunities-edit">
        <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
          <tr>
            <th width="100%">
              <strong><dhv:label name="quotes.notes.addNewNote">Add a new note</dhv:label></strong><br />
            </th>
          </tr>
          <tr class="containerBody">
            <td>
              <table border="0" cellpadding="0" cellspacing="0" class="empty"><tr><td valign="top">
                <textarea name="notes" rows="5" cols="65"></textarea>
              </td><td valign="top" nowrap>&nbsp;
                <font color="red">*</font><%= showAttribute(request, "notesError") %>
              </td></tr></table>
            </td>
          </tr>
        </table>
        </dhv:permission>
        <br />
        <dhv:permission name="pipeline-opportunities-edit"><input type="submit" value="<dhv:label name="button.save">Save</dhv:label>"/></dhv:permission>
        <input type="button" value="<dhv:label name="button.cancel">Cancel</dhv:label>" onClick="javascript:window.location.href='LeadsQuotes.do?command=Details&quoteId=<%= quote.getId() %>&orgId=<%= OrgDetails.getOrgId()%>&version=<%= version %><%= addLinkParams(request, "viewSource") %>'"/>
      </dhv:evaluate>
    </dhv:evaluate>
  </dhv:hasAuthority>
  </dhv:container>
</dhv:container>
</form>
