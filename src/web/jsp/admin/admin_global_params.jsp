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
<jsp:useBean id="Timeout" class="java.lang.String" scope="request"/>
<%-- BEGIN DHV CODE ONLY --%>
<jsp:useBean id="APP_TEXT" class="java.lang.String" scope="application"/>
<%-- END DHV CODE ONLY --%>
<jsp:useBean id="countrySelect" class="org.aspcfs.utils.web.CountrySelect" scope="request"/>
<%@ page import="org.aspcfs.utils.web.HtmlSelectTimeZone" %>
<%@ page import="org.aspcfs.utils.web.HtmlSelectLanguage" %>
<%@ page import="org.aspcfs.utils.web.HtmlSelectCurrency" %>
<%@ include file="../initPage.jsp" %>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="Admin.do">Admin</a> >
Configure System
</td>
</tr>
</table>
<%-- End Trails --%>
<% int count = 1; %>
<dhv:permission name="admin-sysconfig-view">
  <table cellpadding="4" cellspacing="0" border="0" width="100%" class="pagedList">
    <tr>
      <th width="8">
        <strong>Action</strong>
      </th>
      <th>
        <strong>Parameter</strong>
      </th>
      <th>
        <strong>Current Value</strong>
      </th>
    </tr>
    <tr class="row<%= (++count % 2 == 0 ? "1":"2") %>">
      <td align="center">
        <a href="AdminConfig.do?command=ModifyTimeout&timeout=<%= Timeout %>">Edit</a>
      </td>
      <td>
         Session Timeout
      </td>
      <td>
         <%= Timeout %> minutes
      </td>
    </tr>
<dhv:evaluate if="<%= getPref(getServletContext(), "WEBSERVER.ASPMODE") == null || !"true".equals(getPref(getServletContext(), "WEBSERVER.ASPMODE")) %>">
    <%-- BEGIN DHV CODE ONLY --%>
    <tr class="row<%= (++count % 2 == 0 ? "1":"2") %>">
      <td align="center">
        <a href="AdminConfig.do?command=Modify&param=LICENSE">Edit</a>
      </td>
      <td>
         License Information and Details
      </td>
      <td>
         <%= toHtml(APP_TEXT) %>
      </td>
    </tr>
    <%-- END DHV CODE ONLY --%>
    <tr class="row<%= (++count % 2 == 0 ? "1":"2") %>">
      <td align="center">
        <a href="AdminConfig.do?command=Modify&param=MAILSERVER">Edit</a>
      </td>
      <td>
         Email Server
      </td>
      <td>
         <%= toHtml(getPref(getServletContext(), "MAILSERVER")) %>
      </td>
    </tr>
    <tr class="row<%= (++count % 2 == 0 ? "1":"2") %>">
      <td align="center">
        <a href="AdminConfig.do?command=Modify&param=EMAILADDRESS">Edit</a>
      </td>
      <td>
         Email Address
      </td>
      <td>
         <%= toHtml(getPref(getServletContext(), "EMAILADDRESS")) %>
      </td>
    </tr>
    <tr class="row<%= (++count % 2 == 0 ? "1":"2") %>">
      <td align="center">
        <a href="AdminConfig.do?command=Modify&param=WEBSERVER.URL">Edit</a>
      </td>
      <td>
         Centric CRM URL
      </td>
      <td>
         <%= toHtml(getPref(getServletContext(), "WEBSERVER.URL")) %>
      </td>
    </tr>
    <tr class="row<%= (++count % 2 == 0 ? "1":"2") %>">
      <td align="center">
        <a href="AdminConfig.do?command=Modify&param=FAXSERVER">Edit</a>
      </td>
      <td>
         Fax Server
      </td>
      <td>
         <%= toHtml(getPref(getServletContext(), "FAXSERVER")) %>
      </td>
    </tr>
    <tr class="row<%= (++count % 2 == 0 ? "1":"2") %>">
      <td align="center">
        <a href="AdminConfig.do?command=Modify&param=SYSTEM.TIMEZONE">Edit</a>
      </td>
      <td>
         Default Time Zone for new users
      </td>
      <td>
         <%= HtmlSelectTimeZone.getSelect("timeZone", getPref(getServletContext(), "SYSTEM.TIMEZONE")).getValueFromId(getPref(getServletContext(), "SYSTEM.TIMEZONE")) %>
      </td>
    </tr>
    <tr class="row<%= (++count % 2 == 0 ? "1":"2") %>">
      <td align="center">
        <a href="AdminConfig.do?command=Modify&param=SYSTEM.CURRENCY">Edit</a>
      </td>
      <td>
         Default currency for system
      </td>
      <td>
         <%= HtmlSelectCurrency.getSelect("currency", getPref(getServletContext(), "SYSTEM.CURRENCY")).getValueFromId(getPref(getServletContext(), "SYSTEM.CURRENCY")) %>
      </td>
    </tr>
    <tr class="row<%= (++count % 2 == 0 ? "1":"2") %>">
      <td align="center">
        <a href="AdminConfig.do?command=Modify&param=SYSTEM.LANGUAGE">Edit</a>
      </td>
      <td>
         Default locale for system
      </td>
      <td>
         <%= HtmlSelectLanguage.getSelect("language", getPref(getServletContext(), "SYSTEM.LANGUAGE")).getValueFromId(getPref(getServletContext(), "SYSTEM.LANGUAGE")) %>
      </td>
    </tr>
    <tr class="row<%= (++count % 2 == 0 ? "1":"2") %>">
      <td align="center">
        <a href="AdminConfig.do?command=Modify&param=SYSTEM.COUNTRY">Edit</a>
      </td>
      <td>
         Default country for system
      </td>
      <td>
         <%= countrySelect.getValueFromId(getPref(getServletContext(), "SYSTEM.COUNTRY")) %>
      </td>
    </tr>
</dhv:evaluate>
  </table>
  &nbsp;
</dhv:permission>
