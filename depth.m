fileID = fopen('0.exr','r');
formatSpec = '%f';
A = fscanf(fileID, formatSpec);
A = reshape(A,[640,480]);
A(A==65504)=0;
A = A';
figure,imagesc(A); colormap(jet(1024));