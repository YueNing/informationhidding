% width:ÿһ֡�Ŀ�ȣ� heigth:ÿһ֡�ĸ߶ȣ�  Frame:��ǰload����һ֡��
% filename:�ļ�����    Teil_h:��ֱ����������  Teil_b:ˮƽ��������
% YUV������ֵ������YUV��������һ����ά������U��V�����Ŀ�Ⱥ͸߶������Yһ�����ˣ����UV���������ظ���
% YUV(:,:,1)���Y������YUV(:,:,2)���U������YUV(:,:,3)���V����
% Y,U,V������������ʵ��ֵ����ά����û���ظ������ǵĳ��ȿ��ܲ�һ��
function [YUV,Y,U,V] = loadFileYUV(width,heigth,Frame,fileName,format)
    [Teil_h,Teil_b]=YUVFormat(format);
    % get size of U and V
    fileId = fopen(fileName,'r');
    width_h = width*Teil_b;  %U��V��ʵ�ʿ�ȣ���ע����4�ָ�ʽ�£�ÿ�ָ�ʽ��U��V�ĸ�������ȵ�
    heigth_h = heigth*Teil_h;%U��V��ʵ�ʸ߶ȣ���ע����4�ָ�ʽ�£�ÿ�ָ�ʽ��U��V�ĸ�������ȵ�
    % compute factor for framesize
    factor = 1+(Teil_h*Teil_b)*2;
    % compute framesize
    framesize = width*heigth;
    %��file position indicator��λ����ǰ֡����ʼλ�ã�factor*framesize��һ֡�е��ֽ���
    fseek(fileId,(Frame-1)*factor*framesize, 'bof');
    % create Y-Matrix
    YMatrix = fread(fileId, width * heigth, 'uchar');
    %��һά����YMatrixת����width*heigth�Ķ�ά����Ȼ��ת�ã���int16
    %reshape(x,m,n)�ǰ���������֯�ģ�m��ʾÿ�е�Ԫ�ظ�����n��ʾÿ�е�Ԫ�ظ��������������Ҫת��
    YMatrix = int16(reshape(YMatrix,width,heigth)');
    Y=uint8(YMatrix);
    % create U- and V- Matrix
    if Teil_h == 0
        UMatrix = 0;
        VMatrix = 0;
    else
        %file position indicator�������¶�λ��matlab������
        UMatrix = fread(fileId,width_h * heigth_h, 'uchar');
        UMatrix = int16(UMatrix);
        UMatrix = reshape(UMatrix,width_h, heigth_h).';%U�Ķ�ά����
        U=uint8(UMatrix);
        
        VMatrix = fread(fileId,width_h * heigth_h, 'uchar');
        VMatrix = int16(VMatrix);
        VMatrix = reshape(VMatrix,width_h, heigth_h).'; %V�Ķ�ά����  
        V=uint8(VMatrix);
    end
    % compose the YUV-matrix:��YUV�Ǵ˺����ķ���ֵ,
    % YUV��һ����ά������YUV(:,:,1)���Y,YUV(:,:,2)���U,YUV(:,:,3)���V��
    YUV(1:heigth,1:width,1) = YMatrix;%Y
    
    if Teil_h == 0
        YUV(:,:,2) = 127;%U
        YUV(:,:,3) = 127;%V
    end
    % consideration of the subsampling of U and V
    if Teil_b == 1
        UMatrix1(:,:) = UMatrix(:,:);%UMatrix(:,:)���Ѿ����ļ��ж�������U
        VMatrix1(:,:) = VMatrix(:,:);%VMatrix(:,:)���Ѿ����ļ��ж�������V
    
    elseif Teil_b == 0.5     % heigth_h��UMatrix(:,:)�����ʵ�ʸ߶�  
        UMatrix1(1:heigth_h,1:width) = int16(0);% width��֡�Ŀ�ȣ���Y�Ŀ��һ��
        UMatrix1(1:heigth_h,1:2:end) = UMatrix(:,1:1:end);
        UMatrix1(1:heigth_h,2:2:end) = UMatrix(:,1:1:end);%���ˣ�U1U1U2U2U3U3......��ˮƽ�����ظ�2��
                                                          %      ..................
        VMatrix1(1:heigth_h,1:width) = int16(0);
        VMatrix1(1:heigth_h,1:2:end) = VMatrix(:,1:1:end);
        VMatrix1(1:heigth_h,2:2:end) = VMatrix(:,1:1:end);
    
    elseif Teil_b == 0.25
        UMatrix1(1:heigth_h,1:width) = int16(0);
        UMatrix1(1:heigth_h,1:4:end) = UMatrix(:,1:1:end);
        UMatrix1(1:heigth_h,2:4:end) = UMatrix(:,1:1:end);
        UMatrix1(1:heigth_h,3:4:end) = UMatrix(:,1:1:end);
        UMatrix1(1:heigth_h,4:4:end) = UMatrix(:,1:1:end);%ˮƽ�����ظ�4��
        
        VMatrix1(1:heigth_h,1:width) = int16(0);
        VMatrix1(1:heigth_h,1:4:end) = VMatrix(:,1:1:end);
        VMatrix1(1:heigth_h,2:4:end) = VMatrix(:,1:1:end);
        VMatrix1(1:heigth_h,3:4:end) = VMatrix(:,1:1:end);
        VMatrix1(1:heigth_h,4:4:end) = VMatrix(:,1:1:end);%ˮƽ�����ظ�4��
    end
    
    if Teil_h == 1
        YUV(:,:,2) = UMatrix1(:,:);
        YUV(:,:,3) = VMatrix1(:,:);
        
    elseif Teil_h == 0.5        
        YUV(1:heigth,1:width,2) = int16(0);
        YUV(1:2:end,:,2) = UMatrix1(:,:);
        YUV(2:2:end,:,2) = UMatrix1(:,:);%��ֱ�����ظ�2��
        
        YUV(1:heigth,1:width,3) = int16(0);
        YUV(1:2:end,:,3) = VMatrix1(:,:);
        YUV(2:2:end,:,3) = VMatrix1(:,:);%��ֱ�����ظ�2��
        
    elseif Teil_h == 0.25
        YUV(1:heigth,1:width,2) = int16(0);
        YUV(1:4:end,:,2) = UMatrix1(:,:);
        YUV(2:4:end,:,2) = UMatrix1(:,:);
        YUV(3:4:end,:,2) = UMatrix1(:,:);
        YUV(4:4:end,:,2) = UMatrix1(:,:);%��ֱ�����ظ�4��
        
        YUV(1:heigth,1:width) = int16(0);
        YUV(1:4:end,:,3) = VMatrix1(:,:);
        YUV(2:4:end,:,3) = VMatrix1(:,:);
        YUV(3:4:end,:,3) = VMatrix1(:,:);
        YUV(4:4:end,:,3) = VMatrix1(:,:);%��ֱ�����ظ�4��
    end
    YUV = uint8(YUV);
fclose(fileId);
