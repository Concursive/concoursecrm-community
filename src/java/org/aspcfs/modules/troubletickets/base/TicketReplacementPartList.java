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
package org.aspcfs.modules.troubletickets.base;

import java.util.*;
import java.sql.*;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.modules.troubletickets.base.*;
import javax.servlet.*;
import javax.servlet.http.*;

/**
 *  Description of the Class
 *
 *@author     kbhoopal
 *@created    February 11, 2004
 *@version    $Id: TicketReplacementPartList.java,v 1.2 2004/04/01 16:14:05
 *      mrajkowski Exp $
 */
public class TicketReplacementPartList extends ArrayList {

  /**
   *  Constructor for the TicketReplacementPartList object
   */
  public TicketReplacementPartList() { }


  /**
   *  Constructor for the TicketReplacementPartList object
   *
   *@param  request  Description of the Parameter
   */
  public TicketReplacementPartList(HttpServletRequest request) {
    int i = 0;
    while (request.getParameter("partNumber" + (++i)) != null) {
      if (!request.getParameter("partNumber" + (i)).trim().equals("")) {
        TicketReplacementPart thisPart = new TicketReplacementPart();
        thisPart.buildRecord(request, i);
        this.add(thisPart);
      }
    }
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  tmpFormId         Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void queryList(Connection db, int tmpFormId) throws SQLException {
    PreparedStatement pst = null;
    ResultSet rs = null;

    pst = db.prepareStatement(" SELECT *  " +
        " FROM  trouble_asset_replacement " +
        " WHERE link_form_id = ? ");
    pst.setInt(1, tmpFormId);
    if (System.getProperty("DEBUG") != null) {
      System.out.println("TicketReplacementPartList-> before query: " + pst.toString());
    }
    rs = pst.executeQuery();
    if (System.getProperty("DEBUG") != null) {
      System.out.println("TicketReplacementPartList-> resultset");
    }
    while (rs.next()) {
      TicketReplacementPart thisPart = new TicketReplacementPart(rs);
      this.add(thisPart);
    }
    rs.close();
    pst.close();
    if (System.getProperty("DEBUG") != null) {
      System.out.println("TicketReplacementPartList-> rs closed");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  tmpFormId         Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  public boolean deleteList(Connection db, int tmpFormId) throws SQLException {
    PreparedStatement pst = null;
    pst = db.prepareStatement(" DELETE " +
        " FROM  trouble_asset_replacement " +
        " WHERE link_form_id = ? ");

    pst.setInt(1, tmpFormId);
    pst.execute();
    pst.close();

    return true;
  }
}

