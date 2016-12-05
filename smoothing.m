%performs median filtering, where each output pixel contains the median value in the m-by-n neighborhood 
%around the corresponding pixel in the input image.
function [ B ] = smoothing( A,m,n )
B=medfilt2(A, [m n]);
end
