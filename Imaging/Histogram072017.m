Flor = [];
RealFlor = [];
for i = 1:numel(objects)
    for j = 1:numel(objects(i).obj)
        Flor = [Flor objects(i).obj(j).data.logCFP];
    end
end

for i = 1:numel(Flor)
    index = real(Flor(i));
    RealFlor = [RealFlor index];
end



histogram(RealFlor)
