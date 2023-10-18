
clear; clc;
% ��Ҫ����
xmin=-1.8;
xmax=1.8;
ymin=-1.2;
ymax=1.2;
%%Duffing����
%��Ӧ�ˣ�x'=y;y'=-2*gamma*y-x+x^3+A*cos(omiga*t);
A=0.07;%���ڼ�����ֵ

omiga=1.7;%���ڼ���Ƶ��

gamma=0.01;%��ɢϵ��

%%%%
nn=600;
T=2*pi/omiga;
h=T/nn;%rk4���ֲ���
%%%%
xrange=[xmin,xmax];
yrange=[ymin,ymax];
zx=300;zy=300;
Nx=zx;Ny=zy;
Nc=zx*zy;          % ���ĸ���
h1=(xmax-xmin)/zx;
h2=(ymax-ymin)/zy;
u=4;
czx=u;czy=u;
Ncc=czx*czy;       % ÿ������ȡ�������
I=zeros(1,Nc+1);   % �������
C=int32(zeros(Nc+1,Ncc)); % ��i�������������ʾ��Ӧ�����������ţ��б�ʾ����ѡȡ������ı��
P=sparse(Nc+1,Ncc); % ת�Ƹ���/sparseȫ0ϡ����󣬽�ʡ�ڴ�
Pmatrix=sparse(Nc+1,Nc+1);%������ת�Ƹ��ʾ���Ϊ������ԭ����Ϣ׼��
Im=zeros(1,Ncc);   % ����ȡ��������
Ns=u;
sample=zeros(Ns*Ns,2);%���ÿ������������
labels=zeros(Ns*Ns,1);%���ÿ��������ı��
% һ��ת�Ƹ��ʾ���P
 for z=1:Nc+1
   [z,Nc+1]
     for i=1:Ncc
         %B=map(z,i,czx,czy,zx,zy,u,Nc,h1,h2,xmin,xmax,ymin,ymax,AA,BB);Im(i)=B;%BΪ��z�����е�i���������ڹ̶�ʱ��ӳ���µ���Im��̬�����z����������ȡ�������
         B=mapDuffing(z,i,czx,czy,zx,zy,u,Nc,h1,h2,xmin,xmax,ymin,ymax,A,omiga,gamma,h,nn);Im(i)=B;
     end
     
     
     I(z)=numel(unique(Im));%��z����ȡ����������������
     
     if z == 1
     fimage(1,z)=0;
     else
         fimage(1,z)=fimage(1,z-1)+I(z);
     end
     
     C(z,1:I(z))=unique(Im);%C;(Nc+1)xNcc,ÿ��������z�������ţ����������Ӧ����ȡ�������
     for i=1:I(z)
         P(z,i)=sum(Im==C(z,i))/Ncc;
     end
     for i=1:I(z)
     Pmatrix(z,C(z,i))=P(z,i);
     end
 end
 %�ڽӾ���NCM
 NCM=sparse(zx*zy+1,zx*zy+1);%�ڽӾ����ʼ�����ݰ��������һλ���/sparseϡ������ʡ�ڴ�
 NCM(zx*zy+1,zx*zy+1)=1;%�����ݰ���ϵ
 for i=1:size(C,1)
     for j=1:size(find(C(i,:)>0),2)
         
         NCM(i,C(i,j))=1;
         
     end
 end
 save('A=0.07omiga=1.7gamma=0.07.mat')
  %ԭ����Ϣ
 %preC=zeros(Nc+1,500);
 %preP=zeros(Nc+1,500);
 %for i=1:Nc+1
 %    K=find(Pmatrix(:,i)~=0)';
 %    preC(i,1:size(K,2))=K;
 %    for j=1:size(K,2)
 %    preP(i,j)=Pmatrix(K(1,j),i);
 %    end
 %end
 
 % Ѱ��ǿ��ͨ��֧

C=int32(C);
I=int32(I);
Nc=int32(Nc);
DFN=int32(zeros(Nc+1,1));%�������ÿ�����㱻���ʵ�ʱ��
LOW=int32(zeros(Nc+1,1));%�������ÿ���������ڵ�ǿ��ͨ��֧�ĸ��ڵ��ʱ��
Ncom=int32(0);%ǿ��ͨ��ͼ�ĸ���
stccom=int32(zeros(Nc+1,1));%ÿ����������ǿ��ͨ��ͼ�ı��
stack=int32(zeros(Nc+1,1));%��ջ
isstack=int32(zeros(Nc+1,1));%�ж��Ƿ���ջ��
num=int32(1);%�������˳��
top=int32(0);%ջ��Ԫ�ظ���
for i=1:Nc
    if DFN(i,1)==0
        [DFN, LOW, Ncom ,stccom, stack, isstack, num, top]=tarjan(DFN, LOW, Ncom ,stccom, stack, isstack, num, top,i,I,C);%tarjin�㷨������ǿ��ͨ��ͼ
    end
end
%Ncomǿ��ͨ��ͼ����=���ڽ�+˲̬��������stccom���α�ʾÿ����������ǿ��ͨ��ͼ�ı��
Bcnt=max(stccom);
%ǿ��ͨ��ͼ����Ϊ��һ�ࡢ�ڶ��ࡢ�����ඥ��
%��һ��Ϊ�յ�ǿ��ͨ��ͼ����ϵͳ���ȶ��⣻�ڶ���Ϊ����ǿ��ͨ��ͼ��ʾϵͳ�Ĳ��ȶ��⣻������Ϊ˲̬����
CSC=classifySC(NCM,stccom,Bcnt);%���ඥ��ֱ�������������������

%�������ඥ�����
S=stop2SC(NCM,CSC);%פ��
R=SC2routing(NCM,CSC);%·��

n=max(CSC);%��һ��ǿ��ͨ��ͼ������n=1��ʾ���Ϊ���һλ���ݰ�
m=-min(CSC);%�ڶ���ǿ��ͨ��ͼ�а���ĸ���
%��ͼ

%������ͼ
h1=figure;
% set(h1,'visible','off')%��ʾͼƬ̫���ڴ棬������ٿ�
set(0,'defaultfigurecolor','w')
hold on 

%�ȶ�����
stablemanifold=[];
stablemanifoldnumber=[];
for i=1:m
    pos1=find(S(n+i,:)==-i-0.1);
    stablemanifoldnumber=[stablemanifoldnumber,pos1];
    for j=1:length(pos1)
        xy=label2cell(pos1(j),xrange,yrange,Nx,Ny);
        xcen=(xy(1)+xy(2))/2;
        ycen=(xy(3)+xy(4))/2;
        stablemanifold=[stablemanifold,[xcen;ycen]];
        
    end
    plot(stablemanifold(1,:),stablemanifold(2,:),'*b','MarkerSize',0.5);
end
%���ȶ�����
unstablemanifold=[];
unstablemanifoldnumber=[];
for i=1:m
    pos2=find(R(i,:)==-i-0.5);
    unstablemanifoldnumber=[unstablemanifoldnumber,pos2];
    for j=1:length(pos2)
        xy=label2cell(pos2(j),xrange,yrange,Nx,Ny);
        xcen=(xy(1)+xy(2))/2;
        ycen=(xy(3)+xy(4))/2;
        unstablemanifold=[unstablemanifold,[xcen;ycen]];
        
    end
    plot(unstablemanifold(1,:),unstablemanifold(2,:),'*r','MarkerSize',1);
end
%plot([1,-1],[0,0],'go','MarkerFaceColor','g');plot([0],[0],'ko','MarkerFaceColor','k');
%��
saddlepoint=[];
saddlepointnumber=[];
for i=1:m
    pos3=find(CSC==-i);
    saddlepointnumber=[saddlepointnumber,pos3];
    for j=1:length(pos3)
        xy=label2cell(pos3(j),xrange,yrange,Nx,Ny);
        xcen=(xy(1)+xy(2))/2;
        ycen=(xy(3)+xy(4))/2;
        saddlepoint=[saddlepoint,[xcen;ycen]];
        
    end
    plot(saddlepoint(1,:),saddlepoint(2,:),'^y','MarkerSize',10,'MarkerFaceColor','y');
end
%������
attractor=[];
attractornumber=[];
for i=1:n
    pos4=find(CSC==i);
    %i=1�����Ӧפ��
    if i~=1
    attractornumber=[attractornumber,pos4];
    end
    for j=1:length(pos4)
        if pos4(j)==Nx*Ny+1%�ݰ�
            continue;
        end
        xy=label2cell(pos4(j),xrange,yrange,Nx,Ny);
        xcen=(xy(1)+xy(2))/2;
        ycen=(xy(3)+xy(4))/2;
        attractor=[attractor,[xcen;ycen]];
        
    end
    if i~=1
    plot(attractor(1,:),attractor(2,:),'*g','MarkerSize',3);
    end
end
xlim([xmin xmax]);
ylim([ymin ymax]);
hold off

%%save('AA=1.1BB=-0.3.mat','zx','zy','attractor','attractornumber','saddlepoint','saddlepointnumber','stablemanifold','stablemanifoldnumber','unstablemanifold','unstablemanifoldnumber','attractordomain','attractordomainnumber','AA','BB','xmin','xmax','ymin','ymax')%����ȫ�����ݹ�actionplotѡ����ʼ��

 %��������������ͼ
 h2=figure;
 hold on;

 %������
 attractordomain=[];
 attractordomainnumber=[];
 for i=1:n
     if find(CSC==i)==Nx*Ny+1%�ݰ�
         continue;
     end
     pos6=find(S(i,:)==i+0.1);
     attractordomainnumber=[attractordomainnumber,pos6];
     for j=1:length(pos6)
         xy=label2cell(pos6(j),xrange,yrange,Nx,Ny);
         xcen=(xy(1)+xy(2))/2;
         ycen=(xy(3)+xy(4))/2;
         %plot(xcen,ycen,'*','MarkerSize',6);
         attractordomain=[attractordomain,[xcen;ycen]];
     end
     plot(attractordomain(1,:),attractordomain(2,:),'*','MarkerSize',0.5);
 end
 
  %������
 for i=1:n
     pos5=find(CSC==i);
     for j=1:length(pos5)
         if pos5(j)==Nx*Ny+1%�ݰ�
             continue;
         end
         xy=label2cell(pos5(j),xrange,yrange,Nx,Ny);
         xcen=(xy(1)+xy(2))/2;
         ycen=(xy(3)+xy(4))/2;
         plot(xcen,ycen,'^g','MarkerSize',6);
     end
 end
 hold off

 
