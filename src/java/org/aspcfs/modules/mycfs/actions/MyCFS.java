package com.darkhorseventures.cfsmodule;

import javax.servlet.*;
import javax.servlet.http.*;
import org.theseus.actions.*;
import com.darkhorseventures.cfsbase.*;
import com.darkhorseventures.utils.*;
import java.sql.*;
import java.util.Vector;
import com.darkhorseventures.webutils.*;
import java.util.Enumeration;
import java.util.Iterator;

/**
 *  The MyCFS module.
 *
 *@author     chris
 *@created    July 3, 2001
 *@version    $Id$
 */
public final class MyCFS extends CFSModule {

	/**
	 *  Description of the Method
	 *
	 *@param  context  Description of Parameter
	 *@return          Description of the Returned Value
	 *@since
	 */
	public String executeCommandDefault(ActionContext context) {
		String module = context.getRequest().getParameter("module");
		String includePage = context.getRequest().getParameter("include");
		context.getRequest().setAttribute("IncludePage", includePage);
		addModuleBean(context, module, module);
		return ("IncludeOK");
	}
	
	public String executeCommandInbox(ActionContext context) {
		Exception errorMessage = null;
	
		PagedListInfo inboxInfo = this.getPagedListInfo(context, "InboxInfo");
		inboxInfo.setLink("/MyCFSInbox.do?command=Inbox");
	
		Connection db = null;
		CFSNoteList noteList = new CFSNoteList();
	
		try {
			db = this.getConnection(context);
			noteList.setPagedListInfo(inboxInfo);
			noteList.setSentTo(getUserId(context));
			
			if (context.getRequest().getParameter("return") != null) {
				inboxInfo.setListView("new");
			}
	
			if ("old".equals(inboxInfo.getListView())) {
				noteList.setOldMessagesOnly(true);
			}
			
			noteList.buildList(db);
	} catch (Exception e) {
		errorMessage = e;
	} finally {
		this.freeConnection(context, db);
	}
	
	if (errorMessage == null) {
		context.getRequest().setAttribute("CFSNoteList", noteList);
		addModuleBean(context, "MyInbox", "Inbox Home");
		return ("InboxOK");
	} else {
		context.getRequest().setAttribute("Error", errorMessage);
		return ("SystemError");
	}
}

	/**
	 *  Description of the Method
	 *
	 *@param  context  Description of Parameter
	 *@return          Description of the Returned Value
	 *@since
	 */
	public String executeCommandDeleteHeadline(ActionContext context) {
		//Process all parameters
		Enumeration parameters = context.getRequest().getParameterNames();
		Exception errorMessage = null;

		int orgId = -1;
		Connection db = null;

		try {
			db = this.getConnection(context);
			while (parameters.hasMoreElements()) {
				String param = (String) parameters.nextElement();

				if (context.getRequest().getParameter(param).equals("on")) {
					orgId = Integer.parseInt(param);
					Organization newOrg = new Organization();
					newOrg.setOrgId(orgId);
					newOrg.deleteMinerOnly(db);
					System.out.println(param + ": " + context.getRequest().getParameter(param) + "<br>");
				}
			}
		}
		catch (SQLException e) {
			errorMessage = e;
		}
		finally {
			this.freeConnection(context, db);
		}

		if (errorMessage == null) {
			addModuleBean(context, "", "Headline Delete OK");
			return ("DeleteOK");
		}
		else {
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		}
	}

	public String executeCommandCFSNoteDelete(ActionContext context) {
		Connection db = null;
		Exception errorMessage = null;
		
		try {
			db = this.getConnection(context);
			int noteId = Integer.parseInt(context.getRequest().getParameter("id"));
			CFSNote newNote = new CFSNote(db, noteId);
			newNote.delete(db, getUserId(context));
		}
		catch (SQLException e) {
			errorMessage = e;
		}
		finally {
			this.freeConnection(context, db);
		}

		if (errorMessage == null) {
			addModuleBean(context, "MyInbox", "Inbox Home");
			return (executeCommandInbox(context));
		}
		else {
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		}
	}
	
 	public String executeCommandCFSNoteTrash(ActionContext context) {
		Connection db = null;
		Exception errorMessage = null;
		
		try {
			db = this.getConnection(context);
			int noteId = Integer.parseInt(context.getRequest().getParameter("id"));
			CFSNote newNote = new CFSNote(db, noteId);
			
			System.out.println("Status before: " + newNote.getStatus());
			
			if (newNote.getStatus() == 2) {
				newNote.setStatus(CFSNote.READ);
			} else {
				newNote.setStatus(CFSNote.OLD);
			}

			newNote.updateStatus(db);
			System.out.println("Status after: " + newNote.getStatus());

		}
		catch (SQLException e) {
			errorMessage = e;
		}
		finally {
			this.freeConnection(context, db);
		}

		if (errorMessage == null) {
			addModuleBean(context, "MyInbox", "Inbox Home");
			return (executeCommandInbox(context));
		}
		else {
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		}
	}
	
	/**
	 *  Takes a look at the User Session Object and prepares the MyCFSBean for the
	 *  JSP. The bean will contain all the information that the JSP can see.
	 *
	 *@param  context  Description of Parameter
	 *@return          Description of the Returned Value
	 *@since           1.1
	 */
	public String executeCommandHeadline(ActionContext context) {
		addModuleBean(context, "Customize Headlines", "Customize Headlines");
		Exception errorMessage = null;

		PagedListInfo orgListInfo = this.getPagedListInfo(context, "HeadlineListInfo");
		orgListInfo.setLink("/MyCFS.do?command=Headline");

		Connection db = null;
		OrganizationList organizationList = new OrganizationList();

		try {
			db = this.getConnection(context);
			organizationList.setPagedListInfo(orgListInfo);
			organizationList.setMinerOnly(true);
			organizationList.setEnteredBy(getUserId(context));
			organizationList.buildList(db);
		}
		catch (Exception e) {
			errorMessage = e;
		}
		finally {
			this.freeConnection(context, db);
		}

		if (errorMessage == null) {
			context.getRequest().setAttribute("OrgList", organizationList);
			return ("HeadlineOK");
		}
		else {
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		}
	}


	/**
	 *  Description of the Method
	 *
	 *@param  context  Description of Parameter
	 *@return          Description of the Returned Value
	 *@since
	 */
	public String executeCommandInsertHeadline(ActionContext context) {
		addModuleBean(context, "Customize Headlines", "");
		int headlines = 0;
		Exception errorMessage = null;
		boolean existsAlready = false;

		Connection db = null;

		String name = context.getRequest().getParameter("name");
		String sym = context.getRequest().getParameter("stockSymbol");

		Organization newOrg = (Organization) new Organization();

		try {
			newOrg.setName(name);
			newOrg.setTicker(sym);
			newOrg.setIndustry("1");
			newOrg.setEnteredBy(getUserId(context));
			newOrg.setMiner_only(true);

			db = this.getConnection(context);

			existsAlready = newOrg.checkIfExists(db, name);
			newOrg.insert(db);
		}
		catch (SQLException e) {
			errorMessage = e;
		}
		finally {
			this.freeConnection(context, db);
		}

		if (errorMessage == null) {
			context.getRequest().setAttribute("OrgDetails", newOrg);
			return ("GoHomeOK");
		}
		else {
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		}
	}
	
	public String executeCommandCFSNoteDetails(ActionContext context) {
		Exception errorMessage = null;
		Connection db = null;
		CFSNote newNote = null;
	
		try {
			int msgId = Integer.parseInt(context.getRequest().getParameter("id"));
			db = this.getConnection(context);
			newNote = new CFSNote(db, msgId);
			
			if (newNote.getStatus() == CFSNote.NEW) {
				newNote.setStatus(CFSNote.READ);
				newNote.updateStatus(db);
			}
			
			//addRecentItem(context, newOrg);
		} catch (Exception e) {
			errorMessage = e;
		} finally {
			this.freeConnection(context, db);
		}
	
		if (errorMessage == null) {
			addModuleBean(context, "MyInbox", "Inbox Details");
			context.getRequest().setAttribute("NoteDetails", newNote);
			return ("CFSNoteDetailsOK");
		} else {
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		}
	}


	/**
	 *  Takes a look at the User Session Object and prepares the MyCFSBean for the
	 *  JSP. The bean will contain all the information that the JSP can see.
	 *
	 *@param  context  Description of Parameter
	 *@return          Description of the Returned Value
	 *@since           1.1
	 */
	public String executeCommandHome(ActionContext context) {
		addModuleBean(context, "Home", "");
		int headlines = 0;
		Exception errorMessage = null;
		int alertsDD = getUserId(context);

		if (context.getRequest().getParameter("userId") != null) {
			alertsDD = Integer.parseInt(context.getRequest().getParameter("userId"));
		}

		String whereClause = new String();
		UserBean thisUser = (UserBean) context.getSession().getAttribute("User");

		//this is how we get the multiple-level heirarchy...recursive function.

		User thisRec = thisUser.getUserRecord();

		UserList shortChildList = thisRec.getShortChildList();
		UserList newUserList = thisRec.getFullChildList(shortChildList, new UserList());

		//newUserList.setManagerId(getUserId(context));
		//newUserList.setBuildHierarchy(true);

		newUserList.setMyId(getUserId(context));
		newUserList.setMyValue(thisUser.getNameLast() + ", " + thisUser.getNameFirst());
		newUserList.setIncludeMe(true);

		newUserList.setJsEvent("onChange = javascript:document.forms[0].action='/MyCFS.do?command=Home';document.forms[0].submit()");

		//
		//	Alerts Selection
		//

		String alertsRequest = (String) context.getRequest().getParameter("alerts");
		if (alertsRequest == null) {
			alertsRequest = "0";
		}

		int i_alerts = Integer.parseInt(alertsRequest);

		Vector newsList = new Vector();

		String industryCheck = context.getRequest().getParameter("industry");

		Connection db = null;
		Statement st = null;
		ResultSet rs = null;
		ResultSet headline_rs = null;

		try {
			StringBuffer sql = new StringBuffer();

			db = this.getConnection(context);

			//newUserList.buildList(db);
			context.getRequest().setAttribute("NewUserList", newUserList);

			LookupList indSelect = new LookupList(db, "lookup_industry");
			indSelect.setJsEvent("onChange=\"document.forms['miner_select'].submit();\"");

			indSelect.addItem(0, "Latest News");

			//used to check the number of customized headlines
			PreparedStatement pst = null;
			StringBuffer headlineCount = new StringBuffer();
			headlineCount.append(
        "SELECT COUNT(org_id) AS headlinecount " +
        "FROM organization " +
        "WHERE miner_only = " + DatabaseUtils.getTrue(db) + " " + 
        "AND industry_temp_code = 1 and enteredby = " + getUserId(context) + " ");
			pst = db.prepareStatement(headlineCount.toString());
			headline_rs = pst.executeQuery();
			if (headline_rs.next()) {
				headlines = headline_rs.getInt("headlinecount");
			}
			pst.close();
			headline_rs.close();

			if (headlines > 0) {
				indSelect.addItem(1, "My News");
			}

			//new

			if (industryCheck == null && headlines > 0) {
				industryCheck = "1";
			}
      
      sql.append("SELECT ");
      if (DatabaseUtils.getType(db) == DatabaseUtils.MSSQL) {
        sql.append("TOP 10 ");
      }
      sql.append("* FROM news ");

			if (industryCheck != null && !(industryCheck.equals("0"))) {
				whereClause = " WHERE organization.industry_temp_code = " + Integer.parseInt(industryCheck) + " ";
				if (industryCheck.equals("1")) {
					whereClause += 
          " AND news.org_id in ( organization.org_id, organization.duplicate_id ) " +
          "AND organization.enteredby = " + getUserId(context) + 
          "AND organization.miner_only = " + DatabaseUtils.getTrue(db) + " ";
				} else {
					whereClause += " AND organization.org_id = news.org_id ";
				}
				sql.append(whereClause);
			}
			else if (industryCheck == null || industryCheck.equals("0")) {
				sql.append(
          "WHERE organization.miner_only = " + DatabaseUtils.getFalse(db) + " " +
          "AND organization.org_id = news.org_id ");
			}

			context.getRequest().setAttribute("IndSelect", indSelect);

			//end

			sql.append(" ORDER BY dateentered DESC ");
      
      if (DatabaseUtils.getType(db) == DatabaseUtils.POSTGRESQL) {
        sql.append("LIMIT 10 ");
      }

			//System.out.println(sql.toString());
			st = db.createStatement();

			//Execute the main query
			rs = st.executeQuery(sql.toString());
			while (rs.next()) {
				NewsArticle thisNews = new NewsArticle(rs);
				newsList.addElement(thisNews);
			}
			rs.close();
			st.close();

			//Setup the calendar

			CalendarView companyCalendar = new CalendarView(context.getRequest());

			PagedListInfo alertPaged = new PagedListInfo();
			alertPaged.setMaxRecords(20);
			alertPaged.setColumnToSortBy("alertdate");

			CallList alertCalls = new CallList();
			alertCalls.setPagedListInfo(alertPaged);
			alertCalls.setEnteredBy(alertsDD);
			alertCalls.setHasAlertDate(true);
			alertCalls.buildList(db);
			Iterator m = alertCalls.iterator();
			while (m.hasNext()) {
				Call thisCall = (Call) m.next();
				if (thisCall.getOppId() == -1 && thisCall.getContactId() > -1) {
					companyCalendar.addEvent(thisCall.getAlertDateStringLongYear(), "", thisCall.getSubject(), "Contact Call", thisCall.getContactId(), thisCall.getId());
				} else {
					companyCalendar.addEvent(thisCall.getAlertDateStringLongYear(), "", thisCall.getSubject(), "Opportunity Call", thisCall.getOppId(), thisCall.getId());
				}
	
			}

			com.zeroio.iteam.base.ProjectList projects = new com.zeroio.iteam.base.ProjectList();
			projects.setGroupId(-1);
			projects.setOpenProjectsOnly(true);
			projects.setProjectsWithAssignmentsOnly(true);
			projects.setProjectsForUser(alertsDD);
			projects.setBuildAssignments(true);
			projects.setAssignmentsForUser(alertsDD);
			projects.setOpenAssignmentsOnly(true);
			projects.setBuildIssues(false);
			projects.buildList(db);
			Iterator projectList = projects.iterator();
			while (projectList.hasNext()) {
				com.zeroio.iteam.base.Project thisProject = (com.zeroio.iteam.base.Project) projectList.next();
				Iterator assignmentList = thisProject.getAssignments().iterator();
				while (assignmentList.hasNext()) {
					com.zeroio.iteam.base.Assignment thisAssignment = (com.zeroio.iteam.base.Assignment) assignmentList.next();
					//companyCalendar.addEvent(thisAssignment.getDueDate(), thisAssignment.getRole(), "Assignment", thisAssignment.getProjectId(), thisAssignment.getId());
          if (thisAssignment.getDueDate() != null) {
            CalendarEvent thisEvent = new CalendarEvent();
            thisEvent.setDate(thisAssignment.getDueDate());
            thisEvent.setSubject(thisAssignment.getRole());
            thisEvent.setCategory("Assignment");
            thisEvent.setId(thisAssignment.getProjectId());
            thisEvent.setIdsub(thisAssignment.getId());
            thisEvent.setIcon(thisAssignment.getStatusGraphicTag());
            companyCalendar.addEvent(thisEvent);
          }
				}
			}
			
			OpportunityList alertOpps = new OpportunityList();
			alertOpps.setPagedListInfo(alertPaged);
			alertOpps.setEnteredBy(alertsDD);
			alertOpps.setHasAlertDate(true);
			alertOpps.buildList(db);
			
			System.out.println("size of opps: " + alertOpps.size());
			
			Iterator n = alertOpps.iterator();
			while (n.hasNext()) {
				Opportunity thisOpp = (Opportunity) n.next();
				companyCalendar.addEvent(thisOpp.getAlertDateStringLongYear(), "", thisOpp.getDescription(), "Opportunity", thisOpp.getId());
			}

			context.getRequest().setAttribute("CompanyCalendar", companyCalendar);
		}
		catch (SQLException e) {
			errorMessage = e;
		}
		finally {
			this.freeConnection(context, db);
		}

		if (errorMessage == null) {
			context.getRequest().setAttribute("NewsList", newsList);
			return ("HomeOK");
		}
		else {
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		}
	}


	/**
	 *  Displays a list of profile items the user can select to modify
	 *
	 *@param  context  Description of Parameter
	 *@return          Description of the Returned Value
	 *@since
	 */
	public String executeCommandMyProfile(ActionContext context) {
		addModuleBean(context, "MyProfile", "");
		return ("MyProfileOK");
	}


	/**
	 *  The user wants to modify their name, etc.
	 *
	 *@param  context  Description of Parameter
	 *@return          Description of the Returned Value
	 *@since
	 */
	public String executeCommandMyCFSProfile(ActionContext context) {
		Exception errorMessage = null;
		Connection db = null;
		try {
			db = this.getConnection(context);
			buildFormElements(context, db);
			User thisUser = new User(db, this.getUserId(context));
			thisUser.setBuildContact(true);
			thisUser.buildResources(db);
			context.getRequest().setAttribute("User", thisUser);
			context.getRequest().setAttribute("EmployeeBean", thisUser.getContact());
		}
		catch (Exception e) {
			errorMessage = e;
			e.printStackTrace(System.out);
		}
		this.freeConnection(context, db);

		addModuleBean(context, "MyProfile", "");
		return ("ProfileOK");
	}


	/**
	 *  The user's name was modified
	 *
	 *@param  context  Description of Parameter
	 *@return          Description of the Returned Value
	 *@since
	 */
	public String executeCommandUpdateProfile(ActionContext context) {
		Exception errorMessage = null;
		
		Contact thisContact = (Contact)context.getFormBean();
		
		Connection db = null;
		int resultCount = 0;
		
		try {
			thisContact.setRequestItems(context.getRequest());
			thisContact.setModifiedBy(getUserId(context));
			db = this.getConnection(context);
			resultCount = thisContact.update(db);
			
			if (resultCount == -1) {
				processErrors(context, thisContact.getErrors());
				buildFormElements(context, db);
			}
			
		} catch (Exception e) {
			errorMessage = e;
		} finally {
			this.freeConnection(context, db);
		}
		
		if (errorMessage == null) {
			if (resultCount == -1) {
				return (executeCommandMyCFSProfile(context));
			} else if (resultCount == 1) {
				return ("UpdateProfileOK");
			} else {
			context.getRequest().setAttribute("Error",
			"<b>This record could not be updated because someone else updated it first.</b><p>" +
			"You can hit the back button to review the changes that could not be committed, " +
			"but you must reload the record and make the changes again.");
			return ("UserError");
			}
		} else {
		context.getRequest().setAttribute("Error", errorMessage);
		return ("SystemError");
		}
	}

	/**
	 *  The user wants to change the password
	 *
	 *@param  context  Description of Parameter
	 *@return          Description of the Returned Value
	 *@since
	 */
	public String executeCommandMyCFSPassword(ActionContext context) {
		Exception errorMessage = null;
		Connection db = null;
		try {
			db = this.getConnection(context);
			User thisUser = new User(db, this.getUserId(context));
			thisUser.setBuildContact(false);
			thisUser.buildResources(db);
			context.getRequest().setAttribute("User", thisUser);
		}
		catch (Exception e) {
			errorMessage = e;
			e.printStackTrace(System.out);
		}

		this.freeConnection(context, db);

		addModuleBean(context, "MyProfile", "");
		return ("PasswordOK");
	}


	/**
	 *  The password was modified
	 *
	 *@param  context  Description of Parameter
	 *@return          Description of the Returned Value
	 *@since
	 */
	public String executeCommandUpdatePassword(ActionContext context) {
		Exception errorMessage = null;
		Connection db = null;
		int resultCount = 0;

		User tempUser = (User) context.getFormBean();

		try {
			db = getConnection(context);

			User thisUser = new User(db, this.getUserId(context));
			thisUser.setBuildContact(false);
			thisUser.buildResources(db);

			resultCount = tempUser.updatePassword(db, context, thisUser.getPassword());

		}
		catch (SQLException e) {
			errorMessage = e;
		}
		finally {
			this.freeConnection(context, db);
		}

		if (resultCount == -1) {
			processErrors(context, tempUser.getErrors());
			context.getRequest().setAttribute("NewUser", tempUser);
		}

		if (errorMessage == null) {
			if (resultCount == -1) {
				return (executeCommandMyCFSPassword(context));
			}
			else if (resultCount == 1) {
				return ("UpdatePasswordOK");
			}
			else {
				context.getRequest().setAttribute("Error",
						"<b>This record could not be updated because someone else updated it first.</b><p>" +
						"You can hit the back button to review the changes that could not be committed, " +
						"but you must reload the record and make the changes again.");
				return ("UserError");
			}
		}
		else {
			context.getRequest().setAttribute("Error", errorMessage);
			return ("SystemError");
		}

	}


	/**
	 *  Description of the Method
	 *
	 *@param  context  Description of Parameter
	 *@return          Description of the Returned Value
	 *@since
	 */
	public String executeCommandMyCFSSettings(ActionContext context) {
		Exception errorMessage = null;
		Connection db = null;
		try {
			db = this.getConnection(context);
			User thisUser = new User(db, this.getUserId(context));
			thisUser.setBuildContact(true);
			thisUser.buildResources(db);
			context.getRequest().setAttribute("User", thisUser);
			context.getRequest().setAttribute("EmployeeBean", thisUser.getContact());
		}
		catch (Exception e) {
			errorMessage = e;
			e.printStackTrace(System.out);
		}
		this.freeConnection(context, db);

		addModuleBean(context, "MyProfile", "");
		return ("SettingsOK");
	}


	/**
	 *  Description of the Method
	 *
	 *@param  context  Description of Parameter
	 *@return          Description of the Returned Value
	 *@since
	 */
	public String executeCommandUpdateSettings(ActionContext context) {
		return ("UpdateSettingsOK");
	}


	/**
	 *  Description of the Method
	 *
	 *@param  context           Description of Parameter
	 *@param  db                Description of Parameter
	 *@exception  SQLException  Description of Exception
	 *@since
	 */
	protected void buildFormElements(ActionContext context, Connection db) throws SQLException {
		LookupList departmentList = new LookupList(db, "lookup_department");
		departmentList.addItem(0, "--None--");
		context.getRequest().setAttribute("DepartmentList", departmentList);
    
		LookupList phoneTypeList = new LookupList(db, "lookup_contactphone_types");
		context.getRequest().setAttribute("ContactPhoneTypeList", phoneTypeList);

		LookupList emailTypeList = new LookupList(db, "lookup_contactemail_types");
		context.getRequest().setAttribute("ContactEmailTypeList", emailTypeList);

		LookupList addressTypeList = new LookupList(db, "lookup_contactaddress_types");
		context.getRequest().setAttribute("ContactAddressTypeList", addressTypeList);
	}
}

