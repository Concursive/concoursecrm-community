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
package org.aspcfs.modules.admin.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Vector;

/**
 * Description of the Class
 *
 * @author Mathur
 * @version $Id$
 * @created January 13, 2003
 */
public class PermissionList extends Vector {

  private String currentCategory = "!new";
  private boolean viewpointsOnly = false;


  /**
   * Constructor for the PermissionList object
   */
  public PermissionList() {
  }


  /**
   * Constructor for the PermissionList object
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public PermissionList(Connection db) throws SQLException {
    buildList(db);
  }


  /**
   * Sets the viewpointsOnly attribute of the PermissionList object
   *
   * @param viewpointsOnly The new viewpointsOnly value
   */
  public void setViewpointsOnly(boolean viewpointsOnly) {
    this.viewpointsOnly = viewpointsOnly;
  }


  /**
   * Gets the viewpointsOnly attribute of the PermissionList object
   *
   * @return The viewpointsOnly value
   */
  public boolean getViewpointsOnly() {
    return viewpointsOnly;
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void buildList(Connection db) throws SQLException {

    PreparedStatement pst = null;
    ResultSet rs = null;
    int items = -1;

    StringBuffer sqlSelect = new StringBuffer();
    StringBuffer sqlFilter = new StringBuffer();
    StringBuffer sqlOrder = new StringBuffer();

    //Need to build a base SQL statement for returning records
    sqlSelect.append(
        "SELECT p.*, c.category " +
        "FROM permission p, permission_category c " +
        "WHERE p.category_id = c.category_id ");
    createFilter(sqlFilter);
    sqlOrder.append("ORDER BY c.\"level\", c.category, p.\"level\" ");

    pst = db.prepareStatement(
        sqlSelect.toString() + sqlFilter.toString() + sqlOrder.toString());
    items = prepareFilter(pst);
    rs = pst.executeQuery();
    while (rs.next()) {
      Permission thisPermission = new Permission(rs);
      this.addElement(thisPermission);
      thisPermission.setEnabled(true);
    }
    rs.close();
    pst.close();
  }


  /**
   * Description of the Method
   *
   * @param sqlFilter Description of the Parameter
   */
  private void createFilter(StringBuffer sqlFilter) {
    if (sqlFilter == null) {
      sqlFilter = new StringBuffer();
    }
    sqlFilter.append("AND p.enabled = ? ");
    sqlFilter.append("AND c.enabled = ? ");

    if (viewpointsOnly) {
      sqlFilter.append("AND p.viewpoints = ? ");
      sqlFilter.append("AND c.viewpoints = ? ");
    }
  }


  /**
   * Description of the Method
   *
   * @param pst Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  private int prepareFilter(PreparedStatement pst) throws SQLException {
    int i = 0;
    pst.setBoolean(++i, true);
    pst.setBoolean(++i, true);
    if (viewpointsOnly) {
      pst.setBoolean(++i, true);
      pst.setBoolean(++i, true);
    }
    return i;
  }


  /**
   * Gets the newCategory attribute of the PermissionList object
   *
   * @param thisCategory Description of the Parameter
   * @return The newCategory value
   */
  public boolean isNewCategory(String thisCategory) {
    if (thisCategory.equals(currentCategory)) {
      return false;
    } else {
      currentCategory = thisCategory;
      return true;
    }
  }

}

