<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.communications.base.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="Campaign" class="org.aspcfs.modules.communications.base.Campaign" scope="request"/>
<jsp:useBean id="SurveyResponseListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<jsp:useBean id="SurveyResponseList" class="org.aspcfs.modules.communications.base.SurveyResponseList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<a href="CampaignManager.do">Communications Manager</a> >
<a href="CampaignManager.do?command=Dashboard">Dashboard</a> >
<a href="CampaignManager.do?command=Details&id=<%=Campaign.getId()%>">Campaign Details</a> >
Response
<hr color="#BFBFBB" noshade>
<strong>Campaign: </strong><%= toHtml(Campaign.getName()) %>
<% String param1 = "id=" + Campaign.getId(); %>
<dhv:container name="communications" selected="response" param="<%= param1 %>" style="tabs"/>
<table cellpadding="4" cellspacing="0" width="100%">
  <tr>
    <td class="containerBack">
<center><%= SurveyResponseListInfo.getAlphabeticalPageLinks() %></center>
<dhv:pagedListStatus title="<%= showAttribute(request, "actionError") %>" object="SurveyResponseListInfo"/>
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <tr>
    <th width="20%" nowrap>
      <strong><a href="CampaignManager.do?command=ViewResponse&id=<%= Campaign.getId() %>&column=c.namelast">Name</a></strong>
      <%= SurveyResponseListInfo.getSortIcon("c.namelast") %>
    </th>
    <th nowrap>
      <strong><a href="CampaignManager.do?command=ViewResponse&id=<%= Campaign.getId() %>&column=sr.entered">Submitted</a></strong>
      <%= SurveyResponseListInfo.getSortIcon("sr.entered") %>
    </th>
    <th nowrap><strong>IP Address</strong></th>
    <th nowrap><strong>Email Address</strong></th>
    <th nowrap><strong>Phone Number</strong></th>
  </tr>
<%
  Iterator j = SurveyResponseList.iterator();
  if ( j.hasNext() ) {
    int rowid = 0;
    while (j.hasNext()) {
      rowid = (rowid != 1?1:2);
      SurveyResponse thisResponse = (SurveyResponse) j.next();
%>      
    <tr class="row<%= rowid %>">
      <td width="30" nowrap>
        <a href="CampaignManager.do?command=ResponseDetails&id=<%= Campaign.getId() %>&contactId=<%= thisResponse.getContactId() %>&responseId=<%= thisResponse.getId() %>"><%= toHtml(thisResponse.getContact().getNameLastFirst()) %></a>
      </td>
      <td nowrap>
        <%= toDateTimeString(thisResponse.getEntered()) %>&nbsp;
      </td>
      <td>
        <%= toHtml(thisResponse.getIpAddress()) %>&nbsp;
      </td>
      <td nowrap>
        <%= thisResponse.getContact().getEmailAddress("Business") %>&nbsp;
      </td>
      <td nowrap>
        <%= thisResponse.getContact().getPhoneNumber("Business") %>&nbsp;
      </td>
    </tr>
<%}%>
  </table>
  <br>
  <dhv:pagedListControl object="SurveyResponseListInfo"/>
<%} else {%>
    <tr class="containerBody">
      <td colspan="7">
        No Response Found.
      </td>
    </tr>
  </table>
<%}%>
</td>
</tr>
</table>

