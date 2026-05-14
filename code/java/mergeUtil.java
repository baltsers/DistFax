
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Set;

import jxl.Sheet;
import jxl.Workbook;
import jxl.write.Label;
import jxl.write.WritableSheet;
import jxl.write.WritableWorkbook; 
import jxl.write.WriteException;
import jxl.write.biff.RowsExceededException;


public class mergeUtil {
	public static void main(String []args) {
		//System.out.println(""+getSoucePathNumFromStr("[The statement path length]: 66+0+1=67")); 
		//System.out.println(""+getRemotePathNumFromStr("[The statement path length]: 66+0+1=67")); 
		//System.out.println(""+getSinkPathNumFromStr("[The statement path length]: 66+0+1=67"));  getPathTimeFromStr(String longStr)
		//System.out.println(""+getPathTypeFromStr("[The statement path type of <NioServer: void send(java.nio.channels.SocketChannel,byte[])> - specialinvoke $r8.<ChangeRequest: void <init>(java.nio.channels.SocketChannel,int,int)>(r1, 2, 4); <NioClient: void main(java.lang.String[])> - virtualinvoke $r18.<java.io.PrintStream: void println(java.lang.String)>($r24) ]: Remote"));
		//System.out.println(""+getPathTimeFromStr("[The tainted path checking time of <NioServer: void send(java.nio.channels.SocketChannel,byte[])> - specialinvoke $r8.<ChangeRequest: void <init>(java.nio.channels.SocketChannel,int,int)>(r1, 2, 4); <NioClient: void main(java.lang.String[])> - virtualinvoke $r18.<java.io.PrintStream: void println(java.lang.String)>($r24) ]: 214ms"));  
		//writeFile_2("C:/Research/NIOECHOWK1/JAVA1.txt", "C:/Research/NIOECHOWK1/JAVA2.txt");
		//System.out.println(""+getSecondClassFromLine(" <io.netty.util.NetUtil$1: java.lang.Integer run()> - $r9 = virtualinvoke r21.<java.io.BufferedReader: java.lang.String readLine()>() --> <io.netty.util.NetUtil$1: java.lang.Integer run()> - i1 = staticinvoke <java.lang.Integer: int parseInt(java.lang.String)>($r9)"));
	}
 // get source from line string
    public static String getSourceFromStr(String str) {  
    	
        try {  
            // check the string str
        	if (!str.startsWith(" source <"))
        	{
        		return "";
        	}
        	return str.replace(" source <", "<");
        } catch (Exception e) {  
            e.printStackTrace();  
            return "";
        }  
    }      
    // get sink from line string
    public static String getSinkFromStr(String str) {  
    	
        try {  
            // check the string str
        	if (!str.startsWith(" sink <"))
        	{
        		return "";
        	}
        	return str.replace(" sink <", "<");
        } catch (Exception e) {  
            e.printStackTrace();  
            return "";
        }  
    }      

    // get path numbers from line string
    public static String getPathNumsFromStr(String str) {  
    	
        try {  
            // check the string str
        	if (!str.startsWith("[The statement path length]: "))
        	{
        		return "";
        	}
        	return str.replace("[The statement path length]: ", "");
        } catch (Exception e) {  
            e.printStackTrace();  
            return "";
        }  
    }  
    
    // get source path number from line string
    public static String getSoucePathNumFromStr(String longStr) {  
    	
        try {  
            // check the string str
        	if (!longStr.startsWith("[The statement path length]: "))
        	{
        		return "";
        	}
        	String str=longStr.replace("[The statement path length]: ", "");
        	String strs[]=str.split("\\+");
        	if (strs.length<1)  {
        		return "";
        	}
        	else
        		return strs[0];
        } catch (Exception e) {  
            e.printStackTrace();  
            return "";
        }  
    }  
    
    // get remote path number from line string
    public static String getRemotePathNumFromStr(String longStr) {  
    	
        try {  
            // check the string str
        	if (!longStr.startsWith("[The statement path length]: "))
        	{
        		return "";
        	}
        	String str=longStr.replace("[The statement path length]: ", "");
        	String strs[]=str.split("\\+");
        	if (strs.length<2)  {
        		return "";
        	}
        	else
        		return strs[1];
        } catch (Exception e) {  
            e.printStackTrace();  
            return "";
        }  
    }     
    // get sink path number from line string
    public static String getSinkPathNumFromStr(String longStr) {  
    	
        try {  
            // check the string str
        	if (!longStr.startsWith("[The statement path length]: "))
        	{
        		return "";
        	}
        	String str=longStr.replace("[The statement path length]: ", "");
        	String strs[]=str.split("\\+");
        	if (strs.length<3)  {
        		return "";
        	}
        	String str2=strs[2];
        	//System.out.println("str2= "+str2);
        	String strs2[]=str2.split("=");
        	if (strs2.length<1)  {
        		return "";
        	}
        	else
        		return strs2[0];        	
        } catch (Exception e) {  
            e.printStackTrace();  
            return "";
        }  
    }  
    
    // get pair path type from line string
    public static String getPathTypeFromStr(String longStr) {  
    	
        try {  
            // check the string str
        	String str=longStr;
        	String strs[]=str.split("]: ");
        	if (strs.length<2)  {
        		return "";
        	}
        	else
        		return strs[1].trim();        	       	
        } catch (Exception e) {  
            e.printStackTrace();  
            return "";
        }  
    }  
    
    // get pair path time from line string
    public static String getPathTimeFromStr(String longStr) {  
    	
        try {  
            // check the string str
        	String str=longStr;
        	String strs[]=str.split("]: ");
        	if (strs.length<2)  {
        		return "";
        	}
        	else
        		return strs[1].replace("ms", "");        	       	
        } catch (Exception e) {  
            e.printStackTrace();  
            return "";
        }  
    }  
    // only read line until
    public static String readLinesUntil(BufferedReader br,String untilStr) {

    	try
    	{
    		String str = br.readLine();
    		
    		//System.out.print("readLinesUntil "+str+"\n");
             while (str != null && str.indexOf(untilStr)<0) {             	
             	str = br.readLine();      
             }
            
             return str;
    	}
    	catch (IOException e) {          	
            e.printStackTrace();
            return "";
        }  
    }
    
    // get milliseconds from the string
    public static int getMillisecondsFromString(String str) {  
    	
        try {  
            // check the string str
        	if (str.length()<12 || str.indexOf("milliseconds")<0)
        	{
        		return 0;
        	}
        	// remove milliseconds with splitting the string str
        	String[] strs=str.split("milliseconds"); 
        	if (strs.length<0)
        	{
        		return 0;
        	}
        	else
        	{
        		String millisecondsStr=strs[0];
        		//System.out.println(millisecondsStr);
        		String[] millisecondsStrs=millisecondsStr.split(" "); 
        		int millisecondsStrsLength=millisecondsStrs.length;
            	if (millisecondsStrsLength<0)
            	{
            		return 0;
            	}
            	else
            	{
            		// get the last item 
            		return Integer.parseInt(millisecondsStrs[millisecondsStrsLength-1]);
            	}
        		
        	}
        } catch (Exception e) {  
            e.printStackTrace();  
            return 0;
        }  
    }  
    // writeStringToFile
    public static void writeStringToFile(String strSrc, String dest) {  
        FileWriter writer = null;  
        BufferedWriter bw = null;  
   
        try {  
            File file = new File(dest);  
            if (!file.exists()) {  
                file.createNewFile();  
            }  
               
            // 
            writer = new FileWriter(dest, true); 
            bw = new BufferedWriter(writer);  
            bw.write(strSrc);   
            bw.close();  
            writer.close();  
   
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
    }  
    
    public static void writeFile(String strSrc, String dest) {  
        FileWriter writer = null;  
        FileReader reader = null;  
        BufferedReader br = null;  
        BufferedWriter bw = null;  
   
        try {  
            File file = new File(dest);  
            if (!file.exists()) {  
                file.createNewFile();  
            }  
               
            // 
            writer = new FileWriter(dest, true);  
   
            reader = new FileReader(strSrc);  
   
            String str = null;  
   
            br = new BufferedReader(reader);  
   
            bw = new BufferedWriter(writer);  
   
            while ((str = br.readLine()) != null) {  
            	
                StringBuffer sb = new StringBuffer("");  
   
                sb.append(str + "\n");  
                bw.write(sb.toString());  
            }  
   
            br.close();  
            reader.close();  
   
            bw.close();  
            writer.close();  
   
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
    }  
    
 
    
    public static void writeFileAddPrefix(String strSrc, String dest, String prefix) {  
        FileWriter writer = null;  
        FileReader reader = null;  
        BufferedReader br = null;  
        BufferedWriter bw = null;  
   
        try {  
            File file = new File(dest);  
            if (!file.exists()) {  
                file.createNewFile();  
            }  
               
            // 
            writer = new FileWriter(dest, true);  
   
            reader = new FileReader(strSrc);  
   
            String str = null;  
   
            br = new BufferedReader(reader);  
   
            bw = new BufferedWriter(writer);  
   
            while ((str = br.readLine()) != null) {  
            	
                StringBuffer sb = new StringBuffer("");  
   
                sb.append(prefix+str + "\n");  
                bw.write(sb.toString());  
            }  
   
            br.close();  
            reader.close();  
   
            bw.close();  
            writer.close();  
   
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
    }  
    //
    public static void writeFile_2(String strSrc, String dest) {  
        FileWriter writer = null;  
        FileReader reader = null;  
        BufferedReader br = null;  
        BufferedWriter bw = null;  
   
        try {  
            File file = new File(dest);  
            if (!file.exists()) {  
                file.createNewFile();  
            }  
               
            // 
            writer = new FileWriter(dest, true);  
   
            reader = new FileReader(strSrc);  
   
            String str = null;  
   
            br = new BufferedReader(reader);  
   
            bw = new BufferedWriter(writer);  
   
            while ((str = br.readLine()) != null) {  
            	
                StringBuffer sb = new StringBuffer("");  
                
                System.out.print(str+"\n");                
                if (str.length()>2)
                {	
                	sb.append(str.substring(2, str.length())+"\n");  
                }
                else
                	sb.append("\n");  
            	System.out.print(sb);
               	bw.write(sb.toString());  
            }  
   
            br.close();  
            reader.close();  
   
            bw.close();  
            writer.close();  
   
        } catch (IOException e) {  
            e.printStackTrace();  
        }  
    }  
    
 
    // get first class name
    public static String getFirstClassFromKey(String str) {  
    	
        try {  

        	String[] strs=str.split("; "); 
        	if (strs.length<1)
        	{
        		return "";
        	}
        	else
        	{
        		return strs[0];         	
        	}
        } catch (Exception e) {  
            e.printStackTrace();  
            return "";
        }  
    }   
    // get second class name
    public static String getSecondClassFromKey(String str) {  
    	
        try {  

        	String[] strs=str.split("; "); 
        	if (strs.length<2)
        	{
        		return "";
        	}
        	else
        	{
        		return strs[1];         	
        	}
        } catch (Exception e) {  
            e.printStackTrace();  
            return "";
        }  
    }   
    
    // get second class name
    public static String getThirdClassFromKey(String str) {  
    	
        try {  

        	String[] strs=str.split("; "); 
        	if (strs.length<3)
        	{
        		return "";
        	}
        	else
        	{
        		return strs[2];         	
        	}
        } catch (Exception e) {  
            e.printStackTrace();  
            return "";
        }  
    }   
    // get class name
    public static String getClassFromName(String str) {  
    	
        try {  

        	String[] strs=str.split(": "); 
        	if (strs.length<1)
        	{
        		return "";
        	}
        	else
        	{
        		return strs[0];         	
        	}
        } catch (Exception e) {  
            e.printStackTrace();  
            return "";
        }  
    }    
    // get Second Class
    public static String getSecondClassFromLine(String str) {  
    	String splitStr="";
        try {  
        	if (str.indexOf("-->")>1)
			{
        		splitStr="-->";
			} else	if (str.indexOf("<--")>1)
			{
        		splitStr="<--";
			}
			else 
			{
				return "";
			}
        	//System.out.println("splitStr="+splitStr);
        	String[] strs=str.split(splitStr); 
        	//System.out.println("strs.length="+strs.length);
        	if (strs.length<2)
        	{
        		return "";
        	}
        	else
        	{
        		String strs1=strs[1];
        		//System.out.println("strs1="+strs1);
        		return getClassFromName(strs1);
        	}
        } catch (Exception e) {  
            e.printStackTrace();  
            return "";
        }  
    } 
    // get class name
    public static String getMethodFromName(String str) {  
    	
        try {  

        	String[] strs=str.split(": "); 
        	if (strs.length<2)
        	{
        		return "";
        	}
        	else
        	{
        		return strs[1];         	
        	}
        } catch (Exception e) {  
            e.printStackTrace();  
            return "";
        }  
    }         
    
 // get Change Set method name
    public static String getMethodNameFromString(String str) {  
    	
        try {  
            // check the string str
        	if (str.length()<11 || str.indexOf("[Change Set")<0)
        	{
        		return "";
        	}
        	// remove milliseconds with splitting the string str        	  
    		//System.out.print("str="+str+"\n");
        	String[] strs=str.split("\\[<"); 
        	if (strs.length<1)
        	{
        		return "";
        	}
        	else
        	{
        		String strs1=strs[1].replace(">]", "");   
        		//System.out.print("strs1="+strs1+"\n");
        		String[] strs1s=strs1.split(" from "); 
            	if (strs1s.length<1)
            	{
            		return "";
            	}
            	else
            	{
            		return strs1s[0];   
            		
            	}
        	}
        } catch (Exception e) {  
            e.printStackTrace();  
            return "";
        }  
    }  
    
    // get source class from line string
    public static String getSourceClassFromStr(String longStr) {  
    	 try {  
             // check the string str
         	if (!longStr.startsWith(" source <"))
         	{
         		return "";
         	}
         	String str=longStr.replace(" source <", "");
         	String strs[]=str.split(":");
         	if (strs.length<1)  {
         		return "";
         	}
         	else
         		return strs[0];   	
         } catch (Exception e) {  
             e.printStackTrace();  
             return "";
         }  
    }    
    // get sink class from line string
    public static String getSinkClassFromStr(String longStr) {  
   	 try {  
            // check the string str
        	if (!longStr.startsWith(" sink <"))
        	{
        		return "";
        	}
        	String str=longStr.replace(" sink <", "");
        	String strs[]=str.split(":");
        	if (strs.length<1)  {
        		return "";
        	}
        	else
        		return strs[0];   	
        } catch (Exception e) {  
            e.printStackTrace();  
            return "";
        }  
   }      
    
    public static void HashMapValueAdd1(HashMap map, String mapKey) {  
      	 try {  
     		if (map.containsKey(mapKey))
     		{ 
     			int val=(int)map.get(mapKey);            	
     			//System.out.print("val="+val+"\n");            		
                map.put(mapKey, val+1); 
     		}
     		else
     		{
     			map.put(mapKey, 1); 
     		}
           } catch (Exception e) {  
               e.printStackTrace();  
              
           }  
      }  
}