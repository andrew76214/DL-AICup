% for AI cup 空拍
clear
class = 2;
% rows = 100;
% sz = [rows 2];
% varTypes = {'cell', 'double'};
% varNames = {'imgFilename', 'bbox'};
% train = table('Size', [rows 2], 'VariableTypes', varTypes, 'VariableNames',varNames);
    filehead = sprintf('img%04d',1);
    filename = [filehead '.png'];
    label=csvread([filehead '.txt']);
    I=imread(filename);
    %figure, imshow(I)
    annotate = label(:,2:5);
    PersonIdx = (label(:,1) == class);
    PersonAnnotate = annotate(PersonIdx,:);
    IwithPerson = insertObjectAnnotation(I, 'rectangle', PersonAnnotate, 'Person');
    figure, imshow(IwithPerson)
    
    newRow = {filename, PersonAnnotate};
    train = cell2table(newRow);
    test = cell2table(newRow);

for i=22:1000
    filehead = sprintf('img%04d',i);
    filename = [filehead '.png'];
    label = csvread([filehead '.txt']);
    I = imread(filename);
    % figure, imshow(I)
    annotate = label(:,2:5);
    PersonIdx = (label(:,1) == class);
    PersonAnnotate = annotate(PersonIdx,:);
    IwithPersonAnnotate = insertObjectAnnotation(I, 'rectangle', PersonAnnotate, 'Person');
    % figure, imshow(IwithCar)
    
    newRow = {filename, PersonAnnotate};
    % train = cell2table(newRow);
    train = [train;cell2table(newRow)];
    % pause
end;
%%
for i=2:21
    filehead = sprintf('img%04d',i);
    filename = [filehead '.png'];
    label = csvread([filehead '.txt']);
    I = imread(filename);
    % figure, imshow(I)
    annotate = label(:,2:5);
    PersonIdx = (label(:,1) == class);
    PersonAnnotate = annotate(PersonIdx,:);
    IwithPersonAnnotate = insertObjectAnnotation(I, 'rectangle', PersonAnnotate, 'Person');
    % figure, imshow(IwithCar)
    
    newRow = {filename, PersonAnnotate};
    % train = cell2table(newRow);
    test = [test;cell2table(newRow)];
    % pause
end;