# -*- coding: utf-8 -*-
"""
Created on Fri Apr 27 11:20:05 2018
@author: Hympert Nguyen
"""
###########################
# Import  Generic Modules #
###########################

import matplotlib.pyplot as plt
import pandas as pd
import numpy as np

# Import validation module
from sklearn.model_selection import train_test_split, cross_val_score
from sklearn.metrics import mean_squared_error, r2_score, explained_variance_score


######################
# Preprocess dataset #
######################

# Replace all missing data " ?" to Unknown category
dataset = pd.read_csv("Dataset.csv")
for i in range(0, len(dataset.columns)):
    missing = 0
    x = dataset.iloc[:,i].values
    for j in range(0,len(x)):
        if x[j] == ' ?':
            x[j] = " Unknown"
    

# Independent and dependent variables
X = dataset.iloc[:, :-1].values
y = dataset.iloc[:, -1].values

#############################
# Encoding categorical data #
#############################

from sklearn.preprocessing import LabelEncoder, OneHotEncoder

# Encoding the Independent 
for i in range(0, len(dataset.columns) - 1):
    if type(X[1,i]) == int:
        continue
    labelencoder_X = LabelEncoder()
    X[:, i] = labelencoder_X.fit_transform(X[:, i])
    
onehotencoder = OneHotEncoder(categorical_features = [1,2,4,5,6,7])
X = onehotencoder.fit_transform(X).toarray()

# Encoding the Dependent Variable
labelencoder_y = LabelEncoder()
y = labelencoder_y.fit_transform(y)
    

###############
# Naive Bayes #
###############

            
###########################            
# Decision Tree Induction #
###########################


##########################            
# Multiplayer Perceptron #
##########################







