############# Bagging ############
#import matplotlib.pyplot as plt
import numpy as np
from sklearn.svm import SVC
from sklearn.ensemble import BaggingClassifier
#from sklearn import datasets
import pandas as pd
from sklearn.metrics import precision_score, recall_score, f1_score, accuracy_score
from sklearn.model_selection import cross_val_score
import os
import pickle

if os.path.exists('../../model/preTraining/RMCCCCCComplexity_holdout.pickle'):
    with open('../../model/preTraining/RMCCCCCComplexity_holdout.pickle','rb') as f:
        clf = pickle.load(f)
else:        
    df = pd.read_csv('C:/Research/TOOL/DistFax_Meterial/data/ML/RMCCCCComplexity_70.csv' )
    y=df['Cyclomatic Complexity']
    clf = BaggingClassifier(base_estimator=SVC(),n_estimators=10, random_state=0).fit(df, y)
    with open('../../model/preTraining/RMCCCCCComplexity_holdout.pickle','wb') as fw:
        pickle.dump(clf,fw)

df2 = pd.read_csv('C:/Research/TOOL/DistFax_Meterial/data/ML/RMCCCCComplexity_30.csv' )
predict_results=clf.predict(df2)
y2=df2['Cyclomatic Complexity']
print("Hold-out validation precision is ", precision_score(predict_results, y2, average='weighted'))
print("Hold-out validation recall is ", recall_score(predict_results, y2, average='weighted'))
print("Hold-out validation f1 is ", f1_score(predict_results, y2, average='weighted'))

df3 = pd.read_csv('C:/Research/TOOL/DistFax_Meterial/data/ML/RMCCCCComplexity.csv' )
y3=df3['Complexity']
if os.path.exists('../../model/preTraining/RMCCCCCComplexity_10fold.pickle'):
    with open('../../model/preTraining/RMCCCCCComplexity_10fold.pickle','rb') as f:
        clf3 = pickle.load(f)
else:         
    clf3 = BaggingClassifier(base_estimator=SVC(),n_estimators=10, random_state=0).fit(df3, y3)
    with open('../../model/preTraining/RMCCCCCComplexity_10fold.pickle','wb') as fw:
        pickle.dump(clf3,fw)     

cvprec = cross_val_score(estimator=clf3, X=df3, y=y3, cv=10, scoring='precision_weighted')
print("10-fold cross-validation precision is ", cvprec)
cvrec = cross_val_score(estimator=clf3, X=df3, y=y3, cv=10, scoring='recall_weighted')
print("10-fold cross-validation recall is ", cvrec)
cvf1 = cross_val_score(estimator=clf3, X=df3, y=y3, cv=10, scoring='f1_weighted')
print("10-fold cross-validation f1 is ", cvf1)

