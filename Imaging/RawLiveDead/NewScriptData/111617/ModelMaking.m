clear
cd('C:\Users\samng\Documents\MATLAB\Imaging\RawLiveDead\NewScriptData\111617')
load('111617CellforTree.mat')
outdir = 'C:\Users\samng\Documents\MATLAB\Imaging\RawLiveDead\NewScriptData\111617\';
features = DataMatrix(1:size(DataMatrix,1),2:8);
livedead = DataMatrix(1:size(DataMatrix,1),1);

tree = fitctree(features,livedead);
%tree = fitctree(features,livedead,'CrossVal','on');
resuberror = resubLoss(tree);
%cvrtree = crossval(tree);
%%
checkfeatures = DataMatrix(1501:1647,2:8);
answerkey     = DataMatrix(1501:1647,1);

answerpredicted = predict(tree,checkfeatures);

wronginstance = 0;
for i = 1:numel(answerpredicted)
    if answerpredicted(i) ~= answerkey(i)
        wronginstance = wronginstance +1;
    end
end
%%
cvtree = crossval(tree);
cvloss = kfoldLoss(cvtree);
view(tree,'Mode','graph')
%save([outdir 'Model11617.mat'],'tree');
