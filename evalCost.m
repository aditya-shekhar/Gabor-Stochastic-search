function [ cost ] = evalCost( population, in_img, save, savename )
%EVALCOST Takes population and returns cost per initialisation

%% Determines if image needs to be saved for current initialization
if nargin == 2
    save = 0;
    savename = [];
end    


DEBUG = 1; %% Shows intermediate results if 1
cost = zeros(size(population,2),1); %% Initialze cost function

for pop = 1:size(population,2)
   if DEBUG
       disp('evalCost: Creating gabor filter')
       pop
   end
   %% Calls Gabor kernel to form the filter based on the input parameters
   %% Gr is real part of the filter and Gi is the imaginary part
   
[Gr,Gi] = build_gabor_kernel(population(:,pop)); 
   
   Y = [];
   C = [];
   
   for i = 1:size(in_img,3) %% Iterating for all images
       if DEBUG
           disp('evalCost: Applying gabor filter')
           i
           size(Gr)
%            size(in_img(:,:,i))
       end
%% Convolve image with 2D Gabor filter  
       gr = conv2(double(in_img(:,:,i)),Gr,'same');    % Remove 'valid' for zero padding
       gi = conv2(double(in_img(:,:,i)),Gi,'same');
       if DEBUG
           disp('evalCost: Magnitude')
       end
       m = magnitude(gr, gi);
       if DEBUG
           disp('evalCost: Smoothing')
       end 
%% Apply smoothing filter after Gabor filter
       s = smoothing(m, 7, 7);
       
%        if DEBUG
%            figure(1);
%            imshow( (Gr-min(min(Gr)))/(max(max(Gr))-min(min(Gr))) );
%            title('Real part of Gabor Filter (normalised)');
%            figure(2);
%            imshow( (gr-min(min(gr)))/(max(max(gr))-min(min(gr))) );
%            title('Filter output (normalised)');           
%            figure(3);
%            imshow( (m-min(min(m)))/(max(max(m))-min(min(m))) );
%            title('Magnitude output (normalised)');
%        end

       if DEBUG
            disp('evalCost: Scanning')
       end

%% Finding the mean and variance of the patches based on the size of the Gabor 
%% filter obtained in current iteration

       f_s = size(Gr);
       if i == 1
            X1 = scanningwindows(s, f_s(1), f_s(2), 5);    % Stride (argument no. 4) is changeable
            [tmpY,tmpC] = C_Y_of_X(X1);                     %returns the centroid of the scatter plot and the area.
       else if i == 2
            X2 = scanningwindows(s, f_s(1), f_s(2), 5);     
            [tmpY,tmpC] = C_Y_of_X(X2);
           end
       end
       Y = [Y tmpY];
       C = [C tmpC];
   end

   if save == 1
       if DEBUG
        disp('evalCost: Scattering')
       end

       figure(1)
       scatter(X1(1,:),X1(2,:),'b','o');
       hold on
       scatter(X2(1,:),X2(2,:),'r','x');
       title('Scatter plot of mean vs variance');
       hold off
       if DEBUG
           disp('evalCost: Saving scatter plot')
       end
       saveas(1,savename);
   end
   
   if DEBUG
       Y
       C
   end
   %% Distance between vectors containing means and variances for each patch of the processed images
 
   d = (Y(1)-Y(2))'*(Y(1)-Y(2));    
   %% Measures maximum spread of the cluster of points
   %% (vectors containing mean and variance of each of the population) for an image
   %% size of the vector (Y(1)-Y(2)) is [number of populations * 2]
   s = max(C); 
   %% Cost fuction takes into account clustering and distance of clusters
   %% for two different images
   cost(pop) = d/s;
   
end   

end

