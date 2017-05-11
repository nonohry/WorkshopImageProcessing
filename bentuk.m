%Algoritma sederhana untuk mengenali bentuk dari objek

clc;clear;close all;

%baca citra
RGB = imread('pillsetc.png');
imshow(RGB);

I = rgb2gray(RGB);
threshold = graythresh(I);
bw = im2bw(I,threshold);
bw = bwareaopen(bw,30);
 
se = strel('disk',2);
bw = imclose(bw,se);
bw = imfill(bw,'holes');
[B,L] = bwboundaries(bw,'noholes');
 
hold on
for k = 1:length(B)
    boundary = B{k};
    plot(boundary(:,2), boundary(:,1), 'w', 'LineWidth', 2)
end
 
stats = regionprops(L,'Area','Centroid','Eccentricity');

for k = 1:length(B)
    boundary = B{k};
    delta_sq = diff(boundary).^2;
    perimeter = sum(sqrt(sum(delta_sq,2)));
    area = stats(k).Area;
    eccentricity = stats(k).Eccentricity;
    metric = 4*pi*area/perimeter^2;
     
    centroid = stats(k).Centroid;
    text(centroid(1),centroid(2)-16,num2str(k),'Color','r',...
        'FontSize',20,'FontWeight','bold');
    disp('===================================')
    disp(strcat(['Object number = ', num2str(k)]))
    disp(strcat(['Area = ',num2str(area)]))
    disp(strcat(['Perimeter = ',num2str(perimeter)]))
    disp(strcat(['Metric = ',num2str(metric)]))
    disp(strcat(['Eccentricity = ',num2str(eccentricity)]))
    
    %tentukan bentuk daro objek berdasarkan nilai metric
    if metric>0.8
        text(centroid(1)-16,centroid(2)+16,'Bulat','Color','r',...
            'FontSize',20,'FontWeight','bold');
    else
        text(centroid(1)-16,centroid(2)+16,'Tidak Bulat','Color','b',...
            'FontSize',20,'FontWeight','bold');
    end
end