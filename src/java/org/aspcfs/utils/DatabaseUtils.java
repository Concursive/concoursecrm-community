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
package org.aspcfs.utils;

import com.darkhorseventures.database.ConnectionPool;
import com.darkhorseventures.framework.actions.ActionContext;
import org.aspcfs.modules.base.Constants;

import javax.servlet.ServletContext;
import java.io.*;
import java.sql.*;
import java.text.DateFormat;
import java.util.Locale;

/**
 * Useful methods for working with multiple databases and database fields
 *
 * @author matt rajkowski
 * @version $Id: DatabaseUtils.java,v 1.13 2002/11/04 13:21:16 mrajkowski Exp
 *          $
 * @created March 18, 2002
 */
public class DatabaseUtils {

  public final static int POSTGRESQL = 1;
  public final static int MSSQL = 2;
  public final static int ORACLE = 3;
  public final static int FIREBIRD = 4;
  public final static int DAFFODILDB = 5;
  public final static int DB2 = 6;
  public final static String CRLF = System.getProperty("line.separator");
  //intervals
  public final static int DAY = 1;
  public final static int WEEK = 2;
  public final static int MONTH = 3;
  public final static int YEAR = 4;

  /**
   * Gets the true attribute of the DatabaseUtils class
   *
   * @param db Description of Parameter
   * @return The true value
   */
  public static String getTrue(Connection db) {
    switch (DatabaseUtils.getType(db)) {
      case DatabaseUtils.POSTGRESQL:
        return "true";
      case DatabaseUtils.MSSQL:
        return "1";
      case DatabaseUtils.DAFFODILDB:
        return "true";
      case DatabaseUtils.ORACLE:
        return "true";
      case DatabaseUtils.DB2:
        return "true";
      case DatabaseUtils.FIREBIRD:
        return "1";
      default:
        return "true";
    }
  }


  /**
   * Gets the false attribute of the DatabaseUtils class
   *
   * @param db Description of Parameter
   * @return The false value
   */
  public static String getFalse(Connection db) {
    switch (DatabaseUtils.getType(db)) {
      case DatabaseUtils.POSTGRESQL:
        return "false";
      case DatabaseUtils.MSSQL:
        return "0";
      case DatabaseUtils.DAFFODILDB:
        return "false";
      case DatabaseUtils.ORACLE:
        return "false";
      case DatabaseUtils.DB2:
        return "false";
      case DatabaseUtils.FIREBIRD:
        return "0";
      default:
        return "false";
    }
  }


  /**
   * Gets the currentTimestamp attribute of the DatabaseUtils class
   *
   * @param db Description of Parameter
   * @return The currentTimestamp value
   */
  public static String getCurrentTimestamp(Connection db) {
    switch (DatabaseUtils.getType(db)) {
      case DatabaseUtils.POSTGRESQL:
        return "CURRENT_TIMESTAMP";
      case DatabaseUtils.MSSQL:
        return "CURRENT_TIMESTAMP";
      case DatabaseUtils.DAFFODILDB:
        return "CURRENT_TIMESTAMP";
      case DatabaseUtils.ORACLE:
        return "CURRENT_TIMESTAMP";
      case DatabaseUtils.DB2:
        return "CURRENT_TIMESTAMP";
      case DatabaseUtils.FIREBIRD:
        return "CURRENT_TIMESTAMP";
      default:
        return "CURRENT_TIMESTAMP";
    }
  }


  /**
   * Gets the type attribute of the DatabaseUtils class
   *
   * @param db Description of Parameter
   * @return The type value
   */
  public static int getType(Connection db) {
    String databaseName = db.getClass().getName();
    if (databaseName.indexOf("postgresql") > -1) {
      return POSTGRESQL;
    } else if ("net.sourceforge.jtds.jdbc.ConnectionJDBC3".equals(
        databaseName)) {
      return MSSQL;
    } else if ("net.sourceforge.jtds.jdbc.TdsConnectionJDBC3".equals(
        databaseName)) {
      return MSSQL;
    } else if (databaseName.indexOf("sqlserver") > -1) {
      return MSSQL;
    } else if ("net.sourceforge.jtds.jdbc.TdsConnection".equals(databaseName)) {
      return MSSQL;
    } else if ("org.firebirdsql.jdbc.FBDriver".equals(databaseName)) {
      return FIREBIRD;
    } else if (databaseName.indexOf("oracle") > -1) {
      return ORACLE;
    } else if (databaseName.startsWith(
        "in.co.daffodil.db.jdbc.DaffodilDBConnection")) {
      return DAFFODILDB;
    } else if (databaseName.indexOf("db2") > -1) {
      return DB2;
    } else {
      System.out.println("DatabaseUtils-> Driver: " + databaseName);
      return -1;
    }
  }


  /**
   * Gets the typeName attribute of the DatabaseUtils class
   *
   * @param db Description of the Parameter
   * @return The typeName value
   */
  public static String getTypeName(Connection db) {
    switch (getType(db)) {
      case POSTGRESQL:
        return "postgresql";
      case MSSQL:
        return "mssql";
      case FIREBIRD:
        return "firebird";
      case ORACLE:
        return "oracle";
      case DAFFODILDB:
        return "daffodildb";
      case DB2:
        return "db2";
      default:
        return "unknown";
    }
  }


  /**
   * Description of the Method
   *
   * @param db   Description of the Parameter
   * @param date Description of the Parameter
   * @return Description of the Return Value
   */
  public static String castDateTimeToDate(Connection db, String date) {
    switch (DatabaseUtils.getType(db)) {
      case DatabaseUtils.POSTGRESQL:
        return (date + "::date");
      case DatabaseUtils.MSSQL:
        return ("CONVERT(char(10), " + date + ", 101)");
      case DatabaseUtils.FIREBIRD:
        return ("EXTRACT(DATE FROM " + date + ")");
      case DatabaseUtils.DAFFODILDB:
        return ("DATE(" + date + ")");
      case DatabaseUtils.ORACLE:
        return ("DATE(" + date + ")");
        //case DatabaseUtils.ORACLE:
        //  return ("CAST(" + date + " AS DATE)");
      default:
        return "";
    }
  }


  /**
   * Adds a feature to the TimeStampInterval attribute of the DatabaseUtils
   * class
   *
   * @param db                  The feature to be added to the
   *                            TimeStampInterval attribute
   * @param units               The feature to be added to the
   *                            TimeStampInterval attribute
   * @param termsColumnName     The feature to be added to the
   *                            TimeStampInterval attribute
   * @param timeStampColumnName The feature to be added to the
   *                            TimeStampInterval attribute
   * @return Description of the Return Value
   */
  public static String addTimeStampInterval(Connection db, int units, String termsColumnName, String timeStampColumnName) {
    String addTimeStampIntervalString = "";
    String customUnits = "";
    switch (DatabaseUtils.getType(db)) {
      case DatabaseUtils.POSTGRESQL:
        if (units == DAY) {
        } else if (units == WEEK) {
        } else if (units == MONTH) {
          customUnits = "months";
        } else if (units == YEAR) {
        }
        addTimeStampIntervalString = timeStampColumnName + " + ( (" + termsColumnName + " + 1 )::text || ' " + customUnits + "')::interval ";
        break;
      case DatabaseUtils.MSSQL:
        if (units == DAY) {
        } else if (units == WEEK) {
        } else if (units == MONTH) {
          customUnits = "MONTH";
        } else if (units == YEAR) {
        }
        addTimeStampIntervalString = " DATEADD(" + customUnits + ",(" + termsColumnName + " + 1)," + timeStampColumnName + ")";
        break;
      case DatabaseUtils.FIREBIRD:
        break;
      case DatabaseUtils.DAFFODILDB:
        if (units == DAY) {
        } else if (units == WEEK) {
        } else if (units == MONTH) {
          customUnits = "SQL_TSI_MONTH";
        } else if (units == YEAR) {
        }
        addTimeStampIntervalString = " TIMESTAMPADD(" + customUnits + ",(" + termsColumnName + " + 1)," + timeStampColumnName + ")";
        break;
      case DatabaseUtils.ORACLE:
        break;
    }
    return addTimeStampIntervalString;
  }


  /**
   * Gets the nextSeq attribute of the DatabaseUtils class, used before an
   * insert statement has been executed
   *
   * @param db           Description of the Parameter
   * @param sequenceName Description of the Parameter
   * @return The nextSeq value
   * @throws SQLException Description of the Exception
   */
  public static int getNextSeq(Connection db, String sequenceName) throws SQLException {
    int typeId = DatabaseUtils.getType(db);
    if (typeId == POSTGRESQL || typeId == MSSQL) {
      return -1;
    }
    int id = -1;
    Statement st = db.createStatement();
    ResultSet rs = null;
    switch (typeId) {
      case DatabaseUtils.FIREBIRD:
        rs = st.executeQuery(
            "SELECT GEN_ID (" + sequenceName + ",1) FROM RDB$DATABASE");
        break;
      case DatabaseUtils.DAFFODILDB:
        rs = st.executeQuery("SELECT " + sequenceName + ".nextval from dual");
        break;
      case DatabaseUtils.ORACLE:
        rs = st.executeQuery("SELECT " + sequenceName + ".nextval from dual");
        break;
      default:
        break;
    }
    if (rs.next()) {
      id = rs.getInt(1);
    }
    rs.close();
    st.close();
    return id;
  }


  /**
   * Gets the currVal attribute of the DatabaseUtils class, used after an
   * insert statement has been executed
   *
   * @param db           Description of the Parameter
   * @param sequenceName Description of the Parameter
   * @param defaultValue Description of the Parameter
   * @return The currVal value
   * @throws SQLException Description of the Exception
   */
  public static int getCurrVal(Connection db, String sequenceName, int defaultValue) throws SQLException {
    int typeId = DatabaseUtils.getType(db);
    if (typeId != POSTGRESQL && typeId != MSSQL) {
      return defaultValue;
    }
    int id = -1;
    Statement st = db.createStatement();
    ResultSet rs = null;
    switch (typeId) {
      case DatabaseUtils.POSTGRESQL:
        rs = st.executeQuery("SELECT currval('" + sequenceName + "')");
        break;
      case DatabaseUtils.MSSQL:
        rs = st.executeQuery("SELECT @@IDENTITY");
        break;
      default:
        break;
    }
    if (rs.next()) {
      id = rs.getInt(1);
    }
    rs.close();
    st.close();
    return id;
  }


  /**
   * Useful when generating a SQL order by clause to sort by year for the given
   * timestamp field
   *
   * @param db        Description of the Parameter
   * @param fieldname Description of the Parameter
   * @return The yearPart value
   */
  public static String getYearPart(Connection db, String fieldname) {
    switch (DatabaseUtils.getType(db)) {
      case DatabaseUtils.POSTGRESQL:
        return "date_part('year', " + fieldname + ")";
      case DatabaseUtils.MSSQL:
        return "DATEPART(YY, " + fieldname + ")";
      case DatabaseUtils.FIREBIRD:
        return "EXTRACT(YEAR FROM " + fieldname + ")";
      case DatabaseUtils.DAFFODILDB:
        return "YEAR(" + fieldname + ")";
      case DatabaseUtils.ORACLE:
        return "EXTRACT(YEAR FROM " + fieldname + ")";
      default:
        return "";
    }
  }


  /**
   * Useful when generating a SQL order by clause to sort by month for the
   * given timestamp field
   *
   * @param db        Description of the Parameter
   * @param fieldname Description of the Parameter
   * @return The orderByMonth value
   */
  public static String getMonthPart(Connection db, String fieldname) {
    switch (DatabaseUtils.getType(db)) {
      case DatabaseUtils.POSTGRESQL:
        return "date_part('month', " + fieldname + ")";
      case DatabaseUtils.MSSQL:
        return "DATEPART(MM, " + fieldname + ")";
      case DatabaseUtils.FIREBIRD:
        return "EXTRACT(MONTH FROM " + fieldname + ")";
      case DatabaseUtils.DAFFODILDB:
        return "MONTH(" + fieldname + ")";
      case DatabaseUtils.ORACLE:
        return "EXTRACT(MONTH FROM " + fieldname + ")";
      default:
        return "";
    }
  }


  /**
   * Useful when generating a SQL order by clause to sort by day for the given
   * timestamp field
   *
   * @param db        Description of the Parameter
   * @param fieldname Description of the Parameter
   * @return The orderByDay value
   */
  public static String getDayPart(Connection db, String fieldname) {
    switch (DatabaseUtils.getType(db)) {
      case DatabaseUtils.POSTGRESQL:
        return "date_part('day', " + fieldname + ")";
      case DatabaseUtils.MSSQL:
        return "DATEPART(DD, " + fieldname + ")";
      case DatabaseUtils.FIREBIRD:
        return "EXTRACT(DAY FROM " + fieldname + ")";
      case DatabaseUtils.DAFFODILDB:
        return "DAYOFWEEK(" + fieldname + ")";
      case DatabaseUtils.ORACLE:
        return "EXTRACT(DAY FROM " + fieldname + ")";
      default:
        return "";
    }
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @return Description of the Return Value
   */
  public static String toLowerCase(Connection db) {
    switch (DatabaseUtils.getType(db)) {
      case DatabaseUtils.POSTGRESQL:
        return "lower";
      case DatabaseUtils.MSSQL:
        return "lower";
      case DatabaseUtils.ORACLE:
        return "lower";
      case DatabaseUtils.FIREBIRD:
        return "lower";
      case DatabaseUtils.DAFFODILDB:
        return "lcase";
      default:
        return "lower";
    }
  }


  /**
   * Description of the Method
   *
   * @param db    Description of the Parameter
   * @param field Description of the Parameter
   * @return Description of the Return Value
   */
  public static String toLowerCase(Connection db, String field) {
    switch (DatabaseUtils.getType(db)) {
      case DatabaseUtils.POSTGRESQL:
        return "lower(" + field + ")";
      case DatabaseUtils.MSSQL:
        return "lower(" + field + ")";
      case DatabaseUtils.ORACLE:
        return "lower(" + field + ")";
      case DatabaseUtils.FIREBIRD:
        return "lower(" + field + ")";
      case DatabaseUtils.DAFFODILDB:
        return "lcase(" + field + ")";
      default:
        return "lower(" + field + ")";
    }
  }


  /**
   * Gets the substring function for the given database
   *
   * @param db    Description of the Parameter
   * @param field Description of the Parameter
   * @param first Description of the Parameter
   * @param size  Description of the Parameter
   * @return The subString value
   */
  public static String getSubString(Connection db, String field, int first, int size) {
    switch (DatabaseUtils.getType(db)) {
      case DatabaseUtils.POSTGRESQL:
        return "substr(" + field + "," + first + (size < 0 ? "" : "," + size) + ") ";
      case DatabaseUtils.MSSQL:
        return "substring(" + field + "," + first + (size < 0 ? "" : "," + size) + ") ";
      case DatabaseUtils.ORACLE:
        return "substr(" + field + "," + first + (size < 0 ? "" : "," + size) + ") ";
      case DatabaseUtils.FIREBIRD:
        return "substr(" + field + " FROM " + first + (size < 0 ? "" : " FOR " + size) + " ) ";
      case DatabaseUtils.DAFFODILDB:
        return "substring(" + field + "," + first + (size < 0 ? "" : "," + size) + ") ";
      default:
        return "substr(" + field + "," + first + (size < 0 ? "" : "," + size) + ") ";
    }
  }


  /**
   * Description of the Method
   *
   * @param db    Description of the Parameter
   * @param field Description of the Parameter
   * @return Description of the Return Value
   */
  public static String convertToVarChar(Connection db, String field) {
    switch (DatabaseUtils.getType(db)) {
      case DatabaseUtils.POSTGRESQL:
        return field;
      case DatabaseUtils.MSSQL:
        return "CONVERT(VARCHAR(2000), " + field + ")";
      case DatabaseUtils.ORACLE:
        return "SUBSTR(" + field + ", 2000, 1)";
      case DatabaseUtils.FIREBIRD:
        return field;
      case DatabaseUtils.DAFFODILDB:
        // TODO: This doesn't work for DaffodilDB, so use a VARCHAR(4192) instead of CLOB
        return field;
      default:
        return field;
    }

  }


  /**
   * Description of the Method
   *
   * @param tmp          Description of the Parameter
   * @param defaultValue Description of the Parameter
   * @return Description of the Return Value
   */
  public static int parseInt(String tmp, int defaultValue) {
    try {
      return Integer.parseInt(tmp);
    } catch (Exception e) {
      return defaultValue;
    }
  }


  /**
   * Description of the Method
   *
   * @param tmp Description of the Parameter
   * @return Description of the Return Value
   */
  public static boolean parseBoolean(String tmp) {
    return ("ON".equalsIgnoreCase(tmp) ||
        "TRUE".equalsIgnoreCase(tmp) ||
        "1".equals(tmp) ||
        "Y".equalsIgnoreCase(tmp) ||
        "YES".equalsIgnoreCase(tmp));
  }


  /**
   * Description of the Method
   *
   * @param tmp Description of the Parameter
   * @return Description of the Return Value
   */
  public static java.sql.Date parseDate(String tmp) {
    java.sql.Date dateValue = null;
    try {
      java.util.Date tmpDate = DateFormat.getDateInstance(DateFormat.SHORT).parse(
          tmp);
      dateValue = new java.sql.Date(new java.util.Date().getTime());
      dateValue.setTime(tmpDate.getTime());
      return dateValue;
    } catch (Exception e) {
      try {
        return java.sql.Date.valueOf(tmp);
      } catch (Exception e2) {
      }
    }
    return null;
  }


  /**
   * Description of the Method
   *
   * @param tmp Description of the Parameter
   * @return Description of the Return Value
   */
  public static java.sql.Timestamp parseTimestamp(String tmp) {
    return parseTimestamp(tmp, Locale.getDefault());
  }


  /**
   * Description of the Method
   *
   * @param tmp    Description of the Parameter
   * @param locale Description of the Parameter
   * @return Description of the Return Value
   */
  public static java.sql.Timestamp parseTimestamp(String tmp, Locale locale) {
    java.sql.Timestamp timestampValue = null;
    try {
      java.util.Date tmpDate = DateFormat.getDateTimeInstance(
          DateFormat.SHORT, DateFormat.LONG, locale).parse(tmp);
      timestampValue = new java.sql.Timestamp(new java.util.Date().getTime());
      timestampValue.setTime(tmpDate.getTime());
      return timestampValue;
    } catch (Exception e) {
      try {
        return java.sql.Timestamp.valueOf(tmp);
      } catch (Exception e2) {
      }
    }
    return null;
  }


  /**
   * Description of the Method
   *
   * @param tmp Description of the Parameter
   * @return Description of the Return Value
   */
  public static java.sql.Timestamp parseDateToTimestamp(String tmp) {
    return parseDateToTimestamp(tmp, Locale.getDefault());
  }


  /**
   * Description of the Method
   *
   * @param tmp    Description of the Parameter
   * @param locale Description of the Parameter
   * @return Description of the Return Value
   */
  public static java.sql.Timestamp parseDateToTimestamp(String tmp, Locale locale) {
    java.sql.Timestamp timestampValue = DatabaseUtils.parseTimestamp(
        tmp, locale);
    if (timestampValue == null) {
      try {
        DateFormat tmpDateFormat = DateFormat.getDateInstance(
            DateFormat.SHORT, locale);
        tmpDateFormat.setLenient(false);
        java.util.Date tmpDate = tmpDateFormat.parse(tmp);
        timestampValue = new java.sql.Timestamp(System.currentTimeMillis());
        timestampValue.setTime(tmpDate.getTime());
        timestampValue.setNanos(0);
        return timestampValue;
      } catch (Exception e) {
      }
    }
    return timestampValue;
  }


  /**
   * Gets the int attribute of the DatabaseUtils class
   *
   * @param rs           Description of the Parameter
   * @param column       Description of the Parameter
   * @param defaultValue Description of the Parameter
   * @return The int value
   * @throws SQLException Description of the Exception
   */
  public static int getInt(ResultSet rs, String column, int defaultValue) throws SQLException {
    int fieldValue = rs.getInt(column);
    if (rs.wasNull()) {
      fieldValue = defaultValue;
    }
    return fieldValue;
  }


  /**
   * Gets the double attribute of the DatabaseUtils class
   *
   * @param rs           Description of the Parameter
   * @param column       Description of the Parameter
   * @param defaultValue Description of the Parameter
   * @return The double value
   * @throws SQLException Description of the Exception
   */
  public static double getDouble(ResultSet rs, String column, double defaultValue) throws SQLException {
    double fieldValue = rs.getDouble(column);
    if (rs.wasNull()) {
      fieldValue = defaultValue;
    }
    return fieldValue;
  }


  /**
   * Gets the int attribute of the DatabaseUtils class
   *
   * @param rs     Description of the Parameter
   * @param column Description of the Parameter
   * @return The int value
   * @throws SQLException Description of the Exception
   */
  public static int getInt(ResultSet rs, String column) throws SQLException {
    return DatabaseUtils.getInt(rs, column, -1);
  }


  /**
   * Gets the double attribute of the DatabaseUtils class
   *
   * @param rs     Description of the Parameter
   * @param column Description of the Parameter
   * @return The double value
   * @throws SQLException Description of the Exception
   */
  public static double getDouble(ResultSet rs, String column) throws SQLException {
    return DatabaseUtils.getDouble(rs, column, -1.0);
  }


  /**
   * Gets the long attribute of the DatabaseUtils class
   *
   * @param rs     Description of the Parameter
   * @param column Description of the Parameter
   * @return The long value
   * @throws SQLException Description of the Exception
   */
  public static long getLong(ResultSet rs, String column) throws SQLException {
    return DatabaseUtils.getLong(rs, column, -1);
  }


  /**
   * Gets the long attribute of the DatabaseUtils class
   *
   * @param rs           Description of the Parameter
   * @param column       Description of the Parameter
   * @param defaultValue Description of the Parameter
   * @return The long value
   * @throws SQLException Description of the Exception
   */
  public static long getLong(ResultSet rs, String column, long defaultValue) throws SQLException {
    long fieldValue = rs.getLong(column);
    if (rs.wasNull()) {
      fieldValue = defaultValue;
    }
    return fieldValue;
  }


  /**
   * Sets the int attribute of the DatabaseUtils class
   *
   * @param pst        The new int value
   * @param paramCount The new int value
   * @param value      The new int value
   * @throws SQLException Description of the Exception
   */
  public static void setInt(PreparedStatement pst, int paramCount, int value) throws SQLException {
    if (value == -1) {
      pst.setNull(paramCount, java.sql.Types.INTEGER);
    } else {
      pst.setInt(paramCount, value);
    }
  }


  /**
   * Sets the double attribute of the DatabaseUtils class
   *
   * @param pst        The new double value
   * @param paramCount The new double value
   * @param value      The new double value
   * @throws SQLException Description of the Exception
   */
  public static void setDouble(PreparedStatement pst, int paramCount, double value) throws SQLException {
    if (value == -1.0) {
      pst.setNull(paramCount, java.sql.Types.DOUBLE);
    } else {
      pst.setDouble(paramCount, value);
    }
  }


  /**
   * Sets the long attribute of the DatabaseUtils class
   *
   * @param pst        The new long value
   * @param paramCount The new long value
   * @param value      The new long value
   * @throws SQLException Description of the Exception
   */
  public static void setLong(PreparedStatement pst, int paramCount, long value) throws SQLException {
    if (value == -1) {
      pst.setNull(paramCount, java.sql.Types.INTEGER);
    } else {
      pst.setLong(paramCount, value);
    }
  }


  /**
   * Sets the timestamp attribute of the DatabaseUtils class
   *
   * @param pst        The new timestamp value
   * @param paramCount The new timestamp value
   * @param value      The new timestamp value
   * @throws SQLException Description of the Exception
   */
  public static void setTimestamp(PreparedStatement pst, int paramCount, java.sql.Timestamp value) throws SQLException {
    if (value == null) {
      pst.setNull(paramCount, java.sql.Types.DATE);
    } else {
      pst.setTimestamp(paramCount, value);
    }
  }


  /**
   * Sets the date attribute of the DatabaseUtils class
   *
   * @param pst        The new date value
   * @param paramCount The new date value
   * @param value      The new date value
   * @throws SQLException Description of the Exception
   */
  public static void setDate(PreparedStatement pst, int paramCount, java.sql.Date value) throws SQLException {
    if (value == null) {
      pst.setNull(paramCount, java.sql.Types.DATE);
    } else {
      pst.setDate(paramCount, value);
    }
  }


  /**
   * Reads in a text file of SQL statements from the filesystem, and executes
   * them
   *
   * @param db       Description of the Parameter
   * @param filename Description of the Parameter
   * @throws SQLException Description of the Exception
   * @throws IOException  Description of the Exception
   */
  public static void executeSQL(Connection db, String filename) throws SQLException, IOException {
    BufferedReader in = new BufferedReader(new FileReader(filename));
    executeSQL(db, in);
    in.close();
  }


  /**
   * Reads in a text file of SQL statements from the servlet context, and
   * executes them
   *
   * @param db       Description of the Parameter
   * @param context  Description of the Parameter
   * @param filename Description of the Parameter
   * @throws SQLException Description of the Exception
   * @throws IOException  Description of the Exception
   */
  public static void executeSQL(Connection db, ServletContext context, String filename) throws SQLException, IOException {
    InputStream source = context.getResourceAsStream(filename);
    BufferedReader in = new BufferedReader(new InputStreamReader(source));
    executeSQL(db, in);
    in.close();
  }


  /**
   * Description of the Method
   *
   * @param db Description of the Parameter
   * @param in Description of the Parameter
   * @throws SQLException Description of the Exception
   * @throws IOException  Description of the Exception
   */
  public static void executeSQL(Connection db, BufferedReader in) throws SQLException, IOException {
    // Read the file and execute each statement
    StringBuffer sql = new StringBuffer();
    String line = null;
    Statement st = db.createStatement();
    int tCount = 0;
    int lineCount = 0;
    while ((line = in.readLine()) != null) {
      ++lineCount;
      // SQL Comment
      if (line.startsWith("//")) {
        continue;
      }
      // SQL Comment
      if (line.startsWith("--")) {
        continue;
      }
      sql.append(line);
      // check for delimiter
      if (line.endsWith(";")) {
        // Got a transaction, so execute it
        ++tCount;
        try {
          st.execute(sql.substring(0, sql.length() - 1));
        } catch (SQLException e) {
          System.out.println(
              "DatabaseUtils-> ERROR(1), line: " + lineCount + " message: " + e.getMessage());
          throw new SQLException(e.getMessage());
        }
        sql.setLength(0);
      } else if (line.equals("GO")) {
        // Got a transaction, so execute it
        ++tCount;
        try {
          st.execute(sql.substring(0, sql.length() - 2));
        } catch (SQLException e) {
          System.out.println(
              "DatabaseUtils-> ERROR(2), line: " + lineCount + " message: " + e.getMessage());
          throw new SQLException(e.getMessage());
        }
        sql.setLength(0);
      } else {
        // Continue with another line
        sql.append(CRLF);
      }
    }
    // Statement didn't end with a delimiter
    if (sql.toString().trim().length() > 0 && !CRLF.equals(
        sql.toString().trim())) {
      ++tCount;
      try {
        st.execute(sql.toString());
      } catch (SQLException e) {
        System.out.println(
            "DatabaseUtils-> ERROR(3), line: " + lineCount + " message: " + e.getMessage());
        throw new SQLException(e.getMessage());
      }
    }
    st.close();
    if (System.getProperty("DEBUG") != null) {
      System.out.println("Executed " + tCount + " total statements");
    }
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @param db      Description of the Parameter
   */
  public static void renewConnection(ActionContext context, Connection db) {
    //Connections are usually checked out and expire, this will renew the expiration
    //time
    if (db != null) {
      ConnectionPool sqlDriver = (ConnectionPool) context.getServletContext().getAttribute(
          "ConnectionPool");
      if (sqlDriver != null) {
        sqlDriver.renew(db);
      }
    }
  }
}

