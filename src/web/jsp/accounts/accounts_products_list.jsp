<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,java.text.DateFormat,org.aspcfs.modules.accounts.base.*,com.zeroio.iteam.base.*,org.aspcfs.modules.products.base.*" %>
<jsp:useBean id="OrgDetails" class="org.aspcfs.modules.accounts.base.Organization" scope="request"/>
<jsp:useBean id="CustomerProductList" class="org.aspcfs.modules.products.base.CustomerProductList" scope="request"/>
<jsp:useBean id="SearchCustomerProductListInfo" class="org.aspcfs.utils.web.PagedListInfo" scope="session" />
<%@ include file="../initPage.jsp" %>
<%-- Initialize the drop-down menus --%>
<%@ include file="../initPopupMenu.jsp" %>
<%@ include file="accounts_products_list_menu.jsp" %>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/spanDisplay.js"></SCRIPT>
<script language="JavaScript" type="text/javascript" src="javascript/confirmDelete.js"></script>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<script language="JavaScript" type="text/javascript">
  <%-- Preload image rollovers for drop-down menu --%>
  loadImages('select');
</script>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Accounts.do"><dhv:label name="accounts.accounts">Accounts</dhv:label></a> > 
<a href="Accounts.do?command=Search"><dhv:label name="accounts.SearchResults">Search Results</dhv:label></a> >
<a href="Accounts.do?command=Details&orgId=<%= OrgDetails.getOrgId() %>"><dhv:label name="accounts.details">Account Details</dhv:label></a> >
<dhv:label name="product.products">Products</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<dhv:container name="accounts" selected="products" object="OrgDetails" param="<%= "orgId=" + OrgDetails.getOrgId() %>" appendToUrl="<%= addLinkParams(request, "popup|popupType|actionId") %>">
<a href="AccountsProducts.do?command=Add&orgId=<%= OrgDetails.getOrgId() %>"><dhv:label name="product.addProduct">Add Product</dhv:label></a><br>
<dhv:pagedListStatus title="<%= showError(request, "actionError") %>" object="SearchCustomerProductListInfo"/>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th width="8">&nbsp;</th>
    <th>
      <strong><dhv:label name="accounts.accounts_calls_list.Subject">Subject</dhv:label></strong>
    </th>
    <th>
      <strong><dhv:label name="accounts.accountasset_include.Category">Category</dhv:label></strong>
    </th>
    <th>
      <strong><a href="AccountsProducts.do?command=List&orgId=<%= OrgDetails.getOrgId() %>&column=cp.description"><dhv:label name="accounts.accountasset_include.Description">Description</dhv:label></a></strong>
      <%= SearchCustomerProductListInfo.getSortIcon("cp.description") %>
    </th>
    <th align="center"><dhv:label name="documents.documents.submitted">Submitted</dhv:label></th>
  </tr>
<%
  Iterator j = CustomerProductList.iterator();
  if ( j.hasNext() ) {
    int rowid = 0;
    int i = 0;
    while (j.hasNext()) {
      i++;
      rowid = (rowid != 1?1:2);
      CustomerProduct thisProduct = (CustomerProduct) j.next();
      // find the svg file from the customer product's file list
      Iterator k = thisProduct.getFileItemList().iterator();
      FileItem targetFile = null;
      while (k.hasNext()) {
        targetFile = (FileItem) k.next();
        if (".svg".equals(targetFile.getExtension())) {
          break ;
        }
      }
      
%>      
    <tr class="row<%= rowid %>">
      <dhv:evaluate if="<%= targetFile != null %>">
      <td width="10" valign="middle" align="center" nowrap>
        <%-- Use the unique id for opening the menu, and toggling the graphics --%>
        <%-- To display the menu, pass the actionId, accountId and the contactId--%>
        <a href="javascript:displayMenu('menuFile','<%= OrgDetails.getId() %>','<%= thisProduct.getId() %>','<%= targetFile.getId() %>');" onMouseOver="over(0, <%= i %>)" onmouseout="out(0, <%= i %>)"><img src="images/select.gif" name="select<%= i %>" align="absmiddle" border="0"></a>
      </td>
      <td valign="middle" nowrap>
        <%
           if (".svg".equals(targetFile.getExtension())) {
        %>
            <a href="AccountsProducts.do?command=SVGDetails&orgId=<%= OrgDetails.getOrgId() %>&adId=<%= thisProduct.getId() %>&fid=<%= targetFile.getId() %>"><%= toHtml(targetFile.getSubject()) %></a>
        <% } else { %>
            <a href="AccountsProducts.do?command=Details&orgId=<%= OrgDetails.getOrgId() %>&adId=<%= thisProduct.getId() %>&fid=<%= targetFile.getId() %>"><%= toHtml(targetFile.getSubject()) %></a>
        <% } %>
      </td>
      <td valign="middle" nowrap>
        <dhv:evaluate if="<%= thisProduct.getProduct() != null %>">
          <%= toHtml(thisProduct.getProduct().getCategoryName()) %>
        </dhv:evaluate>
      </td>
      <td valign="middle" width="50%">
        <%= toHtml(thisProduct.getDescription()) %>
      </td>
      <td nowrap>
        <dhv:tz timestamp="<%= thisProduct.getModified() %>" dateFormat="<%= DateFormat.SHORT %>" timeFormat="<%= DateFormat.LONG %>"/><br>
        <dhv:username id="<%= thisProduct.getEnteredBy() %>"/>
      </td>
      </dhv:evaluate>
      <dhv:evaluate if="<%= targetFile == null %>">
        <td colspan="5"><dhv:label name="account.brokerRecordFound">Broken Record Found</dhv:label></td>
      </dhv:evaluate>
    </tr>
<%}%>
  </table>
  <br>
  <dhv:pagedListControl object="SearchCustomerProductListInfo"/>
<%} else {%>
    <tr class="containerBody">
      <td colspan="7">
        <dhv:label name="account.product.noProductsFound">No Products found.</dhv:label>
      </td>
    </tr>
  </table>
<%}%>
</dhv:container>