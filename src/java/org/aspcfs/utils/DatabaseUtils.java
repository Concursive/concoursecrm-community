/*
 *  Developed in partnership with Matt Rajkowski
 */
package org.aspcfs.utils;

import java.sql.*;
import java.text.*;
import java.util.*;
import java.io.*;
import javax.servlet.ServletContext;

/**
 *  Useful methods for working with multiple databases and database fields
 *
 *@author     matt rajkowski
 *@created    March 18, 2002
 *@version    $Id: DatabaseUtils.java,v 1.13 2002/11/04 13:21:16 mrajkowski Exp
 *      $
 */
public class DatabaseUtils {

  public final static int POSTGRESQL = 1;
  public final static int MSSQL = 2;
  public final static int ORACLE = 3;

  public final static String CRLF = System.getProperty("line.separator");


  /**
   *  Gets the true attribute of the DatabaseUtils class
   *
   *@param  db  Description of Parameter
   *@return     The true value
   */
  public static String getTrue(Connection db) {
    switch (DatabaseUtils.getType(db)) {
        case DatabaseUtils.POSTGRESQL:
          return "true";
        case DatabaseUtils.MSSQL:
          return "1";
        case DatabaseUtils.ORACLE:
          return "true";
        default:
          return "true";
    }
  }


  /**
   *  Gets the false attribute of the DatabaseUtils class
   *
   *@param  db  Description of Parameter
   *@return     The false value
   */
  public static String getFalse(Connection db) {
    switch (DatabaseUtils.getType(db)) {
        case DatabaseUtils.POSTGRESQL:
          return "false";
        case DatabaseUtils.MSSQL:
          return "0";
        case DatabaseUtils.ORACLE:
          return "false";
        default:
          return "false";
    }
  }


  /**
   *  Gets the currentTimestamp attribute of the DatabaseUtils class
   *
   *@param  db  Description of Parameter
   *@return     The currentTimestamp value
   */
  public static String getCurrentTimestamp(Connection db) {
    switch (DatabaseUtils.getType(db)) {
        case DatabaseUtils.POSTGRESQL:
          return "CURRENT_TIMESTAMP";
        case DatabaseUtils.MSSQL:
          return "CURRENT_TIMESTAMP";
        case DatabaseUtils.ORACLE:
          return "CURRENT_TIMESTAMP";
        default:
          return "CURRENT_TIMESTAMP";
    }
  }


  /**
   *  Gets the type attribute of the DatabaseUtils class
   *
   *@param  db  Description of Parameter
   *@return     The type value
   */
  public static int getType(Connection db) {
    String databaseName = db.getClass().getName();
    if (databaseName.indexOf("postgresql") > -1) {
      return POSTGRESQL;
    } else if ("net.sourceforge.jtds.jdbc.ConnectionJDBC3".equals(databaseName)) {
      return MSSQL;
    } else if ("net.sourceforge.jtds.jdbc.TdsConnectionJDBC3".equals(databaseName)) {
      return MSSQL;
    } else if (databaseName.indexOf("sqlserver") > -1) {
      return MSSQL;
    } else if ("net.sourceforge.jtds.jdbc.TdsConnection".equals(databaseName)) {
      return MSSQL;
    } else if (databaseName.indexOf("oracle") > -1) {
      return ORACLE;
    } else {
      System.out.println("DatabaseUtils-> Driver: " + databaseName);
      return -1;
    }
  }


  /**
   *  Description of the Method
   *
   *@param  db    Description of the Parameter
   *@param  date  Description of the Parameter
   *@return       Description of the Return Value
   */
  public static String castDateTimeToDate(Connection db, String date) {
    switch (DatabaseUtils.getType(db)) {
        case DatabaseUtils.POSTGRESQL:
          return (date + "::date");
        case DatabaseUtils.MSSQL:
          return ("CONVERT(char(10), " + date + ", 101)");
        default:
          return "";
    }
  }


  /**
   *  Gets the currVal attribute of the DatabaseUtils class
   *
   *@param  db                Description of the Parameter
   *@param  sequenceName      Description of the Parameter
   *@return                   The currVal value
   *@exception  SQLException  Description of the Exception
   */
  public static int getCurrVal(Connection db, String sequenceName) throws SQLException {
    int id = -1;
    Statement st = db.createStatement();
    ResultSet rs = null;
    switch (DatabaseUtils.getType(db)) {
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
   *  Useful when generating a SQL order by clause to sort by year for the given
   *  timestamp field
   *
   *@param  db         Description of the Parameter
   *@param  fieldname  Description of the Parameter
   *@return            The yearPart value
   */
  public static String getYearPart(Connection db, String fieldname) {
    switch (DatabaseUtils.getType(db)) {
        case DatabaseUtils.POSTGRESQL:
          return "date_part('year', " + fieldname + ")";
        case DatabaseUtils.MSSQL:
          return "DATEPART(YY, " + fieldname + ")";
        case DatabaseUtils.ORACLE:
          return "";
        default:
          return "";
    }
  }


  /**
   *  Useful when generating a SQL order by clause to sort by month for the
   *  given timestamp field
   *
   *@param  db         Description of the Parameter
   *@param  fieldname  Description of the Parameter
   *@return            The orderByMonth value
   */
  public static String getMonthPart(Connection db, String fieldname) {
    switch (DatabaseUtils.getType(db)) {
        case DatabaseUtils.POSTGRESQL:
          return "date_part('month', " + fieldname + ")";
        case DatabaseUtils.MSSQL:
          return "DATEPART(MM, " + fieldname + ")";
        case DatabaseUtils.ORACLE:
          return "";
        default:
          return "";
    }
  }


  /**
   *  Useful when generating a SQL order by clause to sort by day for the given
   *  timestamp field
   *
   *@param  db         Description of the Parameter
   *@param  fieldname  Description of the Parameter
   *@return            The orderByDay value
   */
  public static String getDayPart(Connection db, String fieldname) {
    switch (DatabaseUtils.getType(db)) {
        case DatabaseUtils.POSTGRESQL:
          return "date_part('day', " + fieldname + ")";
        case DatabaseUtils.MSSQL:
          return "DATEPART(DD, " + fieldname + ")";
        case DatabaseUtils.ORACLE:
          return "";
        default:
          return "";
    }
  }


  /**
   *  Description of the Method
   *
   *@param  tmp           Description of the Parameter
   *@param  defaultValue  Description of the Parameter
   *@return               Description of the Return Value
   */
  public static int parseInt(String tmp, int defaultValue) {
    try {
      return Integer.parseInt(tmp);
    } catch (Exception e) {
      return defaultValue;
    }
  }


  /**
   *  Description of the Method
   *
   *@param  tmp  Description of the Parameter
   *@return      Description of the Return Value
   */
  public static boolean parseBoolean(String tmp) {
    return ("ON".equalsIgnoreCase(tmp) ||
        "TRUE".equalsIgnoreCase(tmp) ||
        "1".equals(tmp) ||
        "Y".equalsIgnoreCase(tmp));
  }


  /**
   *  Description of the Method
   *
   *@param  tmp  Description of the Parameter
   *@return      Description of the Return Value
   */
  public static java.sql.Date parseDate(String tmp) {
    java.sql.Date dateValue = null;
    try {
      java.util.Date tmpDate = DateFormat.getDateInstance(DateFormat.SHORT).parse(tmp);
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
   *  Description of the Method
   *
   *@param  tmp  Description of the Parameter
   *@return      Description of the Return Value
   */
  public static java.sql.Timestamp parseTimestamp(String tmp) {
    return parseTimestamp(tmp, Locale.getDefault());
  }


  /**
   *  Description of the Method
   *
   *@param  tmp     Description of the Parameter
   *@param  locale  Description of the Parameter
   *@return         Description of the Return Value
   */
  public static java.sql.Timestamp parseTimestamp(String tmp, Locale locale) {
    java.sql.Timestamp timestampValue = null;
    try {
      java.util.Date tmpDate = DateFormat.getDateTimeInstance(DateFormat.SHORT, DateFormat.LONG, locale).parse(tmp);
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
   *  Description of the Method
   *
   *@param  tmp  Description of the Parameter
   *@return      Description of the Return Value
   */
  public static java.sql.Timestamp parseDateToTimestamp(String tmp) {
    return parseDateToTimestamp(tmp, Locale.getDefault());
  }


  /**
   *  Description of the Method
   *
   *@param  tmp     Description of the Parameter
   *@param  locale  Description of the Parameter
   *@return         Description of the Return Value
   */
  public static java.sql.Timestamp parseDateToTimestamp(String tmp, Locale locale) {
    java.sql.Timestamp timestampValue = DatabaseUtils.parseTimestamp(tmp, locale);
    if (timestampValue == null) {
      try {
        DateFormat tmpDateFormat = DateFormat.getDateInstance(DateFormat.SHORT, locale);
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
   *  Gets the int attribute of the DatabaseUtils class
   *
   *@param  rs                Description of the Parameter
   *@param  column            Description of the Parameter
   *@param  defaultValue      Description of the Parameter
   *@return                   The int value
   *@exception  SQLException  Description of the Exception
   */
  public static int getInt(ResultSet rs, String column, int defaultValue) throws SQLException {
    int fieldValue = rs.getInt(column);
    if (rs.wasNull()) {
      fieldValue = defaultValue;
    }
    return fieldValue;
  }


  /**
   *  Gets the double attribute of the DatabaseUtils class
   *
   *@param  rs                Description of the Parameter
   *@param  column            Description of the Parameter
   *@param  defaultValue      Description of the Parameter
   *@return                   The double value
   *@exception  SQLException  Description of the Exception
   */
  public static double getDouble(ResultSet rs, String column, double defaultValue) throws SQLException {
    double fieldValue = rs.getDouble(column);
    if (rs.wasNull()) {
      fieldValue = defaultValue;
    }
    return fieldValue;
  }


  /**
   *  Gets the int attribute of the DatabaseUtils class
   *
   *@param  rs                Description of the Parameter
   *@param  column            Description of the Parameter
   *@return                   The int value
   *@exception  SQLException  Description of the Exception
   */
  public static int getInt(ResultSet rs, String column) throws SQLException {
    return DatabaseUtils.getInt(rs, column, -1);
  }


  /**
   *  Gets the double attribute of the DatabaseUtils class
   *
   *@param  rs                Description of the Parameter
   *@param  column            Description of the Parameter
   *@return                   The double value
   *@exception  SQLException  Description of the Exception
   */
  public static double getDouble(ResultSet rs, String column) throws SQLException {
    return DatabaseUtils.getDouble(rs, column, -1.0);
  }


  /**
   *  Gets the long attribute of the DatabaseUtils class
   *
   *@param  rs                Description of the Parameter
   *@param  column            Description of the Parameter
   *@return                   The long value
   *@exception  SQLException  Description of the Exception
   */
  public static long getLong(ResultSet rs, String column) throws SQLException {
    return DatabaseUtils.getLong(rs, column, -1);
  }


  /**
   *  Gets the long attribute of the DatabaseUtils class
   *
   *@param  rs                Description of the Parameter
   *@param  column            Description of the Parameter
   *@param  defaultValue      Description of the Parameter
   *@return                   The long value
   *@exception  SQLException  Description of the Exception
   */
  public static long getLong(ResultSet rs, String column, long defaultValue) throws SQLException {
    long fieldValue = rs.getLong(column);
    if (rs.wasNull()) {
      fieldValue = defaultValue;
    }
    return fieldValue;
  }


  /**
   *  Sets the int attribute of the DatabaseUtils class
   *
   *@param  pst               The new int value
   *@param  paramCount        The new int value
   *@param  value             The new int value
   *@exception  SQLException  Description of the Exception
   */
  public static void setInt(PreparedStatement pst, int paramCount, int value) throws SQLException {
    if (value == -1) {
      pst.setNull(paramCount, java.sql.Types.INTEGER);
    } else {
      pst.setInt(paramCount, value);
    }
  }


  /**
   *  Sets the double attribute of the DatabaseUtils class
   *
   *@param  pst               The new double value
   *@param  paramCount        The new double value
   *@param  value             The new double value
   *@exception  SQLException  Description of the Exception
   */
  public static void setDouble(PreparedStatement pst, int paramCount, double value) throws SQLException {
    if (value == -1.0) {
      pst.setNull(paramCount, java.sql.Types.DOUBLE);
    } else {
      pst.setDouble(paramCount, value);
    }
  }


  /**
   *  Sets the long attribute of the DatabaseUtils class
   *
   *@param  pst               The new long value
   *@param  paramCount        The new long value
   *@param  value             The new long value
   *@exception  SQLException  Description of the Exception
   */
  public static void setLong(PreparedStatement pst, int paramCount, long value) throws SQLException {
    if (value == -1) {
      pst.setNull(paramCount, java.sql.Types.INTEGER);
    } else {
      pst.setLong(paramCount, value);
    }
  }


  /**
   *  Sets the timestamp attribute of the DatabaseUtils class
   *
   *@param  pst               The new timestamp value
   *@param  paramCount        The new timestamp value
   *@param  value             The new timestamp value
   *@exception  SQLException  Description of the Exception
   */
  public static void setTimestamp(PreparedStatement pst, int paramCount, java.sql.Timestamp value) throws SQLException {
    if (value == null) {
      pst.setNull(paramCount, java.sql.Types.DATE);
    } else {
      pst.setTimestamp(paramCount, value);
    }
  }


  /**
   *  Sets the date attribute of the DatabaseUtils class
   *
   *@param  pst               The new date value
   *@param  paramCount        The new date value
   *@param  value             The new date value
   *@exception  SQLException  Description of the Exception
   */
  public static void setDate(PreparedStatement pst, int paramCount, java.sql.Date value) throws SQLException {
    if (value == null) {
      pst.setNull(paramCount, java.sql.Types.DATE);
    } else {
      pst.setDate(paramCount, value);
    }
  }


  /**
   *  Reads in a text file of SQL statements from the filesystem, and executes
   *  them
   *
   *@param  db                Description of the Parameter
   *@param  filename          Description of the Parameter
   *@exception  SQLException  Description of the Exception
   *@exception  IOException   Description of the Exception
   */
  public static void executeSQL(Connection db, String filename) throws SQLException, IOException {
    BufferedReader in = new BufferedReader(new FileReader(filename));
    executeSQL(db, in);
    in.close();
  }


  /**
   *  Reads in a text file of SQL statements from the servlet context, and
   *  executes them
   *
   *@param  db                Description of the Parameter
   *@param  context           Description of the Parameter
   *@param  filename          Description of the Parameter
   *@exception  SQLException  Description of the Exception
   *@exception  IOException   Description of the Exception
   */
  public static void executeSQL(Connection db, ServletContext context, String filename) throws SQLException, IOException {
    InputStream source = context.getResourceAsStream(filename);
    BufferedReader in = new BufferedReader(new InputStreamReader(source));
    executeSQL(db, in);
    in.close();
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of the Parameter
   *@param  in                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   *@exception  IOException   Description of the Exception
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
          System.out.println("DatabaseUtils-> ERROR(1), line: " + lineCount + " message: " + e.getMessage());
          throw new SQLException(e.getMessage());
        }
        sql.setLength(0);
      } else if (line.equals("GO")) {
        // Got a transaction, so execute it
        ++tCount;
        try {
          st.execute(sql.substring(0, sql.length() - 2));
        } catch (SQLException e) {
          System.out.println("DatabaseUtils-> ERROR(2), line: " + lineCount + " message: " + e.getMessage());
          throw new SQLException(e.getMessage());
        }
        sql.setLength(0);
      } else {
        // Continue with another line
        sql.append(CRLF);
      }
    }
    // Statement didn't end with a delimiter
    if (sql.toString().trim().length() > 0 && !CRLF.equals(sql.toString().trim())) {
      ++tCount;
      try {
        st.execute(sql.toString());
      } catch (SQLException e) {
        System.out.println("DatabaseUtils-> ERROR(3), line: " + lineCount + " message: " + e.getMessage());
        throw new SQLException(e.getMessage());
      }
    }
    st.close();
    if (System.getProperty("DEBUG") != null) {
      System.out.println("Executed " + tCount + " total statements");
    }
  }
}

