<%@ include file="initPage.jsp" %>

<script language="JavaScript">
  function checkForm(form) {
      formTest = true;
      message = "";
      if ((form.subject.value == "")) { 
        message += "- A subject is required\r\n";
        formTest = false;
      }
      if (formTest == false) {
        alert("Form could not be saved, please check the following:\r\n\r\n" + message);
        return false;
      } else {
        return true;
      }
    }
</script>

<body onLoad="javascript:document.forms[0].subject.focus();">
<form name="generate" action="/Accounts.do?command=ExportReport" method="post" onSubmit="return checkForm(this);">
<input type="submit" value="Generate">
<input type="button" value="Cancel" onClick="javascript:this.form.action='/Accounts.do?command=Reports';javascript:this.form.submit();">
<br>
&nbsp;
<table cellpadding="4" cellspacing="0" border="1" width="100%" bordercolorlight="#000000" bordercolor="#FFFFFF">
  <tr bgcolor="#DEE0FA">
    <td colspan=2 valign=center align=left>
      <strong>Generate a New Report</strong>
    </td>     
  </tr>
  
  <tr>
    <td nowrap class="formLabel">
      Report Type
    </td>
    <td>
      <select name="type">
      <option value="1">All Accounts</option>
      <option value="2">Accounts w/Contacts</option>
      <option value="3">Accounts w/Tickets</option>
      <option value="4">Accounts w/Folders</option>
      <option value="5">Accounts w/Opportunities</option>
      </select>
    </td>
  </tr>
  
  <tr>
    <td nowrap class="formLabel">
      Report Subject
    </td>
    <td>
      <input type=text size=35 name="subject" maxlength=50>
    </td>
  </tr>
  
  <tr>
    <td nowrap valign=top class="formLabel">
      Included Fields
    </td>
    <td>
      <select size=5 multiple name="fields">
      <option value="1" selected>Account Name</option>
      <option value="2" selected>Account No.</option>
      <option value="3" selected>URL</option>
      <option value="4" selected>Ticker</option>
      <option value="5" selected>Employees</option>
      <option value="6" selected>Entered</option>
      <option value="7" selected>Entered By</option>
      <option value="8" selected>Modified</option>
      <option value="9" selected>Modified By</option>
      <option value="10" selected>Owner</option>
      <option value="11" selected>Contract End Date</option>
      <option value="12" selected>Notes</option>
      </select>
    </td>
  </tr>
  
</table>
<br>
<input type="submit" value="Generate">
<input type="button" value="Cancel" onClick="javascript:this.form.action='/Accounts.do?command=Reports';javascript:this.form.submit();">
</form>
</body>
