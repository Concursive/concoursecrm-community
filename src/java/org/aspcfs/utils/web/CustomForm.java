package com.darkhorseventures.controller;

import com.darkhorseventures.cfsbase.CustomFieldCategory;
import com.darkhorseventures.cfsbase.CustomField;
import com.darkhorseventures.controller.*;
import java.util.*;
import com.darkhorseventures.utils.ObjectUtils;
import com.darkhorseventures.utils.StringUtils;

/**
 *  Represents an HTML Form in which items are dynamically added in code
 *
 *@author     chris price
 *@created    August 8, 2002
 *@version    $Id$
 */
public class CustomForm extends CustomFieldCategory {

  private String action = null;
  private String cancel = null;
  private boolean reset = false;
  private String selectedTabName = "";
  private int selectedTabId = 0;
  private StringBuffer jScripts = new StringBuffer();
  private StringBuffer jsFormCheck = new StringBuffer();
  private StringBuffer jsTabCheck = new StringBuffer();
  private LinkedHashMap buttonList = new LinkedHashMap();



  /**
   *  Constructor for the CustomForm object
   */
  public CustomForm() { }


  /**
   *  Sets the action attribute of the CustomForm object
   *
   *@param  action  The new action value
   */
  public void setAction(String action) {
    this.action = action;
  }


  /**
   *  Sets the selectedTabId attribute of the CustomForm object
   *
   *@param  selectedTabId  The new selectedTabId value
   */
  public void setSelectedTabId(int selectedTabId) {
    this.selectedTabId = selectedTabId;
  }


  /**
   *  Sets the selectedTabId attribute of the CustomForm object
   *
   *@param  selectedTabId  The new selectedTabId value
   */
  public void setSelectedTabId(String selectedTabId) {
    this.selectedTabId = Integer.parseInt(selectedTabId);
  }


  /**
   *  Sets the cancel attribute of the CustomForm object
   *
   *@param  cancel  The new cancel value
   */
  public void setCancel(String cancel) {
    this.cancel = cancel;
  }


  /**
   *  Sets the reset attribute of the CustomForm object
   *
   *@param  reset  The new reset value
   */
  public void setReset(boolean reset) {
    this.reset = reset;
  }


  /**
   *  Sets the selectedTabName attribute of the CustomForm object
   *
   *@param  selectedTabName  The new selectedTabName value
   */
  public void setSelectedTabName(String selectedTabName) {
    this.selectedTabName = selectedTabName;
  }


  /**
   *  Sets the buttonList attribute of the CustomForm object
   *
   *@param  tmp  The new buttonList value
   */
  public void setButtonList(LinkedHashMap tmp) {
    this.buttonList = tmp;
  }


  /**
   *  Sets the jScripts attribute of the CustomForm object
   *
   *@param  jScripts  The new jScripts value
   */
  public void setJScripts(StringBuffer jScripts) {
    this.jScripts = jScripts;
  }


  /**
   *  Constructor for the addJScripts object
   *
   *@param  scripts  Description of the Parameter
   */
  public void addJScripts(String scripts) {
    StringTokenizer st = new StringTokenizer(scripts, "^");
    if (st.hasMoreTokens()) {
      while (st.hasMoreTokens()) {
        jScripts.append("<script language=\"JavaScript\" TYPE=\"text/javascript\" SRC=\"/javascript/" + st.nextToken() + "\"></script>");
      }
    }
  }


  /**
   *  Gets the jScripts attribute of the CustomForm object
   *
   *@return    The jScripts value
   */
  public String getJScripts() {
    return jScripts.toString();
  }


  /**
   *  Gets the action attribute of the CustomForm object
   *
   *@return    The action value
   */
  public String getAction() {
    return action;
  }


  /**
   *  Gets the cancel attribute of the CustomForm object
   *
   *@return    The cancel value
   */
  public String getCancel() {
    return cancel;
  }


  /**
   *  Gets the selectedTabId attribute of the CustomForm object
   *
   *@return    The selectedTabId value
   */
  public int getSelectedTabId() {
    return selectedTabId;
  }


  /**
   *  Gets the reset attribute of the CustomForm object
   *
   *@return    The reset value
   */
  public boolean getReset() {
    return reset;
  }


  /**
   *  Gets the selectedTabName attribute of the CustomForm object
   *
   *@return    The selectedTabName value
   */
  public String getSelectedTabName() {
    return selectedTabName;
  }


  /**
   *  Gets the jsCheckInfo attribute of the CustomForm object
   *
   *@return    The jsCheckInfo value
   */
  public String getJsFormCheck() {
    return jsFormCheck.toString();
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Return Value
   */
  public boolean hasJsFormCheck() {
    return (this.getJsFormCheck() != null && !"".equals(this.getJsFormCheck()));
  }


  /**
   *  Gets the jsTabCheck attribute of the CustomForm object
   *
   *@return    The jsTabCheck value
   */
  public String getJsTabCheck() {
    return jsTabCheck.toString();
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Return Value
   */
  public boolean hasJsTabCheck() {
    return (this.getJsTabCheck() != null && !"".equals(this.getJsTabCheck()));
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Return Value
   */
  public boolean hasCancel() {
    return (this.getCancel() != null && !"".equals(this.getCancel()));
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Return Value
   */
  public boolean hasAction() {
    return (this.getAction() != null && !"".equals(this.getAction()));
  }


  /**
   *  Gets the buttonList attribute of the CustomForm object
   *
   *@return    The buttonList value
   */
  public LinkedHashMap getButtonList() {
    return buttonList;
  }


  /**
   *  Description of the Method
   *
   *@param  thisField  Description of the Parameter
   */
  public void buildJsFormCheck(CustomField thisField) {
    if (thisField.getRequired() == true) {
      if (jsFormCheck.length() == 0) {
        jsFormCheck.append("function checkForm(form) {\n");
        jsFormCheck.append("    formTest = true;\n");
        jsFormCheck.append("    message = \"\";\n");
      }
      appendJsField(thisField, jsFormCheck);
    }
  }


  /**
   *  Description of the Method
   *
   *@param  thisField  Description of the Parameter
   */
  public void buildJsTabCheck(CustomField thisField) {
    if (thisField.getRequired() == true) {
      if (jsTabCheck.length() == 0) {
        jsTabCheck.append("function checkTab(form) {\n");
        jsTabCheck.append("    formTest = true;\n");
        jsTabCheck.append("    message = \"\";\n");
      }
      appendJsField(thisField, jsTabCheck);
    }
  }


  /**
   *  Description of the Method
   *
   *@param  thisField    Description of the Parameter
   *@param  jsCheckInfo  Description of the Parameter
   */
  public static void appendJsField(CustomField thisField, StringBuffer jsCheckInfo) {
    if (thisField.getType() == CustomField.TEXT) {
      jsCheckInfo.append("    if (form." + thisField.getName() + ".value == \"\") {\n");
      jsCheckInfo.append("        message += \"- " + thisField.getDisplay() + "\\r\\n\";\n");
      jsCheckInfo.append("        formTest = false;\n");
      jsCheckInfo.append("    }\n");
    } else if (thisField.getType() == CustomField.SELECT) {
      jsCheckInfo.append("    if (form." + thisField.getName() + ".selectedIndex ==0) {\n");
      jsCheckInfo.append("        message += \"- " + thisField.getDisplay() + "\\r\\n\";\n");
      jsCheckInfo.append("        formTest = false;\n");
      jsCheckInfo.append("    }\n");
    } else if (thisField.getType() == CustomField.ROWLIST) {
      for (int rowListCount = 1; rowListCount <= thisField.getMaxRowItems(); rowListCount++) {
        jsCheckInfo.append("    if (form." + thisField.getName() + rowListCount + "text.value == \"\") {\n");
        jsCheckInfo.append("        message += \"- " + thisField.getDisplay() + rowListCount + "\\r\\n\";\n");
        jsCheckInfo.append("        formTest = false;\n");
        jsCheckInfo.append("    }\n");
      }
    }
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Returned Value
   */
  public String displayButtons() {
    StringBuffer result = new StringBuffer();
    String thisName = null;
    String thisLink = null;

    Iterator buttonI = this.getButtonList().keySet().iterator();
    while (buttonI.hasNext()) {
      thisName = (String) buttonI.next();
      thisLink = (String) buttonList.get(thisName);
      if (thisName != null && !(thisName.equals("")) && !(thisLink.equals("")) && thisLink != null) {
        result.append("<input type=\"submit\" value=\"" + thisName + "\" onClick=\"javascript:this.form.action='" + thisLink + "';this.form.clickFrom.value='" + thisName.toLowerCase() + "'\">\n");
      }
    }

    if (this.hasCancel()) {
      result.append("<input type=\"button\" value=\"Cancel\" onClick=\"javascript:this.form.action='" + this.getCancel() + "';this.form.submit()\">");
    }
    //TODO: Maybe add a RESET button
    return result.toString();
  }


  /**
   *  Populates a CustomForm from any given object usage :
   *  thisForm.populate(SurveyObject); -- this would populate the CustomForm<br>
   *  from the Survey object.<br>
   *  CustomForm heirarchy : tabs --> groups --> rows --> columns --> fields
   *
   *@param  tmp  Description of the Parameter
   *@return      Description of the Return Value
   */
  public int populate(Object tmp) {
    int updatedFields = 0;
    jsFormCheck = new StringBuffer();
    jsTabCheck = new StringBuffer();

    Iterator tabs = this.iterator();
    while (tabs.hasNext()) {
      CustomFormTab thisTab = (CustomFormTab) tabs.next();
      Iterator groups = thisTab.iterator();
      while (groups.hasNext()) {
        ArrayList dynamicRows = null;
        CustomFormGroup thisGroup = (CustomFormGroup) groups.next();
        if (System.getProperty("DEBUG") != null) {
          System.out.println("CustomForm-> Populating Group " + thisGroup.getName() + " Size:" + thisGroup.size());
        }
        ListIterator rows = thisGroup.listIterator();
        while (rows.hasNext()) {
          CustomRow thisRow = (CustomRow) rows.next();
          if (!thisRow.getMultiple()) {
            Iterator columns = thisRow.iterator();
            while (columns.hasNext()) {
              CustomColumn thisColumn = (CustomColumn) columns.next();
              Iterator fields = thisColumn.iterator();
              while (fields.hasNext()) {
                CustomField thisField = (CustomField) fields.next();
                //check for static field i.e do not invoke methods on tmp for static fields like labels
                if (!thisField.getIsStatic()) {
                  //check for the object to be used for populating this field .. could be a listItem like SurveyQuestion
                  if (!thisField.getListName().equals("")) {
                    Object item = ObjectUtils.getObject(ObjectUtils.getObject(tmp, thisField.getListName()), thisField.getListItemName());
                    thisField.setEnteredValue(ObjectUtils.getParam(item, thisField.getName()));
                    if (System.getProperty("DEBUG") != null) {
                      System.out.println("CustomForm-> SetList field: " + thisField.getName() + " " + ObjectUtils.getParam(item, thisField.getName()) + " = " + thisField.getEnteredValue());
                    }
                  } else {
                    thisField.setEnteredValue(ObjectUtils.getParam(tmp, thisField.getName()));
                    if (System.getProperty("DEBUG") != null) {
                      System.out.println("CustomForm-> Set field: " + thisField.getName() + " " + ObjectUtils.getParam(tmp, thisField.getName()) + " = " + thisField.getEnteredValue());
                    }
                  }
                }

                //Set selectedItem if field is a combo box or a checkbox
                if (thisField.getType() == CustomField.SELECT || thisField.getType() == CustomField.CHECKBOX) {
                  if (!thisField.getListName().equals("")) {
                    Object item = ObjectUtils.getObject(ObjectUtils.getObject(tmp, thisField.getListName()), thisField.getListItemName());
                    thisField.setSelectedItemId(ObjectUtils.getParam(item, thisField.getName()));
                  } else {
                    thisField.setSelectedItemId(ObjectUtils.getParam(tmp, thisField.getName()));
                  }
                }
                //Add required fields to javascript code... for this tab
                if (this.getSelectedTabId() == thisTab.getId()) {
                  buildJsTabCheck(thisField);
                }
                //Add required fields to javascript code... for whole form
                buildJsFormCheck(thisField);
                updatedFields++;
              }
            }
          } else {
            thisRow.setListObject(ObjectUtils.getObject(tmp, thisRow.getListName()));
          }
        }
      }
      if (System.getProperty("DEBUG") != null) {
        System.out.println("CustomForm-> populate Done");
      }
    }

    if (jsFormCheck.length() != 0) {
      jsFormCheck.append("    if (formTest == false) {\n");
      jsFormCheck.append("        alert(\"Form could not be saved, please check the following:\\r\\n\\r\\n\" + message);\n");
      jsFormCheck.append("        return false;\n");
      jsFormCheck.append("    } else {\n");
      jsFormCheck.append("        return true;\n");
      jsFormCheck.append("    }\n");
      jsFormCheck.append("}\n");
    }

    if (jsTabCheck.length() != 0) {
      jsTabCheck.append("    if (formTest == false) {\n");
      jsTabCheck.append("        alert(\"Before going to the next page, please check the following:\\r\\n\\r\\n\" + message);\n");
      jsTabCheck.append("        return false;\n");
      jsTabCheck.append("    } else {\n");
      jsTabCheck.append("        return true;\n");
      jsTabCheck.append("    }\n");
      jsTabCheck.append("}\n");
    }

    return updatedFields;
  }


  /**
   *  Gets the jsFormDefault attribute of the CustomForm object
   *
   *@return    The jsFormDefault value
   */
  public String getJsFormOnLoad() {
    Iterator tabs = this.iterator();
    while (tabs.hasNext()) {
      CustomFormTab thisTab = (CustomFormTab) tabs.next();
      if (thisTab.getId() == selectedTabId && thisTab.hasDefaultField()) {
        return (
            "window.onload = function () {" +
            "document." + this.getName() + "." + thisTab.getDefaultField() + ".focus();" +
            thisTab.getOnLoadEvent() +
            "}"
            );
      }
    }
    return "";
  }
}

