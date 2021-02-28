%% Activity 2: Spot the Difference 
%% 找不同
clc;close all;clear all;
f = imread('spot_the_difference.png');
[M,N,D] = size(f);
im1 = f(:,1:N/2,:);
im2 = f(:,N/2+1:end,:);
% figure 
% imshow(im1)
% figure 
% imshow(im2)

im_diff=im1-im2;
im_diff=rgb2gray(im_diff);%change into grayscale,(in range double[0,255])
im_diff=im_diff>40;%要转换为double类型进行计算，如用uint8，可能数据溢出
im_diff=cat(3,im_diff*255,zeros(size(im_diff)),zeros(size(im_diff)));
% 这里决定了im_diff转为rgb模式后，仅有r区有值
%Concatenate arrays,which 3 is number of dimension.
im_diff = uint8(im_diff);%change into uint8scale
% im_diff = imlincomb(0.4,im1,10,im_diff,'uint8');
im_diff1 = im_diff;
im_diff = imlincomb(0.5,im1,0.5,im_diff,'uint8');
figure;
subplot(1,3,1);imshow(im1);
subplot(1,3,2);imshow(im2);
subplot(1,3,3);imshow(im_diff)





%% 连通区域
clc;close all;clear all;
f = imread('spot_the_difference.png');
[M,N,D] = size(f);
img1 = f(:,1:N/2,:);
img2 = f(:,N/2+1:end,:);

% calculate the size 
img1_size = size(img1);
img2_size = size(img2);

% 防止图像不匹配
if(~isequal(img1_size, img2_size))
    error('The two images must be the same size and shade of colour.');
end

% %计算图像差值
% kep_kulonbseg1 = img2 - img1;
% kep_kulonbseg2 = img1 - img2;
% %比如图像a和b，做a（3,3,2）-b（3,3，1），如果相减是个负数的话matla会自动处理为0,
% kep_kulonbseg = kep_kulonbseg1 + kep_kulonbseg2;   

% 计算图像差值
im_diff = img1 - img2;
figure;imshow(im_diff)
% 转换为灰度值
gray_diff = rgb2gray(im_diff);

%使用 graythresh 计算阈值。阈值归一化至范围 [0, 1]。
treshold = graythresh(gray_diff);
% treshold = 0.4;%也可以自己设定阈值
%使用阈值将图像转换为二值图像。
BW = imbinarize(gray_diff,treshold);
figure;imshow(BW)
%在二值图像旁边显示原始图像。
figure;imshowpair(gray_diff,BW,'montage')

%用imdilate函数对二值图进行膨胀，修正连通区域。
BW_inflation= imdilate(BW,strel('disk',7));
figure;imshow(BW_inflation);
connect_area = bwlabel(BW_inflation,8);
connect_num =  bwconncomp(BW_inflation)
%对二维二值图像中的连通分量进行标注
%详见参考资料：https://ww2.mathworks.cn/help/images/ref/bwlabel.html?searchHighlight=bwlabel&s_tid=srchtitle#bupqqy6-1-n
stat = regionprops(connect_area, 'BoundingBox');
% 获取连通区域的属性
figure
subplot(1,2,1),
imshow(img1);
title('image 1');

%用矩形框出连通区域
subplot(1,2,2),
imshow(img2);
title('image 2');
for k = 1:size(stat)
    rectangle('Position', stat(k).BoundingBox, 'EdgeColor','r','LineWidth',1);
end