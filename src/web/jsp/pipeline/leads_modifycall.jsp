<%-- 
  - Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. DARK HORSE
  - VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.contacts.base.Call,org.aspcfs.modules.pipeline.base.*,com.zeroio.iteam.base.*,org.aspcfs.utils.*" %>
<jsp:useBean id="opportunityHeader" class="org.aspcfs.modules.pipeline.base.OpportunityHeader" scope="request"/>
<jsp:useBean id="CallDetails" class="org.aspcfs.modules.contacts.base.Call" scope="request"/>
<jsp:useBean id="PreviousCallDetails" class="org.aspcfs.modules.contacts.base.Call" scope="request"/>
<jsp:useBean id="ContactList" class="org.aspcfs.modules.contacts.base.ContactList" scope="request"/>
<jsp:useBean id="CallTypeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ReminderTypeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="callResultList" class="org.aspcfs.modules.contacts.base.CallResultList" scope="request"/>
<jsp:useBean id="CallResult" class="org.aspcfs.modules.contacts.base.CallResult" scope="request"/>
<jsp:useBean id="PriorityList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="PipelineViewpointInfo" class="org.aspcfs.utils.web.ViewpointInfo" scope="session"/>
<jsp:useBean id="TimeZoneSelect" class="org.aspcfs.utils.web.HtmlSelectTimeZone" scope="request"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkString.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkInt.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkDate.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></script>
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
<% if("pending".equals(request.getParameter("view"))){ %>
    if ((!checkNullString(form.alertText.value)) && (checkNullString(form.alertDate.value))) { 
      message += label("specify.alert.date", "- Please specify an alert date\r\n");
      formTest = false;
    }
    if (checkNullString(form.alertText.value)) { 
      message += label("specify.alert.description", "- Please specify an alert description\r\n");
      formTest = false;
    }
    if (form.alertCallTypeId.value == "0") { 
      message += label("specify.alert.type","- Please specify an alert type\r\n");
      formTest = false;
    }
<% }else{ %>
    if (!checkInt(form.length.value)){
        message += label("check.length.wholenumber","- Check that Length is a whole number\r\n");
        formTest = false;
    }
    
    if (checkNullString(form.subject.value)) { 
      message += label("specify.blank.records","- Blank records cannot be saved\r\n");
      formTest = false;
    }
    
    if (form.callTypeId.value == "0") { 
      message += label("specify.type","- Please specify a type\r\n");
      formTest = false;
    }
    
    if(form.hasFollowup != null && form.hasFollowup.checked){
    if ((!checkNullString(form.alertText.value)) && (checkNullString(form.alertDate.value))) { 
      message += label("specify.alert.date", "- Please specify an alert date\r\n");
      formTest = false;
    }
    if ((!checkNullString(form.alertDate.value)) && (checkNullString(form.alertText.value))) { 
      message += label("specify.alert.description", "- Please specify an alert description\r\n");
      formTest = false;
    }
    if (checkNullString(form.alertText.value)) { 
      message += label("specify.alert.description", "- Please specify an alert description\r\n");
      formTest = false;
    }
    if (form.alertCallTypeId.value == "0") { 
      message += label("specify.alert.type","- Please specify an alert type\r\n");
      formTest = false;
    }
     } 
<% } %>
  if (formTest == false) {
      alert(label("check.form", "Form could not be saved, please check the following:\r\n\r\n") + message);
      return false;
    } else {
      checkFollowup(form);
      return true;
    }
  }
  
  function checkFollowup(form){
    if(form.hasFollowup != null && !form.hasFollowup.checked){
      form.alertText.value = '';
      form.followupNotes.value = '';
      form.alertCallTypeId.value = '0';
      form.alertDate.value = '';
      form.reminderId.value = '-1';
      form.reminderTypeId.value = '0';
      form.owner.value = '-1';
      form.priorityId.value = '-1';
    }else{
      if(form.reminder != null && form.reminder[0].checked){
        form.reminderId.value = '-1';
        form.reminderTypeId.value = '0';
      }
    }
  }
  
  <% if(!"pending".equals(request.getParameter("view")) && CallDetails.getAlertDate() == null){ %>
  function toggleSpan(cb, tag) {
    var form = document.addCall;
    if (cb.checked) {
      if (form.alertText.value == "") {
        form.alertText.value = form.subject.value;
      }
      showSpan(tag);
      form.alertText.focus();
    } else {
      hideSpan(tag);
    }
  }
  
  function makeSuggestion(){
    if(document.getElementById('resultId').value > -1){
      window.frames['server_commands'].location.href='LeadsCalls.do?command=SuggestCall&resultId=' + document.getElementById('resultId').value;
    }
  }
  
  function addFollowup(hours, typeId){
    var form = document.addCall;
    var selectedIndex = 0;
    var callTypes = form.alertCallTypeId;
    
    for(i = 0; i < callTypes.options.length; i++){
      if(callTypes.options[i].value == typeId){
        selectedIndex = i;
      }
    }
    callTypes.selectedIndex = selectedIndex;
    form.alertDate.value = hours;
    form.hasFollowup.checked = 't';
    toggleSpan(form.hasFollowup, 'nextActionSpan');
  }
<% } %>
</script>
<% if("pending".equals(request.getParameter("view"))){ %>
<body onLoad="javascript:document.addCall.alertText.focus();">
<%}else{%>
<body onLoad="javascript:document.addCall.subject.focus();">
<%}%>
<%
  boolean popUp = false;
  if (request.getParameter("popup") != null) {
    popUp = true;
  }
%>
<form name="addCall" action="LeadsCalls.do?command=Save&headerId=<%= opportunityHeader.getId() %><%= (request.getParameter("popup") != null?"&popup=true":"") %>&auto-populate=true" onSubmit="return doCheck(this);" method="post">
<dhv:evaluate if="<%= !popUp %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Leads.do"><dhv:label name="pipeline.pipeline">Pipeline</dhv:label></a> >
<% if ("dashboard".equals(request.getParameter("viewSource"))){ %>
	<a href="Leads.do?command=Dashboard"><dhv:label name="communications.campaign.Dashboard">Dashboard</dhv:label></a> >
<% }else{ %>
	<a href="Leads.do?command=Search"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
<% } %>
<a href="Leads.do?command=DetailsOpp&headerId=<%= opportunityHeader.getId() %><%= addLinkParams(request, "viewSource") %>"><dhv:label name="accounts.accounts_contacts_oppcomponent_add.OpportunityDetails">Opportunity Details</dhv:label></a> >
<a href="LeadsCalls.do?command=View&headerId=<%= opportunityHeader.getId() %><%= addLinkParams(request, "viewSource") %>"><dhv:label name="accounts.accounts_calls_list.Activities">Activities</dhv:label></a> >
<% if (request.getParameter("return") == null) { %>
	<a href="LeadsCalls.do?command=Details&id=<%= CallDetails.getId() %>&headerId=<%= opportunityHeader.getId() %><%= addLinkParams(request, "viewSource") %>"><dhv:label name="accounts.accounts_contacts_calls_add.ActivityDetails">Activity Details</dhv:label></a> >
<%}%>
<dhv:label name="contact.call.modifyActivity">Modify Activity</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>
<dhv:evaluate if="<%= PipelineViewpointInfo.isVpSelected(User.getUserId()) %>">
  <dhv:label name="pipeline.viewpoint.colon" param="<%= "username="+PipelineViewpointInfo.getVpUserName() %>"><b>Viewpoint: </b><b class="highlight"><%= PipelineViewpointInfo.getVpUserName() %></b></dhv:label><br />
  &nbsp;<br>
</dhv:evaluate>
<dhv:container name="opportunities" selected="calls" object="opportunityHeader" param="<%= "id=" + opportunityHeader.getId() %>" appendToUrl="<%= addLinkParams(request, "viewSource") %>">
  <input type="submit" value="<dhv:label name="global.button.update">Update</dhv:label>" onClick="this.form.dosubmit.value='true';">
  <dhv:evaluate if="<%= !popUp %>">
    <% if (request.getParameter("return") != null) {%>
      <% if (request.getParameter("return").equals("list")) {%>
        <input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="window.location.href='LeadsCalls.do?command=View&headerId=<%= opportunityHeader.getId() %>';this.form.dosubmit.value='false';">
      <%}%>
    <%} else {%>
        <input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="window.location.href='LeadsCalls.do?command=Details&id=<%= CallDetails.getId() %>&headerId=<%= opportunityHeader.getId() %>';this.form.dosubmit.value='false';">
    <%}%>
  </dhv:evaluate>
  <dhv:evaluate if="<%= popUp %>">
    <input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:window.close();">
  </dhv:evaluate>
    <br />
    <dhv:formMessage />
    <iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>
    <% if("pending".equals(request.getParameter("view"))){ %>
      <%-- include pending activity form --%>
      <%@ include file="../contacts/call_followup_include.jsp" %>
      &nbsp;
      <%-- include completed activity details --%>
      <%@ include file="../accounts/accounts_contacts_calls_details_include.jsp" %>
    <% }else{ %>
      <% if(CallDetails.getStatusId() != Call.CANCELED){ %>
      <%-- include completed activity form --%>
      <%@ include file="leads_call_completed_include.jsp" %>
      <% }else{ %>
      <%-- include completed activity details --%>
      <%@ include file="../accounts/accounts_contacts_calls_details_include.jsp" %>
      <% } %>
      &nbsp;
      <% if((CallDetails.getAlertDate() != null) && (request.getAttribute("alertDateWarning") == null) && request.getParameter("hasFollowup") == null){ %>
        <%-- include followup activity details --%>
        <%@ include file="../accounts/accounts_contacts_calls_details_followup_include.jsp" %>
      <% }else{ %>
        <span name="nextActionSpan" id="nextActionSpan" <%= CallDetails.getHasFollowup() ? "" : "style=\"display:none\"" %>>
        <br>
        <%-- include pending activity form --%>
        <%@ include file="../contacts/call_followup_include.jsp" %>
        </span>
    <%
        }
      }
    %>
      &nbsp;
      <br>
      <input type="submit" value="<dhv:label name="global.button.update">Update</dhv:label>" onClick="this.form.dosubmit.value='true';">
      <dhv:evaluate if="<%= !popUp %>">
        <% if (request.getParameter("return") != null) {%>
          <% if (request.getParameter("return").equals("list")) {%>
            <input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="window.location.href='LeadsCalls.do?command=View&headerId=<%= opportunityHeader.getId() %>';this.form.dosubmit.value='false';">
          <%}%>
        <%} else {%>
            <input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="window.location.href='LeadsCalls.do?command=Details&id=<%= CallDetails.getId() %>&headerId=<%= opportunityHeader.getId() %>';this.form.dosubmit.value='false';">
        <%}%>
      </dhv:evaluate>
      <dhv:evaluate if="<%= popUp %>">
          <input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:window.close();">
      </dhv:evaluate>
  <input type="hidden" name="dosubmit" value="true">
  <input type="hidden" name="modified" value="<%= CallDetails.getModified() %>">
  <input type="hidden" name="id" value="<%= CallDetails.getId() %>">
  <input type="hidden" name="previousId" value="<%= PreviousCallDetails.getId() %>">
  <input type="hidden" name="statusId" value="<%= CallDetails.getStatusId() %>">
  <input type="hidden" name="headerId" value="<%= opportunityHeader.getId() %>" >
  <%= addHiddenParams(request, "viewSource|view|return|actionId") %>
<% if("pending".equals(request.getParameter("view"))){ %>
    <%-- include completed activity values --%>
    <input type="hidden" name="callTypeId" value="<%= CallDetails.getCallTypeId() %>">
    <input type="hidden" name="length" value="<%= CallDetails.getLength() %>">
    <input type="hidden" name="subject" value="<%= toHtmlValue(CallDetails.getSubject()) %>">
    <input type="hidden" name="notes" value="<%= toString(CallDetails.getNotes()) %>">
    <input type="hidden" name="resultId" value="<%= CallDetails.getResultId() %>">
    <input type="hidden" name="contactId" value="<%= CallDetails.getContactId() %>">
<% }else if(!(CallDetails.getStatusId() == Call.COMPLETE && CallDetails.getAlertDate() == null)&& (request.getAttribute("alertDateWarning") == null)){ %>
    <%-- include pending activity values --%>
    <input type="hidden" name="alertText" value="<%= toHtmlValue(CallDetails.getAlertText()) %>">
    <input type="hidden" name="alertCallTypeId" value="<%= CallDetails.getAlertCallTypeId() %>">
    <zeroio:dateSelect field="alertDate" timestamp="<%= CallDetails.getAlertDate() %>" hidden="true" />
    <zeroio:timeSelect baseName="alertDate" value="<%= CallDetails.getAlertDate() %>" timeZone="<%= User.getTimeZone() %>" hidden="true"/>
    <input type="hidden" name="owner" value="<%= CallDetails.getOwner() %>">
    <input type="hidden" name="reminderId" value="<%= CallDetails.getReminderId() %>">
    <input type="hidden" name="reminderTypeId" value="<%= CallDetails.getReminderTypeId() %>">
    <input type="hidden" name="followupNotes" value="<%= toString(CallDetails.getFollowupNotes()) %>">
    <input type="hidden" name="priorityId" value="<%= CallDetails.getPriorityId() %>">
  <% } %>
</dhv:container>
</form>
</body>
