package com.darkhorseventures.apps.dataimport.cfsdatabasereader;

import java.sql.*;
import com.darkhorseventures.apps.dataimport.*;
import com.darkhorseventures.cfsbase.*;
import com.zeroio.iteam.base.*;
import java.util.*;

/**
 *  Processes Opportunities
 */
public class ImportOpportunities implements CFSDatabaseReaderImportModule {
  
  DataWriter writer = null;
  PropertyMapList mappings = null;
  
  /**
   *  Description of the Method
   *
   *@param  writer  Description of the Parameter
   *@param  db      Description of the Parameter
   *@return         Description of the Return Value
   */
  public boolean process(DataWriter writer, Connection db, PropertyMapList mappings) throws SQLException {
    this.writer = writer; 
    this.mappings = mappings;
    
    //Loop through created items until complete, in the following order
    OpportunityList oppList = new OpportunityList();
    
    writer.setAutoCommit(false);
    this.saveOppList(db, oppList);
    writer.commit();
    
    //update owners
    
    writer.setAutoCommit(true);
    return true;
  }
  
  private void saveOppList(Connection db, OpportunityList oppList) {
    Iterator opps = oppList.iterator();
    while (opps.hasNext()) {
      Opportunity thisOpp = (Opportunity)opps.next();
      DataRecord thisRecord = mappings.createDataRecord(thisOpp, "insert");
      writer.save(thisRecord);
      
      //CallList callList = new CallList();
      //callList.setOppId(thisOpp.getId());
      //callList.buildList() ??
      
      //Iterate thru calls and create datarecords and write like we did for opps?
      
    }
  }
    
}

