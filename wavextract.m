function []=wavextract();
marklength=5394;%��ȡ��ˮӡͼ���С����֪
row=58;                    %row��ˮӡͼ����������֪
fid=fopen('marked.wav','r');
oa=fread(fid,inf,'uint8');
status=fseek(fid,44,'bof');
a=fread(fid,marklength,'uint8');
for i=1:marklength
    w1(i)=bitget(a(i),1);
end
w1=w1';
m=Vector2Matrix(w1,row);
imwrite(m,'markedbupt.bmp','bmp');
% figure;
% imshow('markedbupt.bmp');title('extracted watermark');
%��һ�����ϵ��
% ImageA=imread('bupt.bmp');
% ImageB=imread('markedbupt.bmp');
% % nc=nc(ImageA,ImageB);
% fprintf('Ƕ��ˮӡͼ������ȡˮӡͼ��Ĺ�һ�����ϵ��nc=%.3f\n',nc);