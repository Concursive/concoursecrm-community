//Copyright 2001 Dark Horse Ventures

package com.darkhorseventures.cfsbase;

import java.util.Vector;
import java.util.Iterator;
import java.sql.*;
import com.darkhorseventures.webutils.PagedListInfo;
import com.darkhorseventures.webutils.HtmlSelect;
import javax.servlet.*;
import javax.servlet.http.*;

public class RoleList extends Vector {
  
  private PagedListInfo pagedListInfo = null;
  private String emptyHtmlSelectRecord = null;
  
  public RoleList() { }
  
  public void setPagedListInfo(PagedListInfo tmp) {
    this.pagedListInfo = tmp;
  }
  
  public void setEmptyHtmlSelectRecord(String tmp) {
    this.emptyHtmlSelectRecord = tmp;
  }
  
  public String getHtmlSelect(String selectName) {
    return getHtmlSelect(selectName, -1);
  }
  
  public String getHtmlSelect(String selectName, int defaultKey) {
    HtmlSelect roleListSelect = new HtmlSelect();
    if (emptyHtmlSelectRecord != null) {
      roleListSelect.addItem(-1, emptyHtmlSelectRecord);
    }
    Iterator i = this.iterator();
    while (i.hasNext()) {
      Role thisRole = (Role)i.next();
      roleListSelect.addItem(
          thisRole.getId(),
          thisRole.getRole());
    }
    return roleListSelect.getHtml(selectName, defaultKey);
  }
  
  public void buildList(Connection db) throws SQLException {

    PreparedStatement pst = null;
    ResultSet rs = null;
    int items = -1;

    StringBuffer sqlSelect = new StringBuffer();
    StringBuffer sqlCount = new StringBuffer();
    StringBuffer sqlFilter = new StringBuffer();
    StringBuffer sqlOrder = new StringBuffer();

    //Need to build a base SQL statement for returning records
    sqlSelect.append("SELECT * " +
        "FROM role r " +
        "WHERE enabled = true ");

    //Need to build a base SQL statement for counting records
    sqlCount.append("SELECT COUNT(*) AS recordcount " +
        "FROM role r " +
        "WHERE enabled = true ");

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
      pst.close();
      rs.close();

      //Determine the offset, based on the filter, for the first record to show
      if (!pagedListInfo.getCurrentLetter().equals("")) {
        pst = db.prepareStatement(sqlCount.toString() +
            sqlFilter.toString() +
            "AND role < ? ");
        items = prepareFilter(pst);
        pst.setString(++items, pagedListInfo.getCurrentLetter().toLowerCase());
        rs = pst.executeQuery();
        if (rs.next()) {
          int offsetCount = rs.getInt("recordcount");
          pagedListInfo.setCurrentOffset(offsetCount);
        }
        rs.close();
        pst.close();
      }

      //Determine column to sort by
      if (pagedListInfo.getColumnToSortBy() == null || pagedListInfo.getColumnToSortBy().equals("")) {
				pagedListInfo.setColumnToSortBy("role");
			}
			sqlOrder.append("ORDER BY " + pagedListInfo.getColumnToSortBy() + " ");
			if (pagedListInfo.getSortOrder() != null && !pagedListInfo.getSortOrder().equals("")) {
				sqlOrder.append(pagedListInfo.getSortOrder() + " ");
			}

      //Determine items per page
      if (pagedListInfo.getItemsPerPage() > 0) {
        sqlOrder.append("LIMIT " + pagedListInfo.getItemsPerPage() + " ");
      }

      sqlOrder.append("OFFSET " + pagedListInfo.getCurrentOffset() + " ");
    } else {
      sqlOrder.append("ORDER BY role ");
    }

    pst = db.prepareStatement(sqlSelect.toString() + sqlFilter.toString() + sqlOrder.toString());
    items = prepareFilter(pst);
    rs = pst.executeQuery();
    while (rs.next()) {
      Role thisRole = new Role(rs);
      this.addElement(thisRole);
    }
    rs.close();
    pst.close();
    
    Iterator i = this.iterator();
    while (i.hasNext()) {
      Role thisRole = (Role)i.next();
      thisRole.buildUserList(db);
    }

  }
  
  private void createFilter(StringBuffer sqlFilter) {
    if (sqlFilter == null) {
      sqlFilter = new StringBuffer();
    }
  }
  
  private int prepareFilter(PreparedStatement pst) throws SQLException {
    int i = 0;
    return i;
  }
  
}
