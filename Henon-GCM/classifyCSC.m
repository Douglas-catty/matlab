function CCSC = classifyCSC(G,CSC)
%   ���ڶ��ඥ���Ϊ����Ͳ��ȶ���
%   ������Ϊ���������ȶ�����Ϊ0������û�з��������ȶ���
%   ����GΪ�ڽӾ���SCΪǿ��ͨ���Ǿ���BcntΪǿ��ͨ�����

cntsa=-1;
cntus=0;
m=-min(CSC);
n=size(G,1);
CCSC=CSC;%��ʼ��

for i=1:m
    label=0;%���
    a=find(CCSC==-i);
    for j=1:length(a)
        b=find(G(:,a(j))==1);
        for k=1:length(b)
            if CCSC(b(k))~=-i
                label=1;
                break;
            end
        end
        if label==1
            CCSC(a)=cntsa;
            cntsa=cntsa-1;
            break;
        end
    end
    if label==0
        CCSC(a)=cntus;
%         cntus=cntus+1;
    end
end

end

