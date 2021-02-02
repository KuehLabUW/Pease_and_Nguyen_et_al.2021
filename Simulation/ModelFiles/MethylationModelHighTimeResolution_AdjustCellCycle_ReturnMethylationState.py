#!/usr/bin/python

"""
Created on Tue Dec 13 20:08:54 2016

@author: Sam Nguyen
"""

import roadrunner
import numpy 
import math
from scipy import asarray as ar,exp
from multiprocessing import Pool
import csv
import random

roadrunner.Config.setValue(roadrunner.Config.MAX_OUTPUT_ROWS,10000)

def loada(sbstr):
    import antimony as sb
    r = sb.loadAntimonyString(sbstr)
    if r < 0:
        raise RuntimeError('Failed to load Antimony model: {}'.format(sb.getLastError()))
    return roadrunner.RoadRunner(sb.getSBMLString(sb.getModuleNames()[-1]))

#Import distance array
def getDistanceData():
    Q =[]
    g = 'BoundaryDistanceArray.csv'
    with open('{}'.format(g),'rb') as mycvsfile:
        thedatareader = csv.reader(mycvsfile)
        for row in thedatareader:
            Q.append(row)
    A = Q
    A = ar(A)
    A = A.astype(numpy.float)
    return A

    
# Tellurium function
def doSimulation(CycleTime,alpha1,beta1,alpha2,beta2,L,TF,LT): #LT is the number of fixed nucleosome
    t = CycleTime
    d = getDistanceData()
    # Make on equation
    ON= []
    x = 0
    for i in range(1,101):
        A =[]
        S =[]
        B =[]
        C =[]
        for j in range(1,i):
            x = math.exp(-(((d[j-1,i-1])*1.00)/L)**2)
            if x < 1e-2:
                x = 0
            x = round(x,1)
            A = ('p{}*{}'.format(j,x));
            S.append(A)
            
        for j in range(i+1,101):
            x = math.exp(-(((d[j-1,i-1])*1.00)/L)**2)
            if x < 1e-2:
                x = 0
            x = round(x,1)
            A = ('p{}*{}'.format(j,x));
            S.append(A)
        B = '+'.join(S)
        C = ('$X => p{}; (alpha1 + beta1*({}))*(1-p{})'.format(i,B,i));
        ON.append(C)
    
    #######################               
    # Make OFF equation
    OFF =[]
    for i in range(1,101):
        A =[]
        S =[]
        B =[]
        C =[]
        for j in range(1,i):
            x = math.exp(-(((d[j-1,i-1])*1.00)/L)**2)
            if x < 1e-2:
                x = 0
            x = round(x,1)
            A = ('(1-p{})*{}'.format(j,x));
            S.append(A)
        for j in range(i+1,101):
            x = math.exp(-(((d[j-1,i-1])*1.00)/L)**2)
            if x < 1e-2:
                x = 0
            x = round(x,1)
            A = ('(1-p{})*{}'.format(j,x));
            S.append(A)
        B = '+'.join(S)
        factor = math.exp(-((i-50.0)/LT)**2)
        if factor < 1e-2:
            factor = 0
        x = round(x,2)
        C = ('p{} =>; (alpha2 + beta2*({}))*(p{}) + alphaTF*{}*p{}'.format(i,B,i,factor,i));
        OFF.append(C)

    # Set initial condition string
    s =['0','1']
    p_condition = ['p{} = {}'.format(i,1) for i in range(1,101)]
    
        
    # Run Tellurium
    r = loada("""
    {}
    {}
    {}



    alpha1 = 0.0
    alpha2 = 1.3
    alphaTF = 0
    beta1  = 0.05
    beta2  = 0
    X =0


    """.format(';'.join(ON),';'.join(OFF),';'.join(p_condition)))
    r.integrator = 'gillespie'
    r.integrator.variable_step_size = False
    r.alpha1 = alpha1
    r.beta1  = beta1
    r.alpha2 = alpha2
    r.beta2  = beta2
    alphaTFmax = 5
    Km = 5
    r.alphaTF = (alphaTFmax*TF/(Km+TF))
    result=[]
    for i in xrange(0,2000/t,1): #simulate 5000/t cell cycle/total of 9990 points
        if i == 0:
            SubResult =r.simulate(0,t,int(t/0.001)) #each point is 0.01 in time
            for row in SubResult:
                result.append(row)
        else:
            for k in range(1,101,1):
                q = random.randint(0,1)
                m = 0
                exec("""if r.p{} == 1: m=1;  """.format(k))
                if m == 1:
                    exec("""r.p{} = q;  """.format(k))
            SubResult =r.simulate(0,t,int(t/0.001))
            
            for row in SubResult:
                result.append(row)
    result =ar(result)
    return result


#State array function
def getStateArray(result):
    D =[] #State array of the system
    height = list(numpy.arange(0,len(result),1))
    length = list(numpy.arange(1,101,1))
    for i in height:
        index = 0
        for j in length:
            if result[i,j] ==1:
                index = index + 1
        D.append(index)
           
    return D
    

#Write csv file
def writeCSV(ResultMatrix,alpha,beta,CellCycle):

    with open('HighResRawAlpha{}Beta{}Cycle{}.csv'.format(alpha,beta,CellCycle),'w') as mycvsfile: #open up 'mydata.csv' for reading and pass it up to a variable
        thedatawriter = csv.writer(mycvsfile)   #define a "pen" that writes to the csv file
        thedatawriter.writerow(ResultMatrix)           # write the each row into the csv file. Use '.writerow' if 1D array
                                            # and '.writerows' if 2D array
                                            

 
# Write simulation function for core spreading
def generateStateArray(repeat_number):
            alpha = 0.001
            beta  = 0.001
            result = doSimulation(CellCycle[j],0,beta,alpha,0,15,0,1) #(cell_cycle,alpha1,beta1,alpha2,beta2,L,TF,LT)
            D = getStateArray(result)
            
            writeCSV(D,alpha,beta,CellCycle[j])
            print 'Done with repeat#{}'.format(repeat_number)
            
    
######################## REAL SIMULATION #############
    
RepeatArray = list(numpy.arange(1,2,1))
## Ok spread this over 50 processors
CellCycle  = [25]
for j in xrange(0,len(CellCycle)): 
            U =[]
            p=Pool(16)
            U=p.map(generateStateArray,RepeatArray) # map function assigns a function to a value in the sequence
            print 'Flag before'
            
            print 'Flag after'
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
