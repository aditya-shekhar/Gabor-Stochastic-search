function [ newPopRLC ] = genPopRLC(population, sMin,sMax,nRLC )
%GENPOPRLC

   li=size(population);
   newPopRLC=zeros(li(1),nRLC);
   for i=1:1:nRLC
       alpha=rand(3,1);
       index=[ceil(alpha(1)*li(2));ceil(alpha(2)*li(2))];
       
       index(index>li(2)) = li(2);
       index(index<1) = 1;
       newSample=alpha(3)*population(index(1))+(1-alpha(3))*population(index(2));
%        [ newSample ] = boundCheck(newSample, sMin,sMax );%this is require??it will be a point in between
       newPopRLC(:,i)=newSample;
   end
   


end

