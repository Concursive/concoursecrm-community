package org.aspcfs.modules.actions;

import javax.servlet.*;
import javax.servlet.http.*;
import com.darkhorseventures.framework.actions.*;
import java.sql.*;
import java.util.*;
import org.aspcfs.utils.web.PagedListInfo;
import org.aspcfs.utils.web.LookupList;
import org.aspcfs.modules.accounts.base.Organization;
import org.aspcfs.modules.accounts.base.OrganizationList;
import org.aspcfs.modules.servicecontracts.base.*;
import org.aspcfs.modules.base.FilterList;
import org.aspcfs.modules.base.Filter;
import org.aspcfs.modules.base.Constants;

public final class ServiceContractSelector extends CFSModule {

  /**
   *  Description of the Method
   *
   *@param  context  Description of the Parameter
   *@return          Description of the Return Value
   */
  public String executeCommandListServiceContracts(ActionContext context) {

    Exception errorMessage = null;
    Connection db = null;
    boolean listDone = false;
    String listType = context.getRequest().getParameter("listType");
    ServiceContractList serviceContractList = null;
    ServiceContractList finalServiceContracts = null;
    ArrayList selectedList = (ArrayList) context.getSession().getAttribute("SelectedServiceContracts");

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
      serviceContractList = new ServiceContractList();

      if ("list".equals(listType)) {
        while (context.getRequest().getParameter("hiddenServiceContractId" + rowCount) != null) {
          int serviceContractId = Integer.parseInt(context.getRequest().getParameter("hiddenServiceContractId" + rowCount));
          if (context.getRequest().getParameter("serviceContract" + rowCount) != null) {
            if (!selectedList.contains(String.valueOf(serviceContractId))) {
              selectedList.add(String.valueOf(serviceContractId));
            }
          } else {
            selectedList.remove(String.valueOf(serviceContractId));
          }
          rowCount++;
        }
      }

      if ("true".equals((String) context.getRequest().getParameter("finalsubmit"))) {
        //Handle single selection case
        if ("single".equals(listType)) {
          rowCount = Integer.parseInt(context.getRequest().getParameter("rowcount"));
          int serviceContractId = Integer.parseInt(context.getRequest().getParameter("hiddenServiceContractId" + rowCount));
          selectedList.clear();
          selectedList.add(String.valueOf(serviceContractId));
        }
        listDone = true;
        if (finalServiceContracts == null) {
          finalServiceContracts = new ServiceContractList();
        }
        for (int i = 0; i < selectedList.size(); i++) {
          String contractId = (String) selectedList.get(i);
          ServiceContract thisContract = new ServiceContract(db, contractId);
          finalServiceContracts.add(thisContract);
        }
      }

      LookupList serviceCategorySelect = new LookupList(db, "lookup_sc_category");
      context.getRequest().setAttribute("serviceContractCategorySelect", serviceCategorySelect);

      LookupList serviceTypeSelect = new LookupList(db, "lookup_sc_type");
      context.getRequest().setAttribute("serviceContractTypeSelect", serviceTypeSelect);

      //Set OrganizationList Parameters and build the list
      setParameters(serviceContractList, context);
      serviceContractList.setOrgId(context.getRequest().getParameter("orgId"));
      serviceContractList.buildList(db);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }
    if (errorMessage == null) {
      context.getRequest().setAttribute("serviceContractList", serviceContractList);
      context.getSession().setAttribute("selectedServiceContracts", selectedList);
      if (listDone) {
        context.getRequest().setAttribute("finalServiceContracts", finalServiceContracts);
      }
      return ("ListServiceContractsOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }



  /**
   *  Sets the parameters attribute of the ServiceContractSelector object
   *
   *@param  serviceContractList  The new parameters value
   *@param  context              The new parameters value
   */
  private void setParameters(ServiceContractList serviceContractList, ActionContext context) {

    PagedListInfo serviceContractListInfo = this.getPagedListInfo(context, "ServiceContractListInfo");

    String orgId = context.getRequest().getParameter("orgId");
    serviceContractListInfo.setLink("ServiceContractSelector.do?command=ListServiceContracts&orgId=" + orgId);
    serviceContractList.setPagedListInfo(serviceContractListInfo);
    serviceContractList.setOrgId(Integer.parseInt(orgId));

    context.getRequest().setAttribute("orgId", orgId);
  }

}


