import java.io.*;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

//import soot.jimple.spark.SparkTransformer;
//import soot.options.Options;
//import soot.*;
//import soot.jimple.*;

public class methodRatio{
	//static Set<String> changeSet = new LinkedHashSet<String>();
	//static Map<String, Set<String> > impactSets_Diver = new LinkedHashMap<String, Set<String>>();
	//static HashMap<String, Integer> impactSet_dist = new LinkedHashMap<String, Integer> ( );
	
	//static int nExecutions = 1;  //Integer.MAX_VALUE;
	
	/* the dynamic transfer graph underneath the impact computation with all execution traces */
	//static final DynTransferGraph dvtg = new DynTransferGraph();
	
	static boolean debugOut = true;

	// or compute impact sets for multiple queries at the same time when traversing the execution trace for only once
	static boolean matchingDynVTGForAllQueries = false;
	// include the pruning approach just for a comparison
	static boolean pruningDynVTGForAllQueries = false;
	
	/** if applying runtime statement coverage information to prune statements not executed, examined per test case */
	public static boolean applyStatementCoverage = false;
	/** prune non-covered/non-aliased nodes and edges prior to or after basic querying process: 
	 * both are equivalent in terms of eventual impact set but can be disparate in performance
	 */
	//public static boolean postPrune = true;
	
	/** if applying runtime object alias checking to prune heap value edges on which the source 
	 * and target nodes are not dynamically aliased 
	 */
	public static boolean applyDynAliasChecking = false;
	/** if pruning based on the dynamic alias information at the method instance level, or just the method level */
	public static boolean instancePrune = true; 
	//static Map<String, Set<String>> localImpactSets = new LinkedHashMap<String, Set<String>>();
	// distEA variables
	static boolean separateReport = true;
	static boolean reportCommon = false;
	static boolean strictComponent = false; // strictly two different components won't have common traces --- they have to communicate by message passing
	static boolean improvedPrec = false; // choose between the purely EA-based and precision-improved versions
	static boolean runDiver = false;
	//static Set<String> impactSet = new LinkedHashSet<String>();

	//static Map<String, HashMap<String, Integer>> f2S = new HashMap<String, HashMap<String, Integer>>();

	public static void main(String args[]){
		/*
		String path = "";
	      if(args.length == 0)
	      {
	          //System.out.println("Usage: directory");
	          System.exit(0);
	      }            
//	      else
//				System.out.println("[mainClass]"+args[0]);	
	      path = args[0]; 
		FLUtil.initial(path);
		FLUtil.enableSpark(path);
*/	
//		String file1="diff0Available.txt";
//		String file2="test1/clientlog";
//
//		
//	    if (args.length>1) {
//			//System.out.println("args[1]="+args[1]);
//			file1=args[0];
//		    if (args.length>1) {
//				//System.out.println("args[2]="+args[2]);
//				file2=args[1];
//		    }			
//	    }
//		    		
		
		String file1="C:/Research/Zookeeper_System/diff0Available.txt";
		String file2="C:/Research/Zookeeper_System/test1/clientlog";		
//		 HashSet<String>  strs1=FLUtil.getMethodSetFromFLFile(file2+"/FL.txt");
//		System.out.println("strs1.size()="+strs1.size());
//		System.out.println("strs1="+strs1);
//		
//		HashSet<String>  strs2=FLUtil.getMethodOfProcess(strs1, "org.xnio.Option$10");
//		System.out.println("strs2.size()="+strs2.size());
//		System.out.println("strs2="+strs2);
//
//		HashSet<String>  strs3=FLUtil.getProcessSetFromFLFile(file2+"/FL.txt");
//		System.out.println("strs3.size()="+strs3.size());
//		System.out.println("strs3="+strs3);
////		
//	   	for (String str: strs3) {
//	   		System.out.println("getMethodOfProcess(HashSet<String> methods, "+str+").size()="+FLUtil.getMethodOfProcess(strs1,str).size());
//	   	}
	   	availableIPC(file1, file2);
	}
	
//	public static int init(String binDir) {
//		return 0;
//	}
//	
	

    
	@SuppressWarnings("unchecked")
	public static void mergeTraces(File loc, HashMap<String, Integer> F, HashMap<String, Integer> L)  throws IOException, ClassNotFoundException {
		if (loc.isFile() && loc.getName().endsWith(".em")) {
			FileInputStream fis = new FileInputStream(loc);
			ObjectInputStream ois = new ObjectInputStream(fis);
			HashMap<String, Integer> curF =  (HashMap<String, Integer>) ois.readObject();
			HashMap<String, Integer> curL =  (HashMap<String, Integer>) ois.readObject();
			
			F.putAll(curF);
			L.putAll(curL);
			
			fis.close();
			ois.close();
			
			return;
		}
		
		if (!loc.isDirectory()) { return; }
		
		for (String fname : loc.list()) {
			mergeTraces (new File(loc, fname), F, L);
		}
	}
	/** compute impacts from the trace dumped by one OS process with respect to a test input */ 
	private static int computeProcesTrace(List<String> Chglist, HashMap<String, Integer> F, 
			HashMap<String, Integer> L, List<String> localChgSet, Set<String> localImpactSet) {
		// determine the CLT (Change with Least Time-stamp in F)
		String CLT = "";
		Integer tsCLT = Integer.MAX_VALUE;
		for (String chg : Chglist) {
			for (String m : F.keySet()) {
				//System.out.println("m="+m+" chg="+chg);	
				if ( !m.toLowerCase().contains(chg.toLowerCase()) && 
						!chg.toLowerCase().contains(m.toLowerCase()) ) {
					// unmatched change specified even with a very loose matching
					continue;
				}
				localChgSet.add(m);
				if (F.get(m) <= tsCLT) {
					tsCLT = F.get(m);
					CLT = m;
					//System.out.println("F.get(m)="+F.get(m)+" tsCLT="+tsCLT);	
				}
			}
		}
		// compute the impact set with respect to this execution trace
		for (String m : L.keySet()) {
			if (L.get(m) >= tsCLT) {
				localImpactSet.add(m);
			}
		}
		return tsCLT;
	}
	

	
	public static void parseTraces(String traceDir, HashMap<String, Integer> F, HashMap<String, Integer> L, Map<String, HashMap<String, Integer>> f2L, Map<String, HashMap<String, Integer>> f2F, Map<String, HashMap<String, Integer>> f2S) {
		String dnSource = traceDir  + File.separator;
		try {
			//System.out.println("dnSource="+dnSource);
			mergeTraces(new File(dnSource), F, L);	
			//System.out.println("F.size()="+F.size());
			//System.out.println("L.size()="+L.size());			
			File dn = new File(dnSource);
			//System.out.println("dn="+dn);
			// load trace of all processes into memory
			//long fixtime = System.currentTimeMillis();
			for (String fname : dn.list()) {
				//System.out.println("fname="+fname);
				File loc = new File(dn, fname);
				if (loc.isFile() && loc.getName().endsWith(".em")) {
					FileInputStream fis = new FileInputStream(loc);
					ObjectInputStream ois = new ObjectInputStream(fis);
					HashMap<String, Integer> curF =  (HashMap<String, Integer>) ois.readObject();
					HashMap<String, Integer> curL =  (HashMap<String, Integer>) ois.readObject();
					
					if (improvedPrec) {
						HashMap<String, Integer> _curS =  (HashMap<String, Integer>) ois.readObject();
						HashMap<String, Integer> curS = new HashMap<String, Integer>();
						for (Map.Entry<String, Integer> entry : _curS.entrySet()) {
							String k = entry.getKey().trim().replace("\0", "");
							Integer v = entry.getValue();
							curS.put(k, v);
						}
						f2S.put(loc.getAbsolutePath(), curS);
					}
					
					f2L.put(loc.getAbsolutePath(), curL);
					f2F.put(loc.getAbsolutePath(), curF);
					fis.close();
					ois.close();
				}
			}
			//fixtime = System.currentTimeMillis() - fixtime;
			
			//final long step2stopTime = System.currentTimeMillis();
			//System.out.println("	separateParseTraces_LoadTrace took " + (step2stopTime - step1startTime ) + " ms");
			// compute impacts in local and external processes
				
//				String ProcessI = "";
//				if (improvedPrec) {
//					HashMap<String, Integer> curS = f2S.get(tf);
//					//assert curS.containsValue(Integer.MAX_VALUE);
//					for (String pid : curS.keySet()) {
//						if (curS.get(pid)==Integer.MAX_VALUE) {
//							ProcessI = pid;
//							break;
//						}
//					}
//					//assert ProcessI != null;
//				}		
//			}	
		}
		catch (FileNotFoundException e) {
			return;
		}
		catch (ClassCastException e) {
			//System.err.println("Failed to cast the object deserialized to HashMap<String, Integer>!");
			return;
		}
		catch (IOException e) {
			//throw new RuntimeException(e); 
			return;
		}
		catch (Exception e) {
			//e.printStackTrace();
			return;
		}

	}
	public static LinkedHashSet<String> getMethodDep(String query,Map<String, HashMap<String, Integer>> f2L, Map<String, HashMap<String, Integer>> f2F, Set<String> localImpactSet, Set<String> exImpactSet) {
		Integer tsCLT = Integer.MAX_VALUE;
		LinkedHashSet<String> impactSet = new LinkedHashSet<String>();
		List<String> Chglist = new ArrayList<String>();
		Chglist.add(query);
		List<String> localChgSet = new ArrayList<String>();
		//Set<String> localImpactSet = new LinkedHashSet<String>();	
		for (String tf : f2F.keySet()) {
			HashMap<String, Integer> curF =  f2F.get(tf);
			HashMap<String, Integer> curL = f2L.get(tf);
			tsCLT = computeProcesTrace(Chglist, curF, curL, localChgSet, localImpactSet);	
			//System.out.println("tsCLT="+tsCLT);
			// impacted methods in other processes
			//Set<String> exImpactSet = new LinkedHashSet<String>();
			//int excludedN = 0;
			for (String tl : f2L.keySet()) {
				if (tl.equalsIgnoreCase(tf)) { continue; }
				if (strictComponent) {
					Set<String> lptrace = new LinkedHashSet<String>(f2F.get(tf).keySet());
					lptrace.retainAll(f2L.get(tl).keySet());
					if (!lptrace.isEmpty()) continue;
				}
				for (String m : f2L.get(tl).keySet()) {
					//System.out.println("f2L.get(tl).get(m)="+f2L.get(tl).get(m)+" tsCLT="+tsCLT);
					if (f2L.get(tl).get(m) >= tsCLT) {						
							exImpactSet.add(m);						
					}
				}
				//changeSet.addAll(localChgSet);
				impactSet.addAll(localImpactSet);
			}
			if (exImpactSet!=null && !exImpactSet.isEmpty())
				impactSet.addAll(exImpactSet);
		}	
		return impactSet;
//		if (impactSet!=null) {
//			return impactSet.size();
//		}
//		else			
//			return 0;
	}

	
	public static void availableIPC(String fileName, String branchPath)  {
		  File file = new File(fileName);
		  BufferedReader reader = null;
	        try {  
				reader = new BufferedReader(new FileReader(file));
				String tempStr="";
				//String fullPath=branchPath;
				
				
				while ((tempStr = reader.readLine()) != null) {
					if (tempStr.length()>0) {
						//fullPath=branchPath+"/"+tempStr.replace("-", "_")+"/FL.txt";
						try {
							//mergeTraces(new File(branchPath+"/"), F, L);	
							HashMap<String, Integer> F = new HashMap<String, Integer> ( );
							HashMap<String, Integer> L = new HashMap<String, Integer> ( );
							Map<String, HashMap<String, Integer>> f2L = new HashMap<String, HashMap<String, Integer>> ();
							Map<String, HashMap<String, Integer>> f2F = new HashMap<String, HashMap<String, Integer>> ();
							Map<String, HashMap<String, Integer>> f2S = new HashMap<String, HashMap<String, Integer>>();
							parseTraces(branchPath+"/"+tempStr.replace("-", "_"), F, L, f2L, f2F, f2S);	
							
//							System.out.println("F="+F);
//							System.out.println("L="+L);
//							System.out.println("f2F="+f2F);
//							System.out.println("f2L="+f2L);
//							System.out.println("f2L.size()="+f2L.size());
//							System.out.println("f2F.size()="+f2F.size());
							//mergeTraces(branchPath,F,L);
	//						int mC=1+getAComplexity(fullPath);
	//						if (mC>0)
	//							System.out.println(tempStr+","+mC);
							//System.out.println(fullPath);
//							Map<String, LinkedHashSet<String>> methodLocalImpactSet = new HashMap<String, LinkedHashSet<String>>();
//							Map<String, LinkedHashSet<String>> methodExImpactSet = new HashMap<String, LinkedHashSet<String>>();
//							 Map<String, LinkedHashSet<String>> methodImpactSet = new HashMap<String, LinkedHashSet<String>>();
							 LinkedHashSet<String>  methodStrs=getMethodSetFromFL(F,L);
//							 for (String m: methodStrs) {	
//								 	LinkedHashSet<String> localImpactSet = new LinkedHashSet<String>();	
//								 	LinkedHashSet<String> exImpactSet = new LinkedHashSet<String>();	
//									LinkedHashSet<String> impactSet = getMethodDep(m,f2L, f2F, localImpactSet, exImpactSet);
//									methodLocalImpactSet.put(m, localImpactSet);
//									methodExImpactSet.put(m, exImpactSet);
//									methodImpactSet.put(m, impactSet);
//							 }
							//System.out.println("methodStrs.size()="+methodStrs.size());
							//System.out.println("methodStrs="+methodStrs);
//							for (String m1: methodStrs)  {
//								System.out.println(m1);
//							}
								
							HashSet<String>  processStrs=getProcessSetFromFL(F,L);
							//System.out.println("processStrs.size()="+processStrs.size());
							//System.out.println("processStrs="+processStrs);
							 int MAll=methodStrs.size();
							 if (MAll<1)
								 continue;
							 int pmAll=0;
							 for (String processStr: processStrs) {
									LinkedHashSet<String> classesInProcess=getClassOfProcess(methodStrs, processStr);								
									int pm=0;
									for (String classStr: classesInProcess) {
										LinkedHashSet<String> methodsInClass=getMethodOfClass(methodStrs, classStr);
										//System.out.println("processStr="+processStr+" classStr="+classStr+" methodsInClass.size()="+methodsInClass.size());
//										for (String m3: methodsInClass)  {
//											System.out.println(m3);
//										}
										
										pm=pm+methodsInClass.size();
									}
									//System.out.println("pm="+pm);
									pmAll=pmAll+pm;
							 }
							 
							 
							//System.out.println("MAll="+MAll);

//							double RCCAll=0;
//							double CCCAll=0;
//							int CCCCount=0;
//							double IPRAll=0;
//							double CCLAll=0;
//							int CCLCount=0;
//							double PLCAll=0;
//							int PLCCount=0;
//							for (String processStr: processStrs) {
//								int LDSProcessSize=0;
//								double RCCProcess=0;
//								
//								LinkedHashSet<String> methodsInProcess=FLUtil.getMethodOfProcess(methodStrs, processStr);
//								int MProcess=methodsInProcess.size(); 
//								Set<String> impactSetClass = new LinkedHashSet<String>();
//								
//								LinkedHashSet<String> classesInProcess=FLUtil.getClassOfProcess(methodStrs, processStr);								
//								//System.out.println("processStr="+processStr+" classesInProcess.size()="+classesInProcess.size());
//								for (String classStr: classesInProcess) {
//									int RDSClassSize=0;					
//									double CCCClass=0;
//									
//									LinkedHashSet<String> methodsInClass=FLUtil.getMethodOfClass(methodStrs, classStr);
//									int MClass=methodsInClass.size(); 
//									for (String mStr: methodsInClass) {	
//										double RCCMethod=0;
//										double IPRMethod=0;
//										//System.out.println("processStr="+processStr+" classStr="+classStr+" methodsInClass.size()="+methodsInClass.size()+" mStr="+mStr);
//										
//										LinkedHashSet<String> impactSet = new LinkedHashSet<String>();
//										impactSet=methodImpactSet.get(mStr);
//										if (impactSet==null)
//											continue;
//										LinkedHashSet<String> localImpactSet = new LinkedHashSet<String>();	
//										localImpactSet=methodLocalImpactSet.get(mStr);
//										LinkedHashSet<String> exImpactSet = new LinkedHashSet<String>();
//										exImpactSet=methodExImpactSet.get(mStr);
//										
//										
//										//getMethodDep(mStr,f2L, f2F, localImpactSet, exImpactSet);
//										
//										//compute RCC
//										if (impactSet.size()>0) {
//											for (String processStr2: processStrs) {
//												if (processStr2.equals(processStr))
//												  continue;
//												HashSet<String> methodsInProcess2=FLUtil.getMethodOfProcess(methodStrs, processStr2);
//												for (String mStr2: methodsInProcess2) {	
////													Set<String> localImpactSet2 = new LinkedHashSet<String>();	
////													Set<String> exImpactSet2 = new LinkedHashSet<String>();	
////													Set<String> impactSet2 = getMethodDep(mStr2,f2L, f2F, localImpactSet2, exImpactSet2);
//													LinkedHashSet<String> impactSet2 = new LinkedHashSet<String>();
//													impactSet2=methodImpactSet.get(mStr2);
//													Set<String> impactSet12InterSection = new LinkedHashSet<String>();	
//													impactSet12InterSection.addAll(impactSet);
//													impactSet12InterSection.retainAll(impactSet2);
//													//System.out.println("RCCMethodOld="+RCCMethod);
//													double RCCM2=(double)impactSet12InterSection.size()/impactSet.size();
//													RCCMethod=RCCMethod+ RCCM2;  // (double)impactSet12InterSection.size()/impactSet.size();
//													//System.out.println("RCCMethod="+RCCMethod+"RCCM2="+RCCM2);
//												}
//											}		
//											RCCProcess=RCCProcess+RCCMethod;
//											CCCClass=CCCClass+RCCMethod;
//										}  
//										
//										
//										
//										Set<String> localExInterSection = new LinkedHashSet<String>();	
//										localExInterSection.addAll(localImpactSet);
//										localExInterSection.retainAll(exImpactSet);
////System.out.println(classStr+"   "+mStr+"  impactSet.size()"+impactSet.size()+"  localImpactSet.size()"+localImpactSet.size()+"  exImpactSet.size()"+exImpactSet.size()+"  localExInterSection.size()"+localExInterSection.size());
//										RDSClassSize+=exImpactSet.size();
//										LDSProcessSize+=localImpactSet.size();
//										
//										IPRMethod=(double)localExInterSection.size()/MAll;
//										//System.out.println("IPRMethod="+IPRMethod);
//										IPRAll=IPRAll+IPRMethod;  //localExInterSection.size()/MAll;
//										//System.out.println(" localExInterSection.size()="+localExInterSection.size()+" MAll="+MAll+" IPRMethod="+IPRMethod+" IPRAll="+IPRAll);
//									}  //method									
//									CCCAll=CCLAll+CCCClass;
//									CCCCount++;
//									
//									//System.out.println("CCLAllOld="+CCLAll);
//									double CCLClass=(double)RDSClassSize/MClass;
//									CCLAll=CCLAll+CCLClass;	
//									//System.out.println("CCLAll="+CCLAll+" CCLClass="+CCLClass);
//									
//									CCLCount++;
//								} //class
//								RCCAll=RCCAll+RCCProcess;
//								
//								//System.out.println("PLCAllOld="+PLCAll);
//								double PLCProcess=(double)LDSProcessSize/MProcess;
//								PLCAll=PLCAll+PLCProcess;	
//								//System.out.println("PLCAllOld="+PLCAll+" PLCProcess="+PLCProcess);
//								PLCCount++;
//
//							}		//process
//							int processCount=processStrs.size();
//							double RCC=(RCCAll/(processCount*(processCount-1)));
//							double CCC=CCCAll/CCCCount;
//							double IPR=IPRAll/MAll;
//							double CCL=CCLAll/CCLCount;
//							double PLC=PLCAll/PLCCount;
							//tempStr
							//System.out.println("CCCCount="+CCCCount+" CCLCount="+CCLCount+" PLCCount="+PLCCount);
							System.out.println(tempStr+","+MAll+","+pmAll+","+(float)MAll/pmAll);
					
						}
						catch (Exception e) {
							e.printStackTrace();
						}					
//				  String methodStr=getMethodFromFL(tempStr);
//				  if (methods.contains(methodStr))
//					  methodCount++;
					}  //if
				}
				reader.close();
			

			
	        } catch (IOException e) {  
	            e.printStackTrace();  
	           
	        }  
	       
		}  
	    
	   public static LinkedHashSet<String> getClassOfProcess(LinkedHashSet<String> methods, String processStr) {
		   LinkedHashSet<String> lists = new LinkedHashSet<String>();
		   	for (String str: methods) {
		   		if (str.startsWith(processStr) || str.startsWith("<"+processStr)) {
    	       		String[] itemStrs=str.split(": ");
    	       		if (itemStrs.length>0)
    	       			lists.add(itemStrs[0].replaceFirst("<", ""));
		   		}	
		   	}
		   return lists;
	   }
	   
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
		   
		   public static LinkedHashSet<String> getMethodOfClass(LinkedHashSet<String> methods, String classStr) {
			   LinkedHashSet<String> lists = new LinkedHashSet<String>();
			   	for (String str: methods) {
			   		if (str.startsWith(classStr+": ") || str.startsWith("<"+classStr+": "))
			   			lists.add(str);
			   	}
			   return lists;
		   }
}