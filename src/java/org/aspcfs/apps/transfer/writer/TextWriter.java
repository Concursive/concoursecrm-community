/*
 *  Copyright(c) 2004 Concursive Corporation (http://www.concursive.com/) All
 *  rights reserved. This material cannot be distributed without written
 *  permission from Concursive Corporation. Permission to use, copy, and modify
 *  this material for internal use is hereby granted, provided that the above
 *  copyright notice and this permission notice appear in all copies. CONCURSIVE
 *  CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
 *  IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
 *  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
 *  PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
 *  INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
 *  EVENT SHALL CONCURSIVE CORPORATION OR ANY OF ITS AFFILIATES BE LIABLE FOR
 *  ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
 *  DAMAGES RELATING TO THE SOFTWARE.
 */
package org.aspcfs.apps.transfer.writer;

import org.apache.log4j.Logger;
import org.aspcfs.apps.transfer.DataField;
import org.aspcfs.apps.transfer.DataRecord;
import org.aspcfs.apps.transfer.DataWriter;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Iterator;

/**
 * Description of the Class
 *
 * @author mrajkowski
 * @version $Id$
 * @created January 15, 2003
 */
public class TextWriter implements DataWriter {

  private static final Logger logger = Logger.getLogger(org.aspcfs.apps.transfer.writer.TextWriter.class);

  private String lastResponse = null;
  private String filename = null;
  private boolean overwrite = true;
  private String fieldSeparator = null;
  private boolean showColumnNames = true;
  private PrintWriter out = null;

  private int recordCount = 0;


  /**
   * Sets the filename attribute of the TextWriter object
   *
   * @param tmp The new filename value
   */
  public void setFilename(String tmp) {
    this.filename = tmp;
  }


  /**
   * Sets the overwrite attribute of the TextWriter object
   *
   * @param tmp The new overwrite value
   */
  public void setOverwrite(boolean tmp) {
    this.overwrite = tmp;
  }


  /**
   * Sets the overwrite attribute of the TextWriter object
   *
   * @param tmp The new overwrite value
   */
  public void setOverwrite(String tmp) {
    this.overwrite = "true".equals(tmp);
  }


  /**
   * Sets the fieldSeparator attribute of the TextWriter object
   *
   * @param tmp The new fieldSeparator value
   */
  public void setFieldSeparator(String tmp) {
    this.fieldSeparator = tmp;
  }


  /**
   * Sets the showColumnNames attribute of the TextWriter object
   *
   * @param tmp The new showColumnNames value
   */
  public void setShowColumnNames(boolean tmp) {
    this.showColumnNames = tmp;
  }


  /**
   * Sets the showColumnNames attribute of the TextWriter object
   *
   * @param tmp The new showColumnNames value
   */
  public void setShowColumnNames(String tmp) {
    this.showColumnNames = "true".equals(tmp);
  }


  /**
   * Sets the autoCommit attribute of the TextWriter object
   *
   * @param flag The new autoCommit value
   */
  public void setAutoCommit(boolean flag) {
  }


  /**
   * Gets the version attribute of the TextWriter object
   *
   * @return The version value
   */
  public double getVersion() {
    return 1.0d;
  }


  /**
   * Gets the name attribute of the TextWriter object
   *
   * @return The name value
   */
  public String getName() {
    return "Text Writer";
  }


  /**
   * Gets the description attribute of the TextWriter object
   *
   * @return The description value
   */
  public String getDescription() {
    return "Generates a text representation of data as specified";
  }


  /**
   * Gets the lastResponse attribute of the TextWriter object
   *
   * @return The lastResponse value
   */
  public String getLastResponse() {
    return lastResponse;
  }


  /**
   * Gets the filename attribute of the TextWriter object
   *
   * @return The filename value
   */
  public String getFilename() {
    return filename;
  }


  /**
   * Gets the overwrite attribute of the TextWriter object
   *
   * @return The overwrite value
   */
  public boolean getOverwrite() {
    return overwrite;
  }


  /**
   * Gets the fieldSeparator attribute of the TextWriter object
   *
   * @return The fieldSeparator value
   */
  public String getFieldSeparator() {
    return fieldSeparator;
  }


  /**
   * Gets the showColumnNames attribute of the TextWriter object
   *
   * @return The showColumnNames value
   */
  public boolean getShowColumnNames() {
    return showColumnNames;
  }


  /**
   * Gets the configured attribute of the TextWriter object
   *
   * @return The configured value
   */
  public boolean isConfigured() {
    if (filename == null) {
      return false;
    }

    try {
      out = new PrintWriter(
          new BufferedWriter(new FileWriter(filename, !overwrite)));
    } catch (IOException io) {
      io.printStackTrace(System.out);
      return false;
    }
    return true;
  }


  /**
   * Description of the Method
   */
  public void initialize() {
    this.showColumnNames = true;
    this.recordCount = 0;
  }


  /**
   * Description of the Method
   *
   * @param input Description of the Parameter
   * @return Description of the Return Value
   */
  private String escape(String input) {
    if (input == null) {
      return "";
    }

    if (",".equals(fieldSeparator)) {
      //CSV
      //handle quotes
      StringBuffer result = new StringBuffer();
      for (int i = 0; i < input.length(); ++i) {
        if (input.charAt(i) == '"') {
          result.append("\"\"");
        }
        result.append(input.charAt(i));
      }
      input = result.toString().trim();
      //handle commas
      if (input.indexOf(",") > -1) {
        input = "\"" + input + "\"";
      }
    }
    return input;
  }


  /**
   * Description of the Method
   *
   * @param record Description of the Parameter
   * @return Description of the Return Value
   */
  public boolean save(DataRecord record) {
    ++recordCount;
    try {
      if (recordCount == 1 && showColumnNames) {
        Iterator fieldItems = record.iterator();
        while (fieldItems.hasNext()) {
          DataField thisField = (DataField) fieldItems.next();
          out.print(thisField.getName());
          if (fieldItems.hasNext() && fieldSeparator != null) {
            out.print(fieldSeparator);
          }
        }
        out.println("");
      }
      if (1 == 1) {
        Iterator fieldItems = record.iterator();
        while (fieldItems.hasNext()) {
          DataField thisField = (DataField) fieldItems.next();
          out.print(escape(thisField.getValue()));
          if (fieldItems.hasNext() && fieldSeparator != null) {
            out.print(fieldSeparator);
          }
        }
        out.println("");
      }
    } catch (Exception ex) {
      logger.info(ex.toString());
      ex.printStackTrace(System.out);
      return false;
    }
    return true;
  }


  /**
   * Description of the Method
   *
   * @return Description of the Return Value
   */
  public boolean commit() {
    return true;
  }


  /**
   * Description of the Method
   *
   * @return Description of the Return Value
   */
  public boolean rollback() {
    return false;
  }


  /**
   * Description of the Method
   *
   * @param record Description of the Parameter
   * @return Description of the Return Value
   */
  public boolean load(DataRecord record) {
    return false;
  }


  /**
   * Description of the Method
   *
   * @return Description of the Return Value
   */
  public boolean close() {
    if (out != null) {
      out.close();
    }
    return true;
  }
}

