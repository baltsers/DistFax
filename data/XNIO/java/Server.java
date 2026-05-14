import java.io.IOException;  
import java.net.InetSocketAddress;  
import java.nio.ByteBuffer;  
import java.nio.CharBuffer;  
import java.nio.channels.ClosedChannelException;  
import java.nio.channels.SelectionKey;  
import java.nio.channels.Selector;  
import java.nio.channels.ServerSocketChannel;  
import java.nio.channels.SocketChannel;  
import java.util.Iterator;  
   
public class XiaoNa {  
    private ByteBuffer readBuffer;  
    private Selector selector;  
       
    public static void main(String[] args){  
        XiaoNa xiaona = new XiaoNa();  
        xiaona.init();  
        xiaona.listen();  
    }  
       
    private void init(){  
        readBuffer = ByteBuffer.allocate(1024);  
        ServerSocketChannel servSocketChannel;  
           
        try {  
            servSocketChannel = ServerSocketChannel.open();  
            servSocketChannel.configureBlocking(false);  
          
            servSocketChannel.socket().bind(new InetSocketAddress(8383));  
               
            selector = Selector.open();  
            servSocketChannel.register(selector, SelectionKey.OP_ACCEPT);  
        } catch (IOException e) {  
            e.printStackTrace();  
        }        
    }  
   
    private void listen() {  
        while(true){  
            try{  
                selector.select();               
                Iterator ite = selector.selectedKeys().iterator();  
                   
                while(ite.hasNext()){  
                    SelectionKey key = (SelectionKey) ite.next();                    
                    ite.remove();
                    handleKey(key);  
                }  
            }  
            catch(Throwable t){  
                t.printStackTrace();  
            }                            
        }                
    }  
   
    private void handleKey(SelectionKey key)  
            throws IOException, ClosedChannelException {  
        SocketChannel channel = null;  
           
        try{  
            if(key.isAcceptable()){  
                ServerSocketChannel serverChannel = (ServerSocketChannel) key.channel();  
                channel = serverChannel.accept();//接受连接请求  
                channel.configureBlocking(false);  
                channel.register(selector, SelectionKey.OP_READ);  
            }  
            else if(key.isReadable()){  
                channel = (SocketChannel) key.channel();  
                readBuffer.clear();  
               
                int count = channel.read(readBuffer);  
                   
                if(count > 0){  
                    //
                    readBuffer.flip();  

                    CharBuffer charBuffer = CharsetHelper.decode(readBuffer);   
                    String question = charBuffer.toString();   
                    String answer = getAnswer(question);  
                    channel.write(CharsetHelper.encode(CharBuffer.wrap(answer)));  
                }  
                else{  
                  
                    channel.close();                 
                }                        
            }  
        }  
        catch(Throwable t){  
            t.printStackTrace();  
            if(channel != null){  
                channel.close();  
            }  
        }        
    }  
       
    private String getAnswer(String question){  
        String answer = null;  
           
        switch(question){  
        case "who":  
            answer = "I am xiaoNa\n";  
            break;  
        case "what":  
            answer = "I help you\n";  
            break;  
        case "where":  
            answer = "cosmos\n";  
            break;  
        case "hi":  
            answer = "hello\n";  
            break;  
        case "bye":  
            answer = "88\n";  
            break;  
        default:  
                answer = "who, what, or where";  
        }  
           
        return answer;  
    }  
}  