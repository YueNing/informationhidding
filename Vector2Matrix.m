function A=Vector2Matrix(oi,row)
%������ת���ɶ�λ����,rowΪ����
cl=length(oi)/row;
A=zeros(row,cl);
for i=1:row
    for j=1:cl
        A(i,j)=oi(cl*(i-1)+j);
    end
end