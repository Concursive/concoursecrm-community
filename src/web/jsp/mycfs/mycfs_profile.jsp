<%-- 
  - Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
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
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ taglib uri="/WEB-INF/zeroio-taglib.tld" prefix="zeroio" %>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="MyCFS.do?command=Home">My Home Page</a> > 
Settings
</td>
</tr>
</table>
<%-- End Trails --%>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th>
      <strong>Make a selection</strong>
    </th>
  </tr>
  <dhv:permission name="myhomepage-profile-personal-view">
  <tr>
    <td><a href="MyCFSProfile.do?command=MyCFSProfile">Update my personal information</a></td>
  </tr>
  </dhv:permission>
  <dhv:permission name="myhomepage-profile-settings-view,myhomepage-profile-view">
  <tr>
    <td><a href="MyCFSSettings.do?command=MyCFSSettings">Configure my location</a></td>
  </tr>
  </dhv:permission>
  <dhv:permission name="myhomepage-profile-password-edit">
  <tr>
    <td><a href="MyCFSPassword.do?command=MyCFSPassword">Change my password</a></td>
  </tr>
  </dhv:permission>
</table>
<br>
<%--The time is currently <zeroio:tz timestamp="<%= new java.util.Date() %>"/> --%>

