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
package org.aspcfs.apps.reportRunner.task;

import java.sql.*;
import java.util.*;
import org.aspcfs.modules.system.base.Site;
import org.aspcfs.modules.reports.base.*;
import org.aspcfs.utils.JasperReportUtils;
import dori.jasper.engine.*;
import dori.jasper.engine.util.*;
import java.io.File;
import org.aspcfs.utils.DateUtils;

/**
 *  Class to compile and generate to PDF a JasperReport
 *
 *@author     matt rajkowski
 *@created    October 3, 2003
 *@version    $Id: ProcessJasperReports.java,v 1.6 2004/06/29 14:08:22
 *      mrajkowski Exp $
 */
public class ProcessJasperReports {

  public final static String fs = System.getProperty("file.separator");


  /**
   *  Constructor for the ProcessJasperReports object
   *
   *@param  db             Description of the Parameter
   *@param  thisSite       Description of the Parameter
   *@param  config         Description of the Parameter
   *@exception  Exception  Description of the Exception
   */
  public ProcessJasperReports(Connection db, Site thisSite, HashMap config) throws Exception {
    //Load the report queue for this site, unprocessed only
    ReportQueueList queue = new ReportQueueList();
    queue.setSortAscending(true);
    queue.setUnprocessedOnly(true);
    queue.buildList(db);
    //Iterate the list
    Iterator list = queue.iterator();
    while (list.hasNext()) {
      ReportQueue thisQueue = (ReportQueue) list.next();
      if (queue.lockReport(thisQueue, db)) {
        try {
          String reportDir = "";
          if (((String) config.get("FILELIBRARY")).indexOf("WEB-INF") > 0) {
            reportDir = (String) config.get("FILELIBRARY") + ".." + fs + "reports" + fs;
          }
          if (config.containsKey("WEB-INF")) {
            reportDir = (String) config.get("WEB-INF") + "reports" + fs;
          }
          //Load from the repository, save to the user's site
          String destDir =
              (String) config.get("FILELIBRARY") +
              thisSite.getDatabaseName() + fs +
              "reports-queue" + fs +
              DateUtils.getDatePath(thisQueue.getEntered());
          File destPath = new File(destDir);
          destPath.mkdirs();
          String filename = DateUtils.getFilename(thisQueue.getEntered()) + "-" + thisQueue.getId();
          long size = processReport(
              thisQueue,
              db,
              reportDir,
              destDir + filename);
          thisQueue.setFilename(filename);
          thisQueue.setSize(size);
          thisQueue.setStatus(ReportQueue.STATUS_PROCESSED);
        } catch (Exception e) {
          thisQueue.setStatus(ReportQueue.STATUS_ERROR);
          e.printStackTrace(System.out);
        } finally {
          thisQueue.updateStatus(db);
        }
      }
    }
  }


  /**
   *  For the specified report queue, gets the report and performs the
   *  JasperReport to PDF
   *
   *@param  thisQueue      Description of the Parameter
   *@param  db             Description of the Parameter
   *@param  path           Description of the Parameter
   *@param  destFilename   Description of the Parameter
   *@return                Description of the Return Value
   *@exception  Exception  Description of the Exception
   */
  private static long processReport(ReportQueue thisQueue, Connection db, String path, String destFilename) throws Exception {
    Report thisReport = new Report(db, thisQueue.getReportId());
    //Determine the path and load JasperReport
    JasperReport jasperReport = JasperReportUtils.getReport(path + thisReport.getFilename());
    //Populate the criteria
    QueueCriteriaList criteria = new QueueCriteriaList();
    criteria.setQueueId(thisQueue.getId());
    criteria.buildList(db);
    //Export the pdf to fileLibrary for this site
    JasperRunManager.runReportToPdfFile(
        path +
        thisReport.getFilename().substring(0, thisReport.getFilename().lastIndexOf(".xml")) + ".jasper",
        destFilename,
        criteria.getParameters(jasperReport, path), db);
    //Determine the size
    File reportFile = new File(destFilename);
    if (reportFile.exists()) {
      return reportFile.length();
    } else {
      return -1;
    }
  }

}

