clear; clc;
% 主要参数
xmin=-2.5;
xmax=2.5;
ymin=-2.5;
ymax=2.5;
xrange=[xmin,xmax];
yrange=[ymin,ymax];
zx=1000;zy=1000;
Nx=zx;Ny=zy;
Nc=zx*zy;          % 胞的个数
u=4;
h1=(xmax-xmin)/zx;
h2=(ymax-ymin)/zy;
czx=4;czy=4;
Ncc=czx*czy;       % 每个胞内取样点个数
I=zeros(1,Nc+1);   % 像胞个数
C=int32(zeros(Nc+1,Ncc)); % 第i个像胞，行数表示对应所有正规胞编号，列表示胞中选取样本点的编号
P=sparse(Nc+1,Ncc); % 转移概率/sparse全0稀疏矩阵，节省内存
Pmatrix=sparse(Nc+1,Nc+1);%完整的转移概率矩阵，为后面求原像信息准备
Im=zeros(1,Ncc);   % 所有取样点的像胞

%CoreNum=6; %设定机器CPU核心数量,启用并行计算
%if isempty(gcp('nocreate'))
%    parpool(CoreNum);
%end


% 一步转移概率矩阵P
for z=1:Nc+1
   z
     for i=1:Ncc
         B=map(z,i,czx,czy,zx,zy,u,Nc,h1,h2,xmin,xmax,ymin,ymax);Im(i)=B;%B为第z个胞中第i个样本点在固定时长映射下的像，Im暂态储存第z个胞中所有取样点的像
         
     end
     
     
     I(z)=numel(unique(Im));%第z个胞取样点的所有像胞个数
     
     if z == 1
     fimage(1,z)=0;
     else
         fimage(1,z)=fimage(1,z-1)+I(z);
     end
     
     C(z,1:I(z))=unique(Im);%C;(Nc+1)xNcc,每行中行数z代表胞序号，列数代表对应胞中取样点序号
     for i=1:I(z)
         P(z,i)=sum(Im==C(z,i))/Ncc;
     end
     for i=1:I(z)
     Pmatrix(z,C(z,i))=P(z,i);
     end
 end
 %邻接矩阵NCM
 NCM=sparse(zx*zy+1,zx*zy+1);%邻接矩阵初始化，陷胞放在最后一位标号/sparse稀疏矩阵节省内存
 NCM(zx*zy+1,zx*zy+1)=1;%建立陷胞关系
 for i=1:size(C,1)
     for j=1:size(find(C(i,:)>0),2)
         
         NCM(i,C(i,j))=1;
         
     end
 end
  %原像信息
 %preC=zeros(Nc+1,500);
 %preP=zeros(Nc+1,500);
 %for i=1:Nc+1
 %    K=find(Pmatrix(:,i)~=0)';
 %    preC(i,1:size(K,2))=K;
 %    for j=1:size(K,2)
 %    preP(i,j)=Pmatrix(K(1,j),i);
 %    end
 %end
 
 % 寻找强连通分支

C=int32(C);
I=int32(I);
Nc=int32(Nc);
DFN=int32(zeros(Nc+1,1));%用来存放每个顶点被访问的时间
LOW=int32(zeros(Nc+1,1));%用来存放每个顶点所在的强连通分支的根节点的时间
Ncom=int32(0);%强连通子图的个数
stccom=int32(zeros(Nc+1,1));%每个胞所属的强连通子图的编号
stack=int32(zeros(Nc+1,1));%堆栈
isstack=int32(zeros(Nc+1,1));%判断是否在栈中
num=int32(1);%顶点访问顺序
top=int32(0);%栈中元素个数
for i=1:Nc
    if DFN(i,1)==0
        [DFN, LOW, Ncom ,stccom, stack, isstack, num, top]=tarjan(DFN, LOW, Ncom ,stccom, stack, isstack, num, top,i,I,C);%tarjin算法求所有强连通子图
    end
end
%Ncom强联通子图个数=周期解+瞬态胞个数；stccom星形表示每个胞所属的强连通子图的编号
Bcnt=max(stccom);
%强连通子图分类为第一类、第二类、第三类顶点
%第一类为闭的强联通子图表征系统的稳定解；第二类为开的强联通子图表示系统的不稳定解；第三类为瞬态顶点
disp('strongconnect has been searched');
CSC=classifySC(NCM,stccom,Bcnt);%三类顶点分别用正数，负数，零标记
disp('three kinds of strongconnect has been identified');
%将第三类顶点分类
S=stop2SC(NCM,CSC);%驻足
R=SC2routing(NCM,CSC);%路由

n=max(CSC);%第一类强连通子图个数
m=-min(CSC);%第二类强连通子图中鞍点的个数
%出图

%出流型图
h1=figure;
% set(h1,'visible','off')%显示图片太耗内存，保存后再看
hold on 

%稳定流型
for i=1:m
    pos=find(S(n+i,:)==-i-0.1);
    for j=1:length(pos)
        xy=label2cell(pos(j),xrange,yrange,Nx,Ny);
        xcen=(xy(1)+xy(2))/2;
        ycen=(xy(3)+xy(4))/2;
        plot(xcen,ycen,'*b','MarkerSize',1);
    end
end
%不稳定流型
for i=1:m
    pos=find(R(i,:)==-i-0.5);
    for j=1:length(pos)
        xy=label2cell(pos(j),xrange,yrange,Nx,Ny);
        xcen=(xy(1)+xy(2))/2;
        ycen=(xy(3)+xy(4))/2;
        plot(xcen,ycen,'*r','MarkerSize',1);
    end
end
%鞍
for i=1:m
    pos=find(CSC==-i);
    for j=1:length(pos)
        xy=label2cell(pos(j),xrange,yrange,Nx,Ny);
        xcen=(xy(1)+xy(2))/2;
        ycen=(xy(3)+xy(4))/2;
        plot(xcen,ycen,'.k','MarkerSize',20);
    end
end
%吸引子
for i=1:n
    pos=find(CSC==i);
    for j=1:length(pos)
        if pos(j)==Nx*Ny+1%陷胞
            continue;
        end
        xy=label2cell(pos(j),xrange,yrange,Nx,Ny);
        xcen=(xy(1)+xy(2))/2;
        ycen=(xy(3)+xy(4))/2;
        plot(xcen,ycen,'*g','MarkerSize',1);
    end
end
hold off