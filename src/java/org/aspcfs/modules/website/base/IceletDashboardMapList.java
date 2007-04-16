/*
 *  Copyright(c) 2007 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
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
package org.aspcfs.modules.website.base;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

/**
 * Description of the IceletDashboardMapList
 *
 * @author Artem.Zakolodkin
 * @created Feb 2, 2007
 */
public class IceletDashboardMapList extends ArrayList {

  /**
   * 
   */
  private static final long serialVersionUID = 1L;
  
  private int id = -1;
  private int iceletId = -1;
  private int linkModuleId = -1;
  
  /**
   * @param db
   * @throws SQLException
   */
  public void delete(Connection db) throws SQLException {
      Iterator iceletDashboardMapIterator = this.iterator();
      while (iceletDashboardMapIterator.hasNext()) {
        IceletDashboardMap thisIceletDashboardMap = (IceletDashboardMap) iceletDashboardMapIterator.next();
          thisIceletDashboardMap.delete(db);
      }
      
  }

  public IceletDashboardMap getObject(ResultSet rs) throws SQLException {
    return new IceletDashboardMap(rs);
}

  /**
   * @param db
   * @throws SQLException
   */
  public void buildList(Connection db) throws SQLException {
      PreparedStatement pst = null;
      ResultSet rs = queryList(db, pst);
      while (rs.next()) {
        IceletDashboardMap thisIceletDashboardMap = this.getObject(rs);
          this.add(thisIceletDashboardMap);
      }
      rs.close();
  }

  /**
   * @param db
   * @param pst
   * @return
   * @throws SQLException
   */
  public ResultSet queryList(Connection db, PreparedStatement pst)
          throws SQLException {
      ResultSet rs = null;
      StringBuffer sqlSelect = new StringBuffer();
      StringBuffer sqlFilter = new StringBuffer();
      StringBuffer sqlOrder = new StringBuffer();
      createFilter(sqlFilter, db);
      sqlSelect.append("SELECT widm.* " +
                       "  FROM web_icelet_dashboard_map widm " + 
                       " WHERE dashboard_map_id > -1 ");
      pst = db.prepareStatement(sqlSelect.toString() + sqlFilter.toString()
              + sqlOrder.toString());
      prepareFilter(pst);
      rs = pst.executeQuery();
      return rs;
  }

  /**
   * @param pst
   * @return
   * @throws SQLException
   */
  private int prepareFilter(PreparedStatement pst) throws SQLException {
      int i = 0;
      if (id > - 1) {
          pst.setInt(++i, id);
      }
      if (iceletId > - 1) {
          pst.setInt(++i, iceletId);
      }
      if (linkModuleId > - 1) {
          pst.setInt(++i, linkModuleId);
      }
      return i;
  }

  /**
   * @param sqlFilter
   * @param db
   * @throws SQLException
   */
  private void createFilter(StringBuffer sqlFilter, Connection db) throws SQLException {
      if (id > - 1) {
          sqlFilter.append("AND dashboard_map_id = ? ");
      }
      if (iceletId > - 1) {
          sqlFilter.append("AND icelet_id = ? ");
      }
      if (linkModuleId > - 1) {
          sqlFilter.append("AND link_module_id = ? ");
      }
  }


  /**
   * @return the iceletId
   */
  public int getIceletId() {
    return iceletId;
  }
  /**
   * @param iceletId the iceletId to set
   */
  public void setIceletId(int iceletId) {
    this.iceletId = iceletId;
  }
  /**
   * @return the linkModuleId
   */
  public int getLinkModuleId() {
    return linkModuleId;
  }
  /**
   * @param linkModuleId the linkModuleId to set
   */
  public void setLinkModuleId(int linkModuleId) {
    this.linkModuleId = linkModuleId;
  }
  /**
   * @return the mapId
   */
  public int getId() {
    return id;
  }
  /**
   * @param id the mapId to set
   */
  public void setId(int id) {
    this.id = id;
  }

}
