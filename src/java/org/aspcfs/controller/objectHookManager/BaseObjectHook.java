package org.aspcfs.controller.objectHookManager;

/**
 *  All base object hooks to be executed need to implement this class
 *
 *@author     matt rajkowski
 *@created    October 14, 2002
 *@version    $Id: BaseObjectHook.java,v 1.2 2002/10/21 19:47:58 mrajkowski Exp
 *      $
 */
public interface BaseObjectHook {
  /**
   *  Let the hook manager know if a connection is required for this hook.
   *
   *@return    Description of the Return Value
   */
  public boolean requiresConnection();


  /**
   *  Sets the connection attribute of the BaseObjectHook object if needed
   *
   *@param  tmp  The new connection value
   */
  public void setConnection(java.sql.Connection tmp);


  /**
   *  Sets the previousObject attribute of the BaseObjectHook object for
   *  comparing previous properties
   *
   *@param  tmp  The new previousObject value
   */
  public void setPreviousObject(Object tmp);


  /**
   *  Sets the currentObject attribute of the BaseObjectHook object
   *
   *@param  tmp  The new currentObject value
   */
  public void setCurrentObject(Object tmp);


  /**
   *  Sets the fileLibraryPath attribute of the BaseObjectHook object
   *
   *@param  tmp  The new fileLibraryPath value
   */
  public void setFileLibraryPath(String tmp);


  /**
   *  Method that gets executed when an object has been inserted
   */
  public void processInsert();


  /**
   *  Method that gets executed when an object has been updated
   */
  public void processUpdate();


  /**
   *  Method that gets executed when an object has been deleted
   */
  public void processDelete();
}

