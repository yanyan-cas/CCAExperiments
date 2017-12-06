sampleNum = 1;

for evolve = 1 : 100
    filename = sprintf('expDffusionNBevolution%d.mat', evolve);
    TEMP = load(filename, 'CCATrain');
    
    X = trainData;
    
end
