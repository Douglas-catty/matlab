function label_new= labelold2labelnew(label_old,Gama,Nn)
%LABELOLD2LABELNEW �Ե���ϸ�ֺ�ı�ŵ���
%   label_old Ϊϸ��ǰ�ı��
%   label_new Ϊϸ�ֺ�ı�ţ����label_oldΪϸ�ְ��������label_newΪold������С�ı��
%   GamaΪ��Ҫϸ���İ��ı�ţ�NnΪϸ���̶�

sort=sortold(label_old,Gama);%����˳��
n=sum(Gama);

if sort<=n%label_old��ϸ����
    label_new=(sort-1)*Nn*Nn+1;
else %label_old��ϸ����
    pos=Gama==0;
    label_new=n*Nn*Nn+sum(pos(1:label_old));
end

end

