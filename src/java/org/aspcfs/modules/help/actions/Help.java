package org.aspcfs.modules.help.actions;

import javax.servlet.*;
import javax.servlet.http.*;
import com.darkhorseventures.framework.actions.*;
import org.aspcfs.modules.actions.CFSModule;
import org.aspcfs.modules.help.base.*;
import java.sql.*;

/**
 *  Help Module
 *
 *@author     mrajkowski
 *@created    January 21, 2002
 *@version    $Id$
 */
public final class Help extends CFSModule {

  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandDefault(ActionContext context) {
    Exception errorMessage = null;
    Connection db = null;
    try {
      String module = context.getRequest().getParameter("module");
      String section = context.getRequest().getParameter("section");
      String subsection = context.getRequest().getParameter("sub");
      db = this.getConnection(context);
      HelpItem thisItem = new HelpItem();
      thisItem.setModule(module);
      thisItem.setSection(section);
      thisItem.setSubsection(subsection);
      thisItem.processRecord(db, this.getUserId(context));
      context.getRequest().setAttribute("Help", thisItem);
    } catch (Exception e) {
      errorMessage = e;
      e.printStackTrace(System.out);
    } finally {
      this.freeConnection(context, db);
    }
    if (this.hasPermission(context, "help-edit")) {
      return ("ModifyOK");
    } else {
      return ("HelpOK");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandProcess(ActionContext context) {
    if (this.hasPermission(context, "help-edit")) {
      Exception errorMessage = null;
      Connection db = null;
      try {
        HelpItem thisItem = (HelpItem) context.getFormBean();
        db = this.getConnection(context);
        thisItem.setEnteredBy(this.getUserId(context));
        thisItem.setModifiedBy(this.getUserId(context));
        thisItem.update(db);
      } catch (Exception e) {
        errorMessage = e;
        e.printStackTrace(System.out);
      } finally {
        this.freeConnection(context, db);
      }
      return ("ProcessOK");
    } else {
      return ("UserError");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandViewAll(ActionContext context) {
    Exception errorMessage = null;
    Connection db = null;
    try {
      db = this.getConnection(context);
      HelpContents contents = new HelpContents();
      contents.build(db);
      context.getRequest().setAttribute("HelpContents", contents);
    } catch (Exception e) {
      errorMessage = e;
      e.printStackTrace(System.out);
    } finally {
      this.freeConnection(context, db);
    }
    return ("ViewAllOK");
  }
}

