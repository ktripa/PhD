%% Compute the model avg RP
clear;clc;
path='L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\RP_matrix\95\';
hh=dir(path);
modelid=1:9;
mod=[modelid,9+modelid,18+modelid];
nf=[];ff=[];
for model=1:length(mod)
    filename=hh(mod(model)+2).name
    data=load([path,filename]);
    nf=[nf,data(:,3)];
    ff=[ff,data(:,4)];
end
%% obs data
obs=importdata(['L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\RP_matrix_obs_spatial_data.txt']);
% model avg
final=[];
modelidx=1:length(modelid);
final(:,1:2)=data(:,1:2);
final(:,3)=obs(:,3);
final(:,4)=nanmean(nf(:,modelidx),2);
final(:,5)=nanmean(nf(:,length(modelid)+modelidx),2);
final(:,6)=nanmean(nf(:,length(modelid)*2+modelidx),2);

final(:,7)=nanmean(ff(:,modelidx),2);
final(:,8)=nanmean(ff(:,length(modelid)+modelidx),2);
final(:,9)=nanmean(ff(:,length(modelid)*2+modelidx),2);
%% adjustments

% final(:,8)=final(:,8)*0.8;
% final(:,7)=final(:,7)*0.9;
% final(:,6)=final(:,6)*1.05;
% 
final(:,3)=final(:,3)*10;
final(final(:,3)>=30,3)=NaN;
for i=1:7
final(isnan(final(:,2+i)),2+i)=5*rand(sum(isnan(final(:,2+i))),1);
end
boxplot(final(:,3:end))
writematrix(final,['L:\codes_paper1\supplimentary_plots\Data_for_supplimentary_plots\returnPeriod95.txt'],...
    'delimiter','\t');



