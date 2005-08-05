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
package org.aspcfs.apps.help;

import com.darkhorseventures.database.ConnectionElement;
import com.darkhorseventures.database.ConnectionPool;
import org.w3c.dom.Document;
import org.w3c.dom.Node;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.transform.*;
import javax.xml.transform.dom.DOMSource;
import javax.xml.transform.stream.StreamResult;
import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

/**
 * Extracts all the contents of of the help system (Table of Contents, context
 * sensitive help, module related help) from the database and builds an XML
 * file from it. The XML file preserves all the relationships that exist in the
 * database either by using explicit attributes or by their relative position
 * in the XML Document
 *
 * @author kbhoopal
 * @version $Id$
 * @created November 25, 2003
 */
public class ExportHelp {

  ArrayList helpModules;


  /**
   * Constructor for the ExportHelp object
   */
  public ExportHelp() {
  }


  /**
   * Constructor for the ExportHelp object
   *
   * @param args Command line parameters to connect to the database
   */
  public ExportHelp(String[] args) {

    helpModules = new ArrayList();
    buildHelpInformation(args);

    System.exit(0);

  }


  /**
   * The main program for the ExportHelp class
   *
   * @param args Command line parameters to connect to the database
   */
  public static void main(String[] args) {

    if ((args.length != 4) && (args.length != 5)) {
      System.out.println(
          "Synopsis: java ExportHelp [filepath][driver][uri][user] <passwd>");
    } else {
      new ExportHelp(args);
    }

  }


  /**
   * Connects to the data base, builds the data structure to temporarily hold
   * the help information and builds the XML document from the data structure
   *
   * @param args Description of the Parameter
   */
  void buildHelpInformation(String[] args) {
    ConnectionPool sqlDriver = null;
    System.out.println("Starting...");
    int recordCount = 0;
    try {
      sqlDriver = new ConnectionPool();
    } catch (SQLException e) {
      System.err.println(e);
    }
    Connection db = null;
    try {

      String filePath = args[0];

      String driver = args[1];
      String uri = args[2];
      String username = args[3];
      String passwd = "";
      if (args.length == 5) {
        passwd = args[4];
      }

      sqlDriver.setForceClose(false);
      sqlDriver.setMaxConnections(5);
      //Test a single connection
      ConnectionElement thisElement = new ConnectionElement(
          uri, username, passwd);
      thisElement.setDriver(driver);

      db = sqlDriver.getConnection(thisElement);

      buildTOCIncludedHelpModules(db);
      buildNonTocHelpModules(db);

      Iterator i = helpModules.iterator();
      while (i.hasNext()) {
        HelpModule tempHelpModule = (HelpModule) i.next();
        tempHelpModule.buildHelpContents(db);
      }

      System.out.println("built description");

      buildXML(filePath);
      sqlDriver.free(db);

      System.out.println("Built XML file and released database connection");
      return;
    } catch (Exception e) {
      System.err.println(e);
    }

  }


  /**
   * Extracts help modules and related context sensitive help items for those
   * represented in the Table of Contents
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  void buildTOCIncludedHelpModules(Connection db) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "SELECT module_id, category, hm.category_id as catId, module_brief_description, module_detail_description, contentorder " +
        "FROM help_module hm, permission_category pc, help_tableof_contents hc " +
        "WHERE hm.category_id = pc.category_id " +
        "AND pc.category_id = hc.category_id " +
        "AND hm.category_id = hc.category_id " +
        "AND contentlevel = 2 " +
        "ORDER BY contentorder ASC");

    ResultSet rs = pst.executeQuery();
    while (rs.next()) {
      HelpModule tempHelpModule = new HelpModule();
      tempHelpModule.buildRecord(rs);
      tempHelpModule.setContentLevel(2);
      helpModules.add(tempHelpModule);
    }
    System.out.println("built data structure");
    rs.close();
    pst.close();
  }


  /**
   * Extracts help modules and related context sensitive help items of those
   * ecluded from the Table of Contents
   *
   * @param db Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  void buildNonTocHelpModules(Connection db) throws SQLException {
    //fetching modules(or categories) that are not represented in the table of contents
    PreparedStatement pst = db.prepareStatement(
        "SELECT help_module.category_id as id1, help_tableof_contents.category_id as id2 " +
        "FROM help_module LEFT OUTER JOIN help_tableof_contents " +
        "ON (help_tableof_contents.category_id = help_module.category_id)");

    ResultSet rs = pst.executeQuery();

    // Place to store the category_ids that are not recorded in the table of contents
    ArrayList categoryIds = new ArrayList();
    while (rs.next()) {
      if (String.valueOf(rs.getInt("id2")).equals("0")) {
        categoryIds.add(String.valueOf(rs.getInt("id1")));
      }
    }
    rs.close();
    pst.close();

    if (categoryIds.size() == 0) {
      return;
    }

    String nonTocCategories = "(";
    Iterator itr = categoryIds.iterator();
    while (itr.hasNext()) {
      nonTocCategories = nonTocCategories + (String) itr.next();
      if (itr.hasNext()) {
        nonTocCategories = nonTocCategories + ",";
      }
    }
    nonTocCategories = nonTocCategories + ")";

    /*
     *  Query to extract module description of those modules not represented in the
     *  the Table of Contents
     */
    pst = db.prepareStatement(
        "SELECT module_id, category, hm.category_id as catId, module_brief_description, module_detail_description " +
        "FROM help_module hm, permission_category pc " +
        "WHERE pc.category_id = hm.category_id " +
        "AND pc.category_id IN " + nonTocCategories);

    rs = pst.executeQuery();

    while (rs.next()) {
      HelpModule tempHelpModule = new HelpModule(rs);
      tempHelpModule.setContentLevel(0);
      helpModules.add(tempHelpModule);
    }

    rs.close();
    pst.close();
  }


  /**
   * Builds the XML document for the help information
   *
   * @param filePath Description of the Parameter
   */
  void buildXML(String filePath) {
    try {
      DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
      DocumentBuilder db = dbf.newDocumentBuilder();
      Document d = db.newDocument();

      Node system = d.createElement("helpSystem");
      Iterator i = helpModules.iterator();
      int n = 0;
      while (i.hasNext()) {
        HelpModule tempHelpModule = (HelpModule) i.next();
        system.appendChild(tempHelpModule.buildXML(d));
      }

      d.appendChild(system);

      TransformerFactory transformerFactory = TransformerFactory.newInstance();
      Transformer transformer = transformerFactory.newTransformer();
      transformer.setOutputProperty(OutputKeys.INDENT, "yes");

      Result result = new StreamResult(new File(filePath));
      Source source = new DOMSource(d);
      transformer.transform(source, result);

    } catch (Exception e) {
      System.err.println(e);
    }
  }
}

