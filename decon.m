function Temp = decon( code )
trellis = poly2trellis(7, [133 171]); %��������������ı�ʾ����
tblen = 6;
Temp = vitdec(code, trellis, tblen, 'trunc', 'hard' );
end

