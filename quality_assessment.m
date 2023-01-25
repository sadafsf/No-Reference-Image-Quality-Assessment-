function [num1,num2,hist,WEW]= quality_assessment(img,answer,thresh)
% this function assess the quality image: noise, contrast, edge quality 
[num1,num2]=imageQuality_noise(img);
hist=imageQuality_contrast(img,answer);
WEW=imageQuality_edge(img,thresh);
end