/*
 *  Copyright 2001 Dark Horse Ventures
 *  Uses iteam objects from matt@zeroio.com http://www.mavininteractive.com
 */
package com.darkhorseventures.cfsmodule;

import javax.servlet.*;
import javax.servlet.http.*;
import org.theseus.actions.*;
import java.sql.*;
import java.util.*;
import com.darkhorseventures.cfsbase.*;
import com.darkhorseventures.webutils.*;
import com.zeroio.iteam.base.*;
import com.zeroio.webutils.*;
import com.isavvix.tools.*;
import java.io.*;

/**
 *  Description of the Class
 *
 *@author     mrajkowski
 *@created    December 4, 2001
 *@version    $Id$
 */
public final class ProjectManagementFiles extends CFSModule {

  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandAdd(ActionContext context) {
	  
	if (!(hasPermission(context, "projects-documents-add"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;

    String projectId = (String)context.getRequest().getParameter("pid");
    if (projectId == null) { 
      projectId = (String)context.getRequest().getAttribute("pid");
    }

    Connection db = null;
    try {
      db = getConnection(context);
      Project thisProject = new Project(db, Integer.parseInt(projectId), getUserRange(context));
      context.getRequest().setAttribute("Project", thisProject);
      context.getRequest().setAttribute("IncludeSection", ("file_upload").toLowerCase());
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Add File", "");
    if (errorMessage == null) {
      return ("ProjectCenterOK");
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
  public String executeCommandUpload(ActionContext context) {
	  
	if (!(hasPermission(context, "projects-documents-add"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;

    boolean recordInserted = false;
    try {
      String filePath = this.getPath(context, "projects");
      
      //Process the form data
      HttpMultiPartParser multiPart = new HttpMultiPartParser();
      multiPart.setUsePathParam(true);
      multiPart.setUseUniqueName(true);
      multiPart.setUseDateForFolder(true);
      multiPart.setExtensionId(getUserId(context));
      
      Hashtable parts = multiPart.parseData(
        context.getRequest().getInputStream(), "---------------------------", filePath);
      
      String projectId = (String)parts.get("pid");
      String subject = (String)parts.get("subject");
      String folderId = (String)parts.get("folderId");
      
      //Update the database with the resulting file
      FileInfo newFileInfo = (FileInfo)parts.get("id" + projectId);
      
      db = getConnection(context);
      Project thisProject = new Project(db, Integer.parseInt(projectId), getUserRange(context));
      context.getRequest().setAttribute("Project", thisProject);
      context.getRequest().setAttribute("IncludeSection", ("file_library").toLowerCase());
      
      FileItem thisItem = new FileItem();
      thisItem.setProjectId(thisProject.getId());
      thisItem.setEnteredBy(getUserId(context));
      thisItem.setModifiedBy(getUserId(context));
      thisItem.setFolderId(Integer.parseInt(folderId));
      thisItem.setSubject(subject);
      thisItem.setClientFilename(newFileInfo.getClientFileName());
      thisItem.setFilename(newFileInfo.getRealFilename());
      thisItem.setVersion(1.0);
      thisItem.setSize(newFileInfo.getSize());
      
      recordInserted = thisItem.insert(db);
      if (!recordInserted) {
        processErrors(context, thisItem.getErrors());
      }
      context.getRequest().setAttribute("pid", projectId);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      freeConnection(context, db);
    }

    if (errorMessage == null) {
      if (recordInserted) {
        return ("AddOK");
      } else {
        return (executeCommandAdd(context));
      }
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }
  
  public String executeCommandAddVersion(ActionContext context) {
	  
	if (!(hasPermission(context, "projects-documents-add"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;

    String projectId = (String)context.getRequest().getParameter("pid");
    if (projectId == null) { 
      projectId = (String)context.getRequest().getAttribute("pid");
    }
    
    String itemId = (String)context.getRequest().getParameter("fid");
    if (itemId == null) { 
      itemId = (String)context.getRequest().getAttribute("fid");
    }

    Connection db = null;
    try {
      db = getConnection(context);
      Project thisProject = new Project(db, Integer.parseInt(projectId), getUserRange(context));
      context.getRequest().setAttribute("Project", thisProject);
      
      FileItem thisFile = new FileItem(db, Integer.parseInt(itemId), Integer.parseInt(projectId));
      context.getRequest().setAttribute("FileItem", thisFile);
      
      
      context.getRequest().setAttribute("IncludeSection", ("file_upload_version").toLowerCase());
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Add File", "Add Version");
    if (errorMessage == null) {
      return ("ProjectCenterOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }
  
  public String executeCommandUploadVersion(ActionContext context) {
	  
	if (!(hasPermission(context, "projects-documents-add"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    Connection db = null;

    boolean recordInserted = false;
    try {
      String filePath = this.getPath(context, "projects");
      
      //Process the form data
      HttpMultiPartParser multiPart = new HttpMultiPartParser();
      multiPart.setUsePathParam(true);
      multiPart.setUseUniqueName(true);
      multiPart.setUseDateForFolder(true);
      multiPart.setExtensionId(getUserId(context));
      
      Hashtable parts = multiPart.parseData(
        context.getRequest().getInputStream(), "---------------------------", filePath);
      
      String projectId = (String)parts.get("pid");
      String itemId = (String)parts.get("fid");
      String subject = (String)parts.get("subject");
      String versionId = (String)parts.get("versionId");
      
      //Update the database with the resulting file
      FileInfo newFileInfo = (FileInfo)parts.get("id" + projectId);
      
      db = getConnection(context);
      Project thisProject = new Project(db, Integer.parseInt(projectId), getUserRange(context));
      context.getRequest().setAttribute("Project", thisProject);
      context.getRequest().setAttribute("IncludeSection", ("file_library").toLowerCase());
      
      FileItem thisItem = new FileItem();
      thisItem.setProjectId(thisProject.getId());
      thisItem.setId(Integer.parseInt(itemId));
      thisItem.setEnteredBy(getUserId(context));
      thisItem.setModifiedBy(getUserId(context));
      thisItem.setSubject(subject);
      thisItem.setClientFilename(newFileInfo.getClientFileName());
      thisItem.setFilename(newFileInfo.getRealFilename());
      thisItem.setVersion(Double.parseDouble(versionId));
      thisItem.setSize(newFileInfo.getSize());
      
      recordInserted = thisItem.insertVersion(db);
      if (!recordInserted) {
        processErrors(context, thisItem.getErrors());
      }
      context.getRequest().setAttribute("pid", projectId);
      context.getRequest().setAttribute("fid", itemId);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      freeConnection(context, db);
    }

    if (errorMessage == null) {
      if (recordInserted) {
        return ("AddOK");
      } else {
        return (executeCommandAddVersion(context));
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
   *@since
   */
  public String executeCommandDetails(ActionContext context) {
	  
	if (!(hasPermission(context, "projects-documents-view"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;

    String projectId = (String)context.getRequest().getParameter("pid");
    if (projectId == null) {
      projectId = (String)context.getRequest().getAttribute("pid");
    }
    
    String itemId = (String)context.getRequest().getParameter("fid");

    Connection db = null;
    try {
      db = getConnection(context);
      Project thisProject = new Project(db, Integer.parseInt(projectId), getUserRange(context));
      thisProject.buildFileItemList(db);
      context.getRequest().setAttribute("Project", thisProject);
      context.getRequest().setAttribute("IncludeSection", ("file_details").toLowerCase());
      
      FileItem thisItem = new FileItem(db, Integer.parseInt(itemId), thisProject.getId());
      thisItem.buildVersionList(db);
      context.getRequest().setAttribute("FileItem", thisItem);
      
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Details", "");
    if (errorMessage == null) {
      return ("ProjectCenterOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }
  
  public String executeCommandDownload(ActionContext context) {
	  
	if (!(hasPermission(context, "projects-documents-view"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;

    String projectId = (String)context.getRequest().getParameter("pid");
    String itemId = (String)context.getRequest().getParameter("fid");
    String version = (String)context.getRequest().getParameter("ver");
    FileItem thisItem = null;
    
    Connection db = null;
    try {
      db = getConnection(context);
      Project thisProject = new Project(db, Integer.parseInt(projectId), getUserRange(context));
      thisItem = new FileItem(db, Integer.parseInt(itemId), thisProject.getId());
      if (version != null) {
        thisItem.buildVersionList(db);
      }
      context.getRequest().setAttribute("Project", thisProject);
      context.getRequest().setAttribute("IncludeSection", ("file_library").toLowerCase());
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    
    //Start the download
    try {
      FileItem itemToDownload = null;
      if (version == null) {
        itemToDownload = thisItem;
      } else {
        itemToDownload = thisItem.getVersion(Double.parseDouble(version));
      }
      
      itemToDownload.setEnteredBy(this.getUserId(context));
      String filePath = this.getPath(context, "projects", itemToDownload.getProjectId()) + getDatePath(itemToDownload.getModified()) + itemToDownload.getFilename();
      
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
      //User either cancelled the download or lost connection
    } catch (Exception e) {
      errorMessage = e;
      System.out.println(e.toString());
    } finally {
      this.freeConnection(context, db);
    }
    
    addModuleBean(context, "Details", "");
    if (errorMessage == null) {
      return ("-none-");
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
  public String executeCommandModify(ActionContext context) {
	  
	if (!(hasPermission(context, "projects-documents-edit"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;

    String projectId = (String)context.getRequest().getParameter("pid");
    String itemId = (String)context.getRequest().getParameter("fid");

    Connection db = null;
    try {
      db = getConnection(context);
      Project thisProject = new Project(db, Integer.parseInt(projectId), getUserRange(context));
      context.getRequest().setAttribute("Project", thisProject);
      context.getRequest().setAttribute("IncludeSection", ("file_modify").toLowerCase());
      
      FileItem thisItem = new FileItem(db, Integer.parseInt(itemId), thisProject.getId());
      thisItem.buildVersionList(db);
      context.getRequest().setAttribute("FileItem", thisItem);

    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Modify", "");
    if (errorMessage == null) {
      return ("ProjectCenterOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }
  
  public String executeCommandUpdate(ActionContext context) {
	  
	if (!(hasPermission(context, "projects-documents-edit"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    boolean recordInserted = false;

    String projectId = (String)context.getRequest().getParameter("pid");
    String itemId = (String)context.getRequest().getParameter("fid");
    String subject = (String)context.getRequest().getParameter("subject");
    String filename = (String)context.getRequest().getParameter("clientFilename");

    Connection db = null;
    try {
      db = getConnection(context);
      Project thisProject = new Project(db, Integer.parseInt(projectId), getUserRange(context));
      context.getRequest().setAttribute("Project", thisProject);
      
      FileItem thisItem = new FileItem(db, Integer.parseInt(itemId), thisProject.getId());
      thisItem.setClientFilename(filename);
      thisItem.setSubject(subject);
      recordInserted = thisItem.update(db);

    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    
    addModuleBean(context, "Update", "");
    if (errorMessage == null) {
      if (recordInserted) {
        return ("UpdateOK");
      } else {
        context.getRequest().setAttribute("pid", projectId);
        context.getRequest().setAttribute("fid", itemId);
        return (executeCommandModify(context));
      }
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }
  
  public String executeCommandDelete(ActionContext context) {
	  
	if (!(hasPermission(context, "projects-documents-delete"))) {
	    return ("PermissionError");
    	}
	
    Exception errorMessage = null;
    boolean recordDeleted = false;

    String projectId = (String)context.getRequest().getParameter("pid");
    String itemId = (String)context.getRequest().getParameter("fid");

    Connection db = null;
    try {
      db = getConnection(context);
      Project thisProject = new Project(db, Integer.parseInt(projectId), getUserRange(context));
      context.getRequest().setAttribute("Project", thisProject);
      context.getRequest().setAttribute("pid", projectId);
      
      FileItem thisItem = new FileItem(db, Integer.parseInt(itemId), thisProject.getId());
      if (thisItem.getEnteredBy() == this.getUserId(context)) {
        recordDeleted = thisItem.delete(db, this.getPath(context, "projects", thisItem.getProjectId()));
      }

    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    
    addModuleBean(context, "Delete", "");
    if (errorMessage == null) {
      if (recordDeleted) {
        return ("DeleteOK");
      } else {
        return ("DeleteERROR");
      }
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }

}

