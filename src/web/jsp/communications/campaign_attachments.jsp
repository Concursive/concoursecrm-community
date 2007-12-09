<%-- 
  - Copyright(c) 2004 Concursive Corporation (http://www.concursive.com/) All
  - rights reserved. This material cannot be distributed without written
  - permission from Concursive Corporation. Permission to use, copy, and modify
  - this material for internal use is hereby granted, provided that the above
  - copyright notice and this permission notice appear in all copies. CONCURSIVE
  - CORPORATION MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
  - IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
  - IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
  - PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
  - INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
  - EVENT SHALL CONCURSIVE CORPORATION OR ANY OF ITS AFFILIATES BE LIABLE FOR
  - ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
  - DAMAGES RELATING TO THE SOFTWARE.
  - 
  - Version: $Id$
  - Description: 
  --%>
<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
<%-- Trails --%>
<table class="trails" cellspacing="0">
<tr>
<td>
<a href="CampaignManager.do"><dhv:label name="communications.campaign.Communications">Communications</dhv:label></a> >
<dhv:label name="communications.campaign.CreateAttachments">Create Attachments</dhv:label>
</td>
</tr>
</table>
<%-- End Trails --%>
<dhv:label name="campaign.customizeCampaigns.text">Customize and configure your Campaigns with the following attachments:</dhv:label><br>
&nbsp;<br>
<dhv:permission name="campaign-campaigns-surveys-view">
<table cellpadding="4" cellspacing="0" width="100%" class="pagedList">
  <tr>
    <th>
      <strong><a href="CampaignManagerSurvey.do?command=View"><dhv:label name="campaign.surveys">Surveys</dhv:label></a></strong>
    </th>
  </tr>
  <tr class="containerBody">
    <td>
      <dhv:label name="campaign.createInteractiveSurveys.text">Create interactive surveys using quantitative, qualitative and open-ended questions. Once associated with a campaign, the responses can be reviewed and analyzed.</dhv:label>
    </td>
  </tr>
</table>
</dhv:permission>
