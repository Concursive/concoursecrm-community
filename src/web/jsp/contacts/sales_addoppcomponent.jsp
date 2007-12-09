<%-- 
  - Copyright(c) 2007 Concursive Corporation (http://www.concursive.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Concursive Corporation. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. CONCURSIVE
  - CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL CONCURSIVE CORPORATION OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id: companydirectory_addoppcomponent.jsp 21070 2007-04-18 19:07:15Z matt $
  - Description:
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*,org.aspcfs.modules.pipeline.base.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="opportunityHeader" class="org.aspcfs.modules.pipeline.base.OpportunityHeader" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="ComponentDetails" class="org.aspcfs.modules.pipeline.base.OpportunityComponent" scope="request"/>
<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>
<jsp:useBean id="from" class="java.lang.String" scope="request" />
<jsp:useBean id="listForm" class="java.lang.String" scope="request" />

<%@ include file="../initPage.jsp" %>
<body onLoad="javascript:document.opportunityForm.description.focus();">
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkString.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/checkNumber.js"></script>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popLookupSelect.js?1"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<%if (isPopup(request)) {%>
<script language="JavaScript" type="text/javascript" src="javascript/scrollReload.js"></script>
<%}%>
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
    if (form.low.value != "" && form.low.value != "" && (parseInt(form.low.value) > parseInt(form.high.value))) { 
      message += label("low.estimate", "- Low Estimate cannot be higher than High Estimate\r\n");
      formTest = false;
    }
  <dhv:include name="opportunity.alertDescription opportunity.alertDate,pipeline-alertdate" none="true">
    if ((!checkNullString(form.alertText.value)) && (checkNullString(form.alertDate.value))) { 
      message += label("specify.alert.date", "- Please specify an alert date\r\n");
      formTest = false;
    }
    if ((!checkNullString(form.alertDate.value)) && (checkNullString(form.alertText.value))) { 
      message += label("specify.alert.description", "- Please specify an alert description\r\n");
      formTest = false;
    }
  </dhv:include>
  <dhv:include name="opportunity.estimatedCommission,pipeline-commission" none="true">
    if (!checkNumber(form.commission.value)) { 
      message += label("commission.entered.invalid", "- Commission entered is invalid\r\n");
      formTest = false;
    }
  </dhv:include>
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
  
  function reopenOnDelete() {
    try {
      if ('<%= isPopup(request) %>' != 'true') {
        scrollReload('SalesOpportunities.do?command=DetailsOpp&headerId=<%= opportunityHeader.getId() %>&contactId=<%= ContactDetails.getId() %><%= isPopup(request)?"&popup=true":"" %>');
      } else {
        scrollReload('SalesOpportunities.do?command=DetailsOpp&headerId=<%= opportunityHeader.getId() %>&contactId=<%= ContactDetails.getId() %><%= isPopup(request)?"&popup=true":"" %>');
        var oppId = -1;
        try {
          oppId = opener.reopenOpportunity('<%= opportunityHeader.getId() %>');
        } catch (oException) {
        }
        if (oppId != '<%= opportunityHeader.getId() %>') {
          opener.reopen();
        }
      }
    } catch (oException) {
    }
  }
  
  function reopenOpportunity(id) {
    if (id == '<%= opportunityHeader.getId() %>') {
      scrollReload('SalesOpportunities.do?command=ViewOpps&contactId=<%= ContactDetails.getId() %><%= isPopup(request)?"&popup=true":"" %>');
      return id;
    } else {
      return '<%= opportunityHeader.getId() %>';
    }
  }
</script>
<%
  boolean allowMultiple = allowMultipleComponents(pageContext, OpportunityComponent.MULTPLE_CONFIG_NAME, "multiple");
%>
<form name="opportunityForm" action="SalesOpportunitiesComponents.do?command=SaveComponent&auto-populate=true<%= addLinkParams(request, "popup|popupType|actionId|from|listForm") %>" onSubmit="return doCheck(this);" method="post">
<dhv:evaluate if="<%= !isPopup(request) %>">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Sales.do"><dhv:label name="Leads" mainMenuItem="true">Leads</dhv:label></a> >
<% if (from != null && "list".equals(from) && !"dashboard".equals(from)) { %>
  <a href="Sales.do?command=List&listForm=<%= (listForm != null? listForm:"") %>"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
<%}%>
<a href="Sales.do?command=Details&contactId=<%= ContactDetails.getId() %><%= addLinkParams(request, "popup|popupType|actionId|from|listForm") %>"><dhv:label name="sales.leadDetails">Lead Details</dhv:label></a> >
<a href="SalesOpportunities.do?command=ViewOpps&contactId=<%= ContactDetails.getId() %><%= addLinkParams(request, "popup|popupType|actionId|from|listForm") %>"><dhv:label name="accounts.accounts_contacts_oppcomponent_add.Opportunities">Opportunities</dhv:label></a> >
<a href="SalesOpportunities.do?command=DetailsOpp&headerId=<%= opportunityHeader.getId() %>&contactId=<%= ContactDetails.getId() %><%= addLinkParams(request, "popup|popupType|actionId|from|listForm") %>"><dhv:label name="accounts.accounts_contacts_oppcomponent_add.OpportunityDetails">Opportunity Details</dhv:label></a> >
<dhv:label name="accounts.accounts_opportunities_addoppcomponent.AddComponent">Add Component</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>

</dhv:evaluate>
<dhv:container name="leads" selected="opportunities" object="ContactDetails" param='<%= "id=" + ContactDetails.getId() %>' appendToUrl='<%= addLinkParams(request, "popup|popupType|actionId|from|listForm") %>'>
  <img src="images/icons/stock_form-currency-field-16.gif" border="0" align="absmiddle">
  <strong><%= toHtml(opportunityHeader.getDescription()) %></strong>
  <% FileItem thisFile = new FileItem(); %>
  <dhv:evaluate if="<%= opportunityHeader.hasFiles() %>">
    <%= thisFile.getImageTag() %>
  </dhv:evaluate>
  <br>
  <br>
  <input type="submit" value="<dhv:label name="global.button.save">Save</dhv:label>" onClick="this.form.dosubmit.value='true';">
  <input type="submit" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:this.form.action='SalesOpportunities.do?command=DetailsOpp&headerId=<%= opportunityHeader.getId() %>&contactId=<%= ContactDetails.getId() %><%= addLinkParams(request, "popup|popupType|actionId|from|listForm") %>';this.form.dosubmit.value='false';">
  <br />
  <dhv:formMessage />
  <%@ include file="../pipeline/opportunity_include.jsp" %>
  <br />
  <input type="submit" value="<dhv:label name="global.button.save">Save</dhv:label>" onClick="this.form.dosubmit.value='true';">
  <input type="submit" value="<dhv:label name="global.button.cancel">Cancel</dhv:label>" onClick="javascript:this.form.action='SalesOpportunities.do?command=DetailsOpp&id=<%= opportunityHeader.getId() %>&contactId=<%= ContactDetails.getId() %><%= addLinkParams(request, "popup|popupType|actionId|from|listForm") %>';this.form.dosubmit.value='false';">
  <input type="hidden" name="contactId" value="<%= ContactDetails.getId() %>">
  <input type="hidden" name="dosubmit" value="true">
  <input type="hidden" name="headerId" value="<%= opportunityHeader.getId() %>">
  <input type="hidden" name="actionSource" value="SalesOpportunitiesComponents">
</dhv:container>
</form>
</body>
