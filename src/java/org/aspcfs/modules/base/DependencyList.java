package com.darkhorseventures.cfsbase;

import java.util.*;

/**
 *  Description of the Class
 *
 *@author     Mathur
 *@created    December 18, 2002
 *@version    $Id$
 */
public class DependencyList extends ArrayList {
  private String title = null;


  /**
   *  Sets the title attribute of the DependencyList object
   *
   *@param  title  The new title value
   */
  public void setTitle(String title) {
    this.title = title;
  }


  /**
   *  Gets the title attribute of the DependencyList object
   *
   *@return    The title value
   */
  public String getTitle() {
    return title;
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Return Value
   */
  public boolean canDelete() {
    Iterator thisList = this.iterator();
    boolean canDelete = true;
    while (thisList.hasNext()) {
      Dependency thisDependency = (Dependency) thisList.next();
      if (!thisDependency.getCanDelete() && thisDependency.getCount() > 0) {
        canDelete = false;
      }
    }
    return canDelete;
  }


  /**
   *  Gets the htmlString attribute of the DependencyList object
   *
   *@return    The htmlString value
   */
  public String getHtmlString() {
    boolean canDelete = this.canDelete();
    Iterator i = this.iterator();
    StringBuffer html = new StringBuffer();
    html.append("<br>");
    while (i.hasNext()) {
      Dependency thisDependency = (Dependency) i.next();
      if (canDelete) {
        html.append("&nbsp;&nbsp;");
        html.append("- ");
        html.append(thisDependency.getName() + " (" + thisDependency.getCount() + ")");
        html.append("<br>");
      } else if (!thisDependency.getCanDelete()) {
        html.append("&nbsp;&nbsp;");
        html.append("- ");
        html.append(thisDependency.getName() + " (" + thisDependency.getCount() + ")");
        html.append("<br>");
      }
    }
    return html.toString();
  }
}

