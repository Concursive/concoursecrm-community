<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*,com.darkhorseventures.autoguide.base.*" %>
<jsp:useBean id="OrgDetails" class="com.darkhorseventures.cfsbase.Organization" scope="request"/>
<jsp:useBean id="InventoryList" class="com.darkhorseventures.autoguide.base.InventoryList" scope="request"/>
<jsp:useBean id="AutoGuideAccountInfo" class="com.darkhorseventures.webutils.PagedListInfo" scope="session"/>
<%@ include file="initPage.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="/javascript/confirmDelete.js"></SCRIPT>
<link rel="stylesheet" href="css/photolist.css" type="text/css">
<form name="listView" method="post" action="AccountsAutoGuide.do?command=AccountList&orgId=<%= OrgDetails.getOrgId() %>">
<a href="Accounts.do?command=View">Back to Account List</a><br>&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="containerHeader">
    <td>
      <strong><%= toHtml(OrgDetails.getName()) %></strong>
    </td>
  </tr>
  <tr class="containerMenu">
    <td>
      <% String param1 = "orgId=" + OrgDetails.getOrgId(); %>      
      <dhv:container name="accounts" selected="vehicles" param="<%= param1 %>" />
    </td>
  </tr>
  <tr>
    <td class="containerBack">
<dhv:permission name="autoguide-inventory-add"><a href="AccountsAutoGuide.do?command=AccountAdd&orgId=<%= OrgDetails.getOrgId() %>">Add a Vehicle</a></dhv:permission>
<dhv:permission name="autoguide-inventory-add" none="true"><br></dhv:permission>
<center><%= AutoGuideAccountInfo.getAlphabeticalPageLinks() %></center>
<table width="100%" border="0">
  <tr>
    <td align="left">
      View: <select size="1" name="listView" onChange="javascript:document.forms[0].submit();">
        <option <%= AutoGuideAccountInfo.getOptionValue("list") %>>List View</option>
        <option <%= AutoGuideAccountInfo.getOptionValue("slides") %>>Ad View</option>
      </select>
      <%= showAttribute(request, "actionError") %>
    </td>
  </tr>
</table>

<table cellpadding="10" cellspacing="0" border="0" width="100%">
<%
  int rowcount = 0;
  int count = 0; 
	Iterator i = InventoryList.iterator();
	if (i.hasNext()) {
    while (i.hasNext()) {
      Inventory thisItem = (Inventory)i.next();
      ++count;
      if ((count+2)%3 == 0) {
        ++rowcount;
      }
%>
<dhv:evaluate exp="<%= (count+2)%3 == 0 %>">  
  <tr>
</dhv:evaluate>
    <td class="PhotoList<%= (rowcount == 1?"":"AdditionalRow") %>">
      <p>
        <a href="AccountsAutoGuide.do?command=Details&orgId=<%= OrgDetails.getOrgId() %>&id=<%= thisItem.getId()%>"><img src="images/vehicle_unavailable.gif" border="0"/></a>
      </p>
      <p>
        <span>
          <%= toHtml(OrgDetails.getName()) %>
          <br><%= thisItem.getVehicle().getYear() %> <%= toHtml(thisItem.getVehicle().getMake().getName()) %> <%= toHtml(thisItem.getVehicle().getModel().getName()) %>
<dhv:evaluate exp="<%= (thisItem.getSellingPrice() > 0) %>">
          <br><%= thisItem.getSellingPriceString() %>
</dhv:evaluate>
        </span>
      </p>
    </td>
<dhv:evaluate exp="<%= count%3 == 0 %>">
  </tr>
</dhv:evaluate>
<%
    }
%>    
<dhv:evaluate exp="<%= count%3 != 0 %>">  
  </tr>
</dhv:evaluate>
<%  
  } else {%>  
  <tr>
    <td class="PhotoList" valign="center" colspan="7">
      No vehicles found.
    </td>
  </tr>
<%}%>
</table>
<br>
[<%= AutoGuideAccountInfo.getPreviousPageLink("<font class='underline'>Previous</font>", "Previous") %> <%= AutoGuideAccountInfo.getNextPageLink("<font class='underline'>Next</font>", "Next") %>] <%= AutoGuideAccountInfo.getNumericalPageLinks() %>
</td>
</tr>
</table>
</form>
