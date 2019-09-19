x=randi(500,100,1);
y=3*x+100;
noise=randi([-100 100],100,1);
y=y+noise;
y(3)=1500;
y(5)=7600;
y(12)=5000;
y(13)=5600;
y(15)=1300;
y(34)=2700;
y(41)=6500;
y(52)=250;
y(62)=2000;
y(70)=6900;
y(73)=8000;
y(89)=1600;
y(95)=120;
y(96)=3400;
y(100)=5000;

sz=size(x);
k=sz(1);
W=zeros(k,2*k);
for i = 1:k
    W(i,2*i-1)=1;
    W(i,2*i)=-1;
end

X=reshape(x,k,1);
B=ones(k,1);
A=[W X -X B -B];
b0=reshape(y,k,1);
c=ones(1,2*k);
c0=[0,0,0,0];
c=[c c0];

A1=A;
A2=[];
A3=[];
b1=b0;
b2=[];
b3=[];

[Solution,Status]=generalLinearProgramming(A1,A2,A3,b1,b2,b3,c);
if Solution(2*k+1)==0
    a=-Solution(2*k+2);
else
    a=Solution(2*k+1);
end
if Solution(2*k+3)==0
    b=-Solution(2*k+4);
else
    b=Solution(2*k+3);
end

scatter(x,y);
hold on;
plot(x,a*x+b);
xlabel('x');
ylabel('y');
title('L1 Regression');

hold off;
sz=size(x);
n=sz(1);
x_bar=mean(x);
y_bar=mean(y);
xy=x.*y;
x_square=x.^2;

table=[x y xy x_square];

a2=(sum(xy)-n*x_bar*y_bar)/(sum(x_square)-n*x_bar^2);
b2=y_bar-a*x_bar;

scatter(x,y);
hold on;
plot(x,a2*x+b2);
xlabel('x');
ylabel('y');
title('L2 Regression')