import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashSet;

//import soot.Scene;
//import soot.jimple.spark.SparkTransformer;
//import soot.options.Options;

public class FLUtil {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		 LinkedHashSet<String>  strs1=getMethodSetFromFLFile("C:/Research/XNIO/logs/FL.txt");
//		System.out.println("strs1.size()="+strs1.size());
//		System.out.println("strs1="+strs1);
//		
//		LinkedHashSet<String>  strs2=getMethodOfProcess(strs1, "org.xnio.Option$10");
//		System.out.println("strs2.size()="+strs2.size());
//		System.out.println("strs2="+strs2);
//
//		HashSet<String>  strs3=getClassSetFromFLFile("C:/Research/XNIO/logs/FL.txt");
//		System.out.println("strs3.size()="+strs3.size());
//		System.out.println("strs3="+strs3);
////		
//	   	for (String str: strs3) {
//	   		System.out.println("getMethodOfProcess(HashSet<String> methods, "+str+").size()="+getMethodOfProcess(strs1,str).size());
//	   	}
		String  str1=getProcessFromMethod("SimpleEchoServer$2");
		System.out.println("str1="+str1);
	}
//	   public static String getMethodFromFL(String str) {  
//		   return str.replace(")>:l", ")>").replace(")>:e", ")>").replace(")>:f", ")>").trim();
//
//	   } 
//	   
	   public static LinkedHashSet<String> getMethodOfClass(LinkedHashSet<String> methods, String classStr) {
		   LinkedHashSet<String> lists = new LinkedHashSet<String>();
		   	for (String str: methods) {
		   		if (str.startsWith(classStr+": ") || str.startsWith("<"+classStr+": "))
		   			lists.add(str);
		   	}
		   return lists;
	   }
	   public static LinkedHashSet<String> getMethodOfProcess(LinkedHashSet<String> methods, String processStr) {
		   LinkedHashSet<String> lists = new LinkedHashSet<String>();
		   	for (String str: methods) {
		   		if (str.startsWith(processStr) || str.startsWith("<"+processStr))
		   			lists.add(str);
		   	}
		   return lists;
	   }
	   public static LinkedHashSet<String> getClassOfProcess(LinkedHashSet<String> methods, String processStr) {
		   LinkedHashSet<String> lists = new LinkedHashSet<String>();
		   
		    LinkedHashSet<String> classes = getClassSetFromMethodSet(methods);
		   	for (String str: classes) {
		   		if (str.startsWith(processStr) || str.startsWith("<"+processStr)) {		   			
		   			String[] processStrs=processStr.split("\\.");
		   			String[] strs=str.split("\\.");
		   			//System.out.println("processStrs.length="+processStrs.length+" strs.length="+strs.length+" processStr="+processStr+" str="+str );
		   			if ((processStrs.length+1)==strs.length  ||  (processStrs.length==0 && strs.length==0) ||  (processStrs.length==1 && strs.length==1)) {	
		   				lists.add(str.replaceFirst("<", ""));
//	    	       		String[] itemStrs=str.split(": ");
//	    	       		if (itemStrs.length>0)
//	    	       			lists.add(itemStrs[0].replaceFirst("<", ""));
		   			}
		   		}	
		   	}
		   return lists;
	   }
	   public static String getProcessFromMethod(String str) {  
		   String resultS="";
		   if (str==null || str.length()<1)
			   return "";
		   String[] strs=str.split(": ");
		   if (strs.length<1)
		   	  return "";
		   String classStr=strs[0];
		   
		   String[] classStrs=classStr.split("\\.");
		   if (classStrs.length<1) {
			   resultS=classStr;
		   }
		   else if (classStrs.length==1) {
			   resultS=classStrs[0];
		   }
		   else  
		   {
			   
			   for (int i=0; i<classStrs.length-1;i++) {
				   resultS=resultS+classStrs[i]+".";
			   }
			   //System.out.println("resultS="+resultS);
			   resultS=resultS.substring(0,resultS.length()-1);
			   resultS=resultS.replaceFirst("<", "");
			   
		   }
		   //remove $
		   String[] resultSs=resultS.split("\\$");
		   //System.out.println("resultSs.length="+resultSs.length);
		   if (resultSs.length<1) {
			   	  return resultS.replaceFirst("<", "");
		   }
		   else
			   return resultSs[0].replaceFirst("<", "");
		  
	   }   

//	    public static LinkedHashSet<String> getClassSetFromFLFile(String file1) {  
//	        FileReader reader1 = null;  
//	        BufferedReader br1 = null;    
//	        //LinkedHashSet<String> classes = new LinkedHashSet<String>();	
//	        LinkedHashSet<String> lists = new HashSet<>();  
//	        try {  
//	            reader1 = new FileReader(file1);  	   
//	            String str = "";  	   
//	            br1 = new BufferedReader(reader1);
//	
//	            while ((str = br1.readLine()) != null) { 
//	    	       	String itemStr=getMethodFromFL(str);
//	    	       	if (itemStr.length()>1)  {
//	    	       		String[] itemStrs=itemStr.split(": ");
//	    	       		if (itemStrs.length>0)
//	    	       			lists.add(itemStrs[0].replaceFirst("<", ""));
//	    	       	}	
//	            }  	   
//	            br1.close();  
//	            reader1.close(); 	           
//	            
//	        } catch (IOException e) {  
//	            e.printStackTrace();  	            
//	        }         
//	        return lists;
//	    }
//	    
//	    public static LinkedHashSet<String> getMethodSetFromFLFile(String file1) {  
//	        FileReader reader1 = null;  
//	        BufferedReader br1 = null;    
//	        //LinkedHashSet<String> classes = new LinkedHashSet<String>();	
//	        LinkedHashSet<String> lists = new HashSet<>();  
//	        try {  
//	            reader1 = new FileReader(file1);  	   
//	            String str = "";  	   
//	            br1 = new BufferedReader(reader1);
//	
//	            while ((str = br1.readLine()) != null) { 
//	    	       	String itemStr=getMethodFromFL(str);
//	    	       	if (itemStr.length()>1)
//	    	       		lists.add(itemStr);
//	            }  
//	   
//	            br1.close();  
//	            reader1.close();  
//	           
//	            
//	        } catch (IOException e) {  
//	            e.printStackTrace();  
//	            
//	        }         
//
//	        return lists;
//	    }
//	    
	    public static LinkedHashSet<String> getMethodSetFromFL(HashMap<String, Integer> F, HashMap<String, Integer> L) {  
	        //LinkedHashSet<String> classes = new LinkedHashSet<String>();	
	        LinkedHashSet<String> lists = new LinkedHashSet<String>();  
	        for (String m : F.keySet()) {
	        	lists.add(m);
	        }
	        for (String m2 : L.keySet()) {
	        	lists.add(m2);
	        }
	        return lists;
	    }
	    
	    public static LinkedHashSet<String> getClassSetFromMethodSet(LinkedHashSet<String> ms) {  
	        //LinkedHashSet<String> classes = new LinkedHashSet<String>();	
	        LinkedHashSet<String> lists = new LinkedHashSet<String>();  
	        for (String m : ms) {
    	       	if (m.length()>1)  {
    	       		String[] itemStrs=m.split(": ");
    	       		if (itemStrs.length>0)
    	       			lists.add(itemStrs[0].replaceFirst("<", ""));
    	       	}	
	        }
	        return lists;
	    }
	    
	    public static LinkedHashSet<String> getClassSetFromFL(HashMap<String, Integer> F, HashMap<String, Integer> L) {  
	        //LinkedHashSet<String> classes = new LinkedHashSet<String>();	
	        LinkedHashSet<String> lists = new LinkedHashSet<String>();  
	        for (String m : F.keySet()) {
    	       	if (m.length()>1)  {
    	       		String[] itemStrs=m.split(": ");
    	       		if (itemStrs.length>0)
    	       			lists.add(itemStrs[0].replaceFirst("<", ""));
    	       	}	
	        }
	        for (String m : L.keySet()) {
    	       	if (m.length()>1)  {
    	       		String[] itemStrs=m.split(": ");
    	       		if (itemStrs.length>0)
    	       			lists.add(itemStrs[0].replaceFirst("<", ""));
    	       	}	
	        }
	        return lists;
	    }
	    public static LinkedHashSet<String> getProcessSetFromFL(HashMap<String, Integer> F, HashMap<String, Integer> L) {  
	        //LinkedHashSet<String> classes = new LinkedHashSet<String>();	
	        LinkedHashSet<String> lists = new LinkedHashSet<String>();  
	        for (String m : F.keySet()) {
    	       	if (m.length()>1)  {
    	       		lists.add(getProcessFromMethod(m));
    	       	}	
	        }
	        for (String m : L.keySet()) {
    	       	if (m.length()>1)  {
    	       		lists.add(getProcessFromMethod(m));
    	       	}	
	        }
	        return lists;
	    }

//		// soot option 1
//		public static void initial(String classPath) {
//			soot.G.reset();
//			Options.v().set_allow_phantom_refs(true);
//			Options.v().set_process_dir(Collections.singletonList(classPath));//
//			Options.v().set_whole_program(true);
//			Scene.v().loadNecessaryClasses();
//			
//		}
//		
//		// soot option 2
//		public static void enableSpark(String path){
//	        HashMap opt = new HashMap();
//	        //opt.put("verbose","true");
//	        //opt.put("propagator","worklist");
//	        opt.put("simple-edges-bidirectional","false");
//	        //opt.put("on-fly-cg","true");
//	        opt.put("apponly", "true");
////	        opt.put("set-impl","double");
////	        opt.put("double-set-old","hybrid");
////	        opt.put("double-set-new","hybrid");
////	        opt.put("allow-phantom-refs", "true");
//	        opt.put("-process-dir",path);
//	        
//	        SparkTransformer.v().transform("",opt);
//	    }
	    
}
