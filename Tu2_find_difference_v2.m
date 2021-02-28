%% Activity 2: Spot the Difference 
%% �Ҳ�ͬ
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
im_diff=im_diff>40;%Ҫת��Ϊdouble���ͽ��м��㣬����uint8�������������
im_diff=cat(3,im_diff*255,zeros(size(im_diff)),zeros(size(im_diff)));
% ���������im_diffתΪrgbģʽ�󣬽���r����ֵ
%Concatenate arrays,which 3 is number of dimension.
im_diff = uint8(im_diff);%change into uint8scale
% im_diff = imlincomb(0.4,im1,10,im_diff,'uint8');
im_diff1 = im_diff;
im_diff = imlincomb(0.5,im1,0.5,im_diff,'uint8');
figure;
subplot(1,3,1);imshow(im1);
subplot(1,3,2);imshow(im2);
subplot(1,3,3);imshow(im_diff)





%% ��ͨ����
clc;close all;clear all;
f = imread('spot_the_difference.png');
[M,N,D] = size(f);
img1 = f(:,1:N/2,:);
img2 = f(:,N/2+1:end,:);

% calculate the size 
img1_size = size(img1);
img2_size = size(img2);

% ��ֹͼ��ƥ��
if(~isequal(img1_size, img2_size))
    error('The two images must be the same size and shade of colour.');
end

% %����ͼ���ֵ
% kep_kulonbseg1 = img2 - img1;
% kep_kulonbseg2 = img1 - img2;
% %����ͼ��a��b����a��3,3,2��-b��3,3��1�����������Ǹ������Ļ�matla���Զ�����Ϊ0,
% kep_kulonbseg = kep_kulonbseg1 + kep_kulonbseg2;   

% ����ͼ���ֵ
im_diff = img1 - img2;
figure;imshow(im_diff)
% ת��Ϊ�Ҷ�ֵ
gray_diff = rgb2gray(im_diff);

%ʹ�� graythresh ������ֵ����ֵ��һ������Χ [0, 1]��
treshold = graythresh(gray_diff);
% treshold = 0.4;%Ҳ�����Լ��趨��ֵ
%ʹ����ֵ��ͼ��ת��Ϊ��ֵͼ��
BW = imbinarize(gray_diff,treshold);
figure;imshow(BW)
%�ڶ�ֵͼ���Ա���ʾԭʼͼ��
figure;imshowpair(gray_diff,BW,'montage')

%��imdilate�����Զ�ֵͼ�������ͣ�������ͨ����
BW_inflation= imdilate(BW,strel('disk',7));
figure;imshow(BW_inflation);
connect_area = bwlabel(BW_inflation,8);
connect_num =  bwconncomp(BW_inflation)
%�Զ�ά��ֵͼ���е���ͨ�������б�ע
%����ο����ϣ�https://ww2.mathworks.cn/help/images/ref/bwlabel.html?searchHighlight=bwlabel&s_tid=srchtitle#bupqqy6-1-n
stat = regionprops(connect_area, 'BoundingBox');
% ��ȡ��ͨ���������
figure
subplot(1,2,1),
imshow(img1);
title('image 1');

%�þ��ο����ͨ����
subplot(1,2,2),
imshow(img2);
title('image 2');
for k = 1:size(stat)
    rectangle('Position', stat(k).BoundingBox, 'EdgeColor','r','LineWidth',1);
end