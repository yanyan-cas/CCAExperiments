
clear all
clc
%%
% Digit Data Set: CIFAR

fprintf('Loading CIFAR data file\n'); 
addpath('/Users/Yanyan/Documents/MATLAB/DATASET/cifar-10-batches-mat');

raw = load('data_batch_1.mat');
trainRaw = raw.data;
trainLabel = raw.labels;


%%

tmp = zeros(1,32*32,3);
trainData = zeros(size(trainRaw,1), 32 *32);
for i = 1 : size(trainRaw,1)
    tmp = reshape(trainRaw(i,:), [1,32*32,3]);
    tmp2 = rgb2gray(tmp);
   % tmp3 = imbinarize(tmp2);
    trainData(i,:) = im2double(tmp2);
end
% 
%% Continous Cellular Automata Feature Extraction
CAEVOL = 100;
CCATrain = zeros(size(trainData, 1), 32*32);
addPara = 0.9;
multPara = 1;

WavePara = 0.1;
% 
for j = 1 : CAEVOL
    for i = 1 : size(trainData, 1)
       if j ==1
           output = CCAWaveFeatureNB(reshape(trainData(i,:), 32, 32)', WavePara);
       else
           output =  CCAWaveFeatureNB(reshape(CCATrain(i,:), 32, 32)', WavePara);
       end
       CCATrain(i,:) = reshape(output', 1, 32*32);
    end

    filename = sprintf('expWaveNBevolution%d.mat', j);
    save(filename, 'CCATrain');
    
end


%%

averageErr = zeros(CAEVOL, 10);

for evolve = 1 : CAEVOL
    filename = sprintf('expWaveNBevolution%d.mat', evolve);
    TEMP = load(filename, 'CCATrain');

    X = TEMP.CCATrain;
    Y = cellstr(num2str(trainLabel)); 
    %group = char(Y);
    KNNMdl = fitcknn(X,Y, 'Standardize',1 , 'CrossVal', 'on');
    averageErr(evolve, :) = kfoldLoss(KNNMdl, 'Mode','individual');
        
    filestorename = sprintf('experimentWaveNB%fevolution%d.mat', wavePara, evolve);
        save(filestorename, 'averageErr');
        
end


