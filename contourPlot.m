function [  ] = contourPlot( sMin,sMax,muX,muY,sigmaX,sigmaY,noOfPoints )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

    xMin=sMin(1);
    xMax=sMax(1);
    
    yMin=sMin(2);
    yMax=sMax(2);
    
    stepSizeX=(xMax-xMin)/(noOfPoints-1);        %step size along the x axis for creating the N points.N-1 is used so as to avoid the additional point coming when N is used
    stepSizeY=(yMax-yMin)/(noOfPoints-1);
    
    x=xMin:stepSizeX:xMax;              %Range of values for x
    y=yMin:stepSizeY:yMax;                                    %Range of values for y
   
    x1=(x+5)/sigmaX;
    y1=(y+5)/sigmaY;
    x2 = (x-8)/sigmaX;
    y2= (y-8)/sigmaY ;
    
    x3=0.5*x1+0.5*x2;
    y3=0.5*y1+0.5*y2;
    
    [X,Y]=meshgrid(x1,y1);
     [X2,Y2]=meshgrid(x2,y2);
     
    
    z1=(X).^2+(Y).^2;
    z2=(X2).^2+(Y2).^2;
    z=z1.*z2;
    
    contour(x,y,z,150)


end

