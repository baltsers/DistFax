import java.net.*;
import java.io.*;

public class HelloWorldClient {
	public static void main(String args[]) {
		BufferedReader br = null;
		PrintWriter out = null;
		Socket socket = null;
		int port = 1000;

		if(args.length<2) {
			System.err.println("Usage : "+
			"\n HelloWorldClient  ");
			System.exit(0);
		}

		try {
			port = Integer.parseInt(args[1]);
			System.out.print("Connecting.. ");

			socket = new Socket(args[0], port);
			System.out.println("Connected to "+
				args[0]+":"+port+"\n");

			br = new BufferedReader(new InputStreamReader(
				socket.getInputStream()));
			out = new PrintWriter(new BufferedWriter(
				new OutputStreamWriter(
					socket.getOutputStream())), true);

			String recData = br.readLine();
			System.out.println("S: "+recData);

			out.println("Hi");
			System.out.println("C: Hi");

			recData = br.readLine();
			System.out.println("S: "+recData);

			out.println("quit");
			System.out.println("C: quit");
			recData = br.readLine();
			System.out.println("S: "+recData);

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
	}
}
