<%-- 
  - Copyright(c) 2004 Team Elements LLC (http://www.teamelements.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Team Elements LLC. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. TEAM ELEMENTS
  - LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL TEAM ELEMENTS LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Author(s): Matt Rajkowski
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.zeroio.iteam.base.*" %>
<%@ page import="com.zeroio.iteam.beans.SearchBean" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="searchBean" class="com.zeroio.iteam.beans.SearchBean" scope="session" />
<jsp:useBean id="searchBeanInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<%@ include file="../initPage.jsp" %>
<%!
  public static String selected(SearchBean search, int scope, int section) {
    if (search.getScope() == scope && search.getSection() == section) {
      return "selected";
    }
    return "";
  }
%>
<br />
<form name="search" action="ProjectManagementSearch.do?auto-populate=true" method="post">
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <b>Search</b>
    </th>
  </tr>
  <tr>
    <td class="formLabel">
      Scope
    </td>
    <td>
      <select name="scope" onChange="this.form.query.focus()">
      <dhv:evaluate if="<%= request.getAttribute("Project") != null && ((Project) request.getAttribute("Project")).getId() > -1 %>">
          <option value="this" <%= selected(searchBean, SearchBean.THIS, SearchBean.UNDEFINED) %>>This Project</option>
          <option value="thisNews" <%= selected(searchBean, SearchBean.THIS, SearchBean.NEWS) %>>&nbsp; News</option>
          <option value="thisDiscussion" <%= selected(searchBean, SearchBean.THIS, SearchBean.DISCUSSION) %>>&nbsp; Discussion</option>
          <option value="thisDocuments" <%= selected(searchBean, SearchBean.THIS, SearchBean.DOCUMENTS) %>>&nbsp; Documents</option>
          <option value="thisLists" <%= selected(searchBean, SearchBean.THIS, SearchBean.LISTS) %>>&nbsp; Lists</option>
          <option value="thisPlan" <%= selected(searchBean, SearchBean.THIS, SearchBean.PLAN) %>>&nbsp; Plan</option>
          <option value="thisTickets" <%= selected(searchBean, SearchBean.THIS, SearchBean.TICKETS) %>>&nbsp; Tickets</option>
          <option value="thisDetails" <%= selected(searchBean, SearchBean.THIS, SearchBean.DETAILS) %>>&nbsp; Details</option>
      </dhv:evaluate>
          <option value="all" <%= selected(searchBean, SearchBean.ALL, SearchBean.UNDEFINED) %>>All Project Data</option>
          <option value="allNews" <%= selected(searchBean, SearchBean.ALL, SearchBean.NEWS) %>>&nbsp; News</option>
          <option value="allDiscussion" <%= selected(searchBean, SearchBean.ALL, SearchBean.DISCUSSION) %>>&nbsp; Discussion</option>
          <option value="allDocuments" <%= selected(searchBean, SearchBean.ALL, SearchBean.DOCUMENTS) %>>&nbsp; Documents</option>
          <option value="allLists" <%= selected(searchBean, SearchBean.ALL, SearchBean.LISTS) %>>&nbsp; Lists</option>
          <option value="allPlan" <%= selected(searchBean, SearchBean.ALL, SearchBean.PLAN) %>>&nbsp; Plan</option>
          <option value="allTickets" <%= selected(searchBean, SearchBean.ALL, SearchBean.TICKETS) %>>&nbsp; Tickets</option>
          <option value="allDetails" <%= selected(searchBean, SearchBean.ALL, SearchBean.DETAILS) %>>&nbsp; Details</option>
      </select>
      <dhv:evaluate if="<%= request.getAttribute("Project") != null && ((Project) request.getAttribute("Project")).getId() > -1 %>">
          <input type="hidden" name="projectId" value="<%= ((Project) request.getAttribute("Project")).getId() %>" />
      </dhv:evaluate>
      <dhv:evaluate if="<%= request.getAttribute("Project") == null || ((Project) request.getAttribute("Project")).getId() == -1 %>">
        <input type="hidden" name="projectId" value="-1" />
      </dhv:evaluate>
    </td>
  </tr>
  <tr>
    <td class="formLabel">
      For
    </td>
    <td>
      <input type="text" size="15" name="query" value="<%= toHtmlValue(searchBean.getQuery()) %>" />
    </td>
  </tr>
</table>
<br />
<input type="submit" name="Search" value="Search" />
</form>
