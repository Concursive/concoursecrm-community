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
package org.aspcfs.modules.contacts.actions;

import com.darkhorseventures.framework.actions.ActionContext;
import java.sql.*;
import java.util.*;
import java.io.*;
import java.text.*;
import org.aspcfs.utils.*;
import org.aspcfs.utils.web.*;
import org.aspcfs.modules.contacts.base.*;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.communications.base.Campaign;
import org.aspcfs.modules.communications.base.CampaignList;
import org.aspcfs.modules.admin.base.User;
import org.aspcfs.modules.admin.base.UserList;
import org.aspcfs.modules.login.beans.UserBean;
import org.aspcfs.modules.accounts.base.OrganizationList;
import org.aspcfs.modules.accounts.base.Organization;
import org.aspcfs.modules.pipeline.base.OpportunityHeaderList;
import org.aspcfs.modules.admin.base.AccessTypeList;
import org.aspcfs.modules.admin.base.AccessType;
import org.aspcfs.modules.base.*;
import com.zeroio.webutils.*;
import com.zeroio.iteam.base.FileItemList;
import com.zeroio.iteam.base.FileItem;

/**
 *  Description of the Class
 *
 *@author     mrajkowski
 *@created    September 24, 2001
 *@version    $Id: ExternalContacts.java,v 1.2 2001/10/03 15:40:42 mrajkowski
 *      Exp $
 */
public final class ExternalContacts extends CFSModule {

  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandDefault(ActionContext context) {
    if (!(hasPermission(context, "contacts-external_contacts-view"))) {
      return ("DefaultError");
    }
    return (this.executeCommandSearchContactsForm(context));
  }


  /**
   *  Show reports page
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandReports(ActionContext context) {
    if (!(hasPermission(context, "contacts-external_contacts-reports-view"))) {
      return ("PermissionError");
    }
    Connection db = null;
    FileItemList files = new FileItemList();
    files.setLinkModuleId(Constants.DOCUMENTS_CONTACTS_REPORTS);
    files.setLinkItemId(-1);

    PagedListInfo rptListInfo = this.getPagedListInfo(context, "ContactRptListInfo");
    rptListInfo.setLink("ExternalContacts.do?command=Reports");
    files.setPagedListInfo(rptListInfo);

    if ("all".equals(rptListInfo.getListView())) {
      files.setOwnerIdRange(this.getUserRange(context));
    } else {
      files.setOwner(this.getUserId(context));
    }
    try {
      db = this.getConnection(context);
      files.buildList(db);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Reports", "ViewReports");
    context.getRequest().setAttribute("FileList", files);
    return ("ReportsOK");
  }



  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandDownloadCSVReport(ActionContext context) {
    if (!(hasPermission(context, "contacts-external_contacts-reports-view"))) {
      return ("PermissionError");
    }
    String itemId = (String) context.getRequest().getParameter("fid");
    FileItem thisItem = null;
    Connection db = null;
    try {
      db = getConnection(context);
      thisItem = new FileItem(db, Integer.parseInt(itemId), -1, Constants.DOCUMENTS_CONTACTS_REPORTS);
      if (!hasAuthority(context, thisItem.getEnteredBy())) {
        return ("PermissionError");
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    //Start the download
    try {
      FileItem itemToDownload = null;
      itemToDownload = thisItem;
      //itemToDownload.setEnteredBy(this.getUserId(context));
      String filePath = this.getPath(context, "contact-reports") + getDatePath(itemToDownload.getEntered()) + itemToDownload.getFilename() + ".csv";
      FileDownload fileDownload = new FileDownload();
      fileDownload.setFullPath(filePath);
      fileDownload.setDisplayName(itemToDownload.getClientFilename());
      if (fileDownload.fileExists()) {
        fileDownload.sendFile(context);
        //Get a db connection now that the download is complete
        db = getConnection(context);
        itemToDownload.updateCounter(db);
      } else {
        System.err.println("PMF-> Trying to send a file that does not exist");
      }
    } catch (java.net.SocketException se) {
      //User either canceled the download or lost connection
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return ("-none-");
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandDeleteReport(ActionContext context) {

    if (!(hasPermission(context, "contacts-external_contacts-reports-delete"))) {
      return ("PermissionError");
    }
    boolean recordDeleted = false;

    String projectId = (String) context.getRequest().getParameter("pid");
    String itemId = (String) context.getRequest().getParameter("fid");

    Connection db = null;
    try {
      db = getConnection(context);

      FileItem thisItem = new FileItem(db, Integer.parseInt(itemId), -1, Constants.DOCUMENTS_CONTACTS_REPORTS);
      if (!hasAuthority(context, thisItem.getEnteredBy())) {
        return ("PermissionError");
      }

      if (thisItem.getEnteredBy() == this.getUserId(context)) {
        recordDeleted = thisItem.delete(db, this.getPath(context, "contact-reports"));

        String filePath1 = this.getPath(context, "contact-reports") + getDatePath(thisItem.getEntered()) + thisItem.getFilename() + ".csv";
        java.io.File fileToDelete1 = new java.io.File(filePath1);
        if (!fileToDelete1.delete()) {
          System.err.println("FileItem-> Tried to delete file: " + filePath1);
        }

        String filePath2 = this.getPath(context, "contact-reports") + getDatePath(thisItem.getEntered()) + thisItem.getFilename() + ".html";
        java.io.File fileToDelete2 = new java.io.File(filePath2);
        if (!fileToDelete2.delete()) {
          System.err.println("FileItem-> Tried to delete file: " + filePath2);
        }
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
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
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandGenerateForm(ActionContext context) {
    if (!hasPermission(context, "contacts-external_contacts-reports-add")) {
      return ("PermissionError");
    }
    Connection db = null;
    try {
      CustomFieldCategoryList thisList = new CustomFieldCategoryList();
      thisList.setLinkModuleId(Constants.CONTACTS);
      thisList.setIncludeEnabled(Constants.TRUE);
      thisList.setIncludeScheduled(Constants.TRUE);
      thisList.setAllSelectOption(true);
      thisList.setBuildResources(false);
      db = getConnection(context);
      thisList.buildList(db);
      context.getRequest().setAttribute("CategoryList", thisList);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Reports", "Generate new");
    return ("GenerateFormOK");
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandShowReportHtml(ActionContext context) {
    if (!hasPermission(context, "contacts-external_contacts-reports-view")) {
      return ("PermissionError");
    }
    Connection db = null;
    FileItem thisItem = null;
    String projectId = (String) context.getRequest().getParameter("pid");
    String itemId = (String) context.getRequest().getParameter("fid");
    try {
      db = getConnection(context);
      thisItem = new FileItem(db, Integer.parseInt(itemId));
      String filePath = this.getPath(context, "contact-reports") + getDatePath(thisItem.getEntered()) + thisItem.getFilename() + ".html";
      String textToShow = this.includeFile(filePath);
      context.getRequest().setAttribute("ReportText", textToShow);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    if (!hasAuthority(context, thisItem.getEnteredBy())) {
      return ("PermissionError");
    }
    return ("ReportHtmlOK");
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandExportReport(ActionContext context) {
    if (!hasPermission(context, "contacts-external_contacts-reports-add")) {
      return ("PermissionError");
    }
    boolean recordInserted = false;
    Connection db = null;
    String subject = context.getRequest().getParameter("subject");
    String ownerCriteria = context.getRequest().getParameter("criteria1");
    String type = context.getRequest().getParameter("type");
    //setup file stuff
    String filePath = this.getPath(context, "contact-reports");
    SimpleDateFormat formatter1 = new SimpleDateFormat("yyyy");
    String datePathToUse1 = formatter1.format(new java.util.Date());
    SimpleDateFormat formatter2 = new SimpleDateFormat("MMdd");
    String datePathToUse2 = formatter2.format(new java.util.Date());
    filePath += datePathToUse1 + fs + datePathToUse2 + fs;
    //Prepare the report
    ContactReport contactReport = new ContactReport();
    contactReport.setCriteria(context.getRequest().getParameterValues("selectedList"));
    contactReport.setFilePath(filePath);
    contactReport.setSubject(subject);
    contactReport.addIgnoreTypeId(Contact.EMPLOYEE_TYPE);
    //Prepare the pagedList to provide sorting
    PagedListInfo thisInfo = new PagedListInfo();
    thisInfo.setColumnToSortBy(context.getRequest().getParameter("sort"));
    thisInfo.setItemsPerPage(0);
    contactReport.setPagedListInfo(thisInfo);

    int folderId = Integer.parseInt(context.getRequest().getParameter("catId"));
    if (type.equals("4") && folderId == 0) {
      contactReport.setIncludeFolders(true);
    } else if (type.equals("4") && folderId > 0) {
      contactReport.setFolderId(folderId);
    }
    //make sure user has access to view account contacts
    if (!(hasPermission(context, "accounts-accounts-contacts-view"))) {
      contactReport.setExcludeAccountContacts(true);
    }
    //Check the form selections and criteria
    if (ownerCriteria.equals("my")) {
      contactReport.setOwner(this.getUserId(context));
      //ignore personal check as all personal contacts are covered with the owner criteria
      contactReport.setPersonalId(ContactList.IGNORE_PERSONAL);
    } else if (ownerCriteria.equals("hierarchy")) {
      contactReport.setControlledHierarchyOnly(true, this.getUserRange(context));
      contactReport.setPersonalId(this.getUserId(context));
    } else if (ownerCriteria.equals("all")) {
      //get all contacts (including personal)
      contactReport.setAllContacts(true, this.getUserId(context), this.getUserRange(context));
    } else if (ownerCriteria.equals("public")) {
      //get public contacts only
      contactReport.setRuleId(AccessType.PUBLIC);
    } else if (ownerCriteria.equals("personal")) {
      //get personal contacts owned by me
      contactReport.setRuleId(AccessType.PERSONAL);
      contactReport.setPersonalId(this.getUserId(context));
    }
    try {
      db = this.getConnection(context);
      //builds list also
      contactReport.buildReportFull(db, this.getUserTable(context));
      contactReport.setEnteredBy(getUserId(context));
      contactReport.setModifiedBy(getUserId(context));
      //TODO: set owner, enteredby, and modified names
      contactReport.saveAndInsert(db);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return executeCommandReports(context);
  }


  /**
   *  Searches for contacts and builds a contact list
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandSearchContacts(ActionContext context) {
    if (!hasPermission(context, "contacts-external_contacts-view")) {
      return ("PermissionError");
    }
    boolean search = false;
    PagedListInfo searchContactsInfo = this.getPagedListInfo(context, "SearchContactsInfo");
    searchContactsInfo.setLink("ExternalContacts.do?command=SearchContacts");
    String source = (String) context.getRequest().getParameter("source");
    addModuleBean(context, "External Contacts", "Search Results");
    ContactList contactList = new ContactList();
    Connection db = null;
    try {
      db = this.getConnection(context);
      //return if no criteria is selected
      if ((searchContactsInfo.getListView() == null || "".equals(searchContactsInfo.getListView())) && !"searchForm".equals(source)) {
        return "ListContactsOK";
      }
      //set the searchcriteria
      searchContactsInfo.setSearchCriteria(contactList, UserUtils.getUserLocale(context.getRequest()));
      //make sure user has access to view account contacts
      if (!(hasPermission(context, "accounts-accounts-contacts-view"))) {
        contactList.setExcludeAccountContacts(true);
      }
      //set properties on contact list
      contactList.setPagedListInfo(searchContactsInfo);
      contactList.setBuildDetails(true);
      contactList.setBuildTypes(false);
      contactList.addIgnoreTypeId(Contact.EMPLOYEE_TYPE);
      contactList.setTypeId(searchContactsInfo.getFilterKey("listFilter1"));

      //check if a filter is selected
      if ("all".equals(searchContactsInfo.getListView())) {
        contactList.setAllContacts(true, this.getUserId(context), this.getUserRange(context));
      } else if ("hierarchy".equals(searchContactsInfo.getListView())) {
        contactList.setControlledHierarchyOnly(true, this.getUserRange(context));
        contactList.setPersonalId(this.getUserId(context));
      } else if ("archived".equals(searchContactsInfo.getListView())) {
        contactList.setIncludeEnabled(ContactList.FALSE);
        contactList.setPersonalId(this.getUserId(context));
      } else if ("my".equals(searchContactsInfo.getListView())) {
        contactList.setOwner(this.getUserId(context));
        contactList.setPersonalId(ContactList.IGNORE_PERSONAL);
      }
      contactList.buildList(db);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    context.getRequest().setAttribute("ContactList", contactList);
    return ("ListContactsOK");
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandMessageDetails(ActionContext context) {
    addModuleBean(context, "External Contacts", "Message Details");
    Connection db = null;
    Contact thisContact = null;
    Campaign campaign = null;

    String campaignId = context.getRequest().getParameter("id");
    try {
      db = this.getConnection(context);
      String contactId = context.getRequest().getParameter("contactId");
      thisContact = new Contact(db, contactId);
      if (!(hasPermission(context, "contacts-external_contacts-messages-view")) || (thisContact.getOrgId() > 0 && !(hasPermission(context, "accounts-accounts-contacts-view")))) {
        return ("PermissionError");
      }
      campaign = new Campaign(db, campaignId);
      context.getRequest().setAttribute("Campaign", campaign);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    if (!hasAuthority(context, campaign.getEnteredBy())) {
      return ("PermissionError");
    }
    boolean popup = "true".equals(context.getRequest().getParameter("popup"));
    addModuleBean(context, "External Contacts", "Messages");
    context.getRequest().setAttribute("ContactDetails", thisContact);
    if (popup) {
      return ("MessageDetailsPopupOK");
    }
    return ("MessageDetailsOK");
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandViewMessages(ActionContext context) {
    Connection db = null;
    Contact thisContact = null;
    String contactId = context.getRequest().getParameter("contactId");
    if ("true".equals(context.getRequest().getParameter("contactId"))) {
      context.getSession().removeAttribute("ContactMessageListInfo");
    }
    PagedListInfo pagedListInfo = this.getPagedListInfo(context, "ContactMessageListInfo");
    pagedListInfo.setLink("ExternalContacts.do?command=ViewMessages&contactId=" + contactId + HTTPUtils.addLinkParams(context.getRequest(), "popup|popupType|actionId"));
    try {
      db = this.getConnection(context);

      thisContact = new Contact(db, contactId);
      if (!(hasPermission(context, "contacts-external_contacts-messages-view")) || (thisContact.getOrgId() > 0 && !(hasPermission(context, "accounts-accounts-contacts-view")))) {
        return ("PermissionError");
      }
      if (!hasAuthority(db, context, thisContact)) {
        return ("PermissionError");
      }
      context.getRequest().setAttribute("ContactDetails", thisContact);
      CampaignList campaignList = new CampaignList();
      campaignList.setPagedListInfo(pagedListInfo);
      campaignList.setCompleteOnly(true);
      campaignList.setContactId(Integer.parseInt(contactId));
      //Check the dropdown
      if ("all".equals(pagedListInfo.getListView())) {
        campaignList.setOwnerIdRange(this.getUserRange(context));
      } else {
        campaignList.setOwner(this.getUserId(context));
      }
      campaignList.buildList(db);
      context.getRequest().setAttribute("campList", campaignList);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    boolean popup = "true".equals(context.getRequest().getParameter("popup"));
    addModuleBean(context, "External Contacts", "Messages");
    if (popup) {
      return ("ViewMessagesPopupOK");
    }
    return ("ViewMessagesOK");
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandAddFolderRecord(ActionContext context) {
    Connection db = null;
    Contact thisContact = null;
    try {
      String contactId = context.getRequest().getParameter("contactId");
      db = this.getConnection(context);
      thisContact = new Contact(db, contactId);

      if (!(hasPermission(context, "contacts-external_contacts-folders-add")) || (thisContact.getOrgId() > 0 && !(hasPermission(context, "accounts-accounts-contacts-edit")))) {
        return ("PermissionError");
      }
      if (!hasAuthority(db, context, thisContact)) {
        return ("PermissionError");
      }
      context.getRequest().setAttribute("ContactDetails", thisContact);

      String selectedCatId = (String) context.getRequest().getParameter("catId");
      CustomFieldCategory thisCategory = new CustomFieldCategory(db,
          Integer.parseInt(selectedCatId));
      thisCategory.setLinkModuleId(Constants.CONTACTS);
      thisCategory.setLinkItemId(thisContact.getId());
      thisCategory.setIncludeEnabled(Constants.TRUE);
      thisCategory.setIncludeScheduled(Constants.TRUE);
      thisCategory.setBuildResources(true);
      thisCategory.buildResources(db);
      context.getRequest().setAttribute("Category", thisCategory);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "External Contacts", "Add Folder Record");
    return this.getReturn(context, "AddFolderRecord");
  }



  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandFields(ActionContext context) {
    Connection db = null;
    Contact thisContact = null;
    String recordId = null;
    boolean showRecords = true;
    String selectedCatId = null;

    try {
      String contactId = context.getRequest().getParameter("contactId");
      db = this.getConnection(context);
      thisContact = new Contact(db, contactId);

      if (!(hasPermission(context, "contacts-external_contacts-folders-view")) || (thisContact.getOrgId() > 0 && !(hasPermission(context, "accounts-accounts-contacts-view")))) {
        return ("PermissionError");
      }
      if (!hasAuthority(db, context, thisContact)) {
        return ("PermissionError");
      }
      context.getRequest().setAttribute("ContactDetails", thisContact);

      //Show a list of the different folders available in Contacts
      CustomFieldCategoryList thisList = new CustomFieldCategoryList();
      thisList.setLinkModuleId(Constants.CONTACTS);
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
        selectedCatId = String.valueOf(thisList.getDefaultCategoryId());
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
          PagedListInfo folderListInfo = this.getPagedListInfo(context, "ContactFolderInfo");
          folderListInfo.setLink("ExternalContacts.do?command=Fields&contactId=" + contactId + "&catId=" + selectedCatId + HTTPUtils.addLinkParams(context.getRequest(), "popup|popupType|actionId"));

          CustomFieldRecordList recordList = new CustomFieldRecordList();
          recordList.setLinkModuleId(Constants.CONTACTS);
          recordList.setLinkItemId(thisContact.getId());
          recordList.setCategoryId(thisCategory.getId());
          recordList.buildList(db);
          recordList.buildRecordColumns(db, thisCategory);
          context.getRequest().setAttribute("Records", recordList);
        } else {
          //The user requested a specific record, or this category only
          //allows a single record.
          thisCategory.setLinkModuleId(Constants.CONTACTS);
          thisCategory.setLinkItemId(thisContact.getId());
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
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "External Contacts", "Custom Fields Details");
    if (Integer.parseInt(selectedCatId) <= 0) {
      return this.getReturn(context, "FieldsEmpty");
    } else if (recordId == null && showRecords) {
      return this.getReturn(context, "FieldRecordList");
    } else {
      return this.getReturn(context, "Fields");
    }
  }



  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since           1.2
   */
  public String executeCommandSearchContactsForm(ActionContext context) {
    if (!(hasPermission(context, "contacts-external_contacts-view"))) {
      return ("PermissionError");
    }

    Connection db = null;
    ContactTypeList contactTypeList = new ContactTypeList();
    try {
      PagedListInfo searchContactsInfo = this.getPagedListInfo(context, "SearchContactsInfo");
      db = this.getConnection(context);

      contactTypeList.setShowPersonal(true);
      contactTypeList.setIncludeDefinedByUser(this.getUserId(context));
      contactTypeList.addItem(-1, "All Contact Types");
      contactTypeList.buildList(db);
      context.getRequest().setAttribute("ContactTypeList", contactTypeList);
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Search Contacts", "Contacts Search");
    return ("SearchContactsFormOK");
  }


  /**
   *  This method retrieves the details of a single contact. The resulting
   *  Contact object is added to the request if successful.<p>
   *
   *  This method handles output for both viewing and modifying a contact.
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since           1.1
   */
  public String executeCommandContactDetails(ActionContext context) {
    String contactId = context.getRequest().getParameter("id");
    String action = context.getRequest().getParameter("cmd");
    Connection db = null;
    Contact thisContact = null;
    try {
      db = this.getConnection(context);
      thisContact = new Contact(db, contactId);
      if (!(hasPermission(context, "contacts-external_contacts-view")) || (thisContact.getOrgId() > 0 && !(hasPermission(context, "accounts-accounts-contacts-view")))) {
        return ("PermissionError");
      }
      if (!(hasAuthority(db, context, thisContact) || OpportunityHeaderList.isComponentOwner(db, getUserId(context)))) {
        return ("PermissionError");
      }
      //check whether or not the owner is an active User
      if (!thisContact.getEmployee()) {
        thisContact.checkEnabledOwnerAccount(db);
      }
      context.getRequest().setAttribute("ContactDetails", thisContact);
      addRecentItem(context, thisContact);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "External Contacts", "View Contact Details");
    context.getSession().removeAttribute("ContactMessageListInfo");
    if ("true".equals(context.getRequest().getParameter("popup"))) {
      return ("ContactDetailsPopupOK");
    }
    return ("ContactDetailsOK");
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandModifyContact(ActionContext context) {
    String contactId = context.getRequest().getParameter("id");
    Contact thisContact = null;
    Connection db = null;
    try {
      db = this.getConnection(context);
      thisContact = (Contact) context.getFormBean();
      thisContact.queryRecord(db, Integer.parseInt(contactId));
      if (!(hasPermission(context, "contacts-external_contacts-edit")) || (thisContact.getOrgId() > 0 && !(hasPermission(context, "accounts-accounts-contacts-edit")))) {
        return ("PermissionError");
      }
      if (!(hasAuthority(db, context, thisContact) || OpportunityHeaderList.isComponentOwner(db, getUserId(context)))) {
        return ("PermissionError");
      }

      //add access types
      AccessTypeList accessTypeList = null;
      if (thisContact.getOrgId() > 0) {
        accessTypeList = this.getSystemStatus(context).getAccessTypeList(db, AccessType.ACCOUNT_CONTACTS);
      } else {
        accessTypeList = this.getSystemStatus(context).getAccessTypeList(db, AccessType.GENERAL_CONTACTS);
      }
      context.getRequest().setAttribute("AccessTypeList", accessTypeList);

      //check whether or not the owner is an active User
      if (!thisContact.getEmployee()) {
        thisContact.checkEnabledOwnerAccount(db);
      }
      addRecentItem(context, thisContact);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "External Contacts", "Modify Contact Details");
    context.getSession().removeAttribute("ContactMessageListInfo");
    return executeCommandPrepare(context);
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandPrepare(ActionContext context) {
    Connection db = null;
    Contact thisContact = (Contact) context.getFormBean();
    boolean addUser = "adduser".equals(context.getRequest().getParameter("source"));
    if (thisContact.getId() == -1) {
      if (!(hasPermission(context, "contacts-external_contacts-add"))) {
        return ("PermissionError");
      }
      addModuleBean(context, "Add Contact", "Add Contact to Account");
    }
    try {
      db = this.getConnection(context);
      //prepare contact type list
      ContactTypeList contactTypeList = new ContactTypeList();
      contactTypeList.setIncludeDefinedByUser(this.getUserId(context));
      contactTypeList.setShowPersonal(true);
      contactTypeList.buildList(db);
      context.getRequest().setAttribute("ContactTypeList", contactTypeList);
      //prepare the Department List if employee is being added.
      if (addUser) {
        LookupList departmentList = new LookupList(db, "lookup_department");
        departmentList.addItem(0, "--None--");
        context.getRequest().setAttribute("DepartmentList", departmentList);
      }
      //prepare userList for reassigning owner
      UserBean thisUser = (UserBean) context.getSession().getAttribute("User");
      User thisRec = thisUser.getUserRecord();
      UserList shortChildList = thisRec.getShortChildList();
      UserList userList = thisRec.getFullChildList(shortChildList, new UserList());
      userList.setMyId(getUserId(context));
      userList.setMyValue(thisUser.getContact().getNameLastFirst());
      userList.setIncludeMe(true);
      userList.setExcludeDisabledIfUnselected(true);
      context.getRequest().setAttribute("UserList", userList);

      //add access types
      AccessTypeList accessTypeList = null;
      if (context.getRequest().getAttribute("AccessTypeList") == null) {
        if (thisContact.getOrgId() > 0) {
          accessTypeList = this.getSystemStatus(context).getAccessTypeList(db, AccessType.ACCOUNT_CONTACTS);
        } else if (addUser) {
          accessTypeList = this.getSystemStatus(context).getAccessTypeList(db, AccessType.EMPLOYEES);
        } else {
          accessTypeList = this.getSystemStatus(context).getAccessTypeList(db, AccessType.GENERAL_CONTACTS);
        }
        context.getRequest().setAttribute("AccessTypeList", accessTypeList);
      }

      //prepare organization if needed
      if (thisContact.getOrgId() > -1) {
        Organization thisOrg = new Organization(db, thisContact.getOrgId());
        thisContact.setCompany(thisOrg.getName());
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    context.getSession().removeAttribute("ContactMessageListInfo");
    return ("PrepareOK");
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandClone(ActionContext context) {
    if (!(hasPermission(context, "contacts-external_contacts-add"))) {
      return ("PermissionError");
    }
    addModuleBean(context, "Add Contact", "Clone Contact");
    Connection db = null;
    String contactId = context.getRequest().getParameter("id");
    Contact cloneContact = null;
    try {
      db = this.getConnection(context);
      cloneContact = new Contact(db, contactId);
      cloneContact.resetBaseInfo();
      context.getRequest().setAttribute("ContactDetails", cloneContact);

      //add access types
      AccessTypeList accessTypeList = null;
      if (cloneContact.getOrgId() > 0) {
        accessTypeList = this.getSystemStatus(context).getAccessTypeList(db, AccessType.ACCOUNT_CONTACTS);
      } else {
        accessTypeList = this.getSystemStatus(context).getAccessTypeList(db, AccessType.GENERAL_CONTACTS);
      }
      context.getRequest().setAttribute("AccessTypeList", accessTypeList);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return executeCommandPrepare(context);
  }


  /**
   *  Process the insert form
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since           1.1
   */
  public String executeCommandSave(ActionContext context) {
    boolean recordInserted = false;
    int resultCount = 0;
    String id = context.getRequest().getParameter("id");
    String permission = "contacts-external_contacts-add";
    Organization thisOrg = null;

    Contact thisContact = (Contact) context.getFormBean();
    thisContact.setRequestItems(context);
    thisContact.setTypeList(context.getRequest().getParameterValues("selectedList"));
    thisContact.setEnteredBy(getUserId(context));
    thisContact.setModifiedBy(getUserId(context));
    //decide on permissions based on account/general contact
    if (thisContact.getOrgId() == -1) {
      if (thisContact.getId() > 0) {
        permission = "contacts-external_contacts-edit";
      }
    } else {
      if (thisContact.getId() > 0) {
        permission = "accounts-accounts-contacts-edit";
      } else {
        permission = "accounts-accounts-contacts-add";
      }
    }

    if (!hasPermission(context, permission)) {
      return ("PermissionError");
    }

    if (context.getRequest().getParameter("primaryContact") != null) {
      if (context.getRequest().getParameter("primaryContact").equalsIgnoreCase("true")) {
        thisContact.setPrimaryContact(true);
      }
    }

    Connection db = null;
    try {
      db = this.getConnection(context);
      if (thisContact.getOrgId() > 0) {
        thisOrg = new Organization(db, thisContact.getOrgId());
        thisContact.setOrgName(thisOrg.getName());
      }
      if (thisContact.getId() > 0) {
        addModuleBean(context, "External Contacts", "Update Contact");
        Contact oldContact = new Contact(db, id);

        if (oldContact.getOrgId() == -1 && thisContact.getOrgId() > 0) {
          if (!hasPermission(context, "accounts-accounts-contacts-add")) {
            return ("PermissionError");
          }
        }
        if (!hasAuthority(db, context, oldContact)) {
          return ("PermissionError");
        }
        resultCount = thisContact.update(db);
      } else {
        addModuleBean(context, "External Contacts", "Add a new contact");
        thisContact.setOwner(getUserId(context));
        recordInserted = thisContact.insert(db);
      }
      if (recordInserted) {
        thisContact = new Contact(db, "" + thisContact.getId());
        context.getRequest().setAttribute("ContactDetails", thisContact);
        addRecentItem(context, thisContact);
      } else if (resultCount == 1) {
        //If the user is in the cache, update the contact record
        thisContact.checkUserAccount(db);
        this.updateUserContact(db, context, thisContact.getUserId());
      } else {
        context.getRequest().setAttribute("TypeList", thisContact.getTypeList());
        processErrors(context, thisContact.getErrors());
      }

      //add access types
      if ("true".equals((String) context.getRequest().getParameter("saveAndNew")) || (!recordInserted && resultCount != 1)) {
        AccessTypeList accessTypeList = null;
        if ("true".equals((String) context.getRequest().getParameter("saveAndNew")) || thisContact.getOrgId() == -1) {
          accessTypeList = this.getSystemStatus(context).getAccessTypeList(db, AccessType.GENERAL_CONTACTS);
        } else {
          accessTypeList = this.getSystemStatus(context).getAccessTypeList(db, AccessType.ACCOUNT_CONTACTS);
        }
        context.getRequest().setAttribute("AccessTypeList", accessTypeList);
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    if (recordInserted) {
      if ("true".equals((String) context.getRequest().getParameter("saveAndNew"))) {
        context.getRequest().removeAttribute("ContactDetails");
        return (executeCommandPrepare(context));
      }
      if (context.getRequest().getParameter("popup") != null) {
        return ("CloseInsertContactPopup");
      }
      return ("ContactDetailsOK");
    } else if (resultCount == 1) {
      if (context.getRequest().getParameter("return") != null && context.getRequest().getParameter("return").equals("list")) {
        return (executeCommandSearchContacts(context));
      } else {
        return ("ContactDetailsUpdateOK");
      }
    } else {
      if (thisContact.getId() > 0) {
        if (resultCount == -1) {
          return (executeCommandPrepare(context));
        }
        context.getRequest().setAttribute("Error", NOT_UPDATED_MESSAGE);
        return ("UserError");
      } else {
        processErrors(context, thisContact.getErrors());
        context.getRequest().setAttribute("TypeList", thisContact.getTypeList());
        return (executeCommandPrepare(context));
      }
    }
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since           1.1
   */
  public String executeCommandDeleteContact(ActionContext context) {
    boolean recordDeleted = false;
    Contact thisContact = null;
    Connection db = null;
    try {
      db = this.getConnection(context);
      thisContact = new Contact(db, context.getRequest().getParameter("id"));
      if (!(hasPermission(context, "contacts-external_contacts-delete")) || (thisContact.getOrgId() > 0 && !(hasPermission(context, "accounts-accounts-contacts-delete")))) {
        return ("PermissionError");
      }
      if (!hasAuthority(db, context, thisContact)) {
        return ("PermissionError");
      }
      recordDeleted = thisContact.delete(db);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "External Contacts", "Delete a contact");
    if (recordDeleted) {
      context.getSession().removeAttribute("ContactMessageListInfo");
      context.getRequest().setAttribute("refreshUrl", "ExternalContacts.do?command=SearchContacts");
      deleteRecentItem(context, thisContact);
      return ("ContactDeleteOK");
    } else {
      processErrors(context, thisContact.getErrors());
      return (executeCommandSearchContacts(context));
    }
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandModifyFields(ActionContext context) {
    Connection db = null;
    Contact thisContact = null;

    String selectedCatId = (String) context.getRequest().getParameter("catId");
    String recordId = (String) context.getRequest().getParameter("recId");

    try {
      String contactId = context.getRequest().getParameter("contactId");
      db = this.getConnection(context);
      thisContact = new Contact(db, contactId);
      if (!(hasPermission(context, "contacts-external_contacts-folders-edit")) || (thisContact.getOrgId() > 0 && !(hasPermission(context, "accounts-accounts-contacts-edit")))) {
        return ("PermissionError");
      }
      if (!hasAuthority(db, context, thisContact)) {
        return ("PermissionError");
      }

      context.getRequest().setAttribute("ContactDetails", thisContact);

      CustomFieldCategory thisCategory = new CustomFieldCategory(db,
          Integer.parseInt(selectedCatId));
      thisCategory.setLinkModuleId(Constants.CONTACTS);
      thisCategory.setLinkItemId(thisContact.getId());
      thisCategory.setRecordId(Integer.parseInt(recordId));
      thisCategory.setIncludeEnabled(Constants.TRUE);
      thisCategory.setIncludeScheduled(Constants.TRUE);
      thisCategory.setBuildResources(true);
      thisCategory.buildResources(db);
      context.getRequest().setAttribute("Category", thisCategory);

    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "External Contacts", "Modify Custom Fields");
    if (recordId.equals("-1")) {
      return this.getReturn(context, "AddFolderRecord");
    } else {
      return this.getReturn(context, "ModifyFields");
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
    Connection db = null;
    Contact thisContact = null;
    int resultCount = 0;

    try {
      String contactId = context.getRequest().getParameter("contactId");
      db = this.getConnection(context);
      thisContact = new Contact(db, contactId);
      if (!(hasPermission(context, "contacts-external_contacts-folders-edit")) || (thisContact.getOrgId() > 0 && !(hasPermission(context, "accounts-accounts-contacts-edit")))) {
        return ("PermissionError");
      }
      if (!hasAuthority(db, context, thisContact)) {
        return ("PermissionError");
      }
      context.getRequest().setAttribute("ContactDetails", thisContact);

      CustomFieldCategoryList thisList = new CustomFieldCategoryList();
      thisList.setLinkModuleId(Constants.CONTACTS);
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
      thisCategory.setLinkModuleId(Constants.CONTACTS);
      thisCategory.setLinkItemId(thisContact.getId());
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
          System.out.println("Contacts-> ModifyField validation error");
        }
      } else {
        thisCategory.buildResources(db);
        CustomFieldRecord thisRecord = new CustomFieldRecord(db, thisCategory.getRecordId());
        context.getRequest().setAttribute("Record", thisRecord);
      }
      context.getRequest().setAttribute("Category", thisCategory);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    if (resultCount == -1) {
      return this.getReturn(context, "ModifyFields");
    } else if (resultCount == 1) {
      return this.getReturn(context, "UpdateFields");
    } else {
      context.getRequest().setAttribute("Error", NOT_UPDATED_MESSAGE);
      return ("UserError");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandInsertFields(ActionContext context) {
    Connection db = null;
    int resultCode = -1;
    Contact thisContact = null;

    try {
      String contactId = context.getRequest().getParameter("contactId");
      db = this.getConnection(context);
      thisContact = new Contact(db, contactId);
      if (!(hasPermission(context, "contacts-external_contacts-folders-add")) || (thisContact.getOrgId() > 0 && !(hasPermission(context, "accounts-accounts-contacts-edit")))) {
        return ("PermissionError");
      }
      context.getRequest().setAttribute("ContactDetails", thisContact);

      CustomFieldCategoryList thisList = new CustomFieldCategoryList();
      thisList.setLinkModuleId(Constants.CONTACTS);
      thisList.setIncludeEnabled(Constants.TRUE);
      thisList.setIncludeScheduled(Constants.TRUE);
      thisList.setBuildResources(false);
      thisList.buildList(db);
      context.getRequest().setAttribute("CategoryList", thisList);

      String selectedCatId = (String) context.getRequest().getParameter("catId");
      context.getRequest().setAttribute("catId", selectedCatId);
      CustomFieldCategory thisCategory = new CustomFieldCategory(db,
          Integer.parseInt(selectedCatId));
      thisCategory.setLinkModuleId(Constants.CONTACTS);
      thisCategory.setLinkItemId(thisContact.getId());
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
          System.out.println("Contacts-> InsertField validation error");
        }
      }
      context.getRequest().setAttribute("Category", thisCategory);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    if (resultCode == -1) {
      return this.getReturn(context, "AddFolderRecord");
    } else {
      return (this.executeCommandFields(context));
    }
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandDeleteFields(ActionContext context) {
    Connection db = null;
    boolean recordDeleted = false;
    try {
      db = this.getConnection(context);
      String selectedCatId = context.getRequest().getParameter("catId");
      String recordId = context.getRequest().getParameter("recId");
      String contactId = context.getRequest().getParameter("contactId");

      Contact thisContact = new Contact(db, Integer.parseInt(contactId));
      if (!(hasPermission(context, "contacts-external_contacts-folders-delete")) || (thisContact.getOrgId() > 0 && !(hasPermission(context, "accounts-accounts-contacts-edit")))) {
        return ("PermissionError");
      }

      CustomFieldCategory thisCategory = new CustomFieldCategory(db,
          Integer.parseInt(selectedCatId));

      CustomFieldRecord thisRecord = new CustomFieldRecord(db, Integer.parseInt(recordId));
      thisRecord.setLinkModuleId(Constants.CONTACTS);
      thisRecord.setLinkItemId(Integer.parseInt(contactId));
      thisRecord.setCategoryId(Integer.parseInt(selectedCatId));
      if (!thisCategory.getReadOnly()) {
        recordDeleted = thisRecord.delete(db);
      }
      context.getRequest().setAttribute("recordDeleted", "true");
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return ("DeleteFieldsOK");
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandConfirmDelete(ActionContext context) {
    Connection db = null;
    Contact thisContact = null;
    HtmlDialog htmlDialog = new HtmlDialog();
    String id = null;

    if (context.getRequest().getParameter("id") != null) {
      id = context.getRequest().getParameter("id");
    }

    try {
      db = this.getConnection(context);
      thisContact = new Contact(db, id);
      if (!(hasPermission(context, "contacts-external_contacts-delete")) || (thisContact.getOrgId() > 0 && !(hasPermission(context, "accounts-accounts-contacts-edit")))) {
        return ("PermissionError");
      }
      if (!hasAuthority(db, context, thisContact)) {
        return ("PermissionError");
      }
      thisContact.checkUserAccount(db);
      DependencyList dependencies = thisContact.processDependencies(db);
      htmlDialog.addMessage(dependencies.getHtmlString());

      if (!thisContact.hasAccount()) {
        if (thisContact.getPrimaryContact()) {
          htmlDialog.setHeader("This contact cannot be deleted because it is also an individual account.");
          htmlDialog.addButton("OK", "javascript:parent.window.close()");
        } else if (thisContact.getHasOpportunities()) {
          htmlDialog.setHeader("Please reassign or delete any opportunities associated with this contact first.");
          htmlDialog.addButton("OK", "javascript:parent.window.close()");
        } else {
          if (dependencies.canDelete()) {
            htmlDialog.setTitle("Dark Horse CRM: Confirm Delete");
            htmlDialog.setHeader("The contact you are requesting to delete has the following dependencies within Dark Horse CRM:");
            htmlDialog.addButton("Delete All", "javascript:window.location.href='ExternalContacts.do?command=DeleteContact&id=" + id + "'");
            htmlDialog.addButton("Cancel", "javascript:parent.window.close()");
          } else {
            htmlDialog.setTitle("Dark Horse CRM: Alert");
            htmlDialog.setHeader("This contact cannot be deleted because it has the following dependencies within Dark Horse CRM:");
            htmlDialog.addButton("OK", "javascript:parent.window.close()");
          }
        }
      } else {
        htmlDialog.setHeader("This contact cannot be deleted because it is associated with a User account.");
        htmlDialog.addButton("OK", "javascript:parent.window.close()");
      }
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    context.getSession().setAttribute("Dialog", htmlDialog);
    return ("ConfirmDeleteOK");
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandPopupSelector(ActionContext context) {
    if (!(hasPermission(context, "contacts-external_contacts-view"))) {
      return ("PermissionError");
    }
    Connection db = null;
    boolean listDone = false;
    String displayFieldId = null;
    ContactTypeList contactTypeList = null;

    if ("true".equals(context.getRequest().getParameter("reset"))) {
      context.getSession().removeAttribute("ContactTypeSelectorInfo");
    }
    PagedListInfo lookupSelectorInfo = this.getPagedListInfo(context, "ContactTypeSelectorInfo");

    HashMap selectedList = new HashMap();
    HashMap finalElementList = (HashMap) context.getSession().getAttribute("finalElements");

    String category = context.getRequest().getParameter("category");
    String contactId = context.getRequest().getParameter("contactId");
    String previousSelection = context.getRequest().getParameter("previousSelection");
    String previousSelectionDisplay = context.getRequest().getParameter("previousSelectionDisplay");

    if (previousSelection != null) {
      int j = 0;
      StringTokenizer st = new StringTokenizer(previousSelection, "|");
      StringTokenizer st1 = new StringTokenizer(previousSelectionDisplay, "|");
      while (st.hasMoreTokens()) {
        selectedList.put(new Integer(st.nextToken()), st1.nextToken());
        j++;
      }
    } else {
      //get selected list from the session
      selectedList = (HashMap) context.getSession().getAttribute("selectedElements");
    }

    if (context.getRequest().getParameter("displayFieldId") != null) {
      displayFieldId = context.getRequest().getParameter("displayFieldId");
    }

    //Flush the selectedList if its a new selection
    if ("true".equals(context.getRequest().getParameter("reset"))) {
      if (context.getSession().getAttribute("finalElements") != null && context.getRequest().getParameter("previousSelection") == null) {
        selectedList = (HashMap) ((HashMap) context.getSession().getAttribute("finalElements")).clone();
      }
    }

    int rowCount = 1;

    while (context.getRequest().getParameter("hiddenelementid" + rowCount) != null) {
      int elementId = 0;
      String elementValue = "";
      elementId = Integer.parseInt(context.getRequest().getParameter("hiddenelementid" + rowCount));

      if (context.getRequest().getParameter("checkelement" + rowCount) != null) {
        if (context.getRequest().getParameter("elementvalue" + rowCount) != null) {
          elementValue = context.getRequest().getParameter("elementvalue" + rowCount);
        }

        if (selectedList.get(new Integer(elementId)) == null) {
          selectedList.put(new Integer(elementId), elementValue);
        } else {
          selectedList.remove(new Integer(elementId));
          selectedList.put(new Integer(elementId), elementValue);
        }
      } else {
        selectedList.remove(new Integer(elementId));
      }
      rowCount++;
    }

    if ("true".equals(context.getRequest().getParameter("finalsubmit"))) {
      finalElementList = (HashMap) selectedList;
      context.getSession().setAttribute("finalElements", finalElementList);
    }

    try {
      db = this.getConnection(context);
      contactTypeList = new ContactTypeList();
      contactTypeList.setPagedListInfo(lookupSelectorInfo);
      contactTypeList.setShowPersonal(true);
      contactTypeList.setShowDisabled(false);
      contactTypeList.setIncludeDefinedByUser(this.getUserId(context));
      contactTypeList.setIncludeSelectedByUser(Integer.parseInt(contactId));
      if (previousSelection != null) {
        contactTypeList.setIncludeIds(previousSelection.replace('|', ','));
      }
      if ("accounts".equals(category)) {
        contactTypeList.setCategory(ContactType.ACCOUNT);
      } else {
        contactTypeList.setCategory(ContactType.GENERAL);
      }
      contactTypeList.buildList(db);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      context.getRequest().setAttribute("ContactTypeList", contactTypeList);
      this.freeConnection(context, db);
    }
    context.getSession().setAttribute("selectedElements", selectedList);
    context.getRequest().setAttribute("DisplayFieldId", displayFieldId);
    return ("PopupContactTypeOK");
  }


  /**
   *  Returns an access type list for repopulating a html select
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandAccessTypeJSList(ActionContext context) {
    String category = context.getRequest().getParameter("category");
    Connection db = null;
    try {
      db = getConnection(context);
      //get the access type list
      AccessTypeList accessTypeList = this.getSystemStatus(context).getAccessTypeList(db, Integer.parseInt(category));
      context.getRequest().setAttribute("AccessTypeList", accessTypeList);
    } catch (Exception errorMessage) {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return this.getReturn(context, "AccessTypeJSList");
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   */
  private void resetPagedListInfo(ActionContext context) {
    this.deletePagedListInfo(context, "ExternalOppsPagedListInfo");
    this.deletePagedListInfo(context, "CallListInfo");
    this.deletePagedListInfo(context, "ContactMessageListInfo");
  }
}


