<%-- 
  - Copyright Notice: (C) 2000-2004 Dark Horse Ventures, All Rights Reserved.
  - License: This source code cannot be modified, distributed or used without
  -          written permission from Dark Horse Ventures. This notice must
  -          remain in place.
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.products.base.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="productDetails" class="org.aspcfs.modules.products.base.ProductCatalog" scope="request"/>
<jsp:useBean id="categoryList" class="org.aspcfs.modules.products.base.ProductCategoryList" scope="request"/>
<jsp:useBean id="PermissionCategory" class="org.aspcfs.modules.admin.base.PermissionCategory" scope="request"/>
<%@ include file="../initPage.jsp" %>
<form name="viewProduct" action="ProductsCatalog.do?command=ModifyProduct&productId=<%=productDetails.getId()%>&moduleId=<%= PermissionCategory.getId() %>&return=view" method="post">
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Admin.do">Admin</a> >
<a href="Admin.do?command=Config">Configure Modules</a> >
<a href="Admin.do?command=ConfigDetails&moduleId=<%= PermissionCategory.getId() %>"><%= toHtml(PermissionCategory.getCategory()) %></a> >
<a href="ProductsCatalog.do?command=ListAllProducts&moduleId=<%= PermissionCategory.getId() %>">Labor Category Editor</a> >
Item Details
</td>
</tr>
</table>
<%-- End Trails --%>
<table cellpadding="4" cellspacing="0" border="0" width="100%">
  <tr>
    <td>
      <dhv:permission name="admin-sysconfig-products-edit"><input	type="submit" value="Modify" /></dhv:permission>
      <dhv:permission name="admin-sysconfig-products-delete"><input type="button" value="Delete" onClick="javascript:popURLReturn('ProductsCatalog.do?command=ConfirmDeleteProduct&productId=<%=productDetails.getId()%>&moduleId=<%= PermissionCategory.getId() %>&popup=true','ProductsCatalog.do?command=ViewProduct&productId=<%=productDetails.getId()%>&moduleId=<%= PermissionCategory.getId() %>', 'Delete_product','330','250','yes','no');"></dhv:permission>
      <dhv:permission name="admin-sysconfig-products-edit,admin-sysconfig-products-delete" all="false"><br /><br /></dhv:permission>
        <table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
          <tr>
            <th colspan="2">
              <strong>Details</strong>
            </th>
          </tr>
          <tr class="containerBody">
            <td class="formLabel">
              Code
            </td>
            <td>
              <%=toHtml(productDetails.getSku())%>
            </td>
          </tr>
          <tr class="containerBody">
            <td class="formLabel">
              Description
            </td>
            <td>
              <%=toHtml(productDetails.getName())%>
            </td>
          </tr>
          <tr class="containerBody">
            <td class="formLabel">
              Category
            </td>
            <td>
              <%= toHtml(productDetails.getCategoryName()) %>
            </td>
          </tr>
        </table>
      <br />
      <dhv:permission name="admin-sysconfig-products-edit"><input	type="submit" value="Modify" /></dhv:permission>
      <dhv:permission name="admin-sysconfig-products-delete"><input type="button" value="Delete" onClick="javascript:popURLReturn('ProductsCatalog.do?command=ConfirmDeleteProduct&productId=<%=productDetails.getId()%>&moduleId=<%= PermissionCategory.getId() %>&popup=true','ProductsCatalog.do?command=ViewProduct&productId=<%=productDetails.getId()%>&moduleId=<%= PermissionCategory.getId() %>', 'Delete_product','330','250','yes','no');"></dhv:permission>
  </td>
  </tr>
</table>
</form>
