function mod_ofdm_syms = Add_Pilot(mod_syms)

PilotScramble=[1 1 1 1 -1 -1 -1 1 -1 -1 -1 -1 1 1 -1 1 -1 -1 1 1 -1 1 1 -1 1 1 1 1 ...
      1 1 -1 1 1 1 -1 1 1 -1 -1 1 1 1 -1 1 -1 -1 -1 1 -1 1 -1 -1 1 -1 -1 1 1 1 1 1 -1 -1 1 ...
      1 -1 -1 1 -1 1 -1 1 1 -1 -1 -1 1 1 -1 -1 -1 -1 1 -1 -1 1 -1 1 1 1 1 -1 1 -1 1 -1 1 -1 ...
      -1 -1 -1 -1 1 -1 1 1 -1 1 -1 1 1 1 -1 -1 1 -1 -1 -1 1 1 1 -1 -1 -1 -1 -1 -1 -1];%Pilot��������
NumDataSubc=48;% �������ز���
NumSubc=52;%���ز���
DataSubcPatt=[1:5 7:19 21:26 27:32 34:46 48:52]';%�������ز���λ��
PilotSubcPatt=[6 20 33 47]';%��Ƶ���ز���λ��
NumPilotSubc=4;% ��Ƶ���ز���
PilotSubcSymbols=[1;1;1;-1];%��Ƶ���ز��ķ���

n_mod_syms = size(mod_syms,2);%���͵�ӳ����Ʒ�����
n_ofdm_syms = ceil(n_mod_syms/NumDataSubc);%���͵�OFDM������
mod_syms=[mod_syms zeros(1,n_ofdm_syms*NumDataSubc-n_mod_syms)];

%pilot scrambling pattern
scramble_patt = repmat(PilotScramble,1,ceil(n_ofdm_syms/length(PilotScramble)));%�ظ���Ƶ���룬ʹ���䳤��������OFDM������һ��
scramble_patt = scramble_patt(1:n_ofdm_syms);%��ȡ��OFDM����������Ƶ��������

mod_ofdm_syms = zeros(NumSubc, n_ofdm_syms);
mod_ofdm_syms(DataSubcPatt,:) = reshape(mod_syms, NumDataSubc, n_ofdm_syms);%��ӳ����Ʒ���mod_syms���������NumDataSubc���������ز���

%����Ƶ���ز��������н�������������Ӧ��Ƶ���ز�λ����
mod_ofdm_syms(PilotSubcPatt,:) = repmat(scramble_patt, NumPilotSubc,1).*repmat(PilotSubcSymbols, 1, n_ofdm_syms);
%��Ƶ�������������
mod_ofdm_syms = mod_ofdm_syms(:).';
