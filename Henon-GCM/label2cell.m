function cell = label2cell(label,xrange,yrange,Nx,Ny)
%����һ����ţ�������ֵ���Ϣ�����ظñ�Ŵ���İ��ķ�Χ
%labelΪ����ı�ţ����������ݰ����
%xrange��yrange��Nx,NyΪ��������Ϣ
%cell=[xmin,xmax,ymin,ymax]��Ϊ�ð��ķ�Χ

i=floor(label/Nx);
j=mod(label,Nx);

dx=(xrange(2)-xrange(1))/Nx;
dy=(yrange(2)-yrange(1))/Ny;

if j==0
    cell=[xrange(2)-dx,xrange(2),yrange(1)+(i-1)*dy,yrange(1)+i*dy];
else
    cell=[xrange(1)+(j-1)*dx,xrange(1)+j*dx,yrange(1)+i*dy,yrange(1)+(i+1)*dy];
end

%˵��������ŵĹ��򣺴�����ϵ���½�һ��һ����������������������

end

