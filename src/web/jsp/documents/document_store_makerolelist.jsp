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
  - Author(s): 
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.utils.web.*,org.aspcfs.utils.StringUtils , org.aspcfs.modules.admin.base.*, org.aspcfs.modules.documents.base.* " %>
<jsp:useBean id="roles" class="org.aspcfs.modules.admin.base.RoleList" scope="request"/>
<jsp:useBean id="SiteIdList" class="org.aspcfs.utils.web.LookupList" scope="request"/>
<jsp:useBean id="siteId" class="java.lang.String" scope="request"/>
<body onload='page_init();'>
<script language='Javascript'>
function page_init() {
  var list = parent.document.forms['documentStoreMemberForm'].elements['selDepartment'];
  list.options.length = 0;
<%
  Iterator i = roles.iterator();
  while (i.hasNext()) {
    Role element = (Role) i.next();
    if ("group".equals(request.getAttribute("memberType"))){
%>
      if ( !(inArray(parent.document.forms['documentStoreMemberForm'].elements['selRoleList'], <%= element.getId() %> + '-R<%= siteId.trim() %>')) ) {
        var newOpt = parent.document.createElement("OPTION");
        newOpt.text="<%= StringUtils.jsStringEscape(element.getRole()) %><%= siteId != null && !"".equals(siteId.trim()) && !"-1".equals(siteId.trim()) ?" ("+StringUtils.jsStringEscape(SiteIdList.getSelectedValue(Integer.parseInt(siteId)))+")":"" %>";
        newOpt.value='<%= element.getId()%>' + '-R<%= (siteId != null && !"".equals(siteId.trim())? siteId:"-1") %>';
        list.options[list.length] = newOpt;
      }
      parent.initList('<%= element.getId()%>' + '-R<%= (siteId != null && !"".equals(siteId.trim())? siteId:"-1") %>');
      parent.setGroupType('<%=DocumentStoreTeamMemberList.ROLE%>');
<%
    }else{
%>
    var newOpt = parent.document.createElement("OPTION");
    newOpt.text="<%= StringUtils.jsStringEscape(element.getRole()) %>";
    newOpt.value='<%= element.getId() %>';
    list.options[list.length] = newOpt;
<%
    }
  }
%>
}
function inArray(a, s) {
	var i = 0;
	for(i=0; i < a.length; i++) {
		if (a.options[i].value == s) {
			return true;
		}
	}
	return false;
}
</script>
</body>
