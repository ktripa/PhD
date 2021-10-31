%% step-1
%{ 


Identify the grids that have more than 30 events for the observed period 
%}
clear;clc;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
data=load('L:\map_matrix\severity_model_wise\observation_parameters\CDHW_obsdata_values90.mat');
eve=nansum(data.cdhwevent,1);
% day=nansum(data.cdhwd,1);
z=find(eve>30)';
%%% scatter plot
scatter(latlon(:,1),latlon(:,2));
hold on;
scatter(latlon(z,1),latlon(z,2),'*');
%% Step-2
%{
Threshold of obs_severity

1. Calculate the 90th percentile of the severity of the cdhw events for all
the grids in the observation period

2. Save the observed severity values.
%}

%%% obs severity
obsMM=load('L:\map_matrix\severity_model_wise\observation_parameters\CDHW_obsdata_values90.mat');
sev=obsMM.sev;
obs_thsev=[z,quantile(sev(:,z),0.95)'];
save('L:\map_matrix\severity_model_wise\observation_parameters\severity_obs_data90percentile.mat','obs_thsev');

%% Step-3
%{
1. Load the future scenario values
2. Consider a grid point(where cdhw events more than 30).
3. Calculate how many events and event days given than the severity value
    of that event is more than the 90th percentile.
%}
clear;clc;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
thsev=load('L:\map_matrix\severity_model_wise\observation_parameters\severity_obs_data90percentile.mat');
obs_thsev=thsev.obs_thsev; % obseerved threshold severity values





%%% model severity values
% sv=load('L:\map_matrix\severity_model_wise\severity.mat');
% sv_cell=sv.sv_cell;
path='L:\map_matrix\severity_model_wise\parameters\90\';
hh=dir(path);
xx=cell(length(hh)-2,4);
for i=1:length(hh)-2
    cdhw=load([path,hh(i+2).name]);
    sev=cdhw.model_values{6,1};
    cdhwd{1,1}=cdhw.model_values{1,1}(1:38,:);cdhwd{2,1}=cdhw.model_values{1,1}(39:76,:);
    cdhwe{1,1}=cdhw.model_values{2,1}(1:38,:);cdhwe{2,1}=cdhw.model_values{2,1}(39:76,:);
    for j=1:length(obs_thsev)
        z=obs_thsev(j,1);
%         disp(latlon(z,:));
        %%% near fut
        nf_sev=sev(1:38,z);
        zp=find(nf_sev>obs_thsev(j,2));
        
        xx{i,1}=[xx{i,1},nansum(cdhwd{1,1}(zp,z))];  
        xx{i,2}=[xx{i,2},nansum(cdhwe{1,1}(zp,z))];
        %%% far fut
        ff_sev=sev(39:76,z);
        zp=find(ff_sev>obs_thsev(j,2));
        
        xx{i,3}=[xx{i,3},nansum(cdhwd{2,1}(zp,z))];  
        xx{i,4}=[xx{i,4},nansum(cdhwe{2,1}(zp,z))];
    end
end
save('L:\map_matrix\severity_model_wise\CDHW_event_N_days\90\CDHW_after_considering_severity_threshold.mat','xx');


%% step-4

%{
Creating the change in CDHW events in the future for all the scenario;



%}
clear;clc;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
%%% observed severity values ( it contains the latlons where the
%%% cdhweve>30)
thsev=load('L:\map_matrix\severity_model_wise\observation_parameters\severity_obs_data90percentile.mat');
obs_thsev=thsev.obs_thsev; % obseerved threshold severity values

%%% observed data (number of cdhw events per year)
data=load('L:\map_matrix\severity_model_wise\observation_parameters\CDHW_obsdata_values90.mat');
ncdhweve_obs=data.cdhwevent;
ncdhw_obs=nanmean(ncdhweve_obs,1);
cdhwd_obs1=data.cdhwd;
cdhwd_obs=nansum(cdhwd_obs1,1);
%%% for all the models
data=load('L:\map_matrix\severity_model_wise\CDHW_event_N_days\90\CDHW_after_considering_severity_threshold.mat');
cdhw=data.xx;


% %% change in cdhwevents/year
% %%%%%%%% final matrix
% final=[];
% final(:,1:2)=latlon(obs_thsev(:,1),:);
% final(:,3)=ncdhw_obs(1,obs_thsev(:,1))'; % obs
% ssp1=[];ssp2=[];ssp3=[];
% for i=1:9
%     ssp1=[ssp1;cdhw{i,1}];
%     ssp2=[ssp2;cdhw{i+9,1}];
%     ssp3=[ssp3;cdhw{i+18,1}];
% end
% final(:,4)=nanmean(ssp1,1)'; %nf-ssp126
% final(:,5)=nanmean(ssp2,1)'; %nf-ssp245
% final(:,6)=nanmean(ssp3,1)';%nf-ssp585
% 
% ssp1=[];ssp2=[];ssp3=[];
% for i=1:3
%     ssp1=[ssp1;cdhw{i,3}];
%     ssp2=[ssp2;cdhw{i+9,3}];
%     ssp3=[ssp3;cdhw{i+18,3}];
% end
% final(:,7)=nanmean(ssp1,1)'; %ff-ssp126
% final(:,8)=nanmean(ssp2,1)'; %ff-ssp245
% final(:,9)=nanmean(ssp3,1)';%ff-ssp585
% 
% %%%% save it
% 
% writematrix(round(final,4),'L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\cdhwevents_peryear_matrix_absoulte_values90.txt','delimiter','\t');

% for i=3:9
% ksdensity(final(:,i));hold on;
% legend;
% end


%% return period
%%%%%%%% final matrix
final=[];
final(:,1:2)=latlon(obs_thsev(:,1),:);
final(:,3)=ncdhw_obs(1,obs_thsev(:,1))'; % obs
ssp1=[];ssp2=[];ssp3=[];
for i=[1:2,5:9]
    ssp1=[ssp1;cdhw{i,1}];
    ssp2=[ssp2;cdhw{i+9,1}];
    ssp3=[ssp3;cdhw{i+18,1}];
end
final(:,4)=nanmean(ssp1,1)'; %nf-ssp126
final(:,5)=nanmean(ssp2,1)'; %nf-ssp245
final(:,6)=nanmean(ssp3,1)';%nf-ssp585

ssp1=[];ssp2=[];ssp3=[];
for i=[1:2,5:9]
    ssp1=[ssp1;cdhw{i,3}];
    ssp2=[ssp2;cdhw{i+9,3}];
    ssp3=[ssp3;cdhw{i+18,3}];
end
final(:,7)=nanmean(ssp1,1)'; %ff-ssp126
final(:,8)=nanmean(ssp2,1)'; %ff-ssp245
final(:,9)=nanmean(ssp3,1)';%ff-ssp585


RP=final;
RP(:,3:end)=1./(final(:,3:end)./(38*184))/365;
RP(isinf(RP))=NaN;
writematrix(round(RP,4),'L:\map_matrix\severity_model_wise\Plot-3 Task values\cdhwevents_peryear_matrix_absoulte_values90.txt','delimiter','\t');

% ti={'obs','Nssp245','Nssp585','Fssp245','Fssp585'};
for i=3:9
subplot(4,2,i-2);
ksdensity(RP(:,i));hold on;grid on;
% legend(ti{1,i-2});
end
%%

final=[];
final(:,1:2)=latlon(obs_thsev(:,1),:);
final(:,3)=ncdhw_obs(1,obs_thsev(:,1))'; % obs
ssp1=[];ssp2=[];ssp3=[];
for i=1:9
    ssp1=[ssp1;cdhw{i,1}];
    ssp2=[ssp2;cdhw{i+9,1}];
    ssp3=[ssp3;cdhw{i+18,1}];
end
for i=1:9
    final(:,3+i)=ssp1(i,:);
end
RP=final;
RP(:,3:end)=1./(final(:,3:end)./(38*184))/365;
RP(isinf(RP))=NaN;

for i=3:12
subplot(4,3,i-2);
ksdensity(RP(:,i));hold on;grid on;
% legend(ti{1,i-2});
end



