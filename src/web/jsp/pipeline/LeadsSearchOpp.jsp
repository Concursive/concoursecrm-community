<jsp:useBean id="OrgList" class="org.aspcfs.modules.accounts.base.OrganizationList" scope="request"/>
<jsp:useBean id="StageList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<script language="JavaScript" TYPE="text/javascript" SRC="javascript/popCalendar.js"></script>
<script language="JavaScript" type="text/javascript" src="javascript/popContacts.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popAccounts.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/submit.js"></script>
<body onLoad="javascript:document.forms[0].searchDescription.focus();">
<form name="searchLeads" action="Leads.do?command=Search" method="post">
<%-- Trails --%>
<table class="trails">
<tr>
<td>
<a href="Leads.do">Pipeline</a> > 
Search Opportunities
</td>
</tr>
</table>
<%-- End Trails --%>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong>Search Pipeline</strong>
    </th>
  </tr>
  <tr>
    <td class="formLabel" nowrap>
      Opportunity Description
    </td>
    <td>
      <input type="text" size="35" name="searchDescription">
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      Account
    </td>
    <td>
      <table cellspacing="0" cellpadding="0" border="0" class="empty">
        <tr>
          <td>
            <div id="changeaccount">None Selected</div>
          </td>
          <td>
            <input type="hidden" name="searchcodeOrgId" id="searchcodeOrgId">
            &nbsp;[<a href="javascript:popAccountsListSingle('searchcodeOrgId','changeaccount', 'filters=all|my|disabled');">Select</a>]
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Contact
    </td>
    <td>
      <table class="empty">
        <tr>
          <td>
            <div id="changecontact">None Selected</div>
          </td>
          <td>
            <input type="hidden" id="contactId" name="searchcodeContactId" value="-1">
            &nbsp;[<a href="javascript:popContactsListSingle('contactId','changecontact', 'reset=true');">Select</a>]
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td nowrap class="formLabel">
      Current Stage
    </td>
    <td>
      <%= StageList.getHtmlSelectDefaultNone("searchcodeStage") %>
    </td>
  </tr>
  <tr>
    <td valign="top" class="formLabel">
      Est. Close Date between
    </td>
    <td>
      <input type="text" size="10" name="searchdateCloseDateStart" value="">
      <a href="javascript:popCalendar('searchLeads', 'searchdateCloseDateStart');"><img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle" height="16" width="16"/></a> (mm/dd/yyyy)
      &nbsp;and<br>
      <input type="text" size="10" name="searchdateCloseDateEnd" value="">
      <a href="javascript:popCalendar('searchLeads', 'searchdateCloseDateEnd');"><img src="images/icons/stock_form-date-field-16.gif" border="0" align="absmiddle" height="16" width="16"/></a> (mm/dd/yyyy)
    </td>
  </tr>
</table>
&nbsp;<br>
<input type="submit" value="Search">
<input type="reset" value="Clear">
</form>
</body>
