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

  @author     Matt Rajkowski
  @created    March 10, 2003
  @version    $Id$
  
  Description: An include that configures CSS for all pages, whether
  the user is logged in or not, depending on browser, version, and os.
--%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="org.aspcfs.modules.login.beans.UserBean" %>
<%@ page import="org.aspcfs.utils.web.ClientType" %>
<jsp:useBean id="User" class="org.aspcfs.modules.login.beans.UserBean" scope="session"/>
<jsp:useBean id="applicationPrefs" class="org.aspcfs.controller.ApplicationPrefs" scope="application"/>
<%
  if (User.getClientType() == null) {
    ClientType clientType = new ClientType(request);
    User.setClientType(clientType);
  }
  //Based on Red Hat releases, RH9 Mozilla 1.2.1 was the first to use XFT
  if ("moz".equals(User.getBrowserId()) &&
      ("linux".equals(User.getClientType().getOsString()) && 
       User.getBrowserVersion() < 1.2 )) {
%>
<link rel="stylesheet" href="css/<%= applicationPrefs.get("LAYOUT.TEMPLATE") %>-10pt.css" type="text/css" media="screen">
<%
  } else {
%>
<link rel="stylesheet" href="css/<%= applicationPrefs.get("LAYOUT.TEMPLATE") %>-8pt.css" type="text/css" media="screen">
<%  
  }
%>
<link rel="stylesheet" href="css/<%= applicationPrefs.get("LAYOUT.TEMPLATE") %>.css" type="text/css">
<link rel="stylesheet" href="css/print.css" type="text/css" media="print">
