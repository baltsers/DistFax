# DistFax

Project artifact for:

**DistFax: A Toolkit for Measuring Interprocess Communications and Quality of Distributed Systems**

- Original artifact URL: <https://bitbucket.org/wsucailab/distfax/>
- Imported via `pubs2github` from the publications page
- Downloader: `git` — Cloned https://bitbucket.org/wsucailab/distfax.git (19517 files)


This repository was created automatically. The contents under this
directory mirror what was downloaded from the original artifact link
above; refer to that source for the authoritative version, licensing,
and any updates.

---

## Original `README.md` (from the upstream artifact)

# DistFax: A Toolkit for Measuring Interprocess Communications and Quality of Distributed Systems
-----------
DistFax is a toolkit for common distributed systems, focusing on their quality and interprocess communications (IPCs), a vital aspect of their run-time behaviors. 
DistFax characterizes the coupling and cohesion of distributed systems as IPC metrics as well as their quality. We showed the practicality of characterizing IPC dynamics and quality via the proposed IPC and quality metrics, by computing the measures against eleven real-world distributed systems and their executions. To demonstrate the practical usefulness of DistFax, we extensively investigated how the proposed IPC metrics may help understand and analyze the quality of distributed systems.

#### The demo video can be viewed at https://youtu.be/VLmNiHvOuWQ online.	


-----------
### The IPC and quality metrics computed by DistFax
-----------	
Before getting into the artifact package, it is necessary to understand what the metrics computed by the toolkit are. 

	
#### Summary of IPC Metrics	
	
  Type   |Metric |         Definition / computation                                                |          Justification    
---------|-------|---------------------------------------------------------------------------------|------------------------------ 
         |  RMC  | the interprocess message coupling / computed as                                 | the extent of run-time
         |       | messages sent from one process to another                                       | interactions among processes
         |       |                                                                                 |	 
         |  RCC  | the class coupling across processes / the ratio of #methods in the second class | how methods from a class in
         |       | that are dependent on any method in the first class, to #methods in total which | one process access methods 		  
         |       | depending on any method in the second class in all processes but the first one  | in other processes			 
         |       |                                                                                 |	 
         |  CCC  | the aggregate coupling as regards an individual class executed in a local       | the importance of a class  
Coupling |       | process with respect to classes in all remote processes / the aggregate RCC     | with respect to		
         |       | metrics between the class and other classes in all remote processes             | its coupling strength
         |       |                                                                                 |	 
         |  IPR  | the interprocess coupling of common methods / the intersection of the local and | code overlapping and 
         |       | remote dependence sets divided by the size of the union set of methods executed | reuse across processes  			 
         |       |                                                                                 | 			 
         |  CCL  | the communication load of an individual class communicating with others in all  | how much a class contributes		 
         |       | remote processes / the sum of the sizes of remote dependence sets of the class' | to the communication 
         |       | methods divided by the size of the set of all executed methods in the class     | load among processes	
         |       |                                                                                 |  
         |       |                                                                                 | 
         |       |                                                                                 | 
         |       | internal connections within an individual process / the sum of the sizes of     | the degree to which
Cohension|  PLC  | local dependence sets of all methods in the process, divided by the size of     | the methods of 
         |       | the set of all executed methods in the process                                  | a process belong together


#### Summary of quality Metrics	
	
Metric           | Description                                           | Justification (w.r.t ISO/IEC 25010), meaning the quality characteristic
---------------- | ----------------------------------------------------- | ---------------------------------------
Execution time   | time duration of system execution                     | 'performance efficiency' and its sub-characteristic 'time behavior'
                 |                                                       |					 
Cyclomatic	     | measured at runtime, computed as the                  | maintainability and its sub-characteristics
complexity	     | #(independent flow paths) covered in the execution    | modifiability and testability
                 |                                                       |	
Information flow | #(information flow paths) between all                 | security and its sub-characteristic confidentiality
path count       | sources and sinks considered                          |	
                 |                                                       |	
Information flow | the average length of(information flow paths)         | security and its sub-characteristic confidentiality
path length      | between all sources and sinks considered              |	
                 |                                                       |	
                 | computed as the Euclidean distance between the origin | security and its sub-characteristics confidentiality,	
Attack surface   | <0,0,0> and the vector <#methods that enclose a       | integrity, non-repudiation, accountability,	
                 | source/sink, #network ports used, #files read/written>| and authenticity		


-----------
### Explore the artifact
-----------
#### 1. Directories:

- The directory "code" includes three sub-directories "java", "python", and "src", including Java source code files, Python source code files, and shell scripts, respectively.

- In the directory "data", two sub-directories "fuzz" and "ML", including all data files used by subjects during their executions and classification training and validation data, respectively. There are still six sub-directories "Grizzly", "Netty", "QuickServer", "Thrift", "XNIO", and "xSocket" for library subjects.

- The directory "model" and its subdirectory "preTraining" include pre-trained models (i.e., classifiers).
 	
- The directory "lib" includes all library files.

-----------
### Install DistFax
-----------
      
- Download DistFax_Meterial zip file from https://bitbucket.org/wsucailab/distfax/

- Unzip the file

- Copy all library files from the directory ”tool” of DistFax to a directory (e.g., "lib") defined by the user

- Copy all shell files from the directory ”code/shell” of DistFax to a directory (e.g., "/home/username") defined by the user

- Copy all python files from the directory ”code/python” of DistFax to a directory (e.g., "/home/username") defined by the user

- Copy all data files from the directory ”fuzz” of DistFax to a directory (e.g., "/home/username/fuzz") defined by the user

				
-----------
### Download and install subjects
-----------
- OpenChord   -- https://sourceforge.net/projects/open-chord/files/Open%20Chord%201.0/

- Thrift	  -- http://archive.apache.org/dist/thrift/

- xSocket	  -- https://mvnrepository.com/artifact/org.xsocket/xSocket

- ZooKeeper   -- https://github.com/apache/zookeeper/releases

- Voldemort   -- https://github.com/voldemort/voldemort/releases

- Netty	      -- https://bintray.com/netty/downloads/netty/

- Derby	  	  -- https://db.apache.org/derby/derby_downloads.html

- Karaf	      -- https://mvnrepository.com/artifact/org.apache.karaf/karaf

- XNIO	      -- https://mvnrepository.com/artifact/org.jboss.xnio/xnio-api

- Grizzly     -- https://repo1.maven.org/maven2/org/glassfish/grizzly/grizzly-framework/

- QuickServer -- http://www.quickserver.org/download.html

-----------
### Typical workflow of DistFax (with classifiers already trained)
-----------
  
	In a typical use scenario, DistFax workflow includes four phases as described below.

#### Instrumentation 

	1. Copy the directory ”fuzz/test1” of DistFax to the directory of each project directory (e.g., /home/username/thrift) defined by the user

	2. Instrument the subject

	We execute #subject#/DTInstr.sh and #subject#/DT2BranchPre.sh. 
	For example, we execute /home/username/thrift/Instr.sh running DTInstr.sh and DT2BranchPre.sh.

	 
#### Tracing

	1. Run the instrumented subject 	
	
	We run the relevent shell script(s) to execute instrumented subject with inputs in the subject directory. 
	For example, we execute instrumented Thrift with unique inputs using /home/username/thrift/Run.sh that 
	runs "serverclient3DTFromToAvailable.sh 1 2000" and "serverclient3DT2BrPreFromToAvailable.sh 1 2000".

#### Characterization 

	In this phase, DistFax computes IPC metrics using /home/username/#subject#/characterize.sh such as /home/username/thrift/characterize.sh:
	
Computation for | Command    
------------ | -------------
RMC | java -cp ../DistFax.jar Count#subject#RMC 
RCC/CCC/IPR/CCL/PLC | java -cp ../DistFax.jar methodAnalysis   
 		 
#### Classification

	In this phase, DistFax classifies the quality status of the given system with respect to one of the quality metrics found 
	to be moderately or strongly correlated with one or more of our IPC metrics.
	
	1. Unsupervised learning (based on python 3, code/python/unsupervised.sh):	

Script                           | Functionality                                                          | Validation    
-------------------------------- | ---------------------------------------------------------------------- | --------------- 
Kmeans_CCCAttack.py              | Using CCC as features to classify (run-time) attack surface            | Hold-out       
Kmeans_CCCAttack_Cross.py        | Using CCC as features to classify (run-time) attack surface            | 10-fold cross  
Kmeans_CCCExecution.py           | Using CCC as features to classify execution time                       | Hold-out       
Kmeans_CCCExecution_Cross.py     | Using CCC as features to classify execution time                       | 10-fold cross  
Kmeans_CCLPLCAttack.py           | Using CCL/PLC as features to classify (run-time) attack surface        | Hold-out       
Kmeans_CCLPLCAttack_Cross.py     | Using CCL/PLC as features to classify (run-time) attack surface        | 10-fold cross  
Kmeans_RMCCCCComplexity.py       | Using RMC/CCC as features to classify (run-time) cyclomatic complexity | Hold-out       		
Kmeans_RMCCCCComplexity_Cross.py | Using RMC/CCC as features to classify (run-time) cyclomatic complexity | 10-fold cross 	

	2. Supervised learning (based on python 3, code/python/supervised.sh):

Script                            | Functionality                                                           
--------------------------------- | ------------------------------------------------------------------------ 
Bagging_CCCAttack.py              | Using CCC as features to classify (run-time) attack surface      
Bagging_CCCExecution.py           | Using CCC as features to classify execution time           
Bagging_CCLPLCAttack.py           | Using CCL/PLC as features to classify (run-time) attack surface   
Bagging_RMCCCCComplexity.py       | Using RMC/CCC as features to classify (run-time) cyclomatic complexity  
		 
-----------
### Model construsction 
-----------	
		 
	In this phase, DistFax first checks whether learning models (classifiers) exist in the directory. 
	If yes, it directly loads the models for classification. 
	If no, it trains the models before performing classification. If users want to update the models, they would re-training the models.

#### Construction of pre-trained models

	We have pre-trained supervised and unsupervised learning classifiers for quality metrics (execution time, dynamic cyclomatic complexity, and dynamic attack surface), 
	using 16,880 data points from 11 different real-world large distributed systems listed above, 
	and their diverse execution scenarios---integration/system/load tests.
	
	1. Compute Quality metrics

	- 1.1  Compute raw execution time
	
	We execute CountExecutionTime to compute raw execution time.
	For example, we run /home/username/thrift/computeRawExecutionTime.sh: "java -cp ../DistFax.jar CountExecutionTime diff0Available.txt timecostclientDT3_". 

	- 1.2  Compute raw cyclomatic complexity
	
	We execute CountComplexityFromFiles to compute raw cyclomatic complexity.
	For example, we run /home/username/thrift/computeRawCyclomaticComplexity.sh: "java -cp ../DistFax.jar CountComplexityFromFiles". 

	- 1.3  Compute raw attack surface
	
	We execute CountAttackSurfaceFromFiles to compute raw attack surface.
	For example, we run /home/username/thrift/computeRawAttackurface.sh: "java -cp ../DistFax.jar CountAttackSurfaceFromFiles". 
	
	- 1.4  Compute raw information flow path count and length
	
	We execute /home/username/#subject#/distEAAnalysis.sh to compute information flow paths.  
	
	- 1.5 Normalize raw quality metrics

    We use the tool LocMetrics to compute the logical SLOC of the subject, then normalize raw quality metrics by the SLOC.  	
	
	- 1.6 Repeat the instrumentation and tracing steps until IPC and quality metrics of all subjects have been computed
	
	2. Correlation analysis

    We use IPCQualityToExcelSpearman_P.py to compute Spearman's rank correlation coefficients between IPC metrics and quality metrics.
	For example, we run "Python IPCQualityToExcelSpearman_P.py", and then the file IPCQualityCorrelations.xlsx includes correlations computed.
	
	3. Train binary classsifiers using supervised and unsupervised learning for classifying quality models from IPC metrics according to their moderate or strong correlations.
	
#### Model re-training/updating

    If users need to update classifiers by including their new new data points, they would follow steps:

	1. Add data points
		
	- 1.1  Add the inputs used by the subject(s) of users
		
	- 1.2  Develop shell scripts that load these inputs to run the subject(s)

	- 1.3  Instrument the the subject(s) and then run these shell scripts for tracing

	- 1.4  Compute IPC metrics RMC/RCC/CCC/IPR/CCL/PLC for characterizing the subject(s)
		
	- 1.5  Compute quality metrics (execution time, dynamic cyclomatic complexity, dynamic attack surface, information flow path count and length) of the subject(s)
		
	- 1.6  Compute Spearman rank correlation coefficients between the IPC metrics and quality metrics.
		
	- 1.7 Append/update supervised and unsupervised learning data for IPC metrics and quality metrics that have moderate or strong correlations, in the directory "data/ML"
		
	2. Remove relevant models/classifiers in the directory "model/preTraining"
	
	3. Classify the quality metrics as mentioned in the typical workflow
	
	- 3.1  Develop/update python programs as binary classsifiers using supervised and unsupervised learning for classifying quality models from relevant IPC metrics.
	
	- 3.2  Run these programs to traing the classifiers.


				 
