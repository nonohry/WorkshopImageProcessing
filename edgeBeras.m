%Boundary Detection - Local Variance
%Read an image
I = imread('rice.png');
figure,imagesc(I);colormap(gray);

I = double(I);

%Define the window size
sz=3;
window = ones(sz)/sz.^2;

%Find the local mean
mu = conv2(I,window,'same');

%Find the local Variance
II = conv2(I.^2,window,'same');
Lvar = II-mu.^2;

figure,imagesc(Lvar);colormap(gray);title('Local Variance of the image');

%Define a Threshold
meanL = mean(Lvar(:));

%Set the pixel values based on threshold
Boundary = zeros(size(Lvar));
Boundary(Lvar < meanL)=1;
Boundary(Lvar >= meanL) = 0;

figure,imagesc(Boundary);colormap(gray);title('Boundary Extracted Image');
