import java.net.*;
import java.io.*;

public class Client2 {
	public static void main(String args[]) {
		BufferedReader br = null;
		PrintWriter out = null;
		Socket socket = null;
		int port = 2000;

//		if(args.length<2) {
//			System.err.println("Usage : "+
//			"\n HelloWorldClient  ");
//			System.exit(0);
//		}
		long timeBefore = System.currentTimeMillis();
		try {
			port = 2000; // Integer.parseInt(args[1]);
			System.out.print("Connecting.. ");

			socket = new Socket("127.0.0.1", port);
			System.out.println("Connected to 127.0.0.1: "+port+"\n");

			br = new BufferedReader(new InputStreamReader(
				socket.getInputStream()));
			out = new PrintWriter(new BufferedWriter(
				new OutputStreamWriter(
					socket.getOutputStream())), true);
			out.println("Hi");
			System.out.println("C: Hi");
			
            if (args.length>0) {
					System.out.println("args[0]="+args[0]);
					String[] strs=getFileWords(args[0]);
					for (int i=0; i<strs.length; i++)
					{
						String sentdata=strs[i]+"\n";
						out.println("sentdata");
						System.out.println(sentdata);
						
					}            		            	   
            }
            else
            {
            	String recData = br.readLine();
    			System.out.println("S: "+recData);
            }
			
       		long timeAfterSend = System.currentTimeMillis();
       		System.out.println("quickserver Client2 sending time: " + (timeAfterSend - timeBefore) + "ms\n");
       		
			out.println("quit");
			System.out.println("C: quit");
			
//			String recData = br.readLine();
//			System.out.println("S: "+recData);
//
//			out.println("Hi");
//			System.out.println("C: Hi");
//
//			recData = br.readLine();
//			System.out.println("S: "+recData);
//
//			out.println("quit");
//			System.out.println("C: quit");
//			recData = br.readLine();
//			System.out.println("S: "+recData);

		} catch(Exception e) {
			System.err.println("Error " + e);
		} finally {
			try {
				if(socket!=null)
					socket.close();
			} catch(Exception er) {
				System.err.println("Error closing: " + er);
			}
		}
        System.out.println("quickserver Client2 time: " + (System.currentTimeMillis() - timeBefore) + "ms\n");
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
