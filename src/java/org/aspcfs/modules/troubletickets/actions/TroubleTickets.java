package com.darkhorseventures.cfsmodule;

import javax.servlet.*;
import javax.servlet.http.*;
import org.theseus.actions.*;
import java.io.*;
import java.sql.*;
import java.util.*;
import com.darkhorseventures.utils.*;
import com.darkhorseventures.cfsbase.*;
import com.darkhorseventures.webutils.*;

/**
 *  Description of the Class
 *
 *@author     matt
 *@created    March 15, 2002
 *@version
 */
public final class TroubleTickets extends CFSModule {

  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandAdd(ActionContext context) {
	  
	if (!(hasPermission(context, "tickets-tickets-add"))) {
	    return ("PermissionError");
    	}
	
    int errorCode = 0;
    Exception errorMessage = null;
    Connection db = null;
    Ticket newTic = null;

    try {
      db = this.getConnection(context);

      if (context.getRequest().getParameter("refresh") != null || (context.getRequest().getParameter("contact") != null && context.getRequest().getParameter("contact").equals("on"))) {
        newTic = (Ticket) context.getFormBean();
        newTic.getHistory().setTicketId(newTic.getId());
        newTic.getHistory().buildList(db);
      } else {
        newTic = new Ticket();
      }

      buildFormElements(context, db, newTic);

    } catch (Exception e) {
      errorCode = 1;
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorCode == 0) {
      addModuleBean(context, "AddTicket", "Ticket Add");
      return ("AddOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      context.getRequest().setAttribute("ThisContact", newTic.getThisContact());
      return ("SystemError");
    }

  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandModify(ActionContext context) {
	  
	if (!(hasPermission(context, "tickets-tickets-edit"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;
    Ticket newTic = null;

    try {
      String ticketId = context.getRequest().getParameter("id");
      db = this.getConnection(context);

      if (context.getRequest().getParameter("companyName") == null) {
        newTic = new Ticket(db, Integer.parseInt(ticketId));
      } else {
        newTic = (Ticket) context.getFormBean();
        newTic.getHistory().setTicketId(newTic.getId());
        newTic.getHistory().buildList(db);
      }

      LookupList departmentList = new LookupList(db, "lookup_department");
      departmentList.addItem(0, "-- None --");
      departmentList.setJsEvent("onChange = javascript:document.forms[0].action='/TroubleTickets.do?command=Modify&passedid=" + newTic.getId() + "&auto-populate=true#department';document.forms[0].submit()");
      context.getRequest().setAttribute("DepartmentList", departmentList);

      LookupList severityList = new LookupList(db, "ticket_severity");
      context.getRequest().setAttribute("SeverityList", severityList);

      LookupList priorityList = new LookupList(db, "ticket_priority");
      context.getRequest().setAttribute("PriorityList", priorityList);

      LookupList sourceList = new LookupList(db, "lookup_ticketsource");
      sourceList.addItem(0, "-- None --");
      context.getRequest().setAttribute("SourceList", sourceList);

      TicketCategoryList categoryList = new TicketCategoryList();
      categoryList.setCatLevel(0);
      categoryList.setParentCode(0);
      categoryList.setHtmlJsEvent("onChange = javascript:document.forms[0].action='/TroubleTickets.do?command=Modify&passedid=" + newTic.getId() + "&auto-populate=true&refresh=1#categories';document.forms[0].submit()");
      categoryList.buildList(db);
      context.getRequest().setAttribute("CategoryList", categoryList);

      UserList userList = new UserList();
      userList.setEmptyHtmlSelectRecord("-- None --");
      userList.setBuildContact(true);
      userList.setDepartment(newTic.getDepartmentCode());
      userList.buildList(db);
      context.getRequest().setAttribute("UserList", userList);

      OrganizationList orgList = new OrganizationList();
      orgList.setMinerOnly(false);
      orgList.setHtmlJsEvent("onChange = javascript:document.forms[0].action='/TroubleTickets.do?command=Modify&passedid=" + newTic.getId() + "&auto-populate=true';document.forms[0].submit()");
      orgList.setShowMyCompany(true);
      orgList.buildList(db);
      context.getRequest().setAttribute("OrgList", orgList);

      TicketCategoryList subList1 = new TicketCategoryList();

      subList1.setCatLevel(1);
      subList1.setParentCode(newTic.getCatCode());
      subList1.setHtmlJsEvent("onChange = javascript:document.forms[0].action='/TroubleTickets.do?command=Modify&passedid=" + newTic.getId() + "&auto-populate=true&refresh=2#categories';document.forms[0].submit()");
      subList1.buildList(db);
      context.getRequest().setAttribute("SubList1", subList1);

      ContactList contactList = new ContactList();
      contactList.setPersonalId(getUserId(context));
      //contactList.setTypeId(Integer.parseInt(typeId));
      contactList.setBuildDetails(false);
      contactList.setOrgId(newTic.getOrgId());

      if (newTic.getOrgId() == -1) {
        contactList.setShowEmployeeContacts(true);
      }

      contactList.buildList(db);
      context.getRequest().setAttribute("ContactList", contactList);

      TicketCategoryList subList2 = new TicketCategoryList();
      subList2.setCatLevel(2);

      if (context.getRequest().getParameter("refresh") != null && Integer.parseInt(context.getRequest().getParameter("refresh")) == 1) {
        subList2.setParentCode(0);
        newTic.setSubCat1(0);
        newTic.setSubCat2(0);
        newTic.setSubCat3(0);
      } else if (context.getRequest().getParameter("refresh") != null && Integer.parseInt(context.getRequest().getParameter("refresh")) == -1) {
        subList2.setParentCode(newTic.getSubCat1());
        subList2.getCatListSelect().setDefaultKey(newTic.getSubCat2());
      } else {
        subList2.setParentCode(newTic.getSubCat1());
      }

      subList2.setHtmlJsEvent("onChange = javascript:document.forms[0].action='/TroubleTickets.do?command=Modify&passedid=" + newTic.getId() + "&auto-populate=true&refresh=3#categories';document.forms[0].submit()");
      subList2.buildList(db);
      context.getRequest().setAttribute("SubList2", subList2);

      TicketCategoryList subList3 = new TicketCategoryList();
      subList3.setCatLevel(3);

      if (context.getRequest().getParameter("refresh") != null && (Integer.parseInt(context.getRequest().getParameter("refresh")) == 1 || Integer.parseInt(context.getRequest().getParameter("refresh")) == 2)) {
        subList3.setParentCode(0);
        newTic.setSubCat2(0);
        newTic.setSubCat3(0);
      } else if (context.getRequest().getParameter("refresh") != null && Integer.parseInt(context.getRequest().getParameter("refresh")) == -1) {
        subList3.setParentCode(newTic.getSubCat2());
        subList3.getCatListSelect().setDefaultKey(newTic.getSubCat3());
      } else {
        subList3.setParentCode(newTic.getSubCat2());
      }

      subList3.buildList(db);
      context.getRequest().setAttribute("SubList3", subList3);

      if (context.getRequest().getParameter("refresh") != null && (Integer.parseInt(context.getRequest().getParameter("refresh")) == 1 || Integer.parseInt(context.getRequest().getParameter("refresh")) == 3)) {
        newTic.setSubCat3(0);
      }

      context.getRequest().setAttribute("TicketDetails", newTic);
      addRecentItem(context, newTic);

    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorMessage == null) {
      context.getRequest().setAttribute("TicketDetails", newTic);
      addModuleBean(context, "ViewTickets", "View Tickets");
      return ("ModifyOK");
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
   */
  public String executeCommandDetails(ActionContext context) {
	  
	if (!(hasPermission(context, "tickets-tickets-view"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;
    Ticket newTic = null;
    String ticketId = null;

    PagedListInfo ticListInfo = this.getPagedListInfo(context, "TicketDetails");

    ticListInfo.setColumnToSortBy("entered");

    try {
      ticketId = context.getRequest().getParameter("id");
      db = this.getConnection(context);
      newTic = new Ticket(db, Integer.parseInt(ticketId));
      newTic.getHistory().setPagedListInfo(ticListInfo);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "View Tickets", "Ticket Details");
    if (errorMessage == null) {
      context.getRequest().setAttribute("TicketDetails", newTic);
      addRecentItem(context, newTic);
      addModuleBean(context, "ViewTickets", "View Tickets");
      return ("DetailsOK");
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
   */
  public String executeCommandHome(ActionContext context) {
	  
 	if (!(hasPermission(context, "tickets-tickets-view"))) {
	    return ("PermissionError");
    	}
	
    int errorCode = 0;
    Exception errorMessage = null;

    Connection db = null;
    Statement st = null;
    ResultSet rs = null;

    TicketList ticList = new TicketList();

    String passedId = context.getRequest().getParameter("searchId");
    String passedOrgId = context.getRequest().getParameter("searchOrgId");
    String passedPriority = context.getRequest().getParameter("searchPriority");
    String passedSeverity = context.getRequest().getParameter("searchSeverity");
    String passedType = context.getRequest().getParameter("type");

    UserBean thisUser = (UserBean) context.getSession().getAttribute("User");

    PagedListInfo ticListInfo = this.getPagedListInfo(context, "TicListInfo");
    ticListInfo.setLink("/TroubleTickets.do?command=Home");

    String searchString = context.getRequest().getParameter("search");

    //search stuff

    if (passedId != null && !(passedId.equals(""))) {
      ticList.setId(passedId);
    }
    if (passedOrgId != null && !(passedOrgId.equals(""))) {
      ticList.setOrgId(passedOrgId);
    }

    if (passedSeverity != null && !(passedSeverity.equals(""))) {
      ticList.setSeverity(passedSeverity);
    }
    if (passedPriority != null && !(passedPriority.equals(""))) {
      ticList.setPriority(passedPriority);
    }

    if (passedType != null && passedType.equals("1")) {
      ticList.setOnlyOpen(true);
    } else if (passedType != null && passedType.equals("2")) {
      ticList.setOnlyClosed(true);
    }

    //end

    try {
      db = this.getConnection(context);

      if (searchString == null || searchString.equals("")) {
        if (ticListInfo.getListView() == null) {
          ticListInfo.setListView("A");
        }

        ticList.setOnlyOpen(true);

        if ("A".equals(ticListInfo.getListView())) {
          ticList.setUnassignedToo(true);
          //ticList.setOwnerIdRange(this.getUserRange(context));
          ticList.setDepartment(thisUser.getUserRecord().getContact().getDepartment());
        } else if ("B".equals(ticListInfo.getListView())) {
          ticList.setAssignedTo(getUserId(context));
          //ticList.setOwner(this.getUserId(context));
          ticList.setDepartment(thisUser.getUserRecord().getContact().getDepartment());
        } else {
          ticList.setUnassignedToo(true);
          //ticList.setOwner(this.getUserId(context));
          ticList.setEnteredBy(getUserId(context));
        }

      }

      ticList.setPagedListInfo(ticListInfo);
      ticList.buildList(db);

    } catch (Exception e) {
      errorCode = 1;
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "ViewTickets", "View Tickets");
    context.getRequest().setAttribute("TicList", ticList);

    if (errorCode == 0) {
      addModuleBean(context, "ViewTickets", "View Tickets");
      return ("HomeOK");
    } else {
      return ("SystemError");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandInsert(ActionContext context) {
	  
	if (!(hasPermission(context, "tickets-tickets-add"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;
    int resultCount = 0;
    boolean recordInserted = false;
    boolean contactRecordInserted = false;

    Contact nc = null;
    Ticket newTicket = null;

    String newContact = context.getRequest().getParameter("contact");
    String closeNow = context.getRequest().getParameter("closeNow");

    Ticket newTic = (Ticket) context.getFormBean();

    newTic.setEnteredBy(getUserId(context));
    newTic.setModifiedBy(getUserId(context));

    if (newContact != null && newContact.equals("on")) {
      nc = new Contact();
      nc.setNameFirst(context.getRequest().getParameter("thisContact_nameFirst"));
      nc.setNameLast(context.getRequest().getParameter("thisContact_nameLast"));
      nc.setTitle(context.getRequest().getParameter("thisContact_title"));
      nc.setRequestItems(context.getRequest());
      nc.setOrgId(newTic.getOrgId());
      nc.setEnteredBy(getUserId(context));
      nc.setModifiedBy(getUserId(context));
      nc.setOwner(getUserId(context));
      nc.setTypeId(0);
    }

    if (closeNow != null && closeNow.equals("on")) {
      newTic.setCloseIt(true);
    }

    try {
      db = this.getConnection(context);

      if (nc != null) {
        contactRecordInserted = nc.insert(db);
        if (contactRecordInserted) {
          newTic.setContactId(nc.getId());
        } else {
          processErrors(context, nc.getErrors());
        }

        if (contactRecordInserted) {
          recordInserted = newTic.insert(db);
        }
      } else {
        recordInserted = newTic.insert(db);
      }

      if (recordInserted) {
        newTicket = new Ticket(db, newTic.getId());
        context.getRequest().setAttribute("TicketDetails", newTicket);
        addRecentItem(context, newTicket);
      } else {
        processErrors(context, newTic.getErrors());
      }

    } catch (SQLException e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    if (errorMessage == null) {
      addModuleBean(context, "ViewTickets", "Ticket Insert ok");
      if (recordInserted) {
        return ("InsertOK");
      } else {
        return (executeCommandAdd(context));
      }
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
   */
  public String executeCommandSearchTicketsForm(ActionContext context) {
	  
	if (!(hasPermission(context, "tickets-tickets-view"))) {
	    return ("PermissionError");
    	}
	
    int errorCode = 0;

    Exception errorMessage = null;

    Connection db = null;

    HtmlSelect ticketTypeSelect = new HtmlSelect();
    ticketTypeSelect.setSelectName("type");
    ticketTypeSelect.addItem("0", "-- Any --");
    ticketTypeSelect.addItem("1", "Open");
    ticketTypeSelect.addItem("2", "Closed");
    ticketTypeSelect.build();
    context.getRequest().setAttribute("TicketTypeSelect", ticketTypeSelect);

    try {
      db = this.getConnection(context);

      OrganizationList orgList = new OrganizationList();
      orgList.setMinerOnly(false);
      orgList.setShowMyCompany(true);
      orgList.buildList(db);
      context.getRequest().setAttribute("OrgList", orgList);

      LookupList severityList = new LookupList(db, "ticket_severity");
      severityList.addItem(0, "-- Any --");
      context.getRequest().setAttribute("SeverityList", severityList);

      LookupList priorityList = new LookupList(db, "ticket_priority");
      priorityList.addItem(0, "-- Any --");
      context.getRequest().setAttribute("PriorityList", priorityList);
    } catch (Exception e) {
      errorCode = 1;
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorCode == 0) {
      addModuleBean(context, "SearchTickets", "Tickets Search");
      return ("SearchTicketsFormOK");
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
   */
  public String executeCommandUpdate(ActionContext context) {
	  
	if (!(hasPermission(context, "tickets-tickets-edit"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;
    int resultCount = 0;

    int catCount = 0;
    TicketCategory thisCat = null;
    boolean catInserted = false;
    boolean smartCommentsResult = true;

    String closeNow = context.getRequest().getParameter("closeNow");

    Ticket newTic = (Ticket) context.getFormBean();

    if (closeNow != null && closeNow.equals("on")) {
      newTic.setCloseIt(true);
    }

    try {
      db = this.getConnection(context);

      for (catCount = 0; catCount < 4; catCount++) {
        if ((context.getRequest().getParameter("newCat" + catCount + "chk") != null && context.getRequest().getParameter("newCat" + catCount + "chk").equals("on") && context.getRequest().getParameter("newCat" + catCount) != null && !(context.getRequest().getParameter("newCat" + catCount).equals("")))) {
          thisCat = new TicketCategory();

          if (catCount == 0) {
            thisCat.setParentCode(0);
          } else if (catCount == 1) {
            thisCat.setParentCode(newTic.getCatCode());
          } else if (catCount == 2) {
            thisCat.setParentCode(newTic.getSubCat1());
          } else {
            thisCat.setParentCode(newTic.getSubCat2());
          }

          thisCat.setDescription(context.getRequest().getParameter("newCat" + catCount));
          thisCat.setLevel(catCount);
          catInserted = thisCat.insert(db);

          if (catInserted == true) {
            if (catCount == 0) {
              newTic.setCatCode(thisCat.getId());
            } else if (catCount == 1) {
              newTic.setSubCat1(thisCat.getId());
            } else if (catCount == 2) {
              newTic.setSubCat2(thisCat.getId());
            } else {
              newTic.setSubCat3(thisCat.getId());
            }
          }
        }
      }

      newTic.setModifiedBy(getUserId(context));
      resultCount = newTic.update(db);

    } catch (SQLException e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (resultCount == -1) {
      processErrors(context, newTic.getErrors());
    }

    if (errorMessage == null) {
      if (resultCount == -1) {
        return (executeCommandModify(context));
      } else if (resultCount == 1) {
        return ("UpdateOK");
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
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandDelete(ActionContext context) {
	  
	if (!(hasPermission(context, "tickets-tickets-delete"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    boolean recordDeleted = false;

    String passedId = null;

    Ticket thisTic = null;
    passedId = context.getRequest().getParameter("id");

    Connection db = null;

    try {
      db = this.getConnection(context);
      thisTic = new Ticket(db, Integer.parseInt(passedId));
      recordDeleted = thisTic.delete(db);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorMessage == null) {
      if (recordDeleted) {
        deleteRecentItem(context, thisTic);
        return ("DeleteOK");
      } else {
        return (executeCommandHome(context));
      }
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  context           Description of Parameter
   *@param  db                Description of Parameter
   *@param  newTic            Description of Parameter
   *@exception  SQLException  Description of Exception
   */
  protected void buildFormElements(ActionContext context, Connection db, Ticket newTic) throws SQLException {

    LookupList departmentList = new LookupList(db, "lookup_department");
    departmentList.addItem(0, "-- None --");
    departmentList.setJsEvent("onChange = javascript:document.forms[0].action='/TroubleTickets.do?command=Add&auto-populate=true#department';document.forms[0].submit()");
    context.getRequest().setAttribute("DepartmentList", departmentList);

    LookupList severityList = new LookupList(db, "ticket_severity");
    context.getRequest().setAttribute("SeverityList", severityList);

    LookupList priorityList = new LookupList(db, "ticket_priority");
    context.getRequest().setAttribute("PriorityList", priorityList);

    LookupList sourceList = new LookupList(db, "lookup_ticketsource");
    sourceList.addItem(0, "-- None --");
    context.getRequest().setAttribute("SourceList", sourceList);

    TicketCategoryList categoryList = new TicketCategoryList();
    categoryList.setCatLevel(0);
    categoryList.setParentCode(0);
    categoryList.setHtmlJsEvent("onChange = javascript:document.forms[0].action='/TroubleTickets.do?command=Add&auto-populate=true&refresh=1#categories';document.forms[0].submit()");
    categoryList.buildList(db);
    context.getRequest().setAttribute("CategoryList", categoryList);

    ContactList contactList = new ContactList();

    if (newTic != null && newTic.getOrgId() != -1) {
      contactList.setBuildDetails(false);
      contactList.setPersonalId(getUserId(context));
      contactList.setOrgId(newTic.getOrgId());
      contactList.buildList(db);
    }

    context.getRequest().setAttribute("ContactList", contactList);

    UserList userList = new UserList();
    userList.setEmptyHtmlSelectRecord("-- None --");
    userList.setBuildContact(true);
    userList.setDepartment(newTic.getDepartmentCode());
    userList.buildList(db);
    context.getRequest().setAttribute("UserList", userList);

    OrganizationList orgList = new OrganizationList();
    orgList.setMinerOnly(false);
    orgList.setHtmlJsEvent("onChange = javascript:document.forms[0].action='/TroubleTickets.do?command=Add&auto-populate=true';document.forms[0].submit()");
    orgList.setShowMyCompany(true);
    orgList.buildList(db);
    context.getRequest().setAttribute("OrgList", orgList);

    TicketCategoryList subList1 = new TicketCategoryList();

    subList1.setCatLevel(1);
    subList1.setParentCode(newTic.getCatCode());
    subList1.setHtmlJsEvent("onChange = javascript:document.forms[0].action='/TroubleTickets.do?command=Add&auto-populate=true&refresh=2#categories';document.forms[0].submit()");
    subList1.buildList(db);
    context.getRequest().setAttribute("SubList1", subList1);

    TicketCategoryList subList2 = new TicketCategoryList();
    subList2.setCatLevel(2);

    if (context.getRequest().getParameter("refresh") != null && Integer.parseInt(context.getRequest().getParameter("refresh")) == 1) {
      subList2.setParentCode(0);
      newTic.setSubCat1(0);
      newTic.setSubCat2(0);
      newTic.setSubCat3(0);
    } else if (context.getRequest().getParameter("refresh") != null && Integer.parseInt(context.getRequest().getParameter("refresh")) == -1) {
      subList2.setParentCode(newTic.getSubCat1());
      subList2.getCatListSelect().setDefaultKey(newTic.getSubCat2());
    } else {
      subList2.setParentCode(newTic.getSubCat1());
    }

    subList2.setHtmlJsEvent("onChange = javascript:document.forms[0].action='/TroubleTickets.do?command=Add&auto-populate=true&refresh=3#categories';document.forms[0].submit()");
    subList2.buildList(db);
    context.getRequest().setAttribute("SubList2", subList2);

    TicketCategoryList subList3 = new TicketCategoryList();
    subList3.setCatLevel(3);

    if (context.getRequest().getParameter("refresh") != null && (Integer.parseInt(context.getRequest().getParameter("refresh")) == 1 || Integer.parseInt(context.getRequest().getParameter("refresh")) == 2)) {
      subList3.setParentCode(0);
      newTic.setSubCat2(0);
      newTic.setSubCat3(0);
    } else if (context.getRequest().getParameter("refresh") != null && Integer.parseInt(context.getRequest().getParameter("refresh")) == -1) {
      subList3.setParentCode(newTic.getSubCat2());
      subList3.getCatListSelect().setDefaultKey(newTic.getSubCat3());
    } else {
      subList3.setParentCode(newTic.getSubCat2());
    }

    subList3.buildList(db);
    context.getRequest().setAttribute("SubList3", subList3);

    if (context.getRequest().getParameter("refresh") != null && (Integer.parseInt(context.getRequest().getParameter("refresh")) == 1 || Integer.parseInt(context.getRequest().getParameter("refresh")) == 3)) {
      newTic.setSubCat3(0);
    }

    context.getRequest().setAttribute("TicketDetails", newTic);
  }

}

