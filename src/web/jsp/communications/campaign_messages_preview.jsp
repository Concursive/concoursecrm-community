<%@ page import="java.util.*,com.darkhorseventures.cfsbase.*" %>
<jsp:useBean id="Message" class="com.darkhorseventures.cfsbase.Message" scope="request"/>
<%@ include file="initPage.jsp" %>
<font size="-1" face="Arial, Helvetica, sans-serif">
From: <%= Message.getReplyTo() %><br>
Subject: <%= toHtml(Message.getMessageSubject()) %><br>&nbsp;<br>
<%= Message.getMessageText() %> 
</font>
