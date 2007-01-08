/*
 *  Copyright(c) 2006 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
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
package org.aspcfs.modules.website.actions;

import com.darkhorseventures.framework.actions.ActionContext;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.base.DependencyList;
import org.aspcfs.modules.base.Dependency;
import org.aspcfs.controller.SystemStatus;
import org.aspcfs.modules.website.base.*;
import org.aspcfs.modules.website.framework.IceletManager;
import org.aspcfs.modules.website.icelet.HtmlContentPortlet;
import org.aspcfs.utils.StringUtils;
import org.aspcfs.utils.web.PagedListInfo;
import org.aspcfs.utils.DatabaseUtils;
import org.aspcfs.utils.web.HtmlDialog;

import java.sql.Connection;
import java.sql.SQLException;

/**
 *  Actions for the Tabs module
 *
 * @author     kailash
 * @created    February 10, 2006 $Id: Exp $
 */
public final class Tabs extends CFSModule {

  /**
   *  Description of the Method
   *
   * @param  context  Description of the Parameter
   * @return          Description of the Return Value
   */
  public String executeCommandDefault(ActionContext context) {
    return this.getReturn(context, "Default");
  }


  /**
   *  Description of the Method
   *
   * @param  context  Description of the Parameter
   * @return          Description of the Return Value
   */
  public String executeCommandAdd(ActionContext context) {
    if (!(hasPermission(context, "site-editor-edit"))) {
      return ("PermissionError");
    }
    String siteId = context.getRequest().getParameter("siteId");
    if (siteId == null || "".equals(siteId.trim())) {
      siteId = (String) context.getRequest().getAttribute("siteId");
    }
    Tab tab = (Tab) context.getFormBean();
    String previousTabId = context.getRequest().getParameter("previousTabId");
    if (previousTabId == null || "".equals(previousTabId.trim())) {
      previousTabId = (String) context.getRequest().getAttribute("previousTabId");
    }
    if (previousTabId != null && !"".equals(previousTabId)) {
      tab.setPreviousTabId(previousTabId);
      context.getRequest().setAttribute("previousTabId", previousTabId);
    }
    String nextTabId = context.getRequest().getParameter("nextTabId");
    if (nextTabId == null || "".equals(nextTabId.trim())) {
      nextTabId = (String) context.getRequest().getAttribute("nextTabId");
    }
    if (nextTabId != null && !"".equals(nextTabId)) {
      tab.setNextTabId(nextTabId);
      context.getRequest().setAttribute("nextTabId", nextTabId);
    }
    Site site = null;
    Connection db = null;
    try {
      db = this.getConnection(context);
      site = new Site();
      site.setBuildTabList(true);
      site.queryRecord(db, Integer.parseInt(siteId));
      context.getRequest().setAttribute("site", site);
      tab.setSiteId(siteId);
      context.getRequest().setAttribute("tab", tab);
    } catch (Exception e) {
      e.printStackTrace();
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return this.getReturn(context, "Add");
  }


  /**
   *  Description of the Method
   *
   * @param  context  Description of the Parameter
   * @return          Description of the Return Value
   */
  public String executeCommandModify(ActionContext context) {
    if (!(hasPermission(context, "site-editor-edit"))) {
      return ("PermissionError");
    }
    String siteId = context.getRequest().getParameter("siteId");
    if (siteId == null || "".equals(siteId.trim())) {
      siteId = (String) context.getRequest().getAttribute("siteId");
    }
    String tabId = context.getRequest().getParameter("tabId");
    if (tabId == null || "".equals(tabId.trim())) {
      tabId = (String) context.getRequest().getAttribute("tabId");
    }
    Tab tab = (Tab) context.getFormBean();
    Site site = null;
    SystemStatus systemStatus = this.getSystemStatus(context);
    Connection db = null;
    try {
      db = this.getConnection(context);
      site = new Site();
      site.setBuildTabList(true);
      site.queryRecord(db, Integer.parseInt(siteId));
      context.getRequest().setAttribute("site", site);
      if (tab.getId() == -1) {
        tab = new Tab(db, Integer.parseInt(tabId));
      }
      tab.setSiteId(siteId);
      context.getRequest().setAttribute("tab", tab);
    } catch (Exception e) {
      e.printStackTrace();
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return this.getReturn(context, "Modify");
  }


  /**
   *  Description of the Method
   *
   * @param  context  Description of the Parameter
   * @return          Description of the Return Value
   */
  public String executeCommandSave(ActionContext context) {
    if (!(hasPermission(context, "site-editor-edit"))) {
      return ("PermissionError");
    }
    String siteId = context.getRequest().getParameter("siteId");
    if (siteId == null || "".equals(siteId.trim())) {
      siteId = (String) context.getRequest().getAttribute("siteId");
    }
    String previousTabId = context.getRequest().getParameter("previousTabId");
    String nextTabId = context.getRequest().getParameter("nextTabId");
    boolean isValid = false;
    boolean recordInserted = false;
    int recordCount = -1;
    Tab tab = (Tab) context.getFormBean();
    Site site = null;
    SystemStatus systemStatus = this.getSystemStatus(context);
    Connection db = null;
    try {
      db = this.getConnection(context);
      if (tab.getSiteId() == -1) {
        tab.setSiteId(siteId);
      }
      tab.setModifiedBy(getUserId(context));
      isValid = this.validateObject(context, db, tab);
      if (isValid) {
        if (tab.getId() > -1) {
          recordCount = tab.update(db);
        } else {
          tab.setPosition(tab.computeTabPosition(db));
          recordInserted = tab.insert(db);
          if (recordInserted) {
            insertDefaultData(context, db, tab.getId());
          }
        }
      }
      if (!isValid || (!recordInserted && recordCount == -1)) {
        if (nextTabId != null && !"".equals(nextTabId.trim())) {
          context.getRequest().setAttribute("nextTabId", nextTabId);
        }
        if (previousTabId != null && !"".equals(previousTabId.trim())) {
          context.getRequest().setAttribute("previousTabId", previousTabId);
        }
        if (tab.getId() > -1) {
          // TODO: Executing a new action within an open db can create a deadlock
          return executeCommandModify(context);
        } else {
          // TODO: Executing a new action within an open db can create a deadlock
          return executeCommandAdd(context);
        }
      }
      context.getRequest().setAttribute("siteId", String.valueOf(tab.getSiteId()));
    } catch (Exception e) {
      e.printStackTrace();
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return this.getReturn(context, "Save");
  }


  /**
   *  Description of the Method
   *
   * @param  context  Description of the Parameter
   * @return          Description of the Return Value
   */
  public String executeCommandMove(ActionContext context) {
    if (!(hasPermission(context, "site-editor-edit"))) {
      return ("PermissionError");
    }
    String tabId = context.getRequest().getParameter("tabId");
    String moveTabLeft = context.getRequest().getParameter("moveTabLeft");
    if (moveTabLeft == null || "".equals(moveTabLeft.trim())) {
      moveTabLeft = new String("YES");
    }
    Tab tab = null;
    Connection db = null;
    try {
      db = this.getConnection(context);
      tab = new Tab(db, Integer.parseInt(tabId));
      tab.move(db, DatabaseUtils.parseBoolean(moveTabLeft));
    } catch (Exception e) {
      e.printStackTrace();
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return this.getReturn(context, "Move");
  }


  /**
   *  Description of the Method
   *
   * @param  context  Description of the Parameter
   * @return          Description of the Return Value
   */
  public String executeCommandConfirmDelete(ActionContext context) {
    if (!(hasPermission(context, "site-editor-delete"))) {
      return ("PermissionError");
    }
    String siteId = context.getRequest().getParameter("siteId");
    if (siteId == null || "".equals(siteId.trim())) {
      siteId = (String) context.getRequest().getAttribute("siteId");
    }
    String tabId = context.getRequest().getParameter("tabId");
    if (tabId == null || "".equals(tabId.trim())) {
      tabId = (String) context.getRequest().getAttribute("tabId");
    }
    Tab tab = null;
    HtmlDialog htmlDialog = new HtmlDialog();
    SystemStatus systemStatus = this.getSystemStatus(context);
    Connection db = null;
    try {
      db = this.getConnection(context);
      tab = new Tab(db, Integer.parseInt(tabId));
      //dependencies
      DependencyList dependencies = tab.processDependencies(db);
      dependencies.setSystemStatus(systemStatus);
      htmlDialog.addMessage(systemStatus.getLabel("confirmdelete.caution") + "\n" + dependencies.getHtmlString());
      if (dependencies.canDelete()) {
        htmlDialog.setTitle(systemStatus.getLabel("confirmdelete.title"));
        htmlDialog.setHeader(systemStatus.getLabel("actionphase.dependencies"));
        htmlDialog.addButton(systemStatus.getLabel("global.button.delete"), "javascript:window.location.href='Tabs.do?command=Delete&siteId=" + siteId + "&tabId=" + tab.getId() + "&popup=true'");
        htmlDialog.addButton(systemStatus.getLabel("button.cancel"), "javascript:parent.window.close();");
      } else {
        htmlDialog.setTitle(systemStatus.getLabel("confirmdelete.title"));
        htmlDialog.setHeader(systemStatus.getLabel("confirmdelete.unableHeader"));
        htmlDialog.addButton("OK", "javascript:parent.window.close()");
      }
      context.getSession().setAttribute("Dialog", htmlDialog);
    } catch (Exception e) {
      e.printStackTrace();
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    return this.getReturn(context, "ConfirmDelete");
  }


  /**
   *  Description of the Method
   *
   * @param  context  Description of the Parameter
   * @return          Description of the Return Value
   */
  public String executeCommandDelete(ActionContext context) {
    if (!(hasPermission(context, "site-editor-delete"))) {
      return ("PermissionError");
    }
    String siteId = (String) context.getRequest().getParameter("siteId");
    if (siteId != null && !"".equals(siteId)) {
      context.getRequest().setAttribute("siteId", siteId);
    }
    String tabId = context.getRequest().getParameter("tabId");
    if (tabId == null || "".equals(tabId)) {
      tabId = (String) context.getRequest().getAttribute("tabId");
    }
    Tab tab = null;
    Connection db = null;
    try {
      db = getConnection(context);
      tab = new Tab();
      tab.queryRecord(db, Integer.parseInt(tabId));
      //delete the tab
      tab.delete(db);
    } catch (Exception e) {
      e.printStackTrace();
      context.getRequest().setAttribute("Error", e);
      return ("SystemError");
    } finally {
      this.freeConnection(context, db);
    }
    context.getRequest().setAttribute("refreshUrl", "Sites.do?command=Details&siteId=" + siteId + "&popup=true");
    return this.getReturn(context, "Delete");
  }


  /**
   *  Description of the Method
   *
   * @param  context           Description of the Parameter
   * @param  db                Description of the Parameter
   * @param  tabId             Description of the Parameter
   * @exception  SQLException  Description of the Exception
   */
  public void insertDefaultData(ActionContext context, Connection db, int tabId) throws SQLException {
    SystemStatus systemStatus = this.getSystemStatus(context);
    int userId = this.getUserId(context);
    //Insert the page_version
    PageVersion pageVersion = new PageVersion();
    pageVersion.setVersionNumber(PageVersion.INITIAL_VERSION);
    pageVersion.setModifiedBy(userId);
    pageVersion.insert(db);
    //Insert the page_group
    PageGroup pageGroup = new PageGroup();
    pageGroup.setName(systemStatus.getLabel("", "Home"));
    pageGroup.setTabId(tabId);
    pageGroup.setPosition(PageGroup.INITIAL_POSITION);
    pageGroup.setModifiedBy(userId);
    pageGroup.insert(db);
    //Insert the page
    Page page = new Page();
    page.setName(systemStatus.getLabel("", "Home"));
    page.setPageGroupId(pageGroup.getId());
    page.setConstructionPageVersionId(pageVersion.getId());
    page.setActivePageVersionId(pageVersion.getId());
    page.setPosition(Page.INITIAL_POSITION);
    page.setEnabled(true);
    page.setModifiedBy(userId);
    page.insert(db);
    //Update the page version
    pageVersion = new PageVersion(db, pageVersion.getId());
    pageVersion.setOverride(true);
    pageVersion.setPageId(page.getId());
    pageVersion.update(db);
    //Insert the page_row
    PageRow pageRow = new PageRow();
    pageRow.setPageVersionId(page.getConstructionPageVersionId());
    pageRow.setPosition(PageRow.INITIAL_POSITION);
    pageRow.setEnabled(true);
    pageRow.setModifiedBy(userId);
    pageRow.insert(db);
    //Build the icelet from the database
    Icelet htmlIcelet = null;
    IceletList iceletList = new IceletList();
    iceletList.setConfiguratorClass("HtmlContentPortlet");
    iceletList.buildList(db);
    if (iceletList.size() > 0) {
      htmlIcelet = (Icelet) iceletList.get(0);
    }
    //Insert the row_column
    RowColumn rowColumn = new RowColumn();
    rowColumn.setPageRowId(pageRow.getId());
    rowColumn.setModifiedBy(userId);
    rowColumn.setEnabled(true);
    rowColumn.setWidth(100);
    rowColumn.setPosition(RowColumn.INITIAL_POSITION);
    if (htmlIcelet != null && htmlIcelet.getId() > -1) {
      rowColumn.setIceletId(htmlIcelet.getId());
    }
    rowColumn.insert(db);
    //Insert the icelet.
    if (htmlIcelet != null && htmlIcelet.getId() > -1) {
      IceletProperty property = new IceletProperty();
      property.setRowColumnId(rowColumn.getId());
      property.setValue("Please enter your html text here");
      property.setTypeConstant(HtmlContentPortlet.PROPERTY_HTMLTEXT);
      property.setModifiedBy(userId);
      property.insert(db);
    }
  }
}

