function label_old= labelnew2labelold(label_new,Gama,Nn)
%LABELOLD2LABELNEW �Ե���ϸ�ֺ�ı�ŵ���
%   label_old Ϊϸ��ǰ�ı��
%   label_new Ϊϸ�ֺ�ı��
%   GamaΪ��Ҫϸ���İ��ı�ţ�NnΪϸ���̶�

n=sum(Gama);

if label_new<=n*Nn*Nn%ϸ�����еİ�
    sort=ceil(label_new/Nn/Nn);
    label_old=find(Gama==1);
    label_old=label_old(sort);
else %��ϸ����
    sort=label_new-n*Nn*Nn+n;%�ű�ŵ�˳��
    label_old=find(Gama==0);
    label_old=label_old(sort-n);
end
    

end

