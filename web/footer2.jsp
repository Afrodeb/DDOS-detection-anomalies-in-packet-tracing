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
<!-- 
<script src="assets/plugins/flot/jquery.flot.js"></script>
<script src="assets/plugins/flot/jquery.flot.tooltip.min.js"></script>
<script src="assets/plugins/flot/jquery.flot.resize.js"></script>
<script src="assets/plugins/flot/jquery.flot.pie.js"></script>
<script src="assets/scripts/flot-demo.js"></script>-->
<script>
$(function() {
   
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
                //var y = previous + ret * 10 - 5;
                //data.push(y < 0 ? 0 : y > 100 ? 100 : y);

                console.log(ret);

                if (ret > 100) {
                    ret = 99;
                }
                
            });
        }, 1000);
  });
  //  
        /*alert("h");
        var container = $("#flot-line-chart-moving");
        var maximum = container.outerWidth() / 2 || 300;
        var data = [];
        var res = [];
        var myVar;
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
                //var y = previous + ret * 10 - 5;
                //data.push(y < 0 ? 0 : y > 100 ? 100 : y);

                console.log(ret);

                if (ret > 100) {
                    ret = 99;
                }
                data.push(ret);
            });
        }, 1000);

        function getRandomData() {


            //for (var i = 0; i < data.length; ++i) {
            var i = 0;
            for (var i = 0; i < 10000; ++i) {
                //while(1 == 1){
                res.push([i, data[i]]);
                i++;
            }

            return res;
        }
        //}
        //

        series = [{
                data: getRandomData(),
                lines: {
                    fill: false
                }
            }];

        //

        var plot = $.plot(container, series, {
            grid: {
                borderWidth: 1,
                minBorderMargin: 20,
                labelMargin: 10,
                backgroundColor: {
                    colors: ["#fff", "#e4f4f4"]
                },
                margin: {
                    top: 8,
                    bottom: 20,
                    left: 20
                },
                markings: function(axes) {
                    var markings = [];
                    var xaxis = axes.xaxis;
                    for (var x = Math.floor(xaxis.min); x < xaxis.max; x += xaxis.tickSize * 2) {
                        markings.push({
                            xaxis: {
                                from: x,
                                to: x + xaxis.tickSize
                            },
                            color: "rgba(232, 232, 255, 0.2)"
                        });
                    }
                    return markings;
                }
            },
            xaxis: {
                tickFormatter: function() {
                    return "";
                }
            },
            yaxis: {
                min: 0,
                max: 110
            },
            legend: {
                show: true
            }
        });

        // Update the random dataset at 25FPS for a smoothly-animating chart

        setInterval(function updateRandom() {
            series[0].data = getRandomData();
            plot.setData(series);
            plot.draw();
        }, 40);
        $('#dataTables-example').dataTable();*/
   //
</script>

</body>

</html>
