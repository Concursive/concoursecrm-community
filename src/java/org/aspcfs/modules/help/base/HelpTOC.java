//Copyright 2003 Dark Horse Ventures

package org.aspcfs.modules.help.base;

import com.darkhorseventures.framework.beans.*;
import java.sql.*;
import org.aspcfs.utils.DatabaseUtils;
import java.io.*;
import java.util.*;
import java.text.*;

/**
 *  Description of the Class
 *
 *@author     kbhoopal
 *@created    November 11, 2003
 *@version    $Id$
 */
public class HelpTOC extends GenericBean {

  private HelpTableOfContents contentList;
  private HelpTableOfContents childList;
  private HelpTableOfContents topLevelList;


  /**
   *  Constructor for the HelpTOC object
   */
  public HelpTOC() { }


  /**
   *  Constructor for the HelpTOC object
   *
   *@param  db                Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public HelpTOC(Connection db) throws SQLException {
    contentList = new HelpTableOfContents(db);
  }


  /**
   *  Sets the contentList attribute of the HelpTOC object
   *
   *@param  tmp  The new contentList value
   */
  public void setContentList(HelpTableOfContents tmp) {
    this.contentList = tmp;
  }


  /**
   *  Sets the childList attribute of the HelpTOC object
   *
   *@param  tmp  The new childList value
   */
  public void setChildList(HelpTableOfContents tmp) {
    this.childList = tmp;
  }


  /**
   *  Sets the topLevelList attribute of the HelpTOC object
   *
   *@param  tmp  The new topLevelList value
   */
  public void setTopLevelList(HelpTableOfContents tmp) {
    this.topLevelList = tmp;
  }


  /**
   *  Gets the contentList attribute of the HelpTOC object
   *
   *@return    The contentList value
   */
  public HelpTableOfContents getContentList() {
    return contentList;
  }


  /**
   *  Gets the childList attribute of the HelpTOC object
   *
   *@param  id  Description of the Parameter
   *@return     The childList value
   */
  public HelpTableOfContents getChildList(int id) {
    childList = new HelpTableOfContents();
    childList.buildChildren(id, contentList);
    return childList;
  }


  /**
   *  Gets the topLevelList attribute of the HelpTOC object
   *
   *@return    The topLevelList value
   */
  public HelpTableOfContents getTopLevelList() {
    topLevelList = new HelpTableOfContents();
    topLevelList.buildTopLevelList(contentList);
    return topLevelList;
  }
}

