'''
Created on Jul 21, 2016

@author: dmitry.yarotsky
'''


import time
import os
import sys

import numpy as np
import pandas as pd

from runAllTests import saveResult


rootPath = '.'
caseL = os.listdir(os.path.join(rootPath, 'testcases'))

assert len(sys.argv) == 6 
technique, case, trainFile, testFile, comp = sys.argv[1:]
comp = int(comp)


if technique.startswith('gtapprox'):
    from da.p7core_6_8_400 import gtapprox
    
elif technique.startswith('SL'):
    if technique == 'SL_GP':
        from sklearn.gaussian_process import GaussianProcess as SL_GP
    elif technique == 'SL_KR':
        from sklearn.kernel_ridge import KernelRidge as SL_KR
    elif technique == 'SL_RFR':
        from sklearn.ensemble import RandomForestRegressor as SL_RFR
    elif technique == 'SL_RidgeCV':
        from sklearn.linear_model import RidgeCV as SL_RidgeCV
    elif technique == 'SL_SVR':
        from sklearn.svm import SVR as SL_SVR       
    else:
        raise NotImplementedError  
    
elif technique.startswith('XGB'):
    import xgboost
    
elif technique.startswith('GPy'):
    import GPy
    
info = pd.read_csv(os.path.join(rootPath, 'testcases', case, '_info.dat'), sep=' = ', header=None, index_col=0, engine='python')
din = int(info.loc['inputs'].iloc[0])

train = np.loadtxt(os.path.join(rootPath, 'testcases', case, trainFile), skiprows=1)
test = np.loadtxt(os.path.join(rootPath, 'testcases', case, testFile), skiprows=1)
Xtrain = train[:,:din]
Ytrain = train[:,din+comp]
Xtest = test[:,:din]
Ytest = test[:,din+comp]


trainStartTime = time.time()

if technique.startswith('gtapprox'):
    if technique == 'gtapprox':
        model = gtapprox.Builder().build(Xtrain, Ytrain.reshape((-1,1)))
    elif technique == 'gtapprox_smart':
        model = gtapprox.Builder().build_smart(Xtrain, Ytrain.reshape((-1,1)))
    else:
        raise NotImplementedError

elif technique.startswith('SL'):                           
    model = globals()[technique]()
    model.fit(Xtrain, Ytrain)
    
elif technique.startswith('XGB'):
    dtrain = xgboost.DMatrix(Xtrain, label=Ytrain)
    param = {'silent':1, 'objective':'reg:linear'}
    if technique == 'XGB_lin':
        param['booster'] = 'gblinear'                                   
    model = xgboost.train(param, dtrain)
    
elif technique.startswith('GPy'):
    if technique == 'GPy':
        model = GPy.models.GPRegression(Xtrain, Ytrain.reshape((-1,1)))
    elif technique == 'GPy_sparse':
        model = GPy.models.SparseGPRegression(Xtrain, Ytrain.reshape((-1,1)))
    else:
        raise NotImplementedError
    model.optimize()

else:
    raise NotImplementedError

trainEndTime = time.time()


if technique.startswith('gtapprox'):
    Ypred = model.calc(Xtest).reshape((Xtest.shape[0],))

elif technique.startswith('SL'):
    Ypred = model.predict(Xtest).reshape((Xtest.shape[0],))
    
elif technique.startswith('XGB'):
    dtest = xgboost.DMatrix(Xtest)     
    Ypred = model.predict(dtest)
    
elif technique.startswith('GPy'):
    Ypred = model.predict(Xtest)[0]

else:
    raise NotImplementedError        

def RRMS(Ypred, Ytrue):
    Ytrue = np.array(Ytrue)
    Ypred = np.array(Ypred).reshape(Ytrue.shape)       
    return np.sqrt(np.sum((Ypred-Ytrue)**2)/np.sum((Ytrue-np.mean(Ytrue))**2))      
                  
rrms = RRMS(Ypred, Ytest)
trainTime = trainEndTime-trainStartTime

saveResult(technique, case, trainFile, comp, rrms, trainTime)

print rrms, trainTime

