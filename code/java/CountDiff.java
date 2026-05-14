import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashSet;

public class CountDiff{

	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		String str1=getdiffClientNum("diff0.txt");
//		System.out.print("str1="+str1);
		HashSet<String> lists = new HashSet<>();  
	    if (args.length>0) {
			System.out.println("args[0]="+args[0]);
			lists = getListSet(args[0]);		
	    }	
	    else 
	    {	
	    	//System.out.println("No args parameter!");
	    	//System.exit(0);
	    	System.out.println("args[0] = diff0.txt");
	    	lists = getListSet("diff0.txt");	
	    }	
		System.out.println("lists.size()="+lists.size());
		//System.out.println("lists="+lists);
		//HashSet<String> availableList = new HashSet<>(); 
		int availableSize=0;
		String allItems="";
		for (int i=1; i<=2000; i++) {
			String strI=""+i;
			if (!lists.contains(strI)) {
				//availableList.add(strI);
				availableSize++;
				allItems=allItems+strI+"\n";
			}	
		}
		//System.out.println("availableList.size()="+availableList.size());
		System.out.println("availableSize="+availableSize);
		//System.out.println("availableList="+availableList);
	    if (args.length>1) {
			System.out.println("args[1]="+args[1]);
			//writeSet(availableList,args[1]);			
			writeStringToFile(allItems,args[1]);	
	    }	
	    else
	    	System.out.println("allItems="+allItems);
		//writeSet(availableList,"C:/Research/karaf/diffAvailable.txt");
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
//    public static void writeSet(HashSet<String> hs, String dest) {  
//        
//        FileWriter writer = null;  
//        BufferedWriter bw = null;  
//   
//        try {  
//            File file = new File(dest);  
//            file.createNewFile(); 	           
//            // 
//            writer = new FileWriter(dest, true); 
//            bw = new BufferedWriter(writer);  
//            for (String item: hs) {
//            	bw.write(item+"\n");
//            }
//	    	
//            bw.close();  
//            writer.close();  
//   
//        } catch (IOException e) {  
//            e.printStackTrace();  
//        }  
//    }
	    public static HashSet<String> getListSet(String listFile) {  
	        FileReader reader = null;  
	        BufferedReader br = null;    
	        //HashSet<String> classes = new HashSet<String>();	
	        HashSet<String> lists = new HashSet<>();  
	        try {  
	            
	               
	            //    
	            reader = new FileReader(listFile);  	   
	            String str = null;  	   
	            br = new BufferedReader(reader);
	
	            while ((str = br.readLine()) != null) { 
	    	       	String itemStr=getdiffClientNum(str);
	    	       	if (itemStr.length()>1)
	    	       		lists.add(itemStr);
	            }  
	   
	            br.close();  
	            reader.close();  
	           
	            return lists;
	        } catch (IOException e) {  
	            e.printStackTrace();  
	            return null;
	        }  
	    }
    
	   public static String getdiffClientNum(String str) {  
		   	
	       try {  
	           // check the string str
	       	if (str.indexOf("diffClient_")<0)
	       	{
	       		return "";
	       	}    	  
	   		//System.out.print("str="+str+"\n");
	       	String[] strs=str.split("diffClient_"); 
	   		//System.out.print("strs.length="+strs.length+"\n");
	       	if (strs.length<1)
	       	{
	       		return "";
	       	}
	       	else
	       	{   
	       		String str2=strs[1];
	       		String[] strs2=str.split("_");
		       	if (strs2.length<1)
		       	{
		       		return "";
		       	}
		       	else
		       	{   
		       		return strs2[1];
		       	}	       		
	       		
	       	}
	       } catch (Exception e) {  
	           e.printStackTrace();  
	           return "";
	       }  
	   } 
}
