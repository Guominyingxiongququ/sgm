% LeftListing  = dir('/home/xiyu/Downloads/06/image_2/*.png');
% RightListing = dir('/home/xiyu/Downloads/06/image_3/*.png');

% LeftListing  = dir('/home/xiyu/Downloads/data/2014-05-14-13-50-20/stereo/left/*.png');
% RightListing = dir('/home/xiyu/Downloads/data/2014-05-14-13-50-20/stereo/right/*.png');

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
    
%     D2 = double(D2); 
%     D1(D1< 1)=0;
%     size(D1)
%     D1 = uint16(D1);
%     figure,imagesc(D1); colormap(jet(1024));
%   D3 = cat(3,D1,D1,D1);
%     imwrite(D3,resultName);
%     I1 = imread(resultName);
%     imshow(I1);
    D1(D1< 1)=10000.0;
%     D1 = (1./D1)*0.239983*983.044;
    D1 = (1./D1)* 320.0 * 0.5009;
  
    D1 = uint16(D1);
%     figure,imagesc(D1); colormap(jet(1024));
%     dlmwrite(resultName,D1,'\t');

%     imwrite(D1,resultName);
    
%     figure,imagesc(D1); colormap(jet(1024));

%     disp('processing with new features+settings ...');
%     [D1,D2] = sgmStereoMex(I1,I2,0);
%     figure,imagesc(D1); colormap(jet(1024));
%     figure,imagesc(D2); colormap(jet(1024));
%     disp('done!');
%     maxRange = max(max(max(D1)),max(max(D2)));
end

function [idx, fullName] = getFullName(inputFile)

    folder = inputFile.folder;
    name = inputFile.name;
    strList = strsplit(name,'.');
    fileIdx = strList(1);
    idx = str2num(fileIdx{1});
    fullName = strcat(folder,'/',name);
    
end