%�������ܱ������������ȡ������LSB�ϵ�������Ϣ
%�����ʽ����:result=lsbget('LSBcover.bmp',320,'secret.txt')
%����˵��:
%output����Ϣ���غ��ͼ��
%len_total��������Ϣ�ĳ���
%goalfile����ȡ����������Ϣ�ļ�
%result����ȡ����Ϣ


function result=lsbget(output,len_total,goalfile)
ste_cover=imread(output);
ste_cover=double(ste_cover);


%�ж�Ƕ����Ϣ���Ƿ����
[m,n]=size(ste_cover);
frr=fopen(goalfile,'a');


%p��Ϊ��ϢǶ��λ��������,����Ϣ����д���ı��ļ�
p=1;
for f2=1:n
    for f1=1:m
          if bitand(ste_cover(f1,f2),1)==1%�õ�ͼ���������һλΪ�ı�����Ϣ����Ϊͼ���������8Ϊһ���壬�����һ�е�һ��Ϊ8λ�����ݣ�
              fwrite(frr,1,'ubit1');
              result(p,1)=1;
          else
              fwrite(frr,0,'ubit1');
              result(p,1)=0;
          end 
          
          if p==len_total
               break;
          end
          
          p=p+1;
    end
          if p==len_total 
              break;
          end    
end  
fclose(frr);
  