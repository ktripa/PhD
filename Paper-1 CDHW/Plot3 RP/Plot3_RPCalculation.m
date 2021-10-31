%{
This code considers both Duration and Severity as the threshold in the RP
calculation
%}
%% 90th percentile
clc;clear;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
%% obs data
obs=load(['L:\Master_matrix\obsdata\final3d_obsdata_master_matrix95.mat']);
for i=1:length(latlon(:,1))
    datf=obs.final3d{i,1};
    if length(datf(1,:))==15
        th(i,1:4)=[latlon(i,1),latlon(i,2),max(datf(:,13)),max(datf(:,14))];
    else
    end
end

dlmwrite(['L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\JointMaxThreshold_Observation95'],th,'delimiter','\t');

%%
clear;clc;
th=load('L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\JointMaxThreshold_Observation95');
%%%% model wise data calculation
path='D:\mastermatrix\95\';
hh=dir(path);
% RPmat=cell(27,1);
for model=1:length(hh)-2
    filename=hh(model+2).name
    data=load([path,filename]);
    disp(model)
    n=1;fut=[];
    for i=1:length(th(:,1))
        
        datf=data.output{i,1};
        if th(i,2)>=0
            znf=find(datf(:,1)>=2020&datf(:,1)<=2057&datf(:,2)>=5&datf(:,2)<=10);
            zff=find(datf(:,1)>=2058&datf(:,1)<=2095&datf(:,2)>=5&datf(:,2)<=10);
            
        else
            znf=find(datf(:,1)>=2020&datf(:,1)<=2057&datf(:,2)>=11|datf(:,1)>=2020&datf(:,1)<=2057&datf(:,2)<=4);
            zff=find(datf(:,1)>=2058&datf(:,1)<=2095&datf(:,2)>=11|datf(:,1)>=2058&datf(:,1)<=2095&datf(:,2)<=4);
            
        end
        if length(datf(1,:))==15
            fut(n,1:2)=th(i,1:2);
            fut(n,3)=1/((size(find(datf(znf,13)>=th(i,3)&datf(znf,14)>=th(i,4)),1)/size(znf,1))*365);
            fut(isinf(fut(:,3))==1,3)=NaN;
            %%% far future 
            fut(n,4)=1/((size(find(datf(zff,13)>=th(i,3)&datf(zff,14)>=th(i,4)),1)/size(zff,1))*365);
            fut(isinf(fut(:,4))==1,4)=NaN;
            n=n+1;
        else
        end
    end
    writematrix(round(fut,4),['L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\RP_matrix\95\RP_matrix95',...
        filename(end-7:end-4),'.txt'],'delimiter','\t')
%     RPmat{model,1}=fut;
    clear data;
end
%% Compute the model avg RP
clear;clc;
path='L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\RP_matrix\95\';
hh=dir(path);
modelid=[1:7,9];
mod=[modelid,9+modelid,18+modelid];
nf=[];ff=[];
for model=mod
    filename=hh(model+2).name
    data=load([path,filename]);
    nf=[nf,data(:,3)];
    ff=[ff,data(:,4)];
end
% model avg
final=[];
modelidx=1:length(modelid);
final(:,1:2)=data(:,1:2);
final(:,3)=nanmean(nf(:,modelidx),2);
final(:,4)=nanmean(nf(:,length(modelid)+modelidx),2);
final(:,5)=nanmean(nf(:,length(modelid)*2+modelidx),2);

final(:,6)=nanmean(ff(:,modelidx),2);
final(:,7)=nanmean(ff(:,length(modelid)+modelidx),2);
final(:,8)=nanmean(ff(:,length(modelid)*2+modelidx),2);
writematrix(round(final,3),'L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\RP_matrix\RPmat95.txt','delimiter','\t');

%% RP for Observation
clear;clc;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');

data=load('L:\Master_matrix\obsdata\final3d_obsdata_master_matrix.mat');
data=data.final3d;
n=1;fut=[];
for i=1:length(data)
    
    datf=data{i,1};
    if latlon(i,2)>=0
        z=find(datf(:,1)>=1982&datf(:,1)<2020&datf(:,2)>=5&datf(:,2)<=10);
        
    else
        z=find(datf(:,1)>=1982&datf(:,1)<2020&datf(:,2)>=11|datf(:,1)>=1982&datf(:,1)<=2019&datf(:,2)<=4);
        
    end
    if length(datf(1,:))==15
        fut(n,1:2)=latlon(i,1:2);
        
        fut(n,3)=1/((size(find(datf(z,13)>0),1)/size(z,1))*365);
        fut(isinf(fut(:,3))==1,3)=NaN;
        n=n+1;
    else
    end
end
writematrix(round(fut,3),['L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\RP_matrix\90\RP_matrix_obs.txt'],'delimiter','\t')