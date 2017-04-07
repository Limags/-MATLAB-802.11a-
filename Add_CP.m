function time_signal = Add_CP(time_syms)

num_symbols = size(time_syms, 2)/64;%��Ҫ����ķ�������ÿ������64������Ԫ��
time_signal = zeros(1, num_symbols*80);%����ʱ���źŵĳ�ʼ״̬��

% ����ѭ��ǰ׺
symbols = reshape(time_syms(:), 64, num_symbols);
tmp_syms = [symbols(49:64,:); symbols]; 
tmp_syms(1,:)=tmp_syms(1,:)*0.5;%�Է��ŵ���β���мӴ�����
tmp_syms_end(1,:)=symbols(1,:)*0.5;

tmp_syms(1,2:num_symbols)=tmp_syms(1,2:num_symbols)+tmp_syms_end(1:num_symbols-1);
time_signal(:) = tmp_syms(:).';