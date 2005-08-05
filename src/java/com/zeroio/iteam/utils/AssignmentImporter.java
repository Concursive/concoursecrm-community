/*
 *  Copyright(c) 2004 Team Elements LLC (http://www.teamelements.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Team Elements LLC. Permission to use, copy, and modify this
 *  material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. TEAM
 *  ELEMENTS MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL TEAM ELEMENTS LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR ANY
 *  DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package com.zeroio.iteam.utils;

import com.isavvix.tools.FileInfo;
import com.zeroio.iteam.base.Assignment;
import com.zeroio.iteam.base.Requirement;
import com.zeroio.iteam.base.TeamMemberList;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.aspcfs.utils.XMLUtils;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.xml.sax.EntityResolver;
import org.xml.sax.InputSource;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import java.io.ByteArrayInputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;

/**
 * Imports data from other formats into an outline
 *
 * @author matt rajkowski
 * @version $Id: AssignmentImporter.java,v 1.3 2004/08/31 12:48:25 mrajkowski
 *          Exp $
 * @created June 30, 2004
 */
public class AssignmentImporter {

  /**
   * Description of the Method
   *
   * @param fileInfo    Description of the Parameter
   * @param requirement Description of the Parameter
   * @param db          Description of the Parameter
   * @return Description of the Return Value
   * @throws Exception Description of the Exception
   */
  public static boolean parse(FileInfo fileInfo, Requirement requirement, Connection db) throws Exception {
    if (System.getProperty("DEBUG") != null) {
      System.out.println(
          "AssignmentImporter-> trying to parse: " + fileInfo.getClientFileName().toLowerCase());
    }
    if (fileInfo == null) {
      return false;
    }
    if (fileInfo.getClientFileName().toLowerCase().endsWith(".xls")) {
      return parseExcel(fileInfo.getFileContents(), requirement, db);
    }
    if (fileInfo.getClientFileName().toLowerCase().endsWith(".xmloutline")) {
      return parseOmniOutliner(fileInfo.getFileContents(), requirement, db);
    }
    return false;
  }


  /**
   * Description of the Method
   *
   * @param requirement Description of the Parameter
   * @param db          Description of the Parameter
   * @param buffer      Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public static boolean parseExcel(byte[] buffer, Requirement requirement, Connection db) throws SQLException {
    if (System.getProperty("DEBUG") != null) {
      System.out.println("AssignmentImporter-> parseExcel");
    }
    try {
      db.setAutoCommit(false);
      // stream the Excel Spreadsheet from the uploaded byte array
      POIFSFileSystem fs =
          new POIFSFileSystem(new ByteArrayInputStream(buffer));
      HSSFWorkbook hssfworkbook = new HSSFWorkbook(fs);
      // get the first sheet
      HSSFSheet sheet = hssfworkbook.getSheetAt(0);
      // define objects for housing spreadsheet data
      HSSFRow currentRow = sheet.getRow(0);
      // parse each row, create and insert into a new requirement with a tree
      int rows = sheet.getPhysicalNumberOfRows();
      if (System.getProperty("DEBUG") != null) {
        System.out.println("AssignmentImporter-> Number of rows: " + rows);
      }
      // Columns
      int columnHeader = -1;
      int columnMax = -1;
      boolean columnItemComplete = false;
      short itemColumn = -1;
      short priorityColumn = -1;
      short assignedToColumn = -1;
      short effortColumn = -1;
      short startColumn = -1;
      short endColumn = -1;

      // parse
      for (int r = 0; r < rows; r++) {
        currentRow = sheet.getRow(r);

        if (currentRow != null) {
          // Search for header
          if (columnHeader == -1) {
            int cells = currentRow.getPhysicalNumberOfCells();
            for (short c = 0; c < cells; c++) {
              HSSFCell cell = currentRow.getCell(c);
              if (cell != null) {
                if ("Item".equals(getValue(cell))) {
                  columnHeader = r;
                  itemColumn = c;
                  columnMax = c;
                } else if (itemColumn > -1 && !columnItemComplete && c > itemColumn) {
                  if ("".equals(getValue(cell))) {
                    columnMax = c;
                  } else if (!"".equals(getValue(cell))) {
                    columnItemComplete = true;
                  }
                }
                if ("Priority".equals(getValue(cell))) {
                  columnHeader = r;
                  priorityColumn = c;
                } else if ("Assigned To".equals(getValue(cell))) {
                  columnHeader = r;
                  assignedToColumn = c;
                } else if ("Effort".equals(getValue(cell))) {
                  columnHeader = r;
                  effortColumn = c;
                } else if ("Start".equals(getValue(cell))) {
                  columnHeader = r;
                  startColumn = c;
                } else if ("End".equals(getValue(cell))) {
                  columnHeader = r;
                  endColumn = c;
                }
              }
            }
          }
          // Process each column
          if (columnHeader > -1 && r > columnHeader) {
            boolean gotOne = false;
            Assignment assignment = new Assignment();
            assignment.setProjectId(requirement.getProjectId());
            assignment.setRequirementId(requirement.getId());
            // Activities and folders
            if (itemColumn > -1) {
              // Get the first indent level that has data
              for (short c = itemColumn; c <= columnMax; c++) {
                HSSFCell cell = currentRow.getCell(c);
                if (cell != null && !"".equals(getValue(cell))) {
                  assignment.setRole(getValue(cell));
                  assignment.setIndent(c);
                  gotOne = true;
                  break;
                }
              }
            }
            if (gotOne) {
              // Priority
              if (priorityColumn > -1) {
                HSSFCell cell = currentRow.getCell(priorityColumn);
                if (cell != null) {
                  assignment.setPriorityId(getValue(cell));
                }
              }
              // Effort
              if (effortColumn > -1) {
                HSSFCell cell = currentRow.getCell(effortColumn);
                if (cell != null) {
                  assignment.setEstimatedLoe(getValue(cell));
                  if (assignment.getEstimatedLoeTypeId() == -1) {
                    assignment.setEstimatedLoeTypeId(2);
                  }
                }
              }
              // Assigned To
              if (assignedToColumn > -1) {
                HSSFCell cell = currentRow.getCell(assignedToColumn);
                if (cell != null) {
                  assignment.setUserAssignedId(getValue(cell));
                }
              }
              // Start Date
              if (startColumn > -1) {
                HSSFCell cell = currentRow.getCell(startColumn);
                if (cell != null) {
                  assignment.setEstStartDate(getDateValue(cell));
                }
              }
              // Due Date
              if (endColumn > -1) {
                HSSFCell cell = currentRow.getCell(endColumn);
                if (cell != null) {
                  assignment.setDueDate(getDateValue(cell));
                }
              }
              assignment.setEnteredBy(requirement.getEnteredBy());
              assignment.setModifiedBy(requirement.getModifiedBy());
              assignment.setStatusId(1);
              // Make sure a valid priority is set
              if (assignment.getPriorityId() < 1 || assignment.getPriorityId() > 3) {
                assignment.setPriorityId(2);
              }
              // Make sure user is on team, before adding, else unset the field
              if (assignment.getUserAssignedId() > 0) {
                if (!TeamMemberList.isOnTeam(
                    db, requirement.getProjectId(), assignment.getUserAssignedId())) {
                  assignment.setUserAssignedId(-1);
                }
              }
              // Insert the assignment
              assignment.insert(db);
              if (System.getProperty("DEBUG") != null) {
                System.out.println(
                    "AssignmentImporter-> Assignment Inserted: " + assignment.getId());
              }
            }
          }
        }
      }
      db.commit();
    } catch (Exception e) {
      db.rollback();
      e.printStackTrace(System.out);
      return false;
    } finally {
      db.setAutoCommit(true);
    }
    return true;
  }


  /**
   * Gets the value attribute of the AssignmentImporter class
   *
   * @param cell Description of the Parameter
   * @return The value value
   */
  private static String getValue(HSSFCell cell) {
    if (cell.getCellType() == HSSFCell.CELL_TYPE_NUMERIC) {
      return String.valueOf(cell.getNumericCellValue());
    }
    if (cell.getCellType() == HSSFCell.CELL_TYPE_BOOLEAN) {
      return String.valueOf(cell.getBooleanCellValue());
    }
    if (cell.getCellType() == HSSFCell.CELL_TYPE_STRING) {
      return cell.getStringCellValue().trim();
    }
    if (cell.getCellType() == HSSFCell.CELL_TYPE_BLANK) {
      return "";
    }
    if (System.getProperty("DEBUG") != null) {
      System.out.println("AssignmentImporter-> NONE: " + cell.getCellType());
    }
    try {
      return cell.getStringCellValue().trim();
    } catch (Exception e) {
    }
    try {
      return String.valueOf(cell.getNumericCellValue());
    } catch (Exception e) {
    }
    try {
      return String.valueOf(cell.getBooleanCellValue());
    } catch (Exception e) {
    }
    return null;
  }

  private static java.util.Date getDateValue(HSSFCell cell) {
    try {
      return cell.getDateCellValue();
    } catch (Exception e) {
      return null;
    }
  }


  /**
   * Description of the Method
   *
   * @param buffer      Description of the Parameter
   * @param requirement Description of the Parameter
   * @param db          Description of the Parameter
   * @return Description of the Return Value
   * @throws SQLException Description of the Exception
   */
  public static boolean parseOmniOutliner(byte[] buffer, Requirement requirement, Connection db) throws SQLException {
    if (System.getProperty("DEBUG") != null) {
      System.out.println("AssignmentImporter-> parseOmniOutliner");
    }
    try {
      db.setAutoCommit(false);
      // stream the XML Outline from the uploaded byte array, ignore the DTD
      DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
      DocumentBuilder builder = factory.newDocumentBuilder();
      builder.setEntityResolver(
          new EntityResolver() {
            public InputSource resolveEntity(java.lang.String publicId, java.lang.String systemId)
                throws SAXException, java.io.IOException {
              return new InputSource(
                  new ByteArrayInputStream(
                      "<?xml version='1.0' encoding='UTF-8'?>".getBytes()));
            }
          });
      Document document = builder.parse(new ByteArrayInputStream(buffer));
      // Position
      boolean positionItemComplete = false;
      // Umm... put in an object
      short itemPosition = -1;
      short priorityPosition = -1;
      short assignedToPosition = -1;
      short effortPosition = -1;
      short startPosition = -1;
      short endPosition = -1;
      // Parse the columns
      ArrayList columnList = new ArrayList();
      Element columnElement = XMLUtils.getFirstChild(document, "oo:columns");
      XMLUtils.getAllChildren(columnElement, columnList);
      if (System.getProperty("DEBUG") != null) {
        System.out.println(
            "AssignmentImporter-> Columns: " + columnList.size());
      }
      Iterator columnIterator = columnList.iterator();
      short position = -1;
      boolean foundOutline = false;
      while (columnIterator.hasNext()) {
        Element columnNode = (Element) columnIterator.next();
        Element column = XMLUtils.getFirstChild(columnNode, "oo:title");
        String columnName = XMLUtils.getNodeText(column);
        if (System.getProperty("DEBUG") != null) {
          System.out.println(
              "AssignmentImporter-> Column name: " + columnName);
        }
        if ("yes".equals(
            (String) columnNode.getAttribute("is-outline-column"))) {
          foundOutline = true;
        }
        if (foundOutline) {
          ++position;
          if ("topic".equalsIgnoreCase(columnName)) {
            positionItemComplete = true;
            itemPosition = position;
          }
          if (positionItemComplete) {
            if ("priority".equalsIgnoreCase(columnName)) {
              priorityPosition = position;
            } else if ("lead".equalsIgnoreCase(columnName)) {
              assignedToPosition = position;
            } else if ("effort".equalsIgnoreCase(columnName)) {
              effortPosition = position;
            } else if ("start".equalsIgnoreCase(columnName)) {
              startPosition = position;
            } else if ("end".equalsIgnoreCase(columnName)) {
              endPosition = position;
            }
          }
        }
      }
      // Process the outline
      if (positionItemComplete) {
        ArrayList itemList = new ArrayList();
        Element rootElement = XMLUtils.getFirstChild(document, "oo:root");
        XMLUtils.getAllChildren(rootElement, itemList);
        if (System.getProperty("DEBUG") != null) {
          System.out.println("AssignmentImporter-> Items: " + itemList.size());
        }
        // Go through the items, for each item see if it has children, with items, etc.
        Iterator itemIterator = itemList.iterator();
        while (itemIterator.hasNext()) {
          Element itemElement = (Element) itemIterator.next();
          parseItemElement(
              itemElement, db, 0, requirement.getProjectId(), requirement.getId(),
              requirement.getEnteredBy(), requirement.getModifiedBy(),
              itemPosition, priorityPosition, assignedToPosition, effortPosition, startPosition, endPosition);
        }
      }
      db.commit();
    } catch (Exception e) {
      db.rollback();
      e.printStackTrace(System.out);
      return false;
    } finally {
      db.setAutoCommit(true);
    }
    return true;
  }


  /**
   * Description of the Method
   *
   * @param item               Description of the Parameter
   * @param db                 Description of the Parameter
   * @param indent             Description of the Parameter
   * @param projectId          Description of the Parameter
   * @param requirementId      Description of the Parameter
   * @param enteredBy          Description of the Parameter
   * @param modifiedBy         Description of the Parameter
   * @param itemPosition       Description of the Parameter
   * @param priorityPosition   Description of the Parameter
   * @param assignedToPosition Description of the Parameter
   * @param effortPosition     Description of the Parameter
   * @param startPosition      Description of the Parameter
   * @param endPosition        Description of the Parameter
   * @throws Exception Description of the Exception
   */
  private static void parseItemElement(Element item, Connection db, int indent, int projectId, int requirementId,
                                       int enteredBy, int modifiedBy,
                                       int itemPosition, int priorityPosition, int assignedToPosition, int effortPosition, int startPosition, int endPosition) throws Exception {
    // Get the values for the item
    ArrayList valuesList = new ArrayList();
    Element valuesElement = XMLUtils.getFirstChild(item, "oo:values");
    XMLUtils.getAllChildren(valuesElement, valuesList);
    // Insert the assignment
    Assignment assignment = new Assignment();
    assignment.setProjectId(projectId);
    assignment.setRequirementId(requirementId);
    assignment.setRole(extractText((Element) valuesList.get(itemPosition)));
    assignment.setIndent(indent);
    if (effortPosition > -1) {
      assignment.setEstimatedLoe(
          extractText((Element) valuesList.get(effortPosition)));
    }
    if (startPosition > -1) {
      assignment.setEstStartDate(
          extractText((Element) valuesList.get(startPosition)));
    }
    if (endPosition > -1) {
      assignment.setDueDate(
          extractText((Element) valuesList.get(endPosition)));
    }
    assignment.setEnteredBy(enteredBy);
    assignment.setModifiedBy(modifiedBy);
    assignment.setStatusId(1);
    assignment.setPriorityId(2);
    assignment.insert(db);
    if (System.getProperty("DEBUG") != null) {
      System.out.println(
          "AssignmentImporter-> Assignment Inserted: " + assignment.getId());
    }

    // See if there are children, then parse the children items
    Element childrenElement = XMLUtils.getFirstChild(item, "oo:children");
    if (childrenElement != null) {
      ArrayList itemList = new ArrayList();
      XMLUtils.getAllChildren(childrenElement, itemList);
      if (System.getProperty("DEBUG") != null) {
        System.out.println(
            "AssignmentImporter-> Children items: " + itemList.size());
      }
      // Go through the items, for each item see if it has children, with items, etc.
      Iterator itemIterator = itemList.iterator();
      while (itemIterator.hasNext()) {
        Element itemElement = (Element) itemIterator.next();
        parseItemElement(
            itemElement, db, (indent + 1), projectId, requirementId,
            enteredBy, modifiedBy,
            itemPosition, priorityPosition, assignedToPosition, effortPosition, startPosition, endPosition);
      }
    }
  }


  /**
   * Description of the Method
   *
   * @param element Description of the Parameter
   * @return Description of the Return Value
   * @throws Exception Description of the Exception
   */
  public static String extractText(Element element) throws Exception {
    Element p = XMLUtils.getFirstChild(element, "oo:p");
    if (p == null) {
      if (System.getProperty("DEBUG") != null) {
        System.out.println(
            "AssignmentImporter-> TEXT: " + XMLUtils.getNodeText(element));
      }
      return XMLUtils.getNodeText(element);
    }
    if (System.getProperty("DEBUG") != null) {
      System.out.println(
          "AssignmentImporter-> TEXT: " + XMLUtils.getNodeText(p));
    }
    return XMLUtils.getNodeText(p);
  }
}

