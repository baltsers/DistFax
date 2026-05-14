#############K-means-############
#import matplotlib.pyplot as plt
import numpy as np
from sklearn.cluster import KMeans
#from sklearn import datasets
import pandas as pd
import os
import pickle

if os.path.exists('../../model/preTraining/CCCAttack_KMeans.pickle'):
    with open('../../model/preTraining/CCCAttack_KMeans.pickle','rb') as f:
        clf = pickle.load(f)
else:      
    X = pd.read_csv('../../data/ML/CCC11817.csv')
    clf = KMeans(n_clusters=2)
    clf=clf.fit(X)
    with open('../../model/preTraining/CCCAttack_KMeans.pickle','wb') as fw:
        pickle.dump(clf,fw)

Y = pd.read_csv('../../data/ML/CCC5065.csv' ) 
y_pred=clf.predict(Y)

print (clf.labels_)
print (clf.cluster_centers_)
print (y_pred)

dt = pd.DataFrame(y_pred)
# dt.to_csv("../../data/ML/CCC5065_KMSplit.csv", index=0)

CCCAttack=pd.read_csv('../../data/ML/CCCAttack11817.csv')
label= pd.DataFrame(clf.labels_)
CCCAttack_label=pd.concat([CCCAttack, label], axis=1)
# Attack_label=CCCAttack_label.rename(columns={'0':'label'}, inplace = True)
CCCAttack_label.columns = ['CCC','Attack','Label']


average1=CCCAttack_label[CCCAttack_label['Label']==0]["Attack"].mean()
print ("average1=",average1)

average2=CCCAttack_label[CCCAttack_label['Label']==1]["Attack"].mean()
print ("average2=",average2)

CCCAttack5000=pd.read_csv('../../data/ML/CCCAttack5065.csv')
diff1=abs(CCCAttack5000["AttackSurface"]-average1)
print ("diff1=",diff1)

diff2=abs(CCCAttack5000["AttackSurface"]-average2)
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
 
CCCAttack5000=pd.concat([CCCAttack5000, diff1,diff2, dt_ClosedTo,dt], axis=1)
CCCAttack5000.columns = ['CCC','Attack','D0','D1','ClosedTo','Predicted']
print (CCCAttack5000)

#label2= pd.DataFrame(y_pred)
#CCCAttack5000_label2=pd.concat([CCCAttack5000, label2], axis=1)
#print (CCCAttack5000_label2)
