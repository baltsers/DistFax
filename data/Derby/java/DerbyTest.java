import java.sql.Connection;  
import java.sql.DriverManager;  
import java.sql.ResultSet;  
import java.sql.Statement;  
/** 
 * @author greatwqs 
 * 
 */  
public class DerbyTest {  
  
    public static void main(String[] args) {  
        DerbyTest testClient = new DerbyTest();  
        testClient.showTableContents();  
    }  
  
    public void showTableContents() {  
        try {  
            String driver = "org.apache.derby.jdbc.ClientDriver";  
            Class.forName(driver).newInstance();  
            Connection conn = null;  
            conn = DriverManager.getConnection("jdbc:derby://localhost:1527/firstdb");  
            Statement s = conn.createStatement();  
            ResultSet rs = s.executeQuery("SELECT * FROM firsttable");  
            while (rs.next()) {  
                System.out.println("Number: " + rs.getInt(1));  
            }  
            rs.close();  
            s.close();  
            conn.close();  
        } catch (Exception e) {  
            System.out.println("Exception: " + e);  
            e.printStackTrace();  
        }  
    }  
  
}  