<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="Project" class="com.zeroio.iteam.base.Project" scope="request"/>
<%@ include file="initPage.jsp" %>
<table border='0' width='100%'  bgcolor='#000000' cellspacing='0' cellpadding='0'>
  <tr>
    <td width='100%' bgcolor='#003399'>
      <font color='#FFFFFF'>&nbsp;<b>Issues</b></font>
    </td>
  </tr>
</table>
   
<table border='0' width='100%' cellpadding='0' cellspacing='0'>
  <tr>
    <td width='5' bgcolor='#808080' nowrap>&nbsp;</td>
    <td width="100%" bgcolor='#808080' nowrap><font color='#FFFFFF'>&lt;Subject&gt;</font></td>
    <td align='left' bgcolor='#808080' nowrap><font color='#FFFFFF'>&lt;Replies&gt;</font></td>
    <td bgcolor='#808080' nowrap><font color='#FFFFFF'>&lt;Posted By&gt;</font></td>
    <td bgcolor='#808080' nowrap><font color='#FFFFFF'>&lt;Latest Date&gt;</font></td>
  </tr>
<%    
  String bgColorVar = " bgColor='#E4E4E4'";
  IssueList issues = Project.getIssues();
  Iterator i = issues.iterator();
  while (i.hasNext()) {
  
    Issue thisIssue = (Issue)i.next();
%>    
  <tr<%= bgColorVar %>>
    <td width='5' valign='top' nowrap>&nbsp;</td>
    <td width="100%" valign='top' align='left'><a href="/ProjectManagementIssues.do?command=Details&pid=<%= thisIssue.getProjectId() %>&iid=<%= thisIssue.getId() %>"><%= toHtml(thisIssue.getSubject()) %></a> (<%= toHtml(thisIssue.getCategory()) %>)</td>
    <td valign='top' align='center' nowrap><%= ((thisIssue.getReplyCount()==0)?"-":""+thisIssue.getReplyCount()) %></td>
    <td valign='top' align='left' nowrap>&nbsp; <%= thisIssue.getUser() %> &nbsp;</td>
    <td valign='top' align='left' nowrap><%= thisIssue.getReplyDateTimeString() %></td>
  </tr>
<%    
    if (bgColorVar.equals(" bgColor='#E4E4E4'")) {
      bgColorVar = "";
    } else {
      bgColorVar = " bgColor='#E4E4E4'";
    }
  }
%>
</table>
&nbsp;<br>
<hr color='#000000' width='100%' noshade size='1'>
  
