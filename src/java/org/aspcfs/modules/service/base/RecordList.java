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
package org.aspcfs.modules.service.base;

import org.aspcfs.utils.XMLUtils;
import org.w3c.dom.Element;

import java.util.ArrayList;
import java.util.Iterator;

/**
 * Maintains a list of records copied from a ResultSet. Used for the XML API.
 *
 * @author matt rajkowski
 * @version $Id$
 * @created May 29, 2002
 */
public class RecordList extends ArrayList {

  private String name = null;
  private int totalRecords = -1;


  /**
   * Constructor for the RecordList object
   *
   * @param tableName Description of Parameter
   */
  public RecordList(String tableName) {
    name = tableName;
  }


  /**
   * Constructor for the RecordList object from the specified recordList node;
   * typically used in constructing a TransactionStatus object
   *
   * @param recordListNode Description of the Parameter
   */
  public RecordList(Element recordListNode) {
    //Attributes that a recordList might have
    this.setName(recordListNode.getAttribute("name"));
    this.setTotalRecords(recordListNode.getAttribute("count"));
    //Process each record in the recordList
    ArrayList recordNodes = XMLUtils.getElements(recordListNode, "record");
    Iterator i = recordNodes.iterator();
    while (i.hasNext()) {
      Element recordElement = (Element) i.next();
      Record thisRecord = new Record(recordElement);
      this.add(thisRecord);
    }
  }


  /**
   * Sets the name attribute of the RecordList object
   *
   * @param tmp The new name value
   */
  public void setName(String tmp) {
    this.name = tmp;
  }


  /**
   * Sets the totalRecords attribute of the RecordList object
   *
   * @param tmp The new totalRecords value
   */
  public void setTotalRecords(int tmp) {
    this.totalRecords = tmp;
  }


  /**
   * Sets the totalRecords attribute of the RecordList object
   *
   * @param tmp The new totalRecords value
   */
  public void setTotalRecords(String tmp) {
    try {
      if (tmp != null) {
        this.totalRecords = Integer.parseInt(tmp);
      }
    } catch (Exception e) {
      this.totalRecords = -1;
    }
  }


  /**
   * Gets the name attribute of the RecordList object
   *
   * @return The name value
   */
  public String getName() {
    return name;
  }


  /**
   * Gets the totalRecords attribute of the RecordList object
   *
   * @return The totalRecords value
   */
  public int getTotalRecords() {
    return totalRecords;
  }

}

