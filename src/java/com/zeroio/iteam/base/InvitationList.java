/*
 *  Copyright 2000-2004 Matt Rajkowski
 *  matt.rajkowski@teamelements.com
 *  http://www.teamelements.com
 *  This source code cannot be modified, distributed or used without
 *  permission from Matt Rajkowski
 */
package com.zeroio.iteam.base;

import java.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import com.darkhorseventures.framework.actions.*;
import org.aspcfs.utils.DatabaseUtils;

/**
 *  Represents a list of members of a project
 *
 *@author     matt rajkowski
 *@created    October 27, 2003
 *@version    $Id: InvitationList.java,v 1.1.2.1 2004/03/19 21:00:50 rvasista
 *      Exp $
 */
public class InvitationList extends ArrayList {

  private int projectId = -1;


  /**
   *  Constructor for the InvitationList object
   */
  public InvitationList() { }


  /**
   *  Constructor for the InvitationList object
   *
   *@param  request  Description of the Parameter
   */
  public InvitationList(HttpServletRequest request) {
    int count = 1;
    String data = null;
    while ((data = request.getParameter("count" + count)) != null) {
      if (DatabaseUtils.parseBoolean(request.getParameter("check" + count))) {
        Invitation thisInvitation = new Invitation(request, count);
        this.add(thisInvitation);
      }
      ++count;
    }
  }


  /**
   *  Sets the projectId attribute of the InvitationList object
   *
   *@param  tmp  The new projectId value
   */
  public void setProjectId(int tmp) {
    this.projectId = tmp;
  }


  /**
   *  Sets the projectId attribute of the InvitationList object
   *
   *@param  tmp  The new projectId value
   */
  public void setProjectId(String tmp) {
    this.projectId = Integer.parseInt(tmp);
  }


  /**
   *  Gets the projectId attribute of the InvitationList object
   *
   *@return    The projectId value
   */
  public int getProjectId() {
    return projectId;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  userId            Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public static int queryCount(Connection db, int userId) throws SQLException {
    int count = 0;
    PreparedStatement pst = db.prepareStatement(
        "SELECT count(user_id) AS nocols " +
        "FROM project_team " +
        "WHERE user_id = ? " +
        "AND status = ? ");
    pst.setInt(1, userId);
    pst.setInt(2, TeamMember.STATUS_PENDING);
    ResultSet rs = pst.executeQuery();
    if (rs.next()) {
      count = rs.getInt("nocols");
    }
    rs.close();
    pst.close();
    return count;
  }
}

