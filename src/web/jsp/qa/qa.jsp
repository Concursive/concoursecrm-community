<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%@ page import="java.util.*,org.aspcfs.modules.help.base.*" %>
<jsp:useBean id="Help" class="org.aspcfs.modules.help.base.HelpItem" scope="request"/>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/popURL.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/images.js"></SCRIPT>
<SCRIPT LANGUAGE="JavaScript" TYPE="text/javascript" SRC="javascript/confirmDelete.js"></SCRIPT>
<%@ include file="../initPage.jsp" %>
<table border="0" width="100%" cellspacing="0" cellpadding="0">
  <%-- Introduction --%>
  <tr>
    <td>
      <table border="0" cellpadding="4" cellspacing="0" width="100%">
       <tr>
         <td valign="top">
          <strong>Introduction:</strong>
         </td>
         <td>
        <a href="javascript:popURL('QA.do?command=ModifyIntro&id=<%= Help.getId() %>&popup=true', 'QA_Intro','500','200','yes','yes');"> <%=  !"".equals(toString(Help.getDescription())) ? toHtml(Help.getDescription()) : "Click to add description" %></a>
        </td>
       </tr>
     </table>
      <hr color="#BFBFBB" noshade>
    </td>
  </tr>
  <tr>
    <td>
    <%-- List the General Features --%>
     <table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
     <tr>
       <th>
          <strong>General Features supported on this page</strong> [<a href="javascript:popURL('HelpFeatures.do?command=PrepareFeature&linkHelpId=<%= Help.getId()%>&popup=true', 'QA_Feature_Add','600','240','yes','yes');">Add New</a>]
       </th>
      </tr>
      <%
        Iterator i = Help.getFeatures().iterator();
        if(i.hasNext()){
          while(i.hasNext()){
           HelpFeature thisFeature = (HelpFeature) i.next();
       %>
          <tr>
            <td align="left">
              <a href="javascript:popURL('HelpFeatures.do?command=ModifyFeature&id=<%= thisFeature.getId() %>&linkHelpId=<%= Help.getId() %>&popup=true', 'QA_Feature_Add','600','240','yes','yes');">Edit</a>&nbsp;<a href="javascript:confirmDelete('HelpFeatures.do?command=DeleteFeature&id=<%= thisFeature.getId() %>')">Del</a>&nbsp;
              <a href="javascript:changeImages('feature<%= thisFeature.getId() %>','QA.do?command=ProcessFeature&id=box.gif|gif|'+<%= thisFeature.getId() %>+'|<%= thisFeature.getComplete() ? "0" : "1" %>','QA.do?command=ProcessFeature&id=box-checked.gif|gif|'+<%= thisFeature.getId() %>+'|1');"  onMouseOver="this.style.color='blue';window.status='Change Status';return true;" onMouseOut="this.style.color='black';window.status='';return true;"><img src="images/<%= thisFeature.getComplete() ? "box-checked.gif" : "box.gif" %>" name="feature<%= thisFeature.getId() %>" id="1" border="0" title="Click to change"></a><%= toHtml(thisFeature.getDescription())%>
            </td>
          </tr>
       <% }
        }else{
      %>
        <tr>
          <td>
            No features found
          </td>
        </tr>
      <%}%>
      </table><br>
      <%-- List the Business Rules --%>
      <table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
       <tr>
        <th>
          <strong>Business Rules supported on this page</strong> [<a href="javascript:popURL('HelpRules.do?command=PrepareRule&linkHelpId=<%= Help.getId()%>&popup=true', 'QA_Rule_Add','600','175','yes','yes');">Add New</a>]
        </th>
      </tr>
        <%
          Iterator br = Help.getBusinessRules().iterator();
          if(br.hasNext()){
            while(br.hasNext()){
             HelpBusinessRule thisRule = (HelpBusinessRule) br.next();
         %>
            <tr>
              <td align="left">
                <a href="javascript:popURL('HelpRules.do?command=ModifyRule&id=<%= thisRule.getId() %>&linkHelpId=<%= Help.getId() %>&popup=true', 'QA_Rule_Add','600','175','yes','yes');">Edit</a>&nbsp;<a href="javascript:confirmDelete('HelpRules.do?command=DeleteRule&id=<%= thisRule.getId() %>')">Del</a>&nbsp;
                <a href="javascript:changeImages('rule<%= thisRule.getId() %>','QA.do?command=ProcessRule&id=box.gif|gif|'+<%= thisRule.getId() %>+'|<%= thisRule.getComplete() ? "0" : "1" %>','QA.do?command=ProcessRule&id=box-checked.gif|gif|'+<%= thisRule.getId() %>+'|1');"  onMouseOver="this.style.color='blue';window.status='Change Status';return true;" onMouseOut="this.style.color='black';window.status='';return true;"><img src="images/<%= thisRule.getComplete() ? "box-checked.gif" : "box.gif" %>" name="rule<%= thisRule.getId() %>" id="1" border="0" title="Click to change"></a><%= toHtml(thisRule.getDescription()) %>
              </td>
            </tr>
         <% }
          }else{
        %>
          <tr>
            <td>
              No rules found
            </td>
          </tr>
        <%}%>
      </table><br>
      <%-- List the Notes --%>
      <table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
     <tr>
      <th>
        <strong>Notes on this page</strong> [<a href="javascript:popURL('HelpNotes.do?command=PrepareNote&linkHelpId=<%= Help.getId()%>&popup=true', 'QA_Note_Add','600','175','yes','yes');">Add New</a>]
      </th>
     </tr>
        <%
          Iterator notes = Help.getNotes().iterator();
          if(notes.hasNext()){
            while(notes.hasNext()){
             HelpNote thisNote = (HelpNote) notes.next();
         %>
            <tr>
              <td align="left">
                <a href="javascript:popURL('HelpNotes.do?command=ModifyNote&id=<%= thisNote.getId() %>&linkHelpId=<%= Help.getId() %>&popup=true', 'QA_Note_Add','600','175','yes','yes');">Edit</a>&nbsp;<a href="javascript:confirmDelete('HelpNotes.do?command=DeleteNote&id=<%= thisNote.getId() %>')">Del</a>&nbsp;
                <a href="javascript:changeImages('note<%= thisNote.getId() %>','QA.do?command=ProcessNote&id=box.gif|gif|'+<%= thisNote.getId() %>+'|<%= thisNote.getComplete() ? "0" : "1" %>','QA.do?command=ProcessNote&id=box-checked.gif|gif|'+<%= thisNote.getId() %>+'|1');"  onMouseOver="this.style.color='blue';window.status='Change Status';return true;" onMouseOut="this.style.color='black';window.status='';return true;"><img src="images/<%= thisNote.getComplete() ? "box-checked.gif" : "box.gif" %>" name="note<%= thisNote.getId() %>" id="1" border="0" title="Click to change"></a><%= toHtml(thisNote.getDescription()) %>
              </td>
            </tr>
         <% }
          }else{
        %>
        <tr>
          <td>
            No notes found
          </td>
        </tr>
      <%}%>
      </table><br>
      <%-- List the Tips --%>
      <table cellpadding="2" cellspacing="0" width="100%" class="pagedList">
     <tr>
      <th>
        <strong>Tips on this page</strong> [<a href="javascript:popURL('HelpTips.do?command=PrepareTip&linkHelpId=<%= Help.getId()%>&popup=true', 'QA_Tip_Add','600','175','yes','yes');">Add New</a>]
      </th>
     </tr>
        <%
          Iterator tips = Help.getTips().iterator();
          if(tips.hasNext()){
            while(tips.hasNext()){
             HelpTip thisTip = (HelpTip) tips.next();
         %>
            <tr>
              <td align="left">
                <a href="javascript:popURL('HelpTips.do?command=ModifyTip&id=<%= thisTip.getId() %>&linkHelpId=<%= Help.getId() %>&popup=true', 'QA_Tip_Add','600','175','yes','yes');">Edit</a>&nbsp;<a href="javascript:confirmDelete('HelpTips.do?command=DeleteTip&id=<%= thisTip.getId() %>')">Del</a>&nbsp;<%= toHtml(thisTip.getDescription()) %>
              </td>
            </tr>
         <% }
          }else{
        %>
        <tr>
          <td>
            No tips found
          </td>
        </tr>
      <%}%>
      </table>
    </td>
  </tr>
  <tr>
    <td>
      <br><input type="button" value="Close" onClick="javascript:window.close();">
    </td>
  </tr>
</table>
