package com.darkhorseventures.apps.dataimport;

import java.sql.*;
import java.util.*;
import java.util.logging.*;
import com.darkhorseventures.utils.*;
import com.darkhorseventures.cfsbase.*;
import com.darkhorseventures.cfsmodule.*;
import com.zeroio.iteam.base.*;

/**
 *  Description of the Class
 *
 *@author     matt rajkowski
 *@created    September 3, 2002
 *@version    $Id$
 */
public class CFSDatabaseReader implements DataReader {

  private String driver = null;
  private String url = null;
  private String user = null;
  private String password = null;


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
    return "Reads data from ASPCFS version 2.x";
  }


  /**
   *  Gets the configured attribute of the CFSDatabaseReader object
   *
   *@return    The configured value
   */
  public boolean isConfigured() {
    //Check initial settings
    if (driver == null || url == null || user == null || password == null) {
      return false;
    }

    //TODO:Read in modules and mappings to process

    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  writer  Description of the Parameter
   *@return         Description of the Return Value
   */
  public boolean execute(DataWriter writer) {
    //TODO:Connect to database
    ConnectionPool sqlDriver = null;
    Connection db = null;
    try {
      sqlDriver = new ConnectionPool();
      sqlDriver.setForceClose(false);
      sqlDriver.setMaxConnections(2);
      ConnectionElement thisElement = new ConnectionElement(
          "jdbc:postgresql://127.0.0.1:5432/cdb_dhv", "postgres", "");
      thisElement.setDriver("org.postgresql.Driver");
      db = sqlDriver.getConnection(thisElement);
    } catch (SQLException e) {
      logger.info("Could not get database connection" + e.toString());
      return false;
    }

    try {
      //TODO: Process all lookup lists

      //TODO: Loop through created items until complete, in the following order
      User baseUser = new User(db, "0");
      //Get all accounts user entered
      //Get all contacts user entered
      //Get all users user entered

      //Afterwards... update all owners

      HashMap test = new HashMap();

      if (!writer.save(test)) {
        return false;
      }
    } catch (SQLException sqe) {
      logger.info(sqe.toString());
    } finally {
      sqlDriver.free(db);
      sqlDriver.destroy();
      sqlDriver = null;
    }

    return true;
  }
}

