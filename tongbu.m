function p = tongbu(data,preamble)
b=0;
d=preamble;
p=[];
for i=1:200
    a=abs(dot(data(i:i+15),d(1:16)));%dot����˼data(i:i+15)�Ĺ���ת�ó���d(1:16)
    if a>0.1%���ֵ
        b=b+1;
        if b==10
            v = i - 144;
            length(data);
            p=data(v : length(data));
        elseif b~=10&&i==200
            disp('�����̫С��ʧȥͬ����Ϣ')
            break;
        end
    end
end
