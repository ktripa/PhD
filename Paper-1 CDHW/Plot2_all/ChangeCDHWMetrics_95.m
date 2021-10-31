clear;clc;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');

%% obs data
data=load('L:\map_matrix\severity_model_wise\observation_parameters\CDHW_obsdata_values95.mat');
obs_cdhwe=data.cdhwevent;
obs_cdhwd=data.cdhwd;
obs_cdhws=data.sev;

obs_eve=nanmean(obs_cdhwe,1);
obs_day=nanmean(obs_cdhwd,1);
obs_sev=nanmean(obs_cdhws,1);

%% model data
path='L:\map_matrix\severity_model_wise\parameters\95\';
hh=dir(path);
nevent_ff=[];nevent_nf=[];
nday_ff=[];nday_nf=[];
nsev_ff=[];nsev_nf=[];
for i=[3,14,23:27,29,4:10,12,13,15:20,22]-2
    filename=hh(i+2).name
    data=load(['L:\map_matrix\severity_model_wise\parameters\95\',hh(i+2).name]);
    %% events
    cdhwen=nanmean(data.model_values{2,1}(1:38,:),1); % number of events per year
    nevent_nf=[nevent_nf;cdhwen];
    cdhwef=nanmean(data.model_values{2,1}(39:76,:),1);
    nevent_ff=[nevent_ff;cdhwef];
    %% days
    cdhwdn=nanmean(data.model_values{1,1}(1:38,:),1); % number of events per year
    nday_nf=[nday_nf;cdhwdn];
    cdhwdf=nanmean(data.model_values{1,1}(39:76,:),1);
    nday_ff=[nday_ff;cdhwdf];
    
    %% severity
    cdhwsn=nanmean(data.model_values{6,1}(1:38,:),1); % number of events per year
    nsev_nf=[nsev_nf;cdhwsn];
    cdhwsf=nanmean(data.model_values{6,1}(39:76,:),1);
    nsev_ff=[nsev_ff;cdhwsf];
end
modelid=1:8;
%%  CDHWevents
finale=[];finale(:,1:2)=latlon;
finale(:,3)=obs_eve';
finale(:,4)=nanmean(nevent_nf(modelid,:),1)'-finale(:,3);
finale(:,5)=nanmean(nevent_nf(8+modelid,:),1)'-finale(:,3);
finale(:,6)=nanmean(nevent_nf(16+modelid,:),1)'-finale(:,3);
% far future
finale(:,7)=nanmean(nevent_ff(modelid,:),1)'-finale(:,3);
finale(:,8)=nanmean(nevent_ff(8+modelid,:),1)'-finale(:,3);
finale(:,9)=nanmean(nevent_ff(16+modelid,:),1)'-finale(:,3);
writematrix(round(finale,2),...
    'L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\changeCDHWe_matrix95.txt','delimiter','\t');


finale=[];finale(:,1:2)=latlon;
finale(:,3)=obs_eve';
finale(:,4)=nanmean(nevent_nf(modelid,:),1)';
finale(:,5)=nanmean(nevent_nf(8+modelid,:),1)';
finale(:,6)=nanmean(nevent_nf(16+modelid,:),1)';
% far future
finale(:,7)=nanmean(nevent_ff(modelid,:),1)';
finale(:,8)=nanmean(nevent_ff(8+modelid,:),1)';
finale(:,9)=nanmean(nevent_ff(16+modelid,:),1)';
writematrix(round(finale,2),...
    'L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\Abs_CDHWe_matrix95.txt','delimiter','\t');

%% Days
finald=[];finald(:,1:2)=latlon;
finald(:,3)=obs_day';
finald(:,4)=nanmean(nday_nf(modelid,:),1)'-finald(:,3);
finald(:,5)=nanmean(nday_nf(8+modelid,:),1)'-finald(:,3);
finald(:,6)=nanmean(nday_nf(16+modelid,:),1)'-finald(:,3);
% far future
finald(:,7)=nanmean(nday_ff(modelid,:),1)'-finald(:,3);
finald(:,8)=nanmean(nday_ff(8+modelid,:),1)'-finald(:,3);
finald(:,9)=nanmean(nday_ff(16+modelid,:),1)'-finald(:,3);
writematrix(round(finald,2),...
    'L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\changeCDHWd_matrix95.txt','delimiter','\t');

finald=[];finald(:,1:2)=latlon;
finald(:,3)=obs_day';
finald(:,4)=nanmean(nday_nf(modelid,:),1)';
finald(:,5)=nanmean(nday_nf(8+modelid,:),1)';
finald(:,6)=nanmean(nday_nf(16+modelid,:),1)';
% far future
finald(:,7)=nanmean(nday_ff(modelid,:),1)';
finald(:,8)=nanmean(nday_ff(8+modelid,:),1)';
finald(:,9)=nanmean(nday_ff(16+modelid,:),1)';
writematrix(round(finald,2),...
    'L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\Abs_CDHWd_matrix95.txt','delimiter','\t');

%% Severity
finals=[];finals(:,1:2)=latlon;
finals(:,3)=obs_sev';

% non_val=find(isnan(finals(:,3)));
% rng shuffle;
% 
% pu=15+20*rand(length(non_val),1);
% for c=1:length(pu)
%     finals(non_val(c),3)=pu(c);
% end
finals(:,4)=-nanmean(nsev_nf(modelid,:),1)'+finals(:,3);
finals(:,5)=-nanmean(nsev_nf(8+modelid,:),1)'+finals(:,3);
finals(:,6)=-nanmean(nsev_nf(16+modelid,:),1)'+finals(:,3);
% far future
finals(:,7)=-nanmean(nsev_ff(modelid,:),1)'+finals(:,3);
finals(:,8)=-nanmean(nsev_ff(8+modelid,:),1)'+finals(:,3);
finals(:,9)=-nanmean(nsev_ff(16+modelid,:),1)'+finals(:,3);

writematrix(round(finals,2),...
    'L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\changeCDHWs_matrix95.txt','delimiter','\t');
