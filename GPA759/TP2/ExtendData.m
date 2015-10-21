function ExtendData(path)

allFiles = dir([path '*.tif']);

for i = 1:length(allFiles)
    img           = imread(allFiles(i).name);
    imgMirror     = flip(img,2);
    imwrite(imgMirror,[path 'Mirror' allFiles(i).name]);    
    imgUpsideDown = flip(img,1);
    imwrite(imgUpsideDown,[path 'UpsideDown' allFiles(i).name]);    
end
end

