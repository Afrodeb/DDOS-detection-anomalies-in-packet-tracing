<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
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
        int sz=alldevs.size();
        PcapIf device = alldevs.get(0); // We know we have atleast 1 device 
          int snaplen = 64 * 1024;           // Capture all packets, no trucation  
        int flags = Pcap.MODE_PROMISCUOUS; // capture all packets  
        int timeout = 100 * 1000;           // 10 seconds in millis  
        //Pcap pcap =  
          //  Pcap.openLive(device.getName(), snaplen, flags, timeout, errbuf);  
         Pcap pcap =  
            Pcap.openLive("wlan0", snaplen, flags, timeout, errbuf); //change eth0 to 
                                                                    //whatever network device you are using
        if (pcap == null) {  
            out.print("Error while opening device for capture: " +errbuf.toString());  
        } 
        
        
        
        
        ArrayList rizo=new ArrayList();
        PcapPacketHandler<String> jpacketHandler = new PcapPacketHandler<String>() {  
            Ip4 ip = new Ip4();
            Tcp tcp = new Tcp();
            String outter="";
            String inport="0";
            String outport="0";
            HttpServletRequest request;
            HttpServletResponse response;
            int totalPackets=1;
            int totalPacketSize=0;
            int averagePacketSize=0;
            String status="Trusted";
            String lastIp="0.0.0.0";
            HashMap <String, HashMap<String,Date>> pings=new HashMap();
            Map <String,Integer> times= new HashMap<String,Integer>();
            
            byte[] dIP = new byte[4], sIP = new byte[4];
            String sourceIP="0.0.0.0";
             String destinationIP="0.0.0.0";
            public void nextPacket(PcapPacket packet, String user) {  
                if(packet.hasHeader(ip)){
                dIP=packet.getHeader(ip).destination();
                sIP=packet.getHeader(ip).source();
                sourceIP = org.jnetpcap.packet.format.FormatUtils.ip(sIP);
                destinationIP = org.jnetpcap.packet.format.FormatUtils.ip(dIP);
                }
                if(packet.hasHeader(tcp)){
              
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
//outter=name+"%%%"+ sourceIP +"%%%"+ destinationIP +"%%%"+ new Date(packet.getCaptureHeader().timestampInMillis()) +"%%%"+ packet.getCaptureHeader().caplen() +"%%%"+  packet.getCaptureHeader().wirelen() +"%%%"+ user;                
worker wkr=new worker();                   
PrintStream o = new PrintStream(new File("/home/leon/Documents/ddos/A.txt"));
PrintStream console = System.out;
System.setOut(o);

//lets work out the average packet size so that we cn compare
//-----------------
totalPackets=wkr.getTotalNumberofPackets(totalPackets);
totalPacketSize=wkr.getTotalSizeOfPackets(totalPacketSize, packet.getCaptureHeader().caplen());
averagePacketSize=wkr.getAveragePacketSize(totalPacketSize,totalPackets);
float diff= wkr.getDiff(averagePacketSize,packet.getCaptureHeader().caplen());
if(diff > 100){ //anomarly is greater than 100%
   status ="Packet Size Anomarly Detected";
    wkr.blockIPonSySystem(sourceIP);
}
if(!wkr.checkIpAndPort(inport, outport)){
     status ="Port Anomarly Detected";
      wkr.blockIPonSySystem(sourceIP);
}
/*if(pings.containsKey(sourceIP)){
    times.put(sourceIP,new Date(packet.getCaptureHeader().timestampInMillis()));
    pings.put(sourceIP,times);
    if(pings.get(sourceIP).size() > 10){
        status ="Ping Anomarly Detected";
    }
}else{//just add the ip and times   
    times.put(sourceIP,new Date(packet.getCaptureHeader().timestampInMillis()));
    pings.put(sourceIP,times);
}*/

if(times.containsKey(sourceIP)){
    int d= times.get(sourceIP)+1;
    times.put(sourceIP,d);
    if(d > 5){
        status ="Ping Anomarly Detected";
         wkr.blockIPonSySystem(sourceIP);
    }
}else{//just add the ip and times   
 times.put(sourceIP,1);
}

if((wkr.checkBlacklist(sourceIP)) || (wkr.checkBlacklist(destinationIP))){
   status="Malicious IP detected";
   wkr.blockIPonSySystem(sourceIP);//check if ip is in blacklist and block
}
//------------------


outter=name+"%%%"+ sourceIP +"%%%"+ destinationIP +"%%%"+ new Date(packet.getCaptureHeader().timestampInMillis()) +"%%%"+ packet.getCaptureHeader().caplen() +"%%%"+  packet.getCaptureHeader().wirelen() +"%%%"+ user+"%%%"+inport+"%%%"+outport+"%%%"+status+"%%%"+Integer.toString(times.size());  
outter=outter.trim();
wkr.addPacket(sourceIP,destinationIP,new Date(packet.getCaptureHeader().timestampInMillis()),name,Integer.toString(packet.getCaptureHeader().caplen()));
System.out.println(outter); 
lastIp=sourceIP;

                }catch(Exception e){                
                }
//if(session.getAttribute("email") == null){
//}
            }
         };  
        
pcap.loop(5, jpacketHandler, "");  
}
%>