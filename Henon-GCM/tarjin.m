function [SC,Bcnt] = tarjin(G)
%��DFS-Tarjin�㷨�����ڽӾ����е�ǿ��ͨ��ͼ
%����GΪ�ڽӾ������1by(Nx*Ny+1)�ľ����ǿ��ͨ��ͼ�ĸ�����������ͬǿ��ͨ��ͼ�ı�ʾΪ��ͬ���ֱ��

%��ʼ��
n=size(G,1);
W=G;%���ڼ�¼���Ƿ���ʹ�
point=1;%�ӱ��Ϊ1�ĵ㿪ʼDFS
DFN=zeros(1,n);%����˳��ʱ���
LOW=zeros(1,n);%����ţ�LOW(u)=min(DFN(u),LOW(v),DFN(v))
f=zeros(1,n);%��¼������
stack=zeros(1,n);%ջ
instack=zeros(1,n);%�Ƿ���ջ��
b=sum(sum((W==1)));%������ı���
c=sum(DFN==0);%������Ķ���
d=1;%ѭ���б���
top=1;%ջ�Ķ���λ��
Bcnt=0;%ǿ��ͨ��ͼ�ĸ���
SC=zeros(1,n);%ǿ��ͨ��ͼ�ķֲ�

%DFS-Tarjin�㷨
if b==0&&c==0&&point==1
    d=0;%��ֹѭ��
end

%�ӵ�һ�㿪ʼ��������ʼ��
DFN(point)=1;
numpoint=2;%���ʶ����˳�����
numedge=2;%���ʱߵ�˳�����
stack(top)=point;top=top+1;
instack(point)=1;

while d
    b=sum(sum((W==1)));
    c=sum(DFN==0);
    if b==0&&c==0&&point==1 %��ֹ����
        d=0;
    end
    if isempty(find(SC==0,1))
        return;
    end
    
    a=find(W(point,:)==1);
    if isempty(a)
        if f(point)~=0
            W(f(point),point)=numedge;numedge=numedge+1;
        end
        if LOW(point)==0
            LOW(point)=DFN(point);
        end
        if DFN(point)==LOW(point)&&instack(point)%�ж��Ƿ�Ϊǿ��ͨ��ͼ
            Bcnt=Bcnt+1;
            n=stack(top-1);top=top-1;
            instack(n)=0;%��ջ
            SC(n)=Bcnt;
            while n~=point
                n=stack(top-1);top=top-1;
                instack(n)=0;%��ջ
                SC(n)=Bcnt;
            end
        end
        if f(point)~=0%????
            if LOW(f(point))==0&&isempty(find(W(f(point),:)==1,1))
                LOW(f(point))=min(DFN(f(point)),LOW(point));
            end
        end
        
        %��ջ��Ӧ�ý��븸�������������������1���޸�����2���������Լ�(�ѳ�ջ����3�����������ӣ�����ѭ�����ѳ�ջ��

        if sum(instack)==0&&~isempty(find(SC==0,1))%һ��ʼ�ͽ������ӣ��ѳ�ջ�����
            point=find(SC==0,1);
            DFN(point)=numpoint;
            numpoint=numpoint+1;
            stack(top)=point;top=top+1;
            instack(point)=1;    
        elseif f(point)==0&&~isempty(find(SC==0,1))%�޸������
            temp=point;in=1;
            while temp~=point
                point=find(SC==0,in);
                point=point(in);
                in=in+1;
            end
            DFN(point)=numpoint;
            numpoint=numpoint+1;
            stack(top)=point;top=top+1;
            instack(point)=1;
        elseif f(point)~=0&&~instack(f(point))&&~isempty(find(SC==0,1))%;�н��������ӵ����
            point=stack(top-1);
        else%�������
            point=f(point);
        end
    else
        for i=1:length(a)
            if DFN(a(i))==0%point δ���ʹ�
                DFN(a(i))=numpoint;
                numpoint=numpoint+1;
                W(point,a(i))=numedge;numedge=numedge+1;
                f(a(i))=point;
                point=a(i);
                stack(top)=a(i);top=top+1;
                instack(a(i))=1;
                break;
            elseif DFN(a(i))~=0%point�Ѿ����ʹ�
                W(point,a(i))=numedge;numedge=numedge+1;
                if instack(a(i))&&a(i)~=point%�����
                    if LOW(point)==0%�������
                        LOW(point)=min(DFN(a(i)),DFN(point));
                    elseif LOW(point)~=0%������
                        LOW(point)=min(DFN(a(i)),LOW(point));
                    end
                    if LOW(point)==DFN(point)
                        break;
                    end
                    %������֦��
                    tempf=f(point);
                    temps=point;
                    temped=a(i);
                    while tempf~=0&&tempf~=temped
                        if LOW(tempf)==0%�������
                            LOW(tempf)=min(DFN(tempf),LOW(temps));
                        elseif LOW(tempf)~=0%������
                            LOW(tempf)=min(LOW(tempf),LOW(temps));
                        end
                        if LOW(tempf)==DFN(tempf)
                            break;
                        end
                        temps=tempf;
                        tempf=f(temps);
                    end
                end
                if a(i)~=point&&~instack(a(i))%����¼�Լ����Լ�����������ͺ���ߵ����
                    f(a(i))=point;
                end
            end
        end
    end
end

end

