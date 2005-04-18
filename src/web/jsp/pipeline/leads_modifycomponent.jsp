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
<%@ page import="java.util.*,org.aspcfs.modules.pipeline.base.*,org.aspcfs.utils.web.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="opportunityHeader" class="org.aspcfs.modules.pipeline.base.OpportunityHeader" scope="request"/>
<jsp:useBean id="ComponentDetails" class="org.aspcfs.modules.pipeline.base.OpportunityComponent" scope="request"/>
<jsp:useBean id="PipelineViewpointInfo" class="org.aspcfs.utils.web.ViewpointInfo" scope="session"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>
<%@ include file="../initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/checkString.js"></SCRIPT>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkNumber.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></script>
<SCRIPT LANGUAGE="JavaScript">
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
  if ((!checkNullString(form.alertText.value)) && (checkNullString(form.alertDate.value))) { 
    message += label("specify.alert.date", "- Please specify an alert date\r\n");
    formTest = false;
  }
  if ((!checkNullString(form.alertDate.value)) && (checkNullString(form.alertText.value))) { 
    message += label("specify.alert.description", "- Please specify an alert description\r\n");
    formTest = false;
  }
  if (!checkNumber(form.commission.value)) { 
      message += label("commission.entered.invalid", "- Commission entered is invalid\r\n");
      formTest = false;
    }
  if (formTest == false) {
    alert(label("check.form", "Form could not be saved, please check the following:\r\n\r\n") + message);
    return false;
  } else {
    if(alertMessage != ""){
       return confirmAction(alertMessage);
    }else{
      var test = document.opportunityForm.selectedList;
      if (test != null) {
        return selectAllOptions(document.opportunityForm.selectedList);
      }
    }
  }
}
function reopenOpportunity(id) {
  if (id == '<%= opportunityHeader.getId() %>') {
    if ('<%= "dashboard".equals(request.getParameter("viewSource")) %>' == 'true') {
      scrollReload('Leads.do?command=Dashboard');
    } else {
      scrollReload('Leads.do?command=Search');
    }
    return id;
  } else {
    return '<%= opportunityHeader.getId() %>';
  }
}
</SCRIPT>
<form name="opportunityForm" action="LeadsComponents.do?command=SaveComponent&auto-populate=true<%= (request.getParameter("popup") != null?"&popup=true":"") %>" onSubmit="return doCheck(this);" method="post">
<%
   boolean popUp = false;
   if(request.getParameter("popup")!=null){
     popUp = true;
   }
%>
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
<% if ("list".equals(request.getParameter("return"))) {%>
  <a href="Leads.do?command=DetailsOpp&headerId=<%= ComponentDetails.getHeaderId() %><%= addLinkParams(request, "viewSource") %>"><dhv:label name="accounts.accounts_contacts_oppcomponent_add.OpportunityDetails">Opportunity Details</dhv:label></a> > 
<%} else if (request.getParameter("return") != null) {%>
  <a href="Leads.do?command=DetailsOpp&headerId=<%= ComponentDetails.getHeaderId() %><%= addLinkParams(request, "viewSource") %>"><dhv:label name="accounts.accounts_contacts_oppcomponent_add.OpportunityDetails">Opportunity Details</dhv:label></a> > 
  <a href="LeadsComponents.do?command=DetailsComponent&id=<%= ComponentDetails.getId() %><%= addLinkParams(request, "viewSource") %>"><dhv:label name="accounts.accounts_contacts_oppcomponent_add.ComponentDetails">Component Details</dhv:label></a> >
<%}%>
<dhv:label name="accounts.accounts_contacts_oppcomponent_modify.ModifyComponent">Modify Component</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
</dhv:evaluate>
<dhv:evaluate if="<%= PipelineViewpointInfo.isVpSelected(User.getUserId()) %>">
  <dhv:label name="pipeline.viewpoint.colon" param="<%= "username="+PipelineViewpointInfo.getVpUserName() %>"><b>Viewpoint: </b><b class="highlight"><%= PipelineViewpointInfo.getVpUserName() %></b></dhv:label><br />
  &nbsp;<br>
</dhv:evaluate>
<dhv:container name="opportunities" selected="details" object="opportunityHeader" param="<%= "id=" + opportunityHeader.getId() %>" appendToUrl="<%= addLinkParams(request, "viewSource") %>" hideContainer="<%= isPopup(request) %>">
  <input type="submit" value="<dhv:label name="global.button.update">Update</dhv:label>" onClick="this.form.dosubmit.value='true';">
  <%
    if (request.getParameter("return") != null) {
      if (request.getParameter("return").equals("list")) {
  %>
    <input type="submit" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:this.form.action='Leads.do?command=Search';this.form.dosubmit.value='false';">
  <%
      } else if (request.getParameter("return").equals("details")) {
  %>
    <input type="submit" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:this.form.action='Leads.do?command=DetailsOpp&headerId=<%= ComponentDetails.getHeaderId() %>';this.form.dosubmit.value='false';">
  <%
      }
    } else {
  %>
    <input type="submit" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:this.form.action='LeadsComponents.do?command=DetailsComponent&id=<%= ComponentDetails.getId() %>';this.form.dosubmit.value='false';">
  <%
    }
  %>
  <dhv:evaluate if="<%= popUp %>">
    <input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onclick="javascript:window.close();">
  </dhv:evaluate>
  <br />
  <dhv:formMessage />
  <iframe src="empty.html" name="server_commands" id="server_commands" style="visibility:hidden" height="0"></iframe>
  <%--  include basic opportunity form --%>
  <%@ include file="opportunity_include.jsp" %>
  &nbsp;
  <br>
  <input type="submit" value="<dhv:label name="global.button.update">Update</dhv:label>" onClick="this.form.dosubmit.value='true';">
  <% if (request.getParameter("return") != null) {%>
    <% if (request.getParameter("return").equals("list")) {%>
    <input type="submit" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:this.form.action='Leads.do?command=Search';this.form.dosubmit.value='false';">
    <%} else if(request.getParameter("return").equals("details")) {%>
    <input type="submit" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:this.form.action='Leads.do?command=DetailsOpp&headerId=<%= ComponentDetails.getHeaderId() %>';this.form.dosubmit.value='false';">
   <%}
   } else {%>
  <input type="submit" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:this.form.action='LeadsComponents.do?command=DetailsComponent&id=<%= ComponentDetails.getId() %>';this.form.dosubmit.value='false';">
  <%}%>
  <dhv:evaluate if="<%= popUp %>">
    <input type="button" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onclick="javascript:window.close();">
  </dhv:evaluate>
  <%= addHiddenParams(request, "viewSource|return") %>
  <input type="hidden" name="id" value="<%= ComponentDetails.getId() %>">
  <input type="hidden" name="headerId" value="<%= ComponentDetails.getHeaderId() %>">
  <input type="hidden" name="modified" value="<%= ComponentDetails.getModified() %>">
  <input type="hidden" name="dosubmit" value="true">
</dhv:container>
</form>

