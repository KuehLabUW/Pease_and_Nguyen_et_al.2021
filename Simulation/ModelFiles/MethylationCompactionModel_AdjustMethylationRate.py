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
import sys

roadrunner.Config.setValue(roadrunner.Config.MAX_OUTPUT_ROWS,10000)

def loada(sbstr):
    import antimony as sb
    r = sb.loadAntimonyString(sbstr)
    if r < 0:
        raise RuntimeError('Failed to load Antimony model: {}'.format(sb.getLastError()))
    return roadrunner.RoadRunner(sb.getSBMLString(sb.getModuleNames()[-1]))


    
# Tellurium function
# Tellurium function
def doSimulation(CycleTime,alpha1,alpha2,lambda1,delta2):

    t = CycleTime

    # Run Tellurium
    r = loada("""
    R1: DC => MC ; alpha1*DC
    R2: MC => DC ; alpha2*fraction*MC
    R3: DUC => MUC; alpha1*DUC
    R4: MUC => DUC; alpha2*MUC
    
    R5: DUC => DC; DUC*lambda1*F*(DC+MC)^(2.00/3.00)
    R6: DC => DUC; DC*delta2/((DC+MC)^(1.00/3.00)+1e-8)
    R7: MUC => MC; MUC*lambda1*(DC+MC)^(2.00/3.00)
    R8: MC => MUC; MC*delta2/((DC+MC)^(1.00/3.00)+1e-8)
    
    MC = 50
    DC = 0
    DUC = 0
    MUC = 0
    
    alpha1 = 1.0
    alpha2 = 1.0
    fraction = 0
    
    lambda1 = 1.0
    F = 0.825
    delta2 = 1.0
    CN = 5
    
    R9: at ((DC+MC) < CN): lambda1 = 0;
    
    """)
    
    r.integrator = 'gillespie'
    r.integrator.variable_step_size = False
    r.alpha1 = alpha1
    r.lambda1  = lambda1
    r.alpha2 = alpha2
    r.delta2  = delta2
 
    ############################
    result=[]
    for i in xrange(0,20000/t,1): #simulate 20000/t cell cycle/total of 200000 points
        if i == 0:
            SubResult =r.simulate(0,t,int(t/0.1)) #each point is 0.1 in time
            for row in SubResult:
                result.append(row)
        else:
            X  = r.MUC
            muc = numpy.random.binomial(X,0.5,1)
            r.MUC = r.MUC - muc[0]
            r.DUC = r.DUC + muc[0]
           
            Y = r.MC
            mc = numpy.random.binomial(Y,0.5,1)
            r.MC = r.MC - mc[0]
            r.DC = r.DC + mc[0]

            SubResult =r.simulate(0,t,int(t/0.1))
            
            for row in SubResult:
                result.append(row)
    result =ar(result)
    return result


#State array function
def getStateArray(result):
    D =[] #State array of the system
    M =[] #Methylation array of the system
    C =[] #Compaction array of the system
    height = list(numpy.arange(0,len(result),1))
    for i in height:
        #### Make Methylation state array
        index = result[i,2] + result[i,4]
        M.append(index)
        #### Make Compaction state array
        index = 0
        index = result[i,1] + result[i,2]
        C.append(index)
        
    D.append(M)
    D.append(C)
    return D
    

#Write csv file
def writeCSV(ResultMatrix,AlphaON,AlphaOFF,LambdaON,DeltaOFF,Cycle):
    with open('Trun50F0.825LifeTimePhaseAlphaON{}AlphaOFF{}LambdaON{}DeltaOFF{}Cycle{}.csv'.format(AlphaON,AlphaOFF,LambdaON,DeltaOFF,Cycle),'w') as mycvsfile:
        thedatawriter = csv.writer(mycvsfile)   
        thedatawriter.writerow(ResultMatrix)
                                            

#Switching time Calculator
def getLifeTime(StateArray):
    for i in range(0,len(StateArray)):
        if StateArray[i] == 0:
            time = (i)*0.1
            break
        elif i == len(StateArray)-1:
            time = (i)*0.1                     
    return time
    
            
# Write simulation function for core spreading
def generateLifeTime(repeat_number):
            AlphaON = alphas[j]
            AlphaOFF = 8
            LambdaON = 310 #100
            DeltaOFF = 5300

            result = doSimulation(20,AlphaON,AlphaOFF,LambdaON,DeltaOFF) #(CycleTime,alpha1,alpha2,lambda1,delta2,L)
            D = getStateArray(result)
            T = getLifeTime(D[1])            
            print T
            print 'repeat #: ', repeat_number          
            return T
    
######################## REAL SIMULATION #############
   
RepeatArray = list(numpy.arange(1,51,1))
## Ok spread this over 50 processors
if __name__ == '__main__': #you can only run this from the command line
    

    alphas  = [6.4]

    for j in xrange(0,len(alphas)): 
            U =[]
            p=Pool(16)
            U=p.map(generateLifeTime,RepeatArray) # map function assigns a function to a value in the sequence
            print 'Flag before'
            AlphaON = alphas[j]
            AlphaOFF  = 8
            LambdaON = 310
            DeltaOFF = 5300

            writeCSV(U,alphas[j],AlphaOFF,LambdaON,DeltaOFF,20)
            print 'Flag after'
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
