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
package org.aspcfs.modules.accounts.actions;

import com.darkhorseventures.framework.actions.ActionContext;
import com.zeroio.iteam.base.FileItem;
import com.zeroio.iteam.base.FileItemList;
import com.zeroio.webutils.FileDownload;
import org.aspcfs.controller.ApplicationPrefs;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.accounts.base.Organization;
import org.aspcfs.modules.accounts.base.OrganizationList;
import org.aspcfs.modules.accounts.base.OrganizationReport;
import org.aspcfs.modules.actionplans.base.ActionItemWork;
import org.aspcfs.modules.actionplans.base.ActionPlan;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.admin.base.*;
import org.aspcfs.modules.assets.base.Asset;
import org.aspcfs.modules.assets.base.AssetList;
import org.aspcfs.modules.base.*;
import org.aspcfs.modules.contacts.base.Contact;
import org.aspcfs.modules.contacts.base.ContactList;
import org.aspcfs.modules.contacts.base.ContactReport;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.mycfs.beans.CalendarBean;
import org.aspcfs.modules.pipeline.base.OpportunityHeaderList;
import org.aspcfs.modules.pipeline.base.OpportunityReport;
import org.aspcfs.modules.troubletickets.base.TicketList;
import org.aspcfs.modules.troubletickets.base.TicketReport;
import org.aspcfs.utils.web.*;

import java.sql.Connection;
import java.sql.SQLException;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Iterator;

/**
 * Action for the Account module
 *
 * @author chris
 * @version $Id$
 * @created August 15, 2001
 */
public final class Accounts extends CFSModule {

  /**
   * Default: not used
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandDefault(ActionContext context) {
    return executeCommandDashboards(context);
  }


  /**
   * Reports: Displays a list of previously generated reports with
   * view/delete/download options.
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
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
   * DownloadCSVReport: Sends a copy of the CSV report to the user's local
   * machine
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
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
      thisItem = new FileItem(
          db, Integer.parseInt(itemId), -1, Constants.DOCUMENTS_ACCOUNTS_REPORTS);
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
      String filePath = this.getPath(context, "account-reports") + getDatePath(
          itemToDownload.getEntered()) + itemToDownload.getFilename() + ".csv";
      FileDownload fileDownload = new FileDownload();
      fileDownload.setFullPath(filePath);
      fileDownload.setDisplayName(itemToDownload.getClientFilename());
      if (fileDownload.fileExists()) {
        fileDownload.sendFile(context);
        //Get a db connection now that the download is complete
        db = getConnection(context);
        itemToDownload.updateCounter(db);
      } else {
        System.err.println(
            "Accounts-> Trying to send a file that does not exist");
      }
    } catch (java.net.SocketException se) {
      //User either canceled the download or lost connection
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
   * ShowReportHtml: Displays a preview of the selected report in HTML format
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandShowReportHtml(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-reports-view"))) {
      return ("PermissionError");
    }
    FileItem thisItem = null;
    String itemId = (String) context.getRequest().getParameter("fid");
    Connection db = null;
    try {
      db = getConnection(context);
      thisItem = new FileItem(
          db, Integer.parseInt(itemId), -1, Constants.DOCUMENTS_ACCOUNTS_REPORTS);
      String filePath = this.getPath(context, "account-reports") + getDatePath(
          thisItem.getEntered()) + thisItem.getFilename() + ".html";
      String textToShow = includeFile(filePath);
      context.getRequest().setAttribute("ReportText", textToShow);
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return ("ReportHtmlOK");
  }


  /**
   * GenerateForm: Displays the form that allows the user to select criteria
   * and specify information for a new Accounts report
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandGenerateForm(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-reports-add")) {
      return ("PermissionError");
    }
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
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Reports", "Generate new");
    return ("GenerateFormOK");
  }


  /**
   * ExportReport: Creates both an HTML version (for preview) and a CSV version
   * of the report
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandExportReport(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-reports-add")) {
      return ("PermissionError");
    }
    //Parameters
    String subject = context.getRequest().getParameter("subject");
    String type = context.getRequest().getParameter("type");
    String ownerCriteria = context.getRequest().getParameter("criteria1");
    SystemStatus systemStatus = getSystemStatus(context);
    //process errors
    HashMap errors = new HashMap();
    if ((subject == null) || ("".equals(subject.trim()))) {
      errors.put(
          "subjectError", systemStatus.getLabel("object.validation.required"));
    }
    if (!errors.isEmpty()) {
      processErrors(context, errors);
      return executeCommandGenerateForm(context);
    }
    //File path
    String filePath = this.getPath(context, "account-reports");
    SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy");
    String datePathToUse1 = formatter1.format(new java.util.Date());
    SimpleDateFormat formatter2 = new SimpleDateFormat("MMdd");
    String datePathToUse2 = formatter2.format(new java.util.Date());
    filePath += datePathToUse1 + fs + datePathToUse2 + fs;
    //Populate the report criteria
    OrganizationReport orgReport = new OrganizationReport();
    orgReport.setCriteria(
        context.getRequest().getParameterValues("selectedList"));
    orgReport.setFilePath(filePath);
    orgReport.setSubject(subject);
    orgReport.setMinerOnly(false);
    orgReport.setIncludeEnabled(Constants.UNDEFINED);
    orgReport.setOrgSiteId(this.getUserSiteId(context));
    if (ownerCriteria.equals("my")) {
      orgReport.setOwnerId(this.getUserId(context));
    } else if (ownerCriteria.equals("levels")) {
      orgReport.setOwnerIdRange(this.getUserRange(context));
    }
    Connection db = null;
    try {
      db = this.getConnection(context);
      //Accounts with opportunities report
      if (type.equals("5")) {
        OpportunityReport oppReport = new OpportunityReport();
        oppReport.setHeader(systemStatus.getLabel("Concourse Suite Community Edition Accounts", "centriccrm.accounts"));
        oppReport.setFilePath(filePath);
        oppReport.setEnteredBy(getUserId(context));
        oppReport.setModifiedBy(getUserId(context));
        oppReport.setSiteId(this.getUserSiteId(context));
        oppReport.setExclusiveToSite(true);
        if (oppReport.getSiteId() == -1) {
          oppReport.setIncludeAllSites(true);
        }
        oppReport.setSubject(subject);
        if (ownerCriteria.equals("my")) {
          oppReport.setLimitId(this.getUserId(context));
        } else if (ownerCriteria.equals("levels")) {
          oppReport.setAccountOwnerIdRange(this.getUserRange(context));
        }
        oppReport.setCriteria(null);
        oppReport.getOrgReportJoin().setCriteria(
            context.getRequest().getParameterValues("selectedList"));
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
        contactReport.setHeader(systemStatus.getLabel("Concourse Suite Community Edition Accounts", "centriccrm.accounts"));
        contactReport.addIgnoreTypeId(Contact.EMPLOYEE_TYPE);
        contactReport.addIgnoreTypeId(Contact.LEAD_TYPE);
        contactReport.setSiteId(this.getUserSiteId(context));
        contactReport.setExclusiveToSite(true);
        if (contactReport.getSiteId() == -1) {
          contactReport.setIncludeAllSites(true);
        }
        contactReport.setCriteria(null);
        contactReport.getOrgReportJoin().setCriteria(
            context.getRequest().getParameterValues("selectedList"));
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
        ticReport.setSiteId(this.getUserSiteId(context));
        ticReport.setExclusiveToSite(true);
        if (ticReport.getSiteId() == -1) {
          ticReport.setIncludeAllSites(true);
        }
        ticReport.setHeader(systemStatus.getLabel("Concourse Suite Community Edition Accounts", "centriccrm.accounts"));
        ticReport.setJoinOrgs(true);
        if (ownerCriteria.equals("my")) {
          ticReport.setLimitId(this.getUserId(context));
        } else if (ownerCriteria.equals("levels")) {
          ticReport.setAccountOwnerIdRange(this.getUserRange(context));
        }
        ticReport.setCriteria(null);
        ticReport.getOrgReportJoin().setCriteria(
            context.getRequest().getParameterValues("selectedList"));
        ticReport.buildReportFull(db, context);
        ticReport.saveAndInsert(db);
      } else {
        int folderId = Integer.parseInt(
            context.getRequest().getParameter("catId"));
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
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return executeCommandReports(context);
  }


  /**
   * DeleteReport: Deletes previously generated report files (HTML and CSV)
   * from server and all related file information from the project_files table.
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandDeleteReport(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-reports-delete"))) {
      return ("PermissionError");
    }
    boolean recordDeleted = false;
    String itemId = (String) context.getRequest().getParameter("fid");
    Connection db = null;
    try {
      db = getConnection(context);
      FileItem thisItem = new FileItem(
          db, Integer.parseInt(itemId), -1, Constants.DOCUMENTS_ACCOUNTS_REPORTS);
      recordDeleted = thisItem.delete(
          db, this.getPath(context, "account-reports"));
      String filePath1 = this.getPath(context, "account-reports") + getDatePath(
          thisItem.getEntered()) + thisItem.getFilename() + ".csv";
      java.io.File fileToDelete1 = new java.io.File(filePath1);
      if (!fileToDelete1.delete()) {
        System.err.println("FileItem-> Tried to delete file: " + filePath1);
      }
      String filePath2 = this.getPath(context, "account-reports") + getDatePath(
          thisItem.getEntered()) + thisItem.getFilename() + ".html";
      java.io.File fileToDelete2 = new java.io.File(filePath2);
      if (!fileToDelete2.delete()) {
        System.err.println("FileItem-> Tried to delete file: " + filePath2);
      }
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Reports", "Reports del");
    if (recordDeleted) {
      return ("DeleteReportOK");
    } else {
      return ("DeleteReportERROR");
    }
  }


  /**
   * Search: Displays the Account search form
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandSearchForm(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-view"))) {
      return ("PermissionError");
    }

    //Bypass search form for portal users
    if (isPortalUser(context)) {
      return (executeCommandSearch(context));
    }
    SystemStatus systemStatus = this.getSystemStatus(context);
    Connection db = null;
    try {
      db = getConnection(context);
      LookupList siteList = new LookupList(db, "lookup_site_id");
      siteList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
      siteList.addItem(Constants.INVALID_SITE, systemStatus.getLabel("accounts.allSites"));
      context.getRequest().setAttribute("SiteList", siteList);

      LookupList stageList = new LookupList(db, "lookup_account_stage");
      stageList.addItem(-1, systemStatus.getLabel("accounts.any"));
      context.getRequest().setAttribute("StageList", stageList);

      //reset the offset and current letter of the paged list in order to make sure we search ALL accounts
      PagedListInfo orgListInfo = this.getPagedListInfo(
          context, "SearchOrgListInfo");
      orgListInfo.setCurrentLetter("");
      orgListInfo.setCurrentOffset(0);
      if (orgListInfo.getSearchOptionValue("searchcodeContactCountry") != null && !"-1".equals(orgListInfo.getSearchOptionValue("searchcodeContactCountry"))) {
        StateSelect stateSelect = new StateSelect(systemStatus, orgListInfo.getSearchOptionValue("searchcodeContactCountry"));
        if (orgListInfo.getSearchOptionValue("searchContactOtherState") != null) {
          HashMap map = new HashMap();
          map.put((String) orgListInfo.getSearchOptionValue("searchcodeContactCountry"), (String) orgListInfo.getSearchOptionValue("searchContactOtherState"));
          stateSelect.setPreviousStates(map);
        }
        context.getRequest().setAttribute("ContactStateSelect", stateSelect);
      }
      if (orgListInfo.getSearchOptionValue("searchcodeAccountCountry") != null && !"-1".equals(orgListInfo.getSearchOptionValue("searchcodeAccountCountry"))) {
        StateSelect stateSelect = new StateSelect(systemStatus, orgListInfo.getSearchOptionValue("searchcodeAccountCountry"));
        if (orgListInfo.getSearchOptionValue("searchAccountOtherState") != null) {
          HashMap map = new HashMap();
          map.put((String) orgListInfo.getSearchOptionValue("searchcodeAccountCountry"), (String) orgListInfo.getSearchOptionValue("searchAccountOtherState"));
          stateSelect.setPreviousStates(map);
        }
        context.getRequest().setAttribute("AccountStateSelect", stateSelect);
      }
      buildFormElements(context, db);
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
   * Add: Displays the form used for adding a new Account
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandAdd(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-add")) {
      return ("PermissionError");
    }
    SystemStatus systemStatus = this.getSystemStatus(context);
    Connection db = null;
    try {
      db = this.getConnection(context);
      LookupList siteList = new LookupList(db, "lookup_site_id");
      siteList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("SiteList", siteList);

      LookupList stageList = new LookupList(db, "lookup_account_stage");
      stageList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("StageList", stageList);

      Organization newOrg = (Organization) context.getFormBean();
      ApplicationPrefs prefs = (ApplicationPrefs) context.getServletContext().getAttribute("applicationPrefs");
      StateSelect stateSelect = new StateSelect(systemStatus, (newOrg.getAddressList() != null ? newOrg.getAddressList().getCountries() : "") + prefs.get("SYSTEM.COUNTRY"));
      stateSelect.setPreviousStates((newOrg.getAddressList() != null ? newOrg.getAddressList().getSelectedStatesHashMap() : new HashMap()));
      context.getRequest().setAttribute("StateSelect", stateSelect);
      buildFormElements(context, db);
      if (newOrg.getEnteredBy() != -1) {
        newOrg.setTypeListToTypes(db);
        context.getRequest().setAttribute("OrgDetails", newOrg);
      }
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Add Account", "Accounts Add");
    context.getRequest().setAttribute(
        "systemStatus", this.getSystemStatus(context));
    //if a different module reuses this action then do a explicit return
    if (context.getRequest().getParameter("actionSource") != null) {
      return getReturn(context, "AddAccount");
    }

    return getReturn(context, "Add");
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @param db      Description of the Parameter
   * @throws SQLException Description of the Exception
   */
  public void buildFormElements(ActionContext context, Connection db) throws SQLException {
    String index = null;
    if (context.getRequest().getParameter("index") != null) {
      index = context.getRequest().getParameter("index");
    }
    SystemStatus systemStatus = this.getSystemStatus(context);

    LookupList salutationList = new LookupList(db, "lookup_title");
    salutationList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
    context.getRequest().setAttribute("SalutationList", salutationList);

    LookupList segmentList = new LookupList(db, "lookup_segments");
    segmentList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
    context.getRequest().setAttribute("SegmentList", segmentList);

    LookupList industrySelect = new LookupList(db, "lookup_industry");
    industrySelect.addItem(0, systemStatus.getLabel("calendar.none.4dashes"));
    context.getRequest().setAttribute("IndustryList", industrySelect);

    SICCodeList sicCodeList = new SICCodeList(db);
    sicCodeList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
    context.getRequest().setAttribute("SICCodeList", sicCodeList);

    LookupList sourceList = new LookupList(db, "lookup_contact_source");
    sourceList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
    context.getRequest().setAttribute("SourceList", sourceList);

    LookupList ratingList = new LookupList(db, "lookup_contact_rating");
    ratingList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
    context.getRequest().setAttribute("RatingList", ratingList);

    LookupList accountTypeList1 = new LookupList(db, "lookup_account_types");
    accountTypeList1.setSelectSize(4);
    accountTypeList1.setMultiple(true);
    context.getRequest().setAttribute("AccountTypeList", accountTypeList1);

    LookupList accountTypeList2 = new LookupList(db, "lookup_account_types");
    accountTypeList2.addItem(-1, systemStatus.getLabel("accounts.allTypes"));
    context.getRequest().setAttribute("TypeSelect", accountTypeList2);

    LookupList accountSizeList = new LookupList(db, "lookup_account_size");
    accountSizeList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
    context.getRequest().setAttribute("AccountSizeList", accountSizeList);

    if (index == null || (index != null && Integer.parseInt(index) == 0)) {
      LookupList phoneTypeList = new LookupList(db, "lookup_orgphone_types");
      context.getRequest().setAttribute("OrgPhoneTypeList", phoneTypeList);

      LookupList addrTypeList = new LookupList(db, "lookup_orgaddress_types");
      context.getRequest().setAttribute("OrgAddressTypeList", addrTypeList);

      LookupList emailTypeList = new LookupList(db, "lookup_orgemail_types");
      context.getRequest().setAttribute("OrgEmailTypeList", emailTypeList);

    } else {
      LookupList phoneTypeList = new LookupList(
          db, "lookup_contactphone_types");
      context.getRequest().setAttribute("OrgPhoneTypeList", phoneTypeList);

      LookupList addrTypeList = new LookupList(
          db, "lookup_contactaddress_types");
      context.getRequest().setAttribute("OrgAddressTypeList", addrTypeList);

      LookupList emailTypeList = new LookupList(
          db, "lookup_contactemail_types");
      context.getRequest().setAttribute("OrgEmailTypeList", emailTypeList);

    }
    //Make the StateSelect and CountrySelect drop down menus available in the request.
    //This needs to be done here to provide the SystemStatus to the constructors, otherwise translation is not possible
    StateSelect stateSelect = (StateSelect) context.getRequest().getAttribute("StateSelect");
    if (stateSelect == null) {
      ApplicationPrefs prefs = (ApplicationPrefs) context.getServletContext().getAttribute("applicationPrefs");
      stateSelect = new StateSelect(systemStatus, prefs.get("SYSTEM.COUNTRY"));
    }
    CountrySelect countrySelect = new CountrySelect(systemStatus);

    context.getRequest().setAttribute("StateSelect", stateSelect);
    context.getRequest().setAttribute("CountrySelect", countrySelect);
  }


  /**
   * Details: Displays all details relating to the selected Account. The user
   * can also goto a modify page from this form or delete the Account entirely
   * from the database
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandDetails(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-view")) {
      return ("PermissionError");
    }
    Connection db = null;
    SystemStatus systemStatus = this.getSystemStatus(context);
    Organization newOrg = null;
    try {
      String temporgId = context.getRequest().getParameter("orgId");
      if (temporgId == null) {
        temporgId = (String) context.getRequest().getAttribute("orgId");
      }
      int tempid = Integer.parseInt(temporgId);
      db = this.getConnection(context);
      if (!isRecordAccessPermitted(context, db, Integer.parseInt(temporgId))) {
        return ("PermissionError");
      }
      newOrg = new Organization(db, tempid);
      //check whether or not the owner is an active User
      newOrg.checkEnabledOwnerAccount(db);
      LookupList siteList = new LookupList(db, "lookup_site_id");
      siteList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("SiteList", siteList);

      LookupList stageList = new LookupList(db, "lookup_account_stage");
      stageList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("StageList", stageList);

      buildFormElements(context, db);
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
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
      return getReturn(context, "Details");
    }
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandDashboard(ActionContext context) {
    if (!hasPermission(context, "accounts-dashboard-view")) {
      if (!hasPermission(context, "accounts-accounts-view")) {
        return ("PermissionError");
      }
      //Bypass dashboard and search form for portal users
      if (isPortalUser(context)) {
        return (executeCommandSearch(context));
      }
      return (executeCommandSearchForm(context));
    }
    addModuleBean(context, "Dashboard", "Dashboard");
    CalendarBean calendarInfo = (CalendarBean) context.getSession().getAttribute(
        "AccountsCalendarInfo");
    if (calendarInfo == null) {
      calendarInfo = new CalendarBean(
          this.getUser(context, this.getUserId(context)).getLocale());
      calendarInfo.addAlertType(
          "Accounts", "org.aspcfs.modules.accounts.base.AccountsListScheduledActions", "Accounts");
      calendarInfo.setCalendarDetailsView("Accounts");
      context.getSession().setAttribute("AccountsCalendarInfo", calendarInfo);
    }

    UserBean thisUser = (UserBean) context.getSession().getAttribute("User");

    //this is how we get the multiple-level heirarchy...recursive function.
    User thisRec = thisUser.getUserRecord();

    UserList shortChildList = thisRec.getShortChildList();
    UserList newUserList = thisRec.getFullChildList(
        shortChildList, new UserList());

    newUserList.setMyId(getUserId(context));
    newUserList.setMyValue(
        thisUser.getUserRecord().getContact().getNameLastFirst());
    newUserList.setIncludeMe(true);

    newUserList.setJsEvent(
        "onChange = \"javascript:fillFrame('calendar','MyCFS.do?command=MonthView&source=Calendar&userId='+document.getElementById('userId').value + '&return=Accounts'); javascript:fillFrame('calendardetails','MyCFS.do?command=Alerts&source=CalendarDetails&userId='+document.getElementById('userId').value + '&return=Accounts');javascript:changeDivContent('userName','Scheduled Actions for ' + document.getElementById('userId').options[document.getElementById('userId').selectedIndex].firstChild.nodeValue);\"");
    HtmlSelect userListSelect = newUserList.getHtmlSelectObj(
        "userId", getUserId(context));
    userListSelect.addAttribute("id", "userId");
    context.getRequest().setAttribute("Return", "Accounts");
    context.getRequest().setAttribute("NewUserList", userListSelect);
    return ("DashboardOK");
  }


  /**
   * Search Accounts
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandSearch(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-view")) {
      return ("PermissionError");
    }

    String source = (String) context.getRequest().getParameter("source");
    OrganizationList organizationList = new OrganizationList();
    addModuleBean(context, "View Accounts", "Search Results");

    //Prepare pagedListInfo
    PagedListInfo searchListInfo = this.getPagedListInfo(
        context, "SearchOrgListInfo");
    searchListInfo.setLink("Accounts.do?command=Search");
    SystemStatus systemStatus = this.getSystemStatus(context);
    //Need to reset any sub PagedListInfos since this is a new account
    this.resetPagedListInfo(context);
    Connection db = null;
    try {
      db = this.getConnection(context);

      //For portal usr set source as 'searchForm' explicitly since
      //the search form is bypassed.
      //temporary solution for page redirection for portal user.
      if (isPortalUser(context)) {
        organizationList.setOrgSiteId(this.getUserSiteId(context));
        source = "searchForm";
      }
      //return if no criteria is selected
      if ((searchListInfo.getListView() == null || "".equals(
          searchListInfo.getListView())) && !"searchForm".equals(source)) {
        return "ListOK";
      }
      LookupList siteList = new LookupList(db, "lookup_site_id");
      siteList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
      siteList.addItem(Constants.INVALID_SITE, systemStatus.getLabel("accounts.allSites"));
      context.getRequest().setAttribute("SiteIdList", siteList);

      LookupList stageList = new LookupList(db, "lookup_account_stage");
      stageList.addItem(-1, systemStatus.getLabel("accounts.any"));
      context.getRequest().setAttribute("StageList", stageList);

      //Display list of accounts if user chooses not to list contacts
      if (!"true".equals(searchListInfo.getCriteriaValue("searchContacts"))) {
        if ("contacts".equals(context.getSession().getAttribute("previousSearchType"))) {
          this.deletePagedListInfo(context, "SearchOrgListInfo");
          searchListInfo = this.getPagedListInfo(context, "SearchOrgListInfo");
          searchListInfo.setLink("Accounts.do?command=Search");
        }
        //Build the organization list
        organizationList.setPagedListInfo(searchListInfo);
        organizationList.setMinerOnly(false);
        organizationList.setTypeId(searchListInfo.getFilterKey("listFilter1"));

        organizationList.setStageId(searchListInfo.getCriteriaValue("searchcodeStageId"));

        searchListInfo.setSearchCriteria(organizationList, context);
        //fetching criterea for account source (my accounts or all accounts)
        if ("my".equals(searchListInfo.getListView())) {
          organizationList.setOwnerId(this.getUserId(context));
        }
        if (organizationList.getOrgSiteId() == Constants.INVALID_SITE) {
          organizationList.setOrgSiteId(this.getUserSiteId(context));
          organizationList.setIncludeOrganizationWithoutSite(false);
        } else if (organizationList.getOrgSiteId() == -1) {
          organizationList.setIncludeOrganizationWithoutSite(true);
        }
        //fetching criterea for account status (active, disabled or any)
        int enabled = searchListInfo.getFilterKey("listFilter2");
        organizationList.setIncludeEnabled(enabled);
        //If the user is a portal user, fetching only the
        //the organization that he access to
        //(i.e., the organization for which he is an account contact
        if (isPortalUser(context)) {
          organizationList.setOrgSiteId(this.getUserSiteId(context));
          organizationList.setIncludeOrganizationWithoutSite(false);
          organizationList.setOrgId(getPortalUserPermittedOrgId(context));
        }
        organizationList.buildList(db);
        context.getRequest().setAttribute("OrgList", organizationList);
        context.getSession().setAttribute("previousSearchType", "accounts");
        if (organizationList.size() == 1 && organizationList.getAssetSerialNumber() != null) {
          AssetList assets = new AssetList();
          assets.setOrgId(((Organization) organizationList.get(0)).getId());
          assets.setSerialNumber(organizationList.getAssetSerialNumber());
          assets.setSkipParentIdRequirement(true);
          assets.buildList(db);
          if (assets.size() == 1) {
            Asset asset = (Asset) assets.get(0);
            context.getRequest().setAttribute(
                "id", String.valueOf(asset.getId()));
            return "AssetDetailsOK";
          }
        }
        return "ListOK";
      } else {
        if ("accounts".equals(context.getSession().getAttribute("previousSearchType"))) {
          this.deletePagedListInfo(context, "SearchOrgListInfo");
          searchListInfo = this.getPagedListInfo(context, "SearchOrgListInfo");
          searchListInfo.setLink("Accounts.do?command=Search");
        }
        //Display list of contacts if user chooses to list contacts
        ContactList contactList = new ContactList();
        contactList.setIncludeAllSites(true);
        contactList.setPagedListInfo(searchListInfo);
        //fetching criterea for account source (my accounts or all accounts)
        if ("my".equals(searchListInfo.getListView())) {
          contactList.setAccountOwnerId(this.getUserId(context));
        }
        //fetching criterea for account type
        contactList.setAccountTypeId(searchListInfo.getFilterKey("listFilter1"));

        //fetching criterea for account status (active, disabled or any)
        int enabled = searchListInfo.getFilterKey("listFilter2");
        contactList.setIncludeEnabledAccount(enabled);
        contactList.setBuildDetails(true);
        contactList.setBuildTypes(false);
        contactList.setWithAccountsOnly(true);
        contactList.addIgnoreTypeId(Contact.EMPLOYEE_TYPE);
        searchListInfo.setSearchCriteria(contactList, context);
        if (contactList.getOrgSiteId() == Constants.INVALID_SITE) {
          contactList.setOrgSiteId(this.getUserSiteId(context));
          contactList.setIncludeContactsFromOrganizationsWithoutSite(false);
        } else if (contactList.getOrgSiteId() == -1) {
          contactList.setIncludeContactsFromOrganizationsWithoutSite(true);
        }

        if (searchListInfo.getColumnToSortBy() == null || "searchForm".equals(source)) {
          searchListInfo.setColumnToSortBy("c.org_name,c.namelast");
        }

        if (isPortalUser(context)) {
          contactList.setOrgId(getPortalUserPermittedOrgId(context));
        }
        contactList.buildList(db);

        context.getRequest().setAttribute("ContactList", contactList);
        context.getSession().setAttribute("previousSearchType", "contacts");
        return ("ContactListOK");
      }
    } catch (Exception e) {
      //Go through the SystemError process
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
  }


  /**
   * ViewTickets: Displays Ticket history (open and closed) for a particular
   * Account.
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandViewTickets(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-tickets-view")) {
      return ("PermissionError");
    }
    Connection db = null;
    TicketList ticList = new TicketList();
    Organization newOrg = null;
    //Process request parameters
    int passedId = Integer.parseInt(
        context.getRequest().getParameter("orgId"));

    //Prepare PagedListInfo
    PagedListInfo ticketListInfo = this.getPagedListInfo(
        context, "AccountTicketInfo", "t.entered", "desc");
    ticketListInfo.setLink(
        "Accounts.do?command=ViewTickets&orgId=" + passedId);
    ticList.setPagedListInfo(ticketListInfo);
    try {
      db = this.getConnection(context);
      //find record permissions for portal users
      if (!isRecordAccessPermitted(context, db, passedId)) {
        return ("PermissionError");
      }
      newOrg = new Organization(db, passedId);
      ticList.setOrgId(passedId);
      if (newOrg.isTrashed()) {
        ticList.setIncludeOnlyTrashed(true);
      }
      // For non-portal users, check to see if there are related tickets to show
      // i.e. resellers
      UserBean thisUser = (UserBean) context.getSession().getAttribute("User");
      User thisRec = thisUser.getUserRecord();
      if (!thisRec.isPortalUser()) {
        ticList.buildWithSubmitterTickets();
      }
      ticList.buildList(db);
      context.getRequest().setAttribute("TicList", ticList);
      context.getRequest().setAttribute("OrgDetails", newOrg);
      addModuleBean(context, "View Accounts", "Accounts View");
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return getReturn(context, "ViewTickets");
  }


  /**
   * Insert: Inserts a new Account into the database.
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandInsert(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-add")) {
      return ("PermissionError");
    }
    Connection db = null;
    boolean recordInserted = false;
    boolean isValid = false;
    Organization insertedOrg = null;

    Organization newOrg = (Organization) context.getFormBean();

    newOrg.setTypeList(
        context.getRequest().getParameterValues("selectedList"));
    newOrg.setEnteredBy(getUserId(context));
    newOrg.setModifiedBy(getUserId(context));
    newOrg.setOwner(getUserId(context));

    try {
      db = this.getConnection(context);

      LookupList segmentList = new LookupList(db, "lookup_segments");
      segmentList.addItem(-1, getSystemStatus(context).getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("SegmentList", segmentList);

      LookupList stageList = new LookupList(db, "lookup_account_stage");
      stageList.addItem(-1, getSystemStatus(context).getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("StageList", stageList);

      //set the name to namelastfirstmiddle if individual
      if (context.getRequest().getParameter("form_type").equalsIgnoreCase(
          "individual")) {
        newOrg.setIsIndividual(true);
        newOrg.setName(newOrg.getNameLastFirstMiddle());
        newOrg.populatePrimaryContact();
        newOrg.getPrimaryContact().setRequestItems(context);
        //set the access type for the contact to the default permission for Account Contacts (public)
        AccessTypeList accessTypes = this.getSystemStatus(context).getAccessTypeList(
            db, AccessType.ACCOUNT_CONTACTS);
        newOrg.getPrimaryContact().setAccessType(accessTypes.getDefaultItem());
      } else {
        //don't want to populate the addresses, etc. if this is an individual account
        newOrg.setIsIndividual(false);
        newOrg.setRequestItems(context);
      }
      if (this.getUserSiteId(context) != -1) {
        // Set the site Id of the account to be equal to the site Id of the user
        // for a new account
        if (newOrg.getId() == -1) {
          newOrg.setSiteId(this.getUserSiteId(context));
        } else {
          // Check whether the user has access to update the organization
          if (!isRecordAccessPermitted(context, db, newOrg.getId())) {
            return ("PermissionError");
          }
        }
      }

      isValid = this.validateObject(context, db, newOrg);
      if (isValid) {
        recordInserted = newOrg.insert(db);
      }
      if (recordInserted) {
        insertedOrg = new Organization(db, newOrg.getOrgId());
        context.getRequest().setAttribute("OrgDetails", insertedOrg);
        addRecentItem(context, newOrg);
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
      if (context.getRequest().getParameter("popup") != null) {
        return ("ClosePopupOK");
      }
      if (target != null && "add_contact".equals(target)) {
        return ("InsertAndAddContactOK");
      } else {
        return ("InsertOK");
      }
    }
    return (executeCommandAdd(context));
  }


  /**
   * Update: Updates the Organization table to reflect user-entered
   * changes/modifications to the currently selected Account
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandUpdate(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-edit"))) {
      return ("PermissionError");
    }
    Connection db = null;
    int resultCount = -1;
    boolean isValid = false;
    Organization newOrg = (Organization) context.getFormBean();
    Organization oldOrg = null;
    SystemStatus systemStatus = this.getSystemStatus(context);
    newOrg.setTypeList(
        context.getRequest().getParameterValues("selectedList"));
    newOrg.setModifiedBy(getUserId(context));
    newOrg.setEnteredBy(getUserId(context));
    try {
      db = this.getConnection(context);
      //set the name to namelastfirstmiddle if individual
      if (context.getRequest().getParameter("form_type").equalsIgnoreCase(
          "individual")) {
        newOrg.setIsIndividual(true);
        newOrg.populatePrimaryContact(db);
        if (newOrg.getPrimaryContact() == null) {
          if (newOrg.getPrimaryContactId() == -1) {
            newOrg.getErrors().put("primaryContactIdError", systemStatus.getLabel("", "Select valid primary contact"));
          } else {
            newOrg.updatePrimaryContact(db, true);
          }
        } else {
          newOrg.updatePrimaryContact();
          ((Contact) newOrg.getPrimaryContact()).setRequestItems(context);
          newOrg.setName(newOrg.getNameLastFirstMiddle());
        }
      } else {
        //don't want to populate the addresses, etc. if this is an individual account
        newOrg.setIsIndividual(false);
        newOrg.setRequestItems(context);
        newOrg.populatePrimaryContact(db);
        if (newOrg.getPrimaryContact() != null) {
          //The account has been converted from an org to an individual
          newOrg.updatePrimaryContact(db, false);
        }
      }
      oldOrg = new Organization(db, newOrg.getOrgId());
      isValid = this.validateObject(context, db, newOrg);
      if (isValid) {
        resultCount = newOrg.update(db);
      }
      if (resultCount == 1) {
        processUpdateHook(context, oldOrg, newOrg);
        //if this is an individual account, populate and update the primary contact
        if (context.getRequest().getParameter("form_type").equalsIgnoreCase(
            "individual")) {
          if (newOrg.getPrimaryContactId() == -1) {
            ((Contact) newOrg.getPrimaryContact()).update(db);
          }
        }
        //update all contacts which are associated with this organization
        ContactList.updateOrgName(db, newOrg);
        LookupList segmentList = new LookupList(db, "lookup_segments");
        segmentList.addItem(-1, getSystemStatus(context).getLabel("calendar.none.4dashes"));
        context.getRequest().setAttribute("SegmentList", segmentList);
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "View Accounts", "Modify Account");
    if (resultCount == -1 || !isValid) {
      return (executeCommandModify(context));
    } else if (resultCount == 1) {
      if (context.getRequest().getParameter("return") != null && context.getRequest().getParameter(
          "return").equals("list")) {
        return (executeCommandSearch(context));
      } else
      if (context.getRequest().getParameter("return") != null && context.getRequest().getParameter(
          "return").equals("dashboard")) {
        return (executeCommandDashboard(context));
      } else
      if (context.getRequest().getParameter("return") != null && context.getRequest().getParameter(
          "return").equals("Calendar")) {
        if (context.getRequest().getParameter("popup") != null) {
          return ("PopupCloseOK");
        }
      } else {
        return ("UpdateOK");
      }
    } else {
      context.getRequest().setAttribute("Error", NOT_UPDATED_MESSAGE);
      return ("UserError");
    }
    return ("UpdateOK");
  }


  /**
   * Delete: Deletes an Account from the Organization table
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandDelete(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-delete")) {
      return ("PermissionError");
    }
    SystemStatus systemStatus = this.getSystemStatus(context);
    Exception errorMessage = null;
    boolean recordDeleted = false;
    Organization thisOrganization = null;
    Connection db = null;
    try {
      db = this.getConnection(context);
      thisOrganization = new Organization(
          db, Integer.parseInt(context.getRequest().getParameter("orgId")));
      //Check access permission to organization record
      if (!isRecordAccessPermitted(context, db, thisOrganization.getId())) {
        return ("PermissionError");
      }
      if (context.getRequest().getParameter("action") != null) {
        if (((String) context.getRequest().getParameter("action")).equals(
            "delete")) {
          // NOTE: these may have different options later
          thisOrganization.setContactDelete(true);
          thisOrganization.setRevenueDelete(true);
          thisOrganization.setDocumentDelete(true);
          OpportunityHeaderList opportunityList = new OpportunityHeaderList();
          opportunityList.setOrgId(thisOrganization.getOrgId());
          opportunityList.buildList(db);
          opportunityList.invalidateUserData(context, db);
          thisOrganization.setForceDelete(
              context.getRequest().getParameter("forceDelete"));
          recordDeleted = thisOrganization.delete(
              db, context, getDbNamePath(context));
        } else
        if (((String) context.getRequest().getParameter("action")).equals(
            "disable")) {
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
        context.getRequest().setAttribute(
            "refreshUrl", "Accounts.do?command=Search");
        if ("disable".equals(context.getRequest().getParameter("action")) && "list".equals(
            context.getRequest().getParameter("return"))) {
          return executeCommandSearch(context);
        }
        return "DeleteOK";
      } else {
        processErrors(context, thisOrganization.getErrors());
        return (executeCommandSearch(context));
      }
    } else {
      System.out.println(errorMessage);
      context.getRequest().setAttribute(
          "actionError", systemStatus.getLabel(
          "object.validation.actionError.accountDeletion"));
      context.getRequest().setAttribute(
          "refreshUrl", "Accounts.do?command=Search");
      return ("DeleteError");
    }
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandTrash(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-delete")) {
      return ("PermissionError");
    }
    boolean recordUpdated = false;
    Organization thisOrganization = null;
    Connection db = null;
    try {
      db = this.getConnection(context);
      String orgId = context.getRequest().getParameter("orgId");
      //Check access permission to organization record
      if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
        return ("PermissionError");
      }
      thisOrganization = new Organization(db, Integer.parseInt(orgId));
      // NOTE: these may have different options later
      recordUpdated = thisOrganization.updateStatus(
          db, context, true, this.getUserId(context));
      this.invalidateUserData(context, this.getUserId(context));
      this.invalidateUserData(context, thisOrganization.getOwner());
      if (recordUpdated) {
        deleteRecentItem(context, thisOrganization);
        deleteRecentItems(context, db, thisOrganization);
      }
    } catch (Exception e) {
      context.getRequest().setAttribute(
          "refreshUrl", "Accounts.do?command=Search");
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Accounts", "Delete Account");
    if (recordUpdated) {
      context.getRequest().setAttribute(
          "refreshUrl", "Accounts.do?command=Search");
      if ("list".equals(context.getRequest().getParameter("return"))) {
        return executeCommandSearch(context);
      }
      return "DeleteOK";
    } else {
      return (executeCommandSearch(context));
    }
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandRestore(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-delete")) {
      return ("PermissionError");
    }
    boolean recordUpdated = false;
    Organization thisOrganization = null;
    Connection db = null;
    try {
      db = this.getConnection(context);
      String orgId = context.getRequest().getParameter("orgId");
      //Check access permission to organization record
      if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
        return ("PermissionError");
      }
      thisOrganization = new Organization(db, Integer.parseInt(orgId));
      // NOTE: these may have different options later
      recordUpdated = thisOrganization.updateStatus(
          db, context, false, this.getUserId(context));
      this.invalidateUserData(context, this.getUserId(context));
      this.invalidateUserData(context, thisOrganization.getOwner());
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Accounts", "Delete Account");
    if (recordUpdated) {
      context.getRequest().setAttribute(
          "refreshUrl", "Accounts.do?command=Search");
      if ("list".equals(context.getRequest().getParameter("return"))) {
        return executeCommandSearch(context);
      }
      return this.executeCommandDetails(context);
    } else {
      return (executeCommandSearch(context));
    }
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandEnable(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-edit")) {
      return ("PermissionError");
    }
    boolean recordEnabled = false;
    Organization thisOrganization = null;
    Connection db = null;
    try {
      db = this.getConnection(context);
      thisOrganization = new Organization(
          db, Integer.parseInt(context.getRequest().getParameter("orgId")));
      recordEnabled = thisOrganization.enable(db);
      if (!recordEnabled) {
        this.validateObject(context, db, thisOrganization);
      }
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Accounts", "Delete Account");
    return (executeCommandSearch(context));
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandConfirmDelete(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-delete")) {
      return ("PermissionError");
    }
    Connection db = null;
    Organization thisOrg = null;
    HtmlDialog htmlDialog = new HtmlDialog();
    String id = null;
    SystemStatus systemStatus = this.getSystemStatus(context);
    if (context.getRequest().getParameter("id") != null) {
      id = context.getRequest().getParameter("id");
    }
    try {
      db = this.getConnection(context);
      thisOrg = new Organization(db, Integer.parseInt(id));
      //Check access permission to organization record
      if (!isRecordAccessPermitted(context, db, thisOrg.getId())) {
        return ("PermissionError");
      }
      DependencyList dependencies = thisOrg.processDependencies(db);
      dependencies.setSystemStatus(systemStatus);
      htmlDialog.addMessage(
          systemStatus.getLabel("confirmdelete.caution") + "\n" + dependencies.getHtmlString());
      htmlDialog.setTitle(systemStatus.getLabel("confirmdelete.title"));
      htmlDialog.setHeader(systemStatus.getLabel("confirmdelete.header"));
      htmlDialog.addButton(
          systemStatus.getLabel("button.delete"), "javascript:window.location.href='Accounts.do?command=Trash&action=delete&orgId=" + thisOrg.getOrgId() + "&forceDelete=true" + "'");
      if (thisOrg.getEnabled()) {
        htmlDialog.addButton(
            systemStatus.getLabel("button.disableOnly"), "javascript:window.location.href='Accounts.do?command=Delete&orgId=" + thisOrg.getOrgId() + "&action=disable'");
      }
      htmlDialog.addButton(
          systemStatus.getLabel("button.cancel"), "javascript:parent.window.close()");
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    context.getSession().setAttribute("Dialog", htmlDialog);
    return ("ConfirmDeleteOK");
  }


  /**
   * Modify: Displays the form used for modifying the information of the
   * currently selected Account
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandModify(ActionContext context) {
    if (!hasPermission(context, "accounts-accounts-edit")) {
      return ("PermissionError");
    }
    String orgid = context.getRequest().getParameter("orgId");
    context.getRequest().setAttribute("orgId", orgid);
    int tempid = Integer.parseInt(orgid);
    Connection db = null;
    Organization newOrg = null;
    try {
      db = this.getConnection(context);
      newOrg = (Organization) context.getFormBean();
      if (newOrg.getId() == -1) {
        newOrg = new Organization(db, tempid);
        if (newOrg.getPrimaryContact() == null) {
          newOrg.setIsIndividual(false);
        } else {
          newOrg.setIsIndividual(true);
        }
      } else {
        newOrg.setTypeListToTypes(db);
      }
      if (!isRecordAccessPermitted(context, db, newOrg.getId())) {
        return ("PermissionError");
      }
      if (newOrg.getPrimaryContact() == null) {
        ContactList contacts = new ContactList();
        contacts.setOrgId(newOrg.getOrgId());
        contacts.buildList(db);
        context.getRequest().setAttribute("contactList", contacts);
      }
      SystemStatus systemStatus = this.getSystemStatus(context);
      context.getRequest().setAttribute("systemStatus", systemStatus);
      LookupList industrySelect = systemStatus.getLookupList(
          db, "lookup_industry");
      industrySelect.addItem(
          0, systemStatus.getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("IndustryList", industrySelect);

      SICCodeList sicCodeList = new SICCodeList(db);
      sicCodeList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("SICCodeList", sicCodeList);

      LookupList sourceList = new LookupList(db, "lookup_contact_source");
      sourceList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("SourceList", sourceList);

      LookupList ratingList = new LookupList(db, "lookup_contact_rating");
      ratingList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("RatingList", ratingList);

      LookupList phoneTypeList = systemStatus.getLookupList(
          db, "lookup_orgphone_types");
      context.getRequest().setAttribute("OrgPhoneTypeList", phoneTypeList);

      LookupList addrTypeList = systemStatus.getLookupList(
          db, "lookup_orgaddress_types");
      context.getRequest().setAttribute("OrgAddressTypeList", addrTypeList);

      LookupList emailTypeList = systemStatus.getLookupList(
          db, "lookup_orgemail_types");
      context.getRequest().setAttribute("OrgEmailTypeList", emailTypeList);

      LookupList accountSizeList = new LookupList(db, "lookup_account_size");
      accountSizeList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("AccountSizeList", accountSizeList);

      LookupList salutationList = new LookupList(db, "lookup_title");
      salutationList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("SalutationList", salutationList);

      LookupList siteList = new LookupList(db, "lookup_site_id");
      siteList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("SiteList", siteList);

      LookupList stageList = new LookupList(db, "lookup_account_stage");
      stageList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("StageList", stageList);

      //SegmentList segmentList = new SegmentList(db);
      LookupList segmentList = new LookupList(db, "lookup_segments");
      segmentList.addItem(-1, systemStatus.getLabel("calendar.none.4dashes"));
      context.getRequest().setAttribute("SegmentList", segmentList);

      //if this is an individual account
      if (newOrg.getPrimaryContact() != null) {
        LookupList contactEmailTypeList = systemStatus.getLookupList(
            db, "lookup_contactemail_types");
        context.getRequest().setAttribute(
            "ContactEmailTypeList", contactEmailTypeList);
        LookupList contactAddrTypeList = systemStatus.getLookupList(
            db, "lookup_contactaddress_types");
        context.getRequest().setAttribute(
            "ContactAddressTypeList", contactAddrTypeList);
        LookupList contactPhoneTypeList = systemStatus.getLookupList(
            db, "lookup_contactphone_types");
        context.getRequest().setAttribute(
            "ContactPhoneTypeList", contactPhoneTypeList);
      }

      //Make the StateSelect and CountrySelect drop down menus available in the request.
      //This needs to be done here to provide the SystemStatus to the constructors, otherwise translation is not possible
      ApplicationPrefs prefs = (ApplicationPrefs) context.getServletContext().getAttribute("applicationPrefs");
      StateSelect stateSelect = new StateSelect(systemStatus, (newOrg.getPrimaryContact() == null ? newOrg.getAddressList().getCountries() + "," : newOrg.getPrimaryContact().getAddressList().getCountries() + ",") + prefs.get("SYSTEM.COUNTRY"));
      stateSelect.setPreviousStates((newOrg.getPrimaryContact() == null ? newOrg.getAddressList().getSelectedStatesHashMap() : newOrg.getPrimaryContact().getAddressList().getSelectedStatesHashMap()));
      context.getRequest().setAttribute("StateSelect", stateSelect);
      CountrySelect countrySelect = new CountrySelect(systemStatus);
      context.getRequest().setAttribute("CountrySelect", countrySelect);
      context.getRequest().setAttribute("systemStatus", systemStatus);

      UserList userList = filterOwnerListForSite(context, newOrg.getSiteId());
      context.getRequest().setAttribute("UserList", userList);
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "View Accounts", "Account Modify");
    context.getRequest().setAttribute("OrgDetails", newOrg);
    if (context.getRequest().getParameter("popup") != null) {
      return ("PopupModifyOK");
    } else {
      return ("ModifyOK");
    }
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandFolderList(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-folders-view"))) {
      return ("PermissionError");
    }
    Connection db = null;
    Organization thisOrganization = null;
    try {
      String orgId = context.getRequest().getParameter("orgId");
      db = this.getConnection(context);
      //Check access permission to organization record
      if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
        return ("PermissionError");
      }
      thisOrganization = new Organization(db, Integer.parseInt(orgId));
      context.getRequest().setAttribute("OrgDetails", thisOrganization);
      //Show a list of the different folders available in Accounts
      CustomFieldCategoryList thisList = new CustomFieldCategoryList();
      thisList.setLinkModuleId(Constants.ACCOUNTS);
      thisList.setLinkItemId(thisOrganization.getId());
      thisList.setIncludeEnabled(Constants.TRUE);
      thisList.setIncludeScheduled(Constants.TRUE);
      thisList.setBuildResources(false);
      thisList.setBuildTotalNumOfRecords(true);
      thisList.buildList(db);
      context.getRequest().setAttribute("CategoryList", thisList);
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Accounts", "Custom Fields Details");
    return getReturn(context, "FolderList");
  }


  /**
   * Fields: Shows a list of custom field records that are located "within" the
   * selected Custom Folder. Also shows the details of a particular Custom
   * Field Record when it is selected (details page)
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */

  public String executeCommandFields(ActionContext context) {
    Connection db = null;
    String status = null;
    try {
      db = this.getConnection(context);
      status = this.executeCommandFields(context, db);
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return status;
  }

  private String executeCommandFields(ActionContext context, Connection db) throws NumberFormatException, SQLException {
    if (!(hasPermission(context, "accounts-accounts-folders-view"))) {
      return ("PermissionError");
    }

    Organization thisOrganization = null;
    String source = context.getRequest().getParameter("source");
    String actionStepId = context.getRequest().getParameter("actionStepId");
    if (source != null && !"".equals(source.trim())) {
      context.getRequest().setAttribute("source", source);
    }
    if (actionStepId != null && !"".equals(actionStepId.trim())) {
      context.getRequest().setAttribute("actionStepId", actionStepId);
    }
    String recordId = null;
    boolean showRecords = true;
    String selectedCatId = null;
    String orgId = context.getRequest().getParameter("orgId");
    //Check access permission to organization record
    if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
      return ("PermissionError");
    }
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
      String recordDeleted = (String) context.getRequest().getAttribute(
          "recordDeleted");
      if (recordDeleted != null) {
        recordId = null;
      }

      //Now build the specified or default category
      CustomFieldCategory thisCategory = thisList.getCategory(
          Integer.parseInt(selectedCatId));
      if (recordId == null && thisCategory.getAllowMultipleRecords()) {
        //The user didn't request a specific record, so show a list
        //of records matching this category that the user can choose from
        PagedListInfo folderListInfo = this.getPagedListInfo(
            context, "AccountFolderInfo");
        folderListInfo.setLink(
            "Accounts.do?command=Fields&orgId=" + orgId + "&catId=" + selectedCatId);

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
          CustomFieldRecord thisRecord = new CustomFieldRecord(
              db, thisCategory.getRecordId());
          context.getRequest().setAttribute("Record", thisRecord);
        }
      }
      context.getRequest().setAttribute("Category", thisCategory);
    }
    addModuleBean(context, "View Accounts", "Custom Fields Details");
    if (Integer.parseInt(selectedCatId) <= 0) {
      return getReturn(context, "FieldsEmpty");
    } else if (recordId == null && showRecords) {
      return getReturn(context, "FieldRecordList");
    } else {
      return getReturn(context, "Fields");
    }
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandCheckFields(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-folders-view"))) {
      return ("PermissionError");
    }
    Connection db = null;
    Organization thisOrganization = null;
    String recordId = context.getRequest().getParameter("recId");
    String source = context.getRequest().getParameter("source");
    String actionStepId = context.getRequest().getParameter("actionStepId");
    if (source != null && !"".equals(source.trim())) {
      context.getRequest().setAttribute("source", source);
    }
    if (actionStepId != null && !"".equals(actionStepId.trim())) {
      context.getRequest().setAttribute("actionStepId", actionStepId);
    }
    boolean hasMultipleRecords = false;
    String selectedCatId = null;
    try {
      String orgId = context.getRequest().getParameter("orgId");
      db = this.getConnection(context);
      //Check access permission to organization record
      if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
        return ("PermissionError");
      }
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
        //Now build the specified or default category
        CustomFieldCategory thisCategory = thisList.getCategory(
            Integer.parseInt(selectedCatId));
        thisCategory.setLinkModuleId(Constants.ACCOUNTS);
        thisCategory.setIncludeEnabled(Constants.TRUE);
        thisCategory.setIncludeScheduled(Constants.TRUE);
        thisCategory.setLinkItemId(thisOrganization.getOrgId());
        thisCategory.setBuildResources(true);
        thisCategory.buildRecordId(db);
        thisCategory.buildResources(db);
        if (recordId == null || "".equals(recordId.trim()) || "-1".equals(recordId)) {
          if (thisCategory.getRecordId() != -1) {
            recordId = String.valueOf(thisCategory.getRecordId());
          }
        }
        if ((recordId != null && !"".equals(recordId.trim())) && !"-1".equals(recordId)) {
          CustomFieldRecord thisRecord = new CustomFieldRecord(
              db, Integer.parseInt(recordId));
          context.getRequest().setAttribute("Record", thisRecord);
        }
        if (thisCategory.getRecordId() == -1 && thisCategory.getAllowMultipleRecords()) {
          //The user didn't request a specific record, so show a list
          //of records matching this category that the user can choose from
          PagedListInfo folderListInfo = this.getPagedListInfo(
              context, "AccountFolderInfo");
          folderListInfo.setLink(
              "Accounts.do?command=Fields&orgId=" + orgId + "&catId=" + selectedCatId);

          CustomFieldRecordList recordList = new CustomFieldRecordList();
          recordList.setLinkModuleId(Constants.ACCOUNTS);
          recordList.setLinkItemId(thisOrganization.getOrgId());
          recordList.setCategoryId(thisCategory.getId());
          recordList.buildList(db);
          recordList.buildRecordColumns(db, thisCategory);
          hasMultipleRecords = (recordList.size() > 0 && (recordId == null || "".equals(recordId.trim()))) ||
              (recordList.size() > 1 && recordId != null && !"".equals(recordId.trim()));
          context.getRequest().setAttribute("Records", recordList);
        } else
        if (thisCategory.getRecordId() != -1 && thisCategory.getAllowMultipleRecords()) {
          context.getRequest().setAttribute("recordDeleted", "true");
          return executeCommandFields(context, db);
        } else
        if (thisCategory.getRecordId() != -1 && !thisCategory.getAllowMultipleRecords()) {
          context.getRequest().setAttribute("recId", recordId);
          return executeCommandModifyFields(context, db);
        } else
        if (thisCategory.getRecordId() == -1 && !thisCategory.getAllowMultipleRecords()) {
          return executeCommandAddFolderRecord(context, db);
        }
        //The user requested a specific record, or this category only
        //allows a single record.
        context.getRequest().setAttribute("Category", thisCategory);
      }
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "View Accounts", "Custom Fields Details");
    if (Integer.parseInt(selectedCatId) <= 0) {
      return getReturn(context, "FieldsEmpty");
    } else {
      if (hasMultipleRecords) {
        return executeCommandModifyFields(context);
      }
      return getReturn(context, "FieldRecordList");
    }
  }


  /**
   * AddFolderRecord: Displays the form for inserting a new custom field record
   * for the selected Account.
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandAddFolderRecord(ActionContext context) {
    Connection db = null;
    String status = null;
    try {
      db = this.getConnection(context);
      status = this.executeCommandAddFolderRecord(context, db);
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return status;
  }

  private String executeCommandAddFolderRecord(ActionContext context, Connection db) throws NumberFormatException, SQLException {
    if (!(hasPermission(context, "accounts-accounts-folders-add"))) {
      return ("PermissionError");
    }
    String source = context.getRequest().getParameter("source");
    String actionStepId = context.getRequest().getParameter("actionStepId");
    if (source != null && !"".equals(source.trim())) {
      context.getRequest().setAttribute("source", source);
    }
    if (actionStepId != null && !"".equals(actionStepId.trim())) {
      context.getRequest().setAttribute("actionStepId", actionStepId);
    }
    Organization thisOrganization = null;
    String orgId = context.getRequest().getParameter("orgId");
    //Check access permission to organization record
    if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
      return ("PermissionError");
    }
    thisOrganization = new Organization(db, Integer.parseInt(orgId));
    context.getRequest().setAttribute("OrgDetails", thisOrganization);

    String selectedCatId = (String) context.getRequest().getParameter(
        "catId");
    CustomFieldCategory thisCategory = new CustomFieldCategory(
        db,
        Integer.parseInt(selectedCatId));
    thisCategory.setLinkModuleId(Constants.ACCOUNTS);
    thisCategory.setLinkItemId(thisOrganization.getOrgId());
    thisCategory.setIncludeEnabled(Constants.TRUE);
    thisCategory.setIncludeScheduled(Constants.TRUE);
    thisCategory.setBuildResources(true);
    thisCategory.buildResources(db);
    context.getRequest().setAttribute("Category", thisCategory);
    addModuleBean(context, "View Accounts", "Add Folder Record");
    context.getRequest().setAttribute(
        "systemStatus", this.getSystemStatus(context));
    return getReturn(context, "AddFolderRecord");
  }


  /**
   * ModifyFields: Displays the modify form for the selected Custom Field
   * Record.
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */

  public String executeCommandModifyFields(ActionContext context) {
    Connection db = null;
    String status = null;
    try {
      db = this.getConnection(context);
      status = this.executeCommandModifyFields(context, db);
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return status;
  }


  private String executeCommandModifyFields(ActionContext context, Connection db) throws SQLException {
    if (!hasPermission(context, "accounts-accounts-folders-edit")) {
      return ("PermissionError");
    }
    Organization thisOrganization = null;
    String source = context.getRequest().getParameter("source");
    String actionStepId = context.getRequest().getParameter("actionStepId");
    if (source != null && !"".equals(source.trim())) {
      context.getRequest().setAttribute("source", source);
    }
    if (actionStepId != null && !"".equals(actionStepId.trim())) {
      context.getRequest().setAttribute("actionStepId", actionStepId);
    }
    String selectedCatId = (String) context.getRequest().getParameter("catId");
    String recordId = (String) context.getRequest().getParameter("recId");
    if (recordId == null || "".equals(recordId.trim()) || "-1".equals(recordId.trim())) {
      recordId = (String) context.getRequest().getAttribute("recId");
      if (recordId == null || "".equals(recordId.trim())) {
        recordId = String.valueOf(-1);
      }
    }
    String orgId = context.getRequest().getParameter("orgId");
    //Check access permission to organization record
    if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
      return ("PermissionError");
    }
    thisOrganization = new Organization(db, Integer.parseInt(orgId));
    context.getRequest().setAttribute("OrgDetails", thisOrganization);

    CustomFieldCategory thisCategory = new CustomFieldCategory(
        db,
        Integer.parseInt(selectedCatId));
    thisCategory.setLinkModuleId(Constants.ACCOUNTS);
    thisCategory.setLinkItemId(thisOrganization.getOrgId());
    thisCategory.setRecordId(Integer.parseInt(recordId));
    thisCategory.setIncludeEnabled(Constants.TRUE);
    thisCategory.setIncludeScheduled(Constants.TRUE);
    thisCategory.setBuildResources(true);
    thisCategory.buildResources(db);
    context.getRequest().setAttribute("Category", thisCategory);
    addModuleBean(context, "View Accounts", "Modify Custom Fields");
    context.getRequest().setAttribute(
        "systemStatus", this.getSystemStatus(context));
    if (recordId.equals("-1")) {
      return getReturn(context, "AddFolderRecord");
    } else {
      return getReturn(context, "ModifyFields");
    }
  }


  /**
   * UpdateFields: Performs the actual update of the selected Custom Field
   * Record based on user-submitted information from the modify form.
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandUpdateFields(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-folders-edit"))) {
      return ("PermissionError");
    }
    Connection db = null;
    String source = context.getRequest().getParameter("source");
    String actionStepId = context.getRequest().getParameter("actionStepId");
    if (source != null && !"".equals(source.trim())) {
      context.getRequest().setAttribute("source", source);
    }
    if (actionStepId != null && !"".equals(actionStepId.trim())) {
      context.getRequest().setAttribute("actionStepId", actionStepId);
    }
    Organization thisOrganization = null;
    int resultCount = 0;
    boolean isValid = false;
    context.getRequest().setAttribute(
        "systemStatus", this.getSystemStatus(context));

    try {
      String orgId = context.getRequest().getParameter("orgId");
      db = this.getConnection(context);
      //Check access permission to organization record
      if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
        return ("PermissionError");
      }
      thisOrganization = new Organization(db, Integer.parseInt(orgId));
      context.getRequest().setAttribute("OrgDetails", thisOrganization);

      CustomFieldCategoryList thisList = new CustomFieldCategoryList();
      thisList.setLinkModuleId(Constants.ACCOUNTS);
      thisList.setIncludeEnabled(Constants.TRUE);
      thisList.setIncludeScheduled(Constants.TRUE);
      thisList.setBuildResources(false);
      thisList.buildList(db);
      context.getRequest().setAttribute("CategoryList", thisList);

      String selectedCatId = (String) context.getRequest().getParameter(
          "catId");
      String recordId = (String) context.getRequest().getParameter("recId");
      context.getRequest().setAttribute("catId", selectedCatId);
      CustomFieldCategory thisCategory = new CustomFieldCategory(
          db,
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
        thisCategory.setCanNotContinue(true);
        isValid = this.validateObject(context, db, thisCategory);
        if (isValid) {
          Iterator groups = (Iterator) thisCategory.iterator();
          while (groups.hasNext()) {
            CustomFieldGroup group = (CustomFieldGroup) groups.next();
            Iterator fields = (Iterator) group.iterator();
            while (fields.hasNext()) {
              CustomField field = (CustomField) fields.next();
              field.setValidateData(true);
              field.setRecordId(thisCategory.getRecordId());
              isValid = this.validateObject(context, db, field) && isValid;
            }
          }
        }
        if (isValid && resultCount != -1) {
          thisCategory.setCanNotContinue(true);
          resultCount = thisCategory.update(db);
          thisCategory.setCanNotContinue(false);
          resultCount = thisCategory.insertGroup(
              db, thisCategory.getRecordId());
        }
      }
      context.getRequest().setAttribute("Category", thisCategory);
      if (resultCount != -1 && isValid) {
        thisCategory.buildResources(db);
        CustomFieldRecord thisRecord = new CustomFieldRecord(
            db, thisCategory.getRecordId());
        context.getRequest().setAttribute("Record", thisRecord);
      } else {
        if (System.getProperty("DEBUG") != null) {
          System.out.println("Accounts-> ModifyField validation error");
        }
        if (actionStepId != null && !"".equals(actionStepId.trim())) {
          context.getRequest().setAttribute("recId", recordId);
        }
        context.getRequest().setAttribute(
            "systemStatus", this.getSystemStatus(context));
        return getReturn(context, "ModifyFields");
      }
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    if (resultCount == 1 && isValid) {
      if (context.getRequest().getParameter("source") != null && "attachplan".equals(context.getRequest().getParameter("source"))) {
        return "UpdateFieldsAttachPlanOK";
      }
      return getReturn(context, "UpdateFields");
    } else {
      context.getRequest().setAttribute(
          "Error", CFSModule.NOT_UPDATED_MESSAGE);
      return ("UserError");
    }
  }


  /**
   * InsertFields: Performs the actual insert of a new Custom Field Record.
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandInsertFields(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-folders-add"))) {
      return ("PermissionError");
    }
    boolean popup = false;
    String source = context.getRequest().getParameter("source");
    String actionStepId = context.getRequest().getParameter("actionStepId");
    if (source != null && !"".equals(source.trim())) {
      context.getRequest().setAttribute("source", source);
    }
    if (actionStepId != null && !"".equals(actionStepId.trim())) {
      context.getRequest().setAttribute("actionStepId", actionStepId);
    }
    String popupString = context.getRequest().getParameter("popup");
    popup = (popupString != null && !"".equals(popupString.trim()) && "true".equals(popupString));
    Connection db = null;
    int resultCode = -1;
    boolean isValid = false;
    Organization thisOrganization = null;

    try {
      db = this.getConnection(context);
      String orgId = context.getRequest().getParameter("orgId");
      //Check access permission to organization record
      if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
        return ("PermissionError");
      }
      thisOrganization = new Organization(db, Integer.parseInt(orgId));
      context.getRequest().setAttribute("OrgDetails", thisOrganization);

      CustomFieldCategoryList thisList = new CustomFieldCategoryList();
      thisList.setLinkModuleId(Constants.ACCOUNTS);
      thisList.setIncludeEnabled(Constants.TRUE);
      thisList.setIncludeScheduled(Constants.TRUE);
      thisList.setBuildResources(false);
      thisList.buildList(db);
      context.getRequest().setAttribute("CategoryList", thisList);

      String selectedCatId = (String) context.getRequest().getParameter(
          "catId");
      context.getRequest().setAttribute("catId", selectedCatId);
      CustomFieldCategory thisCategory = new CustomFieldCategory(
          db,
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
        thisCategory.setCanNotContinue(true);
        isValid = this.validateObject(context, db, thisCategory);
        if (isValid) {
          resultCode = thisCategory.insert(db);
          Iterator groups = (Iterator) thisCategory.iterator();
          while (groups.hasNext()) {
            CustomFieldGroup group = (CustomFieldGroup) groups.next();
            Iterator fields = (Iterator) group.iterator();
            while (fields.hasNext()) {
              CustomField field = (CustomField) fields.next();
              field.setValidateData(true);
              field.setRecordId(thisCategory.getRecordId());
              isValid = this.validateObject(context, db, field) && isValid;
            }
          }
        }
        thisCategory.setCanNotContinue(false);
        if (isValid && resultCode != -1) {
          resultCode = thisCategory.insertGroup(
              db, thisCategory.getRecordId());
        }
      }
      context.getRequest().setAttribute("Category", thisCategory);
      if (resultCode != -1 && isValid) {
        processInsertHook(context, thisCategory);
      } else {
        if (thisCategory.getRecordId() != -1) {
          CustomFieldRecord record = new CustomFieldRecord(
              db, thisCategory.getRecordId());
          record.delete(db);
        }
        if (System.getProperty("DEBUG") != null) {
          System.out.println("Accounts-> InsertField validation error");
        }
        context.getRequest().setAttribute(
            "systemStatus", this.getSystemStatus(context));
        return getReturn(context, "AddFolderRecord");
      }
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    if (popup) {
      if (context.getRequest().getParameter("source") != null && "attachplan".equals(context.getRequest().getParameter("source"))) {
        return "InsertFieldsAttachPlanOK";
      }
    }
    return (this.executeCommandFields(context));
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandDeleteFields(ActionContext context) {
    if (!(hasPermission(context, "accounts-accounts-folders-delete"))) {
      return ("PermissionError");
    }
    String source = context.getRequest().getParameter("source");
    boolean returnToList = true;
    String actionStepId = context.getRequest().getParameter("actionStepId");
    ActionItemWork item = null;
    if (source != null && !"".equals(source.trim())) {
      context.getRequest().setAttribute("source", source);
    }
    if (actionStepId != null && !"".equals(actionStepId.trim())) {
      context.getRequest().setAttribute("actionStepId", actionStepId);
    }
    Connection db = null;
    try {
      db = this.getConnection(context);
      String selectedCatId = context.getRequest().getParameter("catId");
      String recordId = context.getRequest().getParameter("recId");
      String orgId = context.getRequest().getParameter("orgId");

      //Check access permission to organization record
      if (!isRecordAccessPermitted(context, db, Integer.parseInt(orgId))) {
        return ("PermissionError");
      }

      CustomFieldCategory thisCategory = new CustomFieldCategory(
          db,
          Integer.parseInt(selectedCatId));

      CustomFieldRecord thisRecord = new CustomFieldRecord(
          db, Integer.parseInt(recordId));
      thisRecord.setLinkModuleId(Constants.ACCOUNTS);
      thisRecord.setLinkItemId(Integer.parseInt(orgId));
      thisRecord.setCategoryId(Integer.parseInt(selectedCatId));
      if (actionStepId != null && !"".equals(actionStepId.trim()) && !"-1".equals(actionStepId) && !"null".equals(actionStepId)) {
        item = new ActionItemWork(db, Integer.parseInt(actionStepId));
      }
      if (!thisCategory.getReadOnly()) {
        thisRecord.delete(db);
      }
      context.getRequest().setAttribute("recordDeleted", "true");
      if (item != null && item.getId() > 0) {
        if (thisRecord.getId() == item.getLinkItemId() && item.getLinkModuleId() == ActionPlan.getMapIdGivenConstantId(db, ActionPlan.ACCOUNTS)) {
          returnToList = false;
          thisCategory.setRecordId(thisRecord.getId());
          context.getRequest().setAttribute("Category", thisCategory);
        }
      }
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    if (returnToList) {
      return getReturn(context, "DeleteFields");
    }
    return "DeletedFieldPopupOK";
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
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
    this.deletePagedListInfo(context, "AccountProjectInfo");
    this.deletePagedListInfo(context, "orgHistoryListInfo");
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
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

        LookupList addrTypeList = new LookupList(
            db, "lookup_orgaddress_types");
        context.getRequest().setAttribute("OrgAddressTypeList", addrTypeList);

        LookupList emailTypeList = new LookupList(db, "lookup_orgemail_types");
        context.getRequest().setAttribute("OrgEmailTypeList", emailTypeList);
      } else {
        LookupList phoneTypeList = new LookupList(
            db, "lookup_contactphone_types");
        context.getRequest().setAttribute("OrgPhoneTypeList", phoneTypeList);

        LookupList addrTypeList = new LookupList(
            db, "lookup_contactaddress_types");
        context.getRequest().setAttribute("OrgAddressTypeList", addrTypeList);

        LookupList emailTypeList = new LookupList(
            db, "lookup_contactemail_types");
        context.getRequest().setAttribute("OrgEmailTypeList", emailTypeList);
      }
    } catch (Exception errorMessage) {

    } finally {
      this.freeConnection(context, db);
    }
    return ("RebuildElementsOK");
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @return Description of the Return Value
   */
  public String executeCommandOwnerJSList(ActionContext context) {

    int siteId = -1;
    String siteIdString = context.getRequest().getParameter("siteId");
    if ((siteIdString != null) || !"".equals(siteIdString)) {
      siteId = Integer.parseInt(siteIdString);
    }
    if (!isSiteAccessPermitted(context, String.valueOf(siteId))) {
      return ("PermissionError");
    }
    UserList userList = new UserList();
    HtmlSelect userListSelect = new HtmlSelect();
    try {
      userList = filterOwnerListForSite(context, siteId);
      userListSelect = userList.getHtmlSelectObj("userId", this.getUserId(context));
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    }
    context.getRequest().setAttribute("UserListSelect", userListSelect);
    return ("OwnerJsListOK");
  }


  /**
   * Description of the Method
   *
   * @param context Description of the Parameter
   * @param siteId  Description of the Parameter
   * @return Description of the Return Value
   * @throws Exception Description of the Exception
   */
  private UserList filterOwnerListForSite(ActionContext context, int siteId) throws Exception {
    UserBean thisUser = (UserBean) context.getSession().getAttribute("User");
    //this is how we get the multiple-level heirarchy...recursive function.
    User thisRec = thisUser.getUserRecord();
    UserList shortChildList = thisRec.getShortChildList();
    UserList userList = thisRec.getFullChildList(
        shortChildList, new UserList());
    userList.setMyId(getUserId(context));
    userList.setMyValue(thisUser.getContact().getNameLastFirst());
    userList.setIncludeMe(true);
    userList.setExcludeDisabledIfUnselected(true);
    userList.setExcludeExpiredIfUnselected(true);

    // filter possible owners for accounts with site ids.

    // An account WITH a site id can be owned by a user with the same
    // site id or by one who has access to all sites
    // (i.e., siteId = -1 or site_id IS NULL)
    if (siteId != -1) {
      Iterator itr = userList.iterator();
      while (itr.hasNext()) {
        User tmpUser = (User) itr.next();
        if (tmpUser.getSiteId() == -1) {
          continue;
        }
        if (siteId != tmpUser.getSiteId()) {
          itr.remove();
        }
      }
    }

    // An account WITHOUT a site id can ONLY be owned by a user with access
    // to all sites
    // (i.e., siteId = -1 or site_id IS NULL)
    if (siteId == -1) {
      Iterator itr = userList.iterator();
      while (itr.hasNext()) {
        User tmpUser = (User) itr.next();
        if (siteId != tmpUser.getSiteId()) {
          itr.remove();
        }
      }
    }
    return userList;
  }

  /**
   * Description of the Method
   *
   * @param context      Description of the Parameter
   * @param organization Description of the Parameter
   * @param db           Description of the Parameter
   * @throws Exception Description of the Exception
   */
  protected void deleteRecentItems(ActionContext context, Connection db, Organization organization) throws SQLException {
    //remove any recent contacts belonging to this account
    ContactList contactList = new ContactList();
    contactList.setOrgId(organization.getOrgId());
    contactList.setIncludeOnlyTrashed(true);
    contactList.buildList(db);

    this.deleteRecentItems(context, contactList.iterator());

    //remove any recent contact opps
    Iterator i = contactList.iterator();
    while (i.hasNext()) {
      Contact contact = (Contact) i.next();
      OpportunityHeaderList oppList = new OpportunityHeaderList();
      oppList.setContactId(contact.getId());
      oppList.setIncludeOnlyTrashed(true);
      oppList.buildList(db);

      this.deleteRecentItems(context, oppList.iterator());
    }

    //remove any recent account opps
    OpportunityHeaderList opportunityList = new OpportunityHeaderList();
    opportunityList.setOrgId(organization.getOrgId());
    opportunityList.setIncludeOnlyTrashed(true);
    opportunityList.buildList(db);

    this.deleteRecentItems(context, opportunityList.iterator());

    //remove any recent tickets
    TicketList ticketList = new TicketList();
    ticketList.setOrgId(organization.getOrgId());
    ticketList.setIncludeOnlyTrashed(true);
    ticketList.buildList(db);

    this.deleteRecentItems(context, ticketList.iterator());
  }

  public String executeCommandStates(ActionContext context) {
    String country = context.getRequest().getParameter("country");
    String form = context.getRequest().getParameter("form");
    String obj = context.getRequest().getParameter("obj");
    String stateObj = context.getRequest().getParameter("stateObj");
    String defaultValue = context.getRequest().getParameter("selected");
    SystemStatus systemStatus = this.getSystemStatus(context);
    StateSelect stateSelect = new StateSelect(systemStatus, country);
    context.getRequest().setAttribute("stateSelect", stateSelect.getHtmlSelectObj(country));
    context.getRequest().setAttribute("form", form);
    context.getRequest().setAttribute("obj", obj);
    context.getRequest().setAttribute("stateObj", stateObj);
    if (defaultValue != null) {
      context.getRequest().setAttribute("selected", defaultValue);
    }
    return "StatesOK";
  }

  public String executeCommandDashboards(ActionContext context) {
    if (!hasPermission(context, "accounts-dashboards-view")) {
      return executeCommandDashboard(context);
    }

    String moduleId = Integer.toString(Constants.ACCOUNTS);
    String dashboardsContainerName = "dashboards" + moduleId;
    context.getRequest().setAttribute("moduleId", moduleId);
    context.getRequest().setAttribute("dashboardsContainerName", dashboardsContainerName);
    context.getRequest().setAttribute("action", context.getRequest().getAttribute("moduleAction"));
    return "DashboardsViewOK";
  }
}

