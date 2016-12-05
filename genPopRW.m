function [ newPopRW ] = genPopRW(population, cardinalityNewPopRW,radius, sMin,sMax )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here

    %radius=0.02;                                        %It is a constant and it's selection depends on the domain knowledge
    dim=size(population);
    %cardinality_child=round(assigned_probability*N);    %number of childs which is to be selected from the viscinity of current sample
        %rand_direction=rand(1,dimension);
        
        newPopRWNo=sum(cardinalityNewPopRW);
        if isnan(newPopRWNo) || isinf(newPopRWNo)
            newPopRW = [];
            return;
        end
        
        newPopRW=zeros(dim(1),newPopRWNo);
        %newPopRWCost=zeros(1,newPopRWNo);            %Iniialize the matrix which stores the value of the cost function of the new population.
        k=1;
        for i=1:1:dim(2)
            if cardinalityNewPopRW(i)==0                      
                %exit();
            else
                for j=1:1:cardinalityNewPopRW(i)
                    randDirection=rand(1,dim(1));       %
                    randDirection=randDirection/norm(randDirection);
                    randDirection=randDirection';
                    newSample=population(:,i)+radius.*(ones(dim(1),1)-2*randDirection);   %-2* factor is to crate both =ve and -ve direction
                    [ newSample ] = boundCheck(newSample, sMin,sMax );
%                     if new_sample(1)<smin(1)
%                         new_sample(1)=smin(1);
%                     elseif new_sample(1)>smax(1)
%                         new_sample(1)=smax(1);
%                     end
%                     if new_sample(2)<smin(2)
%                         new_sample(1)=smin(2);
%                     elseif new_sample(2)>smax(2)
%                         new_sample(2)=smax(2);
%                     end
                    newPopRW(:,k)=newSample;
                    k=k+1;
                end           
            end 
        end
end

