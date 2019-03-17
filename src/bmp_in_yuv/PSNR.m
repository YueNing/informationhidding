%�ļ�����PSNR.m
%��  д�����ָ�
%��дʱ�䣺2005.11.01
%�������ܣ�����������ɶ�����ͼ��ķ�ֵ����ȼ���
%�����ʽ������psnr=PSNR('lena.jpg','lenawater.jpg');
%����˵����
%originalΪԭʼͼ��
%testΪ����ˮӡ��ͼ��
%psnrvalueΪ���߷�ֵ�����
%ʵ����Ҳ������MSE��SNRֵ

function psnrvalue=PSNR(original,test);

%����ԭʼͼ����źŹ���
A=imread(original);
%A=rgb2gray(A);
A=double(A);
B=imread(test);
%B=rgb2gray(B);
B=double(B);

%����MSE
%�ж�����ͼ���Ƿ���Ч
[m,n]=size(A);
[m2,n2]=size(B);
if m2~=m||n2~=n
    error('ͼ��ѡ�����');
end

%����MSE
msevalue=0;
for i=1:m
    for j=1:n
        msevalue=msevalue+(A(i,j)-B(i,j))^2;
    end
end
msevalue=msevalue/(m*n);
if msevalue==0
    error('ͼ��ѡ�����');
end

%��������ȣ���ֵ�����
signal=0;
for i=1:m
    for j=1:n
        signal=signal+A(i,j)^2;
    end
end
signal=signal/(m*n);
snrvalue=signal/msevalue;
snrvalue=10*log10(snrvalue);
psnrvalue=255^2/msevalue;
psnrvalue=10*log10(psnrvalue);