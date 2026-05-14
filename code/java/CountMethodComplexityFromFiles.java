import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;

import soot.jimple.spark.SparkTransformer;
import soot.options.Options;
import soot.*;
import soot.jimple.*;

public class CountMethodComplexityFromFiles {
	public static String path = "";
	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		 HashSet<String>  strs1=getMethodSetFromFLFile("C:/Research/XNIO/logs/FL.txt");
//		System.out.println("strs1.size()="+strs1.size());
//		System.out.println("strs1="+strs1);
	      if(args.length == 0)
	      {
	          //System.out.println("Usage: directory");
	          System.exit(0);
	      }            
//	      else
//				System.out.println("[mainClass]"+args[0]);	
	      path = args[0]; 
		initial(path);
		enableSpark(path);
		
		String file1="diff0Available.txt";
		String file2="test1/clientlog";
	    if (args.length>1) {
			//System.out.println("args[1]="+args[1]);
			file1=args[1];
		    if (args.length>1) {
				//System.out.println("args[2]="+args[2]);
				file2=args[2];
		    }			
	    }
		availableMC(file1, file2);
	}
	
	private static int getAComplexity (String FLpath) {
		int mc=1;
		String methodStr="";
		HashSet<String>  methods=getMethodSetFromFLFile(FLpath);
		//System.out.println("methods.size()="+methods.size());
		//System.out.println("methods="+methods);
		for (SootClass sClass:Scene.v().getApplicationClasses()) 
		{
			if ( sClass.isPhantom() ) {	continue; }
			if ( !sClass.isConcrete() ) {	continue; }
			for(SootMethod m:sClass.getMethods())
			{
				if(!m.isConcrete()) {	continue; }
				methodStr=m.toString();
				//System.out.println("methodStr="+methodStr);
				if (methods.contains(methodStr)) {
					Iterator<Unit> stmts=m.retrieveActiveBody().getUnits().snapshotIterator();
					String midStr1="";
					while(stmts.hasNext())
					{
						Unit u=stmts.next();
						//if(!(u instanceof IdentityStmt) && !(u instanceof AssignStmt) && !(u instanceof InvokeStmt) && !(u instanceof DefinitionStmt) && !(u instanceof RetStmt)) 
						//{	continue; }
						midStr1=u.toString();
						//System.out.println("methodStr="+methodStr+" midStr1="+midStr1);
						if (midStr1.indexOf("&&")>0)
							mc++;
						if (midStr1.indexOf("||")>0)
							mc++;
						if (midStr1.indexOf("?")>0 && midStr1.indexOf(":")>midStr1.indexOf("?"))  						
							mc++;
						
					   if (midStr1.indexOf("for")>=0 || midStr1.indexOf("while")>=0  || midStr1.indexOf("catch")>=0 || midStr1.indexOf("break")>=0 || midStr1.indexOf("continuous")>=0)
						   mc++;
					   if (midStr1.indexOf("else if")>=0) {
						   mc++;
					   }
					   else {
						   if (midStr1.indexOf("if")>=0 || midStr1.indexOf("else")>=0)
							   mc++;
					   }
					}	
				}
					
			}	
			
		}	
		//System.out.println("mc="+mc);
		return mc;
		
	}
	
	// soot option 1
	private static void initial(String classPath) {
		soot.G.reset();
		Options.v().set_allow_phantom_refs(true);
		Options.v().set_process_dir(Collections.singletonList(classPath));//
		Options.v().set_whole_program(true);
		Scene.v().loadNecessaryClasses();
		
	}
	
	// soot option 2
    private static void enableSpark(String path){
        HashMap opt = new HashMap();
        //opt.put("verbose","true");
        //opt.put("propagator","worklist");
        opt.put("simple-edges-bidirectional","false");
        //opt.put("on-fly-cg","true");
        opt.put("apponly", "true");
//        opt.put("set-impl","double");
//        opt.put("double-set-old","hybrid");
//        opt.put("double-set-new","hybrid");
//        opt.put("allow-phantom-refs", "true");
        opt.put("-process-dir",path);
        
        SparkTransformer.v().transform("",opt);
    }
    
	   public static String getMethodFromFL(String str) {  
		   return str.replace(")>:l", ")>").replace(")>:e", ")>").trim();

	   } 
	   
	    public static HashSet<String> getMethodSetFromFLFile(String file1) {  
	        FileReader reader1 = null;  
	        BufferedReader br1 = null;    
	        //HashSet<String> classes = new HashSet<String>();	
	        HashSet<String> lists = new HashSet<>();  
	        try {  
	            reader1 = new FileReader(file1);  	   
	            String str = "";  	   
	            br1 = new BufferedReader(reader1);
	
	            while ((str = br1.readLine()) != null) { 
	    	       	String itemStr=getMethodFromFL(str);
	    	       	if (itemStr.length()>1)
	    	       		lists.add(itemStr);
	            }  
	   
	            br1.close();  
	            reader1.close();  
	           
	            
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
							fullPath=branchPath+"/"+tempStr.replace("-", "_")+"/FL.txt";
							int mC=1+getAComplexity(fullPath);
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
