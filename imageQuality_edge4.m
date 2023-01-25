function score = imageQuality_edge4(img)
size_img = size(img);
[row, column] = size(img);
padded_img = padarray(img, [3 3], 0, 'both');
i=3;
while(i<=row+3)
    for j = 3:column+3
        window = padded_img(i:i, j-2:j+2);
        localMax = find(window == max(window));
        localMin = find(window == min(window));
        width(i,j) = abs(max(localMin) - min(localMax));
    end
    i=i+1;
end

totalEdges = nnz(width);

maxWidth = max(max(width));
minWidth = min(min(width));

freq = zeros(1, maxWidth);
pdf = zeros(1,maxWidth);
j=1; ind = 1;

for k = 1:maxWidth+abs(minWidth)
    freq(k) = length(find(width == minWidth+ind));
    pdf(k) = freq(k)/totalEdges;
    total(k) = pdf(k)*k;
    ind = ind+1;
end

aveWidth = sum(total);
peakLoc = find(pdf == max(pdf));

for i = 1:size(pdf, 2)
    if i < peakLoc
        d(i) = (i/peakLoc)^2;
    elseif i == peakLoc
        d(i) = 1;
    elseif i > peakLoc
        d(i) = ((maxWidth-i)/(maxWidth-peakLoc))^2;
    end
end

for i = 1:size(pdf, 2)
    total2(i) = d(i)*pdf(i)*i;
end

score = sum(total2);
disp("The WEW score of the given image is: " + num2str(score));
end