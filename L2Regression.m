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
n=sz(1);
x_bar=mean(x);
y_bar=mean(y);
xy=x.*y;
x_square=x.^2;

table=[x y xy x_square];

a=(sum(xy)-n*x_bar*y_bar)/(sum(x_square)-n*x_bar^2);
b=y_bar-a*x_bar;

scatter(x,y);
hold on;
plot(x,a*x+b);
xlabel('x');
ylabel('y');
title('L2 Regression');