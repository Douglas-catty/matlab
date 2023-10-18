function label = cell2label(point,xrange,yrange,Nx,Ny)
%����һ���λ�ã�������ֵ���Ϣ�����ظõ������İ����
%pointΪ��������Ϣ
%xrange��yrange��Nx,NyΪ��������Ϣ
%labelΪ�õ��������ı��,���һ����ʾ�ݰ�

dx=(xrange(2)-xrange(1))/Nx;
dy=(yrange(2)-yrange(1))/Ny;

if point(1)<xrange(1)||point(1)>xrange(2)||point(2)<yrange(1)||point(2)>yrange(2)
    label=Nx*Ny+1;
else
    for i=1:Nx
        if point(1)<xrange(1)+i*dx
            break;
        end
    end
    for j=1:Ny
        if point(2)<yrange(1)+j*dy
            break;
        end
    end
    
    label=Nx*(j-1)+i;
end

end

