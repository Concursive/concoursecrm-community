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
package org.aspcfs.modules.accounts.actions;

import com.darkhorseventures.framework.actions.ActionContext;
import org.aspcfs.modules.accounts.base.Organization;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.base.*;
import org.aspcfs.modules.troubletickets.base.Ticket;
import org.aspcfs.utils.web.PagedListInfo;

import java.sql.Connection;
import java.util.Iterator;

/**
 * Actions for Account Ticket Folders
 *
 * @author matt rajkowski
 * @version $Id: AccountTicketFolders.java,v 1.3.12.1 2004/11/12 19:55:24
 *          mrajkowski Exp $
 * @created December 15, 2003
 */
public final class AccountTicketFolders extends CFSModule {

  /**
   * Fields: Shows a list of custom field records that are located "within" the
   * selected Custom Folder. Also shows the details of a particular Custom
   * Field Record when it is selected (details page)
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandFields(ActionContext context) {
    if (!hasPermission(context, "tickets-tickets-view")) {
      return ("PermissionError");
    }
    Connection db = null;
    Ticket thisTicket = null;
    String recordId = null;
    boolean showRecords = true;
    String selectedCatId = null;
    try {
      String ticketId = context.getRequest().getParameter("ticketId");
      db = this.getConnection(context);
      //Load the ticket
      thisTicket = new Ticket(db, Integer.parseInt(ticketId));
      //Check access permission to organization record
      if (!isRecordAccessPermitted(context, db, thisTicket.getOrgId())) {
        return ("PermissionError");
      }
      context.getRequest().setAttribute("TicketDetails", thisTicket);
      //Load the organization
      Organization thisOrganization = new Organization(
          db, thisTicket.getOrgId());
      context.getRequest().setAttribute("OrgDetails", thisOrganization);
      //Show a list of the different folders available in this module
      CustomFieldCategoryList thisList = new CustomFieldCategoryList();
      thisList.setLinkModuleId(Constants.FOLDERS_TICKETS);
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
              context, "AccountTicketsFolderInfo");
          folderListInfo.setLink(
              "TroubleTicketsFolders.do?command=Fields&ticketId=" + ticketId + "&catId=" + selectedCatId);

          CustomFieldRecordList recordList = new CustomFieldRecordList();
          recordList.setLinkModuleId(Constants.FOLDERS_TICKETS);
          recordList.setLinkItemId(thisTicket.getId());
          recordList.setCategoryId(thisCategory.getId());
          recordList.buildList(db);
          recordList.buildRecordColumns(db, thisCategory);
          context.getRequest().setAttribute("Records", recordList);
        } else {
          //The user requested a specific record, or this category only
          //allows a single record.
          thisCategory.setLinkModuleId(Constants.FOLDERS_TICKETS);
          thisCategory.setLinkItemId(thisTicket.getId());
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
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "View Accounts", "Custom Fields Details");
    if (Integer.parseInt(selectedCatId) <= 0) {
      return getReturn(context, "FieldsEmpty");
    } else if (recordId == null && showRecords) {
      return getReturn(context,"FieldRecordList");
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
  public String executeCommandFolderList(ActionContext context) {
    if (!(hasPermission(context, "tickets-tickets-view"))) {
      return ("PermissionError");
    }
    Connection db = null;
    Ticket thisTicket = null;
    try {
      String ticketId = context.getRequest().getParameter("ticketId");
      db = this.getConnection(context);
      //Load the ticket
      thisTicket = new Ticket(db, Integer.parseInt(ticketId));
      //Check access permission to organization record
      if (!isRecordAccessPermitted(context, db, thisTicket.getOrgId())) {
        return ("PermissionError");
      }
      context.getRequest().setAttribute("ticketDetails", thisTicket);
      //Load the organization
      Organization thisOrganization = new Organization(
          db, thisTicket.getOrgId());
      context.getRequest().setAttribute("orgDetails", thisOrganization);

      //Show a list of the different folders available in Accounts
      CustomFieldCategoryList thisList = new CustomFieldCategoryList();
      thisList.setLinkModuleId(Constants.FOLDERS_TICKETS);
      thisList.setLinkItemId(thisTicket.getId());
      thisList.setIncludeEnabled(Constants.TRUE);
      thisList.setIncludeScheduled(Constants.TRUE);
      thisList.setBuildResources(false);
      thisList.setBuildTotalNumOfRecords(true);
      thisList.buildList(db);
      context.getRequest().setAttribute("categoryList", thisList);
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "View Tickets", "Custom Folder List");
    return getReturn(context, "FolderList");
  }


  /**
   * AddFolderRecord: Displays the form for inserting a new custom field record
   * for the selected Account.
   *
   * @param context Description of Parameter
   * @return Description of the Returned Value
   */
  public String executeCommandAddFolderRecord(ActionContext context) {
    if (!(hasPermission(context, "tickets-tickets-view"))) {
      return ("PermissionError");
    }
    Connection db = null;
    Ticket thisTicket = null;
    try {
      String ticketId = context.getRequest().getParameter("ticketId");
      db = this.getConnection(context);
      //Load the ticket
      thisTicket = new Ticket(db, Integer.parseInt(ticketId));
      //Check access permission to organization record
      if (!isRecordAccessPermitted(context, db, thisTicket.getOrgId())) {
        return ("PermissionError");
      }
      context.getRequest().setAttribute("TicketDetails", thisTicket);
      //Load the organization
      Organization thisOrganization = new Organization(
          db, thisTicket.getOrgId());
      context.getRequest().setAttribute("OrgDetails", thisOrganization);

      String selectedCatId = (String) context.getRequest().getParameter(
          "catId");
      CustomFieldCategory thisCategory = new CustomFieldCategory(
          db,
          Integer.parseInt(selectedCatId));
      thisCategory.setLinkModuleId(Constants.FOLDERS_TICKETS);
      thisCategory.setLinkItemId(thisTicket.getId());
      thisCategory.setIncludeEnabled(Constants.TRUE);
      thisCategory.setIncludeScheduled(Constants.TRUE);
      thisCategory.setBuildResources(true);
      thisCategory.buildResources(db);
      context.getRequest().setAttribute("Category", thisCategory);
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
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
    if (!(hasPermission(context, "tickets-tickets-view"))) {
      return ("PermissionError");
    }
    Connection db = null;
    Ticket thisTicket = null;

    String selectedCatId = (String) context.getRequest().getParameter("catId");
    String recordId = (String) context.getRequest().getParameter("recId");

    try {
      String ticketId = context.getRequest().getParameter("ticketId");
      db = this.getConnection(context);
      //Load the ticket
      thisTicket = new Ticket(db, Integer.parseInt(ticketId));
      //Check access permission to organization record
      if (!isRecordAccessPermitted(context, db, thisTicket.getOrgId())) {
        return ("PermissionError");
      }
      context.getRequest().setAttribute("TicketDetails", thisTicket);
      //Load the organization
      Organization thisOrganization = new Organization(
          db, thisTicket.getOrgId());
      context.getRequest().setAttribute("OrgDetails", thisOrganization);

      CustomFieldCategory thisCategory = new CustomFieldCategory(
          db,
          Integer.parseInt(selectedCatId));
      thisCategory.setLinkModuleId(Constants.FOLDERS_TICKETS);
      thisCategory.setLinkItemId(thisTicket.getId());
      thisCategory.setRecordId(Integer.parseInt(recordId));
      thisCategory.setIncludeEnabled(Constants.TRUE);
      thisCategory.setIncludeScheduled(Constants.TRUE);
      thisCategory.setBuildResources(true);
      thisCategory.buildResources(db);
      context.getRequest().setAttribute("Category", thisCategory);
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
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
    if (!(hasPermission(context, "tickets-tickets-view"))) {
      return ("PermissionError");
    }
    Connection db = null;
    Ticket thisTicket = null;
    int resultCount = 0;
    boolean isValid = false;
    try {
      String ticketId = context.getRequest().getParameter("ticketId");
      db = this.getConnection(context);
      //Load the ticket
      thisTicket = new Ticket(db, Integer.parseInt(ticketId));
      //Check access permission to organization record
      if (!isRecordAccessPermitted(context, db, thisTicket.getOrgId())) {
        return ("PermissionError");
      }
      context.getRequest().setAttribute("TicketDetails", thisTicket);
      //Load the organization
      Organization thisOrganization = new Organization(
          db, thisTicket.getOrgId());
      context.getRequest().setAttribute("OrgDetails", thisOrganization);

      CustomFieldCategoryList thisList = new CustomFieldCategoryList();
      thisList.setLinkModuleId(Constants.FOLDERS_TICKETS);
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
      thisCategory.setLinkModuleId(Constants.FOLDERS_TICKETS);
      thisCategory.setLinkItemId(thisTicket.getId());
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
      if (resultCount == -1 || !isValid) {
        if (System.getProperty("DEBUG") != null) {
          System.out.println(
              "TroubleTicketsFolders-> ModifyField validation error");
        }
        context.getRequest().setAttribute(
            "systemStatus", this.getSystemStatus(context));
        return ("ModifyFieldsOK");
      } else {
        thisCategory.buildResources(db);
        CustomFieldRecord thisRecord = new CustomFieldRecord(
            db, thisCategory.getRecordId());
        context.getRequest().setAttribute("Record", thisRecord);
      }
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    if (resultCount == 1 && isValid) {
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
    if (!(hasPermission(context, "tickets-tickets-view"))) {
      return ("PermissionError");
    }
    Connection db = null;
    int resultCode = -1;
    Ticket thisTicket = null;
    boolean isValid = false;
    try {
      String ticketId = context.getRequest().getParameter("ticketId");
      db = this.getConnection(context);
      //Load the ticket
      thisTicket = new Ticket(db, Integer.parseInt(ticketId));
      //Check access permission to organization record
      if (!isRecordAccessPermitted(context, db, thisTicket.getOrgId())) {
        return ("PermissionError");
      }
      context.getRequest().setAttribute("TicketDetails", thisTicket);
      //Load the organization
      Organization thisOrganization = new Organization(
          db, thisTicket.getOrgId());
      context.getRequest().setAttribute("OrgDetails", thisOrganization);

      CustomFieldCategoryList thisList = new CustomFieldCategoryList();
      thisList.setLinkModuleId(Constants.FOLDERS_TICKETS);
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
      thisCategory.setLinkModuleId(Constants.FOLDERS_TICKETS);
      thisCategory.setLinkItemId(thisTicket.getId());
      thisCategory.setIncludeEnabled(Constants.TRUE);
      thisCategory.setIncludeScheduled(Constants.TRUE);
      thisCategory.setBuildResources(true);
      thisCategory.buildResources(db);
      thisCategory.setParameters(context);
      thisCategory.setEnteredBy(this.getUserId(context));
      thisCategory.setModifiedBy(this.getUserId(context));
      if (!thisCategory.getReadOnly()) {
        thisCategory.setCanNotContinue(true);
        resultCode = thisCategory.insert(db);
        Iterator groups = (Iterator) thisCategory.iterator();
        isValid = true;
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
        thisCategory.setCanNotContinue(false);
        if (isValid && resultCode != -1) {
          resultCode = thisCategory.insertGroup(
              db, thisCategory.getRecordId());
        }
      }
      context.getRequest().setAttribute("Category", thisCategory);
      if (resultCode == -1 || !isValid) {
        if (thisCategory.getRecordId() != -1) {
          CustomFieldRecord record = new CustomFieldRecord(
              db, thisCategory.getRecordId());
          record.delete(db);
        }
        if (System.getProperty("DEBUG") != null) {
          System.out.println(
              "TroubleTicketsFolders-> InsertField validation error");
        }
        context.getRequest().setAttribute(
            "systemStatus", this.getSystemStatus(context));
        return getReturn(context, "AddFolderRecord");
      } else {
        processInsertHook(context, thisCategory);
      }
    } catch (Exception e) {
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
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
    if (!(hasPermission(context, "tickets-tickets-view"))) {
      return ("PermissionError");
    }
    Connection db = null;
    boolean recordDeleted = false;
    try {
      String selectedCatId = context.getRequest().getParameter("catId");
      String recordId = context.getRequest().getParameter("recId");
      String ticketId = context.getRequest().getParameter("ticketId");
      db = this.getConnection(context);
      //Load the ticket
      Ticket thisTicket = new Ticket(db, Integer.parseInt(ticketId));
      //Check access permission to organization record
      if (!isRecordAccessPermitted(context, db, thisTicket.getOrgId())) {
        return ("PermissionError");
      }
      CustomFieldCategory thisCategory = new CustomFieldCategory(
          db,
          Integer.parseInt(selectedCatId));
      CustomFieldRecord thisRecord = new CustomFieldRecord(
          db, Integer.parseInt(recordId));
      thisRecord.setLinkModuleId(Constants.FOLDERS_TICKETS);
      thisRecord.setLinkItemId(Integer.parseInt(ticketId));
      thisRecord.setCategoryId(Integer.parseInt(selectedCatId));
      if (!thisCategory.getReadOnly()) {
        recordDeleted = thisRecord.delete(db);
      }
      context.getRequest().setAttribute("recordDeleted", "true");
    } catch (Exception e) {
      addModuleBean(context, "View Accounts", "Delete Folder Record");
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return ("DeleteFieldsOK");
  }
}

