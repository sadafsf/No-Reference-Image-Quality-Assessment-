function histogram_spread = imageQuality_contrast(img, plot)
x = isa(img, "double");
if x == 0
    img = cast(img, 'double');
end

size_img = size(img);
[row, column] = size(img);

if length(size(img)) == 2
    minI = min(min(img));
    maxI = max(max(img));
    binNum = ceil(sqrt(size_img(1)*size_img(2)));
elseif length(size(img)) == 3
    minI = min(min(min(img)));
    maxI = max(max(max(img)));
    binNum = ceil(sqrt(size_img(1)*size_img(2)*size_img(3)));
end

freq = zeros(1, maxI);
pdf = zeros(1,maxI);
cdf = zeros(1,maxI);
j=1; ind = 0;

for k = 1:maxI+abs(minI)
    freq(k) = length(find(img == minI+ind));
    pdf(k) = freq(k)/(row*column);
    ind = ind+1;
end

cdf(1) = pdf(1);

for j = 2:maxI+abs(minI)
    cdf(j) = cdf(j-1)+pdf(j);
end

temp = [0.25 0.75];
[min1, first_percentile] = min(abs(cdf-temp(1)));
[min2, third_percentile] = min(abs(cdf-temp(2)));

histogram_spread = (third_percentile - first_percentile)/(maxI-minI);

if plot=="yes" || plot=="Yes"
    figure;
    %subplot(1,2,1)
    imshow(img, []); title(["Input image with Histogram Spread of", num2str(histogram_spread)]);
%     subplot(1,2,2)
%     bar(cdf); 
%     xlabel('Bin Value'); ylabel('Number of Occurences');
%     title("Cumulative Distribution Function")
end
disp("The histogram spread score of the given image is: " + num2str(histogram_spread));
end