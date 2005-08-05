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
package com.darkhorseventures.framework.actions;

import java.io.Serializable;

/**
 * This class represents a single resource that is stored in the <code>Map
 * </code>for resources resource table. Each resource is the name of a resource
 * to forward to, and possibly the name of an XSL style-sheet to use to
 * transform the resource into a specific format, such as HTML, or XML
 *
 * @author kevin
 * @version $Id$
 * @created October 8, 2000
 */
public class Resource
    implements Serializable {
  private String resourceName = "";
  private String resourceXSL = "";
  private String layoutType = null;
  final static long serialVersionUID = 7269086432553620255L;


  /**
   * Constructor for the Resource object
   *
   * @param name Description of Parameter
   * @param xsl  Description of Parameter
   */
  public Resource(String name, String xsl) {
    resourceName = name;
    resourceXSL = xsl;
  }


  /**
   * Constructor for the Resource object
   *
   * @param name   Description of Parameter
   * @param xsl    Description of Parameter
   * @param layout Description of Parameter
   * @since 1.1
   */
  public Resource(String name, String xsl, String layout) {
    resourceName = name;
    resourceXSL = xsl;
    layoutType = layout;
  }


  /**
   * Return the name of the resource (usually the path/*.jsp JSP page name)
   *
   * @return The Name value
   */
  public String getName() {
    return resourceName;
  }


  /**
   * Returns the name of the XSL to use (usually the path/*.xsl name)
   *
   * @return The XSL value
   */
  public String getXSL() {
    return resourceXSL;
  }


  /**
   * Returns the name of the layout to use
   *
   * @return The layout value
   */
  public String getLayout() {
    return layoutType;
  }
}

