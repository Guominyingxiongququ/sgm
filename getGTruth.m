gListing  = dir('/home/xiyu/Documents/Realistic_rendering_model_1000_Hz/depth/1/*.exr');

for idx = 1:numel(gListing)
    [fileIdx,gImg] = getFullName(gListing(idx));
    gDepth = dlmread(gImg);
    gDepth = uint16(gDepth*1000);
    imgName = strcat('/home/xiyu/Documents/Realistic_rendering_model_1000_Hz/rgb/1/',num2str(fileIdx),'.png');
    oriImg = imread(imgName);
    for t=1
        resultName = strcat('/home/xiyu/Documents/Realistic_rendering_model_1000_Hz/depth_kinect/',num2str(fileIdx),'.png');
        imwrite(gDepth,resultName);
    end
end


function [idx, fullName] = getFullName(inputFile)

    folder = inputFile.folder;
    name = inputFile.name;
    strList = strsplit(name,'.');
    fileIdx = strList(1);
    idx = str2num(fileIdx{1});
    fullName = strcat(folder,'/',name);
end