<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<jsp:useBean id="StageList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="OrgList" class="com.darkhorseventures.cfsbase.OrganizationList" scope="request"/>
<jsp:useBean id="BusTypeList" class="com.darkhorseventures.webutils.HtmlSelect" scope="request"/>
<jsp:useBean id="UnitTypeList" class="com.darkhorseventures.webutils.HtmlSelect" scope="request"/>
<jsp:useBean id="OppDetails" class="com.darkhorseventures.cfsbase.Opportunity" scope="request"/>
<%@ include file="initPage.jsp" %>
<body onLoad="javascript:document.forms[0].description.focus();">
<script language="JavaScript" TYPE="text/javascript" SRC="/javascript/checkDate.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="/javascript/popCalendar.js"></script>
<script language="JavaScript" type="text/javascript" src="/javascript/popURL.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="/javascript/submit.js"></script>
<script language="JavaScript" type="text/javascript" src="/javascript/popContacts.js"></script>
<script language="JavaScript">
  function doCheck(form) {
    if (form.dosubmit.value == "false") {
      return true;
    } else {
      return(checkForm(form));
    }
  }
  function checkForm(form) {
      formTest = true;
      message = "";
        selected = -1;
        for (i=0; i<form.opp_type.length; i++) {
          if (form.opp_type[i].checked) {
            selected = i;
          }
        }
        if (selected == -1) {
            message += "- Please select an opportunity type (account or contact)\r\n";
            formTest = false;
        }

      if ((!form.closeDate.value == "") && (!checkDate(form.closeDate.value))) { 
        message += "- Check that Est. Close Date is entered correctly\r\n";
        formTest = false;
      }
      if ((!form.alertDate.value == "") && (!checkDate(form.alertDate.value))) { 
        message += "- Check that Alert Date is entered correctly\r\n";
        formTest = false;
      }
      if ((!form.alertDate.value == "") && (!checkAlertDate(form.alertDate.value))) { 
        message += "- Check that Alert Date is on or after today's date\r\n";
        formTest = false;
      }
      if ((!form.alertText.value == "") && (form.alertDate.value == "")) { 
        message += "- Please specify an alert date\r\n";
        formTest = false;
      }
      if ((!form.alertDate.value == "") && (form.alertText.value == "")) { 
        message += "- Please specify an alert description\r\n";
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
<form name="addOpportunity" action="/Leads.do?command=InsertOpp&auto-populate=true" onSubmit="return doCheck(this);" method="post">
<a href="/Leads.do">Pipeline Management</a> > 
Add Opportunity<br>
<hr color="#BFBFBB" noshade>
<table cellpadding="4" cellspacing="0" border="0" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr>
    <td>
<input type="submit" value="Save" onClick="this.form.dosubmit.value='true';">
<input type="submit" value="Cancel" onClick="javascript:this.form.action='/Leads.do?command=ViewOpp';this.form.dosubmit.value='false';">
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
    <td nowrap valign="center" class="formLabel">
      Associate With
    </td>
    <td width="100%">
        <input type="radio" name="opp_type" value="org">Account<br>
        <input type="radio" name="opp_type" value="contact">Contact
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Account
    </td>
    <td width="100%">
      <%= OrgList.getHtmlSelectDefaultNone("accountLink")%>
      <font color=red>*</font> <%= showAttribute(request, "orgError") %>
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      <a href="javascript:popContactsListSingle('contactLink','changecontact');">Contact</a>
    </td>
    <td width="100%">
      <table>
        <tr>
          <td>
            <div id="changecontact"><%=(OppDetails.getContactLink()+"").equals("-1")?"None Selected":OppDetails.getContactLink()+""%></div>
          </td>
          <td>
            <input type="hidden" name="contact" id="contactLink" value="<%=(OppDetails.getContactLink() == -1)?-1:OppDetails.getContactLink()%>">
          </td>
        </tr>
      </table>
    </td>
  </tr>

  <tr class="containerBody">
    <td nowrap class="formLabel">
      Description
    </td>
    <td width="100%">
      <input type=text size=50 name="description" value="">
      <font color=red>*</font> <%= showAttribute(request, "descriptionError") %>
    </td>
  </tr>
  
  <tr class="containerBody">
    <td valign="top" nowrap class="formLabel">Additional Notes</td>
    <td><TEXTAREA NAME='notes' ROWS=3 COLS=50><%= toString(OppDetails.getNotes()) %></TEXTAREA></td>
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
      <input type=text size=5 name="closeProb" value="">%
      <font color=red>*</font> <%= showAttribute(request, "closeProbError") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Est. Close Date
    </td>
    <td>
      <input type=text size=10 name="closeDate" value="">
      <a href="javascript:popCalendar('addOpportunity', 'closeDate');">Date</a> (mm/dd/yyyy)
      <font color=red>*</font> <%= showAttribute(request, "closeDateError") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Low Estimate
    </td>
    <td>
      <input type=text size=10 name="low" value="">
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Best Guess Estimate
    </td>
    <td>
      <input type=text size=10 name="guess" value="">
      <font color=red>*</font> <%= showAttribute(request, "guessError") %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      High Estimate
    </td>
    <td>
      <input type=text size=10 name="high" value="">
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Est. Term
    </td>
    <td>
      <input type=text size=5 name="terms" value="">
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
      <input type=text size=5 name="commission" value="">%
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Alert Description
    </td>
    <td valign=center colspan=1>
      <input type=text size=50 name="alertText" value=""><br>
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Alert Date
    </td>
    <td>
      <input type=text size=10 name="alertDate" value="">
      <a href="javascript:popCalendar('addOpportunity', 'alertDate');">Date</a> (mm/dd/yyyy)
    </td>
  </tr>
  
</table>
&nbsp;
<br>
<input type="submit" value="Save" onClick="this.form.dosubmit.value='true';">
<input type="submit" value="Cancel" onClick="javascript:this.form.action='/Leads.do?command=ViewOpp';this.form.dosubmit.value='false';">
<input type="reset" value="Reset">
<input type="hidden" name="dosubmit" value="true">
    </td>
  </tr>
</table>
</form>
</body>
