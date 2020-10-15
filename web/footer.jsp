<%@page import="org.jnetpcap.packet.JHeader"%>
<%@page import="org.jnetpcap.packet.JHeaderPool"%>
<%@page import="org.jnetpcap.packet.structure.JField"%>
<%@page import="org.jnetpcap.protocol.network.Ip4"%>
<%@page import="org.jnetpcap.protocol.tcpip.Tcp"%>
<%@page import="models.ClassicPcap"%>
<%@page import="models.CommonUsage"%>
<%@page import="models.worker"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>  
<%@page import="java.util.List"%>   
<%@page import="org.jnetpcap.Pcap"%>  
<%@page import="org.jnetpcap.PcapIf"%>  
<%@page import="org.jnetpcap.packet.PcapPacket"%>  
<%@page import="org.jnetpcap.packet.PcapPacketHandler"%>
<script src="assets/plugins/jquery-1.10.2.js"></script>
<script src="assets/plugins/bootstrap/bootstrap.min.js"></script>
<script src="assets/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="assets/plugins/pace/pace.js"></script>
<script src="assets/scripts/siminta.js"></script>
<!-- Page-Level Plugin Scripts-->
<script src="assets/plugins/dataTables/jquery.dataTables.js"></script>
<script src="assets/plugins/dataTables/dataTables.bootstrap.js"></script>
  <script src="assets/scripts/d3.v3.min.js"></script>
  <script src="assets/scripts/topojson.v1.min.js"></script>
  <!-- I recommend you host this file on your own, since this will change without warning -->
  <script src="assets/scripts/datamaps.world.min.js?v=1"></script>
<script>
    $(function() {
        $("#start").click(function() {
                           var protocol ="";
                            var dIP = "0.0.0.0";
                            var sIP ="0.0.0.0";
                            var dt = "";
                            var len1 = ""
                            var len2 = "";
                            var status="";
                            var arcs=[];
                            
                            
                                                     
        var map = new Datamap({
        scope: 'world',
        element: document.getElementById('container1'),
        projection: 'mercator',
        height: 500,
        fills: {
          defaultFill: '#f0af0a',
          lt50: 'rgba(0,244,244,0.9)',
          gt50: 'red'
        },
        
        data: {
          USA: {fillKey: 'lt50' },
          RUS: {fillKey: 'lt50' },
          CAN: {fillKey: 'lt50' },
          BRA: {fillKey: 'gt50' },
          ARG: {fillKey: 'gt50'},
          COL: {fillKey: 'gt50' },
          AUS: {fillKey: 'gt50' },
          ZAF: {fillKey: 'gt50' },
          MAD: {fillKey: 'gt50' }       
        }
      });

                            
                            
            setInterval(function() {
                $.ajax({
                   url: "capture.jsp",
                    context: document.body
                }).done(function(ret2) {
                    
                });

                $.ajax({
                url: "retrieve.jsp",
                        context: document.body
                }).done(function(ret) {                    
                    var res = ret.split("%%%");
                    //alert(ret);
                    //console.log(ret);
                    console.log(res.length);
                    if (res.length > 4){
                             protocol = res[0];
                             dIP = res[1];
                             sIP = res[2];
                             dt = res[3];
                             len1 = res[4];
                             len2 = res[5];
                             status=res[9];
                             console.log(res[res.length-1]);
                            var out = "<tr><td>" + protocol + "</td><td>" + dIP + "</td><td>" + sIP + "</td><td>" + dt + "</td><td>" + len2 + "</td><td style='background-color: green; color:black;'>" + status + "</td></tr>";
                            if(status != "Trusted"){
                            var out = "<tr><td>" + protocol + "</td><td>" + dIP + "</td><td>" + sIP + "</td><td>" + dt + "</td><td>" + len2 + "</td><td style='background-color: red; color:white;'>" + status + "</td></tr>";
                            }
 $(out).prependTo("#monitor");
    }
                });
                
          $.ajax({
                   url: "geo.jsp",
                   method: "post",
                   data:"sip="+sIP+"&dip="+dIP,
                   context: document.body
                }).done(function(ret3) {
                    
                 var geos = ret3.split("%%%");       
                 var s=geos[0].split(",");
                 var d=geos[1].split(",");
                 var slat=s[0];
                 var slon=s[1];
                 var dlat=d[0];
                 var dlon=d[1];
                 
      
      //map.arc(arcs, {strokeWidth: 2});
       
   // console.log(slat+"-"+slon+"&&"+dlat+"-"+dlon);
     arcs.push({
          origin: {
              latitude: slat,
              longitude: slon
          },
          destination: {
              latitude: dlat,
              longitude: dlon
          }
      });
      map.arc(arcs, {strokeWidth: 2});
      
  
                    
                });
       
                
            }, 3000);
            
            
            
            
        });
    });
</script>

</body>

</html>
