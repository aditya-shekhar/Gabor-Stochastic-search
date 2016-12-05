%% External driver script

%% This code attempts to find best parameters of Gabor filters to be able 
%% to differentiate between the input square images of same size.    
% DEBUG = 0;
% limits of search space
%       mu_x, mu_y, sigma_x, sigma_y, fx, fy, theta, phase
sMin = [  -1,   -1,       1,       1,  1,  1,     0,    0]';
sMax = [   1,    1,      20,      20, 10, 10,    pi,   pi]';
radius=[0.05, 0.05,       1,       1,0.1,0.1,   0.3,  0.3]';
population_size = 50; % Number of gabor filters initialized per iteration

nRRI=40; % Number of random initializations per iteration
nRLC=10; % Number of random linear combinations generated per iteration
maxItr=20; % Number of iterations
files = {'D11.gif', 'D20.gif'}; % Input image file names
num_gabor = 1; 

% if DEBUG
%     disp('main: Calling stochasticSearch with params:')
%     sMin,sMax,population_size,radius,nRRI,nRLC,maxItr,files    
% end
%% Calling stochastic seach function with required search space parameters
joint_best_pop = stochasticSearch( sMin,sMax,population_size,radius,nRRI,nRLC,maxItr,files ); 
%% Saving the best population parameters in a mat file in current directory 
filename = sprintf('population_variation_%s.mat',datestr(clock,'dd_HH_MM_SS'));
save(filename);