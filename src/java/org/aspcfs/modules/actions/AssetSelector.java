package org.aspcfs.modules.actions;

import javax.servlet.*;
import javax.servlet.http.*;
import com.darkhorseventures.framework.actions.*;
import java.sql.*;
import java.util.*;
import org.aspcfs.utils.web.PagedListInfo;
import org.aspcfs.utils.web.LookupList;
import org.aspcfs.modules.servicecontracts.base.*;
import org.aspcfs.modules.assets.base.*;
import org.aspcfs.modules.base.*;

/**
 *  Description of the Class
 *
 *@author     kbhoopal
 *@created    February 16, 2004
 *@version    $Id$
 */
public final class AssetSelector extends CFSModule {

  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandListAssets(ActionContext context) {

    Exception errorMessage = null;
    Connection db = null;
    boolean listDone = false;
    String listType = context.getRequest().getParameter("listType");
    AssetList assetList = null;
    AssetList finalAssets = null;
    ArrayList selectedList = (ArrayList) context.getSession().getAttribute("SelectedAssets");
    int tmpContractId = -1;

    if (selectedList == null || "true".equals(context.getRequest().getParameter("reset"))) {
      selectedList = new ArrayList();
    }

    if (context.getRequest().getParameter("previousSelection") != null) {
      StringTokenizer st = new StringTokenizer(context.getRequest().getParameter("previousSelection"), "|");
      while (st.hasMoreTokens()) {
        selectedList.add(String.valueOf(st.nextToken()));
      }
    }

    try {
      db = this.getConnection(context);
      int rowCount = 1;
      assetList = new AssetList();

      if ("list".equals(listType)) {
        while (context.getRequest().getParameter("hiddenAssetId" + rowCount) != null) {
          int assetId = Integer.parseInt(context.getRequest().getParameter("hiddenAssetId" + rowCount));
          if (context.getRequest().getParameter("asset" + rowCount) != null) {
            if (!selectedList.contains(String.valueOf(assetId))) {
              selectedList.add(String.valueOf(assetId));
            }
          } else {
            selectedList.remove(String.valueOf(assetId));
          }
          rowCount++;
        }
      }

      if ("true".equals((String) context.getRequest().getParameter("finalsubmit"))) {
        //Handle single selection case
        if ("single".equals(listType)) {
          rowCount = Integer.parseInt(context.getRequest().getParameter("rowcount"));
          int assetId = Integer.parseInt(context.getRequest().getParameter("hiddenAssetId" + rowCount));
          selectedList.clear();
          selectedList.add(String.valueOf(assetId));
        }
        listDone = true;
        if (finalAssets == null) {
          finalAssets = new AssetList();
        }
        for (int i = 0; i < selectedList.size(); i++) {
          String assetId = (String) selectedList.get(i);
          Asset thisAsset = new Asset(db, assetId);
          finalAssets.add(thisAsset);
        }
      }

      LookupList assetStatusList = new LookupList(db, "lookup_asset_status");
      assetStatusList.addItem(-1, "--None--");
      context.getRequest().setAttribute("assetStatusList", assetStatusList);

      buildCategories(context, db, null);

      try{
        tmpContractId = Integer.parseInt(context.getRequest().getParameter("contractId"));
      }catch(Exception e){
        tmpContractId = -1;
      }
      assetList.setServiceContractId(tmpContractId);
      setParameters(assetList, context);
      assetList.setOrgId(context.getRequest().getParameter("orgId"));
      assetList.buildList(db);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    if (errorMessage == null) {
      context.getRequest().setAttribute("assetList", assetList);
      context.getSession().setAttribute("selectedAssets", selectedList);
      if (listDone) {
        context.getRequest().setAttribute("finalAssets", finalAssets);
      }
      return ("ListAssetsOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }



  /**
   *  Sets the parameters attribute of the AccountSelector object
   *
   *@param  context              The new parameters value
   *@param  assetList            The new parameters value
   */
  private void setParameters(AssetList assetList, ActionContext context) {

    String serialNumber = context.getRequest().getParameter("serialNumber");
    String contractNumber = context.getRequest().getParameter("contractNumber");
    if (serialNumber != null) {
      if (!"Serial Number".equals(serialNumber) && !"".equals(serialNumber.trim())) {
        assetList.setSerialNumber("%" + serialNumber + "%");
      }
    }
    if (contractNumber != null) {
      if (!"Service Contract Number".equals(contractNumber) && !"".equals(contractNumber.trim())) {
        assetList.setServiceContractNumber("%" + contractNumber + "%");
        assetList.setServiceContractId(-1);
      }
    }

    PagedListInfo assetListInfo = this.getPagedListInfo(context, "AssetListInfo");
    //filter for departments & project teams
    if (!assetListInfo.hasListFilters()) {
      assetListInfo.addFilter(1, "0");
    }
    //add filters
    FilterList filters = new FilterList();
    filters.setSource(Constants.ASSETS);
    filters.build(context.getRequest());
    context.getRequest().setAttribute("Filters", filters);
    //  set Filter for retrieving contracts depending on type of asset
    String firstFilter = filters.getFirstFilter(assetListInfo.getListView());
    if("allassets".equals(firstFilter)){
      assetList.setAllAssets(true);
    }else{
      assetList.setAllAssets(false);
    }
    
    String orgId = context.getRequest().getParameter("orgId");
    assetListInfo.setLink("AssetSelector.do?command=ListAssets&orgId=" + orgId);
    assetList.setPagedListInfo(assetListInfo);
    assetList.setOrgId(Integer.parseInt(orgId));

    context.getRequest().setAttribute("orgId", orgId);
  }


  /**
   *  Description of the Method
   *
   *@param  context           Description of the Parameter
   *@param  db                Description of the Parameter
   *@param  thisAsset         Description of the Parameter
   *@exception  SQLException  Description of the Exception
   */
  public void buildCategories(ActionContext context, Connection db, Asset thisAsset) throws SQLException {
    CategoryList categoryList1 = new CategoryList("asset_category");
    categoryList1.setCatLevel(0);
    categoryList1.setParentCode(0);
    categoryList1.buildList(db);
    categoryList1.setHtmlJsEvent("onChange=\"javascript:updateCategoryList('1');\"");
    categoryList1.getCatListSelect().addItem(-1, "Undetermined");
    context.getRequest().setAttribute("categoryList1", categoryList1);

    CategoryList categoryList2 = new CategoryList("asset_category");
    categoryList2.setCatLevel(1);
    if (thisAsset == null) {
      categoryList2.buildList(db);
    } else if (thisAsset.getLevel1() > -1) {
      categoryList2.setParentCode(thisAsset.getLevel1());
      categoryList2.buildList(db);
    }
    categoryList2.setHtmlJsEvent("onChange=\"javascript:updateCategoryList('2');\"");
    categoryList2.getCatListSelect().addItem(-1, "Undetermined");
    context.getRequest().setAttribute("categoryList2", categoryList2);

    CategoryList categoryList3 = new CategoryList("asset_category");
    categoryList3.setCatLevel(2);
    if (thisAsset == null) {
      categoryList3.buildList(db);
    } else if (thisAsset.getLevel2() > -1) {
      categoryList3.setParentCode(thisAsset.getLevel2());
      categoryList3.buildList(db);
    }
    categoryList3.getCatListSelect().addItem(-1, "Undetermined");
    context.getRequest().setAttribute("categoryList3", categoryList3);
  }
}

