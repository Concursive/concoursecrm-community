<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*" %>
<jsp:useBean id="ContactDetails" class="com.darkhorseventures.cfsbase.Contact" scope="request"/>
<jsp:useBean id="OppDetails" class="com.darkhorseventures.cfsbase.Opportunity" scope="request"/>
<%@ include file="initPage.jsp" %>
<form name="oppdet" action="/ExternalContactsOpps.do?command=ModifyOpp&id=<%=OppDetails.getId()%>&orgId=<%= OppDetails.getAccountLink() %>&contactId=<%= OppDetails.getContactLink() %>" method="post">
<a href="/ExternalContactsOpps.do?command=ViewOpps&contactId=<%= ContactDetails.getId() %>">Back to Opportunity List</a><br>&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
      <strong><%= toHtml(ContactDetails.getNameFull()) %></strong>
    </td>
  </tr>
  <tr class="containerMenu">
    <td>
      <a href="/ExternalContacts.do?command=ContactDetails&id=<%= ContactDetails.getId() %>"><font color="#000000">Details</font></a> | 
      <font color="#787878">More Details</font> | 
      <a href="/ExternalContactsCalls.do?command=View&contactId=<%= ContactDetails.getId() %>"><font color="#000000">Calls</font></a> |
      <a href="/ExternalContactsOpps.do?command=ViewOpps&contactId=<%= ContactDetails.getId() %>"><font color="#0000FF">Opportunities</font></a> 
    </td>
  </tr>
  <tr>
    <td class="containerBack">
<input type=hidden name="command" value="<%= OppDetails.getId() %>">
<input type="submit" name="Modify" value="Modify">
<input type="submit" value="Delete" onClick="javascript:this.form.action='/ExternalContactsOpps.do?command=DeleteOpp&id=<%= OppDetails.getId() %>&orgId=<%= OppDetails.getAccountLink() %>&contactId=<%= OppDetails.getContactLink() %>'">
<br>
&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan=2 valign=center align=left>
      <strong><%= toHtml(OppDetails.getDescription()) %></strong>
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Owner
    </td>
    <td valign=center width=100%>
      <%= OppDetails.getOwnerName() %>
    </td>
  </tr>

  <tr class="containerBody">
    <td nowrap class="formLabel">
      Prob. of Close
    </td>
    <td valign=center width=100%>
      <%= OppDetails.getCloseProbPercent() %>
    </td>
  </tr>

  <tr class="containerBody">
    <td nowrap class="formLabel">
      Est. Close Date
    </td>
    <td>
      <%= OppDetails.getCloseDate() %>&nbsp;
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Low Estimate
    </td>
    <td>
      $<%= OppDetails.getLowCurrency() %>&nbsp;
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Best Guess
    </td>
    <td>
      $<%= OppDetails.getGuessCurrency() %>&nbsp;
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      High Estimate
    </td>
    <td>
      $<%= OppDetails.getHighCurrency() %>&nbsp;
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Current Stage
    </td>
    <td>
      <%= toHtml(OppDetails.getStageName()) %>&nbsp;
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Current Stage Date
    </td>
    <td>
      <%= toHtml(OppDetails.getStageDate()) %>&nbsp;
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Est. Commission
    </td>
    <td>
      <%= OppDetails.getCommissionPercent() %>
    </td>
  </tr>
  
  <tr class="containerBody">
    <td nowrap class="formLabel">
      Alert Date
    </td>
    <td>
      <%= toHtml(OppDetails.getAlertDate()) %>&nbsp;
    </td>
  </tr>
  
    <tr class="containerBody">
    <td nowrap class="formLabel">
      Entered
    </td>
    <td>
      <%= OppDetails.getEnteredByName() %>&nbsp;-&nbsp;<%= OppDetails.getEntered() %>
    </td>
  </tr>
  
      <tr class="containerBody">
    <td nowrap class="formLabel">
      Modified
    </td>
    <td>
      <%= OppDetails.getModifiedByName() %>&nbsp;-&nbsp;<%= OppDetails.getModified() %>
    </td>
  </tr>
  
</table>
&nbsp;
<br>
<input type="submit" name="Modify" value="Modify">
<input type="submit" value="Delete" onClick="javascript:this.form.action='/ExternalContactsOpps.do?command=DeleteOpp&id=<%= OppDetails.getId() %>&orgId=<%= OppDetails.getAccountLink() %>&contactId=<%= OppDetails.getContactLink() %>'">
  </td>
  </tr>
</table>
</form>
