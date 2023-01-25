function out_img = auto_edge_detection(img, option)
% Edge Detection
S_filter = [1 0 -1; 2 0 -2; 1 0 -1];

out_s_x = spatial_filtering(img, S_filter);
out_s_y = spatial_filtering(img, transpose(S_filter));

gradient_mag_sobel = sqrt(abs(out_s_x).^2 + abs(out_s_y).^2);
%% threshold
threshold_point = automatic_threshold(gradient_mag_sobel);
median_threshold = median(threshold_point);
mean_threshold = mean(threshold_point);
max_threshold = max(threshold_point);
min_threshold = min(threshold_point);

if isnumeric(option) 
    out_img  = threshold(gradient_mag_sobel, option*max_threshold);
elseif option == "median"
    out_img = threshold(gradient_mag_sobel, median_threshold);
elseif option == "mean"
    out_img = threshold(gradient_mag_sobel, mean_threshold);
elseif option == "min"
    out_img = threshold(gradient_mag_sobel, min_threshold);
end 
% 
% figure;
% imshow(out_img,[]); title("Automatic Threshold");
end