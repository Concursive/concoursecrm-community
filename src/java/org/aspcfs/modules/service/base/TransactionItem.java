package com.darkhorseventures.utils;

import java.util.*;
import org.w3c.dom.*;
import java.sql.*;
import java.lang.reflect.*;
import com.darkhorseventures.cfsbase.*;
import com.darkhorseventures.utils.ObjectUtils;
import com.darkhorseventures.webutils.PagedListInfo;

/**
 *  Every Transaction can be made of many TransactionItems. TransactionItems
 *  represent objects in which a method will be called upon.<p>
 *
 *  Example:<br>
 *  The TransactionItem is to insert an Organization. So, the object is
 *  Organization, the action is an INSERT, the meta property contains fields
 *  that are to be returned after the insert is executed, any errors that occur
 *  are placed in the errorMessage property.
 *
 *@author     matt
 *@created    April 10, 2002
 *@version    $Id: TransactionItem.java,v 1.13 2002/04/24 15:39:44 mrajkowski
 *      Exp $
 */
public class TransactionItem {

  //Requested object actions
  private final static byte INSERT = 1;
  private final static byte SELECT = 2;
  private final static byte UPDATE = 3;
  private final static byte DELETE = 4;
  private final static byte SYNC = 5;
  private final static byte SYNC_START = 6;
  private final static byte SYNC_END = 7;
  private final static byte SYNC_DELETE = 8;
  private final static byte GET_DATETIME = 9;

  private String name = null;
  private Object object = null;
  private int action = -1;
  private int identity = -1;
  private PagedListInfo pagedListInfo = null;
  private StringBuffer errorMessage = new StringBuffer();
  private RecordList recordList = null;
  private TransactionMeta meta = null;
  private HashMap ignoredProperties = null;


  /**
   *  Constructor for the TransactionItem object
   */
  public TransactionItem() { }


  /**
   *  Constructor a TransactionItem Object from an XML element, using the
   *  supplied mapping to translate the XML element tag name to a Class.
   *
   *@param  objectElement  Description of Parameter
   *@param  mapping        Description of Parameter
   */
  public TransactionItem(Element objectElement, HashMap mapping) {
    try {
      this.setAction(objectElement);
      this.setObject(objectElement, mapping);
      ignoredProperties = XMLUtils.populateObject(object, objectElement);
    } catch (Exception e) {
      if (System.getProperty("DEBUG") != null) {
        System.out.println("TransactionItem-> Cannot create: " + objectElement.getTagName());
        e.printStackTrace(System.out);
      }
      appendErrorMessage("Invalid element: " + objectElement.getTagName());
    }
  }


  /**
   *  Adds property names and values to the Record object, based on the supplied
   *  meta data
   *
   *@param  thisRecord  The feature to be added to the Fields attribute
   *@param  thisMeta    The feature to be added to the Fields attribute
   *@param  thisObject  The feature to be added to the Fields attribute
   */
  public void addFields(Record thisRecord, TransactionMeta thisMeta, Object thisObject, HashMap mapping, SyncClientMap syncClientMap, Connection db) throws SQLException {
    if (thisMeta != null && thisMeta.getFields() != null) {
      Iterator fields = thisMeta.getFields().iterator();
      while (fields.hasNext()) {
        String thisField = (String) fields.next();
        String thisValue = null;
        if (thisField.endsWith("Guid")) {
          String param = thisField.substring(0, thisField.indexOf("Guid"));
          SyncTable referencedTable = (SyncTable)mapping.get(param + "List");
          if (referencedTable != null) {
            int recordId = syncClientMap.lookupId(db, referencedTable.getId(), 
              ObjectUtils.getParam(thisObject, param + "Id"));
            thisValue = String.valueOf(recordId);
          }
        } else {
          thisValue = ObjectUtils.getParam(thisObject, thisField);
        }
        if (thisValue == null) {
          thisValue = "";
        }
        thisRecord.put(thisField, thisValue);
      }
      thisRecord.setRecordId(ObjectUtils.getParam(thisObject, "id"));
      if (thisRecord.containsKey("guid")) {
        thisRecord.put("guid", String.valueOf(identity++));
      }
    }
  }


  /**
   *  Sets the object attribute of the TransactionItem object
   *
   *@param  tmp  The new object value
   */
  public void setObject(Object tmp) {
    object = tmp;
  }


  /**
   *  Sets the object attribute of the TransactionItem object from XML based on
   *  the mapping data. If the element tag is "contact" and there is a mapping
   *  to "com.darkhorseventures.cfsbase.Contact", then the Object is created and
   *  populated from the XML.
   *
   *@param  element        The new object value
   *@param  mapping        The new object value
   *@exception  Exception  Description of Exception
   */
  public void setObject(Element element, HashMap mapping) throws Exception {
    name = element.getTagName();
    if (mapping.containsKey(name)) {
      object = Class.forName(((SyncTable) mapping.get(name)).getMappedClassName()).newInstance();
      if (System.getProperty("DEBUG") != null) {
        System.out.println("TransactionItem-> New: " + object.getClass().getName());
      }
    }
  }


  /**
   *  Sets the action attribute of the TransactionItem object
   *
   *@param  tmp  The new action value
   */
  public void setAction(int tmp) {
    action = tmp;
  }


  /**
   *  Determines the methods that are allowed from a specified action. These are
   *  the methods that can be executed on the new Object.
   *
   *@param  tmp  The new action value
   */
  public void setAction(String tmp) {
    if ("insert".equals(tmp)) {
      setAction(this.INSERT);
    } else if ("update".equals(tmp)) {
      setAction(this.UPDATE);
    } else if ("select".equals(tmp)) {
      setAction(this.SELECT);
    } else if ("delete".equals(tmp)) {
      setAction(this.DELETE);
    } else if ("sync".equals(tmp)) {
      setAction(this.SYNC);
    } else if ("syncStart".equals(tmp)) {
      setAction(this.SYNC_START);
    } else if ("syncEnd".equals(tmp)) {
      setAction(this.SYNC_END);
    } else if ("getDateTime".equals(tmp)) {
      setAction(this.GET_DATETIME);
    }
  }


  /**
   *  Sets the action attribute of the TransactionItem object
   *
   *@param  objectElement  The new action value
   */
  public void setAction(Element objectElement) {
    if (objectElement.hasAttributes()) {
      String thisAction = objectElement.getAttribute("type");
      if (thisAction == null || thisAction.trim().equals("")) {
        thisAction = objectElement.getAttribute("action");
      }
      String thisIdentity = objectElement.getAttribute("identity");
      try {
        identity = Integer.parseInt(thisIdentity);
      } catch (Exception e) {
      }
      String thisCurrentOffset = objectElement.getAttribute("offset");
      String thisItemsPerPage = objectElement.getAttribute("items");
      if ((thisCurrentOffset != null && !"".equals(thisCurrentOffset)) ||
         (thisItemsPerPage != null && !"".equals(thisItemsPerPage)))  {
        pagedListInfo = new PagedListInfo();
        pagedListInfo.setItemsPerPage(thisItemsPerPage);
        pagedListInfo.setCurrentOffset(thisCurrentOffset);
      }
      this.setAction(thisAction);
    }
  }


  /**
   *  Sets the meta attribute of the TransactionItem object
   *
   *@param  tmp  The new meta value
   */
  public void setMeta(TransactionMeta tmp) {
    this.meta = tmp;
  }


  /**
   *  Gets the errorMessage attribute of the TransactionItem object
   *
   *@return    The errorMessage value
   */
  public String getErrorMessage() {
    return (errorMessage.toString());
  }


  /**
   *  Gets the name attribute of the TransactionItem object
   *
   *@return    The name value
   */
  public String getName() {
    return name;
  }


  /**
   *  Gets the object attribute of the TransactionItem object
   *
   *@return    The object value
   */
  public Object getObject() {
    return object;
  }


  /**
   *  Gets the recordList attribute of the TransactionItem object
   *
   *@return    The recordList value
   */
  public RecordList getRecordList() {
    return recordList;
  }


  /**
   *  Gets the meta attribute of the TransactionItem object
   *
   *@return    The meta value
   */
  public TransactionMeta getMeta() {
    return meta;
  }


  /**
   *  Description of the Method
   *
   *@param  db                Description of Parameter
   *@param  record            Description of Parameter
   *@param  syncClientMap     Description of Parameter
   *@exception  SQLException  Description of Exception
   */
  public void insertClientMapping(Connection db, SyncClientMap syncClientMap,
      Record record) throws SQLException {
    syncClientMap.setRecordId(record.getRecordId());
    syncClientMap.setClientUniqueId((String) record.get("guid"));
    syncClientMap.insert(db);
  }


  /**
   *  Assumes that the Object has already been built and populated, now the
   *  specified action will be executed. A database connection is passed along
   *  since the Object will need it.<p>
   *
   *  Data can be selected, inserted, updated, deleted, and synchronized with
   *  client systems.
   *
   *@param  db             Description of Parameter
   *@param  auth           Description of Parameter
   *@param  mapping        Description of Parameter
   *@exception  Exception  Description of Exception
   */
  public void execute(Connection db, AuthenticationItem auth, HashMap mapping) throws Exception {
    if (System.getProperty("DEBUG") != null) {
      System.out.println("TransactionItem-> Executing transaction");
    }
    if ((object == null || name == null) && !"system".equals(name)) {
      appendErrorMessage("Unsupported object specified");
      return;
    }

    SyncClientMap syncClientMap = new SyncClientMap();
    syncClientMap.setClientId(auth.getClientId());
    if (!"system".equals(name)) {
      syncClientMap.setTableId(((SyncTable) mapping.get(name)).getId());
    }

    if (recordList == null) {
      recordList = new RecordList(name);
    }
    
    if (pagedListInfo != null) {
      doSetPagedListInfo();
    }

    if (action == GET_DATETIME) {
      Record thisRecord = new Record("info");
      thisRecord.put("dateTime", String.valueOf(new java.sql.Timestamp(new java.util.Date().getTime())));
      recordList.add(thisRecord);
    } else if (action == SYNC_START) {
      ObjectUtils.setParam(object, "id", String.valueOf(auth.getClientId()));
      ObjectUtils.setParam(object, "anchor", auth.getLastAnchor());
      if (!((SyncClient) object).checkNormalSync(db)) {
        appendErrorMessage("Client and server not in sync!");
      }
    } else if (action == SYNC_END) {
      ObjectUtils.setParam(object, "id", String.valueOf(auth.getClientId()));
      ObjectUtils.setParam(object, "anchor", auth.getNextAnchor());
      ((SyncClient) object).updateSyncAnchor(db);
    } else if (action == SYNC) {
      ObjectUtils.setParam(object, "lastAnchor", auth.getLastAnchor());
      ObjectUtils.setParam(object, "nextAnchor", auth.getNextAnchor());
      setGuidParameters(db, mapping, syncClientMap);
      //Build inserts for client
      if (auth.getNextAnchor() != null) {
        addRecords(object, db, Constants.SYNC_INSERTS, mapping, syncClientMap);
        Iterator syncRecords = recordList.iterator();
        while (syncRecords.hasNext()) {
          Record thisRecord = (Record) syncRecords.next();
          this.insertClientMapping(db, syncClientMap, thisRecord);
        }
      }
      //Build updates for client
      if (auth.getLastAnchor() != null) {
        addRecords(object, db, Constants.SYNC_UPDATES, mapping, syncClientMap);
      }
    } else if (action == SYNC_DELETE) {
      //Build deletes for client
      String uniqueField = ObjectUtils.getParam(object, "uniqueField");
      String tableName = ObjectUtils.getParam(object, "tableName");
      PreparedStatement pst = null;
      ResultSet rs = syncClientMap.buildSyncDeletes(db, pst, uniqueField, tableName, recordList);
      while (rs.next()) {
        Record thisRecord = new Record("delete");
        int id = rs.getInt(uniqueField);
        java.sql.Timestamp entered = rs.getTimestamp("entered");
        int enteredBy = rs.getInt("enteredby");
        thisRecord.put("guid",
            ObjectUtils.generateGuid(entered, enteredBy, id));
        recordList.add(thisRecord);
      }
      rs.close();
      pst.close();
    } else {
      if (System.getProperty("DEBUG") != null) {
        System.out.println("TransactionItem-> Base request");
      }
      String executeMethod = null;
      switch (action) {
          case -1:
            appendErrorMessage("Action not specified");
            break;
          case INSERT:
            executeMethod = "insert";
            break;
          case UPDATE:
            executeMethod = "update";
            break;
          case DELETE:
            executeMethod = "delete";
            break;
          case SELECT:
            executeMethod = "select";
            break;
          default:
            appendErrorMessage("Unsupported action specified");
            break;
      }
      if (executeMethod != null) {
        if (action == INSERT) {
          //Populate any client GUIDs with the correct server ID
          setGuidParameters(db, mapping, syncClientMap);
        }
        Object result = doExecute(db, executeMethod);
        if (System.getProperty("DEBUG") != null) {
          System.out.println("TransactionItem-> " + object.getClass().getName() + " " + executeMethod);
        }
        if (action == INSERT) {
          //Insert the guid / id into client mapping
          if (ignoredProperties != null) {
            Iterator ignoredList = ignoredProperties.keySet().iterator();
            while (ignoredList.hasNext()) {
              String param = (String)ignoredList.next();
              if (param.equals("guid")) {
                syncClientMap.setRecordId( Integer.parseInt(ObjectUtils.getParam(object, "id")) );
                syncClientMap.setClientUniqueId((String)ignoredProperties.get(param));
                syncClientMap.insert(db);
                break;
              }
            }
          }
        }
        addRecords(object, recordList, null, mapping, syncClientMap, db);
      }
    }
    if (pagedListInfo != null) {
      recordList.setTotalRecords(pagedListInfo.getMaxRecords());
    }
  }

  private Object doExecute(Connection db, String executeMethod) throws Exception {
    Class[] dbClass = new Class[]{Class.forName("java.sql.Connection")};
    Object[] dbObject = new Object[]{db};
    Method method = object.getClass().getDeclaredMethod(executeMethod, dbClass);
    return(method.invoke(object, dbObject));
  }
  
  private void doSetPagedListInfo() {
    try {
      Class[] theClass = new Class[]{pagedListInfo.getClass()};
      Object[] theObject = new Object[]{pagedListInfo};
      Method method = object.getClass().getDeclaredMethod("setPagedListInfo", theClass);
      method.invoke(object, theObject);
    } catch (Exception e) {
      //This class must not support the pagedListInfo
      if (System.getProperty("DEBUG") != null) {
        System.out.println("TransactionItem-> Object does not have setPagedListInfo method");
      }
    }
  }

  /**
   *  Description of the Method
   *
   *@return    Description of the Returned Value
   */
  public boolean hasError() {
    return (errorMessage.length() > 0);
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Returned Value
   */
  public boolean hasRecordList() {
    return (recordList != null);
  }


  /**
   *  Description of the Method
   *
   *@param  tmp  Description of Parameter
   */
  public void appendErrorMessage(String tmp) {
    if (tmp != null) {
      if (errorMessage.length() > 0) {
        errorMessage.append(System.getProperty("line.separator"));
      }
      errorMessage.append(tmp);
    }
  }


  /**
   *  Adds a feature to the Records attribute of the TransactionItem object
   *
   *@param  object         The feature to be added to the Records attribute
   *@param  db             The feature to be added to the Records attribute
   *@param  syncType       The feature to be added to the Records attribute
   *@exception  Exception  Description of Exception
   */
  private void addRecords(Object object, Connection db, int syncType, HashMap mapping, SyncClientMap syncClientMap) throws Exception {
    PreparedStatement pst = null;
    Class[] dbClass = new Class[]{Class.forName("java.sql.Connection"), Class.forName("java.sql.PreparedStatement")};
    Object[] dbObject = new Object[]{db, pst};
    String executeMethod = "queryList";
    ObjectUtils.setParam(object, "syncType", String.valueOf(syncType));
    Method method = object.getClass().getDeclaredMethod(executeMethod, dbClass);
    Object result = method.invoke(object, dbObject);
    while (((ResultSet) result).next()) {
      String objectMethod = "getObject";
      Class[] rsClass = new Class[]{Class.forName("java.sql.ResultSet")};
      Object[] rsObject = new Object[]{result};
      Method getObject = object.getClass().getDeclaredMethod(objectMethod, rsClass);
      Object thisObject = getObject.invoke(object, rsObject);
      String recordAction = null;
      switch (syncType) {
          case Constants.SYNC_INSERTS:
            recordAction = "insert";
            break;
          case Constants.SYNC_UPDATES:
            recordAction = "update";
            break;
          default:
            break;
      }
      addRecords(thisObject, recordList, recordAction, mapping, syncClientMap, db);
    }
    ((ResultSet) result).close();
    if (pst != null) {
      pst.close();
    }
    ((java.util.AbstractList) object).clear();
  }
  
  /**
   *  Adds a feature to the Records attribute of the TransactionItem object
   *
   *@param  object        The feature to be added to the Records attribute
   *@param  recordList    The feature to be added to the Records attribute
   *@param  recordAction  The feature to be added to the Records attribute
   */
  private void addRecords(Object object, RecordList recordList, String recordAction, HashMap mapping, SyncClientMap syncClientMap, Connection db) throws SQLException {
    if (recordList != null) {
      //Need to see if the Object is a collection of Objects, otherwise
      //just process it as a single record.
      if (object instanceof java.util.AbstractList) {
        Iterator objectItems = ((java.util.AbstractList) object).iterator();
        while (objectItems.hasNext()) {
          Object objectItem = objectItems.next();
          Record thisRecord = new Record(recordAction);
          this.addFields(thisRecord, meta, objectItem, mapping, syncClientMap, db);
          recordList.add(thisRecord);
        }
      } else {
        Record thisRecord = new Record(recordAction);
        this.addFields(thisRecord, meta, object, mapping, syncClientMap, db);
        recordList.add(thisRecord);
      }
    }
  }
  
  private void setGuidParameters(Connection db, HashMap mapping, SyncClientMap syncClientMap) throws SQLException {
    if (ignoredProperties != null && ignoredProperties.size() > 0) {
      Iterator ignoredList = ignoredProperties.keySet().iterator();
      while (ignoredList.hasNext()) {
        String param = (String)ignoredList.next();
        if (param != null && param.endsWith("Guid")) {
          String value = (String)ignoredProperties.get(param);
          param = param.substring(0, param.indexOf("Guid"));
          SyncTable referencedTable = (SyncTable)mapping.get(param + "List");
          if (referencedTable != null) {
            int recordId = syncClientMap.lookupId(db, referencedTable.getId(), value);
            ObjectUtils.setParam(object, param + "Id", String.valueOf(recordId));
            if (System.getProperty("DEBUG") != null) {
              System.out.println("TransactionItem-> Setting new parameter: " + param + "Id");
            }
          } else {
            throw new SQLException("Sync reference does not exist, you must sync referenced tables first");
          }
        }
      }
    }
  }
  
  
}

