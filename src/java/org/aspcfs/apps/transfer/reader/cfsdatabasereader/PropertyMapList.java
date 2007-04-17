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
package org.aspcfs.apps.transfer.reader.cfsdatabasereader;

import org.apache.log4j.Logger;
import org.aspcfs.apps.transfer.DataRecord;
import org.aspcfs.apps.transfer.DataWriter;
import org.aspcfs.utils.ObjectUtils;
import org.aspcfs.utils.XMLUtils;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import java.io.File;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;

/**
 * Contains a list of PropertyMaps, used to translate objects into XML
 *
 * @author matt rajkowski
 * @version $Id: PropertyMapList.java,v 1.14.2.1 2003/01/22 23:08:55 akhi_m
 *          Exp $
 * @created September 18, 2002
 */
public class PropertyMapList extends HashMap {

  private int count = 0;
  private static Logger logger = Logger.getLogger(org.aspcfs.apps.transfer.reader.cfsdatabasereader.PropertyMapList.class);


  /**
   * Constructor for the PropertyMapList object
   */
  public PropertyMapList() {
  }


  /**
   * Constructor for the PropertyMapList object
   *
   * @param configFile Description of the Parameter
   * @param modules    Description of the Parameter
   * @throws Exception Description of the Exception
   */
  public PropertyMapList(String configFile, ArrayList modules) throws Exception {
    loadMap(configFile, modules);
  }


  /**
   * Populates this object by reading an XML file with mappings
   *
   * @param mapFile Description of the Parameter
   * @param modules Description of the Parameter
   * @throws Exception Description of the Exception
   */
  public void loadMap(String mapFile, ArrayList modules) throws Exception {
    File configFile = new File(mapFile);
    XMLUtils xml = new XMLUtils(configFile);

    xml.getAllChildrenText(xml.getFirstChild("processes"), "module", modules);
    logger.info("PropertyMapList module count: " + modules.size());

    ArrayList mapElements = new ArrayList();
    XMLUtils.getAllChildren(xml.getFirstChild("mappings"), "map", mapElements);
    Iterator mapItems = mapElements.iterator();
    while (mapItems.hasNext()) {
      //Get the map node
      Element map = (Element) mapItems.next();
      PropertyMap mapProperties = new PropertyMap();
      mapProperties.setId((String) map.getAttribute("id"));
      mapProperties.setTable((String) map.getAttribute("table"));
      mapProperties.setSequence((String) map.getAttribute("sequence"));
      mapProperties.setUniqueField((String) map.getAttribute("uniqueField"));

      if (map.getAttribute("extends") != null) {
        //referred mapping's properties need to be included for this map
        PropertyMap extendsMap = getMap((String) map.getAttribute("extends"));
        if (extendsMap != null) {
          Iterator j = extendsMap.iterator();
          while (j.hasNext()) {
            Property thisProperty = (Property) j.next();
            mapProperties.add(thisProperty);
          }
        }
      }
      
      //Get any property nodes
      NodeList nl = map.getChildNodes();
      for (int i = 0; i < nl.getLength(); i++) {
        Node n = nl.item(i);
        if (n.getNodeType() == Node.ELEMENT_NODE && ((Element) n).getTagName().equals(
            "property")) {
          String nodeText = XMLUtils.getNodeText((Element) n);
          Property thisProperty = null;
          if (nodeText != null) {
            thisProperty = new Property(nodeText);
          } else {
            thisProperty = new Property();
          }
          String lookupValue = ((Element) n).getAttribute("lookup");
          if (lookupValue != null && !"".equals(lookupValue)) {
            thisProperty.setLookupValue(lookupValue);
          }
          String alias = ((Element) n).getAttribute("alias");
          if (alias != null && !"".equals(alias)) {
            thisProperty.setAlias(alias);
          }
          String field = ((Element) n).getAttribute("field");
          if (field != null && !"".equals(field)) {
            thisProperty.setField(field);
          }
          String value = ((Element) n).getAttribute("value");
          if (value != null && !"".equals(value)) {
            thisProperty.setValue(value);
          }
          String type = ((Element) n).getAttribute("type");
          if (type != null && !"".equals(type)) {
            thisProperty.setType(type);
          }
          String allowNull = ((Element) n).getAttribute("allowNull");
          if (allowNull != null && !"".equals(allowNull)) {
            thisProperty.setAllowNull(allowNull);
          }
          String defaultValue = ((Element) n).getAttribute("default");
          if (defaultValue != null && !"".equals(defaultValue)) {
            thisProperty.setDefaultValue(defaultValue);
          }
          String size = ((Element) n).getAttribute("size");
          if (size != null && !"".equals(size)) {
            thisProperty.setSize(size);
          }
          mapProperties.add(thisProperty);
        }
      }
      if (this.containsKey(map.getAttribute("class"))) {
        this.put((String) map.getAttribute("class") + ++count, mapProperties);
      } else {
        this.put((String) map.getAttribute("class"), mapProperties);
      }
    }

    /*
    //A mappings file may further refer to other config files that have mappings
    if (xml.getFirstChild("configs") != null) {
      ArrayList configs = new ArrayList();
      xml.getAllChildrenText(xml.getFirstChild("configs"), "config", configs);
      if (configs.size() > 0) {
        logger.info("PropertyMapList config count: " + configs.size());
        Iterator config = configs.iterator();
        while (config.hasNext()) {
          String configName = (String) config.next();
          loadMap(
            (configFile.getParentFile().getPath() + 
              System.getProperty("file.separator") + 
                configName), modules);
        }
      }
    }
    */
  }


  /**
   * Creates a DataRecord object by comparing and extracting properties from an
   * object that must be in the loaded mappings
   *
   * @param object Description of the Parameter
   * @param action Description of the Parameter
   * @return Description of the Return Value
   */
  public DataRecord createDataRecord(Object object, String action) {
    if (this.containsKey(object.getClass().getName())) {
      PropertyMap thisMap = (PropertyMap) this.get(
          object.getClass().getName());
      DataRecord record = new DataRecord();
      record.setName(thisMap.getId());
      record.setAction(action);
      //Go through each property map and get the corresponding data from the object
      Iterator properties = thisMap.iterator();
      while (properties.hasNext()) {
        Property thisProperty = (Property) properties.next();
        if (thisProperty.getLookupValue() != null && "-1".equals(
            ObjectUtils.getParam(object, thisProperty.getName()))) {
          //Looking up a -1 is not helpful and will cause the server to
          //reject the transaction
        } else {
          if (thisProperty.hasValue()) {
            record.addField(
                thisProperty.getName(), thisProperty.getValue(), thisProperty.getLookupValue(), thisProperty.getAlias());
          } else {
            record.addField(
                thisProperty.getName(), ObjectUtils.getParam(
                object, thisProperty.getName()), thisProperty.getLookupValue(), thisProperty.getAlias());
          }
        }
      }
      return record;
    } else {
      logger.info("PropertyMapList-> Object mapping not found");
      return null;
    }
  }


  /**
   * Writes all of the objects in the supplied list to a writer by converting
   * them to Data Record objects first
   *
   * @param writer Description of the Parameter
   * @param list   Description of the Parameter
   * @param action Description of the Parameter
   * @return Description of the Return Value
   */
  public boolean saveList(DataWriter writer, AbstractList list, String action) {
    logger.info(
        "Class: " + list.getClass().getName() + " Record count: " + list.size());
    boolean processOK = true;
    Iterator i = list.iterator();
    while (i.hasNext() && processOK) {
      Object object = i.next();
      logger.info("Object: " + object.getClass().getName());
      DataRecord thisRecord = createDataRecord(object, action);
      processOK = writer.save(thisRecord);
    }
    return processOK;
  }


  /**
   * Gets the map attribute of the PropertyMapList object
   *
   * @param mapId Description of the Parameter
   * @return The map value
   */
  public PropertyMap getMap(String mapId) {
    Iterator maps = this.keySet().iterator();
    while (maps.hasNext()) {
      String thisMapName = (String) maps.next();
      PropertyMap thisMap = (PropertyMap) this.get(thisMapName);
      if (mapId.equals(thisMap.getId())) {
        return thisMap;
      }
    }
    return null;
  }
}

