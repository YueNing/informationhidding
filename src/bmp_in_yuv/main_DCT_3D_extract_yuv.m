function [img,extractedimg]=main_DCT_3D_extract_yuv(FILENAME,PATHNAME,FILEINDEX)
num_f=100;
%[FILENAME,PATHNAME,FILEINDEX]=uigetfile('foreman_w.yuv','ѡ����ˮӡ��yuv�ļ�');
[yuv,y,u,v]=loadyuv(FILENAME,176,144,num_f);
 num=0;
 y=double(y);
k=4;%�ؼ�֡���

for i=1:k:num_f
    Y_keyframe(:,:,num+1)=y(:,:,i);%Y_keyframeΪ���и�4֡ȡһ֡��֡����
    
    num=num+1;
end

%%����
p=5;
q=0;
group_num=num/p;
for i=1:group_num
  for n=1:p
Y_key_group(:,:,n,i)=Y_keyframe(:,:,q+1);%��ÿP֡��Y��Ϊһ�飬���뵽Y_key_group��ά������
             q=q+1;                                    %���й�4�飬ÿ��5����ά����
  end
end
watermarkimgs=zeros(18,22);
%��ȡ����

for n=1:group_num
    
     y_key_group=Y_key_group(:,:,:,n);%ȡ���ֺõ�ÿһ����д������浽y_key_group��
     watermarkimg=extract_3DDCT_5frame_YUV(y_key_group);
     watermarkimgs=watermarkimgs+watermarkimg;
     
end
%imshow(watermarkimg);
extractedimg=watermarkimgs/(group_num);%ˮӡȡƽ��


% [file,path] = uigetfile('*.jpg','ԭʼˮӡͼ��');
[file,path] = uigetfile('YD(18_22).bmp','ԭʼˮӡͼ��');
inputimg = strcat(path,file);
img = imread( inputimg );
% img=rgb2gray(img);
img=im2bw(img);
% img=imresize(img,[18 22]);

% nc=NC(img,extractedimg);
% % subpolt(121);
% imshow(extractedimg);
% title('��ȡ��ƽ�����ˮӡͼ��');
% xlabel(['NC=',num2str(nc)]);