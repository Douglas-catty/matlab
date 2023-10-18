function y=poincare_Duffing(dt,zeta,w0,h,wf,D,initial,N)
%ģ��I. A. Khovanov 08�������е�Duffing����ϵͳ
%deltaΪ���㲽����zetaΪ���ᣬw0Ϊ�նȲ�����hΪ��г������ֵ��wfΪ��Ъ����Ƶ�ʣ�DΪ������ǿ�Ȳ�����NΪ������
T=2*pi/wf;%����
n=T/dt;%һ���ڵ�����(��ñ�֤Ϊ������

for i=1:n
    winc=sqrt(dt)*randn(N,1);
    initial(:,1)=initial(:,1)+initial(:,2)*dt;
    initial(:,2)=initial(:,2)+(-2*zeta*initial(:,2)-w0^2*initial(:,1)-initial(:,1).^2-initial(:,1).^3+h*sin(wf*i*dt))*dt+sqrt(D)*winc;
end
y=initial;

end
