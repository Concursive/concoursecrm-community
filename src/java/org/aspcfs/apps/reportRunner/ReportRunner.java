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
package org.aspcfs.apps.reportRunner;

import org.aspcfs.modules.system.base.*;
import java.sql.*;
import java.util.*;
import org.aspcfs.utils.*;
import java.lang.reflect.*;
import org.aspcfs.controller.ApplicationPrefs;

/**
 *  Processes all JasperReport queues, either as a standalone application or as
 *  a jcron task
 *
 *@author     matt rajkowski
 *@created    October 3, 2003
 *@version    $Id: ReportRunner.java,v 1.1.2.1 2003/10/03 20:54:54 mrajkowski
 *      Exp $
 */
public class ReportRunner {

  private HashMap config = new HashMap();
  private ArrayList taskList = new ArrayList();

  public final static String fs = System.getProperty("file.separator");
  public final static String lf = System.getProperty("line.separator");


  /**
   *  Commandline startup
   *
   *@param  args  Description of the Parameter
   */
  public static void main(String args[]) {
    if (args.length == 0) {
      System.out.println("Usage: ReportRunner [config file]");
      System.out.println("ExitValue: 2");
      System.exit(0);
    }
    System.setProperty("DEBUG", "2");
    ReportRunner thisRunner = new ReportRunner();
    thisRunner.execute(args);
    System.exit(0);
  }


  /**
   *  jcrontab startup
   *
   *@param  args  Description of the Parameter
   */
  public static void doTask(String args[]) {
    if (args.length == 0) {
      System.out.println("Usage: ReportRunner [config file]");
      System.out.println("ExitValue: 2");
    } else {
      ReportRunner thisRunner = new ReportRunner();
      thisRunner.execute(args);
      if (System.getProperty("DEBUG") != null) {
        System.out.println("ExitValue: 0");
      }
    }
  }


  /**
   *  process the reports
   *
   *@param  args  Description of the Parameter
   */
  private void execute(String args[]) {
    String filename = args[0];
    taskList.add("org.aspcfs.apps.reportRunner.task.ProcessJasperReports");
    AppUtils.loadConfig(filename, config);
    if (config.containsKey("FILELIBRARY")) {
      String baseName = (String) config.get("GATEKEEPER.URL");
      String dbUser = (String) config.get("GATEKEEPER.USER");
      String dbPass = (String) config.get("GATEKEEPER.PASSWORD");
      Connection db = null;
      try {
        SiteList siteList = SiteUtils.getSiteList(config);
        //Process each site
        if (System.getProperty("DEBUG") != null) {
          System.out.println("ReportRunner-> Processing each site");
        }
        Iterator i = siteList.iterator();
        while (i.hasNext()) {
          Site thisSite = (Site) i.next();
          Class.forName(thisSite.getDatabaseDriver());
          db = DriverManager.getConnection(
              thisSite.getDatabaseUrl(),
              thisSite.getDatabaseUsername(),
              thisSite.getDatabasePassword());
          baseName = thisSite.getSiteCode();
          Iterator classes = taskList.iterator();
          while (classes.hasNext()) {
            try {
              //Construct the object, which executes the task
              Class thisClass = Class.forName((String) classes.next());
              Class[] paramClass = new Class[]{Class.forName("java.sql.Connection"), Site.class, HashMap.class};
              Constructor constructor = thisClass.getConstructor(paramClass);
              Object[] paramObject = new Object[]{db, thisSite, config};
              Object theTask = constructor.newInstance(paramObject);
              theTask = null;
            } catch (Exception e) {
              e.printStackTrace(System.out);
            }
          }
          db.close();
        }
      } catch (Exception exc) {
        exc.printStackTrace(System.out);
        System.err.println("ReportRunner-> BuildReport Error: " + exc.toString());
      } finally {
        if (db != null) {
          try {
            db.close();
            db = null;
          } catch (Exception e) {
          }
        }
      }
    }
  }
}

