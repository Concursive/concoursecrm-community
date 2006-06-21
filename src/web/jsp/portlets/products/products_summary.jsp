<%@ page import="org.aspcfs.utils.StringUtils"%>
<%--
- Copyright(c) 2006 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
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
- Version: $Id:  $
- Description:
--%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ taglib uri="/WEB-INF/portlet.tld" prefix="portlet" %>
<%@ page import="java.io.*, java.util.*, org.aspcfs.modules.products.base.*" %>
<jsp:useBean id="introduction" class="java.lang.String" scope="request"/>
<jsp:useBean id="parentCategory" class="org.aspcfs.modules.products.base.ProductCategory" scope="request"/>
<jsp:useBean id="productCategoryList" class="org.aspcfs.modules.products.base.ProductCategoryList" scope="request"/>
<jsp:useBean id="productCatalogList" class="org.aspcfs.modules.products.base.ProductCatalogList" scope="request"/>
<%@ include file="../../initPage.jsp" %>
<%@ include file="../../initPopupMenu.jsp" %>
<portlet:defineObjects/>
<dhv:evaluate if="<%= StringUtils.hasText(introduction) %>">
  <table cellpadding="0" cellspacing="0" border="0" width="100%">
    <tr>
      <td>
        <%= StringUtils.toHtml(introduction) %>
      </td>
    </tr>
  </table>
  <br />
</dhv:evaluate>
<dhv:evaluate if="<%= productCategoryList.size() > 0 %>">
<table cellpadding="4" cellspacing="0" border="0" width="100%">
	<tr>
		<th style="text-align:left;">
      <table align="center" width="100%" cellpadding="4" cellspacing="0" border="0"><tr><td nowrap valign="bottom" align="left">
			Categories
      </td></tr></table>
		</th>
	</tr>
	<tr>
		<td>
<%
	Iterator categoryIterator = productCategoryList.iterator();		
	if (categoryIterator.hasNext()) {
		while (categoryIterator.hasNext()) {
			ProductCategory productCategory = (ProductCategory)categoryIterator.next();
	%>
			<portlet:renderURL var="categoryUrl">
				<portlet:param name="viewType" value="summary"/>
				<portlet:param name="categoryId" value="<%= String.valueOf(productCategory.getId()) %>"/>
			</portlet:renderURL>
			<a href="<%= pageContext.getAttribute("categoryUrl") %>"><%=  productCategory.getName() %></a>&nbsp;&nbsp;&nbsp;
	<%	
		 }
		} else {
	%>
		No categories are available for the chosen category.
	<%	
		 }
	%>                                     
	</td>
</tr>
</table>
  <dhv:evaluate if="<%= productCatalogList.size() > 0 %>">
	  <br />
  </dhv:evaluate>
</dhv:evaluate>
<dhv:evaluate if="<%= productCatalogList.size() > 0 || parentCategory.getId() != Integer.parseInt((String)request.getAttribute("preferredCategoryId")) %>">
<table cellpadding="4" cellspacing="0" border="0" width="100%">
	<tr>
		<th>
			<dhv:pagedListStatus title="<%= StringUtils.toHtml(parentCategory.getName()) %>" object="productCatalogListInfo" label="Items"/>
		</th>
	</tr>
	<tr>
		<td style="text-align:left;">
			<dhv:evaluate if="<%=!(parentCategory.getId() == Integer.parseInt((String)request.getAttribute("preferredCategoryId")))%>">
				<portlet:renderURL var="parentUrl">
					<portlet:param name="viewType" value="summary"/>
					<portlet:param name="categoryId" value="<%= String.valueOf(parentCategory.getParentId()) %>"/>
				</portlet:renderURL>
				&nbsp;[<a href="<%= pageContext.getAttribute("parentUrl") %>">Back to Parent Category</a>]
			</dhv:evaluate>
		</td>
	</tr>
	<tr>
		<td>
<%
	Iterator productIterator = productCatalogList.iterator();
	if (productIterator.hasNext()){
		int offset = productCatalogList.getPagedListInfo().getCurrentOffset();
		while (productIterator.hasNext()) {
			ProductCatalog productCatalog = (ProductCatalog)productIterator.next();
	%>
			<portlet:renderURL var="url">
				<portlet:param name="page" value="<%= String.valueOf(offset%10) %>"/>
				<portlet:param name="viewType" value="details"/>
				<portlet:param name="productId" value="<%= String.valueOf(productCatalog.getId()) %>"/>
				<portlet:param name="categoryId" value="<%= String.valueOf(parentCategory.getId()) %>"/>
				<portlet:param name="offset" value="<%= String.valueOf(offset) %>"/>
			</portlet:renderURL>
				<div style="float: left;width: 140px;height: 160px;padding-right: 3px;">
          <table border="0" width="140" height="160" cellpadding="0" cellspacing="0">
            <tr>
							<td width="140" height="160" valign="top">
								<a href="<%= pageContext.getAttribute("url") %>">
                  <dhv:evaluate if="<%= productCatalog.getThumbnailImageId() > -1 %>"><dhv:fileItemImage id="<%=  productCatalog.getThumbnailImageId() %>" path="products" thumbnail="true" name="<%=  productCatalog.getName() %>" /></dhv:evaluate>
                  <dhv:evaluate if="<%= productCatalog.getThumbnailImageId() == -1 %>"><dhv:fileItemImage id="<%=  productCatalog.getLargestImageId() %>" path="products" thumbnail="true" name="<%=  productCatalog.getName() %>" /></dhv:evaluate>
									<div><%=  StringUtils.toHtml(productCatalog.getName()) %></div></a>
							</td>
						</tr>
          </table>
				</div>
	<%	
			offset++;
		}
	} else {
%>
			No products are available for the chosen category.
	<%	
		}
 %>
		</td>
	</tr>
</table>
</dhv:evaluate>
