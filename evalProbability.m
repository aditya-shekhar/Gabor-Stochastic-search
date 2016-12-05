function [ assignedProbability  ] = evalProbability( cost )
% EVALPROBABILITY Assign probability(weight to each of the samples in the
% population depending on the value of the cost function

    minCost=min(cost);                   
    tmp=cost-minCost;               %subtracting the minimum value so as to make all the values positive so that the sum of the values won't become zero
    totalCost=sum(tmp);             %sum of the costfunction values which is used for normalisation
    assignedProbability=tmp/totalCost;  
     
end

