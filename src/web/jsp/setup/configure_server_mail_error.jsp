<%--
  - Copyright Notice: (C) 2000-2004 Dark Horse Ventures, All Rights Reserved.
  - License: This source code cannot be modified, distributed or used without
  -          written permission from Dark Horse Ventures. This notice must
  -          remain in place.
  - Version: $Id$
  - Description:
  --%>
<%@ include file="../initPage.jsp" %>
<table border="0" width="100%">
  <tr class="sectionTitle">
    <th>
      Dark Horse CRM Mail Test
    </th>
  </tr>
  <tr>
    <td>
      Email failed.  The email transport returned the following error:<br>
      <dhv:formMessage />
      <input type="button" value="OK" onClick="javascript:window.close()"/>
    </td>
  </tr>
</table>
