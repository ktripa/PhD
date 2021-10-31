clear;clc;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
%% obs data
data=load('L:\map_matrix\severity_model_wise\observation_parameters\CDHW_obsdata_values95.mat');
obs_cdhwe=data.cdhwevent;
obs_eve=nanmean(obs_cdhwe,1);
%% model data
path='L:\map_matrix\severity_model_wise\parameters\95\';
hh=dir(path);
nevent_ff=[];nevent_nf=[];
for i=[3,14,23:27,29,4:10,12,13,15:20,22]-2
    filename=hh(i+2).name
    data=load(['L:\map_matrix\severity_model_wise\parameters\95\',hh(i+2).name]);
    
    cdhwen=nanmean(data.model_values{2,1}(1:38,:),1); % number of events per year
    nevent_nf=[nevent_nf;cdhwen];
    cdhwef=nanmean(data.model_values{2,1}(39:76,:),1);
    nevent_ff=[nevent_ff;cdhwef];
end
modelid=1:8;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  CDHWdays
final=[];final(:,1:2)=latlon;
final(:,3)=obs_eve';
final(:,4)=nanmean(nevent_nf(modelid,:),1)'-final(:,3);
final(:,5)=nanmean(nevent_nf(8+modelid,:),1)'-final(:,3);
final(:,6)=nanmean(nevent_nf(16+modelid,:),1)'-final(:,3);
% far future
final(:,7)=nanmean(nevent_ff(modelid,:),1)'-final(:,3);
final(:,8)=nanmean(nevent_ff(8+modelid,:),1)'-final(:,3);
final(:,9)=nanmean(nevent_ff(16+modelid,:),1)'-final(:,3);

boxplot(final(:,3:end));
for i=1:7
%     subplot(3,3,i)
    ksdensity(final(:,i+2));
    hold on
end

writematrix(round(final,2),'L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\changeNumEventPerYear_matrix95.txt','delimiter','\t');
%% absolute values

final=[];final(:,1:2)=latlon;
final(:,3)=obs_eve';
final(:,4)=nanmean(nevent_nf(modelid,:),1)';%-final(:,3);
final(:,5)=nanmean(nevent_nf(8+modelid,:),1)';%-final(:,3);
final(:,6)=nanmean(nevent_nf(16+modelid,:),1)';%-final(:,3);
% far future
final(:,7)=nanmean(nevent_ff(modelid,:),1)';%-final(:,3);
final(:,8)=nanmean(nevent_ff(8+modelid,:),1)';%-final(:,3);
final(:,9)=nanmean(nevent_ff(16+modelid,:),1)';%-final(:,3);
writematrix(round(final,2),'L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\AbsoluteNumEventPerYear_matrix95.txt','delimiter','\t');
%% stair plot
for i=1:7
%     subplot(3,3,i)
    histogram(final(:,i+2),'DisplayStyle','stairs');
    hold on
end


%% 90



clear;clc;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
%% obs data
data=load('L:\map_matrix\severity_model_wise\observation_parameters\CDHW_obsdata_values90.mat');
obs_cdhwe=data.cdhwevent;
obs_eve=nanmean(obs_cdhwe,1);
%% model data
path='L:\map_matrix\severity_model_wise\parameters\95\';
hh=dir(path);
nevent_ff=[];nevent_nf=[];
for i=[3,14,23:27,29,4:10,12,13,15:20,22]-2
    filename=hh(i+2).name
    data=load(['L:\map_matrix\severity_model_wise\parameters\95\',hh(i+2).name]);
    
    cdhwen=nanmean(data.model_values{2,1}(1:38,:),1); % number of events per year
    nevent_nf=[nevent_nf;cdhwen];
    cdhwef=nanmean(data.model_values{2,1}(39:76,:),1);
    nevent_ff=[nevent_ff;cdhwef];
end
modelid=1:8;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  CDHWdays
final=[];final(:,1:2)=latlon;
final(:,3)=obs_eve';
final(:,4)=nanmean(nevent_nf(modelid,:),1)'-final(:,3);
final(:,5)=nanmean(nevent_nf(8+modelid,:),1)'-final(:,3);
final(:,6)=nanmean(nevent_nf(16+modelid,:),1)'-final(:,3);
% far future
final(:,7)=nanmean(nevent_ff(modelid,:),1)'-final(:,3);
final(:,8)=nanmean(nevent_ff(8+modelid,:),1)'-final(:,3);
final(:,9)=nanmean(nevent_ff(16+modelid,:),1)'-final(:,3);

boxplot(final(:,3:end));
for i=1:7
%     subplot(3,3,i)
    ksdensity(final(:,i+2));
    hold on
end

writematrix(round(final,2),'L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\changeNumEventPerYear_matrix90.txt','delimiter','\t');
%% absolute values

final=[];final(:,1:2)=latlon;
final(:,3)=obs_eve';
final(:,4)=nanmean(nevent_nf(modelid,:),1)';%-final(:,3);
final(:,5)=nanmean(nevent_nf(8+modelid,:),1)';%-final(:,3);
final(:,6)=nanmean(nevent_nf(16+modelid,:),1)';%-final(:,3);
% far future
final(:,7)=nanmean(nevent_ff(modelid,:),1)';%-final(:,3);
final(:,8)=nanmean(nevent_ff(8+modelid,:),1)';%-final(:,3);
final(:,9)=nanmean(nevent_ff(16+modelid,:),1)';%-final(:,3);
writematrix(round(final,2),'L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\AbsoluteNumEventPerYear_matrix90.txt','delimiter','\t');

























%% load the previous work
% CH=load('L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\Change_num_cdhw_events_per_year90.txt');
CH=load('L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\cdhwevents_peryear_matrix_absoulte_values90.txt');
final=[];
final(:,1:3)=CH(:,1:3);
for i=1:6
    final(:,i+3)=CH(:,i+3);%-CH(:,3);
end


%% return period
RP(:,1:2)=latlon;
for i=1:3
    jprob(:,i)=final(:,i+2)./(38*184);
    RP(:,i+2)=1./jprob(:,i)/365;
end
RP(isinf(RP))=NaN;
writematrix(round(RP,4),'L:\map_matrix\severity_model_wise\ReturnPeriod_matrix95.txt','delimiter','\t');














%% calculate the total number of cdhw days in the observation period (1982-2019) 
mavg=cell(3,2);
for i=1:3
    for j=1:9
        mavg{i,1}=[mavg{i,1},nansum(cdhwd{i,j}(39:76,:),1)'];
        mavg{i,2}=[mavg{i,2},nansum(cdhwd{i,j}(77:114,:),1)'];
    end
end
%% final matrix absolute values
final=[];
final(:,1:2)=latlon;
final(:,3)=obs; % observed values
for i=1:3
    final(:,i+3)=nanmean(mavg{i,1},2);
    final(:,i+6)=nanmean(mavg{i,2},2);
end



%% return periods
RP(:,1:2)=latlon;
for i=1:7
    jprob(:,i)=final(:,i+2)./(38*184)*365;
    RP(:,i+2)=1./jprob(:,i);
end
RP(isinf(RP))=NaN;
save('L:\map_matrix\severity_model_wise\Return_period_matrix.mat','RP');
writematrix(round(RP,4),'L:\map_matrix\severity_model_wise\ReturnPeriod_matrix.txt','delimiter','\t');


%%
%% number of cdhw events
scenario=['ssp126';'ssp245';'ssp545'];
path1='L:\map_matrix\ssp\';
%% extract the cdhw events for all the models
ncdhweve=cell(3,9);
for ssp=1:3
    for model=[1,2,5:9]
        
       path2=strcat(path1,scenario(ssp,:),'\');
       hh=dir(path2);
       modelname=strcat(path2,hh(model+2).name);
       data=load(strcat(modelname,'\cdhwr_spatial_model_cdhwevents_sever.mat'));
       nevent=data.num_cdhw_event;
       ncdhweve{ssp,model}=nevent;
    end
end
save('L:\map_matrix\severity_model_wise\num_cdhw_events_allmodels.mat','ncdhweve');



%% load the cdhw events
clear;clc;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
data=load('L:\map_matrix\severity_model_wise\num_cdhw_events_allmodels.mat');
data=data.ncdhweve;
near=cell(3,1);far=cell(3,1);
nearf=cell(3,9);farf=cell(3,9);
for ssp=1:3
    for model=[1,2,5:9]
       %% nearfut
       nearf{ssp,model}=nansum(data{ssp,model}(39:76,:));
       near{ssp,1}=[near{ssp,1},nearf{ssp,model}'];
       %% farfuture
       farf{ssp,model}=nansum(data{ssp,model}(77:114,:));
       far{ssp,1}=[far{ssp,1},farf{ssp,model}'];
    end
end
for i=1:3
    nearm(:,i)=nanmean(near{i,1},2)./38;
    farm(:,i)=nanmean(far{i,1},2)./38;
end
save('L:\map_matrix\severity_model_wise\num_cdhw_events_segregated_near_far.mat','nearm','farm');

%% load the ssp data
data=load('L:\map_matrix\severity_model_wise\num_cdhw_events_segregated_near_far.mat');
nearf=data.nearm;farf=data.farm;
%% extract the cdhw events for obs data
data=load('L:\map_matrix\severity_model_wise\CDHW_obsdata_values.mat');
ncdhweve_obs=data.cdhwevent;
ncdhw_obs=nansum(ncdhweve_obs,1)./38;
%% final matrix absolute values
final=[];
final(:,1:2)=latlon;
final(:,3)=ncdhw_obs'; % observed values
final(:,4:6)=nearf;final(:,7:9)=farf;
%% percentage change in the grids
perce=[];perce(:,1:2)=latlon;
for i=1:6
    perce(:,i+2)=(final(:,i+3)-final(:,3));
end
save('L:\map_matrix\severity_model_wise\num_cdhw_events_finalmatrix_change.mat','final','perce');

writematrix(round(final,2),'L:\map_matrix\severity_model_wise\num_cdhw_events_per_year_final.txt','delimiter','\t');
writematrix(round(perce,2),'L:\map_matrix\severity_model_wise\Change_num_cdhw_events_per_year.txt','delimiter','\t');

%% kde plot
fig=figure(1);
for i=1:7
    ksdensity(final(:,i+2));
    hold on;
    grid on;
end
