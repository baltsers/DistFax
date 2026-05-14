   import org.glassfish.grizzly.Connection;
   import org.glassfish.grizzly.Grizzly;
   import org.glassfish.grizzly.filterchain.FilterChainBuilder;
   import org.glassfish.grizzly.filterchain.TransportFilter;
   import org.glassfish.grizzly.nio.transport.TCPNIOTransport;
   import org.glassfish.grizzly.nio.transport.TCPNIOTransportBuilder;
   import org.glassfish.grizzly.utils.StringFilter;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
   import java.io.InputStreamReader;
import java.nio.ByteBuffer;
import java.nio.charset.Charset;
   import java.util.concurrent.ExecutionException;
   import java.util.concurrent.Future;
   import java.util.concurrent.TimeUnit;
   import java.util.concurrent.TimeoutException;
   import java.util.logging.Logger;
   
   public class EchoClient2 {
       private static final Logger logger = Grizzly.logger(EchoClient.class);
   
       public static void main(String[] args) throws IOException,
               ExecutionException, InterruptedException, TimeoutException {
    	   long timeBefore = System.currentTimeMillis();
           Connection connection = null;
   
           // Create a FilterChain using FilterChainBuilder
           FilterChainBuilder filterChainBuilder = FilterChainBuilder.stateless();
           // Add TransportFilter, which is responsible
           // for reading and writing data to the connection
           filterChainBuilder.add(new TransportFilter());
           // StringFilter is responsible for Buffer <-> String conversion
           filterChainBuilder.add(new StringFilter(Charset.forName("UTF-8")));
           // Client is responsible for redirecting server responses to the standard output
           filterChainBuilder.add(new ClientFilter());
   
           // Create TCP transport
           final TCPNIOTransport transport = TCPNIOTransportBuilder.newInstance().build();
           transport.setProcessor(filterChainBuilder.build());
   
           try {
   
               // Start the transport
               transport.start();
   
               // perform async. connect to the server
               Future<Connection> future = transport.connect(EchoServer.HOST, EchoServer.PORT);
   
               // wait for connect operation to complete
               connection = future.get(10, TimeUnit.SECONDS);
   
               assert connection != null;
   
               logger.info("Ready...(\"q\" to exit)");
               
               if (args.length>0) {
					System.out.println("args[0]="+args[0]);
					String[] strs=getFileWords(args[0]);
					for (int i=0; i<strs.length; i++)
					{
						String sentdata=strs[i]+"\n";
						System.out.println("sentdata = "+sentdata);
						connection.write(sentdata);
					}            		            	   
               }
               else
               {	   
	               final BufferedReader inReader = new BufferedReader(new InputStreamReader(System.in));
	               do {
	                   final String userInput = inReader.readLine();
	                   if (userInput == null || "q".equals(userInput)) {
	                       break;
	                   }
	   
	                   connection.write(userInput);
	               } while (true);
               }
	       		long timeAfterSend = System.currentTimeMillis();
	       		System.out.println("Grizzly EchoClient2 sending time: " + (timeAfterSend - timeBefore) + "ms\n");
           } finally {
               // close the client connection
               if (connection != null) {
                   connection.close();
               }
   
               // stop the transport
               transport.shutdownNow();
               
           }
           System.out.println("Grizzly EchoClient2 time: " + (System.currentTimeMillis() - timeBefore) + "ms\n");
       }
   	public static String readFileContent(String fileName) {
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
		    e.printStackTrace();
		  } finally {
		    if (reader != null) {
		      try {
		        reader.close();
		      } catch (IOException e1) {
		        e1.printStackTrace();
		      }
		    }
		  }
		  return sbf.toString();
		}
	
		public static String[] getFileWords(String fileName) {
			String str= readFileContent(fileName);
			System.out.println("Message = "+str+" Message.length() = "+str.length());
			String[] strs=str.replace("\n", " ").replace("  ", " ").split(" "); 
			return strs;
		}	 
   }