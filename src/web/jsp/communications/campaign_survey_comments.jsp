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
<%@ page import="java.util.*,org.aspcfs.modules.communications.base.*" %>
<jsp:useBean id="CommentListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="SurveyAnswerList" class="org.aspcfs.modules.communications.base.SurveyAnswerList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<%
  boolean openEnded =  "open".equalsIgnoreCase(request.getParameter("type"));
%>
<dhv:pagedListStatus title='<%= showAttribute(request, "actionError") %>' object="CommentListInfo"/>
<table cellpadding="4" cellspacing="0" width="100%" class="details">
  <tr>
    <th colspan="<%= openEnded ? "3" : "4"%>">
      <strong><dhv:label name="campaign.surveyComments">Survey Comments</dhv:label></strong>
    </th>
  </tr>
  <tr>
    <dhv:evaluate if="<%= !openEnded %>">
      <th width="20" style="text-align: left;" nowrap>
        <dhv:label name="campaign.answerProvided">Answer Provided</dhv:label>
      </th>
    </dhv:evaluate>
    <th width="100%" style="text-align: left;" nowrap>
      <dhv:label name="campaign.commentProvided">Comment Provided</dhv:label>
    </th>
    <th valign="center" style="text-align: left;" nowrap>
      <dhv:label name="campaign.user">User</dhv:label>
    </th>
    <th valign="center" style="text-align: left;" nowrap>
      <dhv:label name="accounts.accounts_calls_list.Entered">Entered</dhv:label>
    </th>
  </tr>
<%    
	Iterator i = SurveyAnswerList.iterator();
	if (i.hasNext()) {
    int rowid = 0;
		while (i.hasNext()) {
			rowid = (rowid != 1?1:2);
      SurveyAnswer thisAnswer = (SurveyAnswer)i.next();
%>      
   <tr class="row<%= rowid %>">
 <dhv:evaluate if="<%= !openEnded %>">
    <td valign="top" style="text-align: center;" class="row<%= rowid %>" nowrap>
      <%= thisAnswer.getQuantAns() != -1 ? thisAnswer.getQuantAns()+"" : "&nbsp;" %>
    </td>
  </dhv:evaluate>
    <td width="100%">
      <%=toHtml(thisAnswer.getComments())%>
    </td>
    <td valign="center" style="text-align: left;" nowrap>
      <dhv:contactname id="<%=thisAnswer.getContactId()%>" listName="SurveyContactList"/>
    </td>
    <td valign="center" style="text-align: left;" nowrap>
      <%= toDateString(thisAnswer.getEntered()) %>
    </td>
  </tr>
<%
   }
%>
</table>
    <br>
    <dhv:pagedListControl object="CommentListInfo" />
  <%} else {%>  
  <tr>
    <td class="containerBody" colspan="<%= openEnded ? "3" : "4" %>">
      <dhv:label name="campaign.noCommentsForQuestion.text">No comments found for this question.</dhv:label>
    </td>
  </tr>
  </table>
<%}%>
<br>
<input type="button" value="<dhv:label name="button.closeWindow">Close Window</dhv:label>" onClick="javascript:window.close();">
