function [ nextGenPopulation,nextGenCost ] = nextGenSelection( combinedCost,combinedPopulation,noOfSamples )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    s=size(combinedPopulation);
    [sortedcombinedCost,Index] = sort(combinedCost,'descend');
    nextGenPopulation=zeros(s(1),noOfSamples);
    for i=1:1:noOfSamples
        nextGenPopulation(:,i)=combinedPopulation(:,Index(i));
    end
    nextGenCost = sortedcombinedCost(1:1:noOfSamples);
end

