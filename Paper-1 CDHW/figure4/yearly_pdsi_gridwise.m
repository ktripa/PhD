clear;clc;close;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
path='L:\sc_pdsi_daily_1982_2100\ssp545\';
hh=dir(path);
final=cell(9,1);

for model=1:9
    modelname=hh(model+2).name
    data=load(strcat(path,modelname));
    final{model}(1:2,:)=[[NaN;NaN],data(1:2,4:end)];
    for grid=1:3347
        disp([model,grid]);
        for yr=1982:2099
            if latlon(grid,2)>=0
                z=find(data(:,1)==yr&data(:,2)>=5&data(:,2)<=10);
            else 
                z=find(data(:,1)==yr&data(:,2)>=11|data(:,1)==yr&data(:,2)<=4);
            end
            final{model}(yr-1979,1)=yr;
            final{model}(yr-1979,grid+1)=nanmean(data(z,grid+3));
        end
    end
end
save('L:\codes_paper1\figure4\data_figure4\Yearly_pdsi_gridwise_1982_2099.mat','final');        
%% MME
clear;clc;close;
pdsi=importdata('L:\codes_paper1\figure4\data_figure4\Yearly_pdsi_gridwise_1982_2099.mat');


final=(1982:2099)';
for i=1:3347
    temp=[];
    for j=1:9
        temp=[temp,pdsi{j}(3:end,i+1)];
    end
    final(:,i+1)=nanmean(temp,2);
end
writematrix(final,'L:\codes_paper1\figure4\data_figure4\GridWise_pdsi.txt','delimiter','\t');


