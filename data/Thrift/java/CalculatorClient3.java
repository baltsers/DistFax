//import com.google.common.base.Objects;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.regex.Pattern;

import org.apache.thrift.TException;
import org.apache.thrift.protocol.TBinaryProtocol;
import org.apache.thrift.protocol.TProtocol;
import org.apache.thrift.transport.TSocket;
import org.apache.thrift.transport.TTransport;
import org.apache.thrift.transport.TTransportException;

/**

 */
public class CalculatorClient3 {

    private static int port = 9090;
    private static String ip = "localhost";
    private static CalculatorService.Client client;

    private static TTransport transport;

    /**
     
     */
    public static TTransport createTTransport(){

        TTransport transport = new TSocket(ip, port);
        return transport;

    }

    /**

     * @param transport
     * @throws TTransportException
     */
    public static void openTTransport(TTransport transport) throws TTransportException {

        transport.open();

    }

    /**

     * @param transport
     */
    public static void closeTTransport(TTransport transport){

        transport.close();

    }

    /**
     * @return
     */
    public static CalculatorService.Client createClient(TTransport transport){


        TProtocol protocol = new TBinaryProtocol(transport);

        CalculatorService.Client client = new CalculatorService.Client(protocol);
        return client;
    }

    public static void main(String[] args) {
    	long timeBefore = System.currentTimeMillis();
        try {

            // 
            transport = createTTransport();

            // 
            openTTransport(transport);

            // 
            client = createClient(transport);

            /*
            System.out.println(client.add(100, 200));
            System.out.println(client.minus(200, 100));
            System.out.println(client.multi(100, 11));
            System.out.println(client.divi(100, 20));
			*/
			if (args.length>0) {
				System.out.println("args[0]="+args[0]);
            int numLeft=1;               
            int numRight=-999;
			String[] strs=getFileWords(args[0]);		
			if (isInteger(strs[0]))
			{
				numLeft=Integer.parseInt(strs[0]);
			}
			for (int i=1; i<strs.length; i++)
       		{
				if ((i+1)<strs.length)
				{
					String itemMoreI=strs[i+1].trim();
					if (isInteger(itemMoreI))
					{
						numRight=Integer.parseInt(itemMoreI);
					}
					else
						numRight=-999;
				}
				else
					numRight=-999;
				int numMid=-999;
				String itemdata=strs[i].trim();
				if (numRight>-999)
					if (itemdata.equals("add")) {
						numMid=client.add(numLeft, numRight);
					}
					else if (itemdata.equals("add")) {
						numMid=client.minus(numLeft, numRight);
					}
					else if (itemdata.equals("multi")) {
						numMid=client.multi(numLeft, numRight);
					}	
					else if (itemdata.equals("divi")) {
						numMid=client.divi(numLeft, numRight);
					}	
					else 
						numMid=-999;
					if (numMid>-999) {
						System.out.println("The intermediate result of "+numLeft+" "+itemdata+" "+numRight+" = "+numMid);
						numLeft=numMid;
       				}
       			}				
				
       		}
	       		long timeAfterSend = System.currentTimeMillis();
	
	       		System.out.println("Calculator Client3 sending time: " + (timeAfterSend - timeBefore) + "ms\n");
//				System.out.println("client.add("+number1+","+ number2+")="+client.add(number1, number2));
//				System.out.println("client.minus("+number1+","+ number2+")="+client.minus(number1, number2));
//				System.out.println("client.multi("+number1+","+ number2+")="+client.multi(number1, number2));
//				System.out.println("client.divi("+number1+","+ number2+")="+client.divi(number1, number2));
//				System.out.println("The client will sleep "+number3+" seconds");
//                try  {
//                    Thread.sleep(number3*1000);
//                }    
//                catch (Exception e) 
//                {
//                    e.printStackTrace();
//                }    
			//}
        } catch (TException e) {
            e.printStackTrace();
        }
        finally {
            // 
            closeTTransport(transport);
        }
        System.out.println("Calculator Client3 time: " + (System.currentTimeMillis() - timeBefore) + "ms\n");
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
			System.out.println("str.length() = "+str+" Message.length() = "+str.length());
			String[] strs=str.replace("\n", " ").replace("  ", " ").split(" "); 
			return strs;
		}	
		
		  public static boolean isInteger(String str) {  
		        Pattern pattern = Pattern.compile("^[-\\+]?[\\d]*$");  
		        return pattern.matcher(str).matches();  
		  }
}
