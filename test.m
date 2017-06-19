// set the input folder of left and right images

LeftListing  = dir('/media/xiyu/data/dataset/sequences/06/image_2/*.png');
RightListing = dir('/media/xiyu/data/dataset/sequences/06/image_3/*.png');

curMax = 0;

idx = 0;
for idx = 1:numel(LeftListing)
    [fileIdx,leftImg] = getFullName(LeftListing(idx));
    [fileIdx,rightImg] = getFullName(RightListing(idx));
    % copy the original images for 10 times
    
    resultName = strcat('./depth_autoVision/',num2str(idx),'.png');
    getDisparity(leftImg,rightImg,resultName);
    idx = idx +1;
end

function getDisparity(leftImg,rightImg,resultName)

%    imshow(leftImg);
%    imshow(rightImg);
    I1 = imread(leftImg);
    I2 = imread(rightImg);
    % I1 = imread('img_0.png');
    % I2 = imread('img_1.png');
    I1 = rgb2gray(I1);
    I2 = rgb2gray(I2);
    I1 = imresize(I1,[87,306]);
    I2 = imresize(I2,[87,306]);

   tic
    [D1,D2] = sgmStereoMex(I1,I2,1);
    toc
    imagesc(D1); colormap(jet(1024));
    saveas(gcf,resultName,'png')    

// set a default disparity for pixels with void disparity
    D1(D1< 1)=10000.0;
%     D1 = (1./D1)*0.239983*983.044;
// convert disparity map to depth map
    D1 = (1./D1)* 320.0 * 0.5009;
  
    D1 = uint16(D1);
end

function [idx, fullName] = getFullName(inputFile)

    folder = inputFile.folder;
    name = inputFile.name;
    strList = strsplit(name,'.');
    fileIdx = strList(1);
    idx = str2num(fileIdx{1});
    fullName = strcat(folder,'/',name);
    
end