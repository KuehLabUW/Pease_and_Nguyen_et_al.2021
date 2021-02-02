clear
cd('C:\Users\Sam Nguyen\Documents\MATLAB\Imaging\RawLiveDead\NewScriptData\111617')
load('model.mat')
load('111617CellforTree.mat')


features = DataMatrix(1:size(DataMatrix,1),2:8);
livedead = DataMatrix(1:size(DataMatrix,1),1);

answerpredicted = predict(tree,features);

wronginstance = 0;
for i = 1:numel(answerpredicted)
    if answerpredicted(i) ~= livedead(i)
        wronginstance = wronginstance +1;
    end
end
      
      
      