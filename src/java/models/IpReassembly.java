/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package models;

import org.jnetpcap.Pcap;
import org.jnetpcap.packet.PcapPacket;
import org.jnetpcap.packet.PcapPacketHandler;
import org.jnetpcap.protocol.network.Ip4;

/**
 *
 * @author debmeister
 */
public class IpReassembly {
  /*    private Ip4 ip = new Ip4(); // Ip4 header  
     private IpReassembly(int i, IpReassemblyBufferHandler ipReassemblyBufferHandler) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }
    public static void main(String[] args) {  
    StringBuilder errbuf = new StringBuilder();  
    Pcap pcap = Pcap.openOffline("/home/debmeister/NetBeansProjects/ddos/mixed/jnetpcap-src-1.3.0-1/tests/tests/test-ipreassembly2.pcap", errbuf);  
    if (pcap == null) {  
      System.err.println(errbuf.toString());  
      return;  
    }  
  
    pcap.loop(  
      6, // Collect 6 packets  
      new IpReassembly(  
        5 * 1000, // 5 second timeout for reassembly buffer  
        new IpReassemblyBufferHandler() {}),  
      "");  
  }  

    @Override
      public void nextPacket(PcapPacket packet, Object user) {  
  
    if (packet.hasHeader(ip)) {  
      final int flags = ip.flags();  
  
     
      if ((flags & Ip4.FLAG_MORE_FRAGEMNTS) != 0) {  
        bufferFragment(packet, ip);  
  
         
      } else {  
        bufferLastFragment(packet, ip);  
      }  
  
     
      timeoutBuffers();  
    }  
  } 

*/   
}

