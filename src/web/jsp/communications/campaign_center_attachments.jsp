<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.communications.base.*" %>
<jsp:useBean id="Campaign" class="org.aspcfs.modules.communications.base.Campaign" scope="request"/>
<jsp:useBean id="SurveyList" class="org.aspcfs.modules.communications.base.SurveyList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript">
function fillFrame(object){
  if(object.options[object.selectedIndex].value != -1){
    window.frames['edit'].location.href='CampaignManager.do?command=PreviewSurvey&preview=1&id=' + object.options[object.selectedIndex].value + '&inline=true';
  }else{
    window.frames['edit'].location.href='CampaignManager.do?command=PreviewSurvey&preview=0&id=' + object.options[object.selectedIndex].value + '&inline=true';
  }
}
function updateList() {
  var sel = document.forms['modForm'].elements['ListView'];
  var value = sel.options[sel.selectedIndex].value;
  var url = "CampaignManager.do?command=SurveyJSList&listView=" + escape(value);
  window.frames['server_commands'].location.href=url;
}
</script>
<body onLoad="javascript:fillFrame(document.forms['modForm'].surveyId);">
<form name="modForm" action="CampaignManager.do?command=InsertAttachment&id=<%= Campaign.getId() %>" method="post">
<a href="CampaignManager.do">Communications Manager</a> >
<a href="CampaignManager.do?command=View">Campaign List</a> >
<a href="CampaignManager.do?command=ViewDetails&id=<%= Campaign.getId() %>">Campaign Details</a> >
<a href="CampaignManager.do?command=ViewAttachmentsOverview&id=<%= Campaign.getId() %>">Attachments</a> >
Surveys
<hr color="#BFBFBB" noshade>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>
  <tr class="containerHeader">
    <td>
      <strong>Campaign: </strong><%= toHtml(Campaign.getName()) %>
    </td>
  </tr>
  <tr>
    <td width="100%" class="containerBack">
      <ul>
        <li>Choose a survey that will be sent to the campaign groups</li>
        <li>Click "Update Campaign Attachment" to save changes</li>
        <li>Surveys can be created or edited in the <a href="CampaignManagerAttachment.do">Create Attachments</a> utility</li>
      </ul>
<dhv:permission name="campaign-campaigns-edit">
<input type="submit" value="Save Changes" name="Save"><br>
&nbsp;<br>
</dhv:permission>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr bgcolor="#DEE0FA">
    <td colspan="2" valign="center" align="left">
      <strong>Select a survey for this campaign</strong>
    </td>     
  </tr>
  <tr class="containerBody">
    <td width="50" valign="center" nowrap class="formLabel">
      Survey
    </td>
    <td width="100%" valign="center">
    <SELECT SIZE="1" name="ListView" onChange="javascript:updateList();">
      <OPTION VALUE="my"<dhv:evaluate if="<%= "my".equals((String) request.getAttribute("listView")) %>"> selected</dhv:evaluate>>My Surveys</OPTION>
      <OPTION VALUE="all"<dhv:evaluate if="<%= "all".equals((String) request.getAttribute("listView")) %>"> selected</dhv:evaluate>>All Surveys</OPTION>
    </SELECT>
    <% SurveyList.setJsEvent("onChange=\"javascript:fillFrame(this);\""); %>
      <%= SurveyList.getHtmlSelect("surveyId", Campaign.getSurveyId()) %>
    </td>
  </tr>
  <tr class="containerBody">
    <td width="50" valign="top" nowrap class="formLabel">
      Preview
    </td>
    <td width="100%" valign="center">
      <iframe id="edit" name="edit" frameborder="0" <dhv:browser id="ns">width="100%" height="200"</dhv:browser> <dhv:browser id="ie">style="border: 1px solid #cccccc; width: 100%; height: 100%;"</dhv:browser> onblur="return false" src="">
      </iframe>
    </td>
  </tr>
  
</table>
<dhv:permission name="campaign-campaigns-edit">
<br>
<input type="submit" value="Save Changes" name="Save">
</dhv:permission>
  </td>
  </tr>
</table>
</form>
