import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashSet;

public class CountComplexityFromFiles {
	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		String str1=getMethodFromFL("<org.xnio.Xnio$1: void <init>()>:l");
//		System.out.print("str1="+str1);
		 //HashSet<String>  strs1=getMethodSetFromSourceSink("C:/Research/XNIO/logs/source_1.txt","C:/Research/XNIO/logs/sink_1.txt");
		
//		 HashSet<String>  strs1=getBranchSetFromFile("C:/Research/XNIO/logs/branches.txt");
//		System.out.println("strs1.size()="+strs1.size());
//		System.out.println("strs1="+strs1);
//		int mC=getMethodCountFromFL("C:/Research/XNIO/logs/FL.txt",strs1);
//		System.out.println("mC="+mC);
		//readWritePathToFile("C:/Research/XNIO/logs/diff0Available.txt", "C:/Research/XNIO/logs/timecostclient2DT_", "C:/Research/XNIO/logs/executionTime.csv");	
		
//		HashSet<String>  strs1=getMethodSetFromSourceSink("C:/Research/XNIO/logs/sourceSinkMethods2_1.txt");
//		availableSSMC("C:/Research/XNIO/diff0Available.txt", "C:/Research/XNIO/logs/", strs1);
		

		String file1="diff0Available.txt";
		String file2="test1/clientlog";
	    if (args.length>0) {
			System.out.println("args[0]="+args[0]);
			file1=args[0];
		    if (args.length>1) {
				System.out.println("args[1]="+args[1]);
				file2=args[1];
		    }			
	    }
	    availableMC(file1, file2);
	    
	    
	    //availableMC("C:/Research/XNIO/diff0Available.txt", "C:/Research/XNIO/logs");
	    
//		HashSet<String>  strs1=getMethodSetFromSourceSink(file1);
//		//System.out.println("strs1.size()="+strs1.size());
//		//System.out.println("strs1="+strs1);
//		int mC=getMethodCountFromFL(file2,strs1);
//		System.out.println(mC);
	}
	
	public static int getBranchCountFromFile(String file1) { 
		//System.out.println("getBranchCountFromFile  file1="+file1);
		HashSet<String>  strs1=getBranchSetFromFile(file1);
		return strs1.size();
	}
    public static HashSet<String> getBranchSetFromFile(String file1) {  
        FileReader reader1 = null;  
        BufferedReader br1 = null;    
        //HashSet<String> classes = new HashSet<String>();	
        HashSet<String> lists = new HashSet<>();  
        try {  
            reader1 = new FileReader(file1);  	   
            String str = "";  	   
            br1 = new BufferedReader(reader1);

            while ((str = br1.readLine()) != null) { 
            	//System.out.println("str="+str);
            	String tmpStr=str;
            	if (tmpStr.indexOf("Branches covered: ")>=0) {
            		String str1=str.substring(0, str.indexOf("Branches covered: "));
            		tmpStr=str.substring(str1.length(), str.length()); 
            		//System.out.println("tmpStr="+tmpStr);
            		String[] strs=tmpStr.replace("Branches covered: ","").split(" ");
            		for (int i=0; i<strs.length; i++) {
            			//System.out.println("strs[i]="+strs[i]);
            			lists.add(strs[i].trim());
            		}
            	}            	
            }  
   
            br1.close();  
            reader1.close();  
            //System.out.println("lists.size()="+lists.size()+" lists="+lists);
            
        } catch (IOException e) {  
            e.printStackTrace();  
            
        }         

        return lists;
    }
    
	public static void availableMC(String fileName, String branchPath)  {
		  File file = new File(fileName);
		  BufferedReader reader = null;
	        try {  
				reader = new BufferedReader(new FileReader(file));
				String tempStr="";
				String fullPath=branchPath;
				while ((tempStr = reader.readLine()) != null) {
					if (tempStr.length()>0) {
						fullPath=branchPath+"/"+tempStr.replace("-", "_")+"/branches.txt";
						int mC=1+getBranchCountFromFile(fullPath);
						if (mC>0)
							System.out.println(tempStr+","+mC);
					}
					
//				  String methodStr=getMethodFromFL(tempStr);
//				  if (methods.contains(methodStr))
//					  methodCount++;
				  
				}
				reader.close();
			

			
	        } catch (IOException e) {  
	            e.printStackTrace();  
	           
	        }  
	       
		}  
}
