//Copyright 2001 Dark Horse Ventures
//The createFilter method and the prepareFilter method need to have the same
//number of parameters if modified.

package com.darkhorseventures.cfsbase;

import java.util.Vector;
import java.util.Iterator;
import java.util.Hashtable;
import java.sql.*;
import com.darkhorseventures.webutils.PagedListInfo;
import com.darkhorseventures.webutils.HtmlSelect;

/**
 *  Contains a list of contacts... currently used to build the list from the
 *  database with any of the parameters to limit the results.
 *
 *@author     mrajkowski
 *@created    August 29, 2001
 *@version    $Id$
 */
public class ContactList extends Vector {

	private PagedListInfo pagedListInfo = null;
	private int orgId = -1;
	private int typeId = -1;
	private String firstName = null;
	private String middleName = null;
	private String lastName = null;
	private String title = null;
	private String company = null;
	private boolean emailNotNull = false;
	private Vector ignoreTypeIdList = new Vector();
	private boolean checkUserAccess = false;
	private boolean buildDetails = true;
	private int owner = -1;
	private String ownerIdRange = null;

	//ranges
	private String companyRange = null;
	private String nameFirstRange = null;
	private String nameLastRange = null;
	private String zipRange = null;
	private String areaCodeRange = null;
	private String cityRange = null;

	private String dateBefore = null;
	private String dateAfter = null;
	private String dateOnOrBefore = null;
	private String dateOnOrAfter = null;

	private SearchCriteriaList scl = null;


	/**
	 *  Constructor for the ContactList object
	 *
	 *@since    1.1
	 */
	public ContactList() { }


	/**
	 *  Sets the CompanyRange attribute of the ContactList object
	 *
	 *@param  companyRange  The new CompanyRange value
	 *@since
	 */
	public void setCompanyRange(String companyRange) {
		this.companyRange = companyRange;
	}


	/**
	 *  Sets the FirstName attribute of the ContactList object
	 *
	 *@param  firstName  The new FirstName value
	 *@since
	 */
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}


	/**
	 *  Sets the Company attribute of the ContactList object
	 *
	 *@param  company  The new Company value
	 *@since
	 */
	public void setCompany(String company) {
		this.company = company;
	}


	/**
	 *  Sets the OwnerIdRange attribute of the ContactList object
	 *
	 *@param  ownerIdRange  The new OwnerIdRange value
	 *@since
	 */
	public void setOwnerIdRange(String ownerIdRange) {
		this.ownerIdRange = ownerIdRange;
	}


	/**
	 *  Sets the Owner attribute of the ContactList object
	 *
	 *@param  owner  The new Owner value
	 *@since
	 */
	public void setOwner(int owner) {
		this.owner = owner;
	}


	/**
	 *  Sets the NameFirstRange attribute of the ContactList object
	 *
	 *@param  nameFirstRange  The new NameFirstRange value
	 *@since
	 */
	public void setNameFirstRange(String nameFirstRange) {
		this.nameFirstRange = nameFirstRange;
	}


	/**
	 *  Sets the Scl attribute of the ContactList object
	 *
	 *@param  scl  The new Scl value
	 *@since
	 */
	public void setScl(SearchCriteriaList scl) {
		this.scl = scl;
		buildQuery();
	}


	/**
	 *  Sets the MiddleName attribute of the ContactList object
	 *
	 *@param  tmp  The new MiddleName value
	 *@since
	 */
	public void setMiddleName(String tmp) {
		this.middleName = tmp;
	}


	/**
	 *  Sets the LastName attribute of the ContactList object
	 *
	 *@param  tmp  The new LastName value
	 *@since
	 */
	public void setLastName(String tmp) {
		this.lastName = tmp;
	}


	/**
	 *  Sets the PagedListInfo attribute of the ContactList object
	 *
	 *@param  tmp  The new PagedListInfo value
	 *@since       1.1
	 */
	public void setPagedListInfo(PagedListInfo tmp) {
		this.pagedListInfo = tmp;
	}


	/**
	 *  Sets the ZipRange attribute of the ContactList object
	 *
	 *@param  zipRange  The new ZipRange value
	 *@since
	 */
	public void setZipRange(String zipRange) {
		this.zipRange = zipRange;
	}


	/**
	 *  Sets the Title attribute of the ContactList object
	 *
	 *@param  title  The new Title value
	 *@since
	 */
	public void setTitle(String title) {
		this.title = title;
	}


	/**
	 *  Sets the OrgId attribute of the ContactList object
	 *
	 *@param  tmp  The new OrgId value
	 *@since       1.1
	 */
	public void setOrgId(int tmp) {
		this.orgId = tmp;
	}


	/**
	 *  Sets the EmailNotNull attribute of the ContactList object
	 *
	 *@param  emailNotNull  The new EmailNotNull value
	 *@since
	 */
	public void setEmailNotNull(boolean emailNotNull) {
		this.emailNotNull = emailNotNull;
	}


	/**
	 *  Sets the TypeId attribute of the ContactList object
	 *
	 *@param  tmp  The new TypeId value
	 *@since       1.1
	 */
	public void setTypeId(int tmp) {
		this.typeId = tmp;
	}


	/**
	 *  Sets the CheckUserAccess attribute of the ContactList object
	 *
	 *@param  tmp  The new CheckUserAccess value
	 *@since       1.8
	 */
	public void setCheckUserAccess(boolean tmp) {
		this.checkUserAccess = tmp;
	}


	/**
	 *  Sets the BuildDetails attribute of the ContactList object
	 *
	 *@param  tmp  The new BuildDetails value
	 *@since
	 */
	public void setBuildDetails(boolean tmp) {
		this.buildDetails = tmp;
	}


	/**
	 *  Sets the NameLastRange attribute of the ContactList object
	 *
	 *@param  nameLastRange  The new NameLastRange value
	 *@since
	 */
	public void setNameLastRange(String nameLastRange) {
		this.nameLastRange = nameLastRange;
	}


	/**
	 *  Sets the SearchValues attribute of the ContactList object
	 *
	 *@param  outerHash  The new SearchValues value
	 *@since
	 */
	public void setSearchValues(Hashtable[] outerHash) {
		if (outerHash[0].containsKey("=") == true) {
			this.companyRange = outerHash[0].get(new String("=")).toString();
		}

		if (outerHash[1].containsKey("=") == true) {
			this.nameFirstRange = outerHash[1].get(new String("=")).toString();
		}

		if (outerHash[2].containsKey("=") == true) {
			this.nameLastRange = outerHash[2].get(new String("=")).toString();
		}

		if (outerHash[3].containsKey("<") == true) {
			this.dateBefore = outerHash[3].get(new String("<")).toString();
		}

		if (outerHash[3].containsKey(">") == true) {
			this.dateAfter = outerHash[3].get(new String(">")).toString();
		}

		if (outerHash[3].containsKey("<=") == true) {
			this.dateOnOrBefore = outerHash[3].get(new String("<=")).toString();
		}

		if (outerHash[3].containsKey(">=") == true) {
			this.dateOnOrAfter = outerHash[3].get(new String(">=")).toString();
		}

		if (outerHash[4].containsKey("=") == true) {
			this.zipRange = outerHash[4].get(new String("=")).toString();
		}

		if (outerHash[5].containsKey("=") == true) {
			this.areaCodeRange = outerHash[5].get(new String("=")).toString();
		}

		if (outerHash[6].containsKey("=") == true) {
			this.cityRange = outerHash[6].get(new String("=")).toString();
		}
	}


	/**
	 *  Gets the OwnerIdRange attribute of the ContactList object
	 *
	 *@return    The OwnerIdRange value
	 *@since
	 */
	public String getOwnerIdRange() {
		return ownerIdRange;
	}


	/**
	 *  Gets the ZipRange attribute of the ContactList object
	 *
	 *@return    The ZipRange value
	 *@since
	 */
	public String getZipRange() {
		return zipRange;
	}


	/**
	 *  Gets the CompanyRange attribute of the ContactList object
	 *
	 *@return    The CompanyRange value
	 *@since
	 */
	public String getCompanyRange() {
		return companyRange;
	}


	/**
	 *  Gets the NameFirstRange attribute of the ContactList object
	 *
	 *@return    The NameFirstRange value
	 *@since
	 */
	public String getNameFirstRange() {
		return nameFirstRange;
	}


	/**
	 *  Gets the Scl attribute of the ContactList object
	 *
	 *@return    The Scl value
	 *@since
	 */
	public SearchCriteriaList getScl() {
		return scl;
	}


	/**
	 *  Gets the NameLastRange attribute of the ContactList object
	 *
	 *@return    The NameLastRange value
	 *@since
	 */
	public String getNameLastRange() {
		return nameLastRange;
	}


	/**
	 *  Gets the EmailNotNull attribute of the ContactList object
	 *
	 *@return    The EmailNotNull value
	 *@since
	 */
	public boolean getEmailNotNull() {
		return emailNotNull;
	}


	/**
	 *  Gets the Owner attribute of the ContactList object
	 *
	 *@return    The Owner value
	 *@since
	 */
	public int getOwner() {
		return owner;
	}


	/**
	 *  Gets the Company attribute of the ContactList object
	 *
	 *@return    The Company value
	 *@since
	 */
	public String getCompany() {
		return company;
	}


	/**
	 *  Gets the Title attribute of the ContactList object
	 *
	 *@return    The Title value
	 *@since
	 */
	public String getTitle() {
		return title;
	}


	/**
	 *  Gets the MiddleName attribute of the ContactList object
	 *
	 *@return    The MiddleName value
	 *@since
	 */
	public String getMiddleName() {
		return middleName;
	}


	/**
	 *  Gets the LastName attribute of the ContactList object
	 *
	 *@return    The LastName value
	 *@since
	 */
	public String getLastName() {
		return lastName;
	}


	/**
	 *  Gets the FirstName attribute of the ContactList object
	 *
	 *@return    The FirstName value
	 *@since
	 */
	public String getFirstName() {
		return firstName;
	}


	/**
	 *  Gets the HtmlSelect attribute of the ContactList object
	 *
	 *@param  selectName  Description of Parameter
	 *@return             The HtmlSelect value
	 *@since              1.8
	 */
	public String getHtmlSelect(String selectName) {
		return getHtmlSelect(selectName, -1);
	}
	
	public String getEmptyHtmlSelect(String selectName) {
		HtmlSelect contactListSelect = new HtmlSelect();
		contactListSelect.addItem(-1, "-- None --");
		return contactListSelect.getHtml(selectName);
	}


	/**
	 *  Gets the HtmlSelect attribute of the ContactList object
	 *
	 *@param  selectName  Description of Parameter
	 *@param  defaultKey  Description of Parameter
	 *@return             The HtmlSelect value
	 *@since              1.8
	 */
	public String getHtmlSelect(String selectName, int defaultKey) {
		HtmlSelect contactListSelect = new HtmlSelect();
		Iterator i = this.iterator();
		while (i.hasNext()) {
			Contact thisContact = (Contact) i.next();
			contactListSelect.addItem(
					thisContact.getId(),
					thisContact.getNameLast() + ", " +
					thisContact.getNameFirst() +
					(checkUserAccess ? (thisContact.hasAccount() ? " (*)" : "") : ""));
		}
		return contactListSelect.getHtml(selectName, defaultKey);
	}

	/**
	 *  Description of the Method
	 *
	 *@since
	 */
	public void buildQuery() {
		String fieldName = "";
		String readyToGo = "";

		Hashtable[] outerHash = null;

		//ONE FOR EACH IN THE FIELD LIST
		Hashtable company = null;
		Hashtable namefirst = null;
		Hashtable namelast = null;
		Hashtable entered = null;
		Hashtable zip = null;
		Hashtable areacode = null;
		Hashtable city = null;

		int count = 0;

		//CREATE EACH
		company = new Hashtable();
		namefirst = new Hashtable();
		namelast = new Hashtable();
		entered = new Hashtable();
		zip = new Hashtable();
		areacode = new Hashtable();
		city = new Hashtable();

		//THIS CORRESPONDS TO THE FIELD LIST

		outerHash = new Hashtable[]{
				company,
				namefirst,
				namelast,
				entered,
				zip,
				areacode,
				city
				};

    System.out.println("ContactList-> SCL Size: " + this.getScl().size());
    Iterator i = this.getScl().keySet().iterator();
		while (i.hasNext()) {
			++count;
			Integer group = (Integer) i.next();
			SearchCriteriaGroup thisGroup = (SearchCriteriaGroup) this.getScl().get(group);

			fieldName = thisGroup.getGroupField().getFieldName();
      System.out.println("Field: " + fieldName);

			Iterator j = thisGroup.iterator();

			while (j.hasNext()) {

				SearchCriteriaElement thisElement = (SearchCriteriaElement) j.next();
				System.out.println("which one: " + (thisElement.getOperator()));

				readyToGo = replace(thisElement.getText().toLowerCase(), '\'', "\\'");
				String check = (String) outerHash[(thisElement.getFieldId() - 1)].get(thisElement.getOperator());

				//only if we have string data to deal with
				if (check == null || thisElement.getDataType().equals("date")) {
					outerHash[(thisElement.getFieldId() - 1)].put(thisElement.getOperator(), ("'" + readyToGo + "'"));
				}
				else {
					check = check + ", '" + readyToGo + "'";
					outerHash[(thisElement.getFieldId() - 1)].put(thisElement.getOperator(), check);
				}
				//end of that


			}
		}

		//THIS PART IS ALSO DEPENDENT
		this.setSearchValues(outerHash);
	}


	/**
	 *  Builds a list of contacts based on several parameters. The parameters are
	 *  set after this object is constructed, then the buildList method is called
	 *  to generate the list.
	 *
	 *@param  db                Description of Parameter
	 *@exception  SQLException  Description of Exception
	 *@since                    1.1
	 */
	public void buildList(Connection db) throws SQLException {

		PreparedStatement pst = null;
		ResultSet rs = null;
		int items = -1;

		StringBuffer sqlSelect = new StringBuffer();
		StringBuffer sqlCount = new StringBuffer();
		StringBuffer sqlFilter = new StringBuffer();
		StringBuffer sqlOrder = new StringBuffer();

		//Need to build a base SQL statement for returning records
		sqlSelect.append(
				"SELECT c.*, d.description as departmentname, t.description as type_name, " +
				"ct_owner.namelast || ', ' || ct_owner.namefirst as o_name, ct_eb.namelast || ', ' || ct_eb.namefirst as eb_name, ct_mb.namelast || ', ' || ct_mb.namefirst as mb_name, o.name as org_name " +
				"FROM contact c " +
				"LEFT JOIN lookup_contact_types t ON (c.type_id = t.code) " +
				"LEFT JOIN organization o ON (c.org_id = o.org_id) " +
				"LEFT JOIN lookup_department d ON (c.department = d.code) " +
				"LEFT JOIN contact ct_owner ON (c.owner = ct_owner.user_id) " +
				"LEFT JOIN contact ct_eb ON (c.enteredby = ct_eb.user_id) " +
				"LEFT JOIN contact ct_mb ON (c.modifiedby = ct_mb.user_id) " +
				"WHERE c.contact_id > -1 ");

		//Need to build a base SQL statement for counting records
		sqlCount.append(
				"SELECT COUNT(*) AS recordcount " +
				"FROM contact c " +
				"LEFT JOIN lookup_contact_types t ON (c.type_id = t.code) " +
				"LEFT JOIN organization o ON (c.org_id = o.org_id) " +
				"LEFT JOIN lookup_department d ON (c.department = d.code) " +
				"LEFT JOIN contact ct_owner ON (c.owner = ct_owner.user_id) " +
				"LEFT JOIN contact ct_eb ON (c.enteredby = ct_eb.user_id) " +
				"LEFT JOIN contact ct_mb ON (c.modifiedby = ct_mb.user_id) " +
				"WHERE c.contact_id > -1 ");

		createFilter(sqlFilter);

		if (pagedListInfo != null) {
			//Get the total number of records matching filter
			pst = db.prepareStatement(sqlCount.toString() +
					sqlFilter.toString());
			items = prepareFilter(pst);
			rs = pst.executeQuery();
			if (rs.next()) {
				int maxRecords = rs.getInt("recordcount");
				pagedListInfo.setMaxRecords(maxRecords);
			}
			pst.close();
			rs.close();

			//Determine the offset, based on the filter, for the first record to show
			if (!pagedListInfo.getCurrentLetter().equals("")) {
				pst = db.prepareStatement(sqlCount.toString() +
						sqlFilter.toString() +
						"AND c.namelast < ? ");
				items = prepareFilter(pst);
				pst.setString(++items, pagedListInfo.getCurrentLetter().toLowerCase());
				rs = pst.executeQuery();
				if (rs.next()) {
					int offsetCount = rs.getInt("recordcount");
					pagedListInfo.setCurrentOffset(offsetCount);
				}
				rs.close();
				pst.close();
			}

			//Determine column to sort by
			if (pagedListInfo.getColumnToSortBy() == null || pagedListInfo.getColumnToSortBy().equals("")) {
				pagedListInfo.setColumnToSortBy("c.namelast");
			}
			sqlOrder.append("ORDER BY " + pagedListInfo.getColumnToSortBy() + " ");
			if (pagedListInfo.getSortOrder() != null && !pagedListInfo.getSortOrder().equals("")) {
				sqlOrder.append(pagedListInfo.getSortOrder() + " ");
			}

			//Determine items per page
			if (pagedListInfo.getItemsPerPage() > 0) {
				sqlOrder.append("LIMIT " + pagedListInfo.getItemsPerPage() + " ");
			}

			sqlOrder.append("OFFSET " + pagedListInfo.getCurrentOffset() + " ");
		}
		else {
			sqlOrder.append("ORDER BY c.namelast ");
		}

		pst = db.prepareStatement(sqlSelect.toString() + sqlFilter.toString() + sqlOrder.toString());
		
		items = prepareFilter(pst);
		rs = pst.executeQuery();
		while (rs.next()) {
			Contact thisContact = new Contact(rs);
			this.addElement(thisContact);
		}
		rs.close();
		pst.close();

		buildResources(db);
	}


	/**
	 *  Adds a feature to the IgnoreTypeId attribute of the ContactList object
	 *
	 *@param  tmp  The feature to be added to the IgnoreTypeId attribute
	 *@since       1.2
	 */
	public void addIgnoreTypeId(String tmp) {
		ignoreTypeIdList.addElement(tmp);
	}


	/**
	 *  Adds a feature to the IgnoreTypeId attribute of the ContactList object
	 *
	 *@param  tmp  The feature to be added to the IgnoreTypeId attribute
	 *@since       1.2
	 */
	public void addIgnoreTypeId(int tmp) {
		ignoreTypeIdList.addElement("" + tmp);
	}


	/**
	 *  Description of the Method
	 *
	 *@param  str      Description of Parameter
	 *@param  oldChar  Description of Parameter
	 *@param  newStr   Description of Parameter
	 *@return          Description of the Returned Value
	 *@since
	 */
	String replace(String str, char oldChar, String newStr) {
		String replacedStr = "";
		for (int i = 0; i < str.length(); i++) {
			char c = str.charAt(i);
			if (c == oldChar) {
				replacedStr += newStr;
			}
			else {
				replacedStr += c;
			}
		}
		return replacedStr;
	}


	/**
	 *  Convenience method to get a list of phone numbers for each contact
	 *
	 *@param  db                Description of Parameter
	 *@exception  SQLException  Description of Exception
	 *@since                    1.5
	 */
	private void buildResources(Connection db) throws SQLException {
		Iterator i = this.iterator();
		while (i.hasNext()) {
			Contact thisContact = (Contact) i.next();
			if (buildDetails) {
				thisContact.getPhoneNumberList().buildList(db);
				thisContact.getAddressList().buildList(db);
				thisContact.getEmailAddressList().buildList(db);
			}
			if (checkUserAccess) {
				thisContact.checkUserAccount(db);
			}
		}
	}


	/**
	 *  Builds a base SQL where statement for filtering records to be used by
	 *  sqlSelect and sqlCount
	 *
	 *@param  sqlFilter  Description of Parameter
	 *@since             1.3
	 */
	private void createFilter(StringBuffer sqlFilter) {
		if (sqlFilter == null) {
			sqlFilter = new StringBuffer();
		}

		if (orgId != -1) {
			sqlFilter.append("AND c.org_id = ? ");
		}

		if (owner != -1) {
			sqlFilter.append("AND c.owner = ? ");
		}

		if (typeId != -1) {
			sqlFilter.append("AND c.type_id = ? ");
		}

		if (firstName != null) {
			if (firstName.indexOf("%") >= 0) {
				sqlFilter.append("AND lower(c.namefirst) like lower(?) ");
			}
			else {
				sqlFilter.append("AND lower(c.namefirst) = lower(?) ");
			}
		}

		if (middleName != null) {
			if (middleName.indexOf("%") >= 0) {
				sqlFilter.append("AND lower(c.namemiddle) like lower(?) ");
			}
			else {
				sqlFilter.append("AND lower(c.namemiddle) = lower(?) ");
			}
		}

		if (lastName != null) {
			if (lastName.indexOf("%") >= 0) {
				sqlFilter.append("AND lower(c.namelast) like lower(?) ");
			}
			else {
				sqlFilter.append("AND lower(c.namelast) = lower(?) ");
			}
		}

		if (title != null) {
			if (title.indexOf("%") >= 0) {
				sqlFilter.append("AND lower(c.title) like lower(?) ");
			}
			else {
				sqlFilter.append("AND lower(c.title) = lower(?) ");
			}
		}

		if (company != null) {
			if (company.indexOf("%") >= 0) {
				sqlFilter.append("AND lower(c.company) like lower(?) ");
			}
			else {
				sqlFilter.append("AND lower(c.company) = lower(?) ");
			}
		}

		if (companyRange != null) {
			sqlFilter.append("AND (lower(o.name) in (" + companyRange + ") OR lower(c.company) in (" + companyRange + "))");
		}

		if (nameFirstRange != null) {
			sqlFilter.append("AND lower(c.namefirst) in (" + nameFirstRange + ") ");
		}

		if (nameLastRange != null) {
			sqlFilter.append("AND lower(c.namelast) in (" + nameLastRange + ") ");
		}

		if (zipRange != null) {
			sqlFilter.append("AND c.contact_id in (select distinct contact_id from contact_address where address_type = 1 and postalcode in (" + zipRange + ")) ");
		}

		if (areaCodeRange != null) {
			sqlFilter.append("AND c.contact_id in (select distinct contact_id from contact_phone where phone_type = 1 and substr(number,0,4) in (" + areaCodeRange + ")) ");
		}

		if (cityRange != null) {
			sqlFilter.append("AND c.contact_id in (select distinct contact_id from contact_address where address_type = 1 and lower(city) in (" + cityRange + ")) ");
		}

		if (dateBefore != null) {
			sqlFilter.append("AND (c.entered < " + dateBefore + ") ");
		}

		if (dateAfter != null) {
			sqlFilter.append("AND (c.entered > " + dateAfter + ") ");
		}

		if (dateOnOrBefore != null) {
			sqlFilter.append("AND (c.entered <= " + dateOnOrBefore + ") ");
		}

		if (dateOnOrAfter != null) {
			sqlFilter.append("AND (c.entered >= " + dateOnOrAfter + ") ");
		}

		if (ownerIdRange != null) {
			sqlFilter.append("AND c.owner IN (" + ownerIdRange + ") ");
		}

		if (ignoreTypeIdList.size() > 0) {
			Iterator iList = ignoreTypeIdList.iterator();
			sqlFilter.append("AND c.type_id not in (");
			while (iList.hasNext()) {
				String placeHolder = (String) iList.next();
				sqlFilter.append("?");
				if (iList.hasNext()) {
					sqlFilter.append(",");
				}
			}
			sqlFilter.append(") ");
		}
	}


	/**
	 *  Sets the parameters for the preparedStatement - these items must correspond
	 *  with the createFilter statement
	 *
	 *@param  pst               Description of Parameter
	 *@return                   Description of the Returned Value
	 *@exception  SQLException  Description of Exception
	 *@since                    1.3
	 */
	private int prepareFilter(PreparedStatement pst) throws SQLException {
		int i = 0;
		if (orgId != -1) {
			pst.setInt(++i, orgId);
		}

		if (owner != -1) {
			pst.setInt(++i, owner);
		}

		if (typeId != -1) {
			pst.setInt(++i, typeId);
		}

		if (firstName != null) {
			pst.setString(++i, firstName);
		}

		if (middleName != null) {
			pst.setString(++i, middleName);
		}

		if (lastName != null) {
			pst.setString(++i, lastName);
		}

		if (title != null) {
			pst.setString(++i, title);
		}

		if (company != null) {
			pst.setString(++i, company);
		}

		if (ignoreTypeIdList.size() > 0) {
			Iterator iList = ignoreTypeIdList.iterator();
			while (iList.hasNext()) {
				int thisType = Integer.parseInt((String) iList.next());
				pst.setInt(++i, thisType);
			}
		}

		//System.out.println(pst.toString());

		return i;
	}

}

