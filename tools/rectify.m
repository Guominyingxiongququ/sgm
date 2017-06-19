// This is a script to recitify images
// The path of left and right images
LeftListing  = dir('/home/xiyu/Downloads/LeftStereo_rectfiedPinhole/left/*.png');
RightListing = dir('/home/xiyu/Downloads/LeftStereo_rectfiedPinhole/right/*.png');

curMax = 0;

idx = 0;
for idx = 1:numel(LeftListing)
    [fileIdx,leftImg] = getFullName(LeftListing(idx));
    [fileIdx,rightImg] = getFullName(RightListing(idx));
    rectifyLeft = strcat('/home/xiyu/Downloads/LeftStereo_rectfiedPinhole/rectifyLeft/',num2str(idx),'.png');
    rectifyRight = strcat('/home/xiyu/Downloads/LeftStereo_rectfiedPinhole/rectifyRight/',num2str(idx),'.png');
    getRectify(leftImg,rightImg,rectifyLeft,rectifyRight);
    idx = idx +1;
end

function getRectify(leftImg,rightImg,rectifyLeft, rectifyRight)

    I1 = imread(leftImg);
    I2 = imread(rightImg);
    
    rotm = [    0.9999    0.0090    0.0072;
   -0.0090    1.0000   -0.0024;
   -0.0072    0.0023    1.0000]
    
    
%     baseline = 0.5009;
    Intrinsic1 = [320 0 0; 0 320 0; 320 240 1];
    cameraP1 = cameraParameters('IntrinsicMatrix',Intrinsic1);
    cameraP2 = cameraParameters('IntrinsicMatrix',Intrinsic1);
    stereoParams = stereoParameters(cameraP1,cameraP2,rotm,[ 5.00886917888686110e-001,1.15301394735468390e-003,-2.94154771637605970e-003]);
    [J1,J2]= rectifyStereoImages(I1,I2,stereoParams,'OutputView','full');
    imshowpair(J1,J2,'falsecolor','ColorChannels','red-cyan');
    imwrite(J1,rectifyLeft);
    imwrite(J2,rectifyRight); 
end

function [idx, fullName] = getFullName(inputFile)

    folder = inputFile.folder;
    name = inputFile.name;
    strList = strsplit(name,'.');
    fileIdx = strList(1);
    idx = str2num(fileIdx{1});
    fullName = strcat(folder,'/',name);
    
end

