function A=map(B,n,czx,czy,zx,zy,u,Nc,h1,h2,xmin,xmax,ymin,ymax,AA,BB)
if B==Nc+1
    A=Nc+1;
    %�ݰ������һλ
else x1=h1*mod(B-1,zx)+xmin+(h1/czx)*(mod(n-1,czx)+0.5);%mod(A,B),��A��B��������floor����ȡ������ʮ��ȡ����������
    y1=h2*(floor(B/zx)-(mod(B,zx)==0))+ymin+(h2/czy)*(floor(n/czx)-(mod(n,czx)==0)+0.5);
    %X=[x1 y1]';
    %f=@(t,x)[x(2);-25*x(1)^3-0.173*x(2)-2.62*x(1)+0.456*u*(1-cos(2*t))*x(1)+0.92*u*(1-cos(2*t))];
    %[~,M]=ode45(f,[0,pi],X);
    %X=M(length(M(:,1)),:)';
    
   
        X=AA-x1*x1+BB*y1;
        Y=x1;
    
    %if (X(1)>=xmin)&&(X(1)<xmax)&&(X(2)>=ymin)&&(X(2)<ymax)
    if (X>=xmin)&&(X<xmax)&&(Y>=ymin)&&(Y<ymax)
        A=zx*floor((Y-ymin)/h2)+floor((X-xmin)/h1+1);%�����Ķ�˳���µİ����
    else A=Nc+1;
    end
end