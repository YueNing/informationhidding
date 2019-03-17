function [video_image1,video_image2,avr_psnr,psnrvalue] =average_psnr(p)
num_f=25;
[FILENAME,PATHNAME,FILEINDEX]=uigetfile('output/hidden/yuv/keysuzie.yuv','ѡ��ԭ��Ƶ�ؼ�֡�ļ�');
[yuv1,y1,u1,v1]=loadyuv(FILENAME,176,144,25);
[FILENAME,PATHNAME,FILEINDEX]=uigetfile('output/hidden/yuv/WMK_keyframe_suzie.yuv','ѡ����ˮӡ�Ĺؼ�֡��Ƶ�ļ�');
[yuv2,y2,u2,v2]=loadyuv(FILENAME,176,144,25);

sum_psnr=0;
%key=5;
% p=5;
pathnow=pwd;
path='output/hidden/yuv';
cd (path);
for k=1:num_f
    video_image1=y1(:,:,k);
    imwrite(video_image1,strcat('000',int2str(k),'.bmp'),'bmp');
    video_image2=y2(:,:,k);
    imwrite(video_image2,strcat('000000',int2str(k),'.bmp'),'bmp');
    sum_psnr1=PSNR(strcat('000',int2str(k),'.bmp'),strcat('000000',int2str(k),'.bmp'));
    sum_psnr=sum_psnr1+sum_psnr;
    delete(strcat('000',int2str(k),'.bmp'));
    delete(strcat('000000',int2str(k),'.bmp'));
end
avr_psnr=sum_psnr/num_f;


 video_image1=y1(:,:,p);
imwrite(video_image1,strcat('000',int2str(p),'.bmp'),'bmp');

video_image2=y2(:,:,p);
imwrite(video_image2,strcat('000000',int2str(p),'.bmp'),'bmp');
psnrvalue=PSNR(strcat('000',int2str(p),'.bmp'),strcat('000000',int2str(p),'.bmp'));
cd (pathnow);
% 
% subplot(1,2,1);
% imshow(video_image1);
% title(['ԭ��Ƶ��',int2str(p),'֡']);
% xlabel(['��֡PSNR=',num2str(psnrvalue,'%4.2f'),'dB']);
% 
% subplot(1,2,2);
% grid,imshow(video_image2);
% title(['ˮӡ��Ƶ��',int2str(p),'֡']);
% xlabel(['��Ƶ��ƽ��PSNR=',num2str(avr_psnr,'%4.2f'),'dB']);

