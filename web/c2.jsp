<%@page import="java.io.File"%>
<%@page import="java.io.PrintStream"%>
<%@page import="java.io.PrintWriter"%>
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
<%
final worker w=new worker();
CommonUsage c= new CommonUsage();
ClassicPcap p =new ClassicPcap();
String outter=""; 
 List<PcapIf> alldevs = new ArrayList<PcapIf>(); // Will be filled with NICs  
        StringBuilder errbuf = new StringBuilder(); // For any error msgs  
        int r = Pcap.findAllDevs(alldevs, errbuf);  
        if (r == Pcap.NOT_OK || alldevs.isEmpty()) {  
            out.print("Can't read list of devices, error is "+errbuf.toString());  
        }  
        //System.out.println("Network devices found:<br>");  
  if(alldevs.size() > 0){
        int i = 0;  
        for (PcapIf device : alldevs) {  
            String description =  
                (device.getDescription() != null) ? device.getDescription()  
                    : "No description available";  
          //  out.print(Integer.toString(i++) + ": "+device.getName() +"\n"+description+"<br>");  
        }  
        int v=alldevs.size();
      //  for(int j=0; j< v; j++){
            
        PcapIf device = alldevs.get(v-1); // We know we have atleast 1 device 
          int snaplen = 64 * 1024;           // Capture all packets, no trucation  
        int flags = Pcap.MODE_PROMISCUOUS; // capture all packets  
        int timeout = 100 * 1000;           // 10 seconds in millis  
        Pcap pcap =  
            Pcap.openLive(device.getName(), snaplen, flags, timeout, errbuf);  
        if (pcap == null) {  
            out.print("Error while opening device for capture: " +errbuf.toString());  
        } 
        ArrayList rizo=new ArrayList();
        PcapPacketHandler<String> jpacketHandler = new PcapPacketHandler<String>() {  
            Ip4 ip = new Ip4();
            Tcp tcp = new Tcp();
            String inport="";
            String outport="";
            String outter="";
            HttpServletRequest request;
            HttpServletResponse response;
            
            byte[] dIP = new byte[4], sIP = new byte[4];
            String sourceIP="0.0.0.0";
             String destinationIP="0.0.0.0";
            public void nextPacket(PcapPacket packet, String user) {  
                if(packet.hasHeader(ip) && packet.hasHeader(tcp)){
                dIP=packet.getHeader(ip).destination();
                sIP=packet.getHeader(ip).source();
                 sourceIP = org.jnetpcap.packet.format.FormatUtils.ip(sIP);
            destinationIP = org.jnetpcap.packet.format.FormatUtils.ip(dIP);
            inport=Integer.toString(tcp.source());
            outport=Integer.toString(tcp.destination());
                }
    String name="";         
    final JHeaderPool headers = new JHeaderPool();  
    final int count = packet.getHeaderCount();  
    for (int i = 0; i < count; i++) {  
      final int id = packet.getHeaderIdByIndex(i); // Numerical ID of the header  
      final JHeader header = headers.getHeader(id);  
       name= header.getName();  
      final String nicname = header.getNicname();  
      final String description = header.getDescription();  
      final JField[] fields = header.getFields();  
    }                  
                try{
outter=name+"%%%"+ sourceIP +"%%%"+ destinationIP +"%%%"+ new Date(packet.getCaptureHeader().timestampInMillis()) +"%%%"+ packet.getCaptureHeader().caplen() +"%%%"+  packet.getCaptureHeader().wirelen() +"%%%"+ user+"%%%"+inport+"%%%"+outport;                
                   outter=outter.trim();
worker wkr=new worker();                   
PrintStream o = new PrintStream(new File("/home/debmeister/Documents/ddos/A.txt"));
PrintStream console = System.out;
System.setOut(o);
wkr.addPacket(sourceIP,destinationIP,new Date(packet.getCaptureHeader().timestampInMillis()),name,Integer.toString(packet.getCaptureHeader().caplen()));
System.out.println(outter); 


                }catch(Exception e){                
                }
            }
         };  
pcap.loop(Pcap.LOOP_INFINITE, jpacketHandler, "");  
 // }
}
%>