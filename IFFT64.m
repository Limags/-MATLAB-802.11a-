function  time_syms= IFFT64(mod_ofdm_syms)

%IFFT64���ź���Ƶ��任��ʱ��
UsedSubcIdx=[7:32 34:59]';%ʹ�õ����ز�����
NumSubc=52;%���ز���

%OFDM������
num_symbols =size(mod_ofdm_syms, 2)/NumSubc;

%�����ݼӵ���Ӧ���ز��ϣ�����δʹ�õ����ز��ϲ�0
syms_into_ifft = zeros(64, num_symbols);
syms_into_ifft(UsedSubcIdx,:) = reshape(mod_ofdm_syms(:),NumSubc, num_symbols); %�����任
 
%����λ���û�
resample_patt=[33:64 1:32];
syms_into_ifft(resample_patt,:) = syms_into_ifft;
   
% �任��ʱ��
time_syms = zeros(1,num_symbols*64);%��ʼ��time_syms
ifft_out = ifft(syms_into_ifft);
time_syms(1,:) = ifft_out(:).';

