import java.sql.*;
import com.darkhorseventures.utils.ConnectionPool;

/**
 *  Description of the Class
 *
 *@author     mrajkowski
 *@created    July 10, 2001
 */
public class TestDB {

  private int runningConnections = 0;  
  private int connectionsToExecute = 0;
  
  /**
   *  Constructor for the TestDB object
   *
   *@since
   */
  public TestDB() {
  }


  /**
   *  Description of the Method
   *
   *@since
   */
  public synchronized void runTests() {
    java.util.Date startDate = new java.util.Date();
    long startMs = System.currentTimeMillis();
    ConnectionPool sqlDriver = null;
    System.out.println("Starting...");
    int recordCount = 0;
    try {
      sqlDriver = new ConnectionPool();
    } catch (SQLException e) {
    }
    Connection db = null;
    try {
      sqlDriver.setForceClose(false);
      sqlDriver.setMaxConnections(5);
       //Test a single connection
       db = sqlDriver.getConnection(
           "jdbc:postgresql://12.101.73.29:5432/cdb_ds22", "postgres", "");
       PreparedStatement pst = db.prepareStatement(
         "SELECT COUNT(*) AS contactcount FROM contact WHERE type_id not in (?) and namelast < ?");
       pst.setInt(1, 0);
       pst.setString(2, "b");
 
       ResultSet rs = pst.executeQuery();
       if (rs.next()) {
         System.out.println("Records: " + rs.getInt("contactcount"));
       }
       rs.close();
       pst.close();
       sqlDriver.free(db);       
      
      if (1==1) { return; }
      
      connectionsToExecute = 50;
      for (int i = 0; i < connectionsToExecute; i++) {
        ConnectionThread p = new ConnectionThread("cdb_ds21", sqlDriver, i, "D");
        p.start();
        
        ConnectionThread q = new ConnectionThread("cdb_ds21", sqlDriver, i, "B");
        q.start();
        
//        ConnectionThread r = new ConnectionThread("cdb_ds21", sqlDriver, i, "C");
//        r.start();
         
/*         ConnectionThread s = new ConnectionThread("cdb_dhv", sqlDriver, i, "A");
        s.start();*/ 
      }

      wait();
      while (runningConnections != 0) {
          
      }
      System.out.println("Thead loop complete: 100 connections and queries");
      System.out.println(sqlDriver.toString());

    } catch (SQLException e) {
      System.out.println("Error: " + e.toString());
    } catch (java.lang.InterruptedException ie) {
      System.out.println("IE: " + ie.toString());
    }
    sqlDriver.destroy();
    sqlDriver = null;
    java.util.Date endDate = new java.util.Date();
    long endMs = System.currentTimeMillis();
    System.out.println("Start : " + startDate.toString());
    System.out.println("End   : " + endDate.toString());
    System.out.println("Millis: " + (endMs - startMs) + "ms");
  }


  /**
   *  Description of the Method
   *
   *@since
   */
  public synchronized void endThreads() {
    notifyAll();
  }


  /**
   *  The main program for the TestDB class
   *
   *@param  args  The command line arguments
   *@since
   */
  public static void main(String[] args) {
    TestDB thisApp = new TestDB();
    thisApp.runTests();
    System.exit(0);
  }


  /**
   *  Description of the Class
   *
   *@author     mrajkowski
   *@created    July 10, 2001
   */
  class ConnectionThread extends Thread {

    private ConnectionPool sqlDriver;
    private String database;
    private int count = 0;
    private String item = null;


    ConnectionThread(String tmp, ConnectionPool sqlDriver, int runCount, String item) {
      this.database = tmp;
      this.sqlDriver = sqlDriver;
      this.count = runCount;
      this.item = item;
    }


    /**
     *  Main processing method for the ConnectionThread object
     *
     *@since
     */
    public void run() {
      try {
        ++runningConnections;
        Connection db = sqlDriver.getConnection(
            "jdbc:postgresql://12.101.73.29:5432/" + this.database, "postgres", "");
        Statement st = db.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM EMPLOYEE");
        while (rs.next()) {
          
        }
        rs.close();
        st.close();
/*         try {
*           this.sleep(50);
*         } catch (InterruptedException e) {
*         } */
        sqlDriver.free(db);
        --runningConnections;
        if (this.count == (connectionsToExecute - 1) && this.item.equals("D")) {
          endThreads();
        }
      } catch (SQLException e) {
      }
    }

  }

}

