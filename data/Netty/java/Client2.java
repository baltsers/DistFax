import io.netty.bootstrap.Bootstrap; 
import io.netty.channel.ChannelFuture; 
import io.netty.channel.ChannelInitializer; 
import io.netty.channel.ChannelOption; 
import io.netty.channel.EventLoopGroup; 
import io.netty.channel.nio.NioEventLoopGroup; 
import io.netty.channel.socket.SocketChannel; 
import io.netty.channel.socket.nio.NioSocketChannel;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Scanner; 
public class Client2 implements Runnable{ 
  static ClientHandler client = new ClientHandler(); 
  public static void main(String[] args) throws Exception { 
	long timeBefore = System.currentTimeMillis();
    new Thread(new Client2()).start(); 
    if (args.length>0) {
		System.out.println("args[0]="+args[0]);
		//String sentdata=readFileContent(args[0])+" \r\n";
		String sentdata=readFileContent(args[0]); //+" \r\n";
		System.out.println("sentdata = "+sentdata);		
		client.sendMsg(sentdata);
		long timeAfterSend = System.currentTimeMillis();
		System.out.println("Netty Client2 sending time: " + (timeAfterSend - timeBefore) + "ms\n");
//		String[] strs=getFileWords(args[0]);
//		for (int i=0; i<strs.length; i++)
//   		{
//			String sentdata=strs[i];
//			System.out.println("sentdata = "+sentdata);
//			client.sendMsg(sentdata+"\n");
//   		}
    }
    else
    {
	    @SuppressWarnings("resource") 
	    Scanner scanner = new Scanner(System.in); 
	    while(client.sendMsg(scanner.nextLine()));
    }
	System.out.println("Netty Client2 time: " + (System.currentTimeMillis() - timeBefore) + "ms\n");
  } 
  @Override
  public void run() { 
    String host = "127.0.0.1"; 
    int port = 9090; 
    EventLoopGroup workerGroup = new NioEventLoopGroup(); 
    try { 
      Bootstrap b = new Bootstrap(); 
      b.group(workerGroup); 
      b.channel(NioSocketChannel.class); 
      b.option(ChannelOption.SO_KEEPALIVE, true); 
      b.handler(new ChannelInitializer<SocketChannel>() { 
        @Override
        public void initChannel(SocketChannel ch) throws Exception { 
          ch.pipeline().addLast(client); 
        } 
      }); 
      ChannelFuture f = b.connect(host, port).sync(); 
      f.channel().closeFuture().sync(); 
    } catch (InterruptedException e) { 
      e.printStackTrace(); 
    } finally { 
      workerGroup.shutdownGracefully(); 
    } 
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
