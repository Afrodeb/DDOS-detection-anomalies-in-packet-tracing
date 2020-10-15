<%@page import="java.util.ArrayList"%>
<%@page import="models.user"%>
<%
String email=request.getParameter("email");
String password=request.getParameter("password");
user u=new user();
ArrayList result=u.login(email,password);
if(result.size() < 1){
response.sendRedirect("login.jsp?e=Account+not+found");
}else{
session.setAttribute("name",result.get(0).toString());
response.sendRedirect("index.jsp");
}
%>
