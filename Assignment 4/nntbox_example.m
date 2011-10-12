%example using NN toolbox...
%2-layer fdfwd network to be trained w/ neural-net toolbox
%for xor, define 2 inputs--bias is implicit J interneurons (not incl bias), and 1 output
%choose logsig (sigmoid) nonlinear activation fnc for hidden layer, linear activation fnc
% for output layer
% put training patterns in rows: P=4 patterns
p1=[0,0];
t1=0;
p2=[1,1];
t2=0;
p3=[1,0];
t3=1;
p4=[0,1];
t4=1;
training_patterns=[p1;p2;p3;p4];  %store pattern inputs as row vectors in a matrix

targets=[t1;t2;t3;t4];  % should have these responses; rows correspond to input pattern rows

ndim_inputs=2; %2D patterns--not counting bias
nnodes_layer1=4; %try this many interneurons--not including bias
nnodes_layer2=1; %single output

ranges = [0 1; 0 1]; %define 2-D input patterns, values range 0 to 1

%EDIT THIS: watch out for presumption of rows vs columns for input matrices
net = feedforwardnet(nnodes_layer1); % fill in necessary arguments to build a network object

net=init(net); %init all W values; READ ABOUT INIT(NET)

%some debug--probe values of the new net object
%net.layerConnect % 1 in (i,j) if there is a connection from layer j to layer i
%net.outputConnect % shows which layers can produce outputs: [0 1]==> second layer only has outputs
%net.targetConnect % shows only second-layer outputs have targets
%net.numOutputs  % single output
%net.LW{2,1} %display weights onto layer 2 from layer 1
%net.layers{1}.size
%net.layers{2}.size
%net.layerWeights{2,1}.size
%net.inputs{1}.size %dimension of input patterns
%net.inputs{2}.size % there are no inputs to layer 2

%EDIT THIS; 
net.divideFcn = 'dividetrain';
net.trainFcn = 'trainlm';
%net.trainFcn = 'traingd';
%net.trainParam.lr=.5;
net.layers{1}.transferFcn = 'tansig';
net.layers{2}.transferFcn = 'purelin';
net
[net,tr,Y,~,~,~] = train(net, training_patterns', targets');  %do NN training--fill in correct args

%plot out the result--create a new set of stimulus patterns at regular
%intervals and simulate network
evalpats = zeros(2,121);
count = 1;
for i=0:0.1:1
    for j=0:0.1:1
     evalpats(:,count)=[i;j];
     count = count +1;
    end
end
xvals = 0:0.1:1; %same stimulus patterns represented as vectors
yvals = 0:0.1:1;

%SIMULATE the network with new input patterns--READ ABOUT "sim()"
[simOutputs,Pf,Af,E,perf] = sim(net,evalpats); %simulate the entire set

%pack the outputs into an array for surface plotting--only works for 2-D in, 1-D out
Z=zeros(11,11);
p=1;
for i=1:11
    for j=1:11
     Z(i,j)=simOutputs(p);
     p=p+1;
    end
end
figure(2)
surf(xvals,yvals,Z) %plot out the result
title('XOR training result')