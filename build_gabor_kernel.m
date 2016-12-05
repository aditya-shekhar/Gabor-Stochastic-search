function [ gr,gi ] = build_gabor_kernel( p )
%BUILD_GABOR_KERNEL
%   Kernel function to call build_gabor from population

[gr,gi] = build_gabor(p(1),p(2),p(3),p(4),p(5),p(6),p(7),p(8));


end

