clearvars
source_dir = uigetdir([]); 
d = dir([source_dir, '/*scores.csv']);
name = {d.name}.';
C=cellfun(@(x) x(1:24), name, 'UniformOutput', false);
