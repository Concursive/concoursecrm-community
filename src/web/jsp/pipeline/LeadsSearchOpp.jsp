<body onLoad="javascript:document.forms[0].searchDescription.focus();">
<form name="searchLeads" action="/Leads.do?command=ViewOpp" method="post">
<br>
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">

  <tr bgcolor="#DEE0FA">
    <td colspan=2 valign=center align=left>
    <strong>Search Pipeline</strong>
    </td>     
  </tr>
  
  <tr><td width="125" class="formLabel">
Description
</td>
<td colspan=1 valign=center>
<input type=text size=35 name="searchDescription">
</td>
</tr>

</table>
&nbsp;<br>
<input type=submit value="Search">
<input type=reset value="Clear">
</form>
</body>
