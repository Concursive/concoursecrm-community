package com.darkhorseventures.cfsmodule;

import javax.servlet.*;
import javax.servlet.http.*;
import org.theseus.actions.*;
import java.sql.*;
import java.text.*;
import com.darkhorseventures.utils.*;
import com.darkhorseventures.cfsbase.*;
import com.darkhorseventures.webutils.*;

import java.awt.*;
import java.awt.event.*;
import java.awt.geom.*;
import java.awt.image.*;
import java.io.*;
import java.util.*;

import com.sun.image.codec.jpeg.*;

import com.jrefinery.chart.*;
import com.jrefinery.chart.data.*;
import com.jrefinery.chart.ui.*;
import com.jrefinery.util.ui.*;

/**
 *  Description of the Class
 *
 *@author     chris
 *@created    October 17, 2001
 *@version    $Id$
 */
public final class Leads extends CFSModule {

  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandDefault(ActionContext context) {
    String module = context.getRequest().getParameter("module");
    String includePage = context.getRequest().getParameter("include");
    context.getRequest().setAttribute("IncludePage", includePage);
    addModuleBean(context, module, module);
    return ("IncludeOK");
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandDetailsOpp(ActionContext context) {
    addModuleBean(context, "View Opportunities", "View Opportunity Details");
    Exception errorMessage = null;

    String oppId = context.getRequest().getParameter("id");

    Connection db = null;
    Opportunity newOpp = null;

    try {
      db = this.getConnection(context);
      newOpp = new Opportunity(db, oppId);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorMessage == null) {
      context.getRequest().setAttribute("OpportunityDetails", newOpp);
      addRecentItem(context, newOpp);
      return ("OppDetailsOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandSearchOpp(ActionContext context) {
    addModuleBean(context, "Search Leads", "Search Opportunities");
    return ("SearchOK");
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */

  public String executeCommandDashboard(ActionContext context) {
    
    addModuleBean(context, "Dashboard", "Dashboard");

    int errorCode = 0;
    int idToUse = 0;
    
    java.util.Date d = new java.util.Date();

    String errorMessage = "";
    String graphString = new String();
    String fileName = "";
    StringBuffer sql = new StringBuffer();
    String checkFileName = "";

    Connection db = null;
    Statement st = null;
    ResultSet rs = null;

    //build the graph selection
    HtmlSelect graphTypeSelect = new HtmlSelect();
    graphTypeSelect.setSelectName("whichGraph");
    graphTypeSelect.addItem("gmr", "Gross Monthly Revenue");
    graphTypeSelect.addItem("ramr", "Risk Adjusted Monthly Revenue");
    graphTypeSelect.addItem("cgmr", "Commission Gross Monthly Revenue");
    graphTypeSelect.addItem("cramr", "Commission Risk Adj. Monthly Revenue");
    graphTypeSelect.addItem("hist", "Historical");
    //done
	
    UserBean thisUser = (UserBean)context.getSession().getAttribute("User");
    String overrideId = context.getRequest().getParameter("oid");

    //System.out.println("Leads-> got " + overrideId);

    User thisRec = null;

    UserList shortChildList = new UserList();
    UserList fullChildList = new UserList();
    UserList tempUserList = new UserList();
    UserList linesToDraw = new UserList();

    OpportunityList fullOppList = new OpportunityList();
    OpportunityList tempOppList = new OpportunityList();
    OpportunityList realFullOppList = new OpportunityList();

    XYDataSource categoryData = null;

    if (overrideId != null && !(overrideId.equals("null")) && !(overrideId.equals("" + thisUser.getUserId()))) {
      idToUse = Integer.parseInt(overrideId);
      thisRec = thisUser.getUserRecord().getChild(idToUse);
      context.getRequest().setAttribute("override", overrideId);
      context.getRequest().setAttribute("othername", thisRec.getContact().getNameFull());
      context.getRequest().setAttribute("previousId", "" + thisRec.getManagerId());
    } else {
      idToUse = thisUser.getUserId();
      thisRec = thisUser.getUserRecord();
    }

    graphString = context.getRequest().getParameter("whichGraph");

    if (graphString == null || graphString.equals("")) {
	    graphString = "gmr";
    }
    
    graphTypeSelect.setDefaultKey(graphString);
    graphTypeSelect.build();

    try {
      db = this.getConnection(context);
      System.out.println("Leads-> Got user record of" + idToUse);

      shortChildList = thisRec.getShortChildList();
      context.getRequest().setAttribute("ShortChildList", shortChildList);

      fullChildList = thisRec.getFullChildList(shortChildList, new UserList());

      //get the opportunities that were entered by anyone in the full list

      String range = fullChildList.getUserListIds(idToUse);

      realFullOppList.setUnits("M");
      realFullOppList.setOwnerIdRange(range);
      realFullOppList.buildList(db);

      //filter out my opportunities for displaying on page

      Iterator z = realFullOppList.iterator();

      while (z.hasNext()) {
        Opportunity tempOpp = (Opportunity)(z.next());

        //try it out
        //tempOppList is MY (or user drilled-to) Opps

        if (tempOpp.getOwner() == idToUse) {
          tempOppList.addElement(tempOpp);
        }
      }

      context.getRequest().setAttribute("MyOppList", tempOppList);
    } catch (Exception e) {
      errorCode = 1;
      errorMessage = e.toString();
    } finally {
      this.freeConnection(context, db);
    }
    
    if (thisRec.getIsValid() == true) {	
	if (graphString.equals("gmr")) {
		checkFileName = thisRec.getGmr().getLastFileName();
	} else if (graphString.equals("ramr")) {
		checkFileName = thisRec.getRamr().getLastFileName();
	} else if (graphString.equals("cgmr")) {
		checkFileName = thisRec.getCgmr().getLastFileName();
	} else if (graphString.equals("cramr")) {
		checkFileName = thisRec.getCramr().getLastFileName();
	}
    }
    
    if (checkFileName.equals("")) {
	    
	    System.out.println("Leads-> Preparing the chart");
	
	    //add up all stuff for children
	
	    Iterator n = fullChildList.iterator();
	
	    while (n.hasNext()) {
	      User thisRecord = (User)n.next();
	      tempUserList = prepareLines(thisRecord, realFullOppList, tempUserList);
	    }
	
	    linesToDraw = calculateLine(tempUserList, linesToDraw);
	
	    //set my own
	
	    tempUserList = prepareLines(thisRec, tempOppList, tempUserList);
	
	    //add me up -- keep this
	    linesToDraw = calculateLine(thisRec, linesToDraw);
	
	    categoryData = createCategoryDataSource(linesToDraw, graphString);
	
	    JFreeChart chart = JFreeChart.createXYChart(categoryData);
	
	    chart.setChartBackgroundPaint(new GradientPaint(0, 0, Color.white, 1000, 0, Color.white));
	    Plot bPlot = chart.getPlot();
	
	    //don't know if we really need this
	    Axis vAxis = bPlot.getAxis(Plot.VERTICAL_AXIS);
	    vAxis.setLabel("");
	
	    VerticalNumberAxis vnAxis = (VerticalNumberAxis)chart.getPlot().getAxis(Plot.VERTICAL_AXIS);
	    vnAxis.setAutoRangeIncludesZero(true);
	    
	    HorizontalNumberAxis hnAxis = (HorizontalNumberAxis)chart.getPlot().getAxis(Plot.HORIZONTAL_AXIS);
	    hnAxis.setAutoRangeIncludesZero(false);
	    hnAxis.setAutoTickValue(false);
	    hnAxis.setAutoRange(false);
	    
	    hnAxis.setLabel("");
	    
	    Stroke gridStroke = new BasicStroke(0.25f, BasicStroke.CAP_BUTT, BasicStroke.JOIN_ROUND, 0.0f, new float[] {2.0f, 2.0f}, 0.0f); 
	    Paint gridPaint = Color.gray; 

	
	    //don't know if we really need this
	    //Axis hAxis = bPlot.getAxis(Plot.HORIZONTAL_AXIS);
	    //hAxis.setLabel("Months Out");
	    
	    System.out.println("Trying to use " + (d.getYear()+1900) + " " + d.getMonth() + " " + d.getDay());
	    
	    try {
	    Axis myHorizontalDateAxis = new HorizontalDateAxis (hnAxis.getLabel(), hnAxis.getLabelFont(), 
	    hnAxis.getLabelPaint(), hnAxis.getLabelInsets(), true, hnAxis.getTickLabelFont(), 
	    hnAxis.getTickLabelPaint(), hnAxis.getTickLabelInsets(), true, true, hnAxis.getTickMarkStroke(), 
	    true, createDate( (d.getYear()+1900), d.getMonth(), 0), createDate((d.getYear() + 1901), d.getMonth(), 0), false, new DateUnit(Calendar.MONTH, 1), 
	    new SimpleDateFormat("MMM '  ' yy"), true, gridStroke, gridPaint);
	    
	    bPlot.setHorizontalAxis(myHorizontalDateAxis);
	    } catch (AxisNotCompatibleException err1) 
		{ 
		System.out.println("AxisNotCompatibleException error!"); 
		} 
		    
	
	    chart.setLegend(null);
	    chart.setTitle("");
	
	    //Define the chart
	    //int width = 325;
	    //int height = 225;
	    
	    int width = 300;
	    int height = 200;
	
	    System.out.println("Leads-> Drawing the chart");
	    BufferedImage img = draw(chart, width, height);
	
	    //Output the chart
	    try {
	      String fs = System.getProperty("file.separator");
	
	      String realPath = context.getServletContext().getRealPath("/");
	      String filePath = realPath + "graphs" + fs;
	
	      java.util.Date testDate = new java.util.Date();
	      java.util.Calendar testCal = java.util.Calendar.getInstance();
	      testCal.setTime(testDate);
	      testCal.add(java.util.Calendar.MONTH, +1);
	
	      fileName = new String(idToUse + testDate.getTime() + context.getSession().getCreationTime() + ".jpg");
		
		if (graphString.equals("gmr")) {
			thisRec.getGmr().setLastFileName(fileName);
		} else if (graphString.equals("ramr")) {
			thisRec.getRamr().setLastFileName(fileName);
		} else if (graphString.equals("cgmr")) {
			thisRec.getCgmr().setLastFileName(fileName);
		} else if (graphString.equals("cramr")) {
			thisRec.getCramr().setLastFileName(fileName);
		}
	      
	      context.getRequest().setAttribute("GraphFileName", fileName);
	      FileOutputStream foutstream = new FileOutputStream(filePath + fileName);
	
	      JPEGImageEncoder encoder =
		  JPEGCodec.createJPEGEncoder(foutstream);
	      JPEGEncodeParam param =
		  encoder.getDefaultJPEGEncodeParam(img);
	      param.setQuality(1.0f, true);
	      encoder.encode(img, param);
	      foutstream.close();
	    } catch (IOException e) {
	    }


    } else {
	    System.out.println("This file is valid, and cached: " + checkFileName);
	    context.getRequest().setAttribute("GraphFileName", checkFileName);
    }

    if (errorCode == 0) {
      context.getRequest().setAttribute("UserInfo", thisRec);
      context.getRequest().setAttribute("FullChildList", fullChildList);
      context.getRequest().setAttribute("FullOppList", fullOppList);
      context.getRequest().setAttribute("GraphTypeList", graphTypeSelect);
      
      return ("DashboardOK");
    } else {
      //A System Error occurred
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }

  }
  
	public static java.util.Date createDate(int y, int m, int d) 
	{ 
		GregorianCalendar calendar = new GregorianCalendar(y, m, d, 0, 0, 0); 
		return calendar.getTime(); 
	} 

  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandDeleteOpp(ActionContext context) {
    Exception errorMessage = null;
    boolean recordDeleted = false;
    Opportunity newOpp = null;

    String tempcontact = context.getRequest().getParameter("contactLink");
    String tempaccount = context.getRequest().getParameter("accountLink");

    Connection db = null;
    try {
      db = this.getConnection(context);
      newOpp = new Opportunity(db, context.getRequest().getParameter("id"));
      recordDeleted = newOpp.delete(db, context);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    addModuleBean(context, "Opportunities", "Delete an opportunity");
    if (errorMessage == null) {
      if (recordDeleted) {
	deleteRecentItem(context, newOpp);
        return ("OppDeleteOK");
      } else {
        processErrors(context, newOpp.getErrors());
        return (executeCommandViewOpp(context));
      }
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  Modify Contact
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandModifyOpp(ActionContext context) {
    addModuleBean(context, "View Opportunities", "Modify an Opportunity");
    Exception errorMessage = null;

    HtmlSelect busTypeSelect = new HtmlSelect();
    busTypeSelect.setSelectName("type");
    busTypeSelect.addItem("N", "New");
    busTypeSelect.addItem("E", "Existing");

    HtmlSelect unitSelect = new HtmlSelect();
    unitSelect.setSelectName("units");
    unitSelect.addItem("Y", "Years");
    unitSelect.addItem("M", "Months");
    unitSelect.addItem("W", "Weeks");
    unitSelect.addItem("D", "Days");

    int tempId = -1;
    String passedId = context.getRequest().getParameter("id");
    tempId = Integer.parseInt(passedId);

    Connection db = null;
    Statement st = null;
    ResultSet rs = null;
    Opportunity newOpp = null;

    try {
      db = this.getConnection(context);
      StringBuffer sql = new StringBuffer();

      newOpp = new Opportunity(db, "" + tempId);

      LookupList stageSelect = new LookupList(db, "lookup_stage");
      context.getRequest().setAttribute("StageList", stageSelect);
      
      busTypeSelect.setDefaultKey(newOpp.getType());
      unitSelect.setDefaultKey(newOpp.getUnits());

      UserList userList = new UserList();
      //userList.setEmptyHtmlSelectRecord("-- None --");
      userList.setBuildContact(true);
      userList.setIncludeMe(true);
      userList.setMyId(getUserId(context));
      userList.setMyValue(getNameLast(context) + ", " + getNameFirst(context));
      userList.setManagerId(getUserId(context));
      userList.buildList(db);
      context.getRequest().setAttribute("UserList", userList);

    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorMessage == null) {
      context.getRequest().setAttribute("OpportunityDetails", newOpp);
      addRecentItem(context, newOpp);
      context.getRequest().setAttribute("BusTypeList", busTypeSelect);
      context.getRequest().setAttribute("UnitTypeList", unitSelect);
      return ("ModifyOppOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */

  public String executeCommandViewOpp(ActionContext context) {
    Exception errorMessage = null;
    PagedListInfo oppListInfo = this.getPagedListInfo(context, "OpportunityListInfo");
    oppListInfo.setLink("/Leads.do?command=ViewOpp");

    Connection db = null;
    OpportunityList oppList = new OpportunityList();

    //search stuff
    
    String passedDesc = context.getRequest().getParameter("description");

    if (passedDesc != null && !(passedDesc.equals(""))) {
      passedDesc = "%" + passedDesc + "%";
    }
    
    //end search stuff

    try {
	db = this.getConnection(context);
	oppList.setPagedListInfo(oppListInfo);
	oppList.setDescription(passedDesc);
	
	if ("all".equals(oppListInfo.getListView())) {
		oppList.setOwnerIdRange(this.getUserRange(context));
	} else {
		oppList.setOwner(this.getUserId(context));
	}
	
	oppList.buildList(db);
    } catch (Exception e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorMessage == null) {
      context.getRequest().setAttribute("OpportunityList", oppList);
      addModuleBean(context, "View Opportunities", "Opportunities Add");
      return ("OppListOK");
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  context  Description of Parameter
   *@return          Description of the Returned Value
   *@since
   */
  public String executeCommandUpdateOpp(ActionContext context) {
    Exception errorMessage = null;

    Connection db = null;
    int resultCount = 0;
    Opportunity oldOpp = null;
    
	Opportunity newOpp = (Opportunity)context.getFormBean();
	newOpp.setId(Integer.parseInt(context.getRequest().getParameter("id")));
	
	String closeNow = context.getRequest().getParameter("closeNow");
	
		if (closeNow != null && closeNow.equals("on")) {
			newOpp.setCloseIt(true);
		} else {
			newOpp.setOpenIt(true);
		}

    try {
      db = this.getConnection(context);
      
      oldOpp = new Opportunity(db, context.getRequest().getParameter("id"));
      
      if ( (oldOpp.getStage() != newOpp.getStage()) || newOpp.getCloseIt() == true ) {
	      newOpp.setStageChange(true);
      } else {
	      newOpp.setStageChange(false);
      }
      
      newOpp.setModifiedBy(getUserId(context));
      resultCount = newOpp.update(db, context);
    } catch (SQLException e) {
      errorMessage = e;
    } finally {
      this.freeConnection(context, db);
    }

    if (errorMessage == null) {
      if (resultCount == 1) {
        return ("UpdateOppOK");
      } else {
        context.getRequest().setAttribute("Error",
            "<b>This record could not be updated because someone else updated it first.</b><p>" +
            "You can hit the back button to review the changes that could not be committed, " +
            "but you must reload the record and make the changes again.");
        return ("UserError");
      }
    } else {
      context.getRequest().setAttribute("Error", errorMessage);
      return ("SystemError");
    }
  }


  /**
   *  Description of the Method
   *
   *@param  chart   Description of Parameter
   *@param  width   Description of Parameter
   *@param  height  Description of Parameter
   *@return         Description of the Returned Value
   *@since
   */
  protected BufferedImage draw(JFreeChart chart, int width, int height) {
    BufferedImage img =
        new BufferedImage(width, height,
        BufferedImage.TYPE_INT_RGB);
    Graphics2D g2 = img.createGraphics();

    chart.draw(g2, new Rectangle2D.Double((-21), 0, width + 21, height));

    g2.dispose();
    return img;
  }


  /**
   *  Description of the Method
   *
   *@param  pertainsTo    Description of Parameter
   *@param  oppList       Description of Parameter
   *@param  usersToGraph  Description of Parameter
   *@return               Description of the Returned Value
   *@since
   */
  private UserList prepareLines(User pertainsTo, OpportunityList oppList, UserList usersToGraph) {

    java.util.Date myDate = null;
    java.util.Calendar readDate = java.util.Calendar.getInstance();
    java.util.Calendar readDateAdjusted = java.util.Calendar.getInstance();
    java.util.Date d = new java.util.Date();

    java.util.Calendar rightNow = java.util.Calendar.getInstance();
    java.util.Calendar rightNowAdjusted = java.util.Calendar.getInstance();
    java.util.Calendar twelveMonths = java.util.Calendar.getInstance();

    int passedDay = 0;
    int passedYear = 0;
    int passedMonth = 0;
    int roundedMonth = 0;
    int roundedYear = 0;
    int x = 0;

    Float ramrAddTerm = new Float(0.0);
    Float gmrAddTerm = new Float(0.0);
    Float cgmrAddTerm = new Float(0.0);
    Float cramrAddTerm = new Float(0.0);

    String valKey = "";
    boolean adjustTerms = false;

    d.setDate(1);

    rightNow.setTime(d);
    //rightNow.add(java.util.Calendar.MONTH, +1);

    rightNowAdjusted.setTime(d);
    //rightNowAdjusted.add(java.util.Calendar.MONTH, +1);
    rightNowAdjusted.add(java.util.Calendar.DATE, -1);

    //twelve months

    twelveMonths.setTime(d);
    twelveMonths.add(java.util.Calendar.MONTH, +13);
    
    if (pertainsTo.getIsValid() == false) {
      pertainsTo.doOpportunityLock();
      if (pertainsTo.getIsValid() == false) {
        try {
          System.out.println("(RE)BUILDING DATA FOR " + pertainsTo.getId());
          
          pertainsTo.setGmr(new GraphSummaryList());
          pertainsTo.setRamr(new GraphSummaryList());
          pertainsTo.setCgmr(new GraphSummaryList());
          pertainsTo.setCramr(new GraphSummaryList());

          Iterator oppIterator = oppList.iterator();
          while (oppIterator.hasNext()) {

            Opportunity tempOpp = (Opportunity)oppIterator.next();

            if (tempOpp.getOwner() == pertainsTo.getId()) {

              myDate = new java.util.Date(tempOpp.getCloseDate());
              readDate.setTime(myDate);

              readDateAdjusted.setTime(myDate);
              readDateAdjusted.add(java.util.Calendar.MONTH, +(java.lang.Math.round(tempOpp.getTerms())));

              passedDay = readDate.get(java.util.Calendar.DATE);
              passedYear = readDate.get(java.util.Calendar.YEAR);
              passedMonth = readDate.get(java.util.Calendar.MONTH);

              if (passedDay < 15) {
                roundedMonth = passedMonth;
                roundedYear = passedYear;
              } else if (passedDay >= 15) {
                if (passedMonth != 11) {
                  roundedMonth = (passedMonth + 1);
                  roundedYear = passedYear;
                } else {
                  roundedMonth = 0;
                  roundedYear = passedYear + 1;
                }

                adjustTerms = true;
              }

              valKey = ("" + roundedYear) + ("" + roundedMonth);

              //get the individual graph values
              gmrAddTerm = new Float((tempOpp.getGuess() / tempOpp.getTerms()));
	      ramrAddTerm = new Float((tempOpp.getGuess() / tempOpp.getTerms()) * tempOpp.getCloseProb());
              cgmrAddTerm = new Float((tempOpp.getGuess() / tempOpp.getTerms()) * tempOpp.getCommission());
              cramrAddTerm = new Float(((tempOpp.getGuess() / tempOpp.getTerms()) * tempOpp.getCloseProb() * tempOpp.getCommission()));
              //done

              //case: close date within 0-6m range
              if (((rightNow.before(readDate) || rightNowAdjusted.before(readDate)) && twelveMonths.after(readDate)) || rightNow.equals(readDate) || twelveMonths.equals(readDate)) {
                pertainsTo.setGraphValues(valKey, gmrAddTerm, ramrAddTerm, cgmrAddTerm, cramrAddTerm);
              }
              //case: close date plus terms within 0-6m range, or greater than 6m
              else if (rightNowAdjusted.after(readDate) && ((rightNow.before(readDateAdjusted) || rightNowAdjusted.before(readDateAdjusted)))) {
                pertainsTo.setGraphValues(valKey, gmrAddTerm, ramrAddTerm, cgmrAddTerm, cramrAddTerm);
              }

              //more terms
              if ((java.lang.Math.round(tempOpp.getTerms())) > 1) {

                for (x = 1; x < (java.lang.Math.round(tempOpp.getTerms())); x++) {
                  readDate.add(java.util.Calendar.MONTH, +1);
                  if (((rightNow.before(readDate) || rightNowAdjusted.before(readDate)) && twelveMonths.after(readDate)) || rightNow.equals(readDate) || twelveMonths.equals(readDate)) {
                    valKey = ("" + readDate.get(java.util.Calendar.YEAR)) + ("" + readDate.get(java.util.Calendar.MONTH));

                    if (!(adjustTerms)) {
                      pertainsTo.setGraphValues(valKey, gmrAddTerm, ramrAddTerm, cgmrAddTerm, cramrAddTerm);
                    }
                  }

                  adjustTerms = false;
                }
              }
            }
          }

          pertainsTo.setIsValid(true, true);
        } catch (Exception e) {
          System.err.println("Leads-> Unwanted exception occurred: " + e.toString());
        } finally {
          pertainsTo.doOpportunityUnlock();
        }
      } else {
        pertainsTo.doOpportunityUnlock();
      }
    }

    usersToGraph.addElement(pertainsTo);
    
    if (oppList.size() == 0) {
      return new UserList();
    } else {
      return usersToGraph;
    }
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Returned Value
   *@since
   */
  private XYDataSource createCategoryDataSource() {

    Object[][][] data;

    data = new Object[][][]{
        {
        {new Integer(0), new Integer(0)},
        {new Integer(1), new Integer(45)},
        {new Integer(2), new Integer(3)},
        {new Integer(3), new Integer(3)},
        {new Integer(4), new Integer(5)},
        {new Integer(5), new Integer(56)}
        }
        };

    return new DefaultXYDataSource(data);
  }


  /**
   *  Description of the Method
   *
   *@param  passedList  Description of Parameter
   *@return             Description of the Returned Value
   *@since
   */
  private XYDataSource createCategoryDataSource(UserList passedList, String whichGraph) {

    if (passedList.size() == 0) {
      return createEmptyCategoryDataSource();
    }
    
    Object[][][] data;
    
    java.util.Date d = new java.util.Date();
    java.util.Calendar iteratorDate = java.util.Calendar.getInstance();

    data = new Object[passedList.size()][12][2];
    int count = 0;
    int x = 0;

    Iterator n = passedList.iterator();

    while (n.hasNext()) {
      User thisUser = (User)n.next();

      String[] valKeys = thisUser.getGmr().getRange(12);
      
      iteratorDate.setTime(d);
      //iteratorDate.add(java.util.Calendar.MONTH, +1);

      for (count = 0; count < 12; count++) {
	data[x][count][0] = createDate( iteratorDate.get(java.util.Calendar.YEAR), iteratorDate.get(java.util.Calendar.MONTH), 0);
	
	if (whichGraph.equals("gmr")) {
	        data[x][count][1] = thisUser.getGmr().getValue(valKeys[count]);
	} else if (whichGraph.equals("ramr")) {
		data[x][count][1] = thisUser.getRamr().getValue(valKeys[count]);
	} else if (whichGraph.equals("cgmr")) {
		data[x][count][1] = thisUser.getCgmr().getValue(valKeys[count]);
	} else if (whichGraph.equals("cramr")) {
		data[x][count][1] = thisUser.getCramr().getValue(valKeys[count]);
	}
	
	iteratorDate.add(java.util.Calendar.MONTH, +1);
      }

      x++;
    }

    return new DefaultXYDataSource(data);
    //return createEmptyCategoryDataSource();
  }


  /**
   *  Description of the Method
   *
   *@param  primaryNode   Description of Parameter
   *@param  currentLines  Description of Parameter
   *@return               Description of the Returned Value
   *@since
   */
  private UserList calculateLine(User primaryNode, UserList currentLines) {
    if (currentLines.size() == 0) {
      currentLines.addElement(primaryNode);
      return currentLines;
    }

    User thisLine = new User();
    String[] valKeys = thisLine.getGmr().getRange(12);

    Iterator x = currentLines.iterator();
    User addToMe = (User)x.next();

    int count = 0;

    for (count = 0; count < 12; count++) {
      thisLine.getGmr().setValue(valKeys[count], new Float(primaryNode.getGmr().getValue(valKeys[count]).floatValue() + (addToMe.getGmr().getValue(valKeys[count])).floatValue()));
      thisLine.getRamr().setValue(valKeys[count], new Float(primaryNode.getRamr().getValue(valKeys[count]).floatValue() + (addToMe.getRamr().getValue(valKeys[count])).floatValue()));
      thisLine.getCgmr().setValue(valKeys[count], new Float(primaryNode.getCgmr().getValue(valKeys[count]).floatValue() + (addToMe.getCgmr().getValue(valKeys[count])).floatValue()));
      thisLine.getCramr().setValue(valKeys[count], new Float(primaryNode.getCramr().getValue(valKeys[count]).floatValue() + (addToMe.getCramr().getValue(valKeys[count])).floatValue()));
    }

    currentLines.addElement(thisLine);
    return currentLines;
  }


  /**
   *  Description of the Method
   *
   *@param  toRollUp      Description of Parameter
   *@param  currentLines  Description of Parameter
   *@return               Description of the Returned Value
   *@since
   */
  private UserList calculateLine(UserList toRollUp, UserList currentLines) {
    if (toRollUp.size() == 0) {
      return new UserList();
    }

    User thisLine = new User();
    String[] valKeys = thisLine.getGmr().getRange(12);

    int count = 0;

    Iterator x = toRollUp.iterator();

    while (x.hasNext()) {
      User thisUser = (User)x.next();

      for (count = 0; count < 12; count++) {
        thisLine.getGmr().setValue(valKeys[count], thisUser.getGmr().getValue(valKeys[count]));
	thisLine.getRamr().setValue(valKeys[count], thisUser.getRamr().getValue(valKeys[count]));
	thisLine.getCgmr().setValue(valKeys[count], thisUser.getCgmr().getValue(valKeys[count]));
	thisLine.getCramr().setValue(valKeys[count], thisUser.getCramr().getValue(valKeys[count]));
      }
    }

    currentLines.addElement(thisLine);
    return currentLines;
  }


  /**
   *  Description of the Method
   *
   *@return    Description of the Returned Value
   *@since
   */
  private XYDataSource createEmptyCategoryDataSource() {

    Object[][][] data;

    data = new Object[][][]{
        {
        {createDate( 2001, 12, 20),  new Integer(0)},
        {createDate( 2002, 1, 18),  new Integer(45)},
        {createDate( 2002, 2, 18),  new Integer(3)},
        {createDate( 2002, 3, 18),  new Integer(3)},
        {createDate( 2002, 4, 18),  new Integer(5)},
        {createDate( 2002, 5, 18),  new Integer(56)}
        }
        };
/**
    data = new Object[1][1][2];
    data[0][0][0] = new Integer(0);
    data[0][0][1] = new Integer(0);
*/
    return new DefaultXYDataSource(data);
  }

}

