
function [vol, info] = imageRead(path, imageFormat, name)
addpath(path);
filename = fullfile(path, append(name, imageFormat));

if imageFormat == '.mhd' 
    [vol, info] = read_mhd(filename);

elseif imageFormat == '.raw'
    [vol, info] = read_mhd(filename);

elseif imageFormat == '.dcm'
    vol = dicomreadVolume(path);
    info = dicomCollection(path);

elseif imageFormat == '.pgm'
    d = dir(fullfile(path, "*.pgm"));
    for k = 1:numel(d)
        [vol{k}, info{k}] = imread(fullfile(path, d(k).name));
    end

else 
    [vol, info] = imread(append(name, imageFormat));
end
end