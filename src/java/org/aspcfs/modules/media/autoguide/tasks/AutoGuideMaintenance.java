package org.aspcfs.modules.media.autoguide.tasks;

import java.sql.*;
import org.aspcfs.modules.base.Constants;
import org.aspcfs.modules.media.autoguide.base.*;
import java.util.*;
import com.zeroio.iteam.base.*;
import com.isavvix.tools.*;

/**
 *  Deletes old inventory from Auto Guide
 *
 *@author     matt rajkowski
 *@created    February 5, 2003
 *@version    $Id$
 */
public class AutoGuideMaintenance {

  public final static String fs = System.getProperty("file.separator");


  /**
   *  Constructor for the AutoGuideMaintenance object
   *
   *@param  db      Description of the Parameter
   *@param  config  Description of the Parameter
   */
  public AutoGuideMaintenance(Connection db, HashMap siteInfo, HashMap config) {
    try {
      String filePath = (String) config.get("FileLibrary") + fs + (String) siteInfo.get("name") + fs + "autoguide" + fs;
      ArrayList deleteList = new ArrayList();
      //Determine the oldest date
      Calendar dateCheck = Calendar.getInstance();
      dateCheck.add(Calendar.DATE, -30);
      /*
       *  Sold vehicles with last run_date older than 30 days
       */
      PreparedStatement pst = db.prepareStatement(
          "SELECT inventory_id, max(run_date) AS last_date " +
          "FROM autoguide_ad_run " +
          "WHERE inventory_id IN " +
          "(SELECT inventory_id FROM autoguide_inventory WHERE sold = ?) " +
          "GROUP BY inventory_id " +
          "HAVING max(run_date) < ? ");
      pst.setBoolean(1, true);
      pst.setDate(2, new java.sql.Date(dateCheck.getTimeInMillis()));
      ResultSet rs = pst.executeQuery();
      while (rs.next()) {
        Integer id = new Integer(rs.getInt("inventory_id"));
        deleteList.add(id);
      }
      rs.close();
      pst.close();

      System.out.println("AutoGuideMaintenance-> Vehicles to delete: " + deleteList.size());
      
      Iterator i = deleteList.iterator();
      while (i.hasNext()) {
        Inventory thisItem = new Inventory(db, ((Integer) i.next()).intValue());
        //Delete the picture
        FileItemList previousFiles = new FileItemList();
        previousFiles.setLinkModuleId(Constants.AUTOGUIDE);
        previousFiles.setLinkItemId(thisItem.getId());
        previousFiles.buildList(db);
        previousFiles.delete(db, filePath);

        //Delete the record
        thisItem.delete(db);
      }

    } catch (Exception e) {
      e.printStackTrace(System.out);
    }
    if (System.getProperty("DEBUG") != null) {
      System.out.println("AutoGuideMaintenance-> Finished");
    }
  }
}

