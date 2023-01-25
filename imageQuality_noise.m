function [PSNR,imgVar]=imageQuality_noise(img)

if isa(img,"double")==0 
    img=im2double(img);
end

imgVar=var(img(:));
imgrescale= rescale(img, 0, 255);
ref=imnlmfilt(imgrescale);

% find the y and x value of the image
[M,N] = size(imgrescale);

error = (ref - imgrescale);
% to get the Mean Squared Error.  It will be a scalar (a single number).
MSE= sum(sum(error .^2)) / (M * N);

% Calculate PSNR (Peak Signal to Noise Ratio) from the MSE according to the formula.
if(MSE > 0)
PSNR = 10*log(255^2/MSE);
else
PSNR = 99;
end
disp(["The Peak SNR of the given image with the filtered version of it is: " + int2str(PSNR)]);
disp(["The image variance: " + int2str(imgVar)]);
disp(["MSE: " + int2str(MSE)]);
end








