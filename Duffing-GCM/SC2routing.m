function y= SC2routing(G,CSC)
%�ҵ��Եڶ��ඥ��Ϊ·�ɵĵ����ඥ��
%���yΪ��CSC���ԼǺ�Ϊn�ĵڶ��ඥ��Ϊ·�ɵĵ����ඥ��ı��Ϊn.5

m=-min(CSC);%���ȶ�ǿ��ͨ��ͼ����
%��ʼ��
y=zeros(m,size(G,1));
for i=1:m
    y(i,:)=CSC;
end
temp=zeros(1,size(G,1));%��ʱ��¼����

for i=1:m
    a=find(CSC==-i);
    while ~isempty(a)
        for j=1:length(a)
            b=find(G(a(j),:)==1);
            for k=1:length(b)
                if y(i,b(k))~=0;
                    continue;
                elseif y(i,b(k))==0
                    y(i,b(k))=-i-0.5;
                    temp(b(k))=1;
                end
            end
        end
        a=find(temp==1);
        temp=zeros(1,size(G,1));
    end
end


end

