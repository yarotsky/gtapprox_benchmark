'''
Created on Jul 23, 2016

@author: Dmitry Yarotsky
'''
import os
import sys
import subprocess
from multiprocessing import Pool, freeze_support

import pandas as pd


rootPath = '.'
assert os.path.isdir(os.path.join(rootPath, 'testcases')), 'Folder with test cases must be in the working directory.'
caseL = [f for f in os.listdir(os.path.join(rootPath, 'testcases')) if os.path.isdir(os.path.join(rootPath, 'testcases', f))]

def saveResult(technique, case, trainFile, comp, rrms, dt):
    if not os.path.isdir(os.path.join(rootPath, 'results')):
        os.mkdir(os.path.join(rootPath, 'results'))
    if not os.path.isdir(os.path.join(rootPath, 'results', case)):
        os.mkdir(os.path.join(rootPath, 'results', case))
    if not os.path.isdir(os.path.join(rootPath, 'results', case, technique)):
        os.mkdir(os.path.join(rootPath, 'results', case, technique))
    
    fname =  trainFile[:-4]+'_comp'+str(comp)+'.txt'
    with open(os.path.join(rootPath, 'results', case, technique, fname), 'w') as f:
        f.write('rrms = '+str(rrms)+'\n')
        f.write('trainTime = '+str(dt))


def doSingleTest(params):       
    technique, case, trainFile, _, comp, memoryLimit, OMP_NUM_THREADS = params   
      
    command = ' '.join(['ulimit', '-v', str(memoryLimit), '&&', 
                        'export', 'OMP_NUM_THREADS='+str(OMP_NUM_THREADS), '&&',
                        'python',  'runSingleTest.py'] +[str(param) for param in params[:-2]])
    print 'started:', params[:-2], '(shell command:', command, ')'
    try:
        out = subprocess.check_output(command, shell=True)
        print 'finished:', params[:-2], 'rrms:', out.strip().split()[0], 'training time:', out.strip().split()[1]
    except:         
        rrms = 'inf'
        dt = 'inf'
        saveResult(technique, case, trainFile, comp, rrms, dt)      
        print 'failed:', params[:-2], sys.exc_info()    


def runTests(Nworkers=1,
             memoryLimit=6*2**20,
             OMP_NUM_THREADS=4,
             trainSetMinSize=0,
             trainSetMaxSize=sys.maxint
             ):
    
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
    print '===== Starting tests for', len(techniqueL), 'approximation techniques'
    print '===== Case list:', len(caseL), 'cases'
    nProbs = 0
    taskQueue = []
    for case in caseL:
        info = pd.read_csv(os.path.join(rootPath, 'testcases', case, '_info.dat'), sep=' = ', header=None, index_col=0, engine='python')
        dout = int(info.loc['outputs'].iloc[0])
        testFile = info.loc['default_test_sample'].iloc[0]
        trainFileL = [fname for fname in os.listdir(os.path.join(rootPath, 'testcases', case)) 
                      if fname.endswith('.txt') and not fname.startswith('_info') and not fname == testFile]
        for trainFile in trainFileL:
            if int(trainFile.split('_')[1]) >= trainSetMinSize and int(trainFile.split('_')[1]) <= trainSetMaxSize:
                nProbs += dout
                for comp in range(dout):
                    for technique in techniqueL:
                        params = [technique, case, trainFile, testFile, str(comp)]                    
                        taskQueue.append(params)
    print '===== Total problems:', nProbs                  
    print '===== Task queue:', len(taskQueue), 'tasks'                                      
    pool = Pool(Nworkers)
    pool.map(doSingleTest, [params+[memoryLimit, OMP_NUM_THREADS] for params in taskQueue])
        
if __name__ == '__main__':
    freeze_support()
    runTests()       
                                    
    
    