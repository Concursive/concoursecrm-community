package org.aspcfs.modules.accounts.actions;

import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.*;
import java.text.*;
import java.io.*;
import com.zeroio.iteam.base.*;
import com.zeroio.webutils.*;
import com.darkhorseventures.framework.actions.*;
import org.aspcfs.utils.*;
import org.aspcfs.utils.web.*;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.accounts.base.*;
import org.aspcfs.modules.base.*;
import org.aspcfs.modules.mycfs.base.*;
import org.aspcfs.modules.admin.base.*;
import org.aspcfs.modules.login.beans.*;
import org.aspcfs.modules.mycfs.beans.*;
import org.aspcfs.modules.contacts.base.*;
import org.aspcfs.modules.troubletickets.base.*;
import org.aspcfs.modules.admin.base.AccessType;
import org.aspcfs.modules.admin.base.AccessTypeList;
import org.aspcfs.modules.pipeline.base.OpportunityReport;

/**
 *  Actions for the Accounts module
 *
 *@author     chris
 *@created    August 15, 2001
 *@version    $Id$
 */
public final class Accounts extends CFSModule {

  /**
   *  Default: not used
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandDefault(ActionContext context) {

    return executeCommandDashboard(context);
  }


  /**
   *  Reports: Displays a list of previously generated reports with
   *  view/delete/download options.
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandReports(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-reports-view")) {
      return ("PermissionError");
    }
    //Set the menu: the user is in the Reports module
    addModuleBean(context, "Reports", "ViewReports");
    //Retrieve the paged list that will be used for paging through reports
    PagedListInfo rptListInfo = this.getPagedListInfo(context, "RptListInfo");
    rptListInfo.setLink("Accounts.do?command=Reports");
    //Prepare the file list for accounts
    FileItemList files = new FileItemList();
    files.setLinkModuleId(Constants.DOCUMENTS_ACCOUNTS_REPORTS);
    files.setPagedListInfo(rptListInfo);
    //Check the combo box value from the report list for filtering reports
    if ("all".equals(rptListInfo.getListView())) {
      //Show only the reports that this user or someone below this user created
      files.setOwnerIdRange(this.getUserRange(context));
    } else {
      //Show only this user's reports
      files.setOwner(this.getUserId(context));
    }
    Connection db = null;
    try {
      //Get a connection from the connection pool for this user
      db = this.getConnection(context);
      //Generate the list of files based on the above criteria
      files.buildList(db);
      context.getRequest().setAttribute("FileList", files);
    } catch (Exception errorMessage) {
      //An error occurred, go to generic error message page
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      //Always free the database connection
      this.freeConnection(context, db);
    }
    return ("ReportsOK");
  }


  /**
   *  DownloadCSVReport: Sends a copy of the CSV report to the user's local
   *  machine
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandDownloadCSVReport(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-reports-view"))) {
      return ("PermissionError");
    }
    Exception errorMessage = null;
    String itemId = (String) context.getRequest().getParameter("fid");
    FileItem thisItem = null;
    Connection db = null;
    try {
      db = getConnection(context);
      thisItem = new FileItem(db, Integer.parseInt(itemId), -1, Constants.DOCUMENTS_ACCOUNTS_REPORTS);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    //Start the download
    try {
      FileItem itemToDownload = null;
      itemToDownload = thisItem;
      //itemToDownload.setEnteredBy(this.getUserId(context));
      String filePath = this.getPath(context, "account-reports") + getDatePath(itemToDownload.getEntered()) + itemToDownload.getFilename() + ".csv";
      FileDownload fileDownload = new FileDownload();
      fileDownload.setFullPath(filePath);
      fileDownload.setDisplayName(itemToDownload.getClientFilename());
      if (fileDownload.fileExists()) {
        fileDownload.sendFile(context);
        //Get a db connection now that the download is complete
        db = getConnection(context);
        itemToDownload.updateCounter(db);
      } else {
        System.err.println("Accounts-> Trying to send a file that does not exist");
      }
    } catch (java.net.SocketException se) {
      //User either cancelled the download or lost connection
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }
    if (errorMessage == null) {
      return ("-none-");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  ShowReportHtml: Displays a preview of the selected report in HTML format
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandShowReportHtml(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-reports-view"))) {
      return ("PermissionError");
    }
    Exception errorMessage = null;
    FileItem thisItem = null;
    String projectId = (String) context.getRequest().getParameter("pid");
    String itemId = (String) context.getRequest().getParameter("fid");
    Connection db = null;
    try {
      db = getConnection(context);
      thisItem = new FileItem(db, Integer.parseInt(itemId), -1, Constants.DOCUMENTS_ACCOUNTS_REPORTS);
      String filePath = this.getPath(context, "account-reports") + getDatePath(thisItem.getEntered()) + thisItem.getFilename() + ".html";
      String textToShow = this.includeFile(filePath);
      context.getRequest().setAttribute("ReportText", textToShow);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    return ("ReportHtmlOK");
  }


  /**
   *  GenerateForm: Displays the form that allows the user to select criteria
   *  and specify information for a new Accounts report
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandGenerateForm(ActionContext context) {

    if (!(hasPermission(context, "accounts-accounts-reports-add"))) {
      return ("PermissionError");
    }

    Exception errorMessage = null;
    Connection db = null;

    CustomFieldCategoryList thisList = new CustomFieldCategoryList();
    thisList.setLinkModuleId(Constants.ACCOUNTS);
    thisList.setIncludeEnabled(Constants.TRUE);
    thisList.setIncludeScheduled(Constants.TRUE);
    thisList.setAllSelectOption(true);
    thisList.setBuildResources(false);

    try {
      db = getConnection(context);
      thisList.buildList(db);
      context.getRequest().setAttribute("CategoryList", thisList);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Reports", "Generate new");
    return ("GenerateFormOK");
  }


  /**
   *  ExportReport: Creates both an HTML version (for preview) and a CSV version
   *  of the report
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandExportReport(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-reports-add")) {
      return ("PermissionError");
    }
    Exception errorMessage = null;
    boolean recordInserted = false;
    Connection db = null;
    //Parameters
    String subject = context.getRequest().getParameter("subject");
    String type = context.getRequest().getParameter("type");
    String ownerCriteria = context.getRequest().getParameter("criteria1");
    //File path
    String filePath = this.getPath(context, "account-reports");
    SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy");
    String datePathToUse1 = formatter1.format(new java.util.Date());
    SimpleDateFormat formatter2 = new SimpleDateFormat("MMdd");
    String datePathToUse2 = formatter2.format(new java.util.Date());
    filePath += datePathToUse1 + fs + datePathToUse2 + fs;
    //Populate the report criteria
    OrganizationReport orgReport = new OrganizationReport();
    orgReport.setCriteria(context.getRequest().getParameterValues("selectedList"));
    orgReport.setFilePath(filePath);
    orgReport.setSubject(subject);
    orgReport.setMinerOnly(false);
    if (ownerCriteria.equals("my")) {
      orgReport.setOwnerId(this.getUserId(context));
    } else if (ownerCriteria.equals("levels")) {
      orgReport.setOwnerIdRange(this.getUserRange(context));
    }
    try {
      db = this.getConnection(context);
      //Accounts with opportunities report
      if (type.equals("5")) {
        OpportunityReport oppReport = new OpportunityReport();
        oppReport.setHeader("CFS Accounts");
        oppReport.setFilePath(filePath);
        oppReport.setEnteredBy(getUserId(context));
        oppReport.setModifiedBy(getUserId(context));
        oppReport.setSubject(subject);
        if (ownerCriteria.equals("my")) {
          oppReport.setLimitId(this.getUserId(context));
        } else if (ownerCriteria.equals("levels")) {
          oppReport.setAccountOwnerIdRange(this.getUserRange(context));
        }
        oppReport.setCriteria(null);
        oppReport.getOrgReportJoin().setCriteria(context.getRequest().getParameterValues("selectedList"));
        oppReport.setJoinOrgs(true);
        oppReport.buildReportFull(db, context);
        orgReport.setEnteredBy(getUserId(context));
        orgReport.setModifiedBy(getUserId(context));
        oppReport.saveAndInsert(db);
      } else if (type.equals("2")) {
        ContactReport contactReport = new ContactReport();
        contactReport.setFilePath(filePath);
        contactReport.setEnteredBy(getUserId(context));
        contactReport.setModifiedBy(getUserId(context));
        contactReport.setSubject(subject);
        contactReport.setHeader("CFS Accounts");
        contactReport.addIgnoreTypeId(Contact.EMPLOYEE_TYPE);
        contactReport.setCriteria(null);
        contactReport.getOrgReportJoin().setCriteria(context.getRequest().getParameterValues("selectedList"));
        if (ownerCriteria.equals("my")) {
          contactReport.setLimitId(this.getUserId(context));
          contactReport.setOwner(this.getUserId(context));
        } else if (ownerCriteria.equals("levels")) {
          contactReport.setAccountOwnerIdRange(this.getUserRange(context));
        }
        contactReport.setJoinOrgs(true);
        contactReport.buildReportFull(db);
        contactReport.saveAndInsert(db);
      } else if (type.equals("3")) {
        TicketReport ticReport = new TicketReport();
        ticReport.setFilePath(filePath);
        ticReport.setEnteredBy(getUserId(context));
        ticReport.setModifiedBy(getUserId(context));
        ticReport.setSubject(subject);
        ticReport.setHeader("CFS Accounts");
        ticReport.setJoinOrgs(true);
        if (ownerCriteria.equals("my")) {
          ticReport.setLimitId(this.getUserId(context));
        } else if (ownerCriteria.equals("levels")) {
          ticReport.setAccountOwnerIdRange(this.getUserRange(context));
        }
        ticReport.setCriteria(null);
        ticReport.getOrgReportJoin().setCriteria(context.getRequest().getParameterValues("selectedList"));
        ticReport.buildReportFull(db, context);
        ticReport.saveAndInsert(db);
      } else {
        int folderId = Integer.parseInt(context.getRequest().getParameter("catId"));
        if (type.equals("4") && folderId == 0) {
          orgReport.setIncludeFolders(true);
        } else if (type.equals("4") && folderId > 0) {
          orgReport.setFolderId(folderId);
        }
        orgReport.setEnteredBy(getUserId(context));
        orgReport.setModifiedBy(getUserId(context));
        orgReport.buildReportFull(db);
        orgReport.saveAndInsert(db);
      }
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    if (errorMessage == null) {
      return executeCommandReports(context);
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  DeleteReport: Deletes previously generated report files (HTML and CSV)
   *  from server and all related file information from the project_files table.
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandDeleteReport(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-reports-delete"))) {
      return ("PermissionError");
    }
    Exception errorMessage = null;
    boolean recordDeleted = false;
    String projectId = (String) context.getRequest().getParameter("pid");
    String itemId = (String) context.getRequest().getParameter("fid");
    Connection db = null;
    try {
      db = getConnection(context);
      FileItem thisItem = new FileItem(db, Integer.parseInt(itemId), -1, Constants.DOCUMENTS_ACCOUNTS_REPORTS);
      recordDeleted = thisItem.delete(db, this.getPath(context, "account-reports"));
      String filePath1 = this.getPath(context, "account-reports") + getDatePath(thisItem.getEntered()) + thisItem.getFilename() + ".csv";
      java.io.File fileToDelete1 = new java.io.File(filePath1);
      if (!fileToDelete1.delete()) {
        System.err.println("FileItem-> Tried to delete file: " + filePath1);
      }
      String filePath2 = this.getPath(context, "account-reports") + getDatePath(thisItem.getEntered()) + thisItem.getFilename() + ".html";
      java.io.File fileToDelete2 = new java.io.File(filePath2);
      if (!fileToDelete2.delete()) {
        System.err.println("FileItem-> Tried to delete file: " + filePath2);
      }
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Reports", "Reports del");
    if (errorMessage == null) {
      if (recordDeleted) {
        return ("DeleteReportOK");
      } else {
        return ("DeleteReportERROR");
      }
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  Search: Displays the Account search form
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandSearchForm(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-view"))) {
      return ("PermissionError");
    }
    
    //Bypass search form for portal users
    if (isPortalUser(context)){
      return (executeCommandSearch(context));
    }

    Connection db = null;
    try {
      db = getConnection(context);
      //Account type lookup
      LookupList typeSelect = new LookupList(db, "lookup_account_types");
      typeSelect.addItem(0, "All Types");
      context.getRequest().setAttribute("TypeSelect", typeSelect);
      //reset the offset and current letter of the paged list in order to make sure we search ALL accounts
      PagedListInfo orgListInfo = this.getPagedListInfo(context, "SearchOrgListInfo");
      orgListInfo.setCurrentLetter("");
      orgListInfo.setCurrentOffset(0);
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Search Accounts", "Accounts Search");
    return ("SearchOK");
  }


  /**
   *  Add: Displays the form used for adding a new Account to CFS
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandAdd(ActionContext context) {

    if (!(hasPermission(context, "accounts-accounts-add"))) {
      return ("PermissionError");
    }

    int errorCode = 0;
    Exception errorMessage = null;

    Connection db = null;
    Statement st = null;
    ResultSet rs = null;

    try {
      db = this.getConnection(context);
      buildFormElements(context, db);
    } catch (Exception e) {
      errorCode = 1;
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorCode == 0) {
      addModuleBean(context, "Add Account", "Accounts Add");
      return ("AddOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }

  }


  /**
   *  Description of the Method
   *
   *@param  context           Description of the Parameter
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void buildFormElements(ActionContext context, Connection db) throws SQLException {

    String index = null;
    if (context.getRequest().getParameter("index") != null) {
      index = context.getRequest().getParameter("index");
    }
    LookupList industrySelect = new LookupList(db, "lookup_industry");
    industrySelect.addItem(0, "--None--");
    context.getRequest().setAttribute("IndustryList", industrySelect);

    LookupList accountTypeList = new LookupList(db, "lookup_account_types");
    accountTypeList.setSelectSize(4);
    accountTypeList.setMultiple(true);
    context.getRequest().setAttribute("AccountTypeList", accountTypeList);

    if (index == null || (index != null && Integer.parseInt(index) == 0)) {
      LookupList phoneTypeList = new LookupList(db, "lookup_orgphone_types");
      context.getRequest().setAttribute("OrgPhoneTypeList", phoneTypeList);

      LookupList addrTypeList = new LookupList(db, "lookup_orgaddress_types");
      context.getRequest().setAttribute("OrgAddressTypeList", addrTypeList);

      LookupList emailTypeList = new LookupList(db, "lookup_orgemail_types");
      context.getRequest().setAttribute("OrgEmailTypeList", emailTypeList);

    } else {
      LookupList phoneTypeList = new LookupList(db, "lookup_contactphone_types");
      context.getRequest().setAttribute("OrgPhoneTypeList", phoneTypeList);

      LookupList addrTypeList = new LookupList(db, "lookup_contactaddress_types");
      context.getRequest().setAttribute("OrgAddressTypeList", addrTypeList);

      LookupList emailTypeList = new LookupList(db, "lookup_contactemail_types");
      context.getRequest().setAttribute("OrgEmailTypeList", emailTypeList);

    }
  }


  /**
   *  Details: Displays all details relating to the selected Account. The user
   *  can also goto a modify page from this form or delete the Account entirely
   *  from the database
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandDetails(ActionContext context) {

    if (!(hasPermission(context, "accounts-accounts-view"))) {
      return ("PermissionError");
    }

    Exception errorMessage = null;
    Connection db = null;
    Organization newOrg = null;

    try {
      String temporgId = context.getRequest().getParameter("orgId");
      if (!isRecordAccessPermitted(context,Integer.parseInt(temporgId))){
         return ("PermissionError");
      }

      int tempid = Integer.parseInt(temporgId);
      db = this.getConnection(context);
      newOrg = new Organization(db, tempid);

      //check whether or not the owner is an active User
      newOrg.checkEnabledOwnerAccount(db);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorMessage == null) {
      addRecentItem(context, newOrg);
      String action = context.getRequest().getParameter("action");
      if (action != null && action.equals("modify")) {
        //If user is going to the modify form
        addModuleBean(context, "Accounts", "Modify Account Details");
        return ("DetailsOK");
      } else {
        //If user is going to the detail screen
        addModuleBean(context, "View Accounts", "View Account Details");
        context.getRequest().setAttribute("OrgDetails", newOrg);
        return ("DetailsOK");
      }
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandDashboard(ActionContext context) {

    if (!(hasPermission(context, "accounts-dashboard-view"))) {
      if (!(hasPermission(context, "accounts-accounts-view"))) {
        return ("PermissionError");
      }

      //Bypass dashboard and search form for portal users
      if (isPortalUser(context)){
        return (executeCommandSearch(context));
      }

      return (executeCommandSearchForm(context));
    }

    addModuleBean(context, "Dashboard", "Dashboard");

    CalendarBean calendarInfo = (CalendarBean) context.getSession().getAttribute("AccountsCalendarInfo");
    if (calendarInfo == null) {
      calendarInfo = new CalendarBean();
      calendarInfo.addAlertType("Accounts", "org.aspcfs.modules.accounts.base.AccountsListScheduledActions", "Accounts");
      calendarInfo.setCalendarDetailsView("Accounts");
      context.getSession().setAttribute("AccountsCalendarInfo", calendarInfo);
    }

    UserBean thisUser = (UserBean) context.getSession().getAttribute("User");

    //this is how we get the multiple-level heirarchy...recursive function.

    User thisRec = thisUser.getUserRecord();

    UserList shortChildList = thisRec.getShortChildList();
    UserList newUserList = thisRec.getFullChildList(shortChildList, new UserList());

    newUserList.setMyId(getUserId(context));
    newUserList.setMyValue(thisUser.getUserRecord().getContact().getNameLastFirst());
    newUserList.setIncludeMe(true);

    newUserList.setJsEvent("onChange = \"javascript:fillFrame('calendar','MyCFS.do?command=MonthView&source=Calendar&userId='+document.getElementById('userId').value + '&return=Accounts'); javascript:fillFrame('calendardetails','MyCFS.do?command=Alerts&source=CalendarDetails&userId='+document.getElementById('userId').value + '&return=Accounts');javascript:changeDivContent('userName','Scheduled Actions for ' + document.getElementById('userId').options[document.getElementById('userId').selectedIndex].firstChild.nodeValue);\"");
    HtmlSelect userListSelect = newUserList.getHtmlSelectObj("userId", getUserId(context));
    userListSelect.addAttribute("id", "userId");
    context.getRequest().setAttribute("Return", "Accounts");
    context.getRequest().setAttribute("NewUserList", userListSelect);
    return ("DashboardOK");
  }


  /**
   *  Search Accounts
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandSearch(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-view")) {
      return ("PermissionError");
    }

    String source = (String) context.getRequest().getParameter("source");
    OrganizationList organizationList = new OrganizationList();
    addModuleBean(context, "View Accounts", "Search Results");

    //Prepare pagedListInfo
    PagedListInfo searchListInfo = this.getPagedListInfo(context, "SearchOrgListInfo");
    searchListInfo.setLink("Accounts.do?command=Search");

    //Need to reset any sub PagedListInfos since this is a new account
    this.resetPagedListInfo(context);
    Connection db = null;
    try {
      db = this.getConnection(context);

      //For portal usr set source as 'searchForm' explicitly since
      //the search form is bypassed.
      //temporary solution for page redirection for portal user.
      if (isPortalUser(context)){
        source = "searchForm";
      }
      //return if no criteria is selected
      if ((searchListInfo.getListView() == null || "".equals(searchListInfo.getListView())) && !"searchForm".equals(source)) {
        return "ListOK";
      }

      //Build the organization list
      organizationList.setPagedListInfo(searchListInfo);
      organizationList.setMinerOnly(false);
      organizationList.setTypeId(searchListInfo.getFilterKey("listFilter1"));
      searchListInfo.setSearchCriteria(organizationList);
      if ("my".equals(searchListInfo.getListView())) {
        organizationList.setOwnerId(this.getUserId(context));
      }
      if ("disabled".equals(searchListInfo.getListView())) {
        organizationList.setIncludeEnabled(0);
      }
      if ("all".equals(searchListInfo.getListView())) {
        organizationList.setIncludeEnabled(-1);
      }
      
      if (isPortalUser(context))
        organizationList.setOrgId(getPortalUserPermittedOrgId(context));
      
      organizationList.buildList(db);

      context.getRequest().setAttribute("OrgList", organizationList);
      return ("ListOK");
    } catch (Exception e) {
      //Go through the SystemError process
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
  }



  /**
   *  ViewTickets: Displays Ticket history (open and closed) for a particular
   *  Account.
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandViewTickets(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-tickets-view")) {
      return ("PermissionError");
    }
    Connection db = null;
    TicketList ticList = new TicketList();
    Organization newOrg = null;
    //Process request parameters
    int passedId = Integer.parseInt(context.getRequest().getParameter("orgId"));

    //find record permissions for portal users
    if (!isRecordAccessPermitted(context,passedId)){
      return ("PermissionError");
    }
    //Prepare PagedListInfo
    PagedListInfo ticketListInfo = this.getPagedListInfo(context, "AccountTicketInfo", "t.entered", "desc");
    ticketListInfo.setLink("Accounts.do?command=ViewTickets&orgId=" + passedId);
    ticList.setPagedListInfo(ticketListInfo);
    try {
      db = this.getConnection(context);
      newOrg = new Organization(db, passedId);
      ticList.setOrgId(passedId);
      ticList.buildList(db);
      context.getRequest().setAttribute("TicList", ticList);
      context.getRequest().setAttribute("OrgDetails", newOrg);
      addModuleBean(context, "View Accounts", "Accounts View");
      return ("ViewTicketsOK");
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
  }


  /**
   *  Insert: Inserts a new Account into the CFS database.
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandInsert(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-add")) {
      return ("PermissionError");
    }
    Connection db = null;
    int resultCount = 0;
    boolean recordInserted = false;
    Organization insertedOrg = null;

    Organization newOrg = (Organization) context.getFormBean();

    newOrg.setTypeList(context.getRequest().getParameterValues("selectedList"));
    newOrg.setEnteredBy(getUserId(context));
    newOrg.setModifiedBy(getUserId(context));
    newOrg.setOwner(getUserId(context));

    try {
      db = this.getConnection(context);

      //set the name to namelastfirstmiddle if individual
      if (context.getRequest().getParameter("form_type").equalsIgnoreCase("individual")) {
        newOrg.setName(newOrg.getNameLastFirstMiddle());
        newOrg.populatePrimaryContact();
        newOrg.getPrimaryContact().setRequestItems(context.getRequest());
        //set the access type for the contact to the default permission for Account Contacts (public)
        AccessTypeList accessTypes = this.getSystemStatus(context).getAccessTypeList(db, AccessType.ACCOUNT_CONTACTS);
        newOrg.getPrimaryContact().setAccessType(accessTypes.getDefaultItem());
      } else {
        //don't want to populate the addresses, etc. if this is an individual account
        newOrg.setRequestItems(context.getRequest());
      }
      recordInserted = newOrg.insert(db);
      if (recordInserted) {
        insertedOrg = new Organization(db, newOrg.getOrgId());
        context.getRequest().setAttribute("OrgDetails", insertedOrg);
        addRecentItem(context, newOrg);
      } else {
        processErrors(context, newOrg.getErrors());
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "View Accounts", "Accounts Insert ok");
    if (recordInserted) {
      String target = context.getRequest().getParameter("target");
      if (target != null && "add_contact".equals(target)) {
        return ("InsertAndAddContactOK");
      } else {
        return ("InsertOK");
      }
    } else {
      return (executeCommandAdd(context));
    }
  }


  /**
   *  Update: Updates the Organization table to reflect user-entered
   *  changes/modifications to the currently selected Account
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandUpdate(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-edit"))) {
      return ("PermissionError");
    }
    Connection db = null;
    int resultCount = 0;
    Organization updatedOrg = null;
    Organization newOrg = (Organization) context.getFormBean();
    newOrg.setTypeList(context.getRequest().getParameterValues("selectedList"));
    newOrg.setModifiedBy(getUserId(context));
    newOrg.setEnteredBy(getUserId(context));
    //set the name to namelastfirstmiddle if individual
    if (context.getRequest().getParameter("form_type").equalsIgnoreCase("individual")) {
      newOrg.setName(newOrg.getNameLastFirstMiddle());
    } else {
      //don't want to populate the addresses, etc. if this is an individual account
      newOrg.setRequestItems(context.getRequest());
    }
    try {
      String orgId = context.getRequest().getParameter("orgId");
      int tempid = Integer.parseInt(orgId);
      db = this.getConnection(context);
      updatedOrg = new Organization(db, tempid);
      resultCount = newOrg.update(db);
      if (resultCount == -1) {
        processErrors(context, newOrg.getErrors());
      } else {
        //if this is an individual account, populate and update the primary contact
        if (context.getRequest().getParameter("form_type").equalsIgnoreCase("individual")) {
          newOrg.populatePrimaryContact(db);
          newOrg.updatePrimaryContact();
          ((Contact) newOrg.getPrimaryContact()).setRequestItems(context.getRequest());
          ((Contact) newOrg.getPrimaryContact()).update(db);
        }
        //update all contacts which are associated with this organization
        ContactList.updateOrgName(db, newOrg);
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "View Accounts", "Modify Account");
    if (resultCount == -1) {
      return (executeCommandModify(context));
    } else if (resultCount == 1) {
      if (context.getRequest().getParameter("return") != null && context.getRequest().getParameter("return").equals("list")) {
        return (executeCommandSearch(context));
      } else if (context.getRequest().getParameter("return") != null && context.getRequest().getParameter("return").equals("dashboard")) {
        return (executeCommandDashboard(context));
      } else {
        if (context.getRequest().getParameter("popup") != null) {
          return ("PopupCloseOK");
        }
        return ("UpdateOK");
      }
    } else {
      context.getRequest().setAttribute("Error", NOT_UPDATED_MESSAGE);
      return ("UserError");
    }
  }



  /**
   *  Delete: Deletes an Account from the Organization table
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandDelete(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-delete")) {
      return ("PermissionError");
    }
    Exception errorMessage = null;
    boolean recordDeleted = false;
    Organization thisOrganization = null;
    Connection db = null;
    try {
      db = this.getConnection(context);
      thisOrganization = new Organization(db, Integer.parseInt(context.getRequest().getParameter("orgId")));
      if (context.getRequest().getParameter("action") != null) {
        if (((String) context.getRequest().getParameter("action")).equals("delete")) {
          //TODO: these may have different options later
          thisOrganization.setContactDelete(true);
          thisOrganization.setRevenueDelete(true);
          thisOrganization.setDocumentDelete(true);
          recordDeleted = thisOrganization.delete(db, this.getPath(context, "accounts"));
        } else if (((String) context.getRequest().getParameter("action")).equals("disable")) {
          recordDeleted = thisOrganization.disable(db);
        }
      }
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Accounts", "Delete Account");
    if (errorMessage == null) {
      if (recordDeleted) {
        deleteRecentItem(context, thisOrganization);
        context.getRequest().setAttribute("refreshUrl", "Accounts.do?command=Search");
        if ("disable".equals(context.getRequest().getParameter("action")) && "list".equals(context.getRequest().getParameter("return"))) {
          return executeCommandSearch(context);
        }
        return "DeleteOK";
      } else {
        processErrors(context, thisOrganization.getErrors());
        return (executeCommandSearch(context));
      }
    } else {
      System.out.println(errorMessage);
      context.getRequest().setAttribute("actionError", "Account could not be deleted because of referential integrity .");
      context.getRequest().setAttribute("refreshUrl", "Accounts.do?command=View");
      return ("DeleteError");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandEnable(ActionContext context) {

    if (!(hasPermission(context, "accounts-accounts-edit"))) {
      return ("PermissionError");
    }

    Exception errorMessage = null;
    boolean recordEnabled = false;
    Organization thisOrganization = null;

    Connection db = null;
    try {
      db = this.getConnection(context);
      thisOrganization = new Organization(db, Integer.parseInt(context.getRequest().getParameter("orgId")));
      recordEnabled = thisOrganization.enable(db);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Accounts", "Delete Account");
    if (errorMessage == null) {
      if (recordEnabled) {
        return (executeCommandSearch(context));
      } else {
        processErrors(context, thisOrganization.getErrors());
        return (executeCommandSearch(context));
      }
    } else {
      System.out.println(errorMessage);
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandConfirmDelete(ActionContext context) {

    if (!(hasPermission(context, "accounts-accounts-delete"))) {
      return ("PermissionError");
    }

    Exception errorMessage = null;
    Connection db = null;
    Organization thisOrg = null;
    HtmlDialog htmlDialog = new HtmlDialog();
    String id = null;

    if (context.getRequest().getParameter("id") != null) {
      id = context.getRequest().getParameter("id");
    }

    try {
      db = this.getConnection(context);
      thisOrg = new Organization(db, Integer.parseInt(id));
      htmlDialog.setTitle("Dark Horse CRM: Account Management");
      DependencyList dependencies = thisOrg.processDependencies(db);
      htmlDialog.addMessage(dependencies.getHtmlString());
      if (thisOrg.getHasOpportunities() || thisOrg.getHasPortalUsers()) {
        String headerMessage = "";
        if (thisOrg.getHasPortalUsers()){
          headerMessage = "This account cannot be deleted because its contacts have (or had) portal access.  <br />";
        }
        if (thisOrg.getHasOpportunities()){
          headerMessage = "Please re-assign or delete any opportunities associated with this account first.";
        }
        htmlDialog.setHeader(headerMessage);
        htmlDialog.addButton("OK", "javascript:parent.window.close()");
      } else {
        htmlDialog.setHeader("The account you are requesting to delete has the following dependencies within Dark Horse CRM:");
        htmlDialog.addButton("Delete All", "javascript:window.location.href='Accounts.do?command=Delete&action=delete&orgId=" + thisOrg.getOrgId() + "'");
        htmlDialog.addButton("Disable Only", "javascript:window.location.href='Accounts.do?command=Delete&orgId=" + thisOrg.getOrgId() + "&action=disable'");
        htmlDialog.addButton("Cancel", "javascript:parent.window.close()");
      }
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    if (errorMessage == null) {
      context.getSession().setAttribute("Dialog", htmlDialog);
      return ("ConfirmDeleteOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }

  }


  /**
   *  Modify: Displays the form used for modifying the information of the
   *  currently selected Account
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandModify(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-edit")) {
      return ("PermissionError");
    }
    Exception errorMessage = null;
    //Command errors
    int errorCode = 0;
    String orgid = context.getRequest().getParameter("orgId");
    context.getRequest().setAttribute("orgId", orgid);
    int tempid = Integer.parseInt(orgid);
    UserBean thisUser = (UserBean) context.getSession().getAttribute("User");
    //this is how we get the multiple-level heirarchy...recursive function.
    User thisRec = thisUser.getUserRecord();
    UserList shortChildList = thisRec.getShortChildList();
    UserList userList = thisRec.getFullChildList(shortChildList, new UserList());
    userList.setMyId(getUserId(context));
    userList.setMyValue(thisUser.getContact().getNameLastFirst());
    userList.setIncludeMe(true);
    userList.setExcludeDisabledIfUnselected(true);
    context.getRequest().setAttribute("UserList", userList);
    Connection db = null;
    Organization newOrg = null;
    try {
      db = this.getConnection(context);
      newOrg = new Organization(db, tempid);

      SystemStatus systemStatus = this.getSystemStatus(context);

      LookupList industrySelect = systemStatus.getLookupList(db, "lookup_industry");
      industrySelect.addItem(0, "--None--");
      context.getRequest().setAttribute("IndustryList", industrySelect);

      LookupList phoneTypeList = systemStatus.getLookupList(db, "lookup_orgphone_types");
      context.getRequest().setAttribute("OrgPhoneTypeList", phoneTypeList);

      LookupList addrTypeList = systemStatus.getLookupList(db, "lookup_orgaddress_types");
      context.getRequest().setAttribute("OrgAddressTypeList", addrTypeList);

      LookupList emailTypeList = systemStatus.getLookupList(db, "lookup_orgemail_types");
      context.getRequest().setAttribute("OrgEmailTypeList", emailTypeList);

      //if this is an individual account
      if (newOrg.getPrimaryContact() != null) {
        LookupList contactEmailTypeList = systemStatus.getLookupList(db, "lookup_contactemail_types");
        context.getRequest().setAttribute("ContactEmailTypeList", contactEmailTypeList);
        LookupList contactAddrTypeList = systemStatus.getLookupList(db, "lookup_contactaddress_types");
        context.getRequest().setAttribute("ContactAddressTypeList", contactAddrTypeList);
        LookupList contactPhoneTypeList = systemStatus.getLookupList(db, "lookup_contactphone_types");
        context.getRequest().setAttribute("ContactPhoneTypeList", contactPhoneTypeList);
      }
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    if (errorMessage == null) {
      addModuleBean(context, "View Accounts", "Account Modify");
      context.getRequest().setAttribute("OrgDetails", newOrg);
      if (context.getRequest().getParameter("popup") != null) {
        return ("PopupModifyOK");
      } else {
        return ("ModifyOK");
      }
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  Fields: Shows a list of custom field records that are located "within" the
   *  selected Custom Folder. Also shows the details of a particular Custom
   *  Field Record when it is selected (details page)
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandFields(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-folders-view"))) {
      return ("PermissionError");
    }

    Exception errorMessage = null;
    Connection db = null;
    Organization thisOrganization = null;
    String recordId = null;
    boolean showRecords = true;
    String selectedCatId = null;

    try {
      String orgId = context.getRequest().getParameter("orgId");
      db = this.getConnection(context);
      thisOrganization = new Organization(db, Integer.parseInt(orgId));
      context.getRequest().setAttribute("OrgDetails", thisOrganization);

      //Show a list of the different folders available in Accounts
      CustomFieldCategoryList thisList = new CustomFieldCategoryList();
      thisList.setLinkModuleId(Constants.ACCOUNTS);
      thisList.setIncludeEnabled(Constants.TRUE);
      thisList.setIncludeScheduled(Constants.TRUE);
      thisList.setBuildResources(false);
      thisList.buildList(db);
      context.getRequest().setAttribute("CategoryList", thisList);

      //See which one is currently selected or use the default
      selectedCatId = (String) context.getRequest().getParameter("catId");
      if (selectedCatId == null) {
        selectedCatId = (String) context.getRequest().getAttribute("catId");
      }
      if (selectedCatId == null) {
        selectedCatId = "" + thisList.getDefaultCategoryId();
      }
      context.getRequest().setAttribute("catId", selectedCatId);

      if (Integer.parseInt(selectedCatId) > 0) {
        //See if a specific record has been chosen from the list
        recordId = context.getRequest().getParameter("recId");
        String recordDeleted = (String) context.getRequest().getAttribute("recordDeleted");
        if (recordDeleted != null) {
          recordId = null;
        }

        //Now build the specified or default category
        CustomFieldCategory thisCategory = thisList.getCategory(Integer.parseInt(selectedCatId));
        if (recordId == null && thisCategory.getAllowMultipleRecords()) {
          //The user didn't request a specific record, so show a list
          //of records matching this category that the user can choose from
          PagedListInfo folderListInfo = this.getPagedListInfo(context, "AccountFolderInfo");
          folderListInfo.setLink("Accounts.do?command=Fields&orgId=" + orgId + "&catId=" + selectedCatId);

          CustomFieldRecordList recordList = new CustomFieldRecordList();
          recordList.setLinkModuleId(Constants.ACCOUNTS);
          recordList.setLinkItemId(thisOrganization.getOrgId());
          recordList.setCategoryId(thisCategory.getId());
          recordList.buildList(db);
          recordList.buildRecordColumns(db, thisCategory);
          context.getRequest().setAttribute("Records", recordList);
        } else {
          //The user requested a specific record, or this category only
          //allows a single record.
          thisCategory.setLinkModuleId(Constants.ACCOUNTS);
          thisCategory.setLinkItemId(thisOrganization.getOrgId());
          if (recordId != null) {
            thisCategory.setRecordId(Integer.parseInt(recordId));
          } else {
            thisCategory.buildRecordId(db);
            recordId = String.valueOf(thisCategory.getRecordId());
          }
          thisCategory.setIncludeEnabled(Constants.TRUE);
          thisCategory.setIncludeScheduled(Constants.TRUE);
          thisCategory.setBuildResources(true);
          thisCategory.buildResources(db);
          showRecords = false;

          if (thisCategory.getRecordId() > -1) {
            CustomFieldRecord thisRecord = new CustomFieldRecord(db, thisCategory.getRecordId());
            context.getRequest().setAttribute("Record", thisRecord);
          }
        }
        context.getRequest().setAttribute("Category", thisCategory);
      }
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorMessage == null) {
      addModuleBean(context, "View Accounts", "Custom Fields Details");
      if (Integer.parseInt(selectedCatId) <= 0) {
        return ("FieldsEmptyOK");
      } else if (recordId == null && showRecords) {
        return ("FieldRecordListOK");
      } else {
        return ("FieldsOK");
      }
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  AddFolderRecord: Displays the form for inserting a new custom field record
   *  for the selected Account.
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandAddFolderRecord(ActionContext context) {

    if (!(hasPermission(context, "accounts-accounts-folders-add"))) {
      return ("PermissionError");
    }

    Exception errorMessage = null;
    Connection db = null;
    Organization thisOrganization = null;

    try {
      String orgId = context.getRequest().getParameter("orgId");
      db = this.getConnection(context);
      thisOrganization = new Organization(db, Integer.parseInt(orgId));
      context.getRequest().setAttribute("OrgDetails", thisOrganization);

      String selectedCatId = (String) context.getRequest().getParameter("catId");
      CustomFieldCategory thisCategory = new CustomFieldCategory(db,
          Integer.parseInt(selectedCatId));
      thisCategory.setLinkModuleId(Constants.ACCOUNTS);
      thisCategory.setLinkItemId(thisOrganization.getOrgId());
      thisCategory.setIncludeEnabled(Constants.TRUE);
      thisCategory.setIncludeScheduled(Constants.TRUE);
      thisCategory.setBuildResources(true);
      thisCategory.buildResources(db);
      context.getRequest().setAttribute("Category", thisCategory);

    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorMessage == null) {
      addModuleBean(context, "View Accounts", "Add Folder Record");
      return ("AddFolderRecordOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  ModifyFields: Displays the modify form for the selected Custom Field
   *  Record.
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandModifyFields(ActionContext context) {

    if (!(hasPermission(context, "accounts-accounts-folders-edit"))) {
      return ("PermissionError");
    }

    Exception errorMessage = null;
    Connection db = null;
    Organization thisOrganization = null;

    String selectedCatId = (String) context.getRequest().getParameter("catId");
    String recordId = (String) context.getRequest().getParameter("recId");

    try {
      String orgId = context.getRequest().getParameter("orgId");
      db = this.getConnection(context);
      thisOrganization = new Organization(db, Integer.parseInt(orgId));
      context.getRequest().setAttribute("OrgDetails", thisOrganization);

      CustomFieldCategory thisCategory = new CustomFieldCategory(db,
          Integer.parseInt(selectedCatId));
      thisCategory.setLinkModuleId(Constants.ACCOUNTS);
      thisCategory.setLinkItemId(thisOrganization.getOrgId());
      thisCategory.setRecordId(Integer.parseInt(recordId));
      thisCategory.setIncludeEnabled(Constants.TRUE);
      thisCategory.setIncludeScheduled(Constants.TRUE);
      thisCategory.setBuildResources(true);
      thisCategory.buildResources(db);
      context.getRequest().setAttribute("Category", thisCategory);

    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorMessage == null) {
      addModuleBean(context, "View Accounts", "Modify Custom Fields");
      if (recordId.equals("-1")) {
        return ("AddFolderRecordOK");
      } else {
        return ("ModifyFieldsOK");
      }
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  UpdateFields: Performs the actual update of the selected Custom Field
   *  Record based on user-submitted information from the modify form.
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandUpdateFields(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-folders-edit"))) {
      return ("PermissionError");
    }

    Exception errorMessage = null;
    Connection db = null;
    Organization thisOrganization = null;
    int resultCount = 0;

    try {
      String orgId = context.getRequest().getParameter("orgId");
      db = this.getConnection(context);
      thisOrganization = new Organization(db, Integer.parseInt(orgId));
      context.getRequest().setAttribute("OrgDetails", thisOrganization);

      CustomFieldCategoryList thisList = new CustomFieldCategoryList();
      thisList.setLinkModuleId(Constants.ACCOUNTS);
      thisList.setIncludeEnabled(Constants.TRUE);
      thisList.setIncludeScheduled(Constants.TRUE);
      thisList.setBuildResources(false);
      thisList.buildList(db);
      context.getRequest().setAttribute("CategoryList", thisList);

      String selectedCatId = (String) context.getRequest().getParameter("catId");
      String recordId = (String) context.getRequest().getParameter("recId");

      context.getRequest().setAttribute("catId", selectedCatId);
      CustomFieldCategory thisCategory = new CustomFieldCategory(db,
          Integer.parseInt(selectedCatId));
      thisCategory.setLinkModuleId(Constants.ACCOUNTS);
      thisCategory.setLinkItemId(thisOrganization.getOrgId());
      thisCategory.setRecordId(Integer.parseInt(recordId));
      thisCategory.setIncludeEnabled(Constants.TRUE);
      thisCategory.setIncludeScheduled(Constants.TRUE);
      thisCategory.setBuildResources(true);
      thisCategory.buildResources(db);
      thisCategory.setParameters(context);
      thisCategory.setModifiedBy(this.getUserId(context));
      if (!thisCategory.getReadOnly()) {
        resultCount = thisCategory.update(db);
      }
      if (resultCount == -1) {
        if (System.getProperty("DEBUG") != null) {
          System.out.println("Accounts-> ModifyField validation error");
        }
      } else {
        thisCategory.buildResources(db);
        CustomFieldRecord thisRecord = new CustomFieldRecord(db, thisCategory.getRecordId());
        context.getRequest().setAttribute("Record", thisRecord);
      }
      context.getRequest().setAttribute("Category", thisCategory);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorMessage == null) {
      if (resultCount == -1) {
        return ("ModifyFieldsOK");
      } else if (resultCount == 1) {
        return ("UpdateFieldsOK");
      } else {
        context.getRequest().setAttribute("Error", CFSModule.NOT_UPDATED_MESSAGE);
        return ("UserError");
      }
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  InsertFields: Performs the actual insert of a new Custom Field Record.
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandInsertFields(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-folders-add"))) {
      return ("PermissionError");
    }

    Exception errorMessage = null;
    Connection db = null;
    int resultCode = -1;
    Organization thisOrganization = null;

    try {
      String orgId = context.getRequest().getParameter("orgId");
      db = this.getConnection(context);
      thisOrganization = new Organization(db, Integer.parseInt(orgId));
      context.getRequest().setAttribute("OrgDetails", thisOrganization);

      CustomFieldCategoryList thisList = new CustomFieldCategoryList();
      thisList.setLinkModuleId(Constants.ACCOUNTS);
      thisList.setIncludeEnabled(Constants.TRUE);
      thisList.setIncludeScheduled(Constants.TRUE);
      thisList.setBuildResources(false);
      thisList.buildList(db);
      context.getRequest().setAttribute("CategoryList", thisList);

      String selectedCatId = (String) context.getRequest().getParameter("catId");
      context.getRequest().setAttribute("catId", selectedCatId);
      CustomFieldCategory thisCategory = new CustomFieldCategory(db,
          Integer.parseInt(selectedCatId));
      thisCategory.setLinkModuleId(Constants.ACCOUNTS);
      thisCategory.setLinkItemId(thisOrganization.getOrgId());
      thisCategory.setIncludeEnabled(Constants.TRUE);
      thisCategory.setIncludeScheduled(Constants.TRUE);
      thisCategory.setBuildResources(true);
      thisCategory.buildResources(db);
      thisCategory.setParameters(context);
      thisCategory.setEnteredBy(this.getUserId(context));
      thisCategory.setModifiedBy(this.getUserId(context));
      if (!thisCategory.getReadOnly()) {
        resultCode = thisCategory.insert(db);
      }
      if (resultCode == -1) {
        if (System.getProperty("DEBUG") != null) {
          System.out.println("Accounts-> InsertField validation error");
        }
      } else {
        processInsertHook(context, thisCategory);
      }
      context.getRequest().setAttribute("Category", thisCategory);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorMessage == null) {
      if (resultCode == -1) {
        return ("AddFolderRecordOK");
      } else {
        return (this.executeCommandFields(context));
      }
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandDeleteFields(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-folders-delete"))) {
      return ("PermissionError");
    }

    Exception errorMessage = null;
    Connection db = null;
    boolean recordDeleted = false;

    try {
      db = this.getConnection(context);
      String selectedCatId = context.getRequest().getParameter("catId");
      String recordId = context.getRequest().getParameter("recId");
      String orgId = context.getRequest().getParameter("orgId");

      CustomFieldCategory thisCategory = new CustomFieldCategory(db,
          Integer.parseInt(selectedCatId));

      CustomFieldRecord thisRecord = new CustomFieldRecord(db, Integer.parseInt(recordId));
      thisRecord.setLinkModuleId(Constants.ACCOUNTS);
      thisRecord.setLinkItemId(Integer.parseInt(orgId));
      thisRecord.setCategoryId(Integer.parseInt(selectedCatId));
      if (!thisCategory.getReadOnly()) {
        recordDeleted = thisRecord.delete(db);
      }
      context.getRequest().setAttribute("recordDeleted", "true");
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorMessage == null) {
      return ("DeleteFieldsOK");
    } else {
      addModuleBean(context, "Accounts", "Delete Folder Record");
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   */
  private void resetPagedListInfo(ActionContext context) {
    this.deletePagedListInfo(context, "ContactListInfo");
    this.deletePagedListInfo(context, "AccountFolderInfo");
    this.deletePagedListInfo(context, "RptListInfo");
    this.deletePagedListInfo(context, "OpportunityPagedInfo");
    this.deletePagedListInfo(context, "AccountTicketInfo");
    this.deletePagedListInfo(context, "AutoGuideAccountInfo");
    this.deletePagedListInfo(context, "RevenueListInfo");
    this.deletePagedListInfo(context, "AccountDocumentInfo");
    this.deletePagedListInfo(context, "ServiceContractListInfo");
    this.deletePagedListInfo(context, "AssetListInfo");
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandRebuildFormElements(ActionContext context) {
    Connection db = null;
    String index = null;
    if (context.getRequest().getParameter("index") != null) {
      index = context.getRequest().getParameter("index");
    }
    try {
      db = this.getConnection(context);
      if (Integer.parseInt(index) == 0) {
        LookupList phoneTypeList = new LookupList(db, "lookup_orgphone_types");
        context.getRequest().setAttribute("OrgPhoneTypeList", phoneTypeList);

        LookupList addrTypeList = new LookupList(db, "lookup_orgaddress_types");
        context.getRequest().setAttribute("OrgAddressTypeList", addrTypeList);

        LookupList emailTypeList = new LookupList(db, "lookup_orgemail_types");
        context.getRequest().setAttribute("OrgEmailTypeList", emailTypeList);
      } else {
        LookupList phoneTypeList = new LookupList(db, "lookup_contactphone_types");
        context.getRequest().setAttribute("OrgPhoneTypeList", phoneTypeList);

        LookupList addrTypeList = new LookupList(db, "lookup_contactaddress_types");
        context.getRequest().setAttribute("OrgAddressTypeList", addrTypeList);

        LookupList emailTypeList = new LookupList(db, "lookup_contactemail_types");
        context.getRequest().setAttribute("OrgEmailTypeList", emailTypeList);
      }
    } catch (Exception errorMessage) {
      
    } finally {
      this.freeConnection(context, db);
    }
    return ("RebuildElementsOK");
  }
}

