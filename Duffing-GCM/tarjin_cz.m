function tarjin_cz(label,I,C)
%����targin�㷨������ͼ��ǿ��ͨ��ͼ�������C����һ���ڽӽṹ��ÿһ�ж���ÿ��������ڽӱ�

global DFN LOW Ncom stccom stack isstack num top
DFN(label,1)=num;
LOW(label,1)=num;
num=num+1;
top=top+1;
stack(top,1)=label;%����ջ��
isstack(label,1)=1;%����ջ��

for i=1:I(label,1)
    w=C(label,i);
    if DFN(w,1)==0 %��label�ĵ�i������δ���ʹ���
        tarjin_cz(w,I,C);%�ݹ����tarjin
        LOW(label,1)=min(LOW(label,1),LOW(w,1));
    elseif DFN(w,1)<DFN(label,1)
        if isstack(w,1)==1%��label�ĵ�i�����Ƿ��ʹ�������ջ��
            LOW(label,1)=min(LOW(label,1),DFN(w,1));
        end
    end
end

if LOW(label,1)==DFN(label,1)
    Ncom=Ncom+1;%�ҵ�һ���µ�ǿ��ͨ��ͼ
    while 1
%         top=top-1;
        j=stack(top,1);
        stccom(j,1)=Ncom;
        stack(top,1)=0;%Ԫ�س�ջ
        isstack(j,1)=0;%Ԫ�س�ջ
        top=top-1;%ջ��Ԫ�ؼ���һ��
        if j==label||top<=0
            break;
        end
    end
end

    
        



