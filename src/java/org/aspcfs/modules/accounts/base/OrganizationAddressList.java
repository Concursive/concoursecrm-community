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
package org.aspcfs.modules.accounts.base;

import org.apache.log4j.Logger;
import org.aspcfs.modules.base.AddressList;
import org.aspcfs.modules.base.SyncableList;
import org.aspcfs.utils.DatabaseUtils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.http.HttpServletRequest;

/**
 *  Builds an address list for an organization using a custom query that extends
 *  the fields and methods of a typical AddressList.
 *
 * @author     mrajkowski
 * @version    $Id: OrganizationAddressList.java,v 1.3 2002/09/11 19:22:26 chris
 *      Exp $
 * @created    September 1, 2001
 */
public class OrganizationAddressList extends AddressList implements SyncableList {

  private static Logger log = Logger.getLogger(org.aspcfs.modules.accounts.base.OrganizationAddressList.class);

  public final static String tableName = "organization_address";
  public final static String uniqueField = "address_id";

  /**
   *  Constructor for the OrganizationAddressList object
   *
   * @since    1.1
   */
  public OrganizationAddressList() { }

  /* (non-Javadoc)
   * @see org.aspcfs.modules.base.SyncableList#getTableName()
   */
  public String getTableName() {
    return tableName;
  }

  /* (non-Javadoc)
   * @see org.aspcfs.modules.base.SyncableList#getUniqueField()
   */
  public String getUniqueField() {
    return uniqueField;
  }

  /**
   *  Constructor for the OrganizationAddressList object
   *
   * @param  request  Description of the Parameter
   */
  public OrganizationAddressList(HttpServletRequest request) {
    int i = 0;
    int primaryAddress = -1;
    if (request.getParameter("primaryAddress") != null) {
      primaryAddress = Integer.parseInt(
          (String) request.getParameter("primaryAddress"));
    }
    while (request.getParameter("address" + (++i) + "type") != null) {
      OrganizationAddress thisAddress = new OrganizationAddress();
      thisAddress.buildRecord(request, i);
      if (primaryAddress == i) {
        thisAddress.setPrimaryAddress(true);
      }
      if (thisAddress.isValid()) {
        this.addElement(thisAddress);
      }
    }
  }

  /**
   *  Description of the Method
   *
   * @param  db                Description of the Parameter
   * @param  pst               Description of the Parameter
   * @exception  SQLException  Description of the Exception
   */
  public ResultSet queryList(Connection db, PreparedStatement pst) throws SQLException {
    ResultSet rs = null;
    int items = -1;

    StringBuffer sqlSelect = new StringBuffer();
    StringBuffer sqlCount = new StringBuffer();
    StringBuffer sqlFilter = new StringBuffer();
    StringBuffer sqlOrder = new StringBuffer();

    //Need to build a base SQL statement for returning records
    sqlSelect.append(
        "SELECT " +
        "a.address_id, a.org_id, a.address_type, a.addrline1, a.addrline2, a.addrline3, " +
        "a.city, a.state, a.country, a.postalcode, a.entered, a.enteredby, a.modified, a.modifiedby, " +
        "a.primary_address, a.addrline4, a.county, a.latitude, a.longitude, " +
        "l.code, l.description, l.default_item, l." + DatabaseUtils.addQuotes(db, "level") + ", l.enabled " +
        "FROM organization_address a, lookup_orgaddress_types l " +
        "WHERE a.address_type = l.code ");
    //Need to build a base SQL statement for counting records
    sqlCount.append(
        "SELECT COUNT(*) AS recordcount " +
        "FROM organization_address a, lookup_orgaddress_types l " +
        "WHERE a.address_type = l.code ");

    createFilter(sqlFilter);

    if (pagedListInfo != null) {
      //Get the total number of records matching filter
      pst = db.prepareStatement(
          sqlCount.toString() +
          sqlFilter.toString());
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
            "AND " + DatabaseUtils.toLowerCase(db) + "(city) < ? ");
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
      if (pagedListInfo.getColumnToSortBy() != null && !pagedListInfo.getColumnToSortBy().equals(
          "")) {
        sqlOrder.append(
            "ORDER BY " + pagedListInfo.getColumnToSortBy() + ", city ");
        if (pagedListInfo.getSortOrder() != null && !pagedListInfo.getSortOrder().equals(
            "")) {
          sqlOrder.append(pagedListInfo.getSortOrder() + " ");
        }
      } else {
        sqlOrder.append("ORDER BY city ");
      }

      //Determine items per page
      if (pagedListInfo.getItemsPerPage() > 0) {
        sqlOrder.append("LIMIT " + pagedListInfo.getItemsPerPage() + " ");
      }

      sqlOrder.append("OFFSET " + pagedListInfo.getCurrentOffset() + " ");
    }

    pst = db.prepareStatement(
        sqlSelect.toString() + sqlFilter.toString() + sqlOrder.toString());
    items = prepareFilter(pst);
    rs = DatabaseUtils.executeQuery(db, pst);

    return rs;
  }


  /**
   *  Builds a list of addresses based on several parameters. The parameters are
   *  set after this object is constructed, then the buildList method is called
   *  to generate the list.
   *
   * @param  db             Description of Parameter
   * @throws  SQLException  Description of Exception
   * @since                 1.1
   */
  public void buildList(Connection db) throws SQLException {
    ResultSet rs = queryList(db, null);
    while (rs.next()) {
      OrganizationAddress thisAddress = this.getObject(rs);
      this.addElement(thisAddress);
    }
    rs.close();
  }


  /**
   *  Gets the object attribute of the OrganizationAddressList object
   *
   * @param  rs                Description of the Parameter
   * @return                   The object value
   * @exception  SQLException  Description of the Exception
   */
  public OrganizationAddress getObject(ResultSet rs) throws SQLException {
    OrganizationAddress thisAddress = new OrganizationAddress(rs);
    return thisAddress;
  }


  /**
   *  Description of the Method
   *
   * @param  db                Description of the Parameter
   * @exception  SQLException  Description of the Exception
   */
  public void select(Connection db) throws SQLException {
    buildList(db);
  }
}

