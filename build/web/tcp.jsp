
<%@page import="org.jnetpcap.protocol.lan.Ethernet"%>
<%@page import="org.jnetpcap.packet.JMemoryPacket"%>
<%@page import="org.jnetpcap.protocol.tcpip.Tcp"%>
<%@page import="org.jnetpcap.protocol.network.Ip4"%>
<%@page import="org.jnetpcap.protocol.JProtocol"%>
<%@page import="org.jnetpcap.packet.JPacket"%>
<%
    JPacket packet =  
      new JMemoryPacket(JProtocol.ETHERNET_ID,  
          " 001801bf 6adc0025 4bb7afec 08004500 "  
        + " 0041a983 40004006 d69ac0a8 00342f8c "  
        + " ca30c3ef 008f2e80 11f52ea8 4b578018 "  
        + " ffffa6ea 00000101 080a152e ef03002a "  
        + " 2c943538 322e3430 204e4f4f 500d0a");  
      
    Ip4 ip = packet.getHeader(new Ip4());  
    Tcp tcp = packet.getHeader(new Tcp());  
      
    tcp.destination(80);  
      
    ip.checksum(ip.calculateChecksum());  
    tcp.checksum(tcp.calculateChecksum());  
    packet.scan(Ethernet.ID);  
      
    out.println(packet);  
%>