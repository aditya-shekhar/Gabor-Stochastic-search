%computing the magnitude of image after gabor filter operation

function [ mag ] = magnitude(real,imaginary )
mag = real.*real+imaginary.*imaginary;
mag = sqrt(mag);
end



