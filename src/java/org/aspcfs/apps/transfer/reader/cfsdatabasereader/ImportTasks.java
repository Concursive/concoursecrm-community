/*
 *  Copyright(c) 2006 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
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
package org.aspcfs.apps.transfer.reader.cfsdatabasereader;

import org.aspcfs.apps.transfer.DataWriter;
import org.aspcfs.modules.tasks.base.TaskCategoryList;
import org.aspcfs.modules.tasks.base.TaskList;

import java.sql.Connection;
import java.sql.SQLException;

/**
 * Description of the Class
 *
 * @author Ananth
 * @created September 11, 2006
 */
public class ImportTasks implements CFSDatabaseReaderImportModule {
  DataWriter writer = null;
  PropertyMapList mappings = null;


  /**
   * Description of the Method
   *
   * @param writer   Description of the Parameter
   * @param db       Description of the Parameter
   * @param mappings Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public boolean process(DataWriter writer, Connection db, PropertyMapList mappings) throws SQLException {

    this.writer = writer;
    this.mappings = mappings;
    boolean processOK = true;

    logger.info("ImportTasks-> Inserting TaskCategory records");
    writer.setAutoCommit(false);
    TaskCategoryList taskCategoryList = new TaskCategoryList();
    taskCategoryList.buildList(db);
    mappings.saveList(writer, taskCategoryList, "insert");
    processOK = writer.commit();
    if (!processOK) {
      return false;
    }

    logger.info("ImportTasks-> Inserting Task records");
    writer.setAutoCommit(false);
    TaskList taskList = new TaskList();
    taskList.buildList(db);
    mappings.saveList(writer, taskList, "insert");
    processOK = writer.commit();
    if (!processOK) {
      return false;
    }

    logger.info("ImportTickets-> Inserting Task <--> Contact Links");
    processOK = ImportLookupTables.saveCustomLookupList(
        writer, db, mappings, "taskLinkContact");
    if (!processOK) {
      return false;
    }

    logger.info("ImportTickets-> Inserting Task <--> Ticket Links");
    processOK = ImportLookupTables.saveCustomLookupList(
        writer, db, mappings, "taskLinkTicket");
    if (!processOK) {
      return false;
    }

    logger.info("ImportTickets-> Inserting Task <--> Project Links");
    processOK = ImportLookupTables.saveCustomLookupList(
        writer, db, mappings, "taskLinkProject");
    if (!processOK) {
      return false;
    }

    logger.info("ImportTickets-> Inserting Task Category <--> Project Links");
    processOK = ImportLookupTables.saveCustomLookupList(
        writer, db, mappings, "taskCategoryProject");
    if (!processOK) {
      return false;
    }

    logger.info("ImportTickets-> Inserting Task Category <--> News Links");
    processOK = ImportLookupTables.saveCustomLookupList(
        writer, db, mappings, "taskCategoryLinkNews");
    if (!processOK) {
      return false;
    }

    return true;
  }
}

