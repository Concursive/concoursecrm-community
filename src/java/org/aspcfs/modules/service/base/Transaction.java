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
package org.aspcfs.modules.service.base;

import java.util.*;
import org.w3c.dom.*;
import java.sql.*;
import org.aspcfs.controller.objectHookManager.ObjectHookManager;
import org.aspcfs.utils.XMLUtils;
import org.aspcfs.utils.ObjectUtils;

/**
 *  A Transaction is an array of TransactionItems. When a system requests a
 *  transaction to be performed on an object -- for example, inserting records
 *  -- a Transaction is built from XML.<p>
 *
 *  After the object is built, the transaction items can be executed.
 *
 *@author     matt rajkowski
 *@created    April 10, 2002
 *@version    $Id$
 */
public class Transaction extends ArrayList {

  private int id = -1;
  private StringBuffer errorMessage = new StringBuffer();
  private RecordList recordList = null;
  private TransactionMeta meta = null;
  private PacketContext packetContext = null;


  /**
   *  Constructor for the Transaction object
   */
  public Transaction() { }


  /**
   *  Sets the id attribute of the Transaction object
   *
   *@param  tmp  The new id value
   */
  public void setId(int tmp) {
    id = tmp;
  }


  /**
   *  Sets the id attribute of the Transaction object
   *
   *@param  tmp  The new id value
   */
  public void setId(String tmp) {
    try {
      id = Integer.parseInt(tmp);
    } catch (Exception e) {
      id = -1;
    }
  }


  /**
   *  Sets the packetContext attribute of the Transaction object
   *
   *@param  tmp  The new packetContext value
   */
  public void setPacketContext(PacketContext tmp) {
    packetContext = tmp;
  }


  /**
   *  Gets the id attribute of the Transaction object
   *
   *@return    The id value
   */
  public int getId() {
    return id;
  }


  /**
   *  Gets the errorMessage attribute of the Transaction object
   *
   *@return    The errorMessage value
   */
  public String getErrorMessage() {
    return errorMessage.toString();
  }


  /**
   *  Gets the recordList attribute of the Transaction object
   *
   *@return    The recordList value
   */
  public RecordList getRecordList() {
    return recordList;
  }


  /**
   *  Builds a list of TransactionItems from XML
   *
   *@param  transactionElement  Description of Parameter
   */
  public void build(Element transactionElement) {
    if (transactionElement.hasAttributes()) {
      this.setId(transactionElement.getAttribute("id"));
    }
    ArrayList objectElements = new ArrayList();
    XMLUtils.getAllChildren(transactionElement, objectElements);
    Iterator i = objectElements.iterator();
    while (i.hasNext()) {
      Element objectElement = (Element) i.next();
      TransactionItem thisItem = new TransactionItem(objectElement, packetContext.getObjectMap());
      thisItem.setPacketContext(packetContext);
      if (thisItem.getName().equals("meta")) {
        if (System.getProperty("DEBUG") != null) {
          System.out.println("Transaction-> Meta data found");
        }
        meta = (TransactionMeta) thisItem.getObject();
      } else {
        if (System.getProperty("DEBUG") != null) {
          System.out.println("Transaction-> Adding transaction item");
        }
        this.add(thisItem);
      }
    }
  }


  /**
   *  Adds a feature to the Mapping attribute of the Transaction object
   *
   *@param  key    The feature to be added to the Mapping attribute
   *@param  value  The feature to be added to the Mapping attribute
   */
  public void addMapping(String key, SyncTable value) {
    packetContext.getObjectMap().put(key, value);
  }


  /**
   *  Adds a feature to the Transaction attribute of the Transaction object
   *
   *@param  tmp  The feature to be added to the Transaction attribute
   */
  public void addTransaction(TransactionItem tmp) {
    this.add(tmp);
  }


  /**
   *  Executes all of the TransactionItems in the array
   *
   *@param  db                Description of Parameter
   *@param  dbLookup          Description of the Parameter
   *@return                   Description of the Returned Value
   *@exception  SQLException  Description of Exception
   */
  public int execute(Connection db, Connection dbLookup) throws SQLException {
    Exception exception = null;
    try {
      db.setAutoCommit(false);
      //Create a shared context for items within a transaction
      TransactionContext transactionContext = new TransactionContext();
      //Process the transaction items
      Iterator items = this.iterator();
      while (items.hasNext()) {
        TransactionItem thisItem = (TransactionItem) items.next();
        thisItem.setMeta(meta);
        thisItem.setTransactionContext(transactionContext);
        thisItem.execute(db, dbLookup);
        //If the item generated an error, then add it to the list to show the client
        if (thisItem.hasError()) {
          appendErrorMessage(thisItem.getErrorMessage());
        }
        //If the item generated a record list, then retrieve it so the records can be
        //returned to the client
        if (thisItem.hasRecordList() && recordList == null) {
          recordList = thisItem.getRecordList();
        }
        //If the item allows its key to be shared with other items, then add it
        //to the transactionContext
        if (thisItem.getShareKey()) {
          String keyName = ((SyncTable) packetContext.getObjectMap().get(thisItem.getName())).getKey();
          if (keyName != null) {
            transactionContext.getPropertyMap().put(thisItem.getName() + "." + keyName,
                ObjectUtils.getParam(thisItem.getObject(), keyName));
          }
        }
      }
      db.commit();
    } catch (Exception e) {
      exception = e;
      e.printStackTrace(System.out);
      appendErrorMessage("Transaction failed");
      db.rollback();
    } finally {
      db.setAutoCommit(true);
    }

    if (exception == null && errorMessage.length() == 0) {
      return 0;
    }

    if (exception != null) {
      appendErrorMessage(exception.getMessage());
    }
    return 1;
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Returned Value
   */
  public boolean hasError() {
    return (errorMessage.length() > 0);
  }


  /**
   *  Description of the Method
   *
   *@param  tmp  Description of Parameter
   */
  public void appendErrorMessage(String tmp) {
    if (tmp != null) {
      if (errorMessage.length() > 0) {
        errorMessage.append(System.getProperty("line.separator"));
      }
      errorMessage.append(tmp);
    }
  }
}

