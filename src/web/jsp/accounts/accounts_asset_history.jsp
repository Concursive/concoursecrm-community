<%-- 
  - Copyright Notice: (C) 2000-2004 Dark Horse Ventures, All Rights Reserved.
  - License: This source code cannot be modified, distributed or used without
  -          written permission from Dark Horse Ventures. This notice must
  -          remain in place.
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.utils.web.*, org.aspcfs.modules.assets.base.*, org.aspcfs.modules.troubletickets.base.* " %>
<jsp:useBean id="asset" class="org.aspcfs.modules.assets.base.Asset" scope="request"/>
<jsp:useBean id="ticketList" class="org.aspcfs.modules.troubletickets.base.TicketList" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="AssetHistoryInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" type="text/javascript">
</script>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
  <a href="Accounts.do"><dhv:label name="accounts.accounts">Accounts</dhv:label></a> > 
  <a href="Accounts.do?command=Search">Search Results</a> >
  <a href="Accounts.do?command=Details&orgId=<%= OrgDetails.getOrgId() %>"><dhv:label name="accounts.details">Account Details</dhv:label></a> >
  <a href="AccountsAssets.do?command=List&orgId=<%= OrgDetails.getOrgId() %>">Assets</a> >
  Asset History
</td>
</tr>
</table>
<%-- End Trails --%>
<%@ include file="accounts_details_header_include.jsp" %>
<dhv:container name="accounts" selected="assets" param="<%= "orgId=" + asset.getOrgId() %>" style="tabs"/>
<table cellpadding="4" cellspacing="0" border="0" width="100%">
  <tr>
    <td class="containerBack">
      <% String param2 = "id=" + asset.getId(); %>
      [ <dhv:container name="accountsassets" selected="history" param="<%= param2 %>"/> ]
      <br /><br />
<dhv:pagedListStatus title="<%= showError(request, "actionError") %>" object="AssetHistoryInfo"/>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
  <tr>
    <th width="12%">
      <strong><dhv:label name="accounts.tickets.number">Ticket Number</dhv:label></strong>
    </th>
    <th width="12%">
      <b><a href="AccountsAssets.do?command=History&id=<%=asset.getId()%>&column=t.entered">Date Entered</a></b>
      <%= AssetHistoryInfo.getSortIcon("t.entered") %>
    </th>
    <th width="32%">
      <strong>Issue</strong>
    </th>
    <th width="12%" nowrap>
      <b><a href="AccountsAssets.do?command=History&id=<%=asset.getId()%>&column=closed">Date Closed</a></b>
      <%= AssetHistoryInfo.getSortIcon("closed") %>
    </th>
    <th width="32%" nowrap>
      <strong>Resolution</strong>
    </th>
  </tr>
  <% 
    Iterator itr = ticketList.iterator();
    if (itr.hasNext()){
      int rowid = 0;
      int i = 0;
      while (itr.hasNext()){
        i++;
        rowid = (rowid != 1 ? 1 : 2);
        Ticket thisTicket = (Ticket)itr.next();
    %>    
  <tr valign="top" class="row<%=rowid%>">
    <td width=8 valign="center"  nowrap >
        <dhv:permission name="accounts-accounts-tickets-view"><a href="AccountTickets.do?command=TicketDetails&id=<%=thisTicket.getId()%>"></dhv:permission><%=thisTicket.getPaddedId() %><dhv:permission name="accounts-accounts-tickets-view"></a></dhv:permission>
    </td>
    <td width="12%" >
      <zeroio:tz timestamp="<%= thisTicket.getEntered() %>" dateOnly="true" default="&nbsp;"/>
		</td>
    <td width="32%" >
      <%=toHtml(thisTicket.getProblem())%>
		</td>
		<td width="12%" >
    <zeroio:tz timestamp="<%= thisTicket.getClosed() %>" dateOnly="true" default="&nbsp;"/>
		</td>
		<td width="32%" >
      <%= toHtml(thisTicket.getSolution()) %>
		</td>
   </tr>
   <%}
   }else{%>
   <tr>
		<td colspan="5">
      There is no maintenance or service history for this asset.
		</td>
   </tr>
   <%}%>
</table>
<br>
<dhv:pagedListControl object="AssetHistoryInfo"/>
 </td>
</tr>
</table>
