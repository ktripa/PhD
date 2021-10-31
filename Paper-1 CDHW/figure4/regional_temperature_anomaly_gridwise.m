clear;clc;close;

filename='L:\Data_preprocess\MainDataFile\tmean_1979_2019_rg.txt';
data=importdata(filename);
data(data(:,1)<=1981,:)=[];
obs_final=[[NaN;NaN],data(1:2,4:end)];
for i=1:3347
    disp(i)
    for yr=1982:2019
        if latlon(i,2)>=0
            z=find(data(:,1)==yr&data(:,2)>=5&data(:,2)<=10);
        else
            z=find(data(:,1)==yr&data(:,2)>=11|data(:,1)==yr&data(:,2)<=4);
        end
        obs_final(yr-1979,1)=yr;
        obs_final(yr-1979,i+1)=nanmean(data(z,i+3));
    end
end
obs_final(3:end,2:end)=convtemp(obs_final(3:end,2:end),'K','C');
save('L:\codes_paper1\figure4\data_figure4\tmean_obs.mat','obs_final');

%% GCM data
clear;clc;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
path='L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\ssp545\Tmean\';
hh=dir(path);
final=cell(9,1);
for model=1:9
    modelname=hh(model+2).name
    data=importdata(strcat(path,modelname));
    data(data(:,1)<=2019|data(:,1)>2099,:)=[];
    final{model}(1:2,:)=[[NaN;NaN],data(1:2,4:end)];
    for grid=1:3347
        disp([model,grid]);
        for yr=2020:2099
            if latlon(grid,2)>=0
                z=find(data(:,1)==yr&data(:,2)>=5&data(:,2)<=10);
            else 
                z=find(data(:,1)==yr&data(:,2)>=11|data(:,1)==yr&data(:,2)<=4);
            end
            final{model}(yr-2017,1)=yr;
            final{model}(yr-2017,grid+1)=nanmean(data(z,grid+3));
            final{model}(yr-2017,grid+1)=convtemp(final{model}(yr-2017,grid+1),'K','C');
        end
    end
    clear data;
end
save('L:\codes_paper1\figure4\data_figure4\tmean_GCMs.mat','final');
%% MME
clear;clc;
d=load('L:\codes_paper1\figure4\data_figure4\tmean_GCMs.mat');
GCM=d.final;
final=zeros(82,3348);
final(1:2,:)=GCM{1}(1:2,:);
final(3:end,1)=GCM{1}(3:end,1);
for i=1:3347
    temp=[];
    for j=1:9
        temp=[temp,GCM{j}(3:end,i+1)];
    end
    final(3:end,i+1)=nanmean(temp,2);
end
%% load the observed data
obs=load('L:\codes_paper1\figure4\data_figure4\tmean_obs.mat');
obs_final=obs.obs_final;
pid_grid=nanmean(obs_final(3:end,2:end),1);
tmean=[obs_final;final(3:end,:)];
anomaly=zeros(120,3348);
anomaly(1:2,:)=tmean(1:2,:);
anomaly(3:end,1)=tmean(3:end,1);
anomaly(3:end,2:end)=tmean(3:end,2:end)-pid_grid;
save('L:\codes_paper1\figure4\data_figure4\Yearly_regional_anomaly_gridwise.mat','anomaly')