<a href="MyCFS.do?command=Home">My Home Page</a> >
<a href="MyCFSInbox.do?command=Inbox&return=1">My Mailbox</a> >
<% if("-1".equals(request.getParameter("noteId"))){ %>
<a href="javascript:window.location.href='MyCFSInbox.do?command=NewMessage&sendUrl='+escape('MyCFSInbox.do?command=SendMessage')+'&return='+escape('MyCFSInbox.do?command=Inbox');">New Message</a><br>
<% }else{ %>
<a href="MyCFSInbox.do?command=CFSNoteDetails&id=<%= request.getParameter("noteId") %>">Message Details</a> >
Forward Message
<%}%>
<hr color="#BFBFBB" noshade>
<%@ include file="../confirmsend.jsp" %>
