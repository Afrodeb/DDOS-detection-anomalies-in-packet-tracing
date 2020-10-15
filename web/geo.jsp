<%@page import="models.worker"%>
<%@page import="helpers.GeoIPv4"%>
<%
String sip=request.getParameter("sip");
String dip=request.getParameter("dip");
GeoIPv4 geo=new GeoIPv4();
String slat=geo.getLatitude(sip);
String slon=geo.getLongitude(sip);

String dlat=geo.getLatitude(dip);
String dlon=geo.getLongitude(dip);

if((slat == null) || (slat.equals("N/A"))){
    slat="0.0";
}

if((dlat == null) || (dlat.equals("N/A"))){
    dlat="0.0";
}

if((slon == null) || (slon.equals("N/A"))){
    slon="0.0";
}

if((dlon == null) || (dlon.equals("N/A"))){
    dlon="0.0";
}
out.print(slat+","+slon+"%%%"+dlat+","+dlon);
%>