function cell_new= label2cellnew(label_new,xrange,yrange,Nx,Ny,Gama,Nn)
%LABEL2CELLPRO �����Ե����±�ŵ�cell_new��Χ
%label_newΪ�����ϸ����ı�ţ����������ݰ����
%xrange��yrange��Nx,NyΪ��������Ϣ
%cell=[xmin,xmax,ymin,ymax]��Ϊ�ð��ķ�Χ
%GamaΪ��Ҫϸ���İ��ı�ţ�NnΪϸ���̶�

label_old=labelnew2labelold(label_new,Gama,Nn);%�±�������İ����ϱ��
if Gama(label_old)==0%��ϸ����
    cell_new=label2cell(label_old,xrange,yrange,Nx,Ny);
else %ϸ����
    sort=sortold(label_old,Gama);%��ϸ���������±��ʱ��˳��
    label_local=label_new-(sort-1)*Nn*Nn;%��ϸ������еľֲ����
    cell_old=label2cell(label_old,xrange,yrange,Nx,Ny);%ϸ��ǰ��Ӧ���ķ�Χ
    cell_new=label2cell(label_local,cell_old(1:2),cell_old(3:4),Nn,Nn);
end

end

