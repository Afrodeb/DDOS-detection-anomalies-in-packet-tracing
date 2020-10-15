package models;
import helpers.Connector;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.InputStreamReader;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import static java.sql.Statement.RETURN_GENERATED_KEYS;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Properties;
import java.util.Random;
import java.util.Scanner;
import java.util.concurrent.TimeUnit;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import org.jnetpcap.Pcap;
import org.jnetpcap.PcapIf;
import org.jnetpcap.packet.JPacket;
import org.jnetpcap.packet.PcapPacket;
import org.jnetpcap.packet.PcapPacketHandler;
import org.jnetpcap.protocol.network.Ip4;
import org.jnetpcap.protocol.tcpip.Tcp;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 *
 * @author debmeister
 */
public class worker {
    public ArrayList rizo=new ArrayList(); 
    public String register(String name,String email,String password){
        String result="false";
                try {
Connector connector=new Connector();
Connection conn=connector.connect();
if(conn != null){
Statement statement;
    statement = conn.createStatement();

int i = statement.executeUpdate(
"INSERT INTO clients(id,name,email,password) VALUES(NULL,'"+name+"','"+email+"','"+password+"');"
);
result="Client registered successfully";
}else{
    result="connection yakatsva";
}
} catch(SQLException insertException) {
System.out.println("Error while inserting System details :"+insertException.toString());
result="Error while inserting System details :"+insertException.toString();
}
        return result;
}
           
 
        public String addPacket(String sip,String dip,Date time,String type,String sz){
        String result="false";
                try {
Connector connector=new Connector();
Connection conn=connector.connect();
if(conn != null){
Statement statement;
    statement = conn.createStatement();

int i = statement.executeUpdate(
"INSERT INTO activity_log(sip,dip,time,protocol,sz) VALUES('"+sip+"','"+dip+"','"+time+"','"+type+"','"+sz+"');"
);
result="ip registered successfully";
}else{
    result="connection yakatsva";
}
} catch(SQLException insertException) {
System.out.println("Error while inserting System details :"+insertException.toString());
result="Error while inserting System details :"+insertException.toString();
}
               // System.out.println(result);
        return result;
}
    
public ArrayList login(String email,String password){
      ArrayList result=new ArrayList();
        try {
Connector connector=new Connector();
Connection conn=connector.connect();
if(conn != null){
Statement statement;
    statement = conn.createStatement();

ResultSet rs = statement.executeQuery("SELECT patient.* FROM patient WHERE email='"+email+"' AND password='"+password+"'");
while(rs.next()){
result.add(rs.getString("name"));
result.add(rs.getString("email"));
//result.add(rs.getString("location"));
result.add(rs.getString("id"));
}
}
} catch(SQLException insertException) {
System.out.println("Error while getting users :"+insertException.toString());
result.add("Error while getting details :"+insertException.toString());
}
                
        return result;
        
    }

public String addPacket(String des,String source){
String result="";
        try {
Connector connector=new Connector();
Connection conn=connector.connect();
if(conn != null){
Statement statement;
    statement = conn.createStatement();

//int i = statement.executeUpdate(
//"INSERT INTO activity_log() VALUES(NULL,'"+id+"',NULL,'"+text+"');"
//);
result="User was successfuly added.";
}else{
    result="null";
}
} catch(SQLException insertException) {
System.out.println("Error while inserting System details :"+insertException.toString());
result="Error while inserting System details :"+insertException.toString();
}
           
        
        return result;

}

public ArrayList admins(){
      ArrayList result=new ArrayList();
      ArrayList users=new ArrayList();
        try {
Connector connector=new Connector();
Connection conn=connector.connect();
if(conn != null){
Statement statement;
    statement = conn.createStatement();

ResultSet rs = statement.executeQuery("SELECT * FROM users");
while(rs.next()){
result.add(rs.getString("name"));
result.add(rs.getString("email"));
//result.add(rs.getString("location"));
result.add(rs.getString("created"));
users.add(result);
}
}
} catch(SQLException insertException) {
System.out.println("Error while getting users :"+insertException.toString());
result.add("Error while getting details :"+insertException.toString());
}
                
        return users;
        
    }

public String deleteIP(String id){
String result="";
        try {
Connector connector=new Connector();
Connection conn=connector.connect();
if(conn != null){
Statement statement;
    statement = conn.createStatement();

int i = statement.executeUpdate(
"DELETE FROM websites WHERE id='"+id+"';"
);
result="Url was successfuly deleted.";
}else{
    result="null";
}
} catch(SQLException insertException) {
System.out.println("Error while inserting System details :"+insertException.toString());
result="Error while inserting System details :"+insertException.toString();
}
                   
        return result;
     
    }



public void addIP(String link,String wid){
   String result="";
   String type="internal";
   if(link.contains("http://")){
       type="external";
   }
        try {
Connector connector=new Connector();
Connection conn=connector.connect();
if(conn != null){
Statement statement;
    statement = conn.createStatement();

int i = statement.executeUpdate(
"INSERT INTO links(url,wid,type) VALUES('"+link+"','"+wid+"','"+type+"');"
);
result="link was successfuly added.";
}else{
    result="null";
}
} catch(SQLException insertException) {
System.out.println("Error while inserting System details :"+insertException.toString());
result="Error while inserting System details :"+insertException.toString();
}
           
       
        
 
}

public String setNotification(String text,String id){
String result="";
        try {
Connector connector=new Connector();
Connection conn=connector.connect();
if(conn != null){
Statement statement;
    statement = conn.createStatement();

int i = statement.executeUpdate(
"INSERT INTO notifications VALUES(NULL,'"+id+"',NULL,'"+text+"');"
);
result="User was successfuly added.";
}else{
    result="null";
}
} catch(SQLException insertException) {
System.out.println("Error while inserting System details :"+insertException.toString());
result="Error while inserting System details :"+insertException.toString();
}
           
        
        return result;
        
    }
  
    
      public ArrayList getNotifications(String id){
      ArrayList choices=new ArrayList();
        try {
Connector connector=new Connector();
Connection conn=connector.connect();
if(conn != null){
Statement statement;
    statement = conn.createStatement();

ResultSet rs = statement.executeQuery("SELECT * FROM notifications WHERE cid='"+id+"'");
while(rs.next()){
choices.add(rs.getString("text")+"-"+rs.getString("created"));
}
}
} catch(SQLException insertException) {
System.out.println("Error while getting users :"+insertException.toString());
//result.add("Error while getting details :"+insertException.toString());
}
                
        return choices;
        
    }
      
    
        
          

public ArrayList getSystem(){
ArrayList choices=new ArrayList();
try {
Connector connector=new Connector();
Connection conn=connector.connect();
if(conn != null){
Statement statement;
    statement = conn.createStatement();
ResultSet rs = statement.executeQuery("SELECT * FROM system WHERE id='1'");
while(rs.next()){
choices.add(rs.getString("name"));
choices.add(rs.getString("file_path"));
}
}
} catch(SQLException insertException) {
System.out.println("Error while getting users :"+insertException.toString());
//result.add("Error while getting details :"+insertException.toString());
}
                
        return choices;    
  }    


public ArrayList ip(){

 ArrayList rizo=new ArrayList();
try {
Connector connector=new Connector();
Connection conn=connector.connect();
if(conn != null){
Statement statement;
    statement = conn.createStatement();
ResultSet rs = statement.executeQuery("SELECT * FROM activity_log");
while(rs.next()){
 ArrayList cats=new ArrayList();    
cats.add(rs.getString("sip"));
cats.add(rs.getString("dip"));
cats.add(rs.getString("time"));
cats.add(rs.getString("user_agent"));
cats.add(rs.getString("protocol"));
cats.add(rs.getString("id"));
rizo.add(cats);
}
}
} catch(SQLException insertException) {
System.out.println("Error while getting users :"+insertException.toString());
//result.add("Error while getting details :"+insertException.toString());
}
                
        return rizo;     
}


public ArrayList blacklist(){
ArrayList rizo=new ArrayList();
try {
Connector connector=new Connector();
Connection conn=connector.connect();
if(conn != null){
Statement statement;
    statement = conn.createStatement();
ResultSet rs = statement.executeQuery("SELECT * FROM blacklisted");
while(rs.next()){
 ArrayList cats=new ArrayList();    
cats.add(rs.getString("source_ip"));
cats.add(rs.getString("user_port"));
cats.add(rs.getString("hostname"));
cats.add(rs.getString("external_id"));
rizo.add(cats);
}
}
} catch(SQLException insertException) {
System.out.println("Error while getting users :"+insertException.toString());
//result.add("Error while getting details :"+insertException.toString());
}
                
        return rizo;     
}

public String capture(){
List<PcapIf> alldevs = new ArrayList<PcapIf>(); // Will be filled with NICs  
        StringBuilder errbuf = new StringBuilder(); // For any error msgs  
  
        /*************************************************************************** 
         * First get a list of devices on this system 
         **************************************************************************/  
        int r = Pcap.findAllDevs(alldevs, errbuf);  
        if (r == Pcap.NOT_OK || alldevs.isEmpty()) {  
            return "Can't read list of devices, error is " + errbuf.toString();  
           // return;  
        }  
  
        System.out.println("Network devices found:");  
  
        int i = 0;  
        for (PcapIf device : alldevs) {  
            String description =  
                (device.getDescription() != null) ? device.getDescription()  
                    : "No description available";  
            System.out.printf("#%d: %s [%s]\n", i++, device.getName(), description);  
        }  
  
        PcapIf device = alldevs.get(0); // We know we have atleast 1 device  
        System.out  
            .printf("\nChoosing '%s' on your behalf:\n",  
                (device.getDescription() != null) ? device.getDescription()  
                    : device.getName());  
  
        /*************************************************************************** 
         * Second we open up the selected device 
         **************************************************************************/  
        int snaplen = 64 * 1024;           // Capture all packets, no trucation  
        int flags = Pcap.MODE_PROMISCUOUS; // capture all packets  
        int timeout = 10 * 1000;           // 10 seconds in millis  
        Pcap pcap =  
            Pcap.openLive(device.getName(), snaplen, flags, timeout, errbuf);  
  
        if (pcap == null) {  
            System.err.printf("Error while opening device for capture: "  
                + errbuf.toString());  
            return "";  
        }  
  
        /*************************************************************************** 
         * Third we create a packet handler which will receive packets from the 
         * libpcap loop. 
         **************************************************************************/  
        PcapPacketHandler<String> jpacketHandler = new PcapPacketHandler<String>() {  
  
            public void nextPacket(PcapPacket packet, String user) {  
  
                System.out.printf("Received packet at %s caplen=%-4d len=%-4d %s\n",  
                    new Date(packet.getCaptureHeader().timestampInMillis()),   
                    packet.getCaptureHeader().caplen(),  // Length actually captured  
                    packet.getCaptureHeader().wirelen(), // Original length   
                    user                                 // User supplied object  
                    );  
            }  
        };  
  
        /*************************************************************************** 
         * Fourth we enter the loop and tell it to capture 10 packets. The loop 
         * method does a mapping of pcap.datalink() DLT value to JProtocol ID, which 
         * is needed by JScanner. The scanner scans the packet buffer and decodes 
         * the headers. The mapping is done automatically, although a variation on 
         * the loop method exists that allows the programmer to sepecify exactly 
         * which protocol ID to use as the data link type for this pcap interface. 
         **************************************************************************/  
        pcap.loop(10, jpacketHandler, "jNetPcap rocks!");  
  
        /*************************************************************************** 
         * Last thing to do is close the pcap handle 
         **************************************************************************/  
        pcap.close(); 
    return "";
} 

 public String test() {  
   
    return "no-error";
  }  
 
 public void blockIPonSySystem(String ip){
     try{       
         Process proc =Runtime.getRuntime().exec("ufw deny from "+ ip +" to any");
         //Process proc =Runtime.getRuntime().exec("ufw status numbered");
          BufferedReader reader =  
              new BufferedReader(new InputStreamReader(proc.getInputStream()));

        String line = "";
        while((line = reader.readLine()) != null) {
            System.out.print(line + "\n");
        }

        proc.waitFor();   

    
   /*  String[] args = new String[] {"ufw deny from "+ ip +" to any"};
     Process proc = new ProcessBuilder(args).start();
     BufferedReader reader =  
              new BufferedReader(new InputStreamReader(proc.getInputStream()));

        String line = "";
        while((line = reader.readLine()) != null) {
            System.out.print(line + "\n");
        }
        proc.waitFor();  */ 
     }catch(Exception e){
     
     }
     
     
     
 }

 public boolean checkIpAndPort(String iport,String oport){
     boolean result=true;
   //  if(sip.equals(dip)){
         if(iport.equals(oport)){
             result=false;
         }
 //    }
     return result;
 }
 public boolean checkSyn(JPacket packet,Ip4 ip,Tcp tcp){
     boolean result=true;
     if (!packet.hasHeader(ip) || !packet.hasHeader(tcp)) {
                   result=false;
                }
     return result;
 } 

 public int getTotalNumberofPackets(int n){
     return n+1;
 }
 
 public int getTotalSizeOfPackets(int total,int sz){
     return total+sz;
 }
 
 public int getAveragePacketSize(int total,int sz){
     return (total)/sz;
 }
 
 public float getDiff(int one,int two){
     float diff=0;
     if((one != 0) && (two != 0)){
     diff=((one-two)/one)*100;
     if(diff < 0){
         diff=diff * -1;
     }
     }
     return diff;
 } 
 
 
 public long diff(Date d1,Date d2, TimeUnit timeUnit){
    
    long diffInMillies = d1.getTime() - d2.getTime();
    return timeUnit.convert(diffInMillies,TimeUnit.MILLISECONDS);
     
 } 
 
 public void prepareDatabase(){
     File file = new File("/home/debmeister/NetBeansProjects/ddos/mixed/blacklist.txt");

    try {

        Scanner sc = new Scanner(file);

        while (sc.hasNextLine()) {
            String i = sc.nextLine();
            System.out.println(i);
        }
        sc.close();
    } 
    catch (FileNotFoundException e) {
        e.printStackTrace();
    }
 }
 
 
public boolean checkBlacklist(String ip){
ArrayList rizo=new ArrayList();
boolean result=false;
try {
Connector connector=new Connector();
Connection conn=connector.connect();
if(conn != null){
Statement statement;
    statement = conn.createStatement();
ResultSet rs = statement.executeQuery("SELECT * FROM ipblacklist WHERE IPAddress='"+ip+"'");
while(rs.next()){
    result=true;
}
}
} catch(SQLException insertException) {
System.out.println("Error while getting users :"+insertException.toString());
}                
return result;     
}
 
}
