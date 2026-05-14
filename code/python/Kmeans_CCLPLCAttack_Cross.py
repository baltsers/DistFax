#############K-means-############
#import matplotlib.pyplot as plt
import numpy as np
from sklearn.cluster import KMeans
#from sklearn import datasets
import pandas as pd
# allMetrics = 'C:/Research/distMeasureResults/PythonData/IPCQulityMetricsNew1.xlsx' 

#X = pd.read_csv('../../data/ML/CCLPLC11817.csv')
#Y = pd.read_csv('../../data/ML/CCLPLC5065.csv')

#pd.read_csv('../../data/ML/CCLPLCAttack5065.csv')

Precisions=0.0
Recalls=0.0
PrecisionCount=0
RecallCount=0

def cv(X, Y, Z, W):
  clf = KMeans(n_clusters=2)
  fit_clf=clf.fit(X)
  y_pred=clf.predict(Y)

  print (clf.labels_)
  print (clf.cluster_centers_)
  print (y_pred)

  dt = pd.DataFrame(y_pred)
# dt.to_csv("../../data/ML/RMCCCC5065_KMSplit.csv", index=0)

  CCLPLAttack=Z.reset_index(drop=True)   # data5065
  label= pd.DataFrame(clf.labels_)
  print ("CCLPLAttack.columns.size=",CCLPLAttack.columns.size," CCLPLAttack.iloc[:,0].size=",CCLPLAttack.iloc[:,0].size)
  print ("CCLPLAttack=", CCLPLAttack)
  print ("label.columns.size=",label.columns.size," label.iloc[:,0].size=",label.iloc[:,0].size)
  print ("label=", label) 

  CCLPLAttack_label=pd.concat([CCLPLAttack, label], axis=1, ignore_index=True)
  #CCLPLAttack_label=CCLPLAttack.append(label, ignore_index=True)
# Attack_label=CCLPLAttack_label.rename(columns={'0':'label'}, inplace = True)
  print ("CCLPLAttack_label.columns.size=",CCLPLAttack_label.columns.size," CCLPLAttack_label.iloc[:,0].size=",CCLPLAttack_label.iloc[:,0].size)
  print ("CCLPLAttack_label=", CCLPLAttack_label)
  CCLPLAttack_label.columns = ['RMC','CCC','Attack','Label']
#

#sum1=CCLPLAttack_label[CCLPLAttack_label['Label']==0].sum()
#print (sum1)
#sum2=CCLPLAttack_label[CCLPLAttack_label['Label']==1].sum()
#print (sum2)

  average1=CCLPLAttack_label[CCLPLAttack_label['Label']==0]["Attack"].mean()
  print ("average1=",average1)

  average2=CCLPLAttack_label[CCLPLAttack_label['Label']==1]["Attack"].mean()
  print ("average2=",average2)

  CCLPLAttack5000=W.reset_index(drop=True)
  print ("CCLPLAttack5000.columns.size=",CCLPLAttack5000.columns.size," CCLPLAttack5000.iloc[:,0].size=",CCLPLAttack5000.iloc[:,0].size)
  print ("CCLPLAttack5000=", CCLPLAttack5000) 
  #pd.read_csv('../../data/ML/CCLPLCAttack5065.csv')
  diff1=abs(CCLPLAttack5000["Attack"]-average1)
  print ("diff1=",diff1)

  diff2=abs(CCLPLAttack5000["Attack"]-average2)
  print ("diff2=",diff2)

  ClosedTo=np.where(diff1 < diff2, 0, 1)
  print ("ClosedTo=",ClosedTo)

  dt_ClosedTo=pd.DataFrame(ClosedTo)
  #dt_ClosedTo.to_csv("../../data/ML/ClosedTo.csv", index=0)

  TP=np.where( (ClosedTo==0) & (y_pred==0), 1, 0)
  TPSum=TP.sum()
  print ("TP=",TP," TPSum=",TPSum)

  TN=np.where( (ClosedTo==1) & (y_pred==1), 1, 0)
  TNSum=TN.sum()
  print ("TN=",TN," TNSum=",TNSum)

  FP=np.where( (ClosedTo==1) & (y_pred==0), 1, 0)
  FPSum=FP.sum()
  print ("FP=",FP," FPSum=",FPSum)

  FN=np.where( (ClosedTo==0) & (y_pred==1), 1, 0)
  FNSum=FN.sum()
  print ("FN=",FN," FNSum=",FNSum)

  if TPSum<TNSum:
    TP1=TPSum
    TPSum=TNSum
    TNSum=TP1
    TP2=FPSum
    FPSum=FNSum
    FNSum=TP2
    
  print (" TPSum=",TPSum, " TNSum=",TNSum," FPSum=",FPSum," FNSum=",FNSum) 
    
  Precision=0
  Recall=0
  if (TPSum+FPSum)>0:
    Precision=TPSum/(TPSum+FPSum)
    Recall=TPSum/(TPSum+FNSum)
  F1=0

  global Precisions
  global Recalls
  global PrecisionCount
  global RecallCount

  
  
  if (Precision+Recall)>0:
    Precisions += Precision
    Recalls += Recall
    PrecisionCount=PrecisionCount+1
    RecallCount=RecallCount+1
    F1=2*Precision*Recall/(Precision+Recall)

  print ("Precision=",Precision," Recall=",Recall, " F1=",F1) 
 
  #CCLPLAttack5000=pd.concat([CCLPLAttack5000, diff1,diff2, dt_ClosedTo,dt], axis=1)
  #CCLPLAttack5000.columns = ['RMC','CCC','Attack','D0','D1','ClosedTo','Predicted']
  #print (CCLPLAttack5000)

#label2= pd.DataFrame(y_pred)
#CCLPLAttack5000_label2=pd.concat([CCLPLAttack5000, label2], axis=1)
#print (CCLPLAttack5000_label2)

  

def cvOneTime(fileName,k,n):
  allData=pd.read_csv(fileName)

  #k=10;
  #n=0;
  
  allSize=allData.iloc[:,0].size;
  subsize = int(allData.iloc[:,0].size/k)
  startTest=n*subsize;
  endTest=startTest+subsize;
  if endTest>allSize:
    endTest=allSize
  #dataTest=allData[0:allSize]
  #print (" dataTest[:,0].size=",dataTest.iloc[:,0].size, "dataTest=",dataTest)
  dataTest=allData[startTest:endTest]
  #print (" dataTest[:,0].size=",dataTest.iloc[:,0].size, "dataTest=",dataTest)
  print (" dataTest[:,0].size=",dataTest.iloc[:,0].size)
  
  dataTrain1 = pd.DataFrame(columns=['CCL', 'PLC', 'Attack'])
  startTrain1=0;
  endTrain1=startTest-1;
  if (startTrain1<endTrain1):
    dataTrain1=allData[startTrain1:endTrain1]
    #print (" dataTrain1[:,0].size=",dataTrain1.iloc[:,0].size, "datadataTrain2=",dataTrain2)
    print (" dataTrain1[:,0].size=",dataTrain1.iloc[:,0].size)

  dataTrain2 = pd.DataFrame(columns=['CCL', 'PLC', 'Attack'])
  startTrain2=endTest+1;
  endTrain2=allSize;
  if (startTrain2<endTrain2):
    dataTrain2=allData[startTrain2:endTrain2]
    #print (" dataTrain1[:,0].size=",dataTrain1.iloc[:,0].size, "datadataTrain1=",dataTrain1)
    print (" dataTrain2[:,0].size=",dataTrain2.iloc[:,0].size)  

  
  dataTrain=dataTrain1.append(dataTrain2, ignore_index = False)
  #pd.concat([startTrain1,startTrain2])
  #print (" dataTrain[:,0].size=",dataTrain.iloc[:,0].size, "datadataTrain=",dataTrain)
  print (" dataTrain[:,0].size=",dataTrain.iloc[:,0].size)
  
  #data11817=allData.head(11817)
  #data5065=allData.tail(5065)
  #print ("data11817=",data11817, "data5065=",data5065)
  X = dataTrain[['CCL','PLC']]

  Y = dataTest[['CCL','PLC']]
  #print ("X=",X, "Y=",Y)
  cv(X, Y, dataTrain, dataTest)


if __name__=="__main__":
  for num in range(0,9):
    cvOneTime('../../data/ML/CCLPLCAttack16882.csv',10,num)
    
  # print (" average precision=",Precisions/PrecisionCount, " average recall=",Recalls/RecallCount)
  print (" average precision=",Precisions/10, " average recall=",Recalls/10)
