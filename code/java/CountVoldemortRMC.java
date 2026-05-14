import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class CountVoldemortRMC {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String file1="diff0Available.txt";
		String file2="timecost";
		String file3="RMC.csv";
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
	    readWriteRMCToFile(file1,file2,file3);
	}

    public static int getMsgCount(String listFile) {  
        FileReader reader = null;  
        BufferedReader br = null;    
        //HashSet<String> classes = new HashSet<String>();	
        int msgCount=0;
        try {  
            
               
            // 
            reader = new FileReader(listFile);  	   
            String str = "";  	   
            br = new BufferedReader(reader);

            while ((str = br.readLine()) != null) {             	
            	if (str.startsWith("> ") || str.length()>3) {
            		msgCount++;
            	}
            	else  if (str.indexOf(" connection ")>0 || str.indexOf(" Attempting to get raw store [")>0) {
            		msgCount++;
            	}
            	
            }  
   
            br.close();  
            reader.close();  
        } catch (IOException e) {  
            //e.printStackTrace();  0
        }  
        return msgCount;
    }
    
    public static int getMsgCounts3(String filePrefix, String ith) {  
    	 //  timecostClient_1.log  timecostDT_1.log  timecostServer_1.log
    	return getMsgCount(filePrefix+"tServer_"+ith+".log")+getMsgCount(filePrefix+"Client_"+ith+".log");    	
    
    }	
	    
	    public static void readWriteRMCToFile(String src1, String srcPart2, String dstFile) {  
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
	            		int count3=getMsgCounts3 (srcPart2,str);
		            	if (count3>0) {
		            		bw.write(str+","+count3+"\n");
	            		}
//		            	String str2=getMillionSecondsFromFile(srcPart2+str+".log");	    
//		            	if (str2.length()>0) {
//		            		bw.write(str+","+str2+"\n");
//		            	}
//		            	else {
//		            		str2=getMillionSecondsFromFile(srcPart2+str.replace("-","_")+".log");
//			            	if (str2.length()>0) {
//			            		bw.write(str+","+str2+"\n");
//			            	}
//			            	else {
//			            		str2=getMillionSecondsFromFile(srcPart2+str.replace("_","-")+".log");
//				            	if (str2.length()>0) 
//				            		bw.write(str+","+str2+"\n");
//			            	}
//		            	}
		            		
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