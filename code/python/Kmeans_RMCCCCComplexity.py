#############K-means-############
#import matplotlib.pyplot as plt
import numpy as np
from sklearn.cluster import KMeans
#from sklearn import datasets
import pandas as pd
import os
import pickle

if os.path.exists('../../model/preTraining/RMCCCCCComplexity_KMeans.pickle'):
    with open('../../model/preTraining/RMCCCCCComplexity_KMeans.pickle','rb') as f:
        clf = pickle.load(f)
else:      
    X = pd.read_csv('../../data/ML/RMCCCCCComplexity11817.csv')
    clf = KMeans(n_clusters=2)
    clf=clf.fit(X)
    with open('../../model/preTraining/RMCCCCCComplexity_KMeans.pickle','wb') as fw:
        pickle.dump(clf,fw)
        

Y = pd.read_csv('../../data/ML/RMCCCCCComplexity5065.csv' )
y_pred=clf.predict(Y)

print (clf.labels_)
print (clf.cluster_centers_)
print (y_pred)
# print (clf.feature_importances_)

#feature_importances = np.mean([
#    tree.feature_importances_ for tree in clf.estimators_
#], axis=0)

#print (feature_importances)

dt = pd.DataFrame(y_pred)
# dt.to_csv("../../data/ML/RMCCCC5065_KMSplit.csv", index=0)

RMCCCCComplexity=pd.read_csv('../../data/ML/RMCCCCCComplexity11817.csv')
label= pd.DataFrame(clf.labels_)
RMCCCCComplexity_label=pd.concat([RMCCCCComplexity, label], axis=1)
# Complexity_label=RMCCCCComplexity_label.rename(columns={'0':'label'}, inplace = True)
# print (RMCCCCComplexity_label)
RMCCCCComplexity_label.columns = ['RMC','CCC','Complexity','Label']
#

#sum1=RMCCCCComplexity_label[RMCCCCComplexity_label['Label']==0].sum()
#print (sum1)
#sum2=RMCCCCComplexity_label[RMCCCCComplexity_label['Label']==1].sum()
#print (sum2)

average1=RMCCCCComplexity_label[RMCCCCComplexity_label['Label']==0]["Complexity"].mean()
print ("average1=",average1)

average2=RMCCCCComplexity_label[RMCCCCComplexity_label['Label']==1]["Complexity"].mean()
print ("average2=",average2)

RMCCCCComplexity5000=pd.read_csv('../../data/ML/RMCCCCCComplexity5065.csv')
diff1=abs(RMCCCCComplexity5000["Complexity"]-average1)
print ("diff1=",diff1)

diff2=abs(RMCCCCComplexity5000["Complexity"]-average2)
print ("diff2=",diff2)

ClosedTo=np.where(diff1 < diff2, 0, 1)
print ("ClosedTo=",ClosedTo)

dt_ClosedTo=pd.DataFrame(ClosedTo)
#dt_ClosedTo.to_csv("../../data/ML/ClosedTo.csv", index=0)

TP=np.where( (ClosedTo==0) & (y_pred==0), 1, 0)
TPSum=TP.sum()
print ("TP=",TP," TPSum=",TPSum)

TN=np.where( (ClosedTo==1) & (y_pred==1), 1, 0)
print ("TN=",TN)

FP=np.where( (ClosedTo==1) & (y_pred==0), 1, 0)
FPSum=FP.sum()
print ("FP=",FP," FPSum=",FPSum)

FN=np.where( (ClosedTo==0) & (y_pred==1), 1, 0)
FNSum=FN.sum()
print ("FN=",FN," FNSum=",FNSum)

Precision=TPSum/(TPSum+FPSum)
Recall=TPSum/(TPSum+FNSum)
F1=2*Precision*Recall/(Precision+Recall)

print ("Precision=",Precision," Recall=",Recall, " F1=",F1)
 
RMCCCCComplexity5000=pd.concat([RMCCCCComplexity5000, diff1,diff2, dt_ClosedTo,dt], axis=1)
RMCCCCComplexity5000.columns = ['RMC','CCC','Complexity','D0','D1','ClosedTo','Predicted']
print (RMCCCCComplexity5000)

#label2= pd.DataFrame(y_pred)
#RMCCCCComplexity5000_label2=pd.concat([RMCCCCComplexity5000, label2], axis=1)
#print (RMCCCCComplexity5000_label2)
