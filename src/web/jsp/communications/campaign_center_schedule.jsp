<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*" %>
<jsp:useBean id="Campaign" class="com.darkhorseventures.cfsbase.Campaign" scope="request"/>
<jsp:useBean id="DeliveryList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<%@ include file="initPage.jsp" %>
<body onLoad="document.inputForm.activeDate.focus()">
<script language="JavaScript" type="text/javascript" src="/javascript/checkDate.js"></script>
<script language="JavaScript" type="text/javascript" src="/javascript/popCalendar.js"></script>
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
<form name="inputForm" action="/CampaignManager.do?command=InsertSchedule&id=<%= Campaign.getId() %>" method="post" onSubmit="return checkForm(this);">
<a href="/CampaignManager.do?command=View">Back to Campaign List</a><br>&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
      <strong><%= toHtml(Campaign.getName()) %></strong>
    </td>
  </tr>
  <tr class="containerMenu">
    <td>
      <% String param1 = "id=" + Campaign.getId(); %>      
      <dhv:container name="communications" selected="schedule" param="<%= param1 %>" />
    </td>
  </tr>
  <tr>
    <td class="containerBack">
<br>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan=2 valign=center align=left>
      <strong>Schedule when the campaign should start</strong>
    </td>     
  </tr>
  <tr class="containerBody">
    <td class="formLabel" valign="center" nowrap>
      Run Date
    </td>
    <td width="100%">
      <input type=text size=10 name="activeDate" value="<%= toHtmlValue(Campaign.getActiveDateString()) %>">
      <dhv:permission name="campaign-campaigns-edit"><a href="javascript:popCalendar('inputForm', 'activeDate');">Date</a> (mm/dd/yyyy)</dhv:permission><%--<br>
      <input type="checkbox" name="active" <%= Campaign.getActive("checked") %>>Ready to Run--%>
    </td>
  </tr>
  
  <tr class="containerBody">
      <td class="formLabel" valign="center" nowrap>
      Delivery Method
    </td>
    <td width="100%">
      <%=DeliveryList.getHtmlSelect("sendMethodId",Campaign.getSendMethodId() )%>
    </td>
  </tr>
  
</table>
<dhv:permission name="campaign-campaigns-edit">
<br>
<input type='submit' name="Save" value="Update Campaign Schedule">
</dhv:permission>
  </td>
  </tr>
</table>
</form>
