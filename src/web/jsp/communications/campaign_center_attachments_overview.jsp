<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*" %>
<jsp:useBean id="Campaign" class="com.darkhorseventures.cfsbase.Campaign" scope="request"/>
<jsp:useBean id="Survey" class="com.darkhorseventures.cfsbase.Survey" scope="request"/>
<jsp:useBean id="FileItemList" class="com.zeroio.iteam.base.FileItemList" scope="request"/>
<%@ include file="initPage.jsp" %>
<form name="modForm" action="/CampaignManager.do?command=InsertAttachment&id=<%= Campaign.getId() %>" method="post">
<a href="CampaignManager.do">Communications Manager</a> >
<a href="/CampaignManager.do?command=View">Campaign List</a> >
<a href="/CampaignManager.do?command=ViewDetails&id=<%= Campaign.getId() %>">Campaign Details</a> >
Attachments
<hr color="#BFBFBB" noshade>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
      <strong>Campaign: </strong><%= toHtml(Campaign.getName()) %>
    </td>
  </tr>
  <tr>
    <td width="100%" class="containerBack">
      <ul>
        <li>Choose from any of the following attachment types to include with your Message</li>
        <li>Certain attachments must be created or edited in the <a href="CampaignManagerAttachment.do">Create Attachments</a> utility</li>
      </ul>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr bgcolor="#DEE0FA">
    <td colspan="2" valign="center" align="left">
      <strong>Configured attachments for this campaign</strong>
    </td>     
  </tr>
  <tr class="containerBody">
    <td width="50" valign="top" nowrap class="formLabel">
      Interactive Responses
    </td>
    <td width="100%" valign="top">
      <dhv:evaluate if="<%= Campaign.hasSurvey() %>">
        Added: <%= Survey.getName() %>&nbsp;
      </dhv:evaluate>
      <a href="CampaignManager.do?command=ViewAttachment&id=<%= Campaign.getId() %>">
        Click to change interactive response attachment
      </a>
    </td>
  </tr>
  <tr class="containerBody">
    <td width="50" valign="top" nowrap class="formLabel">
      File Attachments
    </td>
    <td width="100%" valign="top">
      <dhv:evaluate if="<%= Campaign.hasFiles() %>">
        Added: A bunch of files
      </dhv:evaluate>
      <a href="CampaignManager.do?command=ManageFileAttachments&id=<%= Campaign.getId() %>">  
        Click to change file attachments
      </a>
    </td>
  </tr>
</table>
&nbsp;<br>
<input type="button" value="Done" onClick="javascript:window.location.href='CampaignManager.do?command=ViewDetails&id=<%= Campaign.getId() %>'">
  </td>
  </tr>
</table>
</form>
