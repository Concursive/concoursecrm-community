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
<script language="javascript">
  var thisCriteriaId = -1;
  var menu_init = false;
  //Set the action parameters for clicked item
  function displayMenu(loc, id, criteriaId) {
    thisCriteriaId = criteriaId;
    if (!menu_init) {
      menu_init = true;
      new ypSlideOutMenu("menu1", "down", 0, 0, 170, getHeight("menu1Table"));
    }
    return ypSlideOutMenu.displayDropMenu(id, loc);
  }
  //Menu link functions
  function select() {
    window.location.href='Reports.do?command=ParameterList&categoryId=<%= category.getId() %>&reportId=<%= report.getId() %>&criteriaId=' + thisCriteriaId;
  }
  function deleteCriteria() {
    confirmDelete('Reports.do?command=DeleteCriteria&categoryId=<%= category.getId() %>&reportId=<%= report.getId() %>&criteriaId=' + thisCriteriaId);
  }
</script>
<div id="menu1Container" class="menu">
  <div id="menu1Content">
    <table id="menu1Table" class="pulldown" width="170" cellspacing="0">
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="select()">
        <th>
          <img src="images/icons/stock_compile-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          <dhv:label name="reports.useThisCriteria">Use this criteria</dhv:label>
        </td>
      </tr>
      <tr onmouseover="cmOver(this)" onmouseout="cmOut(this)" onclick="deleteCriteria()">
        <th>
          <img src="images/icons/stock_delete-16.gif" border="0" align="absmiddle" height="16" width="16"/>
        </th>
        <td width="100%">
          <dhv:label name="reports.deleteThisCriteria">Delete this criteria</dhv:label>
        </td>
      </tr>
    </table>
  </div>
</div>
