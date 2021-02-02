clear
cd('C:\Users\samng\Documents\MATLAB\Imaging\RawLiveDead\NewScriptData\082117')
load('082117CellforTree.mat')
outdir = 'C:\Users\samng\Documents\MATLAB\Imaging\RawLiveDead\NewScriptData\082117\';
%load('Model111617.mat')
features = DataMatrix(1:size(DataMatrix,1),2:8);
livedead = DataMatrix(1:size(DataMatrix,1),1);
%%
%checkfeatures = DataMatrix(:,2:8);
%answerkey     = DataMatrix(:,1);

%answerpredicted = predict(tree,checkfeatures);

%wronginstance = 0;
%for i = 1:numel(answerpredicted)
%    if answerpredicted(i) ~= answerkey(i)
%        wronginstance = wronginstance +1;
%    end
%end
%%
tree = fitctree(features,livedead);
resuberror = resubLoss(tree);
cvtree = crossval(tree);
cvloss = kfoldLoss(cvtree);
view(tree,'Mode','graph')
%save([outdir 'Model082117.mat'],'tree');
%%