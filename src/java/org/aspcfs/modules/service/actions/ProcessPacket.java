/*
 *  Copyright 2002 Dark Horse Ventures
 *  Class begins with "Process" so it bypasses security
 */
package com.darkhorseventures.cfsmodule;

import javax.servlet.*;
import javax.servlet.http.*;
import org.theseus.actions.*;
import java.sql.*;
import java.util.*;
import com.darkhorseventures.cfsbase.*;
import com.darkhorseventures.utils.*;
import java.io.*;
import javax.xml.parsers.*;
import org.w3c.dom.*;
import org.xml.sax.*;
import java.lang.reflect.*;

public final class ProcessPacket extends CFSModule {

  public String executeCommandDefault(ActionContext context) {
    Exception errorMessage = null;
    ArrayList statusMessages = new ArrayList();
    Connection db = null;

    try {
      XMLUtils xml = new XMLUtils(context.getRequest());
      if (System.getProperty("DEBUG") != null) {
        System.out.println("ProcessPacket-> Parsing data");
      }
      AuthenticationItem auth = new AuthenticationItem();
      xml.populateObject(auth, xml.getFirstChild("authentication"));
      db = auth.getConnection(context); 
      if (db != null) {
        Hashtable objectMap = new Hashtable();
        if (auth.getClient() == null || auth.getClient().equals("aspcfs")) {
          objectMap.put("account", "com.darkhorseventures.cfsbase.Organization");
          objectMap.put("organization", "com.darkhorseventures.cfsbase.Organization");
          objectMap.put("contact", "com.darkhorseventures.cfsbase.Contact");
          objectMap.put("ticket", "com.darkhorseventures.cfsbase.Ticket");
          objectMap.put("folder", "com.darkhorseventures.cfsbase.CustomFieldCategory");
        } else if (auth.getClient().equals("autoguide")) {
          objectMap.put("user", "com.darkhorseventures.cfsbase.User");
          objectMap.put("syncClient", "com.darkhorseventures.cfsbase.SyncClient");
          objectMap.put("account", "com.darkhorseventures.cfsbase.Organization");
          objectMap.put("accountList", "com.darkhorseventures.cfsbase.OrganizationList");
          objectMap.put("make", "com.darkhorseventures.autoguide.base.Make");
          objectMap.put("model", "com.darkhorseventures.autoguide.base.Model");
          objectMap.put("vehicle", "com.darkhorseventures.autoguide.base.Vehicle");
        }
        ArrayList transactionList = new ArrayList();
        xml.getAllChildren(xml.getDocumentElement(), "transaction", transactionList);
        Iterator trans = transactionList.iterator();
        while (trans.hasNext()) {
          Element thisElement = (Element)trans.next();
          Transaction thisTransaction = new Transaction();
          thisTransaction.setMapping(objectMap);
          thisTransaction.addMapping("meta", "com.darkhorseventures.utils.TransactionMeta");
          thisTransaction.build(thisElement);
          int statusCode = thisTransaction.execute(db);
          TransactionStatus thisStatus = new TransactionStatus();
          thisStatus.setStatusCode(statusCode);
          thisStatus.setId(thisTransaction.getId());
          thisStatus.setMessage(thisTransaction.getErrorMessage());
          thisStatus.setRecordList(thisTransaction.getRecordList());
          statusMessages.add(thisStatus);
        }

        if (statusMessages.size() == 0 && transactionList.size() == 0) {
          TransactionStatus thisStatus = new TransactionStatus();
          thisStatus.setStatusCode(1);
          thisStatus.setMessage("No transactions found");
          statusMessages.add(thisStatus);
        }
      } else {
        TransactionStatus thisStatus = new TransactionStatus();
        thisStatus.setStatusCode(1);
        thisStatus.setMessage("Not authorized");
        statusMessages.add(thisStatus);
      }
    } catch (Exception e) {
      errorMessage = e;
      e.printStackTrace();
      TransactionStatus thisStatus = new TransactionStatus();
      thisStatus.setStatusCode(1);
      thisStatus.setMessage("Error: " + e.getMessage());
      statusMessages.add(thisStatus);
    } finally {
      if (db != null) this.freeConnection(context, db);
    }

    try {
      DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
      DocumentBuilder builder = dbf.newDocumentBuilder();
      Document document = builder.newDocument();
      Element app = document.createElement("aspcfs");
      document.appendChild(app);
      
      Iterator messages = statusMessages.iterator();
      while (messages.hasNext()) {
        if (System.getProperty("DEBUG") != null) {
          System.out.println("ProcessPacket-> Processing StatusMessage for output");
        }
      
        TransactionStatus thisMessage = (TransactionStatus)messages.next();
        Element response = document.createElement("response");
        if (thisMessage.getId() > -1) {
          response.setAttribute("id", "" + thisMessage.getId());
        }
        app.appendChild(response);
        Element status = document.createElement("status");
        status.appendChild(document.createTextNode(String.valueOf(thisMessage.getStatusCode())));
        response.appendChild(status);
        
        Element errorText = document.createElement("errorText");
        errorText.appendChild(document.createTextNode(thisMessage.getMessage()));
        response.appendChild(errorText);
        
        if (thisMessage.hasRecordList()) {
          Element recordSet = document.createElement("recordSet");
          recordSet.setAttribute("name", thisMessage.getRecordList().getName());
          recordSet.setAttribute("count", String.valueOf(thisMessage.getRecordList().size()));
          response.appendChild(recordSet);
          
          Iterator recordList = thisMessage.getRecordList().iterator();
          while (recordList.hasNext()) {
            Element record = document.createElement("record");
            recordSet.appendChild(record);
            Record thisRecord = (Record)recordList.next();
            Iterator fields = thisRecord.keySet().iterator();
            while (fields.hasNext()) {
              String fieldName = (String)fields.next();
              String fieldValue = (String)thisRecord.get(fieldName);
              Element field = document.createElement(fieldName);
              field.appendChild(document.createTextNode(fieldValue));
              record.appendChild(field);
            }
          }
          
        }
      }
      
      context.getRequest().setAttribute("statusXML", XMLUtils.toString(document));
    } catch (Exception pce) {
      pce.printStackTrace(System.out);
    }
    return ("PacketOK");
  }
}

