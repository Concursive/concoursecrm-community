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
package org.aspcfs.apps.transfer.writer.cfsdatabasewriter;

import org.apache.log4j.Logger;
import org.aspcfs.apps.transfer.DataRecord;
import org.aspcfs.apps.transfer.DataWriter;
import org.aspcfs.modules.login.base.AuthenticationItem;
import org.aspcfs.modules.service.base.PacketContext;
import org.aspcfs.modules.service.base.SyncClientManager;
import org.aspcfs.modules.service.base.SyncTableList;
import org.aspcfs.modules.service.base.Transaction;
import org.aspcfs.modules.service.sync.base.SyncPackage;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.HashMap;

/**
 *  Writes data into a Centric database. It uses Centric's Transaction API to
 *  store data into a db. Centric Offline application loads this class to
 *  perform as a Sync Writer. When writing sync records to the database the
 *  writer can be configured to disable storing of client mapping information
 *
 * @author     Ananth
 * @created    November 2, 2006
 */
public class CFSXMLDatabaseWriter implements DataWriter {

  private final static Logger logger = Logger.getLogger(org.aspcfs.apps.transfer.writer.cfsdatabasewriter.CFSXMLDatabaseWriter.class);

  private String lastResponse = null;
  private Connection connection = null;
  private Connection connectionLookup = null;
  private int clientId = -1;
  private int recipient = SyncPackage.SYNC_CLIENT;

  private PacketContext packetContext = new PacketContext();


  /**
   *  Gets the recipient attribute of the CFSXMLDatabaseWriter object
   *
   * @return    The recipient value
   */
  public int getRecipient() {
    return recipient;
  }


  /**
   *  Sets the recipient attribute of the CFSXMLDatabaseWriter object
   *
   * @param  tmp  The new recipient value
   */
  public void setRecipient(int tmp) {
    this.recipient = tmp;
  }


  /**
   *  Sets the recipient attribute of the CFSXMLDatabaseWriter object
   *
   * @param  tmp  The new recipient value
   */
  public void setRecipient(String tmp) {
    this.recipient = Integer.parseInt(tmp);
  }


  /**
   *  Gets the connectionLookup attribute of the CFSXMLDatabaseWriter object
   *
   * @return    The connectionLookup value
   */
  public Connection getConnectionLookup() {
    return connectionLookup;
  }


  /**
   *  Sets the connectionLookup attribute of the CFSXMLDatabaseWriter object
   *
   * @param  tmp  The new connectionLookup value
   */
  public void setConnectionLookup(Connection tmp) {
    this.connectionLookup = tmp;
  }


  /**
   *  Gets the lastResponse attribute of the CFSXMLDatabaseWriter object
   *
   * @return    The lastResponse value
   */
  public String getLastResponse() {
    return lastResponse;
  }


  /**
   *  Sets the lastResponse attribute of the CFSXMLDatabaseWriter object
   *
   * @param  tmp  The new lastResponse value
   */
  public void setLastResponse(String tmp) {
    this.lastResponse = tmp;
  }


  /**
   *  Gets the connection attribute of the CFSXMLDatabaseWriter object
   *
   * @return    The connection value
   */
  public Connection getConnection() {
    return connection;
  }


  /**
   *  Sets the connection attribute of the CFSXMLDatabaseWriter object
   *
   * @param  tmp  The new connection value
   */
  public void setConnection(Connection tmp) {
    this.connection = tmp;
  }


  /**
   *  Gets the clientId attribute of the CFSXMLDatabaseWriter object
   *
   * @return    The clientId value
   */
  public int getClientId() {
    return clientId;
  }


  /**
   *  Sets the clientId attribute of the CFSXMLDatabaseWriter object
   *
   * @param  tmp  The new clientId value
   */
  public void setClientId(int tmp) {
    this.clientId = tmp;
  }


  /**
   *  Sets the clientId attribute of the CFSXMLDatabaseWriter object
   *
   * @param  tmp  The new clientId value
   */
  public void setClientId(String tmp) {
    this.clientId = Integer.parseInt(tmp);
  }



  /**
   *  Gets the name attribute of the CFSXMLDatabaseWriter object
   *
   * @return    The name value
   */
  public String getName() {
    return "CFS XML Database Writer";
  }


  /**
   *  Gets the description attribute of the CFSXMLDatabaseWriter object
   *
   * @return    The description value
   */
  public String getDescription() {
    return "Writes data records to the database";
  }


  /**
   *  Sets the autoCommit attribute of the CFSXMLDatabaseWriter object
   *
   * @param  flag  The new autoCommit value
   */
  public void setAutoCommit(boolean flag) {
  }


  /**
   *  Gets the configured attribute of the CFSXMLDatabaseWriter object
   *
   * @return    The configured value
   */
  public boolean isConfigured() {
    //TODO: implement this
    return true;
  }


  /**
   *  Constructor for the getObjectMap object
   *
   * @param  db    Description of the Parameter
   * @param  auth  Description of the Parameter
   * @return       The objectMap value
   */
  private HashMap getObjectMap(Connection db, AuthenticationItem auth) {
    //TODO: should be cached?
    SyncTableList systemObjectMap = new SyncTableList();
    systemObjectMap.setBuildTextFields(false);
    try {
      systemObjectMap.buildList(db);
    } catch (SQLException e) {
      e.printStackTrace(System.out);
    }

    return systemObjectMap.getObjectMapping(auth.getSystemId());
  }


  /**
   *  Description of the Method
   */
  public void initialize() {
    AuthenticationItem auth = new AuthenticationItem();
    auth.setClientId(clientId);
    auth.setSystemId(4);
    //hardcoded

    packetContext.setAuthenticationItem(auth);

    try {
      //Prepare the SyncClientManager
      SyncClientManager clientManager = new SyncClientManager();
      clientManager.addClient(connection, auth.getClientId());
      packetContext.setClientManager(clientManager);
    } catch (SQLException e) {
      e.printStackTrace(System.out);
    }

    //Disable sync client server mapping if the sync reader is preparing a package for the server
    if (recipient == SyncPackage.SYNC_SERVER) {
      packetContext.setDisableSyncMap(true);
    }

    //Prepare the objectMap: The allowable objects that can be processed for the
    //given systemId
    HashMap objectMap = this.getObjectMap(connection, auth);
    packetContext.setObjectMap(objectMap);
  }


  /**
   *  Description of the Method
   *
   * @param  record  Description of the Parameter
   * @return         Description of the Return Value
   */
  public boolean save(DataRecord record) {
    int statusCode = 1;
    String action = record.getAction();
    Transaction transaction = new Transaction();
    transaction.setPacketContext(packetContext);
    transaction.setValidateObject(false);
    transaction.build(record);

    try {
      if (action.startsWith("insert") || action.equals(DataRecord.INSERT)
           || action.equals(DataRecord.UPDATE)) {
        boolean commit = connection.getAutoCommit();
        try {
          if (commit) {
            connection.setAutoCommit(false);
          }
          statusCode =
              transaction.execute(connection, connectionLookup);

          if (commit) {
            connection.commit();
          }
          if (transaction.hasError()) {
            logger.error(transaction.getErrorMessage());
          }
        } catch (SQLException e) {
          e.printStackTrace(System.out);
          if (commit) {
            connection.rollback();
          }
        } finally {
          if (commit) {
            connection.setAutoCommit(true);
          }
        }
      }
    } catch (SQLException sqle) {
      sqle.printStackTrace(System.out);
    }
    return (statusCode == 0);
  }


  /**
   *  Description of the Method
   *
   * @return    Description of the Return Value
   */
  public boolean commit() {
    return true;
  }


  /**
   *  Description of the Method
   *
   * @return    Description of the Return Value
   */
  public boolean rollback() {
    return false;
  }


  /**
   *  Description of the Method
   *
   * @return    Description of the Return Value
   */
  public boolean close() {
    //TODO: implement this
    return true;
  }


  /**
   *  Gets the version attribute of the CFSXMLDatabaseWriter object
   *
   * @return    The version value
   */
  public double getVersion() {
    return 1.0d;
  }


  /**
   *  Description of the Method
   *
   * @param  record  Description of the Parameter
   * @return         Description of the Return Value
   */
  public boolean load(DataRecord record) {
    return false;
  }
}

