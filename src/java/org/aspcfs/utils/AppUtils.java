package org.aspcfs.utils;

import java.io.*;
import java.util.*;
import org.w3c.dom.*;
import org.xml.sax.SAXException;
import javax.xml.parsers.*;

/**
 *  Description of the Class
 *
 *@author     matt rajkowski
 *@created    January 15, 2003
 *@version    $Id$
 */
public class AppUtils {

  /**
   *  Description of the Method
   *
   *@param  filename  Description of the Parameter
   *@param  config    Description of the Parameter
   *@return           Description of the Return Value
   */
  public static boolean loadConfig(String filename, HashMap config) {
    File file = new File(filename);
    if (file == null) {
      System.err.println("AppUtils-> Configuration file not found: " + filename);
      return false;
    }
    try {
      Document document = parseDocument(file);
      config.clear();
      NodeList tags = document.getElementsByTagName("init-param");
      for (int i = 0; i < tags.getLength(); i++) {
        Element tag = (Element) tags.item(i);
        NodeList params = tag.getChildNodes();
        String name = null;
        String value = null;
        for (int j = 0; j < params.getLength(); j++) {
          Node param = (Node) params.item(j);
          if (param.hasChildNodes()) {
            NodeList children = param.getChildNodes();
            Node thisNode = (Node) children.item(0);
            if (param.getNodeName().equals("param-name")) {
              name = thisNode.getNodeValue();
            }
            if (param.getNodeName().equals("param-value")) {
              value = thisNode.getNodeValue();
            }
          }
        }
        if (value == null) {
          value = "";
        }
        config.put(name, value);
      }
    } catch (Exception e) {
      e.printStackTrace();
      return false;
    }
    return true;
  }


  /**
   *  Description of the Method
   *
   *@param  file                              Description of the Parameter
   *@return                                   Description of the Return Value
   *@exception  FactoryConfigurationError     Description of the Exception
   *@exception  ParserConfigurationException  Description of the Exception
   *@exception  SAXException                  Description of the Exception
   *@exception  IOException                   Description of the Exception
   */
  private static Document parseDocument(File file)
       throws FactoryConfigurationError, ParserConfigurationException, SAXException, IOException {
    DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
    DocumentBuilder builder = factory.newDocumentBuilder();
    Document document = builder.parse(file);
    return document;
  }

}

