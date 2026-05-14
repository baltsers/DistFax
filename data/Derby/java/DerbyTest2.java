import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class DerbyTest2 {

    public static void main(String[] args) {  
//    	String[] strs=getFileWords("C:/Research/FUZZ/main.c");
//    	System.out.println("strs: " + strs);  
        try {  
            String driver = "org.apache.derby.jdbc.ClientDriver";  
            Class.forName(driver).newInstance();  
            Connection conn = null;  
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/firstdb");  
            Statement s = conn.createStatement();  
            s.execute("DROP TABLE firsttable");
            s.execute("create table firsttable(id int primary key, name varchar(255))");
            s.execute("insert into firsttable values(1,'Hotpepper')");
            ResultSet rs = s.executeQuery("SELECT * FROM firsttable");  
            while (rs.next()) {  
                System.out.println("Number: " + rs.getInt(1));  
            }  
            if (args.length>0) {
					System.out.println("args[0]="+args[0]);
					String[] strs=getFilelines(args[0]);
					for (int i=0; i<strs.length; i++)
					{
						String aline=strs[i]+"\n";
						System.out.println("execute: " + aline);  
						s.execute(aline);						
					}            		            	   
            }            
            
            rs.close();  
            s.close();  
            conn.close();  
        } catch (Exception e) {  
            System.out.println("Exception: " + e);  
            e.printStackTrace();  
        }  
    }  
  
   	public static String readFileContent(String fileName) {
		  File file = new File(fileName);
		  Long filelength = file.length();
	        byte[] filecontent = new byte[filelength.intValue()];  
	        try {  
	            FileInputStream in = new FileInputStream(file);  
	            in.read(filecontent);  
	            in.close();  
	        } catch (FileNotFoundException e) {  
	            e.printStackTrace();  
	        } catch (IOException e) {  
	            e.printStackTrace();  
	        }
	        try {  
	            return new String(filecontent, "UTF-8");  
	        } catch (UnsupportedEncodingException e) {  
	            System.err.println("The OS does not support UTF-8");  
	            e.printStackTrace();  
	            return null;  
	        }  
		}
	
		public static String[] getFilelines(String fileName) {
			String str= readFileContent(fileName);
			System.out.println("Message = "+str+" Message.length() = "+str.length());
			String[] strs=str.replace("; ", "\n").split("\n"); 
			return strs;
		}	 
}
