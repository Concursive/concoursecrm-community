<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*,com.darkhorseventures.autoguide.base.*" %>
<jsp:useBean id="OrgDetails" class="com.darkhorseventures.cfsbase.Organization" scope="request"/>
<jsp:useBean id="InventoryItem" class="com.darkhorseventures.autoguide.base.Inventory" scope="request"/>
<%@ include file="initPage.jsp" %>
<form name="modInventory" action='/AccountsAutoGuide.do?command=AccountModify&id=<%= InventoryItem.getId() %>&orgId=<%= OrgDetails.getOrgId() %>' method='post'>
<a href="AccountsAutoGuide.do?command=AccountList&orgId=<%= OrgDetails.getOrgId() %>">Back to Vehicle List</a><br>&nbsp;
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
<dhv:permission name="autoguide-inventory-edit"><input type='submit' value='Modify' name='Modify'></dhv:permission>
<dhv:permission name="autoguide-inventory-delete"><input type="submit" value="Delete" onClick="javascript:this.form.action='AccountsAutoGuide.do?command=Delete&id=<%=InventoryItem.getId() %>&orgId=<%= OrgDetails.getOrgId() %>'"></dhv:permission>
<dhv:permission name="autoguide-inventory-edit,autoguide-inventory-delete"><br>&nbsp;</dhv:permission>

<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan="2" valign="center" align="center">
	    <strong><%= InventoryItem.getVehicle().getYear() %> <%= toHtml(InventoryItem.getVehicle().getMake().getName()) %> <%= toHtml(InventoryItem.getVehicle().getModel().getName()) %></strong>
	  </td>
  </tr>
<dhv:evaluate exp="<%= hasText(InventoryItem.getStockNo()) %>">
  <tr class="containerBody">
    <td nowrap class="formLabel">Stock No</td>
    <td><%= toHtml(InventoryItem.getStockNo()) %>&nbsp;</td>
  </tr>
</dhv:evaluate>
<dhv:evaluate exp="<%= (InventoryItem.getMileage() > -1) %>">
  <tr class="containerBody">
    <td nowrap class="formLabel">Mileage</td>
    <td><%= InventoryItem.getMileageString() %>&nbsp;</td>
  </tr>
</dhv:evaluate>
<dhv:evaluate exp="<%= hasText(InventoryItem.getVin()) %>">
  <tr class="containerBody">
    <td nowrap class="formLabel">VIN</td>
    <td><%= toHtml(InventoryItem.getVin()) %>&nbsp;</td>
  </tr>
</dhv:evaluate>
<dhv:evaluate exp="<%= (InventoryItem.getSellingPrice() > 0) %>">
  <tr class="containerBody">
    <td nowrap class="formLabel">Selling Price</td>
    <td><%= InventoryItem.getSellingPriceString() %>&nbsp;</td>
  </tr>
</dhv:evaluate>
<dhv:evaluate exp="<%= hasText(InventoryItem.getExteriorColor()) %>">
  <tr class="containerBody">
    <td nowrap class="formLabel">Exterior Color</td>
    <td><%= toHtml(InventoryItem.getExteriorColor()) %>&nbsp;</td>
  </tr>
</dhv:evaluate>
<dhv:evaluate exp="<%= hasText(InventoryItem.getCondition()) %>">
  <tr class="containerBody">
    <td nowrap class="formLabel">Condition</td>
    <td><%= toHtml(InventoryItem.getCondition()) %>&nbsp;</td>
  </tr>
</dhv:evaluate>
<dhv:evaluate exp="<%= hasText(InventoryItem.getComments()) %>">
  <tr class="containerBody">
    <td nowrap class="formLabel">Additional Text</td>
    <td><%= toHtml(InventoryItem.getComments()) %>&nbsp;</td>
  </tr>
</dhv:evaluate>
<dhv:evaluate exp="<%= InventoryItem.hasOptions() %>">
  <tr class="containerBody">
    <td nowrap class="formLabel">Options</td>
    <td>
<%
      Iterator options = InventoryItem.getOptions().iterator();
      while (options.hasNext()) {
        Option thisOption = (Option)options.next();
%>
      <%= toHtml(thisOption.getName()) %><%= (options.hasNext()?", ":"") %>
<%
      }
%>
    </td>
  </tr>
</dhv:evaluate>
</table>
<dhv:permission name="autoguide-inventory-edit,autoguide-inventory-delete"><br></dhv:permission>
<dhv:permission name="autoguide-inventory-edit"><input type='submit' value='Modify' name='Modify'></dhv:permission>
<dhv:permission name="autoguide-inventory-delete"><input type="submit" value="Delete" onClick="javascript:this.form.action='AccountsAutoGuide.do?command=Delete&id=<%= InventoryItem.getId() %>&orgId=<%= OrgDetails.getOrgId() %>'"></dhv:permission>
  </td>
  </tr>
</table>
</form>

