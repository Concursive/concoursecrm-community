//Copyright 2001 Dark Horse Ventures
package com.darkhorseventures.cfsbase;

import java.sql.*;

public class OpportunityNote extends Note {

  public OpportunityNote() {
    isContact = false;
    isOrg = false;
  }


  public OpportunityNote(ResultSet rs) throws SQLException {
    isContact = false;
    isOrg = false;
    buildRecord(rs);
  }


  public OpportunityNote(Connection db, String noteId) throws SQLException {
    isContact = false;
    isOrg = false;
    if (noteId == null) {
      throw new SQLException("Note ID not specified.");
    }

    Statement st = null;
    ResultSet rs = null;
    StringBuffer sql = new StringBuffer();
    sql.append("SELECT * " +
        "FROM note " +
        "WHERE id = " + noteId + " ");
	
    st = db.createStatement();
    rs = st.executeQuery(sql.toString());
    if (rs.next()) {
      buildRecord(rs);
    } else {
      rs.close();
      st.close();
      throw new SQLException("Note record not found.");
    }
    rs.close();
    st.close();
  }


  /**
   *  Determines what to do if this record is marked for INSERT, UPDATE, or
   *  DELETE
   *
   *@param  db                Description of Parameter
   *@param  orgId         Description of Parameter
   *@param  enteredBy         Description of Parameter
   *@param  modifiedBy        Description of Parameter
   *@exception  SQLException  Description of Exception
   *@since
   */
  public void process(Connection db, int oppId, int enteredBy, int modifiedBy) throws SQLException {
    if (this.getEnabled() == true) {
      if (this.getId() == -1) {
        this.insert(db, oppId, enteredBy);
      } else {
        this.update(db, modifiedBy);
      }
    } else {
      this.delete(db);
    }
  }


  public void insert(Connection db, int oppId, int enteredBy) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "INSERT INTO note " +
        "(org_id, contact_id, opp_id, subject, body, enteredby, modifiedby) " +
        "VALUES " +
        "(?, ?, ?, ?, ?, ?, ?) ");
    int i = 0;
    pst.setInt(++i, this.getOrgId());
    pst.setInt(++i, this.getContactId());
    pst.setInt(++i, oppId);
    pst.setString(++i, this.getSubject());
    pst.setString(++i, this.getBody());
    pst.setInt(++i, enteredBy);
    pst.setInt(++i, enteredBy);
    pst.execute();
    pst.close();

    Statement st = db.createStatement();
    ResultSet rs = st.executeQuery("select currval('note_id_seq')");
    
    
    if (rs.next()) {
     
      this.setId(rs.getInt(1));
            System.out.println("here I am " + ("" + this.getId()));
    }
    rs.close();
    st.close();
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@param  modifiedBy        Description of Parameter
   *@exception  SQLException  Description of Exception
   *@since
   */
   
  public void update(Connection db, int modifiedBy) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "UPDATE note " +
        "SET body = ?, subject = ?, modifiedby = ? " +
        "WHERE id = ? ");
    int i = 0;
    pst.setString(++i, this.getBody());
    pst.setString(++i, this.getSubject());
    pst.setInt(++i, modifiedBy);
    pst.setInt(++i, this.getId());
    pst.execute();
    pst.close();
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@exception  SQLException  Description of Exception
   *@since
   */
  public void delete(Connection db) throws SQLException {
    PreparedStatement pst = db.prepareStatement(
        "DELETE FROM note " +
        "WHERE id = ? ");
    int i = 0;
    pst.setInt(++i, this.getId());
    pst.execute();
    pst.close();
  }

}

