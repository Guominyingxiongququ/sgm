LeftListing  = dir('/media/xiyu/data/training/image_0/*_10.png');
RightListing = dir('/media/xiyu/data/training/image_1/*_10.png');

curMax = 0;

idx = 0;
for idx = 1:numel(LeftListing)
    [fileName,leftImg] = getFullName(LeftListing(idx));
    [fileName,rightImg] = getFullName(RightListing(idx));
    
    resultName = strcat('/home/xiyu/Desktop/project/devkit/cpp/results/xiyu/',fileName);
    getDisparity(leftImg,rightImg,resultName);
    idx = idx +1;
end

function getDisparity(leftImg,rightImg,resultName)

    I1 = imread(leftImg);
    I2 = imread(rightImg);
    [D1,D2] = sgmStereoMex(I1,I2,1);
    D1(D1< 1)=0.0;
    D1 = uint16(D1)
    D1 = D1;
     imwrite(D1,resultName);
end

function [fileName, fullName] = getFullName(inputFile)

    folder = inputFile.folder;
    name = inputFile.name;
    fullName = strcat(folder,'/',name);
    fileName = name; 
end