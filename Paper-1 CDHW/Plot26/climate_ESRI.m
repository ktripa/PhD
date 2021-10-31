clear;clc;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');

grid_data=readtable('referenceRegions.xls');
for i=1:height(grid_data)
    grid1{i,1}=str2num(char(grid_data{i,5:10}))
%     cellfun(@str2num,grid_data{i,5},'un',0)
end
% for i=1:length(grid)
%     coord{i,1}=latlon(inpolygon(latlon(:,2),latlon(:,1),grid{i,1}(:,2),grid{i,1}(:,1)),:);
% end
% scatter(coord{1,1}(:,1),coord{1,1}(:,2))
save('L:\codes_paper1\Plot26\latlon_of_grid_points.mat','grid1');
















