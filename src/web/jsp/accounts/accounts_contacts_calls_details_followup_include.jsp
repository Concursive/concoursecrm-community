<%-- 
  - Copyright Notice: (C) 2000-2004 Dark Horse Ventures, All Rights Reserved.
  - License: This source code cannot be modified, distributed or used without
  -          written permission from Dark Horse Ventures. This notice must
  -          remain in place.
  - Version: $Id$
  - Description: 
  --%>
<table cellpadding="4" cellspacing="0" border="0" width="100%" class="details">
  <tr>
    <th colspan="2">
      <strong>Follow-up Activity Reminder</strong>
    </th>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Description
    </td>
    <td>
      <%= toHtml(CallDetails.getAlertText()) %>
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" valign="top">
      Notes
    </td>
    <td>
      <%= toHtml(CallDetails.getFollowupNotes()) %>
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Type
    </td>
    <td>
      <%= toHtmlValue(CallDetails.getAlertCallType()) %>&nbsp;
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Priority
    </td>
    <td>
      <%= toHtml(CallDetails.getPriorityString()) %>
    </td>
  </tr>
  <tr class="containerBody">
    <td nowrap class="formLabel" valign="top">
      Due Date
    </td>
    <td>
      <zeroio:tz timestamp="<%= CallDetails.getAlertDate() %>" default="&nbsp;" timeZone="<%= CallDetails.getAlertDateTimeZone() %>" showTimeZone="yes" default="&nbsp;" />
      <% if(!User.getTimeZone().equals(CallDetails.getAlertDateTimeZone())){%>
      <br>
      <zeroio:tz timestamp="<%= CallDetails.getAlertDate() %>" default="&nbsp;" timeZone="<%= User.getTimeZone() %>" showTimeZone="yes"  default="&nbsp;" />
      <% } %>
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Reminder
    </td>
    <td>
      <% if(CallDetails.getReminderId() > -1){ %>
        <%= CallDetails.getReminderId() %><%= ReminderTypeList.getSelectedValue(CallDetails.getReminderTypeId()) %>&nbsp; before due date  
      <% }else{ %>
        None
      <% } %>
    </td>
  </tr>
  <tr class="containerBody">
    <td class="formLabel" nowrap>
      Assigned to...
    </td>
    <td>
      <dhv:username id="<%= CallDetails.getOwner() %>"/>
    </td>
  </tr>
</table>
