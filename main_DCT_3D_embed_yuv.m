function [v1,v2,p,a1,psnrvalue]=main_DCT_3D_embed_yuv(file,path,FILENAME,PATHNAME,FILEINDEX);
%����ˮӡͼƬ
%[file,path] = uigetfile('YD(18_22).bmp','ԭʼˮӡͼ��');
inputimg = strcat(path,file);
img = imread( inputimg );
img=im2bw(img);
img=imresize(img,[18 22]);
%imshow(img);


%����ԭʼ��Ƶ�ļ�
num_f=100;
%[FILENAME,PATHNAME,FILEINDEX]=uigetfile('suzie.yuv','ѡ��һ��yuv�ļ�');
[yuv,y,u,v]=loadyuv(FILENAME,176,144,num_f);
%num_f֡��
 num=0;
 y=double(y);
k=4;%�ؼ�֡���
for i=1:k:num_f
    Y_keyframe(:,:,num+1)=y(:,:,i);%Y_keyframeΪ���и�4֡ȡһ֡��֡����
    U_keyframe(:,:,num+1)=u(:,:,i);
    V_keyframe(:,:,num+1)=v(:,:,i);
    num=num+1;
end


%ֻ���ؼ�֡����Ƶ�ļ�
fileId = fopen('keysuzie.yuv','wb');%
for i=1:num
fwrite(fileId,Y_keyframe(:,:,i)' , 'uchar');
fwrite(fileId,U_keyframe(:,:,i)' , 'uchar');
fwrite(fileId,V_keyframe(:,:,i)' , 'uchar');
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

%��¼Y_key_group
% YKG=Y_key_group;

i=1;


%%Ƕ�����
for n=1:group_num
    
     y_key_group=Y_key_group(:,:,:,n);%ȡ���ֺõ�ÿһ����д������浽y_key_group��
     y_key_group=embed_3DDCT_5frame_YUV(y_key_group,img);
%      watermarkimg=extract_3DDCT_5frame_YUV(y_key_group);
%      imshow(watermarkimg);
     
     Y_key_group(:,:,:,n)=y_key_group;%�Ѵ���õ�������滻
     
end


%�����ֻ���ؼ�֡����Ƶ�ļ�
i=1;
for n=1:group_num
    Y_WMK_keyframe(:,:,1+(i-1)*p:i*p)=Y_key_group(:,:,:,n);
    i=i+1;
end
    
fileId = fopen('WMK_keyframe_suzie.yuv','wb');%
for i=1:num
fwrite(fileId,Y_WMK_keyframe(:,:,i)' , 'uchar');
fwrite(fileId,U_keyframe(:,:,i)' , 'uchar');
fwrite(fileId,V_keyframe(:,:,i)' , 'uchar');
end




%%���벢�滻ԭ��Ƶ֡
i=1;
    for x=1:num
y(:,:,i)=Y_WMK_keyframe(:,:,x);
i=i+p-1;
   
    end


    
%д����ˮӡ����Ƶ�ļ�
fileId = fopen('suzie_w.yuv','wb');%
for i=1:100
fwrite(fileId,y(:,:,i)' , 'uchar');
fwrite(fileId,u(:,:,i)' , 'uchar');
fwrite(fileId,v(:,:,i)' , 'uchar');
end



p=20;
%%ƽ��PSNR
[v1,v2,a1,psnrvalue]=average_psnr(p);
fclose('all');
