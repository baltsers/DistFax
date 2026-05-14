import java.net.*;
import java.io.*;
import org.quickserver.net.server.ClientCommandHandler;
import org.quickserver.net.server.ClientHandler;

public class HelloWorldCommandHandler implements ClientCommandHandler {

	public void handleCommand(ClientHandler handler, String command) 
			throws SocketTimeoutException, IOException {
		if(command.equals("quit")) {
			handler.sendClientMsg("bye");
			handler.closeConnection();
		} else {
			handler.sendClientMsg("You Sent: "+command);
		}
	}
}