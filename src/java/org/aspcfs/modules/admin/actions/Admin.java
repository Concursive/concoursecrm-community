package org.aspcfs.modules.admin.actions;

import javax.servlet.*;
import javax.servlet.http.*;
import java.sql.*;
import java.util.Vector;
import java.util.*;
import com.darkhorseventures.framework.actions.*;
import com.darkhorseventures.framework.servlets.*;
import com.darkhorseventures.database.Connection;
import org.aspcfs.modules.admin.base.*;
import org.aspcfs.modules.contacts.base.*;
import org.aspcfs.modules.utils.*;
import org.aspcfs.modules.utils.web.*;
import com.zeroio.iteam.base.*;
import java.text.*;

/**
 *  Administrative commands executor.
 *
 *@author     chris
 *@created    January 7, 2002
 *@version    $Id$
 */
public final class Admin extends CFSModule {

  /**
   *  Default action, calls home action.
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandDefault(ActionContext context) {
    if (!(hasPermission(context, "admin-view"))) {
      return ("PermissionError");
    }
    return executeCommandHome(context);
  }


  /**
   *  Home.
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandHome(ActionContext context) {
    if (!(hasPermission(context, "admin-view"))) {
      return ("PermissionError");
    }
    addModuleBean(context, "Admin", "Admin");
    return ("HomeOK");
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandManage(ActionContext context) {
    if (!(hasPermission(context, "admin-sysconfig-view"))) {
      return ("PermissionError");
    }
    addModuleBean(context, "Configuration", "Management");
    return "ManagementOK";
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandUsage(ActionContext context) {
    if (!hasPermission(context, "admin-sysconfig-view")) {
      return ("PermissionError");
    }
    addModuleBean(context, "Configuration", "Usage");
    Connection db = null;
    Exception errorMessage = null;
    ArrayList usageList = new ArrayList();
    ArrayList usageList2 = new ArrayList();
    String rangeSelect = context.getRequest().getParameter("rangeSelect");
    java.sql.Date dateStart = null;
    String dateStartParam = context.getRequest().getParameter("dateStart");
    if (dateStartParam != null) {
      dateStart = DatabaseUtils.parseDate(dateStartParam);
      if (dateStart != null) {
        rangeSelect = "custom";
      }
    }
    java.sql.Date dateEnd = null;
    String dateEndParam = context.getRequest().getParameter("dateEnd");
    if (dateEndParam != null) {
      dateEnd = DatabaseUtils.parseDate(dateEndParam);
      if (dateEnd != null) {
        rangeSelect = "custom";
      }
    }
    context.getRequest().setAttribute("rangeSelect", rangeSelect);
    try {
      Calendar cal = Calendar.getInstance();
      //Date Start Range
      if (dateStart != null) {
        cal.setTimeInMillis(dateStart.getTime());
      }
      cal.set(Calendar.HOUR_OF_DAY, 0);
      cal.set(Calendar.MINUTE, 0);
      cal.set(Calendar.SECOND, 0);
      cal.set(Calendar.MILLISECOND, 0);
      long startRange = cal.getTimeInMillis();
      context.getRequest().setAttribute("dateStart", new java.sql.Date(cal.getTimeInMillis()));
      //Date End Range
      if (dateStart != null && dateEnd != null && dateEnd.after(dateStart)) {
        cal.setTimeInMillis(dateEnd.getTime());
      }
      cal.set(Calendar.HOUR_OF_DAY, 23);
      cal.set(Calendar.MINUTE, 59);
      cal.set(Calendar.SECOND, 59);
      cal.set(Calendar.MILLISECOND, 999);
      long endRange = cal.getTimeInMillis();
      context.getRequest().setAttribute("dateEnd", new java.sql.Date(cal.getTimeInMillis()));

      NumberFormat nf = NumberFormat.getInstance();
      db = this.getConnection(context);

      //Users enabled as of date range
      UserList userList = new UserList();
      userList.setEnabled(Constants.TRUE);
      int userListCount = userList.queryRecordCount(db);
      usageList.add(nf.format(userListCount) + " user" + StringUtils.addS(userListCount) + " enabled");

      //File count: x size: x
      FileItemVersionList fileList = new FileItemVersionList();
      int fileCount = fileList.queryRecordCount(db);
      long fileSize = fileList.queryFileSize(db);
      usageList.add(nf.format(fileCount) + " file" + StringUtils.addS(fileCount) + " stored in document library using " + nf.format(fileSize) + " byte" + StringUtils.addS(fileSize) + " of storage");

      //Logins
      AccessLogList accessLog = new AccessLogList();
      accessLog.setEnteredRangeStart(new java.sql.Timestamp(startRange));
      accessLog.setEnteredRangeEnd(new java.sql.Timestamp(endRange));
      int logins = accessLog.queryRecordCount(db);
      usageList2.add(nf.format(logins) + " login" + StringUtils.addS(logins));

      //Prepare to get usage for several different actions
      UsageList usage = new UsageList();
      usage.setEnteredRangeStart(new java.sql.Timestamp(startRange));
      usage.setEnteredRangeEnd(new java.sql.Timestamp(endRange));

      //Upstream bw: x, the specific files uploaded on date x size
      usage.setAction(Constants.USAGE_FILE_UPLOAD);
      usage.buildUsage(db);
      long fileUploadCount = usage.getCount();
      long fileUploadSize = usage.getSize();
      usageList2.add(nf.format(fileUploadCount) + " file" + StringUtils.addS(fileUploadCount) + " uploaded, using " + nf.format(fileUploadSize) + " byte" + StringUtils.addS(fileUploadSize) + " of bandwidth");

      //Downstream bw: x
      usage.setAction(Constants.USAGE_FILE_DOWNLOAD);
      usage.buildUsage(db);
      long fileDownloadCount = usage.getCount();
      long fileDownloadSize = usage.getSize();
      usageList2.add(nf.format(fileDownloadCount) + " file" + StringUtils.addS(fileDownloadCount) + " downloaded, using " + nf.format(fileDownloadSize) + " byte" + StringUtils.addS(fileDownloadSize) + " of bandwidth");

      //Communications Manager emails
      usage.setAction(Constants.USAGE_COMMUNICATIONS_EMAIL);
      usage.buildUsage(db);
      long emailRecipientCount = usage.getCount();
      long emailSize = usage.getSize();
      usageList2.add(nf.format(emailRecipientCount) + " email" + StringUtils.addS(emailRecipientCount) + " sent, consisting of " + nf.format(emailSize) + " byte" + StringUtils.addS(emailSize));

      //Communications Manager faxes
      usage.setAction(Constants.USAGE_COMMUNICATIONS_FAX);
      usage.buildUsage(db);
      long faxRecipientCount = usage.getCount();
      long faxSize = usage.getSize();
      usageList2.add(nf.format(faxRecipientCount) + " fax" + StringUtils.addES(faxRecipientCount) + " sent, consisting of  " + nf.format(faxSize) + " byte" + StringUtils.addS(faxSize));

      context.getRequest().setAttribute("usageList", usageList);
      context.getRequest().setAttribute("usageList2", usageList2);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    return "UsageOK";
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandConfig(ActionContext context) {

    if (!(hasPermission(context, "admin-sysconfig-view"))) {
      return ("PermissionError");
    }

    Exception errorMessage = null;
    addModuleBean(context, "Configuration", "Configuration");
    Connection db = null;
    PermissionCategoryList thisPermCatList = new PermissionCategoryList();

    try {
      db = this.getConnection(context);
      thisPermCatList.setEnabledState(1);
      thisPermCatList.setCustomizableModulesOnly(true);
      thisPermCatList.buildList(db);
      context.getRequest().setAttribute("PermissionCategoryList", thisPermCatList);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorMessage == null) {
      return ("ConfigurationOK");
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
  public String executeCommandConfigDetails(ActionContext context) {

    if (!(hasPermission(context, "admin-sysconfig-view"))) {
      return ("PermissionError");
    }

    Exception errorMessage = null;
    addModuleBean(context, "Configuration", "Configuration");
    Connection db = null;
    String moduleId = context.getRequest().getParameter("moduleId");

    try {
      db = this.getConnection(context);
      PermissionCategory permCat = new PermissionCategory(db, Integer.parseInt(moduleId));
      context.getRequest().setAttribute("PermissionCategory", permCat);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorMessage == null) {
      return ("ConfigDetailsOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }

  }


  /**
   *  Take an initial look at all of the configurable lists within CFS
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandEditLists(ActionContext context) {

    if (!(hasPermission(context, "admin-sysconfig-lists-view"))) {
      return ("PermissionError");
    }

    Exception errorMessage = null;
    Connection db = null;
    PermissionCategory permCat = null;
    String moduleId = context.getRequest().getParameter("moduleId");

    try {
      db = this.getConnection(context);
      permCat = new PermissionCategory(db, Integer.parseInt(moduleId));
      buildFormElements(context, db);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    context.getRequest().setAttribute("PermissionCategory", permCat);
    addModuleBean(context, "Configuration", "Configuration");
    if (errorMessage == null) {
      return ("EditListsOK");
    }
    context.getRequest().setAttribute("Error", errorMessage);
    return "SystemError";
  }


  /**
   *  Update a particular list with the new values
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandUpdateList(ActionContext context) {
    if (!(hasPermission(context, "admin-sysconfig-lists-edit"))) {
      return ("PermissionError");
    }

    Exception errorMessage = null;
    Connection db = null;
    String tblName = context.getRequest().getParameter("tableName");

    if ("lookup_contact_types".equals(tblName)) {
      return executeCommandUpdateContactList(context);
    }
    String[] params = context.getRequest().getParameterValues("selectedList");
    String[] names = new String[params.length];
    int j = 0;

    StringTokenizer st = new StringTokenizer(context.getRequest().getParameter("selectNames"), "^");

    while (st.hasMoreTokens()) {
      names[j] = (String) st.nextToken();
      j++;
    }

    try {
      db = this.getConnection(context);

      //begin for all lookup lists
      LookupList compareList = new LookupList(db, tblName);
      LookupList newList = new LookupList(params, names);

      Iterator i = compareList.iterator();
      while (i.hasNext()) {
        LookupElement thisElement = (LookupElement) i.next();

        //still there, stay enabled, don't re-insert it
        if (System.getProperty("DEBUG") != null) {
          System.out.println("Here: " + thisElement.getCode() + " " + newList.getSelectedValue(thisElement.getCode()));
        }

        //not there, disable it, leave it
        if (newList.getSelectedValue(thisElement.getCode()).equals("") ||
            newList.getSelectedValue(thisElement.getCode()) == null) {
          thisElement.disableElement(db, tblName);
        }
      }

      Iterator k = newList.iterator();
      while (k.hasNext()) {
        LookupElement thisElement = (LookupElement) k.next();

        if (thisElement.getCode() == 0) {
          thisElement.insertElement(db, tblName);
        } else {
          thisElement.setNewOrder(db, tblName);
        }

      }
      //end
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    context.getRequest().setAttribute("moduleId", context.getRequest().getParameter("module"));
    addModuleBean(context, "Configuration", "Configuration");
    return (executeCommandEditLists(context));
  }


  /**
   *  Updates the Contact Types list .<br>
   *  Note : Treated as a special case of Lookup List as it has category &
   *  userId associated.
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandUpdateContactList(ActionContext context) {
    Exception errorMessage = null;
    Connection db = null;
    String category = context.getRequest().getParameter("category");
    String[] params = context.getRequest().getParameterValues("selectedList");
    String[] names = new String[params.length];
    int j = 0;

    StringTokenizer st = new StringTokenizer(context.getRequest().getParameter("selectNames"), "^");

    while (st.hasMoreTokens()) {
      names[j] = (String) st.nextToken();
      j++;
    }

    try {
      db = this.getConnection(context);
      if (System.getProperty("DEBUG") != null) {
        System.out.println("Admin -- > Updating Contact Types ");
      }

      ContactTypeList compareList = new ContactTypeList();
      compareList.setCategory(category);
      compareList.setIncludeDefinedByUser(this.getUserId(context));
      compareList.setShowPersonal(true);
      compareList.buildList(db);

      ContactTypeList newList = new ContactTypeList(params, names);

      Iterator i = compareList.iterator();
      while (i.hasNext()) {
        ContactType thisType = (ContactType) i.next();

        //not there, disable it, leave it
        if (newList.getElement(thisType.getId()) == null) {
          thisType.setEnabled(db, false);
        }
      }

      Iterator k = newList.iterator();
      while (k.hasNext()) {
        ContactType thisType = (ContactType) k.next();
        thisType.setCategory(category);
        System.out.println("Admin -- > New List " + thisType.getId() + " Category : " + category);
        if (thisType.getId() == 0) {
          thisType.insert(db);
        } else {
          thisType.setNewOrder(db);
        }
      }
      //end
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    context.getRequest().setAttribute("moduleId", context.getRequest().getParameter("module"));
    addModuleBean(context, "Configuration", "Configuration");
    return (executeCommandEditLists(context));
  }


  /**
   *  Modify a selected list
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandModifyList(ActionContext context) {
    if (!(hasPermission(context, "admin-sysconfig-lists-edit"))) {
      return ("PermissionError");
    }

    Exception errorMessage = null;
    Connection db = null;
    int module = -1;
    int sublist = -1;

    if (context.getRequest().getParameter("module") != null) {
      module = Integer.parseInt(context.getRequest().getParameter("module"));
    }

    if (context.getRequest().getParameter("sublist") != null) {
      sublist = Integer.parseInt(context.getRequest().getParameter("sublist"));
    }

    LookupList selectedList = null;
    String subTitle = null;

    try {
      db = this.getConnection(context);

      if (module == PermissionCategory.PERMISSION_CAT_LEADS) {
        if (sublist == PermissionCategory.LOOKUP_LEADS_STAGE) {
          selectedList = new LookupList(db, "lookup_stage");
          subTitle = "Pipeline Management: Stage";
        }
        if (sublist == PermissionCategory.LOOKUP_LEADS_TYPE) {
          selectedList = new LookupList(db, "lookup_opportunity_types");
          subTitle = "Pipeline Management: Opportunity Type";
        }
      }

      if (module == PermissionCategory.PERMISSION_CAT_CONTACTS) {
        if (sublist == PermissionCategory.LOOKUP_CONTACTS_TYPE) {
          ContactTypeList contactTypeList = new ContactTypeList();
          contactTypeList.setCategory(ContactType.GENERAL);
          contactTypeList.setShowPersonal(true);
          contactTypeList.buildList(db);
          selectedList = contactTypeList.getLookupList("contacttype", 0);
          subTitle = "Contacts &amp; Resources: Type";
          context.getRequest().setAttribute("category", String.valueOf(ContactType.GENERAL));
        } else if (sublist == PermissionCategory.LOOKUP_CONTACTS_EMAIL) {
          selectedList = new LookupList(db, "lookup_contactemail_types");
          subTitle = "Contacts &amp; Resources: Email Type";
        } else if (sublist == PermissionCategory.LOOKUP_CONTACTS_ADDRESS) {
          selectedList = new LookupList(db, "lookup_contactaddress_types");
          subTitle = "Contacts &amp; Resources: Address Type";
        } else if (sublist == PermissionCategory.LOOKUP_CONTACTS_PHONE) {
          selectedList = new LookupList(db, "lookup_contactphone_types");
          subTitle = "Contacts &amp; Resources: Phone Type";
        } else if (sublist == PermissionCategory.LOOKUP_CONTACTS_DEPT) {
          selectedList = new LookupList(db, "lookup_department");
          subTitle = "Contacts &amp; Resources: Department";
        }
      }

      if (module == PermissionCategory.PERMISSION_CAT_ACCOUNTS) {
        if (sublist == PermissionCategory.LOOKUP_ACCOUNTS_TYPE) {
          selectedList = new LookupList(db, "lookup_account_types");
          subTitle = "Account Management: Type";
        } else if (sublist == PermissionCategory.LOOKUP_ACCOUNTS_REVENUE_TYPE) {
          selectedList = new LookupList(db, "lookup_revenue_types");
          subTitle = "Account Management: Revenue Type";
        } else if (sublist == PermissionCategory.LOOKUP_ACCOUNTS_CONTACTS_TYPE) {
          ContactTypeList contactTypeList = new ContactTypeList();
          contactTypeList.setCategory(ContactType.ACCOUNT);
          contactTypeList.setShowPersonal(true);
          contactTypeList.buildList(db);
          selectedList = contactTypeList.getLookupList("contacttype", 0);
          subTitle = "Account Management: Contact Type";
          context.getRequest().setAttribute("category", String.valueOf(ContactType.ACCOUNT));
        }
      }

      if (module == PermissionCategory.PERMISSION_CAT_TICKETS) {
        if (sublist == PermissionCategory.LOOKUP_TICKETS_SOURCE) {
          selectedList = new LookupList(db, "lookup_ticketsource");
          subTitle = "Tickets: Source";
        } else if (sublist == PermissionCategory.LOOKUP_TICKETS_SEVERITY) {
          selectedList = new LookupList(db, "ticket_severity");
          subTitle = "Tickets: Severity";
        } else if (sublist == PermissionCategory.LOOKUP_TICKETS_PRIORITY) {
          selectedList = new LookupList(db, "ticket_priority");
          subTitle = "Tickets: Priority";
        }
      }
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (selectedList != null) {
      selectedList.setSelectSize(8);
      selectedList.setMultiple(true);
    }

    context.getRequest().setAttribute("SelectedList", selectedList);
    context.getRequest().setAttribute("SubTitle", subTitle);
    context.getRequest().setAttribute("moduleId", context.getRequest().getParameter("module"));
    addModuleBean(context, "Configuration", "Configuration");
    return ("ModifyListOK");
  }


  /**
   *  Lists the global parameters.
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandListGlobalParams(ActionContext context) {
    if (!(hasPermission(context, "admin-sysconfig-view"))) {
      return ("PermissionError");
    }
    addModuleBean(context, "Configuration", "Configuration");
    //get the session timeout
    ConnectionElement ce = (ConnectionElement) context.getSession().getAttribute("ConnectionElement");
    int sessionTimeout = ((SystemStatus) ((Hashtable) context.getServletContext().getAttribute("SystemStatus")).get(ce.getUrl())).getSessionTimeout();
    context.getRequest().setAttribute("Timeout", String.valueOf(sessionTimeout / 60));
    return ("GlobalParamsOK");
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandModifyTimeout(ActionContext context) {
    if (!(hasPermission(context, "admin-sysconfig-view"))) {
      return ("PermissionError");
    }
    addModuleBean(context, "Configuration", "Configuration");
    return ("ModifyTimeoutOK");
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandUpdateTimeout(ActionContext context) {
    if (!(hasPermission(context, "admin-sysconfig-view"))) {
      return ("PermissionError");
    }
    int timeout = Integer.parseInt(context.getRequest().getParameter("timeout"));
    addModuleBean(context, "Configuration", "Configuration");

    //get the session timeout
    ConnectionElement ce = (ConnectionElement) context.getSession().getAttribute("ConnectionElement");
    SystemStatus thisSystem = (SystemStatus) ((Hashtable) context.getServletContext().getAttribute("SystemStatus")).get(ce.getUrl());
    thisSystem.setSessionTimeout(timeout * 60);

    return executeCommandListGlobalParams(context);
  }


  /**
   *  Build all the necessarry form elements (lists)
   *
   *@param  context           Description of Parameter
   *@param  db                Description of Parameter
   *@exception  SQLException  Description of Exception
   *@since
   */
  protected void buildFormElements(ActionContext context, Connection db) throws SQLException {
    int moduleId = Integer.parseInt(context.getRequest().getParameter("moduleId"));
    LookupListList thisList = new LookupListList(db, moduleId);
    if (moduleId == PermissionCategory.PERMISSION_CAT_ACCOUNTS || moduleId == PermissionCategory.PERMISSION_CAT_CONTACTS) {
      ContactTypeList contactTypeList = new ContactTypeList();
      contactTypeList.setIncludeDefinedByUser(this.getUserId(context));
      contactTypeList.setCategory((moduleId == PermissionCategory.PERMISSION_CAT_ACCOUNTS ? ContactType.ACCOUNT : ContactType.GENERAL));
      contactTypeList.setShowPersonal(true);
      contactTypeList.buildList(db);
      int category = (moduleId == PermissionCategory.PERMISSION_CAT_ACCOUNTS ? PermissionCategory.LOOKUP_ACCOUNTS_CONTACTS_TYPE : PermissionCategory.LOOKUP_CONTACTS_TYPE);
      LookupListElement thisElement = thisList.getElement(category);
      if (thisElement != null) {
        thisElement.setLookupList(contactTypeList.getLookupList("list", 0));
      }
    }
    context.getRequest().setAttribute("LookupLists", thisList);
  }
}

