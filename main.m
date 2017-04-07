function main()
Ncbps = 192;
Nbpsc = 4;
%RATE=[1 1 0 1];                 % 6Mbps����
RATE=[1 0 0 1];                    %24Mbps
Pad_Bits =[];
Tail=zeros(1,6);
SERVICE = zeros(1, 16);
PSDU = randi([0 1], 3000, 1)';   %ԭʼ����
len_psdu = length(PSDU);        %���ݳ���
DATA = [SERVICE PSDU Tail Pad_Bits];

S_DATA = raoma(DATA); %����

SIGNAL_DATA = xinyuan(len_psdu, S_DATA, RATE); %��Դ

con = convolutionNew(SIGNAL_DATA);%���

[INTER, ZEROS] = jiaozhi(con, Ncbps, Nbpsc); %��֯
%SIGNAL_DATA = bpsk(INTER); %ӳ��
SIGNAL_DATA = QAM(INTER); %QAM

P_SIGNAL_DATA = Add_Pilot(SIGNAL_DATA); %��ӵ�Ƶ

IF_SIGNAL_DATA = IFFT64(P_SIGNAL_DATA); %OFDM����

ACP_SIGNAL_DATA = Add_CP(IF_SIGNAL_DATA); %���CP

preamb = qiandaoma(); %ǰ����

PPDU = [preamb ACP_SIGNAL_DATA]; %PPDU

N_PPDU = awgn(PPDU, 20.0);     %��˹����
[~, freq_data_syms, ~] = FFT64(N_PPDU);  %OFDM���
freq_data_syms = freq_data_syms * (64/sqrt(52));

%NDBSK_DATA = dbpsk(freq_data_syms); %��ӳ��
NDBSK_DATA = D16QAM(freq_data_syms);

d = jiejiaozhi(NDBSK_DATA, ZEROS, Ncbps, Nbpsc);  %�⽻֯

s = decon(d);     %����

s([1 1:24]) = [];   %ɾ��signal

rm = raoma(s);   %������

XOR = xor(rm, DATA); %���
ONES = numel(find(XOR == 1)); %�ҳ��������1�ĸ���
ERRORS = ONES / len_psdu * 100


