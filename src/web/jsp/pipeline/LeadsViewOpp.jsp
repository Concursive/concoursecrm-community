<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.utils.web.HtmlSelect" %>
<%@ page import="org.aspcfs.modules.pipeline.base.*" %>
<%@ page import="com.zeroio.iteam.base.*" %>
<%@ page import="org.aspcfs.modules.pipeline.beans.OpportunityBean" %>
<jsp:useBean id="OpportunityList" class="org.aspcfs.modules.pipeline.base.OpportunityList" scope="request"/>
<jsp:useBean id="OpportunityListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="PipelineViewpointInfo" class="org.aspcfs.utils.web.ViewpointInfo" scope="session"/>
<jsp:useBean id="TypeSelect" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="UserList" class="org.aspcfs.modules.admin.base.UserList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>
<%@ include file="LeadsViewOpp_menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<script language="JavaScript" type="text/javascript">
  <%-- Preload image rollovers for drop-down menu --%>
  loadImages('select');
</script>
<%-- Trails --%>
<table class="trails">
<tr>
<td>
<a href="Leads.do">Pipeline</a> >
View Components
</td>
</tr>
</table>
<%-- End Trails --%>
<dhv:evaluate exp="<%= PipelineViewpointInfo.isVpSelected(User.getUserId()) %>">
  <b>Viewpoint: </b><b class="highlight"><%= PipelineViewpointInfo.getVpUserName() %></b><br>
  &nbsp;<br>
</dhv:evaluate>
<dhv:permission name="pipeline-opportunities-add"><a href="Leads.do?command=Prepare&source=list">Add an Opportunity</a></dhv:permission>
<center><%= OpportunityListInfo.getAlphabeticalPageLinks() %></center>
<table width="100%" border="0">
  <tr>
    <form name="listView" method="post" action="Leads.do?command=ViewOpp">
    <td align="left">
      <select size="1" name="listView" onChange="javascript:document.forms[0].submit();">
        <option <%= OpportunityListInfo.getOptionValue("my") %>>My Open Opportunities</option>
        <option <%= OpportunityListInfo.getOptionValue("all") %>>All Open Opportunities</option>
        <option <%= OpportunityListInfo.getOptionValue("closed") %>>All Closed Opportunities</option>
	      <dhv:evaluate if="<%= (!OpportunityListInfo.getSavedCriteria().isEmpty()) %>">
          <option <%= OpportunityListInfo.getOptionValue("search") %>>Search Results</option>
        </dhv:evaluate>
      </select>
			<% TypeSelect.setJsEvent("onChange=\"javascript:document.forms[0].submit();\""); %>
      <%=TypeSelect.getHtmlSelect("listFilter1", OpportunityListInfo.getFilterKey("listFilter1"))%>
      <dhv:evaluate if="<%= "all".equals(OpportunityListInfo.getListView()) || "closed".equals(OpportunityListInfo.getListView()) %>">
      <% UserList.setJsEvent("onChange=\"javascript:document.forms[0].submit();\""); 
         HtmlSelect userSelect = UserList.getHtmlSelectObj("listFilter2", OpportunityListInfo.getFilterKey("listFilter2"));
         userSelect.addItem(-1, "All Users", 0);
      %>
      <%= userSelect.getHtml("listFilter2", OpportunityListInfo.getFilterKey("listFilter2")) %>
      </dhv:evaluate>
    </td>
    <td>
      <dhv:pagedListStatus title="<%= showError(request, "actionError") %>" object="OpportunityListInfo"/>
    </td>
    </form>
  </tr>
</table>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
  <tr>
    <th valign="center">
      <strong>Action</strong>
    </th>
    <th valign="center" nowrap>
      <strong><a href="Leads.do?command=ViewOpp&column=x.description">Component</a></strong>
      <%= OpportunityListInfo.getSortIcon("x.description") %>
    </th>
    <th valign="center" nowrap>
      <strong><a href="Leads.do?command=ViewOpp&column=guessvalue">Amount</a></strong>
      <%= OpportunityListInfo.getSortIcon("guessvalue") %>
    </th>
    <th valign="center" nowrap>
      <strong><a href="Leads.do?command=ViewOpp&column=closeprob">Prob.</a></strong>
      <%= OpportunityListInfo.getSortIcon("closeprob") %>
    </th>
    <th valign="center" nowrap>
      <strong><a href="Leads.do?command=ViewOpp&column=closedate">Close Date</a></strong>
      <%= OpportunityListInfo.getSortIcon("closedate") %>
    </th>
    <th valign="center" nowrap>
      <strong><a href="Leads.do?command=ViewOpp&column=terms">Term</a></strong>
      <%= OpportunityListInfo.getSortIcon("terms") %>
    </th>
    <th valign="center" nowrap>
      <strong>Organization</strong>
    </th>
    <th valign="center" nowrap>
      <strong><a href="Leads.do?command=ViewOpp&column=ct.namelast">Contact</a></strong>
      <%= OpportunityListInfo.getSortIcon("ct.namelast") %>
    </th>
  </tr>
<%
	Iterator j = OpportunityList.iterator();
  FileItem thisFile = new FileItem();
	if ( j.hasNext() ) {
		int rowid = 0;
    int i =0;
    while (j.hasNext()) {
      i++;
		  rowid = (rowid != 1?1:2);
      OpportunityBean thisOpp = (OpportunityBean) j.next();
%>      
	<tr bgcolor="white">
    <td width="8" valign="top" nowrap class="row<%= rowid %>">
      <%-- Use the unique id for opening the menu, and toggling the graphics --%>
       <a href="javascript:displayMenu('menuOpp', '<%= thisOpp.getHeader().getId() %>','<%= thisOpp.getComponent().getId() %>');"
       onMouseOver="over(0, <%= i %>)" onmouseout="out(0, <%= i %>)"><img src="images/select.gif" name="select<%= i %>" align="absmiddle" border="0"></a>
    </td>
    <td width="33%" valign="top" class="row<%= rowid %>">
      <a href="Leads.do?command=DetailsOpp&headerId=<%= thisOpp.getHeader().getId() %>&reset=true">
      <%= toHtml(thisOpp.getComponent().getDescription()) %></a>
      <dhv:evaluate if="<%= thisOpp.getHeader().hasFiles() %>">
        <%= thisFile.getImageTag()%>
      </dhv:evaluate>
    </td>
    <td valign="top" align="right" nowrap class="row<%= rowid %>">
      $<%= thisOpp.getComponent().getGuessCurrency() %>
    </td>
    <td valign="top" align="center" nowrap class="row<%= rowid %>">
      <%= thisOpp.getComponent().getCloseProbValue() %>%
    </td>
    <td valign="top" align="center" nowrap class="row<%= rowid %>">
      <dhv:tz timestamp="<%= thisOpp.getComponent().getCloseDate() %>" dateOnly="true" dateFormat="<%= DateFormat.SHORT %>" default="&nbsp;"/>
    </td>
    <td valign="top" align="center" nowrap class="row<%= rowid %>">
      <%= toHtml(thisOpp.getComponent().getTermsString()) %>
    </td>
    <td width="33%" valign="top" class="row<%= rowid %>">
      <dhv:evaluate if="<%= thisOpp.getHeader().getAccountLink() > -1 %>">
        <a href="Opportunities.do?command=View&orgId=<%= thisOpp.getHeader().getAccountLink() %>">
          <%= toHtml(thisOpp.getHeader().getAccountName()) %>
        </a>
      </dhv:evaluate>
      <dhv:evaluate if="<%= thisOpp.getHeader().getContactLink() > -1 && hasText(thisOpp.getHeader().getContactCompanyName()) %>">
        <a href="ExternalContactsOpps.do?command=ViewOpps&contactId=<%= thisOpp.getHeader().getContactLink() %>">
          <%= toHtml(thisOpp.getHeader().getContactCompanyName()) %>
        </a>
      </dhv:evaluate>
      &nbsp;
    </td>
    <td width="33%" valign="top" class="row<%= rowid %>">
      <dhv:evaluate if="<%= thisOpp.getHeader().getContactLink() > -1 %>">
        <a href="ExternalContactsOpps.do?command=ViewOpps&contactId=<%= thisOpp.getHeader().getContactLink() %>">
          <%= toHtml(thisOpp.getHeader().getContactName()) %>
        </a>
      </dhv:evaluate>
      &nbsp;
    </td>
  </tr>
<%
    }
  } else {%>
  <tr class="containerBody">
    <td colspan="8" valign="center">No opportunities found.</td>
  </tr>
<%}%>
</table>
<br>
<dhv:pagedListControl object="OpportunityListInfo" tdClass="row1"/>

