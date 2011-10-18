%Main program for fitting arm actuator positions to x-y position for
%assignment 4b in EECS 484
%By Edward Venator, based on code from assignment 4a, which is in turn 
%based on code by Wyatt Newman.

%2-layer fdfwd network to be trained w/ neural-net toolbox

clear;

%Load in Training/Target Data From dat file
load('arm_xy.dat')
training_patterns = arm_xy(:,1:2);
[~, input_dim] = size(training_patterns); %Number of input nodes
targets = arm_xy(:,3);
[~, output_dim] = size(targets); %Number of output nodes
interneurons = 10; %Number of interneurons
ranges = range(training_patterns); %Range of input patterns

%Create feedforward neural network
net = feedforwardnet(interneurons);

%Don't need to init net (this is just to reset a net that has already been
%trained)

%Set training parameters
net.divideFcn = 'dividetrain'; %Use all training patterns
net.trainFcn = 'trainlm'; %Use lm training
%net.trainFcn = 'traingd'; %Use gradient descent training (slower)
%net.trainParam.lr=.5; %Set epsilong (learning rate)
net.layers{1}.transferFcn = 'tansig'; %Use sigmoid tf for interneurons
net.layers{2}.transferFcn = 'purelin'; %Use linear or sigmoid tf for output

%Train Neural Net
[net, Y] = train(net, training_patterns', targets'); 

%Simulate and Plot Out the Results

%Create a set of stimuli at regular intervals to create response plots
evalpats = zeros(2, 21*11);
count = 1;
l1vals = 0.1:.01:.3;
l2vals = 0.2:0.01:.4;
for i=l1vals
    for j=l2vals
        evalpats(:,count)=[i;j];
        count = count + 1;
    end
end
%Simulate the network with new input patterns
simOutputVec = sim(net,evalpats);

%Plot X
figure(1);
clf;
simXMat = reshape(simOutputVec(1,:), 21, []);
surf(l1vals, l2vals, simXMat);
hold on;
plot3(training_patterns(:,1), training_patterns(:,2), targets(:,1), 'b*');
hold off;
title('X Result')