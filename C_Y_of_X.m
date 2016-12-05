function [ Y, C ] = C_Y_of_X( X )
%C_Y_of_X Get centroid and determinant of 
%    covariance matrix of X
%    X assumed to be of size (2 x NoOfPatches)
%X is a mtrix of mean and variances of all the pathces
Y = sum(X,2)/size(X,2);  % taking the mean of all the means, and mean of all the variances to get the centroid of the scatter plot for 
						% the current population
newX = X - repmat(Y,1,size(X,2)); % a new mean and variance matrix is created with the subtracted mean values of the mean and variance.

Cmat = newX * newX'; % covaraince matrix is created

C = det(Cmat);  % determinant is calculated which gives the approximate area of the scatter plot.

end

