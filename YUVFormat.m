function [fwidth,fheight]=YUVFormat(format)
    %set factor for UV-sampling
    fwidth = 0.5;
    fheight= 0.5;
    %ע������4�ָ�ʽ�£�ÿ�ָ�ʽ��U��V�ĸ�������ȵ�
    if strcmp(format,'400')
        fwidth = 0;  %U��V�ĸ�����ˮƽ������0
        fheight= 0;  %U��V�ĸ����ڴ�ֱ������0
    elseif strcmp(format,'411')
        fwidth = 0.25;%U��V�ĸ�����ˮƽ������Y������1/4
        fheight= 1;  %U��V�ĸ����ڴ�ֱ�����Y�������
    elseif strcmp(format,'420')
        fwidth = 0.5;%U��V�ĸ�����ˮƽ������Y������1/2
        fheight= 0.5;%U��V�ĸ����ڴ�ֱ������Y������1/2
    elseif strcmp(format,'422')
        fwidth = 0.5;%U��V�ĸ�����ˮƽ������Y������1/2
        fheight= 1;  %U��V�ĸ����ڴ�ֱ�����Y�ĸ������
    elseif strcmp(format,'444')
        fwidth = 1;  %U��V�ĸ�����ˮƽ�����Y�ĸ������
        fheight= 1;  %U��V�ĸ����ڴ�ֱ�����Y�ĸ������
    else
        display('Error: wrong format');
end
