function show2Dlevelcurve(xdata,ydata,network)
%
% Description: plot response of neural network for 2 input and a single
% output.
%
xmin=min(xdata,[],2);
xmax=max(xdata,[],2);
x1=xmin(1)+(xmax(1)-xmin(1))*[0:100]/100;
x2=xmin(2)+(xmax(2)-xmin(2))*[0:100]/100;
xVal=[reshape(ones(101,1)*x1,1,101*101);reshape(x2'*ones(1,101),1,101*101)];
[yVal]=networkFProp(xVal,network);
yVal=reshape(yVal,101,101);
figure;
set(gcf,'Position',[80,200,950,420]);
h1=subplot('Position',[0.1,0.1,0.4,0.8]);
hold on
ind=find(ydata==1);
plot(xdata(1,ind),xdata(2,ind),'o','MarkerSize',[3],'MarkerFaceColor','r','MarkerEdgeColor','r');
ind=find(ydata==0);
plot(xdata(1,ind),xdata(2,ind),'o','MarkerSize',[3],'MarkerFaceColor','b','MarkerEdgeColor','b');
h2=subplot('Position',[0.5,0.1,0.4,0.8]);
imagesc(x1,x2,yVal);
set(gca,'YAxisLocation','right','YDir','normal');
return
end