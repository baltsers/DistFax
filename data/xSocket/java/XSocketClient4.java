import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;   
import java.lang.management.ManagementFactory;    
import org.xsocket.connection.BlockingConnection;   
import org.xsocket.connection.IBlockingConnection;   
import org.xsocket.connection.INonBlockingConnection;   
import org.xsocket.connection.NonBlockingConnection;  

public class XSocketClient4 {
    private static final int PORT = 8014;   

	public String getProcessID() {
		return ManagementFactory.getRuntimeMXBean().getName()+'\0';
	}
	
	public String readFileContent(String fileName) {
		  File file = new File(fileName);
		  BufferedReader reader = null;
		  StringBuffer sbf = new StringBuffer();
		  try {
		    reader = new BufferedReader(new FileReader(file));
		    String tempStr;
		    while ((tempStr = reader.readLine()) != null) {
		      sbf.append(tempStr);
		    }
		    reader.close();
		    return sbf.toString();
		  } catch (IOException e) {
		    //e.printStackTrace();
		  } finally {
		    if (reader != null) {
		      try {
		        reader.close();
		      } catch (IOException e1) {
		        //e1.printStackTrace();
		      }
		    }
		  }
		  return sbf.toString();
		}
	
	public static void main(String[] args) throws IOException {
		XSocketClient4 x = new XSocketClient4();
		if (args.length>0) {
			System.out.println("args[0]="+args[0]);
			 try (FileInputStream stream = new FileInputStream(args[0])) {
				 
	            INonBlockingConnection nbc = new NonBlockingConnection("localhost", PORT, new ClientHandler());   
	            //IBlockingConnection bc = new BlockingConnection("localhost", PORT);     
	           
	            IBlockingConnection bc = new BlockingConnection(nbc);   
	           //  
	            //bc.setEncoding("UTF-8");   
	            System.out.println("******************** Client getProcessID = " + x.getProcessID());  
	            bc.setAutoflush(true);  
	            String sentdata=" ";
	
						sentdata=stream.read()+" \r\n";
					
	//				System.out.println("args[0]="+args[0]);
	//				sentdata=readFileContent(args[0])+" \r\n";
				System.out.println("sentdata = "+sentdata);
				bc.write(sentdata);
				System.out.println("Write3");
				//bc.write("Client:2\r\n");            
				//System.out.println("Write2");
				String res = bc.readStringByDelimiter("\r\n"); 
	            //byte[] byteBuffers= bc.readBytesByDelimiter("|", "UTF-8");   
	            System.out.println( "res = "+ res);   
	            //System.out.println(new String(byteBuffers));   
	           //   
	            bc.flush();               
				System.out.println("flush()");
	            bc.close();                
				System.out.println("close()");

		} catch (FileNotFoundException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			//e.printStackTrace();
		}


		}
		System.out.println("Main done.");System.out.println("Main done.");
	}
}
