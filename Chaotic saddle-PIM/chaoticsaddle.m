syms x y
a=1.405;b=-0.3;
%����Henonӳ��
ff1=a-x^2+b*y;
ff2=x;
%����Henonӳ��
fb1=y;
fb2=(x+y^2-a)/b;
%����ϰ�ӳ������ѡ�����ʵ�restraining region R��R����ȥ�����Ӽ���С����
xlimit=[-2.3,2.2];ylimit=[-2.5,3];
%�������ѡ����PIM��Ԫ��
%�������������ѡΪֱ��:x=1;y=[-3,3];
xrange=[-2.3,2.2];
yrange=[2,2];
N=50;%ÿ��ϸ����Ԫ���ȡ�������
xrangenew=xrange;
yrangenew=yrange;
chaoticsaddlepoint=[];%��¼���簰������꣬2�У�ÿ�д���һ����ֵ���簰�������
segmenttrajectory=[];%��¼����ֱ�����Ͼ��ȵ��߶ζ̵����꣬4�У�ÿ�д���һ���߶Σ�12��Ϊ��ʼ�˵ĺ������꣬34��Ϊĩ�˵ĺ�������
%while true
for i=1:1000
    i
linesamplex=linspace(xrangenew(1,1),xrangenew(1,2),N);
linesampley=linspace(yrangenew(1,1),yrangenew(1,2),N);
linesample=[linesamplex;linesampley];%ÿ�д���һ��ȡ����
%����ĳһ��һ��ϸ�������������R��ʱ��
[exittime] = onestep( linesample,N,ff1,ff2,xlimit,ylimit );
maxexittimenum=find(exittime==max(exittime));
if size(maxexittimenum,2)>1
    %disp('please enlarge N');
    %break
    N=N+20;
else
xrangenew=[linesample(1,maxexittimenum-1),linesample(1,maxexittimenum+1)];
yrangenew=[linesample(2,maxexittimenum-1),linesample(2,maxexittimenum+1)];
 if sqrt((xrangenew(1,2)-xrangenew(1,1))^2+(yrangenew(1,2)-yrangenew(1,1))^2)<=(0.1)^4
     chaoticsaddlepoint=[chaoticsaddlepoint,[(xrangenew(1,1)+xrangenew(1,2))/2;(yrangenew(1,1)+yrangenew(1,2))/2]];
     segmenttrajectory=[segmenttrajectory,[xrangenew(1,1);yrangenew(1,1);xrangenew(1,2);yrangenew(1,2)]];
    break 
 end
end
end

%�ѵõ����߶���ǰ������ʼ�ձ�������ڣ�0.1��^8��
N2=0;%��������ϸ��������ÿ����Ԫ�鳤��С�ڣ�0.1��^8
startpoint=segmenttrajectory(1:2,1);startpointcopy=startpoint;
endpoint=segmenttrajectory(3:4,1);endpointcopy=endpoint;
for i=1:999
    i
    startpoint(1,1)=double(subs(ff1,[x,y],[startpointcopy(1,1),startpointcopy(2,1)]));
    startpoint(2,1)=double(subs(ff2,[x,y],[startpointcopy(1,1),startpointcopy(2,1)]));
    startpointcopy=startpoint;
    endpoint(1,1)=double(subs(ff1,[x,y],[endpointcopy(1,1),endpointcopy(2,1)]));
    endpoint(2,1)=double(subs(ff2,[x,y],[endpointcopy(1,1),endpointcopy(2,1)]));
    endpointcopy=endpoint;
    linelength=sqrt((startpoint(1,1)-endpoint(1,1))^2+(startpoint(2,1)-endpoint(2,1))^2);
    if linelength<=(0.1)^4
        segmenttrajectory=[segmenttrajectory,[startpoint;endpoint]];
        chaoticsaddlepoint=[chaoticsaddlepoint,[(startpoint(1,1)+endpoint(1,1))/2;(startpoint(2,1)+endpoint(2,1))/2]];
    else
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      N2=ceil(linelength*(10)^4)+100;
      linesamplex=linspace(startpoint(1,1),endpoint(1,1),N2);
      linesampley=linspace(startpoint(2,1),endpoint(2,1),N2);
      linesample=[linesamplex;linesampley];%ÿ�д���һ��ȡ����
      [exittime] = onestep( linesample,N2,ff1,ff2,xlimit,ylimit );
      maxexittimenum=find(exittime==max(exittime));
      
      if maxexittimenum(1,1)==1
      leftnum=1;
      else
      leftnum=maxexittimenum(1,1)-1;
      end
      
      if maxexittimenum(1,size(maxexittimenum,2))==N2
      rightnum=N2;
      else
      rightnum=maxexittimenum(1,size(maxexittimenum,2))+1;
      end
      
      chaoticsaddlepoint=[chaoticsaddlepoint,[(linesample(1,leftnum)+linesample(1,leftnum))/2;(linesample(2,leftnum)+linesample(2,leftnum))/2]];
      segmenttrajectory=[segmenttrajectory,[linesample(:,leftnum);linesample(:,rightnum)]];
      startpoint=linesample(:,leftnum);
      startpointcopy=startpoint;
      endpoint=linesample(:,rightnum);
      endpointcopy=endpoint;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
    end
end
plot(chaoticsaddlepoint(1,:),chaoticsaddlepoint(2,:),'.','MarkerSize',3)