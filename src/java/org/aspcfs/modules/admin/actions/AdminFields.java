package com.darkhorseventures.cfsmodule;

import javax.servlet.*;
import javax.servlet.http.*;
import org.theseus.actions.*;
import java.sql.*;
import java.util.*;
import com.darkhorseventures.utils.*;
import com.darkhorseventures.cfsbase.*;
import com.darkhorseventures.webutils.*;

/**
 *  Description of the Class
 *
 *@author     matt
 *@created    January 4, 2002
 *@version    $Id$
 */
public final class AdminFields extends CFSModule {

  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   */
  public String executeCommandDefault(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-view"))) {
	    return ("PermissionError");
    	}
	
    return executeCommandListFolders(context);
  }


  public String executeCommandListFolders(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-view"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;

    try {
      db = this.getConnection(context);
      this.addModuleList(context, db);
      this.addCategoryList(context, db);
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Configuration", "Configuration");
    return ("ListFoldersOK");
  }
  
  public String executeCommandAddFolder(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-add"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;

    try {
      db = this.getConnection(context);
      this.addModuleList(context, db);
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Configuration", "Configuration");
    return ("AddFolderOK");
  }
  
  public String executeCommandInsertFolder(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-add"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;
    boolean result = true;

    try {
      db = this.getConnection(context);
      CustomFieldCategory thisCategory = (CustomFieldCategory)context.getFormBean();
      result = thisCategory.insertCategory(db);
      if (!result) {
        this.processErrors(context, thisCategory.getErrors());
      }
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }

    if (result) {
      return ("InsertFolderOK");
    } else {
      return ("InsertFolderERROR");
    }
  }
  
  public String executeCommandModifyFolder(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-edit"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;

    try {
      db = this.getConnection(context);
      this.addModuleList(context, db);
      this.addCategoryList(context, db);
      this.addCategory(context, db);
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Configuration", "Configuration");
    return ("ModifyFolderOK");
  }
  
  public String executeCommandUpdateFolder(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-edit"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;
    boolean result = false;
    
    try {
      db = this.getConnection(context);
      CustomFieldCategory thisCategory = (CustomFieldCategory)context.getFormBean();
      result = thisCategory.updateCategory(db);
      this.processErrors(context, thisCategory.getErrors());
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Configuration", "Configuration");
    if (result) {
      return ("UpdateFolderOK");
    } else {
      return ("UpdateFolderERROR");
    }
  }
  
  public String executeCommandToggleFolder(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-edit"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;
    boolean result = true;

    String moduleId = context.getRequest().getParameter("modId"); 
    String categoryId = context.getRequest().getParameter("catId");
    
    try {
      db = this.getConnection(context);
      CustomFieldCategory thisCategory = new CustomFieldCategory(db, Integer.parseInt(categoryId));
      if (moduleId.equals("" + thisCategory.getModuleId())) {
        thisCategory.toggleEnabled(db);
      }
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }
    
    return("ToggleOK");
  }
  
  public String executeCommandDeleteFolder(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-delete"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;
    boolean result = true;

    try {
      db = this.getConnection(context);
      CustomFieldCategory thisCategory = (CustomFieldCategory)context.getFormBean();
      result = thisCategory.deleteCategory(db);
      if (!result) {
        this.processErrors(context, thisCategory.getErrors());
      }
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Configuration", "Configuration");
    if (result) {
      return ("DeleteFolderOK");
    } else {
      return ("DeleteFolderERROR");
    }
  }
  
  
  //Groups
  
  public String executeCommandListGroups(ActionContext context) {
	  
 	if (!(hasPermission(context, "admin-sysconfig-folders-view"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;

    try {
      db = this.getConnection(context);
      this.addModuleList(context, db);
      this.addCategoryList(context, db);
      this.addCategory(context, db);
      
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Configuration", "Configuration");
    return ("ListGroupsOK");
  }
  
  public String executeCommandAddGroup(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-add"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;

    try {
      db = this.getConnection(context);
      this.addModuleList(context, db);
      this.addCategoryList(context, db);
      this.addCategory(context, db);
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }
    return ("AddGroupOK");
  }
  
  public String executeCommandInsertGroup(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-add"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;
    boolean result = false;

    try {
      db = this.getConnection(context);
      CustomFieldGroup thisGroup = (CustomFieldGroup)context.getFormBean();
      result = thisGroup.insertGroup(db);
      if (!result) {
        this.processErrors(context, thisGroup.getErrors());
      }
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }
    if (result) {
      return ("InsertGroupOK");
    } else {
      return ("InsertGroupERROR");
    }
  }
  
  public String executeCommandModifyGroup(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-edit"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;

    try {
      db = this.getConnection(context);
      this.addModuleList(context, db);
      this.addCategoryList(context, db);
      this.addCategory(context, db);
      this.addGroup(context, db);
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Configuration", "Configuration");
    return ("ModifyGroupOK");
  }
  
  public String executeCommandUpdateGroup(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-edit"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;
    boolean result = false;
    
    try {
      db = this.getConnection(context);
      CustomFieldGroup thisGroup = (CustomFieldGroup)context.getFormBean();
      result = thisGroup.updateGroup(db);
      this.processErrors(context, thisGroup.getErrors());
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Configuration", "Configuration");
    if (result) {
      return ("UpdateGroupOK");
    } else {
      return ("UpdateGroupERROR");
    }
  }
  
  public String executeCommandDeleteGroup(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-delete"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;
    boolean result = true;

    try {
      db = this.getConnection(context);
      CustomFieldGroup thisGroup = (CustomFieldGroup)context.getFormBean();
      result = thisGroup.deleteGroup(db);
      if (!result) {
        this.processErrors(context, thisGroup.getErrors());
      }
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }

    if (result) {
      return ("DeleteGroupOK");
    } else {
      return ("DeleteGroupERROR");
    }
  }
  
  
  //Fields
  
  public String executeCommandAddField(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-add"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;

    try {
      db = this.getConnection(context);
      this.addModuleList(context, db);
      this.addCategoryList(context, db);
      this.addCategory(context, db);
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }
    return ("AddFieldOK");
  }
  
  public String executeCommandInsertField(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-add"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;
    boolean result = false;

    try {
      db = this.getConnection(context);
      CustomField thisField = (CustomField)context.getFormBean();
      result = thisField.insertField(db);
      if (!result) {
        this.processErrors(context, thisField.getErrors());
      }
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }
    if (result) {
      return ("InsertFieldOK");
    } else {
      return ("InsertFieldERROR");
    }
  }
  
  public String executeCommandDeleteField(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-delete"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;
    boolean result = true;

    try {
      db = this.getConnection(context);
      CustomField thisField = (CustomField)context.getFormBean();
      result = thisField.deleteField(db);
      if (!result) {
        this.processErrors(context, thisField.getErrors());
      }
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }

    if (result) {
      return ("DeleteFieldOK");
    } else {
      return ("DeleteFieldERROR");
    }
  }
  
  public String executeCommandModifyField(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-edit"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;

    try {
      db = this.getConnection(context);
      this.addModuleList(context, db);
      this.addCategoryList(context, db);
      this.addCategory(context, db);
      this.addGroup(context, db);
      this.addField(context, db);
    } catch (Exception e) {
      errorMessage = e;
      e.printStackTrace(System.out);
    } finally {
      this.freeConnection(context, db);
    }
    addModuleBean(context, "Configuration", "Configuration");
    return ("ModifyFieldOK");
  }
  
  public String executeCommandUpdateField(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-edit"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;
    boolean result = false;
    
    try {
      db = this.getConnection(context);
      CustomField thisField = (CustomField)context.getFormBean();
      thisField.buildElementData(db);
      
      if (thisField.getLookupListRequired()) {
      
        String[] params = context.getRequest().getParameterValues("selectedList");
        String[] names = new String[params.length];
        String tblName = "";
        int j = 0;
    
        StringTokenizer st = new StringTokenizer(context.getRequest().getParameter("selectNames"), "^");
        
        while (st.hasMoreTokens()) {
          names[j] = (String) st.nextToken();
          if (System.getProperty("DEBUG") != null) System.out.println(names[j]);
          j++;
        }
        
        LookupList compareList = (LookupList)thisField.getElementData();
        LookupList newList = new LookupList(params, names);
        if (System.getProperty("DEBUG") != null) newList.printVals();
        
        Iterator i = compareList.iterator();
        while (i.hasNext()) {
          LookupElement thisElement = (LookupElement) i.next();
  
          //still there, stay enabled, don't re-insert it
          if (System.getProperty("DEBUG") != null) System.out.println("Here: " + thisElement.getCode() + " " + newList.getSelectedValue(thisElement.getCode()));
  
          //not there, disable it, leave it
          if (newList.getSelectedValue(thisElement.getCode()).equals("") || 
              newList.getSelectedValue(thisElement.getCode()) == null) {
            thisElement.disableElement(db, "custom_field_lookup");
          }
        }
        
        Iterator k = newList.iterator();
        while (k.hasNext()) {
          LookupElement thisElement = (LookupElement) k.next();
  
          if (thisElement.getCode() == 0) {
            thisElement.insertElement(db, "custom_field_lookup", thisField.getId());
          } else {
            thisElement.setNewOrder(db, "custom_field_lookup");
          }
        }
      }
      
      result = thisField.updateField(db);
      this.processErrors(context, thisField.getErrors());
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
      e.printStackTrace(System.out);
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Configuration", "Configuration");
    if (result) {
      return ("UpdateFieldOK");
    } else {
      return ("UpdateFieldERROR");
    }
  }
  
  
  
  //
  
  private void addModuleList(ActionContext context, Connection db) throws SQLException {
    String moduleId = context.getRequest().getParameter("modId");
    LookupList moduleList = new LookupList(db, "system_modules");
    moduleList.setDefaultKey(moduleId);
    context.getRequest().setAttribute("ModuleList", moduleList);
    System.out.println("AdminFields-> addModuleListOK");
  }
  
  private void addCategoryList(ActionContext context, Connection db) throws SQLException {
    LookupList moduleList = (LookupList)context.getRequest().getAttribute("ModuleList");
    CustomFieldCategoryList categoryList = new CustomFieldCategoryList();
    if (moduleList.size() > 0) {
      categoryList.setLinkModuleId(moduleList.getSelectedKey());
      categoryList.setBuildResources(false);
      categoryList.buildList(db);
      context.getRequest().setAttribute("CategoryList", categoryList);
      System.out.println("AdminFields-> addCategoryListOK");
    }
  }
  
  private void addCategory(ActionContext context, Connection db) throws SQLException {
    if ( (context.getRequest().getParameter("auto-populate") == null) ||
         (context.getFormBean() == null) ||
         (!(context.getFormBean() instanceof CustomFieldCategory))) {
          
      String categoryId = context.getRequest().getParameter("catId");
      if (categoryId == null) {
        categoryId = (String)context.getRequest().getAttribute("catId");
      }
      if (System.getProperty("DEBUG") != null) System.out.println("AdminFields-> Adding Category: " + categoryId);
      if (categoryId != null) {
        context.getRequest().setAttribute("catId", categoryId);
        LookupList moduleList = (LookupList)context.getRequest().getAttribute("ModuleList");
        CustomFieldCategoryList categoryList = (CustomFieldCategoryList)context.getRequest().getAttribute("CategoryList");
        CustomFieldCategory thisCategory = categoryList.getCategory(Integer.parseInt(categoryId));
        thisCategory.setLinkModuleId(moduleList.getSelectedKey());
        thisCategory.setBuildResources(true);
        thisCategory.buildResources(db);
        context.getRequest().setAttribute("Category", thisCategory);
      }
    }
  }
  
  private void addGroup(ActionContext context, Connection db) throws SQLException {
    if ( (context.getRequest().getParameter("auto-populate") == null) ||
         (context.getFormBean() == null) ||
         (!(context.getFormBean() instanceof CustomFieldGroup))) {
          
      String groupId = context.getRequest().getParameter("grpId");
      if (groupId == null) {
        groupId = (String)context.getRequest().getAttribute("grpId");
      }
      if (System.getProperty("DEBUG") != null) System.out.println("AdminFields-> Adding Group: " + groupId);
      if (groupId != null) {
        context.getRequest().setAttribute("grpId", groupId);
        LookupList moduleList = (LookupList)context.getRequest().getAttribute("ModuleList");
        CustomFieldCategoryList categoryList = (CustomFieldCategoryList)context.getRequest().getAttribute("CategoryList");
        CustomFieldCategory thisCategory = (CustomFieldCategory)context.getRequest().getAttribute("Category");
        CustomFieldGroup thisGroup = thisCategory.getGroup(Integer.parseInt(groupId));
        context.getRequest().setAttribute("Group", thisGroup);
      }
    }
  }
  
  private void addField(ActionContext context, Connection db) throws SQLException {
    if ( (context.getRequest().getParameter("auto-populate") == null) ||
         (context.getFormBean() == null) ||
         (!(context.getFormBean() instanceof CustomField))) {
    
      String fieldId = context.getRequest().getParameter("id");
      if (fieldId == null) {
        fieldId = (String)context.getRequest().getAttribute("id");
      }
      if (System.getProperty("DEBUG") != null) System.out.println("AdminFields-> Adding Field: " + fieldId);
      if (fieldId != null) {
        context.getRequest().setAttribute("id", fieldId);
        LookupList moduleList = (LookupList)context.getRequest().getAttribute("ModuleList");
        CustomFieldCategoryList categoryList = (CustomFieldCategoryList)context.getRequest().getAttribute("CategoryList");
        CustomFieldCategory thisCategory = (CustomFieldCategory)context.getRequest().getAttribute("Category");
        CustomFieldGroup thisGroup = (CustomFieldGroup)context.getRequest().getAttribute("Group");
        if (thisGroup == null) System.out.println("AdminFields-> CustomFieldGroup should not be null");
        CustomField thisField = thisGroup.getField(Integer.parseInt(fieldId));
        context.getRequest().setAttribute("CustomField", thisField);
      }
    } else if ( (context.getRequest().getParameter("auto-populate") != null) &&
         (context.getFormBean() != null) &&
         (context.getFormBean() instanceof CustomField)) {
       CustomField thisField = (CustomField)context.getFormBean();
       thisField.buildElementData(db);
    }
  }
  
  public String executeCommandMoveField(ActionContext context) {
	  
 	if (!(hasPermission(context, "admin-sysconfig-folders-edit"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;

    try {
      db = this.getConnection(context);
      this.addModuleList(context, db);
      this.addCategoryList(context, db);
      this.addCategory(context, db);
      
      String change = context.getRequest().getParameter("chg");
      if (System.getProperty("DEBUG") != null) System.out.println("AdminFields->MoveField: " + change);
      
      if (change != null && change.indexOf("|") > -1) {
        StringTokenizer st = new StringTokenizer(change, "|");
        int groupChange = Integer.parseInt((String)st.nextToken());
        int fieldChange = Integer.parseInt((String)st.nextToken());
        String direction = (String)st.nextToken();
        
        CustomFieldCategory thisCategory = (CustomFieldCategory)context.getRequest().getAttribute("Category");
        Iterator groups = thisCategory.iterator();
        int groupCount = 0;
        int previousGroupId = -1;
        int previousGroupSize = -1;
        CustomFieldGroup previousGroup = null;  
        boolean hasNewGroup = false;
        int previousFieldId = -1;
        while (groups.hasNext()) {
          CustomFieldGroup thisGroup = (CustomFieldGroup)groups.next();
          ++groupCount;
          Iterator fields = thisGroup.iterator();
          int level = 0;
          int fieldCount = 0;
          boolean forceUpdate = false;
          if (hasNewGroup) {
            ++level;
            ++fieldCount;
            CustomField thisField = new CustomField();
            thisField.setId(previousFieldId);
            thisField.setLevel(level);
            thisField.setGroupId(thisGroup.getId());
            thisField.updateLevel(db);
            hasNewGroup = false;
            forceUpdate = true;
          }
          
          while (fields.hasNext()) {
            CustomField thisField = (CustomField)fields.next();
            ++fieldCount;
            
            if (groupCount > 1 && fieldCount == 1 && groupChange == groupCount && fieldChange == 1 && "U".equals(direction)) {
              thisField.setLevel(previousGroup.size() + 1);
              thisField.setGroupId(previousGroup.getId());
            } else if (groups.hasNext() && !fields.hasNext() && groupChange == groupCount && fieldChange == fieldCount && "D".equals(direction)) {
              hasNewGroup = true;
              previousFieldId = thisField.getId();
            } else if (groupCount == groupChange && "U".equals(direction)) {
              if (fieldCount < fieldChange) ++level;
              if ((fieldCount + 1) == fieldChange) ++level;
              if (fieldCount == fieldChange) --level;
              if (fieldCount > fieldChange) ++level;
              thisField.setLevel((new Integer(level)).intValue());
              if (fieldCount == fieldChange) ++level;
            } else if (groupCount == groupChange && "D".equals(direction)) {
              if (fieldCount < fieldChange) ++level;
              if (fieldCount == fieldChange) level = level + 2;
              if ((fieldCount - 1) == fieldChange) --level;
              if ((fieldCount - 1) > fieldChange) ++level;
              thisField.setLevel((new Integer(level)).intValue());
              if ((fieldCount - 1) == fieldChange) ++level;
            } else if (forceUpdate) {
              ++level;
              thisField.setLevel((new Integer(level)).intValue());
            }
            
            if (!hasNewGroup) thisField.updateLevel(db);
            System.out.println("Grp: " + thisField.getGroupId() + " Fld: " + thisField.getLevel());
          }
          previousGroup = thisGroup;
          previousGroupId = thisGroup.getId();
          previousGroupSize = thisGroup.size();
        }
      }
      
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
      e.printStackTrace(System.out);
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Configuration", "Configuration");
    return ("MoveFieldOK");
  }
  
  public String executeCommandMoveGroup(ActionContext context) {
	  
	if (!(hasPermission(context, "admin-sysconfig-folders-edit"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;

    try {
      db = this.getConnection(context);
      this.addModuleList(context, db);
      this.addCategoryList(context, db);
      this.addCategory(context, db);
      
      String change = context.getRequest().getParameter("chg");
      if (System.getProperty("DEBUG") != null) System.out.println("AdminFields->MoveGroup: " + change);
      
      if (change != null && change.indexOf("|") > -1) {
        StringTokenizer st = new StringTokenizer(change, "|");
        int groupChange = Integer.parseInt((String)st.nextToken());
        String direction = (String)st.nextToken();
        
        CustomFieldCategory thisCategory = (CustomFieldCategory)context.getRequest().getAttribute("Category");
        Iterator groups = thisCategory.iterator();
        int groupCount = 0;
        int level = 0;
        while (groups.hasNext()) {
          CustomFieldGroup thisGroup = (CustomFieldGroup)groups.next();
          ++groupCount;
            
          if ("U".equals(direction)) {
            if (groupCount < groupChange) ++level;
            if ((groupCount + 1) == groupChange) ++level;
            if (groupCount == groupChange) --level;
            if (groupCount > groupChange) ++level;
            thisGroup.setLevel((new Integer(level)).intValue());
            if (groupCount == groupChange) ++level;
          } else if ("D".equals(direction)) {
            if (groupCount < groupChange) ++level;
            if (groupCount == groupChange) level = level + 2;
            if ((groupCount - 1) == groupChange) --level;
            if ((groupCount - 1) > groupChange) ++level;
            thisGroup.setLevel((new Integer(level)).intValue());
            if ((groupCount - 1) == groupChange) ++level;
          }
          
          thisGroup.updateLevel(db);
          System.out.println("Grp: " + thisGroup.getId());
        }
      }
      
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
      e.printStackTrace(System.out);
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Configuration", "Configuration");
    return ("MoveGroupOK");
  }
  
}

