import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.HashSet;

public class CountExecutionTime {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		String str1=getMillionSecondsFromStr("oc > ^CRunTime for chord elapsed:  11329 milliseconds");
//		System.out.print("str1="+str1);
//		String str1=getMillionSecondsFromFile("C:/Research/OpenChord/logs/timecostNodeCDT_9.log");
//		System.out.print("str1="+str1);
		//readWritePathToFile("C:/Research/XNIO/logs/diff0Available.txt", "C:/Research/XNIO/logs/timecostclient2DT_", "C:/Research/XNIO/logs/executionTime.csv");
		String file1="diff0Available.txt";
		String file2="timecostclientDT_";
		String file3="executionTime.csv";
	    if (args.length>0) {
			System.out.println("args[0]="+args[0]);
			file1=args[0];
		    if (args.length>1) {
				System.out.println("args[1]="+args[1]);
				file2=args[1];
			    if (args.length>2) {
					System.out.println("args[2]="+args[2]);
					file3=args[2];		
			    }				
		    }			
	    }
	    readWritePathToFile(file1,file2, file3);
	}

	   public static String getMillionSecondsFromStr(String str) { 

	    	   if (str.indexOf("elapse: ")>=0)  {
	    		   //System.out.println("1");
	    		   return getSubstr(str, "elapse: ");
	    	   }
	    	   else if (str.indexOf("elapsed: ")>=0)  {
	    		  // System.out.println("1");
	    		   return getSubstr(str, "elapsed: ");
	    	   }	    	   
	    	   else  if (str.indexOf("time: ")>=0)  {
	    		  // System.out.println("2");
	    		   return getSubstr(str, "time: ");
	    	   }
	    	   else 
	    		   return "";
	   } 
	   
	   public static String getSubstr(String str, String splitStr) {  
		   	
	       try {  
	           // check the string str
	       	if (str.indexOf(splitStr)<0)
	       	{
	       		return "";
	       	}    	  
	   		//System.out.print("str="+str+"\n");
	       	String[] strs=str.split(splitStr); 
	   		//System.out.print("strs.length="+strs.length+"\n");
	       	if (strs.length<1)
	       	{
	       		return "";
	       	}
	       	else
	       	{   
	       		return strs[1].replace(" milliseconds", "").replace(" ms", "").trim();

	       	}
	       } catch (Exception e) {  
	           e.printStackTrace();  
	           return "";
	       }  
	   } 
	   
	    public static String getMillionSecondsFromFile(String listFile) {  
	        FileReader reader = null;  
	        BufferedReader br = null;    
	        //HashSet<String> classes = new HashSet<String>();	
	        String millionSeconds="";
	        try {  
	            
	               
	            //    
	            reader = new FileReader(listFile);  	   
	            String str = "";  	   
	            br = new BufferedReader(reader);
	
	            while ((str = br.readLine()) != null) { 
	            	String linems=getMillionSecondsFromStr(str);
	            	if (linems.length()>1 && linems.length()<10)
	            		millionSeconds=linems;
	            }  
	   
	            br.close();  
	            reader.close();  
	           
	            return millionSeconds;
	        } catch (IOException e) {  
	            //e.printStackTrace();  
	            return "";
	        }  
	    }
	    
	    public static void readWritePathToFile(String src1, String srcPart2, String dstFile) {  
	        FileWriter writer = null;  
	        FileReader reader = null;  
	        BufferedReader br = null;  
	        BufferedWriter bw = null;  
	   
	        try {  
	            
	   
	            reader = new FileReader(src1);     
	            String str = null;     
	            br = new BufferedReader(reader);  
	            str = br.readLine();
	            
	            File file = new File(dstFile);  
	            if (!file.exists()) {  
	                file.createNewFile();  
	            }  
	            writer = new FileWriter(dstFile, true);  
	            bw = new BufferedWriter(writer);    
	            
	            while (str!= null) {  
	            	System.out.println("str ="+str);
	            	if (str.length()>0)  {
		            	String str2=getMillionSecondsFromFile(srcPart2+str+".log");	    
		            	if (str2.length()>0) {
		            		bw.write(str+","+str2+"\n");
		            	}
		            	else {
		            		str2=getMillionSecondsFromFile(srcPart2+str.replace("-","_")+".log");
			            	if (str2.length()>0) {
			            		bw.write(str+","+str2+"\n");
			            	}
			            	else {
			            		str2=getMillionSecondsFromFile(srcPart2+str.replace("_","-")+".log");
				            	if (str2.length()>0) 
				            		bw.write(str+","+str2+"\n");
			            	}
		            	}
		            		
	            	}
	            	str = br.readLine();
	            }  
	            br.close();  
	            reader.close();  
	   
	            bw.close();  
	            writer.close();  
	   
	        } catch (IOException e) {  
	            e.printStackTrace();  
	        }  
	    }   
}
