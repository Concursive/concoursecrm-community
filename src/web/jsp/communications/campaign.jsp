<%@ taglib uri="/WEB-INF/dhv-taglib.tld" prefix="dhv" %>
Communications Manager
<hr color="#BFBFBB" noshade>
Review and manage campaigns with the following options:<br>
<dhv:permission name="campaign-campaigns-add">
&nbsp;<br>
<table cellpadding="4" cellspacing="0" width="100%" class="details">
  <tr>
    <th>
      <strong><a href="CampaignManager.do?command=Dashboard">Dashboard</a></strong>
    </th>
  </tr>
  <tr class="containerBody">
    <td>
      Track and analyze campaigns that have been activated and executed.<br>
      &nbsp;<br>
      Messages can be sent out by any combination of email, fax, or mail merge.
      The Dashboard shows an overview of sent messages and allows you to
      drill down and view recipients and any survey results.<br>
      &nbsp;<br>
      Choose <a href="CampaignManager.do?command=Add">Add Campaign</a> to create a new campaign.
    </td>
  </tr>
</table>
</dhv:permission>
<dhv:permission name="campaign-campaigns-view">
&nbsp;<br>
<table cellpadding="4" cellspacing="0" width="100%" class="details">
  <tr>
    <th>
      <strong><a href="CampaignManager.do?command=View">Campaign Builder</a></strong>
    </th>
  </tr>
  <tr class="containerBody">
    <td>
      Create or work on existing campaigns.<br>
      &nbsp;<br>
      The Campaign Builder allows you
      to select groups of contacts that you would like to send a message to, as
      well as schedule a delivery date.  Additional options are available.<br>
      &nbsp;<br>
      Distribution groups can be constructed in the
      <a href="CampaignManagerGroup.do?command=View">Build Groups</a> utility, and
      messages can be written in the 
      <a href="CampaignManagerMessage.do?command=View">Create Messages</a> utility.
    </td>
  </tr>
</table>
</dhv:permission>
<dhv:permission name="campaign-campaigns-groups-view">
&nbsp;<br>
<table cellpadding="4" cellspacing="0" width="100%" class="details">
  <tr>
    <th>
      <strong><a href="CampaignManagerGroup.do?command=View">Build Groups</a></strong>
    </th>
  </tr>
  <tr class="containerBody">
    <td>
      Assemble dynamic distribution groups.<br>
      &nbsp;<br>
      Each campaign needs at least one group to send a message to.
      Use criteria to filter the contacts you need to reach and use
      them over and over again.  As new contacts meet the criteria,
      they will be included in future campaigns.
    </td>
  </tr>
</table>
</dhv:permission>
<dhv:permission name="campaign-campaigns-messages-view">
&nbsp;<br>
<table cellpadding="4" cellspacing="0" width="100%" class="details">
  <tr>
    <th>
      <strong><a href="CampaignManagerMessage.do?command=View">Create Messages</a></strong>
    </th>
  </tr>
  <tr class="containerBody">
    <td>
      Compose a message to reach your audience.<br>
      &nbsp;<br>
      Each campaign requires a message that will be sent to
      selected groups.  Write the message once, then use it
      in any number of future campaigns.  Modified messages
      will only affect future campaigns.
    </td>
  </tr>
</table>
</dhv:permission>
<dhv:permission name="campaign-campaigns-surveys-view">
&nbsp;<br>
<table cellpadding="4" cellspacing="0" width="100%" class="details">
  <tr>
    <th>
      <strong><a href="CampaignManagerAttachment.do">Create Attachments</a></strong>
    </th>
  </tr>
  <tr class="containerBody">
    <td>
      Interact with your recipients.<br>
      &nbsp;<br>
      Attachments can include interactive items, like surveys, or
      provide additional materials like files.
    </td>
  </tr>
</table>
</dhv:permission>
