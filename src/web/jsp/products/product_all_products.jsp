<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.products.base.*,com.zeroio.iteam.base.*" %>
<jsp:useBean id="productList" class="org.aspcfs.modules.products.base.ProductCatalogList" scope="request"/>
<jsp:useBean id="productCatalogListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session"/>
<%@ include file="../initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>
<%@ include file="product_list_menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<script language="JavaScript" type="text/javascript">
  <%-- Preload image rollovers for drop-down menu --%>
  loadImages('select');
</script>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="ProductsCatalog.do?command=ListAllProducts">Products</a> > 
View Products
</td>
</tr>
</table>
<%-- End Trails --%>
<dhv:pagedListStatus title="<%= showError(request, "actionError") %>" object="productCatalogListInfo"/>
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <tr>
		<th>
      <strong>Action</strong>
    </th>
    <th width="20%"> 
      <strong>Code</strong>
    </th>
    <th width="80%"> 
      <strong>Description</strong>
    </th>
  </tr>
 <%
    Iterator itr = productList.iterator();
    if (itr.hasNext()){
		  int rowid = 0;
    	int i = 0;
      while (itr.hasNext()) {
        i++;
	      rowid = (rowid != 1?1:2);
    	  ProductCatalog thisProduct = (ProductCatalog)itr.next();
  %>
       <tr class="row<%= rowid %>">
        <td>
          <%-- Use the unique id for opening the menu, and toggling the graphics --%>
           <a href="javascript:displayMenu('menuProduct', '<%= thisProduct.getId() %>');" onMouseOver="over(0, <%= i %>)" onmouseout="out(0, <%= i %>)"><img src="images/select.gif" name="select<%= i %>" align="absmiddle" border="0"></a>
        </td>
        <td>
          <a href="ProductsCatalog.do?command=ViewProductDetails&productId=<%=thisProduct.getId()%>"><%= thisProduct.getSku() %></a>
        </td>
        <td>
          <%= toHtml(thisProduct.getName()) %>
        </td>
        </tr>
     <%}%>
   <%}else{%>
       <tr class="row2">
        <td colspan="3">No products found.</td>
       </tr>
   <%}%>
  </table>
<br>
<dhv:pagedListControl object="productCatalogListInfo"/>

       
