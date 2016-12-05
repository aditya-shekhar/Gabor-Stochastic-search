function [ population ] = generatePopulation( vMin,vMax,noOfPoints )
%Generates a random set of points within the specified range
%    noOfPoints-> no of points generated randomnly

    if noOfPoints~=0 && length(vMin)==length(vMax)           %Check for dimension mismatch                                 
        dimension=length(vMax);                              %dimension of the search space
        population=zeros(dimension,noOfPoints);                       %Generates a matrix of N vectors of mentioned dimension
        alpha=rand(dimension,noOfPoints);                    %?should alpha besame across each dimension
        %----------creating the population from the mentioned search space
        for i=1:1:noOfPoints
            population(:,i)=alpha(:,i).*vMin + (ones(dimension,1)-alpha(:,i)).*vMax;
        end
    else
        population='incorrect function arguments';
    end
end

