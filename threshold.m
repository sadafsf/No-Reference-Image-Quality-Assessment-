function out=threshold(input,threshold)
out = zeros(size(input));
for i = 1:size(input,1)
    for j = 1:size(input,2)
        if input(i,j)>threshold
            out(i,j) = input(i,j)+1;
        end
    end
end
end

