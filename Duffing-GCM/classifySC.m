function CSC = classifySC(G,SC,Bcnt)
%�򵥵Ľ�ǿ��ͨ���Ϊ��һ�ࡢ�ڶ��ࡢ�����ඥ��
%   �����һ�ࡢ�ڶ��ࡢ�����ඥ��ֱ���������������0��ǣ���ͬ�������ͬһ�鶥��
%   ����GΪ�ڽӾ���SCΪǿ��ͨ���Ǿ���BcntΪǿ��ͨ�����

cnt1=1;%�������ϵı����
cnt2=-1;
cnt3=0;
n=size(G,1);
CSC=zeros(1,n);%��ʼ��

for i=1:Bcnt
    label=0;%���
    a=find(SC==i);
    if length(a)==1
        b=find(G((a),:)==1);
        if isempty(b)
            CSC(a)=cnt1;
            cnt1=cnt1+1;
        elseif ~isempty(find(b==a,1))&&length(b)==1
            CSC(a)=cnt1;
            cnt1=cnt1+1;
        elseif ~isempty(find(b==a,1))&&length(b)~=1
            CSC(a)=cnt2;
            cnt2=cnt2-1;
        else 
            continue;
        end
        continue;
    end
    for j=1:length(a)
        b=find(G(a(j),:)==1);
        for k=1:length(b)
            if SC(b(k))~=i
                label=1;
                break;
            end
        end
        if label==1
            CSC(a)=cnt2;
            cnt2=cnt2-1;
            break;
        end
    end
    if label==0
        CSC(a)=cnt1;
        cnt1=cnt1+1;
    end
end

end

