function [ gr,gi ] = build_gabor( mu_x, mu_y, sigma_x, sigma_y, fx, fy, theta, phase )

%To avoid the problem of fx and fy becoming 0
if(fx == 0)
    fx = 5;
end
if(fy == 0)
    fy = 5;
end
    
%BUILD_GABOR returns a 6*fx x 6*fy gabor matrix
% x vertical, y horizontal
DEBUG = 0;
ct = cos(theta);
st = sin(theta);

size_x = 2*ceil(6*abs(sigma_x))+1;
% if(mod(size_x,2)==0)
%     size_x = size_x+1;
% end
size_y = 2*ceil(6*abs(sigma_y))+1;
% if(mod(size_y,2)==0)
%     size_y = size_y+1;
% end

if(DEBUG)
    size_x
    size_y
end

centre = [floor(size_x/2) floor(size_y/2)];

gr = complex(double(zeros(size_x,size_y)));
gi = complex(double(zeros(size_x,size_y)));

mag = [0 0];

for x = (-floor(size_x/2)):floor(size_x/2)
    for y = (-floor(size_y/2)):floor(size_y/2)
%         if(DEBUG)
%             x
%             y
%         end
        temp = exp(-0.5*( (((x-mu_x)/sigma_x)^2) + (((y-mu_y)/sigma_y)^2) ));
        angle = 2*pi*(fx*ct*x + fy*y*st + phase);
        gr(x+centre(1)+1,y+centre(2)+1) = temp * cos(angle);
        gi(x+centre(1)+1,y+centre(2)+1) = temp * sin(angle);
        mag(1) = mag(1) + abs(gr(x+centre(1)+1,y+centre(2)+1));
        mag(2) = mag(2) + abs(gi(x+centre(1)+1,y+centre(2)+1));
    end
end

gr = gr./mag(1);
gi = gi./mag(2);

end

