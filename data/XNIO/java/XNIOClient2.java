import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.CharBuffer;
import java.nio.charset.Charset;

import org.xnio.IoFuture;
import org.xnio.IoUtils;
import org.xnio.OptionMap;
import org.xnio.Xnio;
import org.xnio.XnioWorker;
import org.xnio.channels.Channels;
import org.xnio.channels.ConnectedStreamChannel;

public final class XNIOClient2 {

    public static void main(String[] args) throws Exception {
        final Charset charset = Charset.forName("utf-8");
        final Xnio xnio = Xnio.getInstance();
        final XnioWorker worker = xnio.createWorker(OptionMap.EMPTY);
        long timeBefore = System.currentTimeMillis();

            final IoFuture<ConnectedStreamChannel> futureConnection = worker.connectStream(new InetSocketAddress("localhost", 12345), null, OptionMap.EMPTY);
            final ConnectedStreamChannel channel = futureConnection.get(); // throws exceptions
            
                // Send the greeting
                if (args.length>0) {
            		System.out.println("args[0]="+args[0]);
            		String[] strs=getFileWords(args[0]);
            		for (int i=0; i<strs.length; i++)
               		{
            			String sentdata=strs[i]+"\n";
            			System.out.println("sentdata = "+sentdata);
            			Channels.writeBlocking(channel, ByteBuffer.wrap(sentdata.getBytes(charset)));
               		}            		
                }
                else
                	Channels.writeBlocking(channel, ByteBuffer.wrap("Hello world!\n".getBytes(charset)));
                
        		long timeAfterSend = System.currentTimeMillis();
        		System.out.println("XNIO Client2 sending time: " + (timeAfterSend - timeBefore) + "ms\n");
                // Make sure all data is written
                Channels.flushBlocking(channel);
                // And send EOF
                channel.shutdownWrites();
                System.out.println("Sent greeting string!  The response is...");
                ByteBuffer recvBuf = ByteBuffer.allocate(128);
                // Now receive and print the whole response
                while (Channels.readBlocking(channel, recvBuf) != -1) {
                    recvBuf.flip();
                    final CharBuffer chars = charset.decode(recvBuf);
                    System.out.print(chars);
                    recvBuf.clear();
                }
            IoUtils.safeClose(channel);

        worker.shutdown();
        System.out.println("XNIO Client2 time: " + (System.currentTimeMillis() - timeBefore) + "ms\n");
    }
    
	public static String readFileContent(String fileName) throws IOException {
		  File file = new File(fileName);
		  BufferedReader reader = null;
		  StringBuffer sbf = new StringBuffer();
		  reader = new BufferedReader(new FileReader(file));

		    reader = new BufferedReader(new FileReader(file));
		    String tempStr;
		    while ((tempStr = reader.readLine()) != null) {
		      sbf.append(tempStr);
		    }
		    reader.close();
		    return sbf.toString();

		}
	
		public static String[] getFileWords(String fileName) throws IOException {
			String str= readFileContent(fileName);
			System.out.println("Message = "+str+" Message.length() = "+str.length());
			String[] strs=str.replace("\n", " ").replace("  ", " ").split(" "); 
			return strs;
		}	 
}