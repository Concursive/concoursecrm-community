<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.pipeline.base.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="opportunityHeader" class="org.aspcfs.modules.pipeline.base.OpportunityHeader" scope="request"/>
<jsp:useBean id="CallDetails" class="org.aspcfs.modules.contacts.base.Call" scope="request"/>
<jsp:useBean id="CallTypeList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="PipelineViewpointInfo" class="org.aspcfs.utils.web.ViewpointInfo" scope="session"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../initPage.jsp" %>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkDate.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
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
    alertMessage = "";
    if ((!form.alertDate.value == "") && (!checkDate(form.alertDate.value))) { 
      message += "- Check that Alert Date is entered correctly\r\n";
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
    if ((!form.alertDate.value == "") && (!checkAlertDate(form.alertDate.value))) { 
      alertMessage += "Alert Date is before today's date\r\n";
  }
      
  if (formTest == false) {
    alert("Form could not be saved, please check the following:\r\n\r\n" + message);
    return false;
  } else {
    if(alertMessage != ""){
       return confirmAction(alertMessage);
    }else{
      return true;
    }
  }
}
</script>
<%
  boolean popUp = false;
  if (request.getParameter("popup") != null) {
    popUp = true;
  }
%>
<dhv:evaluate exp="<%= !popUp %>">
<%-- Trails --%>
<table class="trails">
<tr>
<td>
<a href="Leads.do">Pipeline</a> >
<% if ("dashboard".equals(request.getParameter("viewSource"))){ %>
	<a href="Leads.do?command=Dashboard">Dashboard</a> >
<% }else{ %>
	<a href="Leads.do?command=Search">Search Results</a> >
<% } %>
<a href="Leads.do?command=DetailsOpp&headerId=<%= opportunityHeader.getId() %><%= addLinkParams(request, "viewSource") %>">Opportunity Details</a> >
<a href="LeadsCalls.do?command=View&headerId=<%= opportunityHeader.getId() %><%= addLinkParams(request, "viewSource") %>">Calls</a> >
<% if (request.getParameter("return") == null) { %>
	<a href="LeadsCalls.do?command=Details&id=<%= CallDetails.getId() %>&headerId=<%= opportunityHeader.getId() %><%= addLinkParams(request, "viewSource") %>">Call Details</a> >
<%}%>
Modify Call
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>
<dhv:evaluate exp="<%= PipelineViewpointInfo.isVpSelected(User.getUserId()) %>">
  <b>Viewpoint: </b><b class="highlight"><%= PipelineViewpointInfo.getVpUserName() %></b><br>
  &nbsp;<br>
</dhv:evaluate>
<%@ include file="leads_details_header_include.jsp" %>
<dhv:evaluate exp="<%= !popUp %>">
  <% String param1 = "id=" + opportunityHeader.getId(); 
   String param2 = addLinkParams(request, "viewSource");
%>
<dhv:container name="opportunities" selected="calls" param="<%= param1 %>" appendToUrl="<%= param2 %>" style="tabs"/>
</dhv:evaluate>
<form name="addCall" action="LeadsCalls.do?command=Update&id=<%= CallDetails.getId() %>&headerId=<%= opportunityHeader.getId() %><%= (request.getParameter("popup") != null?"&popup=true":"") %>&auto-populate=true" onSubmit="return doCheck(this);" method="post">
<table cellpadding="4" cellspacing="0" border="0" width="100%">
  <tr>
    <td class="containerBack">
      <input type="submit" value="Update" onClick="this.form.dosubmit.value='true';">
<dhv:evaluate exp="<%= !popUp %>">
  <% if (request.getParameter("return") != null) {%>
    <% if (request.getParameter("return").equals("list")) {%>
      <input type="submit" value="Cancel" onClick="javascript:this.form.action='LeadsCalls.do?command=View&headerId=<%= opportunityHeader.getId() %>';this.form.dosubmit.value='false';">
    <%}%>
  <%} else {%>
      <input type="submit" value="Cancel" onClick="javascript:form.action='LeadsCalls.do?command=Details&id=<%= CallDetails.getId() %>&headerId=<%= opportunityHeader.getId() %>';this.form.dosubmit.value='false';">
  <%}%>
</dhv:evaluate>
<dhv:evaluate exp="<%= popUp %>">
      <input type="button" value="Cancel" onClick="javascript:window.close();">
</dhv:evaluate>
      <input type="reset" value="Reset">
      <br>
      <%= showError(request, "actionError") %>
      <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
        <tr>
          <th colspan="2">
            <strong>Call Details</strong>
          </th>
        </tr>
        <tr class="containerBody">
          <td class="formLabel">
            Type
          </td>
          <td>
            <%= CallTypeList.getHtmlSelect("callTypeId", CallDetails.getCallTypeId()) %>
          </td>
        </tr>
        <tr class="containerBody">
          <td class="formLabel">
            Length
          </td>
          <td>
            <input type="text" size="5" name="length" value="<%= toHtmlValue(CallDetails.getLengthString()) %>"> minutes  <%= showAttribute(request, "lengthError") %>
          </td>
        </tr>
        <tr class="containerBody">
          <td class="formLabel">
            Subject
          </td>
          <td>
            <input type="text" size="50" name="subject" value="<%= toHtmlValue(CallDetails.getSubject()) %>">
          </td>
        </tr>
        <tr class="containerBody">
          <td valign="top" nowrap class="formLabel">
            Notes
          </td>
          <td>
            <TEXTAREA NAME="notes" ROWS="3" COLS="50"><%= toString(CallDetails.getNotes()) %></TEXTAREA>
          </td>
        </tr>
        <tr class="containerBody">
          <td nowrap class="formLabel">
            Alert Description
          </td>
          <td>
            <input type="text" size="50" name="alertText" value="<%= toHtmlValue(CallDetails.getAlertText()) %>">
          </td>
        </tr>
        <tr class="containerBody">
          <td nowrap class="formLabel">
            Alert Date
          </td>
          <td>
            <input type="text" size="10" name="alertDate" value="<dhv:tz timestamp="<%= CallDetails.getAlertDate() %>" dateOnly="true" dateFormat="<%= DateFormat.SHORT %>"/>"> 
            <a href="javascript:popCalendar('addCall', 'alertDate');"><img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle" height="16" width="16"/></a> (mm/dd/yyyy)
          </td>
        </tr>
      </table>
      <br>
      <input type="submit" value="Update" onClick="this.form.dosubmit.value='true';">
<dhv:evaluate exp="<%= !popUp %>">
  <% if (request.getParameter("return") != null) {%>
    <% if (request.getParameter("return").equals("list")) {%>
      <input type="submit" value="Cancel" onClick="javascript:this.form.action='LeadsCalls.do?command=View&headerId=<%= opportunityHeader.getId() %>';this.form.dosubmit.value='false';">
    <%}%>
  <%} else {%>
      <input type="submit" value="Cancel" onClick="javascript:form.action='LeadsCalls.do?command=Details&id=<%= CallDetails.getId() %>&headerId=<%= opportunityHeader.getId() %>';this.form.dosubmit.value='false';">
  <%}%>
</dhv:evaluate>
<dhv:evaluate exp="<%= popUp %>">
      <input type="button" value="Cancel" onClick="javascript:window.close();">
</dhv:evaluate>
      <input type="reset" value="Reset">
      <input type="hidden" name="dosubmit" value="true">
      <input type="hidden" name="contactId" value="<%=CallDetails.getContactId()%>">
      <input type="hidden" name="modified" value="<%= CallDetails.getModified() %>">
      <%= addHiddenParams(request, "viewSource|return") %>
    </td>
  </tr>
</table>
</form>
