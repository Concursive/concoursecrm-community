<%-- 
  - Copyright(c) 2004 Concursive Corporation (http://www.concursive.com/) All
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
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ page import="java.util.*, org.aspcfs.modules.products.base.*, org.aspcfs.modules.products.configurator.*" %>
<jsp:useBean id="PermissionCategory" class="org.aspcfs.modules.admin.base.PermissionCategory" scope="request"/>
<jsp:useBean id="ProductOption" class="org.aspcfs.modules.products.base.ProductOption" scope="request"/>
<jsp:useBean id="PropertyList" class="org.aspcfs.modules.products.configurator.OptionPropertyList" scope="request"/>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<%@ include file="../initPage.jsp" %>
<%-- Trails --%>
<dhv:evaluate if="<%= !isPopup(request) %>">
<table class="trails" cellspacing="0">
	<tr>
		<td>
			<a href="ProductCatalogEditor.do?command=List"><dhv:label name="product.products">Products</dhv:label></a> >
			<a href="ProductCatalogEditor.do?command=Options&moduleId=<%= PermissionCategory.getId() %>"><dhv:label name="product.editor">Editor</dhv:label></a> >
			<a href="ProductOptions.do?command=SearchForm&moduleId=<%= PermissionCategory.getId() %>"><dhv:label name="product.searchOptions">Search Options</dhv:label></a> >
      <a href="ProductOptions.do?command=Search&moduleId=<%= PermissionCategory.getId() %>"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
      <a href="ProductOptions.do?command=Add&moduleId=<%= PermissionCategory.getId() %>"><dhv:label name="product.optionChoice">Option Choice</dhv:label></a> >
      <dhv:label name="button.createOption">Create Option</dhv:label>
		</td>
	</tr>
</table>
</dhv:evaluate>
<%-- End Trails --%>
<form name="paramForm" method="post" action="ProductOptions.do?command=InsertOption&auto-populate=true&moduleId=<%= PermissionCategory.getId() %>">
<input type="submit" value="<dhv:label name="button.createOption">Create Option</dhv:label>"/><br /><br />
<input type="hidden" name="configId" value="<%= request.getParameter("configId") %>"/>
<input type="hidden" name="productId" value="<%= request.getParameter("catalogId") %>"/>
<input type="hidden" name="catalogId" value="<%= request.getParameter("catalogId") %>"/>
<input type="hidden" name="moduleId" value="<%= request.getParameter("moduleId") %>">
<input type="hidden" name="popup" value="<%= request.getParameter("popup") %>"/>
<input type="hidden" name="action" value="<%= request.getParameter("action") %>"/>
<% ProductOption productOption = ProductOption; %>
<%@ include file="product_option_configurator_field_include.jsp" %>
<br />
<input type="submit" value="<dhv:label name="button.createOption">Create Option</dhv:label>"/>
</form>
