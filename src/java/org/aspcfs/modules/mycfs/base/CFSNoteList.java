//Copyright 2001 Dark Horse Ventures
// The createFilter method and the prepareFilter method need to have the same
// number of parameters if modified.

package com.darkhorseventures.cfsbase;

import java.util.Vector;
import java.util.Iterator;
import java.sql.*;
import com.darkhorseventures.webutils.PagedListInfo;
import com.darkhorseventures.webutils.HtmlSelect;


public class CFSNoteList extends Vector {

	private PagedListInfo pagedListInfo = null;
  	private int status = -1;
	private int sentTo = -1;


	public CFSNoteList() { }

	public void setPagedListInfo(PagedListInfo tmp) {
		this.pagedListInfo = tmp;
	}

	public PagedListInfo getPagedListInfo() {
		return pagedListInfo;
	}
	public void setStatus(int status) {
	this.status = status;
}
public int getStatus() {
	return status;
}
public void setSentTo(int sentTo) {
	this.sentTo = sentTo;
}
public int getSentTo() {
	return sentTo;
}

	public void buildList(Connection db) throws SQLException {
		
		PreparedStatement pst = null;
		ResultSet rs = null;
		int items = -1;
		
		StringBuffer sqlSelect = new StringBuffer();
		StringBuffer sqlCount = new StringBuffer();
		StringBuffer sqlFilter = new StringBuffer();
		StringBuffer sqlOrder = new StringBuffer();
		
		sqlSelect.append(
		      "SELECT m.*, ml.*, ct_sent.namefirst as sent_namefirst, ct_sent.namelast as sent_namelast " +
		      "FROM cfsinbox_message m " +
		      "LEFT JOIN contact ct_eb ON (m.enteredby = ct_eb.user_id) " +
		      "LEFT JOIN contact ct_mb ON (m.modifiedby = ct_mb.user_id) " +
		      "LEFT JOIN contact ct_sent ON (m.enteredby = ct_sent.user_id) " +
		      "LEFT JOIN cfsinbox_messagelink ml ON (m.id = ml.id) " +
		      "WHERE m.id > -1 ");
		
		sqlCount.append(
		      "SELECT COUNT(*) AS recordcount " +
		      "FROM cfsinbox_message m " +
		      "WHERE m.id > -1 ");
      
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
						"AND subject < ? ");
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
			pagedListInfo.setColumnToSortBy("subject");
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
		}
		else {
			sqlOrder.append("ORDER BY entered desc ");
		}

		pst = db.prepareStatement(sqlSelect.toString() + sqlFilter.toString() + sqlOrder.toString());
		
		items = prepareFilter(pst);
		System.out.println(pst.toString());
		rs = pst.executeQuery();
		
		while (rs.next()) {
			CFSNote thisNote = new CFSNote(rs);
			this.addElement(thisNote);
		}
		rs.close();
		pst.close();

	
	} // end buildList

	private void createFilter(StringBuffer sqlFilter){
		if (sqlFilter == null) {
			sqlFilter = new StringBuffer();
		}
		
		if (status > -1) {
			sqlFilter.append("AND m.id in (select distinct id from cfsinbox_messagelink where status = ?) ");
		}
		
		if (sentTo > -1) {
			sqlFilter.append("AND m.id in (select distinct id from cfsinbox_messagelink where sent_to = ?) ");
		}
		
	}
	
	private int prepareFilter(PreparedStatement pst) throws SQLException {
		int i = 0;
	
		if (status > -1) {
			pst.setInt(++i, status);
		}
		
		
		if (sentTo > -1) {
			pst.setInt(++i, sentTo);
		}
	
		return i;
	}
}

