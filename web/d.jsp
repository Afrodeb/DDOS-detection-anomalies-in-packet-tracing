<%@page import="models.worker"%>
<%
worker wkr=new worker();                   
if(wkr.checkBlacklist("1.0.0.4")){
    out.print("found");
}

%>