/*
 *  Copyright 2000-2004 Team Elements. All Rights Reserved.
 *  License: This source code cannot be modified, distributed or used without
 *  written permission from Team Elements. This notice must remain in
 *  place.
 */
package com.zeroio.iteam.base;

import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.web.HtmlSelect;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

/**
 * Contains a collection of news articles
 *
 * @author matt rajkowski
 * @version $Id: NewsArticleCategoryList.java,v 1.1.2.1 2004/08/26 15:54:32
 *          matt Exp $
 * @created June 23, 2003
 */
public class NewsArticleCategoryList extends ArrayList {
  public final static String tableName = "project_news_category";
  public final static String uniqueField = "category_id";
  private java.sql.Timestamp lastAnchor = null;
  private java.sql.Timestamp nextAnchor = null;
  private int syncType = Constants.NO_SYNC;

  private int projectId = -1;
  private int enabled = Constants.UNDEFINED;
  private int includeId = -1;


  /**
   * Constructor for the NewsArticleCategoryList object
   */
  public NewsArticleCategoryList() {
  }

  /**
   * Sets the lastAnchor attribute of the ActionItemList object
   *
   * @param tmp The new lastAnchor value
   */
  public void setLastAnchor(java.sql.Timestamp tmp) {
    this.lastAnchor = tmp;
  }


  /**
   * Sets the lastAnchor attribute of the ActionItemList object
   *
   * @param tmp The new lastAnchor value
   */
  public void setLastAnchor(String tmp) {
    this.lastAnchor = java.sql.Timestamp.valueOf(tmp);
  }


  /**
   * Sets the nextAnchor attribute of the ActionItemList object
   *
   * @param tmp The new nextAnchor value
   */
  public void setNextAnchor(java.sql.Timestamp tmp) {
    this.nextAnchor = tmp;
  }


  /**
   * Sets the nextAnchor attribute of the ActionItemList object
   *
   * @param tmp The new nextAnchor value
   */
  public void setNextAnchor(String tmp) {
    this.nextAnchor = java.sql.Timestamp.valueOf(tmp);
  }


  /**
   * Sets the syncType attribute of the ActionItemList object
   *
   * @param tmp The new syncType value
   */
  public void setSyncType(int tmp) {
    this.syncType = tmp;
  }

  /**
   * Gets the tableName attribute of the ActionItemList object
   *
   * @return The tableName value
   */
  public String getTableName() {
    return tableName;
  }


  /**
   * Gets the uniqueField attribute of the ActionItemList object
   *
   * @return The uniqueField value
   */
  public String getUniqueField() {
    return uniqueField;
  }

  /**
   * Gets the projectId attribute of the NewsArticleCategoryList object
   *
   * @return The projectId value
   */
  public int getProjectId() {
    return projectId;
  }


  /**
   * Sets the projectId attribute of the NewsArticleCategoryList object
   *
   * @param tmp The new projectId value
   */
  public void setProjectId(int tmp) {
    this.projectId = tmp;
  }


  /**
   * Sets the projectId attribute of the NewsArticleCategoryList object
   *
   * @param tmp The new projectId value
   */
  public void setProjectId(String tmp) {
    this.projectId = Integer.parseInt(tmp);
  }


  /**
   * Gets the enabled attribute of the NewsArticleCategoryList object
   *
   * @return The enabled value
   */
  public int getEnabled() {
    return enabled;
  }


  /**
   * Sets the enabled attribute of the NewsArticleCategoryList object
   *
   * @param tmp The new enabled value
   */
  public void setEnabled(int tmp) {
    this.enabled = tmp;
  }


  /**
   * Sets the enabled attribute of the NewsArticleCategoryList object
   *
   * @param tmp The new enabled value
   */
  public void setEnabled(String tmp) {
    this.enabled = Integer.parseInt(tmp);
  }


  /**
   * Gets the includeId attribute of the NewsArticleCategoryList object
   *
   * @return The includeId value
   */
  public int getIncludeId() {
    return includeId;
  }


  /**
   * Sets the includeId attribute of the NewsArticleCategoryList object
   *
   * @param tmp The new includeId value
   */
  public void setIncludeId(int tmp) {
    this.includeId = tmp;
  }


  /**
   * Sets the includeId attribute of the NewsArticleCategoryList object
   *
   * @param tmp The new includeId value
   */
  public void setIncludeId(String tmp) {
    this.includeId = Integer.parseInt(tmp);
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
    //Set the order
    sqlOrder.append("ORDER BY c.project_id, c." + DatabaseUtils.addQuotes(db, "level") + ", c.category_name ");
    createFilter(sqlFilter);
    //Need to build a base SQL statement for returning records
    sqlSelect.append("SELECT ");
    sqlSelect.append(
        "c.* " +
            "FROM project_news_category c " +
            "WHERE c.category_id > -1 ");
    pst = db.prepareStatement(
        sqlSelect.toString() + sqlFilter.toString() + sqlOrder.toString());
    items = prepareFilter(pst);
    rs = pst.executeQuery();
    while (rs.next()) {
      NewsArticleCategory thisCategory = new NewsArticleCategory(rs);
      this.add(thisCategory);
    }
    rs.close();
    pst.close();
  }


  /**
   * Description of the Method
   *
   * @param sqlFilter Description of the Parameter
   */
  protected void createFilter(StringBuffer sqlFilter) {
    if (projectId > 0) {
      sqlFilter.append("AND c.project_id = ? ");
    }
    if (enabled != Constants.UNDEFINED) {
      if (includeId == -1) {
        sqlFilter.append("AND c.enabled = ? ");
      } else {
        sqlFilter.append("AND (c.enabled = ? OR EXISTS (SELECT news_id FROM project_news pn WHERE pn.category_id = ?)) ");
      }
    }
    if (syncType == Constants.SYNC_INSERTS) {
      if (lastAnchor != null) {
        sqlFilter.append("AND o.entered > ? ");
      }
      sqlFilter.append("AND o.entered < ? ");
    }
    if (syncType == Constants.SYNC_UPDATES) {
      sqlFilter.append("AND o.modified > ? ");
      sqlFilter.append("AND o.entered < ? ");
      sqlFilter.append("AND o.modified < ? ");
    }
  }


  /**
   * Description of the Method
   *
   * @param pst Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  protected int prepareFilter(PreparedStatement pst) throws SQLException {
    int i = 0;
    if (projectId > 0) {
      pst.setInt(++i, projectId);
    }
    if (enabled != Constants.UNDEFINED) {
      if (includeId == -1) {
        pst.setBoolean(++i, enabled == Constants.TRUE);
      } else {
        pst.setBoolean(++i, enabled == Constants.TRUE);
        pst.setInt(++i, includeId);
      }
    }
    if (syncType == Constants.SYNC_INSERTS) {
      if (lastAnchor != null) {
        pst.setTimestamp(++i, lastAnchor);
      }
      pst.setTimestamp(++i, nextAnchor);
    }
    if (syncType == Constants.SYNC_UPDATES) {
      pst.setTimestamp(++i, lastAnchor);
      pst.setTimestamp(++i, lastAnchor);
      pst.setTimestamp(++i, nextAnchor);
    }
    return i;
  }


  /**
   * Gets the valueFromId attribute of the NewsArticleCategoryList object
   *
   * @param id Description of the Parameter
   * @return The valueFromId value
   */
  public String getValueFromId(int id) {
    Iterator i = this.iterator();
    while (i.hasNext()) {
      NewsArticleCategory thisCategory = (NewsArticleCategory) i.next();
      if (thisCategory.getId() == id) {
        return thisCategory.getName();
      }
    }
    return null;
  }


  /**
   * Gets the htmlSelect attribute of the NewsArticleCategoryList object
   *
   * @param selectName Description of the Parameter
   * @param selectedId Description of the Parameter
   * @return The htmlSelect value
   */
  public String getHtmlSelect(SystemStatus thisSystem, String selectName, int selectedId) {
    HtmlSelect thisSelect = new HtmlSelect();
    thisSelect.addItem(-1, thisSystem.getLabel("calendar.none.4dashes"));
    Iterator i = this.iterator();
    while (i.hasNext()) {
      NewsArticleCategory thisCategory = (NewsArticleCategory) i.next();
      if (thisCategory.getEnabled() || (!thisCategory.getEnabled() && thisCategory.getId() == selectedId)) {
        thisSelect.addItem(
            thisCategory.getId(),
            thisCategory.getName() + (!thisCategory.getEnabled() && thisCategory.getId() == selectedId ? " (X)" : ""));
      }
    }
    return thisSelect.getHtml(selectName, selectedId);
  }


  /**
   * Gets the htmlSelect attribute of the NewsArticleCategoryList object
   *
   * @return The htmlSelect value
   */
  public HtmlSelect getHtmlSelect() {
    HtmlSelect thisSelect = new HtmlSelect();
    Iterator i = this.iterator();
    while (i.hasNext()) {
      NewsArticleCategory thisCategory = (NewsArticleCategory) i.next();
      thisSelect.addItem(
          thisCategory.getId(),
          thisCategory.getName());
    }
    return thisSelect;
  }


  /**
   * Description of the Method
   *
   * @param db     Description of the Parameter
   * @param params Description of the Parameter
   * @param names  Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void updateValues(Connection db, String[] params, String[] names) throws SQLException {

    // Put into something manageable
    ArrayList arrayList = new ArrayList();
    for (int i = 0; i < params.length; i++) {
      System.out.println("NewsArticleList-> Name: " + names[i]);
      System.out.println("NewsArticleList-> Param: " + params[i]);
      arrayList.add(params[i]);
    }

    // BEGIN TRANSACTION

    // Iterate through this article list
    Iterator items = this.iterator();
    while (items.hasNext()) {
      NewsArticleCategory thisCategory = (NewsArticleCategory) items.next();
      // If item is not in the passed array, then disable the entry
      if (!arrayList.contains(String.valueOf(thisCategory.getId()))) {
        thisCategory.setEnabled(false);
        thisCategory.update(db);
        items.remove();
      }
    }

    // Iterate through the array
    for (int i = 0; i < params.length; i++) {
      if (System.getProperty("DEBUG") != null) {
        System.out.println("NewsArticleList-> Name: " + names[i]);
        System.out.println("NewsArticleList-> Param: " + params[i]);
      }
      if (params[i].startsWith("*")) {
        // TODO: Check to see if a previously disabled entry has the same name,
        // and enable it

        // New item, add it at the correct position
        NewsArticleCategory thisCategory = new NewsArticleCategory();
        thisCategory.setProjectId(projectId);
        thisCategory.setName(names[i]);
        thisCategory.setLevel(i);
        thisCategory.insert(db);
        this.add(thisCategory);
      } else {
        // Existing item, update the name and position
        updateName(db, Integer.parseInt(params[i]), names[i]);
        updateLevel(db, Integer.parseInt(params[i]), i);
      }
    }

    // END TRANSACTION
  }


  /**
   * Description of the Method
   *
   * @param db    Description of the Parameter
   * @param id    Description of the Parameter
   * @param level Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void updateLevel(Connection db, int id, int level) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "UPDATE project_news_category " +
            "SET " + DatabaseUtils.addQuotes(db, "level") + " = ?, " +
            "modified = " + DatabaseUtils.getCurrentTimestamp(db) + " " +
            "WHERE category_id = ? ");
    int i = 0;
    pst.setInt(++i, level);
    pst.setInt(++i, id);
    pst.executeUpdate();
    pst.close();
  }


  /**
   * Description of the Method
   *
   * @param db   Description of the Parameter
   * @param id   Description of the Parameter
   * @param name Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void updateName(Connection db, int id, String name) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "UPDATE project_news_category " +
            "SET category_name = ?, " +
            "modified = " + DatabaseUtils.getCurrentTimestamp(db) + " " +
            "WHERE category_id = ? ");
    int i = 0;
    pst.setString(++i, name);
    pst.setInt(++i, id);
    pst.executeUpdate();
    pst.close();
  }


  /**
   * Description of the Method
   *
   * @param db        Description of the Parameter
   * @param projectId Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public static void delete(Connection db, int projectId) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "DELETE FROM project_news_category " +
            "WHERE project_id = ? ");
    pst.setInt(1, projectId);
    pst.execute();
    pst.close();
  }
}

