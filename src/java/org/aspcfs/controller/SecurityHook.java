package com.darkhorseventures.controller;

import javax.servlet.*;
import javax.servlet.http.*;
import org.theseus.servlets.ControllerHook;
import com.darkhorseventures.cfsbase.*;
import com.darkhorseventures.cfsmodule.*;
import com.darkhorseventures.utils.*;
import java.util.Hashtable;
import java.sql.*;

/**
 *  Every request to the ServletController executes this code.
 *
 *@author     mrajkowski
 *@created    July 9, 2001
 *@version    $Id$
 */
public class SecurityHook implements ControllerHook {

  /**
   *  Checks to see if a User session object exists, if not then the security
   *  check fails.<p>
   *
   *  The security check also compares the date/time of the user's permissions
   *  to the date/time someone changed the user's permissions in the database.
   *
   *@param  request  Description of Parameter
   *@param  servlet  Description of Parameter
   *@return          Description of the Returned Value
   *@since           1.1
   */
  public String securityCheck(Servlet servlet, HttpServletRequest request) {
    UserBean userSession = (UserBean)request.getSession().getAttribute("User");

    // Get the intended action, if going to the login module, then let it proceed
    String s = request.getServletPath();
    int slash = s.lastIndexOf("/");
    s = s.substring(slash + 1);

    if (userSession == null && !s.toUpperCase().startsWith("LOGIN")) {
      LoginBean failedSession = new LoginBean();
      failedSession.setMessage("* Please login, your session has expired");
      request.setAttribute("LoginBean", failedSession);
      return "SecurityCheck";
    } else {
      if (userSession != null) {
        ConnectionElement ce = (ConnectionElement)request.getSession().getAttribute("ConnectionElement");
        SystemStatus systemStatus = (SystemStatus)((Hashtable)servlet.getServletConfig().getServletContext().getAttribute("SystemStatus")).get(ce.getUrl());
        
        if (userSession.getHierarchyCheck().before(systemStatus.getHierarchyCheck())) {
          User updatedUser = systemStatus.getHierarchyList().getUser(userSession.getUserRecord().getId());
          userSession.setUserRecord(updatedUser);
          userSession.setHierarchyCheck(new java.util.Date());
          System.out.println("SecurityHook-> Updating user session with new user record");
        }
        
        if (userSession.getPermissionCheck().before(systemStatus.getPermissionCheck())) {
          Connection db = null;
          try {
            db = ((ConnectionPool)servlet.getServletConfig().getServletContext().getAttribute("ConnectionPool")).getConnection(ce);
            User updatedUser = userSession.getUserRecord();
            updatedUser.setBuildContact(false);
            updatedUser.setBuildPermissions(true);
            updatedUser.setBuildHierarchy(false);
            updatedUser.buildResources(db);
            userSession.setPermissionCheck(new java.util.Date());
            System.out.println("SecurityHook-> Updating user session with new permissions");
          } catch (SQLException e) {
          } finally {
            ((ConnectionPool)servlet.getServletConfig().getServletContext().getAttribute("ConnectionPool")).free(db);
          }
        }
      }
      return null;
    }
  }

}

