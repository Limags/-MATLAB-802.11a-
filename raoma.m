function R=raoma(input)%���庯��
S = [1, 1, 1, 1, 1, 1, 1];%��ʼ״̬
L = zeros(1, 127);%127�������У�zeros�����Ƿ���һ��m��n��p��...��double�������
F = zeros(1, length(input));%�������ݳ���
 for i = 1:127
    A = S(1, 1);
    B = S(1, 4);
    C = xor(A, B);%����λ�Ĵ���4��7���
    S =[ S(2:7), C];% ����һλ  
    S(1, 7) = C;
    L(1,i) = C;%��������
 end
L_copy = repmat(L, 1, ceil(length(input) / length(L)));%������ L���� 1��c��(ceil���ش��ڵ��ڱ��ʽ����С���� )
L_num = L_copy(1: length(input));%���������ݵĳ��Ⱥ��������г���ƥ��

F= xor(L_num, input);%���������ݺ͸ı䳤�Ⱥ�������������
   
R =  F;%���ź����������