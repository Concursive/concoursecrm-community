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
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.communications.base.*" %>
<jsp:useBean id="CampaignSurveyListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="SurveyList" class="org.aspcfs.modules.communications.base.SurveyList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>
<%@ include file="campaign_surveys_view_menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></script>
<script language="JavaScript" type="text/javascript">
  <%-- Preload image rollovers for drop-down menu --%>
  loadImages('select');
</script>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="CampaignManager.do">Communications</a> >
<a href="CampaignManagerAttachment.do">Create Attachments</a> >
Surveys
</td>
</tr>
</table>
<%-- End Trails --%>
<dhv:permission name="campaign-campaigns-surveys-add"><a href="CampaignManagerSurvey.do?command=Add">Add a Survey</a></dhv:permission>
<dhv:permission name="campaign-campaigns-surveys-add" none="true"><br></dhv:permission>
<center><%= CampaignSurveyListInfo.getAlphabeticalPageLinks() %></center>
<table width="100%" border="0">
  <tr>
    <form name="listView" method="post" action="CampaignManagerSurvey.do?command=View">
    <td align="left">
      <select size="1" name="listView" onChange="javascript:document.forms[0].submit();">
        <option <%= CampaignSurveyListInfo.getOptionValue("my") %>>My Surveys</option>
        <option <%= CampaignSurveyListInfo.getOptionValue("all") %>>All Surveys</option>
      </select>
    </td>
    <td>
      <dhv:pagedListStatus title="<%= showError(request, "actionError") %>" object="CampaignSurveyListInfo"/>
    </td>
    </form>
  </tr>
</table>
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <tr>
   <th>
      <strong>Action</strong>
    </th>
    <th nowrap>
      <a href="CampaignManagerSurvey.do?command=View&column=name"><strong>Name</strong></a>
      <%= CampaignSurveyListInfo.getSortIcon("name") %>
    </th>  
    <th nowrap>
      <strong>Entered By</strong>
    </th>
    <th nowrap>
      <a href="CampaignManagerSurvey.do?command=View&column=s.modified"><strong>Last Modified</strong></a>
      <%= CampaignSurveyListInfo.getSortIcon("s.modified") %>
    </th>
  </tr>
<%    
	Iterator i = SurveyList.iterator();
	if (i.hasNext()) {
    int rowid = 0;
    int count = 0;
		while (i.hasNext()) {
      count++;
			rowid = (rowid != 1?1:2);
      Survey thisSurvey = (Survey)i.next();
%>      
      <tr>
        <td width="8" valign="center" nowrap class="row<%= rowid %>">
          <%-- Use the unique id for opening the menu, and toggling the graphics --%>
          <a href="javascript:displayMenu('select<%= count %>','menuSurvey', '<%= thisSurvey.getId() %>');"
          onMouseOver="over(0, <%= count %>)" onmouseout="out(0, <%= count %>); hideMenu('menuSurvey');"><img src="images/select.gif" name="select<%= count %>" id="select<%= count %>" align="absmiddle" border="0"></a>
        </td>
        <td class="row<%= rowid %>" width="100%" nowrap>
          <a href="CampaignManagerSurvey.do?command=Details&id=<%= thisSurvey.getId() %>"><%= toHtml(thisSurvey.getName()) %></a>
        </td>
        <td class="row<%= rowid %>" nowrap>
          <dhv:username id="<%= thisSurvey.getEnteredBy() %>"/>
        </td>
        <td class="row<%= rowid %>" nowrap>
          <zeroio:tz timestamp="<%= thisSurvey.getModified() %>" timeZone="<%= User.getTimeZone() %>" showTimeZone="yes"/>
        </td>
      </tr>
<%
    }
  } else {%>  
  <tr>
    <td class="containerBody" colspan="5">
      No surveys found.
    </td>
  </tr>
<%}%>
</table>
<br>
<dhv:pagedListControl object="CampaignSurveyListInfo" tdClass="row1"/>

