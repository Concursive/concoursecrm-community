<jsp:useBean id="ContactDetails" class="org.aspcfs.modules.contacts.base.Contact" scope="request"/>
<html>
<script type="text/javascript">
  function addContact(text, value){
    opener.insertOption(text, value, 'contactId');
  }
</script>
  <body onload="javascript:addContact('<%= ContactDetails.getNameLastFirst() %>','<%= ContactDetails.getId() %>');window.close();">
</body>
</html>
