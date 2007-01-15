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
<%@ page import="java.util.*,org.aspcfs.modules.contacts.base.*,org.aspcfs.utils.DateUtils" %>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="CallDetails" class="org.aspcfs.modules.contacts.base.Call" scope="request"/>
<jsp:useBean id="PreviousCallDetails" class="org.aspcfs.modules.contacts.base.Call" scope="request"/>
<jsp:useBean id="CallTypeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="ReminderTypeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="callResultList" class="org.aspcfs.modules.contacts.base.CallResultList" scope="request"/>
<jsp:useBean id="CallResult" class="org.aspcfs.modules.contacts.base.CallResult" scope="request"/>
<jsp:useBean id="PriorityList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="TimeZoneSelect" class="org.aspcfs.utils.web.HtmlSelectTimeZone" scope="request"/>
<jsp:useBean id="actionSource" class="java.lang.String" scope="request"/>
<jsp:useBean id="action" class="java.lang.String" scope="request"/>
<jsp:useBean id="contactList" class="org.aspcfs.modules.contacts.base.ContactList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkString.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkDate.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></script>
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
    if ((!checkNullString(form.alertDate.value)) && (checkNullString(form.alertText.value))) {
      message += label("specify.alert.description", "- Please specify an alert description\r\n");
      formTest = false;
    }
    if (form.alertCallTypeId.value == "0") { 
      message += label("specify.alert.type", "- Please specify an alert type\r\n");
      formTest = false;
    }
<% }else{ %>
  if (checkNullString(form.subject.value)) { 
      message += label("specify.blank.records", "- Blank records cannot be saved\r\n");
      formTest = false;
    }
    
    if (form.callTypeId.value == "0") { 
      message += label("specify.type", "- Please specify a type\r\n");
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
        message += label("specify.alert.type", "- Please specify an alert type\r\n");
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
  
  <% if((!"pending".equals(request.getParameter("view")) && CallDetails.getAlertDate() == null) ||
  !((CallDetails.getAlertDate() != null) && (request.getAttribute("alertDateWarning") == null) && request.getParameter("hasFollowup") == null)){ %>
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
      window.frames['server_commands'].location.href='AccountContactCalls.do?command=SuggestCall&resultId=' + document.getElementById('resultId').value;
    }
  }
  
  function addFollowup(hours, typeId){
    var form = document.addCall;
    var selectedIndex = 0;
    var callTypes = form.alertCallTypeId;
    
    for(i = 0; i < callTypes.options.length; i++){
      if(frm.options[i].value == typeId){
        selectedIndex = i;
      }
    }
    callTypes.selectedIndex = selectedIndex;
    form.reminderId.value = hours;
    form.nextAction.checked = 't';
    toggleSpan(form.nextAction, 'nextActionSpan');
  }
<% } %>
function showHistory() {
    popURL('CalendarCalls.do?command=View&contactId=<%= ContactDetails.getId() %>&popup=true&source=calendar','CONTACT_HISTORY','650','500','yes','yes');
  }
</script>
<% if("pending".equals(request.getParameter("view"))){ %>
  <body onLoad="javascript:document.addCall.alertText.focus();">
<%}else if(CallDetails.getStatusId() != Call.CANCELED){ %>
  <body onLoad="javascript:document.addCall.subject.focus();">
<% } %>
<% request.setAttribute("includeDetails", "true"); %>
<%-- <%@ include file="../contacts/contact_details_header_include.jsp" %><br> --%>
<form name="addCall" action="AccountContactsCalls.do?command=Save&auto-populate=true&actionSource=CalendarCalls" onSubmit="return doCheck(this);" method="post">
<input type="hidden" name="orgId" value="<%= CallDetails.getOrgId()%>"/>
<dhv:container name="calls" selected="contacts" object="CallDetails" param='<%= "id=" + CallDetails.getFollowupContactId() %>' appendToUrl='<%= addLinkParams(request, "popup|popupType|actionId") %>' hideContainer="<%= isPopup(request) %>">
  <dhv:evaluate if="<%= hasText(ContactDetails.getTitle()) %>"><%= toHtml(ContactDetails.getTitle()) %><br /></dhv:evaluate>
  <dhv:evaluate if="<%= hasText(ContactDetails.getPhoneNumberList().getPrimaryPhoneNumber()) %>"><%= toHtml(ContactDetails.getPhoneNumberList().getPrimaryPhoneNumber()) %><br /></dhv:evaluate>
  <dhv:evaluate if="<%= hasText(ContactDetails.getEmailAddressList().getPrimaryEmailAddress()) %>"><%= toHtml(ContactDetails.getEmailAddressList().getPrimaryEmailAddress()) %><br /></dhv:evaluate>
  <br />
  <%-- include call update form --%>
  <dhv:evaluate if="<%= CallDetails.getStatusId() != Call.CANCELED %>">
  <input type="submit" value="<dhv:label name="global.button.update">Update</dhv:label>" onClick="this.form.dosubmit.value='true';">
  </dhv:evaluate>
  <input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:window.close();">
  [<a href="javascript:showHistory();"><dhv:label name="calendar.viewContactHistory">View Contact History</dhv:label></a>]
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
    <%@ include file="../contacts/call_completed_include.jsp" %>
    <% }else{ %>
    <%-- include completed activity details --%>
    <%@ include file="../accounts/accounts_contacts_calls_details_include.jsp" %>
    <% } %>
    &nbsp;
    <% if((CallDetails.getAlertDate() != null) && (request.getAttribute("alertDateWarning") == null) && request.getParameter("hasFollowup") == null){ %>
      <%-- include followup activity details --%>
      <%@ include file="../accounts/accounts_contacts_calls_details_followup_include.jsp" %>
    <% }else{ %>
      <span name="nextActionSpan" id="nextActionSpan" <%= (CallDetails.getHasFollowup() || (request.getAttribute("alertDateWarning") != null)) ? "" : "style=\"display:none\"" %>>
      <br>
      <%-- include pending activity form --%>
      <%@ include file="../contacts/call_followup_include.jsp" %>
        <%--Add the javascript to toggle the followupInclude. --%>
        <dhv:evaluate if="<%= CallDetails.getAlertDate() != null %>">
          <script type="text/javascript">
            var form1 = document.addCall;
            form1.hasFollowup.checked = true;
            form1.hasFollowup.disabled = true;
          </script>
        </dhv:evaluate>
      </span>
  <% 
      }
    }
  %>
  &nbsp;
  <br />
  <dhv:evaluate if="<%= CallDetails.getStatusId() != Call.CANCELED %>">
  <input type="submit" value="<dhv:label name="global.button.update">Update</dhv:label>" onClick="this.form.dosubmit.value='true';">
  </dhv:evaluate>
  <input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:window.close();">
  <input type="hidden" name="dosubmit" value="true">
  <input type="hidden" name="contactId" value="<%= ContactDetails.getId() %>">
  <input type="hidden" name="modified" value="<%= CallDetails.getModified() %>">
  <input type="hidden" name="oppHeaderId" value="<%= CallDetails.getOppHeaderId() != -1? CallDetails.getOppHeaderId():PreviousCallDetails.getOppHeaderId() %>">
  <input type="hidden" name="id" value="<%= CallDetails.getId() %>">
  <input type="hidden" name="previousId" value="<%= PreviousCallDetails.getId() %>">
  <br>
  &nbsp;
<% if("pending".equals(request.getParameter("view"))){ %>
  <%-- include completed activity values --%>
  <input type="hidden" name="callTypeId" value="<%= CallDetails.getCallTypeId() %>">
  <input type="hidden" name="length" value="<%= CallDetails.getLength() %>">
  <input type="hidden" name="subject" value="<%= toHtmlValue(CallDetails.getSubject()) %>">
  <input type="hidden" name="notes" value="<%= toString(CallDetails.getNotes()) %>">
  <input type="hidden" name="resultId" value="<%= CallDetails.getResultId() %>">
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
<input type="hidden" name="statusId" value="<%= CallDetails.getStatusId() %>">
<input type="hidden" name="return" value="calendar">
<%= addHiddenParams(request, "view|popup") %>
</dhv:container>
</form>
</body>
