% Fixed-step gradient descent
[x,y]=getData(1000,2,69622471);
x1=x(1,:);
x2=x(2,:);
ind = find(y==1);
plot(x(1,ind),x(2,ind),'o','MarkerFaceColor','r','MarkerEdgeColor','r','MarkerSize',5);
hold on
ind = find(y==0);
plot(x(1,ind),x(2,ind),'o','MarkerFaceColor','b','MarkerEdgeColor','b','MarkerSize',5);
legend('y=1','y=0');
xlabel('x1');
ylabel('x2');

[network]=createNetwork(2,[4,1]);
VisualizeNN(network)
[Weight]=getNNWeight(network);
weight=[1;-1;0;0;0;0;-1;1;40;40;32;15;1;1;1;1;-2];
[network]=setNNWeight(network,weight);
CompareData2NNResponse_2D(x,y,network)

[yVal,yintVal]=networkFProp(x,network);
[yGrad,yGrad_Struct]=networkBProp(network,yintVal);

yGrad=reshape(yGrad,[17,1000]);
gradient=-2*yGrad*(y-yVal)';
gradVal=norm(gradient,2);
index=1;
gradArray(index)=gradVal;
loss(index)=(y-yVal)*(y-yVal)';
while gradVal>5
     weight=weight-0.0005*gradient;
     [network]=setNNWeight(network,weight);
     [yVal,yintVal]=networkFProp(x,network);
     [yGrad,yGrad_Struct]=networkBProp(network,yintVal);
     yGrad=reshape(yGrad,[17,1000]);
     gradient=-2*yGrad*(y-yVal)';
     gradVal=norm(gradient,2);
     index=index+1;
     gradArray(index)=gradVal;
     loss(index)=(y-yVal)*(y-yVal)';
end

CompareData2NNResponse_2D(x,y,network)