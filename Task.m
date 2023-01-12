options = trainingOptions('sgdm', ...
        'MiniBatchSize', 128, ...
        'InitialLearnRate', 1e-3, ...
        'LearnRateSchedule', 'piecewise', ...
        'LearnRateDropFactor', 0.1, ...
        'LearnRateDropPeriod', 100, ...
        'ExecutionEnvironment', 'gpu', ...
        'MaxEpochs',2, ...
        'Verbose', true);
    
% train    
rcnn = trainRCNNObjectDetector(train, 'googlenet', options, ...
        'NegativeOverlapRange', [0 0.3], 'PositiveOverlapRange',[0.5 1]);
%%
test.newRow1 = fullfile('Path', test.newRow1);
test
%%
results = table('Size',[height(test) 2],...
       'VariableTypes',{'cell','cell'},...
       'VariableNames',{'Boxes','Scores'});

for i = 2 : 21
    I = imread(test.newRow1{i});
    [bboxes, scores] = detect(rcnn,I);
    results.Boxes{i} = bboxes;
    results.Scores{i} = scores;
end 

[ap,recall,precision] = evaluateDetectionPrecision(results,test(:,2));
%% 
ap      % ap = average precision

%%
figure
plot(recall,precision)
grid on
title(sprintf('Average Precision = %.1f',ap))