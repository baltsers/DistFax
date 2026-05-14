import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public class Write2000 {

	public static void main(String[] args) {
		String allItems="";
		for (int i=1; i<=2000; i++) {
			String strI=""+i;
			allItems=allItems+strI+"\n";			
		}
		writeStringToFile(allItems,"C:/Research/FUZZ/test1/2000.txt");
	}

    public static void writeStringToFile(String str, String dest) {  
        FileWriter writer = null;  
        BufferedWriter bw = null;  
   
        try {  
            File file = new File(dest);  
            if (!file.exists()) {  
                file.createNewFile();  
            }  
            writer = new FileWriter(dest, false); 
            bw = new BufferedWriter(writer);  
            bw.write(str);    
            bw.close();  
            writer.close();  	
            //System.out.println("str="+str+" dest="+dest);
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
    }  
}
