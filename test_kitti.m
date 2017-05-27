close all;

% I1 = imread('1.png');
% I2 = imread('2.png');

I1 = imread('kitti_0.png');
I2 = imread('kitti_1.png');
figure,imagesc(I1),colormap gray;
figure,imagesc(I2),colormap gray;
keyboard;
I1 = rgb2gray(I1);
I2 = rgb2gray(I2);

disp('processing with old features+settings ...');
tic;
[D1,D2] = sgmStereoMex(I2,I1,0);
toc;
figure,imagesc(D1); colormap(jet(1024));
keyboard;

tic;
[D1,D2] = sgmStereoMex(I2,I1,1);
toc;
figure,imagesc(D1); colormap(jet(1024));
keyboard;

tic;
disp('processing with new features+settings ...');
[D1,D2] = sgmStereoMex(I1,I2,0);
toc;
figure,imagesc(D1); colormap(jet(1024));

disp('done!');