%��������:�������������LSB�ϵ�˳����Ϣ���أ�����ѡ������ѡ��BMPͼ��
%�����ʽ����:[ste_cover,len_total]=lsbhide('lenna.bmp','message.txt','LSBcover.bmp')
%����˵����
%input����Ϣ��������ͼ��,ΪBMPͼ��
%file��������Ϣ�ļ�
%output����Ϣ���غ�����ͼ��
%ste_cover����Ϣ���غ�ͼ�����
%len_total��������Ϣ�ĳ��ȣ�������


function [ste_cover,len_total]=lsbhide(input,file,output)


%����ͼ�����
cover=imread(input);
ste_cover=cover;
ste_cover=double(ste_cover);%�ھ�����ʹ�õ�����������double��


%���ı��ļ�ת��Ϊ����������
f_id=fopen(file,'r');
[msg,len_total]=fread(f_id,'ubit1'); %һ�ζ�һλ��д�����msg


%�ж�Ƕ����Ϣ���Ƿ����
[m,n]=size(ste_cover);
if len_total>m*n
    error('Ƕ����Ϣ�����������ͼ��');
end

%�ı���Ƕ�����
%p��Ϊ��ϢǶ��λ��������
p=1;
for f2=1:n %MATLAB���ж�ȡ
    for f1=1:m %MATLAB���ж�ȡ
        ste_cover(f1,f2)=ste_cover(f1,f2)-mod(ste_cover(f1,f2),2)+msg(p,1);%���ı���Ϣ���ص�ͼƬ��
          if p==len_total
             break;
          end
          p=p+1;
    end 
    if p==len_total
        break;
    end
end


%������ת��Ϊʮ����
ste_cover=uint8(ste_cover); %8λ�޷�������


%������Ϣ���κ��ͼ��
imwrite(ste_cover,output);

