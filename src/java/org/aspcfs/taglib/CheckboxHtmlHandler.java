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
package org.aspcfs.taglib;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

/**
 *  This tag returns an HTML checkbox string based on the given parameters.
 *
 *@author     matt rajkowski
 *@created    August 13, 2003
 *@version    $Id: CheckboxHtmlHandler.java,v 1.3 2004/06/30 15:24:37 mrajkowski
 *      Exp $
 */
public class CheckboxHtmlHandler extends TagSupport {

  private String name = null;
  private String value = null;
  private boolean checked = false;


  /**
   *  Sets the name attribute of the CheckboxHtmlHandler object
   *
   *@param  tmp  The new name value
   */
  public void setName(String tmp) {
    this.name = tmp;
  }


  /**
   *  Sets the value attribute of the CheckboxHtmlHandler object
   *
   *@param  tmp  The new value value
   */
  public void setValue(String tmp) {
    this.value = tmp;
  }


  /**
   *  Sets the checked attribute of the CheckboxHtmlHandler object
   *
   *@param  tmp  The new checked value
   */
  public final void setChecked(boolean tmp) {
    checked = tmp;
  }


  /**
   *  Sets the checked attribute of the CheckboxHtmlHandler object
   *
   *@param  tmp  The new checked value
   */
  public final void setChecked(String tmp) {
    checked = "true".equalsIgnoreCase(tmp);
  }


  /**
   *  Description of the Method
   *
   *@return                   Description of the Return Value
   *@exception  JspException  Description of the Exception
   */
  public int doStartTag() throws JspException {
    try {
      this.pageContext.getOut().write(
          "<input type=\"checkbox\" name=\"" + name + "\"" +
          (value != null ? " value=\"" + value + "\"" : "") +
          (checked ? " checked" : "") + " />");
    } catch (Exception e) {
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

