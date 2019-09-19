function [Solution,Status]=generalLinearProgramming(A1,A2,A3,b1,b2,b3,c)

A=[A1;A2;A3];
sz=size(A);
column=sz(2);
size1=size(A1);
size2=size(A2);
size3=size(A3);
row1=size1(1);
row2=size2(1);
row3=size3(1);

A(row1+1:row1+row2,column+1:column+row2)=eye(row2);
A(row1+row2+1:row1+row2+row3,column+row2+1:column+row2+row3)=-eye(row3);

b1=reshape(b1,row1,1);
b2=reshape(b2,row2,1);
b3=reshape(b3,row3,1);
b0=[b1;b2;b3];

index=find(b0<0);
A(index,:)=-A(index,:);
b0(index)=-b0(index);

A(1:row1+row2+row3,column+row2+row3+1:column+row2+row3+row1+row2+row3)=eye(row1+row2+row3);

c1=zeros(1,column+row2+row3);
c2=ones(1,row1+row2+row3);
c0=[c1 c2];

BasicVar0=[column+row2+row3+1:column+row2+row3+row1+row2+row3];

[A,b,Solution,BasicVar,Status]=basicsimplex(A,b0,c0,BasicVar0);
if Status == -1
    disp("Problem is not solvable.");
    return
end
if c0*Solution ~= 0
    disp("Problem is not feasible.");
    Status=-1;
    return
end

A=A(:,1:column+row2+row3);

zero=zeros(1,row2+row3);
c=[c zero];
 
[A,b,Solution,BasicVar,Status]=basicsimplex(A,b,c,BasicVar);
if Status == -1
    disp("Problem is not solvable.");
    return
end

return
end