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
package org.aspcfs.modules.base;

import java.util.*;
import java.sql.*;
import java.text.*;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.modules.admin.base.User;
import org.aspcfs.modules.base.*;

/**
 *  Contains the links to CFS components
 *
 *@author     akhi_m
 *@created    May 20, 2003
 *@version    $Id$
 */
public class CFSLinks {
  private int type = -1;
  private int linkItemId = -1;
  //TODO: implement adding multiple params using HashMap
  private HashMap params = null;


  /**
   *  Sets the type attribute of the TaskLink object
   *
   *@param  type  The new type value
   */
  public void setType(int type) {
    this.type = type;
  }


  /**
   *  Sets the linkItemId attribute of the TaskLink object
   *
   *@param  linkItemId  The new linkItemId value
   */
  public void setLinkItemId(int linkItemId) {
    this.linkItemId = linkItemId;
  }


  /**
   *  Gets the hashMap attribute of the TaskLink object
   *
   *@return    The hashMap value
   */
  public HashMap getParams() {
    return params;
  }


  /**
   *  Gets the linkItemId attribute of the TaskLink object
   *
   *@return    The linkItemId value
   */
  public int getLinkItemId() {
    return linkItemId;
  }


  /**
   *  Gets the type attribute of the TaskLink object
   *
   *@return    The type value
   */
  public int getType() {
    return type;
  }


  /**
   *  Gets the link attribute of the TaskLink object
   *
   *@return    The link value
   */
  public String getLink() {
    return getLink("");
  }


  /**
   *  Gets the link of a CFS component
   *
   *@param  tailParams  Description of the Parameter
   *@return             The link value
   */
  public String getLink(String tailParams) {
    String link = null;
    switch (type) {
        case Constants.TICKET_OBJECT:
          link = "TroubleTickets.do?command=Details&id=" + linkItemId +
              ((tailParams != null && !"".equals(tailParams.trim())) ? ("&" + tailParams) : "");
          break;
        default:
          link = "";
          break;
    }
    return link;
  }


  /**
   *  Gets the displayNameFull attribute of the CFSLinks object
   *
   *@return    The displayNameFull value
   */
  public String getDisplayNameFull() {
    String displayName = null;
    switch (type) {
        case Constants.TICKET_OBJECT:
          displayName = "Ticket";
          break;
        default:
          displayName = "";
          break;
    }
    return displayName;
  }


  /**
   *  Gets the link attribute of the CFSLinks class
   *
   *@param  linkItemId  Description of the Parameter
   *@param  type        Description of the Parameter
   *@param  tailParams  Description of the Parameter
   *@return             The link value
   */
  public static String getLink(int linkItemId, int type, String tailParams) {
    String link = null;
    switch (type) {
        case Constants.TICKET_OBJECT:
          link = "TroubleTickets.do?command=Details&id=" + linkItemId +
              ((tailParams != null && !"".equals(tailParams.trim())) ? ("&" + tailParams) : "");
          break;
        default:
          link = "";
          break;
    }
    return link;
  }
}

