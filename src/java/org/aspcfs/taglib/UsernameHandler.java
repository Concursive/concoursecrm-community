package org.aspcfs.taglib;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;
import org.aspcfs.modules.admin.base.User;
import org.aspcfs.modules.contacts.base.Contact;
import org.aspcfs.controller.SystemStatus;
import com.darkhorseventures.database.ConnectionElement;
import java.util.*;

/**
 *  This Class evaluates a User ID and returns a Contact record from application
 *  scope.
 *
 *@author     matt rajkowski
 *@created    December 14, 2001
 *@version    $Id: UsernameHandler.java,v 1.3 2002/12/23 16:12:28 mrajkowski Exp
 *      $
 */
public class UsernameHandler extends TagSupport {

  private int userId = -1;
  private boolean lastFirst = false;


  /**
   *  Sets the Id attribute of the UsernameHandler object
   *
   *@param  tmp  The new Id value
   *@since
   */
  public void setId(String tmp) {
    this.userId = Integer.parseInt(tmp);
  }


  /**
   *  Sets the id attribute of the UsernameHandler object
   *
   *@param  tmp  The new id value
   */
  public void setId(int tmp) {
    this.userId = tmp;
  }


  /**
   *  Sets the lastFirst attribute of the UsernameHandler object
   *
   *@param  tmp  The new lastFirst value
   */
  public void setLastFirst(String tmp) {
    this.lastFirst = "true".equals(tmp);
  }


  /**
   *  Description of the Method
   *
   *@return                   Description of the Returned Value
   *@exception  JspException  Description of Exception
   *@since
   */
  public int doStartTag() throws JspException {
    try {
      ConnectionElement ce = (ConnectionElement) pageContext.getSession().getAttribute("ConnectionElement");
      if (ce == null) {
        System.out.println("UsernameHandler-> ConnectionElement is null");
      }
      SystemStatus systemStatus = (SystemStatus) ((Hashtable) pageContext.getServletContext().getAttribute("SystemStatus")).get(ce.getUrl());
      if (systemStatus == null) {
        System.out.println("UsernameHandler-> SystemStatus is null");
      }
      User thisUser = systemStatus.getUser(userId);
      if (thisUser != null) {
        Contact thisContact = thisUser.getContact();
        if (lastFirst) {
          this.pageContext.getOut().write(thisContact.getNameLastFirst());
        } else {
          this.pageContext.getOut().write(thisContact.getNameFirstLast());
        }
      } else {
        System.out.println("UsernameHandler-> User is null");
        this.pageContext.getOut().write("");
      }
    } catch (Exception e) {
      throw new JspException("UsernameHandler-> Error: " + e.getMessage());
    }
    return SKIP_BODY;
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Return Value
   */
  public int doEndTag() {
    return EVAL_PAGE;
  }

}

