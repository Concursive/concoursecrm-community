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
package org.aspcfs.apps.transfer.writer.cfsdatabasewriter;

import com.darkhorseventures.database.*;
import org.aspcfs.apps.transfer.*;
import java.util.*;
import java.util.logging.*;
import org.aspcfs.utils.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;
import org.xml.sax.*;
import javax.xml.transform.*;
import javax.xml.transform.dom.*;
import javax.xml.transform.stream.*;
import java.sql.*;

/**
 *  Description of the Class
 *
 *@author     matt rajkowski
 *@created    September 17, 2002
 *@version    $Id: TicketCategoryWriter.java,v 1.7 2003/09/26 19:08:41
 *      mrajkowski Exp $
 */
public class TicketCategoryWriter implements DataWriter {
  private ConnectionPool sqlDriver = null;
  private Connection db = null;
  private int level0Id = -1;
  private int level1Id = -1;
  private int level2Id = -1;
  private int level3Id = -1;
  private int level = 0;

  private String driver = null;
  private String url = null;
  private String user = null;
  private String pass = null;


  /**
   *  Sets the driver attribute of the TicketCategoryWriter object
   *
   *@param  tmp  The new driver value
   */
  public void setDriver(String tmp) {
    this.driver = tmp;
  }


  /**
   *  Sets the url attribute of the TicketCategoryWriter object
   *
   *@param  tmp  The new url value
   */
  public void setUrl(String tmp) {
    this.url = tmp;
  }


  /**
   *  Sets the user attribute of the TicketCategoryWriter object
   *
   *@param  tmp  The new user value
   */
  public void setUser(String tmp) {
    this.user = tmp;
  }


  /**
   *  Sets the pass attribute of the TicketCategoryWriter object
   *
   *@param  tmp  The new pass value
   */
  public void setPass(String tmp) {
    this.pass = tmp;
  }


  /**
   *  Sets the autoCommit attribute of the TicketCategoryWriter object
   *
   *@param  flag  The new autoCommit value
   */
  public void setAutoCommit(boolean flag) {
  }


  /**
   *  Gets the driver attribute of the TicketCategoryWriter object
   *
   *@return    The driver value
   */
  public String getDriver() {
    return driver;
  }


  /**
   *  Gets the url attribute of the TicketCategoryWriter object
   *
   *@return    The url value
   */
  public String getUrl() {
    return url;
  }


  /**
   *  Gets the user attribute of the TicketCategoryWriter object
   *
   *@return    The user value
   */
  public String getUser() {
    return user;
  }


  /**
   *  Gets the pass attribute of the TicketCategoryWriter object
   *
   *@return    The pass value
   */
  public String getPass() {
    return pass;
  }


  /**
   *  Gets the version attribute of the CFSHttpXMLWriter object
   *
   *@return    The version value
   */
  public double getVersion() {
    return 1.0d;
  }


  /**
   *  Gets the name attribute of the CFSHttpXMLWriter object
   *
   *@return    The name value
   */
  public String getName() {
    return "Ticket Category Writer";
  }


  /**
   *  Gets the description attribute of the CFSHttpXMLWriter object
   *
   *@return    The description value
   */
  public String getDescription() {
    return "Inserts data directly into a Dark Horse CRM database";
  }


  /**
   *  Gets the lastResponse attribute of the TicketCategoryWriter object
   *
   *@return    The lastResponse value
   */
  public String getLastResponse() {
    return null;
  }


  /**
   *  Gets the configured attribute of the CFSHttpXMLWriter object
   *
   *@return    The configured value
   */
  public boolean isConfigured() {
    if (url == null) {
      return false;
    }

    //Connect to database
    try {
      sqlDriver = new ConnectionPool();
      sqlDriver.setForceClose(false);
      sqlDriver.setMaxConnections(1);
      ConnectionElement thisElement = new ConnectionElement(
          url, user, pass);
      thisElement.setDriver(driver);
      db = sqlDriver.getConnection(thisElement);
    } catch (SQLException e) {
      logger.info("Could not get database connection" + e.toString());
      return false;
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  record  Description of Parameter
   *@return         Description of the Return Value
   */
  public boolean save(DataRecord record) {
    try {
      PreparedStatement pst = db.prepareStatement(
          "INSERT INTO ticket_category " +
          "(cat_level, parent_cat_code, description, level, enabled) " +
          "VALUES " +
          "(?, ?, ?, ?, ?) ");
      int i = 0;
      int catLevel = Integer.parseInt(record.getValue("catLevel"));
      pst.setInt(++i, catLevel);
      switch (catLevel) {
          case 0:
            pst.setInt(++i, 0);
            break;
          case 1:
            pst.setInt(++i, level0Id);
            break;
          case 2:
            pst.setInt(++i, level1Id);
            break;
          case 3:
            pst.setInt(++i, level2Id);
            break;
          default:
            break;
      }
      pst.setString(++i, record.getValue("description"));
      pst.setInt(++i, level++);
      pst.setBoolean(++i, true);
      pst.execute();
      pst.close();

      int parentId = DatabaseUtils.getCurrVal(db, "ticket_category_id_seq");
      switch (catLevel) {
          case 0:
            level0Id = parentId;
            break;
          case 1:
            level1Id = parentId;
            break;
          case 2:
            level2Id = parentId;
            break;
          case 3:
            level3Id = parentId;
            break;
          default:
            break;
      }

    } catch (Exception ex) {
      logger.info(ex.toString());
      return false;
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Returned Value
   */
  public boolean commit() {
    return true;
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Returned Value
   */
  public boolean rollback() {
    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  record  Description of the Parameter
   *@return         Description of the Return Value
   */
  public boolean load(DataRecord record) {
    return false;
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Return Value
   */
  public boolean close() {
    if (db != null) {
      try {
        db.close();
      } catch (Exception e) {
      }
    }
    return true;
  }
}


