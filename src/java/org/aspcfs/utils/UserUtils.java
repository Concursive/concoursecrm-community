/*
 *  Copyright(c) 2004 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
 *  this material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. DARK HORSE
 *  VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
 *  ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package org.aspcfs.utils;

import javax.servlet.http.*;
import javax.servlet.*;
import org.aspcfs.modules.login.beans.UserBean;
import java.util.TimeZone;
import java.util.Locale;

/**
 *  Methods for working with the User object
 *
 *@author     matt rajkowski
 *@created    October 13, 2003
 *@version    $Id$
 */
public class UserUtils {

  /**
   *  Gets the userId attribute of the UserUtils class
   *
   *@param  request  Description of the Parameter
   *@return          The userId value
   */
  public static int getUserId(HttpServletRequest request) {
    return ((UserBean) request.getSession().getAttribute("User")).getUserId();
  }


  /**
   *  Gets the userRangeId attribute of the UserUtils class
   *
   *@param  request  Description of the Parameter
   *@return          The userRangeId value
   */
  public static String getUserIdRange(HttpServletRequest request) {
    return ((UserBean) request.getSession().getAttribute("User")).getIdRange();
  }


  /**
   *  Gets the userRoleType attribute of the UserUtils class
   *
   *@param  request  Description of the Parameter
   *@return          The userRoleType value
   */
  public static int getUserRoleType(HttpServletRequest request) {
    return ((UserBean) request.getSession().getAttribute("User")).getRoleType();
  }


  /**
   *  Gets the userOrganization attribute of the UserUtils class
   *
   *@param  request  Description of the Parameter
   *@return          The userOrganization value
   */
  public static int getUserOrganization(HttpServletRequest request) {
    return ((UserBean) request.getSession().getAttribute("User")).getOrgId();
  }


  /**
   *  Gets the userTimeZone attribute of the UserUtils class
   *
   *@param  request  Description of the Parameter
   *@return          The userTimeZone value
   */
  public static String getUserTimeZone(HttpServletRequest request) {
    return ((UserBean) request.getSession().getAttribute("User")).getTimeZone();
  }


  /**
   *  Gets the userLocale attribute of the UserUtils class
   *
   *@param  request  Description of the Parameter
   *@return          The userLocale value
   */
  public static Locale getUserLocale(HttpServletRequest request) {
    return ((UserBean) request.getSession().getAttribute("User")).getLocale();
  }


  /**
   *  Gets the userCurrency attribute of the UserUtils class
   *
   *@param  request  Description of the Parameter
   *@return          The userCurrency value
   */
  public static String getUserCurrency(HttpServletRequest request) {
    return ((UserBean) request.getSession().getAttribute("User")).getCurrency();
  }
}

