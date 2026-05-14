import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;

public class CountMsgRMC {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		String file1="diff0Available.txt";
//		String file2="/home/xqfu/fuzz/Karafs/Karaf";
//		String file3="RMC.csv";
//	    if (args.length>0) {
//			System.out.println("args[0]="+args[0]);
//			file1=args[0];
//		    if (args.length>1) {
//				System.out.println("args[1]="+args[1]);
//				file2=args[1];
//			    if (args.length>2) {
//					System.out.println("args[2]="+args[2]);
//					file3=args[2];		
//			    }				
//		    }			
//	    }
	
		String file1="C:/Research/Netty/diff0AvailableAll.txt";
		String file2="C:/Research/FUZZ/fuzz191/Messages/Message";
		String file3="C:/Research/Netty/RMC.csv";
	    readWriteRMCToFile(file1,file2,file3);
	}

    public static int getMsgCount(String listFile) {  
        FileReader reader = null;  
        BufferedReader br = null;    
        //HashSet<String> classes = new HashSet<String>();	
        //System.out.println("listFile ="+listFile);
        int msgCount=0;
        try {  
            
               
            //    timecostclientDT3_1.log  timecostServer_1.log
            reader = new FileReader(listFile);  	   
            String str = "";  	   
            br = new BufferedReader(reader);

            while ((str = br.readLine()) != null) {   
            	//System.out.println("str="+str);
//            	if (str.startsWith("The intermediate result of ")) {
//            		msgCount=msgCount+2;
//            	}
            	msgCount++;
            }  
   
            br.close();  
            reader.close();  
        } catch (IOException e) {  
            //e.printStackTrace();  0
        }  
        //System.out.println("msgCount="+msgCount);
        return msgCount;
    }
    
    public static int getMsgCounts3(String filePrefix, String ith) {  
    	 // timecostclient2DT_1.log  timecostServerDT_1.log
    	return getMsgCount(filePrefix+ith+".txt");
    	//+getMsgCount(filePrefix+"clientDT3_"+ith+".log");    	
    
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
	            	//System.out.println("str ="+str);
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