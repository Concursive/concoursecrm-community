/*
 *  Copyright(c) 2004 Concursive Corporation (http://www.concursive.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Concursive Corporation. Permission to use, copy, and modify
 *  this material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. CONCURSIVE
 *  CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL CONCURSIVE CORPORATION OR ANY OF ITS AFFILIATES BE LIABLE FOR
 *  ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package org.aspcfs.modules.help.base;

import org.aspcfs.modules.base.Constants;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.web.PagedListInfo;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

/**
 * Represents a list of Help Notes for a page
 *
 * @author akhi_m
 * @version $id:exp$
 * @created July 9, 2003
 */
public class HelpNoteList extends ArrayList {
  public final static String tableName = "help_notes";
  public final static String uniqueField = "note_id";
  private java.sql.Timestamp lastAnchor = null;
  private java.sql.Timestamp nextAnchor = null;
  private int syncType = Constants.NO_SYNC;

  private PagedListInfo pagedListInfo = null;
  private int linkHelpId = -1;
  private boolean completeOnly = false;
  private int enteredBy = -1;
  private boolean incompleteOnly = false;
  private boolean ignoreDone = false;
  private boolean enabledOnly = false;

  /**
   * Sets the lastAnchor attribute of the HelpNoteList object
   *
   * @param tmp The new lastAnchor value
   */
  public void setLastAnchor(java.sql.Timestamp tmp) {
    this.lastAnchor = tmp;
  }


  /**
   * Sets the lastAnchor attribute of the HelpNoteList object
   *
   * @param tmp The new lastAnchor value
   */
  public void setLastAnchor(String tmp) {
    this.lastAnchor = java.sql.Timestamp.valueOf(tmp);
  }


  /**
   * Sets the nextAnchor attribute of the HelpNoteList object
   *
   * @param tmp The new nextAnchor value
   */
  public void setNextAnchor(java.sql.Timestamp tmp) {
    this.nextAnchor = tmp;
  }


  /**
   * Sets the nextAnchor attribute of the HelpNoteList object
   *
   * @param tmp The new nextAnchor value
   */
  public void setNextAnchor(String tmp) {
    this.nextAnchor = java.sql.Timestamp.valueOf(tmp);
  }


  /**
   * Sets the syncType attribute of the HelpNoteList object
   *
   * @param tmp The new syncType value
   */
  public void setSyncType(int tmp) {
    this.syncType = tmp;
  }


  /**
   * Gets the tableName attribute of the HelpNoteList object
   *
   * @return The tableName value
   */
  public String getTableName() {
    return tableName;
  }


  /**
   * Gets the uniqueField attribute of the HelpNoteList object
   *
   * @return The uniqueField value
   */
  public String getUniqueField() {
    return uniqueField;
  }


  /**
   * Sets the pagedListInfo attribute of the HelpNoteList object
   *
   * @param pagedListInfo The new pagedListInfo value
   */
  public void setPagedListInfo(PagedListInfo pagedListInfo) {
    this.pagedListInfo = pagedListInfo;
  }


  /**
   * Sets the linkHelpId attribute of the HelpNoteList object
   *
   * @param linkHelpId The new linkHelpId value
   */
  public void setLinkHelpId(int linkHelpId) {
    this.linkHelpId = linkHelpId;
  }


  /**
   * Sets the completeOnly attribute of the HelpNoteList object
   *
   * @param completeOnly The new completeOnly value
   */
  public void setCompleteOnly(boolean completeOnly) {
    this.completeOnly = completeOnly;
  }


  /**
   * Sets the enteredBy attribute of the HelpNoteList object
   *
   * @param enteredBy The new enteredBy value
   */
  public void setEnteredBy(int enteredBy) {
    this.enteredBy = enteredBy;
  }


  /**
   * Gets the enteredBy attribute of the HelpNoteList object
   *
   * @return The enteredBy value
   */
  public int getEnteredBy() {
    return enteredBy;
  }


  /**
   * Sets the ignoreDone attribute of the HelpNoteList object
   *
   * @param tmp The new ignoreDone value
   */
  public void setIgnoreDone(boolean tmp) {
    this.ignoreDone = tmp;
  }


  /**
   * Sets the incompleteOnly attribute of the HelpNoteList object
   *
   * @param tmp The new incompleteOnly value
   */
  public void setIncompleteOnly(boolean tmp) {
    this.incompleteOnly = tmp;
  }


  /**
   * Sets the incompleteOnly attribute of the HelpNoteList object
   *
   * @param tmp The new incompleteOnly value
   */
  public void setIncompleteOnly(String tmp) {
    this.incompleteOnly = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   * Sets the enabledOnly attribute of the HelpNoteList object
   *
   * @param tmp The new enabledOnly value
   */
  public void setEnabledOnly(boolean tmp) {
    this.enabledOnly = tmp;
  }


  /**
   * Sets the enabledOnly attribute of the HelpNoteList object
   *
   * @param tmp The new enabledOnly value
   */
  public void setEnabledOnly(String tmp) {
    this.enabledOnly = DatabaseUtils.parseBoolean(tmp);
  }


  /**
   * Gets the pagedListInfo attribute of the HelpNoteList object
   *
   * @return The pagedListInfo value
   */
  public PagedListInfo getPagedListInfo() {
    return pagedListInfo;
  }


  /**
   * Gets the linkHelpId attribute of the HelpNoteList object
   *
   * @return The linkHelpId value
   */
  public int getLinkHelpId() {
    return linkHelpId;
  }


  /**
   * Gets the completeOnly attribute of the HelpNoteList object
   *
   * @return The completeOnly value
   */
  public boolean getCompleteOnly() {
    return completeOnly;
  }


  /**
   * Gets the ignoreDone attribute of the HelpNoteList object
   *
   * @return The ignoreDone value
   */
  public boolean getIgnoreDone() {
    return ignoreDone;
  }


  /**
   * Gets the incompleteOnly attribute of the HelpNoteList object
   *
   * @return The incompleteOnly value
   */
  public boolean getIncompleteOnly() {
    return incompleteOnly;
  }


  /**
   * Gets the enabledOnly attribute of the HelpNoteList object
   *
   * @return The enabledOnly value
   */
  public boolean getEnabledOnly() {
    return enabledOnly;
  }


  /**
   * Builds the list
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
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
            "FROM help_notes hf " +
            "WHERE hf.note_id > -1 ");
    createFilter(sqlFilter);
    if (pagedListInfo == null) {
      pagedListInfo = new PagedListInfo();
      pagedListInfo.setItemsPerPage(0);
    }

    //Get the total number of records matching filter
    pst = db.prepareStatement(sqlCount.toString() + sqlFilter.toString());
    items = prepareFilter(pst);
    rs = pst.executeQuery();
    if (rs.next()) {
      int maxRecords = rs.getInt("recordcount");
      pagedListInfo.setMaxRecords(maxRecords);
    }
    rs.close();
    pst.close();

    //Determine the offset, based on the filter, for the first record to show
    if (!pagedListInfo.getCurrentLetter().equals("")) {
      pst = db.prepareStatement(
          sqlCount.toString() +
              sqlFilter.toString() +
              "AND hf.description < ? ");
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
    pagedListInfo.setDefaultSort("hf.note_id", null);
    pagedListInfo.appendSqlTail(db, sqlOrder);

    //Need to build a base SQL statement for returning records
    pagedListInfo.appendSqlSelectHead(db, sqlSelect);
    sqlSelect.append(
        "hf.* " +
            "FROM help_notes hf " +
            "WHERE hf.note_id > -1 ");

    pst = db.prepareStatement(
        sqlSelect.toString() + sqlFilter.toString() + sqlOrder.toString());
    items = prepareFilter(pst);
    if (pagedListInfo != null) {
      pagedListInfo.doManualOffset(db, pst);
    }
    rs = pst.executeQuery();
    if (pagedListInfo != null) {
      pagedListInfo.doManualOffset(db, rs);
    }
    while (rs.next()) {
      HelpNote thisNote = new HelpNote(rs);
      this.add(thisNote);
    }
    rs.close();
    pst.close();
  }


  /**
   * Create the filters
   *
   * @param sqlFilter Description of the Parameter
   */
  protected void createFilter(StringBuffer sqlFilter) {
    if (sqlFilter == null) {
      sqlFilter = new StringBuffer();
    }

    if (enteredBy != -1) {
      sqlFilter.append("AND hf.enteredby = ? ");
    }

    if (linkHelpId != -1) {
      sqlFilter.append("AND hf.link_help_id = ? ");
    }

    if (completeOnly) {
      sqlFilter.append("AND hf.completedate IS NOT NULL ");
    }
    if (incompleteOnly) {
      sqlFilter.append("AND hf.completedate IS NULL ");
    }
    if (ignoreDone) {
      sqlFilter.append("AND hf.description NOT LIKE 'DONE:%' ");
    }
    if (enabledOnly) {
      sqlFilter.append("AND hf.enabled = ? ");
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
   * Sets the filters
   *
   * @param pst Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  protected int prepareFilter(PreparedStatement pst) throws SQLException {
    int i = 0;
    if (enteredBy != -1) {
      pst.setInt(++i, enteredBy);
    }
    if (linkHelpId != -1) {
      pst.setInt(++i, linkHelpId);
    }
    if (enabledOnly) {
      pst.setBoolean(++i, true);
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
}


