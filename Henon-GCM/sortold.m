function sort= sortold(label_old,Gama)
%SORTOLD �ϱ�ŵ����±��˳��
%   label_old �ϱ��
%   Gama��Ҫϸ���ı��
%   ˵��˳��������Ҫϸ���İ������Ų���Ҫϸ���İ�

n=sum(Gama);%��Ҫϸ���İ�������

if Gama(label_old)==0%��ϸ����
    pos=Gama==0;
    sort=n+sum(pos(1:label_old));
else %ϸ����
    sort=sum(Gama(1:label_old));
end

end

