//Copyright 2002 Dark Horse Ventures
package org.aspcfs.apps.workFlowManager;

import java.util.*;
import org.w3c.dom.Element;
import org.aspcfs.utils.*;
import org.aspcfs.modules.base.Constants;
import java.io.*;

/**
 *  Contains a list of BusinessProcess objects and can be used for initially
 *  building the list.
 *
 *@author     matt rajkowski
 *@created    November 11, 2002
 *@version    $Id: BusinessProcessList.java,v 1.4 2003/01/13 21:41:16 mrajkowski
 *      Exp $
 */
public class BusinessProcessList extends HashMap {
  private int enabled = -1;


  /**
   *  Constructor for the BusinessProcessList object
   */
  public BusinessProcessList() { }


  /**
   *  Constructor for the BusinessProcessList object
   *
   *@param  processes  Description of the Parameter
   *@param  enabled    Description of the Parameter
   */
  public BusinessProcessList(Element processes, int enabled) {
    this.process(processes, enabled);
  }


  /**
   *  Description of the Method
   *
   *@param  xmlFile  Description of the Parameter
   */
  public void buildListTest(File xmlFile) {
    try {
      BufferedReader in = new BufferedReader(new FileReader(xmlFile));
      StringBuffer config = new StringBuffer();
      String text = null;
      while ((text = in.readLine()) != null) {
        config.append(text);
      }
      this.parse(config.toString());
    } catch (Exception e) {
    }
  }


  /**
   *  Description of the Method
   *
   *@param  processData  Description of the Parameter
   *@return              Description of the Return Value
   */
  public boolean parse(String processData) {
    if (processData == null) {
      return false;
    }
    try {
      XMLUtils xml = new XMLUtils(processData);
      return parse(xml.getDocumentElement());
    } catch (Exception e) {
      e.printStackTrace(System.out);
      return false;
    }
  }


  /**
   *  Description of the Method
   *
   *@param  element  Description of the Parameter
   *@return          Description of the Return Value
   */
  public boolean parse(Element element) {
    if (element == null) {
      return false;
    }
    try {
      Element processes = XMLUtils.getFirstElement(element, "processes");
      if (processes != null) {
        this.process(processes, Constants.TRUE);
      }
    } catch (Exception e) {
      e.printStackTrace(System.out);
      return false;
    }
    return true;
  }



  /**
   *  Description of the Method
   *
   *@param  processes  Description of the Parameter
   *@param  enabled    Description of the Parameter
   */
  private void process(Element processes, int enabled) {
    ArrayList processNodes = XMLUtils.getElements(processes, "process");
    Iterator processElements = processNodes.iterator();
    while (processElements.hasNext()) {
      Element processElement = (Element) processElements.next();
      String processEnabled = (String) processElement.getAttribute("enabled");
      if (enabled == Constants.TRUE && processEnabled != null && "false".equals(processEnabled)) {
        break;
      }
      BusinessProcess thisProcess = new BusinessProcess(processElement, enabled);
      this.put(thisProcess.getName(), thisProcess);
      if (System.getProperty("DEBUG") != null) {
        System.out.println("BusinessProcessList-> Added: " + thisProcess.getName());
      }
    }
  }
}

