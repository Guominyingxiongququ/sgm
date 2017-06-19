
% copy 10 times

gListing1  = dir('./stereo_depth/*.png');
gListing2  = dir('./stereo_img_left/*.png');


for idx = 1:numel(gListing1)
    [fileIdx,gImg] = getFullName(gListing1(idx));
    for t=1:10
        resultName = strcat('./copied_stereo_depth/',num2str(fileIdx*10 + t),'.png');
        copyfile(gImg,resultName);
    end
    
    [fileIdx,gImg] = getFullName(gListing2(idx));
    for t=1:10
        resultName = strcat('./copied_stereo_img/',num2str(fileIdx*10 +t),'.png');
        copyfile(gImg,resultName);
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