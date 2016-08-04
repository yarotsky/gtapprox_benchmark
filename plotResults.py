'''
Created on Jul 26, 2016

@author: dmitry.yarotsky
'''

import os

import numpy as np
import matplotlib.pyplot as plt
import pandas as pd

rootPath = '.'
assert os.path.isdir(os.path.join(rootPath, 'results')), 'Folder with results must be in the working directory.'
caseL = os.listdir(os.path.join(rootPath, 'results'))
print '===== Found results for', len(caseL), 'cases'

techniqueL = [      
       'gtapprox',
       'gtapprox_smart',
       'SL_RidgeCV',
       'SL_SVR',
       'SL_GP',
       'SL_KR',
       'SL_RFR',
       'XGB',
       'XGB_lin',
       'GPy',
       'GPy_sparse'
       ]

results = dict()
for technique in techniqueL:
    results[technique] = dict()
    for case in caseL:
        results[technique][case] = dict()
        resDir = os.path.join(rootPath, 'results', case, technique)
        if os.path.isdir(resDir):
            resFileL = os.listdir(resDir)
            for fname in resFileL:
                testResults = pd.read_csv(os.path.join(resDir, fname), sep=' = ', header=None, index_col=0, engine='python')
                results[technique][case][fname] = dict()
                results[technique][case][fname]['rrms'] = float(testResults.loc['rrms'].iloc[0])
                results[technique][case][fname]['trainTime'] = float(testResults.loc['trainTime'].iloc[0])

completedTests = []
for case in caseL:
    fnameSet = set.intersection(*[set(results[technique][case].keys()) for technique in techniqueL])
    completedTests.extend([(case, fname) for fname in fnameSet])

print '===== Found', len(completedTests), 'fully completed problems (results available for all', len(techniqueL), 'techniques)'     

lines = [
            {'width':4, 'style':'-', 'color':(0.7,0.7,0.7)}, 
            {'width':4, 'style':'-', 'color':(0,0,0)},
            {'width':2.5, 'style':'-', 'color':(1,1,0)},
            {'width':1.5, 'style':'-', 'color':(0,0,0.4)},
            {'width':4, 'style':':', 'color':(1,0,1)},
            {'width':3, 'style':':', 'color':(0,0.4,0)},
            {'width':3, 'style':'--', 'color':(0,1,1)},
            {'width':2, 'style':'--', 'color':(0.4,0,0)},
            {'width':4, 'style':'-.', 'color':(1,0,0)},
            {'width':2, 'style':'-.', 'color':(0,0.3,0.3)},
            {'width':4, 'style':'--', 'color':(0.5,0.5,0)},
        ]

for resType in ['rrms', 'trainTime']:
    for n, technique in enumerate(techniqueL):
        profile = np.sort([results[technique][case][fname][resType] for (case, fname) in completedTests])
        if technique == 'gtapprox_smart':
            label = 'gta_smart'
        else:
            label = technique
        plt.semilogx(profile, np.linspace(0,1,len(profile)), lines[n]['style'], color=lines[n]['color'], 
                     linewidth=lines[n]['width'], label=label)
                    
        if resType == 'rrms':  
            plt.xlim([1e-3,5e0])
            plt.xlabel('RRMS threshold')
            plt.ylabel('Share of tests with RRMS below given threshold')
            plt.legend(loc='upper left')  
        else:
            plt.xlim([1e-3,5e4])
            plt.xlabel('Training time threshold, [s]')
            plt.ylabel('Share of tests with training time below given threshold') 
            plt.legend(loc='lower right')
        if not os.path.isdir(os.path.join(rootPath, 'figures')):
            os.mkdir(os.path.join(rootPath, 'figures'))
        plt.savefig('figures/'+resType+'.png')          
    plt.show() 