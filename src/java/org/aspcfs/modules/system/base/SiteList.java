//Copyright 2003 Dark Horse Ventures
package org.aspcfs.modules.system.base;

import java.util.ArrayList;
import java.util.Iterator;
import java.sql.*;
import org.aspcfs.utils.*;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.utils.web.PagedListInfo;

/**
 *  Builds a list of gatekeeper Site objects
 *
 *@author     matt rajkowski
 *@created    May 13, 2003
 *@version    $Id$
 */
public class SiteList extends ArrayList {

  private PagedListInfo pagedListInfo = null;
  private int enabled = Constants.UNDEFINED;
  private String siteCode = null;
  private String virtualHost = null;


  /**
   *  Constructor for the SiteList object
   */
  public SiteList() { }


  /**
   *  Sets the pagedListInfo attribute of the SiteList object
   *
   *@param  tmp  The new pagedListInfo value
   */
  public void setPagedListInfo(PagedListInfo tmp) {
    this.pagedListInfo = tmp;
  }


  /**
   *  Gets the pagedListInfo attribute of the SiteList object
   *
   *@return    The pagedListInfo value
   */
  public PagedListInfo getPagedListInfo() {
    return pagedListInfo;
  }


  /**
   *  Sets the enabled attribute of the SiteList object
   *
   *@param  tmp  The new enabled value
   */
  public void setEnabled(int tmp) {
    this.enabled = tmp;
  }


  /**
   *  Sets the enabled attribute of the SiteList object
   *
   *@param  tmp  The new enabled value
   */
  public void setEnabled(String tmp) {
    this.enabled = Integer.parseInt(tmp);
  }


  /**
   *  Gets the enabled attribute of the SiteList object
   *
   *@return    The enabled value
   */
  public int getEnabled() {
    return enabled;
  }


  /**
   *  Sets the siteCode attribute of the SiteList object
   *
   *@param  tmp  The new siteCode value
   */
  public void setSiteCode(String tmp) {
    this.siteCode = tmp;
  }


  /**
   *  Gets the siteCode attribute of the SiteList object
   *
   *@return    The siteCode value
   */
  public String getSiteCode() {
    return siteCode;
  }


  /**
   *  Sets the virtualHost attribute of the SiteList object
   *
   *@param  tmp  The new virtualHost value
   */
  public void setVirtualHost(String tmp) {
    this.virtualHost = tmp;
  }


  /**
   *  Gets the virtualHost attribute of the SiteList object
   *
   *@return    The virtualHost value
   */
  public String getVirtualHost() {
    return virtualHost;
  }


  /**
   *  Builds a list of sites based on the specified parameters, requires a
   *  Gatekeeper Connection
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void buildList(Connection db) throws SQLException {
    PreparedStatement pst = null;
    ResultSet rs = null;
    int items = -1;
    StringBuffer sqlSelect = new StringBuffer();
    StringBuffer sqlCount = new StringBuffer();
    StringBuffer sqlFilter = new StringBuffer();
    StringBuffer sqlOrder = new StringBuffer();
    //Need to build a base SQL statement for counting records
    sqlCount.append(
        "SELECT COUNT(*) AS recordcount " +
        "FROM sites s " +
        "WHERE s.site_id > -1 ");
    createFilter(sqlFilter);
    if (pagedListInfo != null) {
      //Get the total number of records matching filter
      pst = db.prepareStatement(sqlCount.toString() +
          sqlFilter.toString());
      items = prepareFilter(pst);
      rs = pst.executeQuery();
      if (rs.next()) {
        int maxRecords = rs.getInt("recordcount");
        pagedListInfo.setMaxRecords(maxRecords);
      }
      rs.close();
      pst.close();
      //Determine column to sort by
      pagedListInfo.setDefaultSort("site_id", null);
      pagedListInfo.appendSqlTail(db, sqlOrder);
    } else {
      sqlOrder.append("ORDER BY site_id ");
    }
    //Need to build a base SQL statement for returning records
    sqlSelect.append(
        "SELECT * " +
        "FROM sites s " +
        "WHERE s.site_id > -1 ");
    pst = db.prepareStatement(sqlSelect.toString() + sqlFilter.toString() + sqlOrder.toString());
    items = prepareFilter(pst);
    rs = pst.executeQuery();
    if (pagedListInfo != null) {
      pagedListInfo.doManualOffset(db, rs);
    }
    int count = 0;
    while (rs.next()) {
      if (pagedListInfo != null && pagedListInfo.getItemsPerPage() > 0 &&
          DatabaseUtils.getType(db) == DatabaseUtils.MSSQL &&
          count >= pagedListInfo.getItemsPerPage()) {
        break;
      }
      ++count;
      Site thisSite = new Site(rs);
      this.add(thisSite);
    }
    rs.close();
    pst.close();
  }


  /**
   *  Description of the Method
   *
   *@param  sqlFilter  Description of the Parameter
   */
  private void createFilter(StringBuffer sqlFilter) {
    if (sqlFilter == null) {
      sqlFilter = new StringBuffer();
    }
    if (enabled != Constants.UNDEFINED) {
      sqlFilter.append("AND enabled = ? ");
    }
    if (siteCode != null) {
      sqlFilter.append("AND sitecode = ? ");
    }
    if (virtualHost != null) {
      sqlFilter.append("AND vhost = ? ");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  pst               Description of the Parameter
   *@return                   Description of the Return Value
   *@exception  SQLException  Description of the Exception
   */
  private int prepareFilter(PreparedStatement pst) throws SQLException {
    int i = 0;
    if (enabled != Constants.UNDEFINED) {
      pst.setBoolean(++i, enabled == Constants.TRUE);
    }
    if (siteCode != null) {
      pst.setString(++i, siteCode);
    }
    if (virtualHost != null) {
      pst.setString(++i, virtualHost);
    }
    return i;
  }

}

