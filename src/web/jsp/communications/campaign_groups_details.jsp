<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.communications.base.*,org.aspcfs.utils.web.LookupElement" %>
<jsp:useBean id="scl" class="org.aspcfs.modules.communications.base.SearchCriteriaList" scope="request"/>
<%@ include file="../initPage.jsp" %>
<a href="CampaignManager.do">Communications Manager</a> >
<a href="CampaignManagerGroup.do?command=View">View Groups</a> >
Group Details
<hr color="#BFBFBB" noshade>
<dhv:permission name="campaign-campaigns-groups-edit"><input type="button" name="cmd" value="Modify" onClick="window.location.href='CampaignManagerGroup.do?command=Modify&id=<%= request.getAttribute("id") %>'"></dhv:permission>
<dhv:permission name="campaign-campaigns-groups-delete"><input type="button" name="cmd" value="Delete Group" onClick="popURLReturn('CampaignManagerGroup.do?command=ConfirmDelete&id=<%= request.getAttribute("id") %>&popup=true','CampaignManagerGroup.do?command=View', 'Delete_group','330','200','yes','no');"></dhv:permission>
<input type="button" name="cmd" value="Preview" onClick="window.location.href='CampaignManagerGroup.do?command=Preview&id=<%= request.getAttribute("id") %>&reset=true'">
<br>
&nbsp;<br>
<table cellpadding="4" cellspacing="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong><%= scl.getGroupName() %></strong>
    </th>
  </tr>
  <tr>
    <th colspan="2">
      Criteria
    </th>
  </tr>
<%
  LinkedHashMap criteriaList = scl.getCriteriaTextArray();
  Iterator i = criteriaList.keySet().iterator();
	if (!i.hasNext()) {
%>
  <tr class="containerBody">
    <td colspan="2">
      This group doesn't have any criteria defined
    </td>
  </tr>
<%
  }
  int rowid = 0;
  int count = 0;
  while (i.hasNext()) {
    ++count;
    rowid = (rowid != 1?1:2);
    String key = (String) i.next();
%>
  <tr class="row<%= rowid %>">
    <td align="right" nowrap>
      <%= count %>.
    </td>
    <td width="100%">
      <%= (String) criteriaList.get(key) %>
    </td>
  </tr>
<%
  }
%>
</table>
&nbsp;<br>
<dhv:permission name="campaign-campaigns-groups-edit"><input type="button" name="cmd" value="Modify" onClick="window.location.href='CampaignManagerGroup.do?command=Modify&id=<%= request.getAttribute("id") %>'"></dhv:permission>
<dhv:permission name="campaign-campaigns-groups-delete"><input type="button" name="cmd" value="Delete Group" onClick="popURLReturn('CampaignManagerGroup.do?command=ConfirmDelete&id=<%= request.getAttribute("id") %>&popup=true','CampaignManagerGroup.do?command=View', 'Delete_group','330','200','yes','no');"></dhv:permission>
<input type="button" name="cmd" value="Preview" onClick="window.location.href='CampaignManagerGroup.do?command=Preview&id=<%= request.getAttribute("id") %>&reset=true'">

