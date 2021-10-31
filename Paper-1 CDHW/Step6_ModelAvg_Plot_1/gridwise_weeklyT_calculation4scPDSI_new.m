function []=gridwise_weeklyT_calculation4scPDSI_new(model,ssp,model_name,obsdata)
%% historical data
%% historical data
histpath='L:\Data_preprocess\MainDataFile\Historical';
hist_dir=dir(histpath);
modelname=hist_dir(model+11).name
datahis_max=load(modelname);
datahis_max(datahis_max(:,1)<=1981,:)=[]; % 1982-2014

modelname=hist_dir(model+20).name
datahis_min=load(modelname);
datahis_min(datahis_min(:,1)<=1981,:)=[]; % 1982-2014
datahis=(datahis_min+datahis_max)/2;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
[a,b]=func_to_calc_daily2weekly_temperature(datahis,latlon);
%% scenario

%% scenario
ssp='ssp545';
path=strcat('L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\',ssp,'\Tmean');
h=dir(path);
cd (path);
%% concatenate the obs data with the cmip6 model future data
data=load(h(model+2).name);
data(data(:,1)>=2100,:)=[];%% remove the years 2015-2019
xx=[a;data(3:end,:)];
data=xx;
clear xx obsdata;

%% calculation
start_year=min(data(:,1));
end_year=max(data(:,1));
n_weeks=52;
for grid_index=4:3350
    final=zeros(end_year-start_year+1,n_weeks+1);
    %% fill the values of final
    final(1:end,1)=start_year:end_year;
    for i=1:(end_year-start_year+1)
        start_col=find(data(:,1)==start_year-1+i,1);
        end_col=start_col+51;
        if end_col<=length(data)
            final(i,2:end)=data(start_col:end_col,grid_index);
        elseif end_col>length(data)
            cc=end_col-length(data);
            final(i,2:end-cc)=data(start_col:length(data),grid_index);
            final(i,end-cc+1:end)=final(i,2:cc+1);
        end
    end
    %%% convert kelvin to fahrenheit
    ab=convtemp(final(:,2:end),'K','F');
    final(:,2:end)=round(ab,2);
    final(isnan(final))=-99;
    dlmwrite(strcat('L:\sc_PDSI_calc\',ssp,'\',model_name,'\',num2str(grid_index-3),'\','weekly_T'),final,'delimiter','\t');
end