//Copyright 2001 Dark Horse Ventures

package org.aspcfs.modules.base;

import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
import org.aspcfs.utils.DateUtils;
import java.util.Locale;

/**
 *  Represents a mailing address to be used as a base class.
 *
 *@author     mrajkowski
 *@created    July 11, 2001
 *@version    $Id$
 */
public class Address {

  protected boolean isContact = false;
  private int id = -1;
  private int orgId = -1;
  private int contactId = -1;
  private String streetAddressLine1 = "";
  private String streetAddressLine2 = "";
  private String streetAddressLine3 = "";
  private String city = null;
  private String state = null;
  private String otherState = null;
  private String zip = null;
  private String country = null;
  private int type = -1;
  private String typeName = null;
  private int enteredBy = -1;
  private int modifiedBy = -1;
  private boolean enabled = true;
  private java.sql.Timestamp entered = null;
  private java.sql.Timestamp modified = null;


  /**
   *  Sets the Id attribute of the Address object
   *
   *@param  tmp  The new Id value
   *@since       1.1
   */
  public void setId(int tmp) {
    this.id = tmp;
  }


  /**
   *  Sets the enabled attribute of the Address object
   *
   *@param  tmp  The new enabled value
   */
  public void setEnabled(String tmp) {
    enabled = ("on".equalsIgnoreCase(tmp) || "true".equalsIgnoreCase(tmp));
  }


  /**
   *  Sets the Id attribute of the Address object
   *
   *@param  tmp  The new Id value
   *@since       1.8
   */
  public void setId(String tmp) {
    this.id = Integer.parseInt(tmp);
  }


  /**
   *  Sets the OrgId attribute of the Address object
   *
   *@param  orgId  The new OrgId value
   *@since         1.6
   */
  public void setOrgId(int orgId) {
    this.orgId = orgId;
  }


  /**
   *  Sets the orgId attribute of the Address object
   *
   *@param  orgId  The new orgId value
   */
  public void setOrgId(String orgId) {
    this.orgId = Integer.parseInt(orgId);
  }


  /**
   *  Sets the ContactId attribute of the Address object
   *
   *@param  tmp  The new ContactId value
   *@since       1.8
   */
  public void setContactId(int tmp) {
    this.contactId = tmp;
  }


  /**
   *  Sets the contactId attribute of the Address object
   *
   *@param  tmp  The new contactId value
   */
  public void setContactId(String tmp) {
    this.contactId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the streetAddressLine3 attribute of the Address object
   *
   *@param  streetAddressLine3  The new streetAddressLine3 value
   */
  public void setStreetAddressLine3(String streetAddressLine3) {
    this.streetAddressLine3 = streetAddressLine3;
  }


  /**
   *  Sets the otherState attribute of the Address object
   *
   *@param  tmp         The new otherState value
   */
  public void setOtherState(String tmp) {
    if (tmp != null) {
      if (tmp.length() == 0) {
        this.otherState = null;
      } else {
        this.otherState = tmp;
      }
    }
  }


  /**
   *  Gets the otherState attribute of the Address object
   *
   *@return    The otherState value
   */
  public String getOtherState() {
    return otherState;
  }


  /**
   *  Gets the streetAddressLine3 attribute of the Address object
   *
   *@return    The streetAddressLine3 value
   */
  public String getStreetAddressLine3() {
    return streetAddressLine3;
  }


  /**
   *  Gets the contactId attribute of the Address object
   *
   *@return    The contactId value
   */
  public int getContactId() {
    return contactId;
  }


  /**
   *  Sets the StreetAddressLine1 attribute of the Address object
   *
   *@param  tmp  The new StreetAddressLine1 value
   *@since       1.5
   */
  public void setStreetAddressLine1(String tmp) {
    this.streetAddressLine1 = tmp;
  }


  /**
   *  Sets the StreetAddressLine2 attribute of the Address object
   *
   *@param  tmp  The new StreetAddressLine2 value
   *@since       1.5
   */
  public void setStreetAddressLine2(String tmp) {
    this.streetAddressLine2 = tmp;
  }


  /**
   *  Sets the City attribute of the Address object
   *
   *@param  tmp  The new City value
   *@since       1.5
   */
  public void setCity(String tmp) {
    this.city = tmp;
  }


  /**
   *  Sets the State attribute of the Address object
   *
   *@param  tmp  The new State value
   *@since       1.5
   */
  public void setState(String tmp) {
    if (tmp != null) {
      if (tmp.length() == 0) {
        this.state = null;
      } else {
        this.state = tmp;
      }
    }
  }


  /**
   *  Sets the Zip attribute of the Address object
   *
   *@param  tmp  The new Zip value
   *@since       1.5
   */
  public void setZip(String tmp) {
    this.zip = tmp;
  }


  /**
   *  Sets the Country attribute of the Address object
   *
   *@param  tmp  The new Country value
   *@since       1.5
   */
  public void setCountry(String tmp) {
    this.country = tmp;
  }


  /**
   *  Sets the Type attribute of the Address object, for example: Home, Work,
   *  Billing, etc.
   *
   *@param  tmp  The new Type value
   *@since       1.6
   */
  public void setType(int tmp) {
    this.type = tmp;
  }


  /**
   *  Sets the Type attribute of the Address object
   *
   *@param  tmp  The new Type value
   *@since       1.8
   */
  public void setType(String tmp) {
    this.type = Integer.parseInt(tmp);
  }


  /**
   *  Sets the TypeName attribute of the Address object
   *
   *@param  tmp  The new TypeName value
   *@since       1.6
   */
  public void setTypeName(String tmp) {
    this.typeName = tmp;
  }


  /**
   *  Sets the EnteredBy attribute of the Address object
   *
   *@param  tmp  The new EnteredBy value
   *@since       1.6
   */
  public void setEnteredBy(int tmp) {
    this.enteredBy = tmp;
  }


  /**
   *  Sets the enteredBy attribute of the Address object
   *
   *@param  tmp  The new enteredBy value
   */
  public void setEnteredBy(String tmp) {
    this.enteredBy = Integer.parseInt(tmp);
  }


  /**
   *  Sets the ModifiedBy attribute of the Address object
   *
   *@param  tmp  The new ModifiedBy value
   *@since       1.6
   */
  public void setModifiedBy(int tmp) {
    this.modifiedBy = tmp;
  }


  /**
   *  Sets the modifiedBy attribute of the Address object
   *
   *@param  tmp  The new modifiedBy value
   */
  public void setModifiedBy(String tmp) {
    this.modifiedBy = Integer.parseInt(tmp);
  }


  /**
   *  Sets the Enabled attribute of the Address object
   *
   *@param  tmp  The new Enabled value
   *@since       1.8
   */
  public void setEnabled(boolean tmp) {
    this.enabled = tmp;
  }


  /**
   *  Gets the Id attribute of the Address object
   *
   *@return    The Id value
   *@since     1.6
   */
  public int getId() {
    return id;
  }


  /**
   *  Gets the OrgId attribute of the Address object
   *
   *@return    The OrgId value
   *@since     1.6
   */
  public int getOrgId() {
    return orgId;
  }


  /**
   *  Gets the entered attribute of the Address object
   *
   *@return    The entered value
   */
  public java.sql.Timestamp getEntered() {
    return entered;
  }


  /**
   *  Gets the modified attribute of the Address object
   *
   *@return    The modified value
   */
  public java.sql.Timestamp getModified() {
    return modified;
  }


  /**
   *  Gets the StreetAddressLine1 attribute of the Address object
   *
   *@return    The StreetAddressLine1 value
   *@since     1.5
   */
  public String getStreetAddressLine1() {
    return streetAddressLine1;
  }


  /**
   *  Gets the StreetAddressLine2 attribute of the Address object
   *
   *@return    The StreetAddressLine2 value
   *@since     1.5
   */
  public String getStreetAddressLine2() {
    return streetAddressLine2;
  }


  /**
   *  Gets the City attribute of the Address object
   *
   *@return    The City value
   *@since     1.5
   */
  public String getCity() {
    return city;
  }


  /**
   *  Gets the State attribute of the Address object
   *
   *@return    The State value
   *@since     1.5
   */
  public String getState() {
    if ("UNITED STATES".equals(country) || ("CANADA".equals(country))) {
      return state;
    }
    if ("-1".equals(otherState)) {
      return "";
    } else {
      return otherState;
    }
  }


  /**
   *  Gets the CityState attribute of the Address object
   *
   *@return    The CityState value
   *@since     1.5
   */
  public String getCityState() {
    if (getCity() == null || getState() == null) {
      return ("");
    } else if (!getCity().equals("") && !getState().equals("") && !"-1".equals(getState())) {
      return (getCity() + ", " + getState());
    } else if (getCity().equals("") && !getState().equals("") && !"-1".equals(getState())) {
      return (getState());
    } else if (!getCity().equals("") && getState().equals("") && !"-1".equals(getState())) {
      return (getCity());
    } else {
      return ("");
    }
  }


  /**
   *  Gets the Zip attribute of the Address object
   *
   *@return    The Zip value
   *@since     1.5
   */
  public String getZip() {
    return zip;
  }


  /**
   *  Gets the Country attribute of the Address object
   *
   *@return    The Country value
   *@since     1.5
   */
  public String getCountry() {
    if ("-1".equals(country)) {
      return "";
    } else {
      return country;
    }
  }


  /**
   *  Gets the Type attribute of the Address object
   *
   *@return    The Type value
   *@since     1.6
   */
  public int getType() {
    return type;
  }


  /**
   *  Gets the TypeName attribute of the Address object
   *
   *@return    The TypeName value
   *@since     1.6
   */
  public String getTypeName() {
    return typeName;
  }


  /**
   *  If any of the information for an address is filled in, then the address is
   *  valid
   *
   *@return    The Valid value
   *@since     1.10
   */
  public boolean isValid() {
    //A blank record is not valid, and having the default UNITED STATES selected
    //without any other data is also invalid and does not need to be saved
    if (type == -1) {
      return false;
    }
    if ((streetAddressLine1 == null || streetAddressLine1.trim().equals("")) &&
        (streetAddressLine2 == null || streetAddressLine2.trim().equals("")) &&
        (streetAddressLine3 == null || streetAddressLine3.trim().equals("")) &&
        (city == null || city.trim().equals("")) &&
        (state == null ||
        state.trim().equals("") ||
        "-1".equals(state)) &&
        (zip == null || zip.trim().equals("")) &&
        (country == null ||
        country.trim().equals("") ||
        "-1".equals(country) ||
        "UNITED STATES".equals(country))) {
      return false;
    }
    return true;
  }


  /**
   *  Gets the EnteredBy attribute of the Address object
   *
   *@return    The EnteredBy value
   *@since     1.8
   */
  public int getEnteredBy() {
    return enteredBy;
  }


  /**
   *  Sets the entered attribute of the Address object
   *
   *@param  tmp  The new entered value
   */
  public void setEntered(java.sql.Timestamp tmp) {
    this.entered = tmp;
  }


  /**
   *  Sets the modified attribute of the Address object
   *
   *@param  tmp  The new modified value
   */
  public void setModified(java.sql.Timestamp tmp) {
    this.modified = tmp;
  }


  /**
   *  Sets the entered attribute of the Address object
   *
   *@param  tmp  The new entered value
   */
  public void setEntered(String tmp) {
    this.entered = DateUtils.parseTimestampString(tmp);
  }


  /**
   *  Sets the modified attribute of the Address object
   *
   *@param  tmp  The new modified value
   */
  public void setModified(String tmp) {
    this.modified = DateUtils.parseTimestampString(tmp);
  }


  /**
   *  Gets the ModifiedBy attribute of the Address object
   *
   *@return    The ModifiedBy value
   *@since     1.6
   */
  public int getModifiedBy() {
    return modifiedBy;
  }


  /**
   *  Gets the Enabled attribute of the Address object
   *
   *@return    The Enabled value
   *@since     1.9
   */
  public boolean getEnabled() {
    return enabled;
  }


  /**
   *  Gets the Address attribute of the Address object
   *
   *@return    The Address value
   *@since     1.9
   */
  public String toString() {
    StringBuffer thisAddress = new StringBuffer();
    if (this.getStreetAddressLine1() != null && !this.getStreetAddressLine1().trim().equals("")) {
      thisAddress.append(this.getStreetAddressLine1().trim() + "\r\n");
    }
    if (this.getStreetAddressLine2() != null && !this.getStreetAddressLine2().trim().equals("")) {
      thisAddress.append(this.getStreetAddressLine2().trim() + "\r\n");
    }
    if (this.getStreetAddressLine3() != null && !this.getStreetAddressLine3().trim().equals("")) {
      thisAddress.append(this.getStreetAddressLine3().trim() + "\r\n");
    }
    if (!this.getCityState().trim().equals("")) {
      thisAddress.append(this.getCityState().trim() + "\r\n");
    }
    if (this.getZip() != null && !this.getZip().trim().equals("")) {
      thisAddress.append(this.getZip().trim() + "\r\n");
    }
    if (this.getCountry() != null && !this.getCountry().trim().equals("")) {
      thisAddress.append(this.getCountry().trim() + "\r\n");
    }
    return thisAddress.toString();
  }


  /**
   *  Gets the locale attribute of the Address object
   *
   *@return    The locale value
   */
  public Locale getLocale() {
    if ("UNITED STATES".equals(country)) {
      return Locale.US;
    }
    if ("CANADA".equals(country)) {
      return Locale.CANADA;
    }
    return null;
  }


  /**
   *  Populates the object from a ResultSet
   *
   *@param  rs                Description of Parameter
   *@exception  SQLException  Description of Exception
   *@since                    1.6
   */
  public void buildRecord(ResultSet rs) throws SQLException {
    this.setId(rs.getInt("address_id"));
    if (!isContact) {
      this.setOrgId(rs.getInt("org_id"));
      if (rs.wasNull()) {
        this.setOrgId(-1);
      }
    } else {
      this.setContactId(rs.getInt("contact_id"));
      if (rs.wasNull()) {
        this.setContactId(-1);
      }
    }
    this.setType(rs.getInt("address_type"));
    if (rs.wasNull()) {
      this.setType(-1);
    }
    this.setStreetAddressLine1(rs.getString("addrline1"));
    this.setStreetAddressLine2(rs.getString("addrline2"));
    this.setStreetAddressLine3(rs.getString("addrline3"));
    this.setCity(rs.getString("city"));
    this.setState(rs.getString("state"));
    this.setOtherState(state);
    this.setZip(rs.getString("postalcode"));
    this.setCountry(rs.getString("country"));
    this.setEntered(rs.getTimestamp("entered"));
    this.setEnteredBy(rs.getInt("enteredby"));
    if (this.getEnteredBy() == -1) {
      this.setEnteredBy(0);
    }
    this.setModified(rs.getTimestamp("modified"));
    this.setModifiedBy(rs.getInt("modifiedby"));
    if (this.getModifiedBy() == -1) {
      this.setModifiedBy(0);
    }
    this.setTypeName(rs.getString("description"));
  }


  /**
   *  Description of the Method
   *
   *@param  request    Description of Parameter
   *@param  parseItem  Description of Parameter
   *@since             1.8
   */
  public void buildRecord(HttpServletRequest request, int parseItem) {
    this.setType(request.getParameter("address" + parseItem + "type"));
    if (request.getParameter("address" + parseItem + "id") != null) {
      this.setId(request.getParameter("address" + parseItem + "id"));
    }
    this.setStreetAddressLine1(request.getParameter("address" + parseItem + "line1"));
    this.setStreetAddressLine2(request.getParameter("address" + parseItem + "line2"));
    this.setStreetAddressLine3(request.getParameter("address" + parseItem + "line3"));
    this.setCity(request.getParameter("address" + parseItem + "city"));
    this.setState(request.getParameter("address" + parseItem + "state"));
    this.setOtherState(request.getParameter("address" + parseItem + "otherState"));
    this.setZip(request.getParameter("address" + parseItem + "zip"));
    this.setCountry(request.getParameter("address" + parseItem + "country"));
    if (request.getParameter("address" + parseItem + "delete") != null) {
      String action = request.getParameter("address" + parseItem + "delete").toLowerCase();
      if (action.equals("on")) {
        this.setEnabled(false);
      }
    }
  }
}

