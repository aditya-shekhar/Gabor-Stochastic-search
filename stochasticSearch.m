function [ x ] = stochasticSearch( sMin,sMax,noOfSamples,radius,nRRI,nRLC,maxItr,files )
%STOCHASTICSEARCH Program to implement the stochastic serach algorithm
%   Eg:-stochasticSearch( [-20;-20],[20;20],100,4... )
    DEBUG = 1;

    im_sizex = 640; im_sizey=640;
    population=generatePopulation(sMin,sMax,noOfSamples );
    save(sprintf('iteration_0.mat'),'population');
    bestPointOfAGen=zeros(length(sMax),maxItr);
    bestCostOfAGen=zeros(1,maxItr);
    
    A = uint8(zeros(im_sizex, im_sizey,length(files)));
    for i = 1:length(files)
%         rgb2gray(imread(char(files(i))));
        A(:,:,i) = (imread(char(files(i))));
    end
    cost = -1*ones(size(population,2),1);    

    for itr=1:1:maxItr
        
        if sum(cost==-1)>0
            if DEBUG
                itr
                disp('stochasticSearch: Calling evalcost on parent population')
            end
            cost = evalCost( population,A );
        else
            if DEBUG
                itr
                disp('stochasticSearch: Already have cost of parent population')
            end
        end
        assignedProbability  = evalProbability( cost );
        cardinalityNewPopRW  = evalCardinality( assignedProbability,noOfSamples );
        newPopRW = genPopRW(population, cardinalityNewPopRW,radius,sMin,sMax );
        if DEBUG
            disp('stochasticSearch: Calling evalcost on child population')
        end
        newPopRWCost=evalCost( newPopRW,A );
        newPopRRI = genPopRRI(sMin,sMax, nRRI );
        if DEBUG
            disp('stochasticSearch: Calling evalcost on RRI population')
        end
        newPopRRICost=evalCost( newPopRRI,A );
        newPopRLC = genPopRLC(population,sMin,sMax, nRLC );
        if DEBUG
            disp('stochasticSearch: Calling evalcost on RLC population')
        end
        newPopRLCCost=evalCost( newPopRLC,A );
        combinedCost=[cost',newPopRWCost',newPopRRICost',newPopRLCCost'];
        combinedPopulation=[population,newPopRW,newPopRRI,newPopRLC];
        [nextGenPopulation,cost] = nextGenSelection( combinedCost,combinedPopulation,noOfSamples );
        cost = cost';
        if DEBUG
            itr
            disp('stochasticSearch: Best population selected')
        end
        bestCostOfAGen(itr)=cost(1);
        bestPointOfAGen(:,itr)=nextGenPopulation(:,1);  %best point in each iteration
        population=nextGenPopulation;
        % for saving the best scatter
        evalCost(bestPointOfAGen(:,itr), A, 1, sprintf('iteration_%d.png',itr));
        save(sprintf('iteration_%d.mat',itr),'nextGenPopulation');
    end
    x=bestPointOfAGen;
    
    if DEBUG
        disp('stochasticSearch: Finished search')
    end
end













