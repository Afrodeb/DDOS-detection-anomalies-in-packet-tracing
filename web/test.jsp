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
worker w=new worker();
CommonUsage c= new CommonUsage();
ClassicPcap p =new ClassicPcap();
//String r=w.capture();
//p.test();
//out.print(r.size());
//out.print(c.getPackets().size());
 List<PcapIf> alldevs = new ArrayList<PcapIf>(); // Will be filled with NICs  
        StringBuilder errbuf = new StringBuilder(); // For any error msgs  
  
        /*************************************************************************** 
         * First get a list of devices on this system 
         **************************************************************************/  
        int r = Pcap.findAllDevs(alldevs, errbuf);  
        if (r == Pcap.NOT_OK || alldevs.isEmpty()) {  
            out.print("Can't read list of devices, error is "+errbuf.toString());  
            //return;  
        }  
        System.out.println("Network devices found:<br>");  
  
        int i = 0;  
        for (PcapIf device : alldevs) {  
            String description =  
                (device.getDescription() != null) ? device.getDescription()  
                    : "No description available";  
            out.print(Integer.toString(i++) + ": "+device.getName() +"\n"+description+"<br>");  
        }  
        PcapIf device = alldevs.get(0); // We know we have atleast 1 device 
          int snaplen = 64 * 1024;           // Capture all packets, no trucation  
        int flags = Pcap.MODE_PROMISCUOUS; // capture all packets  
        int timeout = 100 * 1000;           // 10 seconds in millis  
        Pcap pcap =  
            Pcap.openLive(device.getName(), snaplen, flags, timeout, errbuf);  
  
        if (pcap == null) {  
            out.print("Error while opening device for capture: " +errbuf.toString());  
            //return;  
        } 
//       System.out o;
        ArrayList rizo=new ArrayList();
        //System out;
        PcapPacketHandler<String> jpacketHandler = new PcapPacketHandler<String>() {  
            Ip4 ip = new Ip4();
            Tcp tcp = new Tcp();
            
            byte[] dIP = new byte[4], sIP = new byte[4];
            public void nextPacket(PcapPacket packet, String user) {  
                if(packet.hasHeader(ip)){
                dIP=packet.getHeader(ip).destination();
                sIP=packet.getHeader(ip).source();
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
      //final Header annotatedHeader = header.getAnnotatedHeader(); // Annotation  
    }                  
                try{
                System.out.print(name+ "Received packet from IP: "+ sIP +" to IP :"+ dIP +" at "+ new Date(packet.getCaptureHeader().timestampInMillis()) +" caplen="+ packet.getCaptureHeader().caplen() +" len="+  packet.getCaptureHeader().wirelen() +" "+ user+"\n");                 
                }catch(Exception e){
                
                }
// rizo.add(); 
//packet.getCaptureHeader()
            }  
         };  
        //jpacketHandler        
pcap.loop(100, jpacketHandler, "jNetPcap rocks!");  
//pcap.loop(i, bbh, t)
//pcap.loop(Pcap.LOOP_INFINITE, jpacketHandler, "jNetPcap rocks!");  
%>