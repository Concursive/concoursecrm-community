package com.darkhorseventures.taglib;

import javax.servlet.jsp.*;
import javax.servlet.jsp.tagext.*;

/**
 *  This Class evaluates whether an expression is true, then includes the body.
 *
 *@author     Matt Rajkowski
 *@created    April 2, 2002
 *@version    $Id$
 */
public class EvaluateHandler extends TagSupport {
  private boolean result = false;


  /**
   *  Sets the exp attribute of the EvaluateHandler object
   *
   *@param  tmp  The new exp value
   */
  public final void setExp(boolean tmp) {
    result = tmp;
  }


  /**
   *  Sets the expression attribute of the EvaluateHandler object
   *
   *@param  tmp  The new expression value
   */
  public final void setExp(String tmp) {
    if (System.getProperty("DEBUG") != null) {
      System.out.println("EvaluateHandler: Input-> " + tmp);
    }
    result = "true".equalsIgnoreCase(tmp);
  }
  
  public final void setIf(boolean tmp) {
    this.setExp(tmp);
  }

  public final void setIf(String tmp) {
    this.setExp(tmp);
  }

  /**
   *  Description of the Method
   *
   *@return                   Description of the Returned Value
   *@exception  JspException  Description of Exception
   */
  public final int doStartTag() throws JspException {
    if (result) {
      return EVAL_BODY_INCLUDE;
    } else {
      return SKIP_BODY;
    }
  }

}

