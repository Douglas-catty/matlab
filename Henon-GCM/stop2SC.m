function  y= stop2SC(G,CSC)
%�ҵ��Ե�һ��ڶ��ඥ��Ϊפ��ĵ����ඥ��
%���yΪ��CSC���ԼǺ�Ϊn�ĵ�һ���ڶ��ඥ��Ϊפ��ĵ����ඥ��ı��Ϊn.1

n=max(CSC);%�ȶ�ǿ��ͨ��ͼ����
m=-min(CSC);%���ȶ�ǿ��ͨ��ͼ����
%��ʼ��
y=zeros(n+m,size(G,1));
for i=1:n+m
    y(i,:)=CSC;
end
temp=zeros(1,size(G,1));%��ʱ��¼����

%�����һ�ඥ���פ��
for i=1:n
    a=find(CSC==i);
    while ~isempty(a)
        for j=1:length(a)
            b=find(G(:,a(j))==1);
            for k=1:length(b)
                if y(i,b(k))~=0;
                    continue;
                elseif y(i,b(k))==0
                    y(i,b(k))=i+0.1;
                    temp(b(k))=1;
                end
            end
        end
        a=find(temp==1);
        temp=zeros(1,size(G,1));
    end
end

%����ڶ��ඥ��
for i=1:m
    a=find(CSC==-i);
    while ~isempty(a)
        for j=1:length(a)
            b=find(G(:,a(j))==1);
            for k=1:length(b)
                if y(n+i,b(k))~=0;
                    continue;
                elseif y(n+i,b(k))==0
                    y(n+i,b(k))=-i-0.1;
                    temp(b(k))=1;
                end
            end
        end
        a=find(temp==1);
        temp=zeros(1,size(G,1));
    end
end

end

