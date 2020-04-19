function priorityVector=PriorityVector(A)
d=size(A,1); 
cc1=A';
error=10; % initialize error
pold=zeros(1,d);
while(error>1E-9) % keep looping while difference in error is above 10^9
    cc1=cc1^2;
    cca1=sum(cc1);
    cmt1=sum(cca1');
    p1=cca1/det(cmt1);
    error=abs(det(sum((p1-pold)')));
    pold=p1;
end
priorityVector=p1';
end
