<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.communications.base.*" %>
<jsp:useBean id="Campaign" class="org.aspcfs.modules.communications.base.Campaign" scope="request"/>
<jsp:useBean id="DeliveryList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<body onLoad="document.inputForm.activeDate.focus()">
<script language="JavaScript" type="text/javascript" src="javascript/checkDate.js"></script>
<script language="JavaScript" type="text/javascript" src="javascript/popCalendar.js"></script>
<script language="JavaScript">
  function checkForm(form) {
    formTest = true;
    message = "";
    if ((!form.activeDate.value == "") && (!checkDate(form.activeDate.value))) { 
      message += "- Check that the Run Date is entered correctly\r\n";
      formTest = false;
    }
    if (formTest == false) {
      alert("Form could not be saved, please check the following:\r\n\r\n" + message);
      return false;
    } else {
      return true;
    }
  }
</script>
<form name="inputForm" action="CampaignManager.do?command=InsertSchedule&id=<%= Campaign.getId() %>" method="post" onSubmit="return checkForm(this);">
<a href="CampaignManager.do">Communications Manager</a> > 
<a href="CampaignManager.do?command=View">Campaign List</a> >
<a href="CampaignManager.do?command=ViewDetails&id=<%= Campaign.getId() %>">Campaign Details</a> >
Delivery
<hr color="#BFBFBB" noshade>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
      <strong>Campaign: </strong><%= toHtml(Campaign.getName()) %>
    </td>
  </tr>
  <tr>
    <td class="containerBack">
<dhv:permission name="campaign-campaigns-edit">
<input type="submit" name="Save" value="Update Campaign Schedule">
</dhv:permission>
<input type="button" value="Cancel" onClick="javascript:window.location.href='CampaignManager.do?command=ViewDetails&id=<%= Campaign.getId() %>'"><br>
&nbsp;<br>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan="2">
      <strong>Delivery Options</strong>
    </td>     
  </tr>
  <tr class="containerBody">
    <td class="formLabel" valign="center" nowrap>
      Run Date
    </td>
    <td>
      <input type="text" size="10" name="activeDate" value="<%= toHtmlValue(Campaign.getActiveDateString()) %>">
      <dhv:permission name="campaign-campaigns-edit"><a href="javascript:popCalendar('inputForm', 'activeDate');">Date</a> (mm/dd/yyyy)</dhv:permission>
    </td>
  </tr>
  <tr class="containerBody">
      <td class="formLabel" valign="center" nowrap>
      Delivery Method
    </td>
    <td>
      <%= DeliveryList.getHtmlSelect("sendMethodId",Campaign.getSendMethodId() ) %>
    </td>
  </tr>
</table>
<br>
<dhv:permission name="campaign-campaigns-edit">
<input type="submit" name="Save" value="Update Campaign Schedule">
</dhv:permission>
<input type="button" value="Cancel" onClick="javascript:window.location.href='CampaignManager.do?command=ViewDetails&id=<%= Campaign.getId() %>'">
  </td>
  </tr>
</table>
</form>
</body>
