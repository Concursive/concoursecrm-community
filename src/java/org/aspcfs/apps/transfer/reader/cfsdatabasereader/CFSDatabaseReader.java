package org.aspcfs.apps.transfer.reader.cfsdatabasereader;

import java.sql.*;
import java.util.*;
import java.io.*;
import java.util.logging.*;
import com.darkhorseventures.database.*;
import org.aspcfs.utils.*;
import org.aspcfs.apps.transfer.DataReader;
import org.aspcfs.apps.transfer.DataWriter;
import org.aspcfs.apps.transfer.reader.cfsdatabasereader.PropertyMapList;
import org.w3c.dom.*;

/**
 *  Reads data by constructing CFS objects from a database connection. This
 *  reader will process objects in a specific order so that data integrity will
 *  be maintained during a copy process.<p>
 *
 *  CFS Objects must have the following:<br>
 *  - A method called: insert(Connection db)<br>
 *  - A constructor like: new Object(Connection db, int id)<br>
 *  - A modified field with a getModified() method<p>
 *
 *  CFS List Objects must have the following fields:<br>
 *  - tableName, uniqueField, lastAnchor, nextAnchor, syncType, pagedListInfo
 *
 *@author     matt rajkowski
 *@created    September 3, 2002
 *@version    $Id: CFSDatabaseReader.java,v 1.3 2002/09/05 14:49:36 mrajkowski
 *      Exp $
 */
public class CFSDatabaseReader implements DataReader {

  private String driver = null;
  private String url = null;
  private String user = null;
  private String password = null;
  private String processConfigFile = "CFSDatabaseReader.xml";
  private ArrayList modules = null;
  private PropertyMapList mappings = null;

  private int count = 0;


  /**
   *  Sets the driver attribute of the CFSDatabaseReader object
   *
   *@param  tmp  The new driver value
   */
  public void setDriver(String tmp) {
    this.driver = tmp;
  }


  /**
   *  Sets the url attribute of the CFSDatabaseReader object
   *
   *@param  tmp  The new url value
   */
  public void setUrl(String tmp) {
    this.url = tmp;
  }


  /**
   *  Sets the user attribute of the CFSDatabaseReader object
   *
   *@param  tmp  The new user value
   */
  public void setUser(String tmp) {
    this.user = tmp;
  }


  /**
   *  Sets the password attribute of the CFSDatabaseReader object
   *
   *@param  tmp  The new password value
   */
  public void setPassword(String tmp) {
    this.password = tmp;
  }


  /**
   *  Sets the processConfigFile attribute of the CFSDatabaseReader object
   *
   *@param  tmp  The new processConfigFile value
   */
  public void setProcessConfigFile(String tmp) {
    this.processConfigFile = tmp;
  }


  /**
   *  Gets the driver attribute of the CFSDatabaseReader object
   *
   *@return    The driver value
   */
  public String getDriver() {
    return driver;
  }


  /**
   *  Gets the url attribute of the CFSDatabaseReader object
   *
   *@return    The url value
   */
  public String getUrl() {
    return url;
  }


  /**
   *  Gets the user attribute of the CFSDatabaseReader object
   *
   *@return    The user value
   */
  public String getUser() {
    return user;
  }


  /**
   *  Gets the password attribute of the CFSDatabaseReader object
   *
   *@return    The password value
   */
  public String getPassword() {
    return password;
  }


  /**
   *  Gets the processConfigFile attribute of the CFSDatabaseReader object
   *
   *@return    The processConfigFile value
   */
  public String getProcessConfigFile() {
    return processConfigFile;
  }


  /**
   *  Gets the version attribute of the CFSDatabaseReader object
   *
   *@return    The version value
   */
  public double getVersion() {
    return 1.0d;
  }


  /**
   *  Gets the name attribute of the CFSDatabaseReader object
   *
   *@return    The name value
   */
  public String getName() {
    return "CFS 2.x Database Reader";
  }


  /**
   *  Gets the description attribute of the CFSDatabaseReader object
   *
   *@return    The description value
   */
  public String getDescription() {
    return "Reads data from an ASPCFS version 2.x database";
  }


  /**
   *  Gets the configured attribute of the CFSDatabaseReader object
   *
   *@return    The configured value
   */
  public boolean isConfigured() {
    //Check initial settings
    if (driver == null || url == null || user == null) {
      return false;
    }
    modules = new ArrayList();
    try {
      mappings = new PropertyMapList(processConfigFile, modules);
    } catch (Exception e) {
      logger.info(e.toString());
      return false;
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  writer  Description of the Parameter
   *@return         Description of the Return Value
   */
  public boolean execute(DataWriter writer) {
    //Connect to database
    ConnectionPool sqlDriver = null;
    Connection db = null;
    ConnectionElement connectionElement = null;
    try {
      sqlDriver = new ConnectionPool();
      sqlDriver.setMaxConnections(1);
      sqlDriver.setDebug(true);
      connectionElement = new ConnectionElement(url, user, password);
      connectionElement.setAllowCloseOnIdle(false);
      connectionElement.setDriver(driver);
      db = sqlDriver.getConnection(connectionElement);
    } catch (SQLException e) {
      logger.info("Could not get database connection" + e.toString());
      return false;
    }

    try {
      //Process the modules
      boolean processOK = true;
      Iterator moduleList = modules.iterator();
      while (moduleList.hasNext() && processOK) {
        String moduleClass = (String) moduleList.next();
        logger.info("Processing: " + moduleClass);
        Object module = Class.forName(moduleClass).newInstance();
        processOK = ((CFSDatabaseReaderImportModule) module).process(writer, db, mappings);
        if (!processOK) {
          logger.info("Module failed: " + moduleClass);
        }
      }
    } catch (Exception ex) {
      ex.printStackTrace(System.out);
      //logger.info(ex.toString());
      //logger.info(writer.getLastResponse());
    } finally {
      sqlDriver.free(db);
      sqlDriver.destroy();
      sqlDriver = null;
    }

    return true;
  }
}

