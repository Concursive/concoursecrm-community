<jsp:useBean id="OrgDetails" class="com.darkhorseventures.cfsbase.Organization" scope="request"/>
<jsp:useBean id="OppDetails" class="com.darkhorseventures.cfsbase.Opportunity" scope="request"/>
<jsp:useBean id="StageList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="BusTypeList" class="com.darkhorseventures.webutils.HtmlSelect" scope="request"/>
<jsp:useBean id="UnitTypeList" class="com.darkhorseventures.webutils.HtmlSelect" scope="request"/>
<%@ include file="initPage.jsp" %>
<body onLoad="javascript:document.forms[0].description.focus();">
<script language="JavaScript" TYPE="text/javascript" SRC="/javascript/checkDate.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="/javascript/popCalendar.js"></script>
<script language="JavaScript">
  function checkForm(form) {
      formTest = true;
      message = "";
      if ((!form.closeDate.value == "") && (!checkDate(form.closeDate.value))) { 
        message += "- Check that Est. Close Date is entered correctly\r\n";
        formTest = false;
      }
      if ((!form.alertDate.value == "") && (!checkDate(form.alertDate.value))) { 
        message += "- Check that Alert Date is entered correctly\r\n";
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
<form name="addOpportunity" action="/Opportunities.do?command=Insert&auto-populate=true" method="post" onSubmit="return checkForm(this);">
<a href="/Opportunities.do?command=View&orgId=<%= OrgDetails.getOrgId() %>">Back to Opportunity List</a><br>&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
      <strong><%= toHtml(OrgDetails.getName()) %></strong>
    </td>
  </tr>
  <tr class="containerMenu">
    <td>
      <a href="/Accounts.do?command=Details&orgId=<%=OrgDetails.getOrgId()%>"><font color="#000000">Details</font></a> | 
      <a href="/Accounts.do?command=Fields&orgId=<%= OrgDetails.getOrgId() %>"><font color="#000000">Folders</font></a> |
      <font color="#787878">Activities</font> | 
      <a href="/Contacts.do?command=View&orgId=<%=OrgDetails.getOrgId()%>"><font color="#000000">Contacts</font></a> | 
      <a href="/Opportunities.do?command=View&orgId=<%=OrgDetails.getOrgId()%>"><font color="#0000FF">Opportunities</font></a> | 
      <a href="/Accounts.do?command=ViewTickets&orgId=<%= OrgDetails.getOrgId() %>"><font color="#000000">Tickets</font></a> |
      <font color="#787878">Documents</font> 
    </td>
  </tr>
  <tr>
    <td class="containerBack">
<input type="submit" value="Save">
<input type="submit" value="Cancel" onClick="javascript:this.form.action='/Opportunities.do?command=View&orgId=<%= OrgDetails.getOrgId() %>'">
<input type="reset" value="Reset">
<br>
&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan=2 valign=center align=left>
      <strong>Add a New Opportunity</strong>
    </td>     
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Description
    </td>
    <td width="100%">
      <input type=text size=35 name="description" value="<%= toHtmlValue(OppDetails.getDescription()) %>">
      <font color=red>*</font> <%= showAttribute(request, "descriptionError") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Type of Business
    </td>
    <td>
      <%= BusTypeList.getHtml() %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Prob. of Close
    </td>
    <td>
      <input type=text size=5 name="closeProb" value="<%= OppDetails.getCloseProbValue() %>">%
      <font color=red>*</font> <%= showAttribute(request, "closeProbError") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Est. Close Date
    </td>
    <td>
      <input type=text size=10 name="closeDate" value="<%= toHtmlValue(OppDetails.getCloseDateString()) %>">
      <a href="javascript:popCalendar('addOpportunity', 'closeDate');">Date</a> (mm/dd/yyyy)
      <font color=red>*</font> <%= showAttribute(request, "closeDateError") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Low Estimate
    </td>
    <td>
      <input type=text size=10 name="low" value="<%= toHtmlValue(OppDetails.getLowAmount()) %>">
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Best Guess Estimate
    </td>
    <td>
      <input type=text size=10 name="guess" value="<%= toHtmlValue(OppDetails.getGuessAmount()) %>">
      <font color=red>*</font> <%= showAttribute(request, "guessError") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      High Estimate
    </td>
    <td>
      <input type=text size=10 name="high" value="<%= toHtmlValue(OppDetails.getHighAmount()) %>">
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Est. Terms
    </td>
    <td>
      <input type=text size=5 name="terms" value="<%= toHtmlValue(OppDetails.getTermsString()) %>">
      <%= UnitTypeList.getHtml() %>
      <font color="red">*</font> <%= showAttribute(request, "termsError") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Current Stage
    </td>
    <td>
       <%=StageList.getHtmlSelect("stage",0)%>
      <input type=checkbox name="closeNow">Close opportunity
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Est. Commission
    </td>
    <td>
      <input type=text size=5 name="commission" value="<%= OppDetails.getCommissionValue() %>">%
      <input type=hidden name="accountLink" value="<%=request.getParameter("orgId")%>">
      <input type=hidden name="orgId" value="<%=request.getParameter("orgId")%>">
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Alert Date
    </td>
    <td>
      <input type=text size=10 name="alertDate" value="<%= toHtmlValue(OppDetails.getAlertDateString()) %>">
      <a href="javascript:popCalendar('addOpportunity', 'alertDate');">Date</a> (mm/dd/yyyy)
    </td>
  </tr>
</table>
&nbsp;
<br>
<input type="submit" value="Save">
<input type="submit" value="Cancel" onClick="javascript:this.form.action='/Opportunities.do?command=View&orgId=<%= OrgDetails.getOrgId() %>'">
<input type="reset" value="Reset">
    </td>
  </tr>
</table>
</form>
</body>
