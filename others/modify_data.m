function [M_sort]=modify_data(M)
[N,d]=size(M);
d=d-1;
values = unique(M(:,1));
instances = histc(M(:,1),values);
current_count=0;
for i=1:length(values)
    index=(current_count+1):(current_count+instances(i));
    current_count=current_count+instances(i);
    M(index,:)=sortrows(M(index,:),size(M,2));
end
M_sort=M;
end