clear;clc;close;
%%%% import the historical GCM data
path='K:\CMIP6_data\CMIP6_rg\Historical\';
hh=dir(path);
for i=1:length(hh)-2
    tic
    tmax=hh(i+11).name
    fname_tmax=strcat(path,tmax);
    tmin=hh(i+20).name
    fname_tmin=strcat(path,tmin);
    [dateh{i},outh{i},pid{i}]=myfun_to_calculate_global_mean_temp_1961_1990(fname_tmax,fname_tmin);
    toc
end
save('temporary_historical_timeseries.mat','dateh','pid','outh');
%%% import the GCM future data
path='K:\CMIP6_data\CMIP6_rg\ssp545\';
hh=dir(path);
datef=cell(1,9);outf=cell(1,9);
for i=[7,1:6,8:9]
    tic
    tmax=hh(i+11).name
    fname_tmax=strcat(path,tmax);
    tmin=hh(i+20).name
    fname_tmin=strcat(path,tmin);
    [datef{i},outf{i}]=myfun_to_calculate_future_ts(fname_tmax,fname_tmin);
    toc
end
save('temporary_future_timeseries.mat','datef','outf');
%% load the data
clear;clc;close;
his=load('L:\codes_paper1\figure4\data_figure4\temporary_historical_timeseries.mat');
fut=load('L:\codes_paper1\figure4\data_figure4\temporary_future_timeseries.mat');    
dh=his.outh;df=fut.outf;
temph=[];tempf=[];
for i=1:9
    temph=[temph,dh{i}(:,end)];
    tempf=[tempf,df{i}(:,end)];
end
%%% MME
ts=[temph;tempf];
MME=[(1850:2099)',nanmean(ts,2)];
%%% period (1982-2019)
pid=nanmean(MME(MME(:,1)>=1982&MME(:,1)<=2019,2));
MME(:,3)=MME(:,2)-pid;
writematrix(MME,'L:\codes_paper1\figure4\data_figure4\Global_temp_anomaly_1850_2099','delimiter','\t');
%% temp anomaly
than=[0.5:0.5:3.5]';
thyr=[2016,2028,2038,2049,2057,2066,2073]';


    

















