<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*" %>
<%@ page import="org.aspcfs.modules.pipeline.base.*" %>
<%@ page import="com.zeroio.iteam.base.*" %>
<%@ page import="org.aspcfs.modules.pipeline.beans.OpportunityBean" %>
<jsp:useBean id="OpportunityList" class="org.aspcfs.modules.pipeline.base.OpportunityList" scope="request"/>
<jsp:useBean id="OpportunityListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="PipelineViewpointInfo" class="org.aspcfs.utils.web.ViewpointInfo" scope="session"/>
<jsp:useBean id="TypeSelect" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<a href="Leads.do">Pipeline Management</a> > 
View Opportunities<br>
<hr color="#BFBFBB" noshade>
<dhv:evaluate exp="<%= PipelineViewpointInfo.isVpSelected(User.getUserId()) %>">
  <b>Viewpoint: </b><b class="highlight"><%= PipelineViewpointInfo.getVpUserName() %></b><br>
  &nbsp;<br>
</dhv:evaluate>
<dhv:permission name="pipeline-opportunities-add"><a href="Leads.do?command=AddOpp&source=list">Add an Opportunity</a></dhv:permission>
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
    </td>
    <td>
      <dhv:pagedListStatus title="<%= showError(request, "actionError") %>" object="OpportunityListInfo"/>
    </td>
    </form>
  </tr>
</table>
<table cellpadding="4" cellspacing="0" border="1" width="100%" class="pagedlist" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr bgcolor="#DEE0FA">
    <dhv:permission name="pipeline-opportunities-edit,pipeline-opportunities-delete">
    <td valign=center>
      <strong>Action</strong>
    </td>
    </dhv:permission>
    <td valign=center nowrap>
      <strong><a href="Leads.do?command=ViewOpp&column=acct_name">Organization</a></strong>
      <%= OpportunityListInfo.getSortIcon("acct_name") %>
    </td>    
    <td valign=center nowrap>
      <strong><a href="Leads.do?command=ViewOpp&column=x.description">Component</a></strong>
      <%= OpportunityListInfo.getSortIcon("x.description") %>
    </td>
    <td valign=center nowrap>
      <strong><a href="Leads.do?command=ViewOpp&column=guessvalue">Amount</a></strong>
      <%= OpportunityListInfo.getSortIcon("guessvalue") %>
    </td>
    <td valign=center nowrap>
      <strong><a href="Leads.do?command=ViewOpp&column=closeprob">Prob.</a></strong>
      <%= OpportunityListInfo.getSortIcon("closeprob") %>
    </td>
    <td valign=center nowrap>
      <strong><a href="Leads.do?command=ViewOpp&column=closedate">Start</a></strong>
      <%= OpportunityListInfo.getSortIcon("closedate") %>
    </td>
    <td valign=center nowrap>
      <strong><a href="Leads.do?command=ViewOpp&column=terms">Term</a></strong>
      <%= OpportunityListInfo.getSortIcon("terms") %>
    </td>
  </tr>
<%
	Iterator j = OpportunityList.iterator();
  FileItem thisFile = new FileItem();
	if ( j.hasNext() ) {
		int rowid = 0;
    while (j.hasNext()) {
		  rowid = (rowid != 1?1:2);
      OpportunityBean thisOpp = (OpportunityBean) j.next();
%>      
	<tr bgcolor="white">
	<dhv:permission name="pipeline-opportunities-edit,pipeline-opportunities-delete">
    <td width="8" valign="top" nowrap class="row<%= rowid %>">
      <dhv:permission name="pipeline-opportunities-edit"><a href="LeadsComponents.do?command=ModifyComponent&id=<%= thisOpp.getComponent().getId() %>&return=list">Edit</a></dhv:permission><dhv:permission name="pipeline-opportunities-edit,pipeline-opportunities-delete" all="true">|</dhv:permission><dhv:permission name="pipeline-opportunities-delete"><a href="javascript:popURLReturn('LeadsComponents.do?command=ConfirmComponentDelete&id=<%= thisOpp.getComponent().getId() %>&return=list&popup=true','Leads.do?command=ViewOpp', 'Delete_opp','320','200','yes','no');">Del</a></dhv:permission>
    </td>
	</dhv:permission>
    <td width="50%" valign="top" class="row<%= rowid %>">
      <dhv:evaluate exp="<%= thisOpp.getHeader().getAccountEnabled() && thisOpp.getHeader().getAccountLink() > -1 %>">
        <a href="Opportunities.do?command=View&orgId=<%= thisOpp.getHeader().getAccountLink() %>">
      </dhv:evaluate>
      <%= toHtml(thisOpp.getHeader().getAccountName()) %>
      <dhv:evaluate exp="<%= !thisOpp.getHeader().getAccountEnabled() && thisOpp.getHeader().getAccountLink() > -1 %>"><font color="red">*</font></dhv:evaluate>
      <dhv:evaluate exp="<%= thisOpp.getHeader().getAccountEnabled() && thisOpp.getHeader().getAccountLink() > -1 %>">
        </a>
      </dhv:evaluate>
    </td>  
    <td width="50%" valign="top" class="row<%= rowid %>">
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
      <%= toHtml(thisOpp.getComponent().getCloseDateString()) %>
    </td>
    <td valign="top" align="center" nowrap class="row<%= rowid %>">
      <%= toHtml(thisOpp.getComponent().getTermsString()) %>
    </td>      
  </tr>
<%
    }
  } else {%>
  <tr bgcolor="white">
    <td colspan="7" valign="center">No opportunities found.</td>
  </tr>
<%}%>
</table>
<br>
<dhv:pagedListControl object="OpportunityListInfo" tdClass="row1"/>

