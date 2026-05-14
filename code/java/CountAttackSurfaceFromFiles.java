import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.HashSet;

public class CountAttackSurfaceFromFiles {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		String str1=getMethodFromFL("<org.xnio.Xnio$1: void <init>()>:l");
//		System.out.print("str1="+str1);
		 //HashSet<String>  strs1=getMethodSetFromSourceSink("C:/Research/XNIO/logs/source_1.txt","C:/Research/XNIO/logs/sink_1.txt");
		
//		 HashSet<String>  strs1=getMethodSetFromSourceSink("C:/Research/XNIO/logs/sourceSinkMethods2_1.txt");
//		System.out.println("strs1.size()="+strs1.size());
//		//System.out.println("strs1="+strs1);
//		int mC=getMethodCountFromFL("C:/Research/XNIO/logs/FL.txt",strs1);
//		System.out.println("mC="+mC);
		//readWritePathToFile("C:/Research/XNIO/logs/diff0Available.txt", "C:/Research/XNIO/logs/timecostclient2DT_", "C:/Research/XNIO/logs/executionTime.csv");	
		
//		HashSet<String>  strs1=getMethodSetFromSourceSink("C:/Research/XNIO/logs/sourceSinkMethods2_1.txt");
//		availableSSMC("C:/Research/XNIO/diff0Available.txt", "C:/Research/XNIO/logs/", strs1);
		
		String file1="sourceSinkMethods2_1.txt";
		String file2="diff0Available.txt";
		String file3="test1/clientlog";
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
		HashSet<String>  strs1=getMethodSetFromSourceSink(file1);
		availableSSMC(file2, file3, strs1);
	    
	    
//		HashSet<String>  strs1=getMethodSetFromSourceSink(file1);
//		//System.out.println("strs1.size()="+strs1.size());
//		//System.out.println("strs1="+strs1);
//		int mC=getMethodCountFromFL(file2,strs1);
//		System.out.println(mC);
	}
	
	   public static String getMethodFromSourceSink(String str) {  
		   	
	       try {  
	           // check the string str
	       	if (str.indexOf(" - ")<0)
	       	{
	       		return "";
	       	}    	  
	   		//System.out.print("str="+str+"\n");
	       	String[] strs=str.split(" - "); 
	   		//System.out.print("strs.length="+strs.length+"\n");
	       	if (strs.length<1)
	       	{
	       		return "";
	       	}
	       	else
	       	{   
	       		return strs[0].replace("Source: ", "").replace("Sink: ", "").trim();

	       	}
	       } catch (Exception e) {  
	           e.printStackTrace();  
	           return "";
	       }  
	   } 

	    public static HashSet<String> getMethodSetFromSourceSink(String file1) {  
	        FileReader reader1 = null;  
	        BufferedReader br1 = null;    
	        //HashSet<String> classes = new HashSet<String>();	
	        HashSet<String> lists = new HashSet<>();  
	        try {  
	            
	               
	            //    
	            reader1 = new FileReader(file1);  	   
	            String str = "";  	   
	            br1 = new BufferedReader(reader1);
	
	            while ((str = br1.readLine()) != null) { 
	    	       	//String itemStr=getMethodFromSourceSink(str);
	    	       	if (str.length()>1)
	    	       		lists.add(str);
	            }  
	   
	            br1.close();  
	            reader1.close();  
	           
	            
	        } catch (IOException e) {  
	            e.printStackTrace();  
	            
	        }  
	        return lists;
	        
	        
	    }
	   
	    public static HashSet<String> getMethodSetFromSourceSink(String file1, String file2) {  
	        FileReader reader1 = null;  
	        BufferedReader br1 = null;    
	        //HashSet<String> classes = new HashSet<String>();	
	        HashSet<String> lists = new HashSet<>();  
	        try {  
	            
	               
	            //    
	            reader1 = new FileReader(file1);  	   
	            String str = "";  	   
	            br1 = new BufferedReader(reader1);
	
	            while ((str = br1.readLine()) != null) { 
	    	       	String itemStr=getMethodFromSourceSink(str);
	    	       	if (itemStr.length()>1)
	    	       		lists.add(itemStr);
	            }  
	   
	            br1.close();  
	            reader1.close();  
	           
	            
	        } catch (IOException e) {  
	            e.printStackTrace();  
	            
	        }  
	        
	        FileReader reader2 = null;  
	        BufferedReader br2 = null;    
	        try {  
	            reader2 = new FileReader(file2);  	   
	            String str = "";  	   
	            br2 = new BufferedReader(reader2);
	
	            while ((str = br2.readLine()) != null) { 
	    	       	String itemStr=getMethodFromSourceSink(str);
	    	       	if (itemStr.length()>1)
	    	       		lists.add(itemStr);
	            }  
	   
	            br1.close();  
	            reader1.close();  
	           
	            //return lists;
	        } catch (IOException e) {  
	            e.printStackTrace();  
	            //return null;
	        }  
	        return lists;
	    }
	   
	   public static String getMethodFromFL(String str) {  
		   return str.replace(")>:l", ")>").replace(")>:e", ")>").trim();

	   } 
	   
		public static int getMethodCountFromFL(String fileName, HashSet<String> methods)  {
		  File file = new File(fileName);
		  BufferedReader reader = null;
		  int methodCount=1;

	        try {  
				reader = new BufferedReader(new FileReader(file));
				String tempStr="";
				while ((tempStr = reader.readLine()) != null) {
				  String methodStr=getMethodFromFL(tempStr);
				  if (methods.contains(methodStr))
					  methodCount++;
				  
				}
				reader.close();
			

			
	        } catch (IOException e) {  
	            e.printStackTrace();  
	           
	        }  
	        return methodCount;
		}    
		
		public static void availableSSMC(String fileName, String FLPath, HashSet<String> methods)  {
			  File file = new File(fileName);
			  BufferedReader reader = null;
			  int methodCount=1;

		        try {  
					reader = new BufferedReader(new FileReader(file));
					String tempStr="";
					String fullPath=FLPath;
					while ((tempStr = reader.readLine()) != null) {
						if (tempStr.length()>0) {
							fullPath=FLPath+"/"+tempStr.replace("-", "_")+"/FL.txt";
							int mC=getMethodCountFromFL(fullPath,methods);
							if (mC>0)
								System.out.println(tempStr+","+mC);
						}
						
//					  String methodStr=getMethodFromFL(tempStr);
//					  if (methods.contains(methodStr))
//						  methodCount++;
					  
					}
					reader.close();
				

				
		        } catch (IOException e) {  
		            e.printStackTrace();  
		           
		        }  
		       
			}    
}	