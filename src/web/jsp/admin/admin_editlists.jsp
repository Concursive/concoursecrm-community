<%@ taglib uri="WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<jsp:useBean id="ContactTypeList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="RevenueTypeList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="AccountTypeList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="ContactEmailTypeList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="ContactPhoneTypeList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="ContactAddressTypeList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="DepartmentList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="SourceList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="PriorityList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="SeverityList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<jsp:useBean id="StageList" class="com.darkhorseventures.webutils.LookupList" scope="request"/>
<a href="/Admin.do">Setup</a> >
<a href="/Admin.do?command=Config">System Configuration</a> >
Lookup Lists<br> 
&nbsp;<br>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan="3">
      <strong>Contacts and Resources</strong>
    </td>
  </tr>
  <tr>
    <dhv:permission name="admin-sysconfig-lists-edit"><td width=2><a href="/Admin.do?command=ModifyList&listId=1">Edit</a></td></dhv:permission>
    <td width=50%>Contact Type</td>
    <td width=50%><%=ContactTypeList.getHtmlSelect("typeId",0)%></td>
  </tr>

  <tr>
    <dhv:permission name="admin-sysconfig-lists-edit"><td width=2><a href="/Admin.do?command=ModifyList&listId=7">Edit</a></td></dhv:permission>
    <td width=50%>Contact Email Type</td>
    <td width=50%><%= ContactEmailTypeList.getHtmlSelect("contactEmailTypes",0) %></td>
  </tr>
  <tr>
    <dhv:permission name="admin-sysconfig-lists-edit"><td width=2><a href="/Admin.do?command=ModifyList&listId=9">Edit</a></td></dhv:permission>
    <td width=50%>Contact Address Type</td>
    <td width=50%><%= ContactAddressTypeList.getHtmlSelect("contactAddressTypes",0) %></td>
  </tr>
  <tr>
    <dhv:permission name="admin-sysconfig-lists-edit"><td width=2><a href="/Admin.do?command=ModifyList&listId=8">Edit</a></td></dhv:permission>
    <td width=50%>Contact Phone Type</td>
    <td width=50%><%= ContactPhoneTypeList.getHtmlSelect("contactPhoneTypes",0) %></td>
  </tr>
  <tr>
    <dhv:permission name="admin-sysconfig-lists-edit"><td width=2><a href="/Admin.do?command=ModifyList&listId=3">Edit</a></td></dhv:permission>
    <td width=50%>Department</td>
    <td width=50%><%= DepartmentList.getHtmlSelect("department",0) %></td>
  </tr>
</table>
&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan="3">
      <strong>Account Management</strong>
    </td>
  </tr>
  <tr>
    <dhv:permission name="admin-sysconfig-lists-edit"><td width=2><a href="/Admin.do?command=ModifyList&listId=2">Edit</a></td></dhv:permission>
    <td width=50%>Account Type</td>
    <td width=50%><%=AccountTypeList.getHtmlSelect("typeId",0)%></td>
  </tr>
  <tr>
    <dhv:permission name="admin-sysconfig-lists-edit"><td width=2><a href="/Admin.do?command=ModifyList&listId=11">Edit</a></td></dhv:permission>
    <td width=50%>Revenue Type</td>
    <td width=50%><%=RevenueTypeList.getHtmlSelect("typeId",0)%></td>
  </tr>
</table>
&nbsp;

<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan="3">
      <strong>Opportunities/Leads</strong>
    </td>
  </tr>
  <tr>
    <dhv:permission name="admin-sysconfig-lists-edit"><td width=2><a href="/Admin.do?command=ModifyList&listId=10">Edit</a></td></dhv:permission>
    <td width=50%>Stage</td>
    <td width=50%><%= StageList.getHtmlSelect("stage",0) %></td>
  </tr>
</table>
&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr class="title">
    <td colspan="3">
      <strong>Tickets</strong>
    </td>
  </tr>
  <tr>
    <dhv:permission name="admin-sysconfig-lists-edit"><td width=2><a href="/Admin.do?command=ModifyList&listId=4">Edit</a></td></dhv:permission>
    <td width=50%>Ticket Source</td>
    <td width=50%><%= SourceList.getHtmlSelect("sourceCode",0) %></td>
  </tr>
  <tr>
    <dhv:permission name="admin-sysconfig-lists-edit"><td width=2><a href="/Admin.do?command=ModifyList&listId=5">Edit</a></td></dhv:permission>
    <td width=50%>Ticket Severity</td>
    <td width=50%><%= SeverityList.getHtmlSelect("severityCode",0) %></td>
  </tr>
  <tr>
    <dhv:permission name="admin-sysconfig-lists-edit"><td width=2><a href="/Admin.do?command=ModifyList&listId=6">Edit</a></td></dhv:permission>
    <td width=50%>Ticket Priority</td>
    <td width=50%><%= PriorityList.getHtmlSelect("priorityCode",0) %></td>
  </tr>
</table>
