// This is a tool to resize images
fileListing  = dir('/home/xiyu/Desktop/project/VideoParsing/videoparsing/build/Results_WithFSO/*.png');

curMax = 0;

idx = 0;
for idx = 1:numel(fileListing)
    [fileIdx,leftImg] = getName(fileListing(idx));
    
    resultName = strcat('/home/xiyu/Downloads/06/crf_result/', fileIdx{1},'.ppm')
    I = imread(leftImg);
    J = imresize(I,[370,1226]);
    imwrite(J,resultName);
    idx = idx +1;
end

function [fileIdx, fullName] = getName(inputFile)
    folder = inputFile.folder;
    name = inputFile.name
    strList = strsplit(name,'.');
    strList
    fileIdx = strList(1);
    fullName = strcat(folder,'/',name);
    
end