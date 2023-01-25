function out = spatial_filtering(img, h)
    out = conv2(double(img), h, 'same');
end