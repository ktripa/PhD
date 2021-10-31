function []=gridwise_weeklyP_calculation4scPDSI(model,ssp,model_name)
%% load the historical data
histpath='L:\Data_preprocess\MainDataFile\Historical';
hist_dir=dir(histpath);
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
scenario=['ssp126','ssp245','ssp545'];
for i=3:9
    modelname=hist_dir(i+2).name
    datahis=load(modelname);
    datahis(datahis(:,1)<=1981,:)=[]; % 1982-2014
    for kk=1:3
        ssp=scenario(kk,:);
        
end






[a,b]=func_to_calc_daily2weekly(datahis,latlon);



%% scenario
clear data data19802100;
ssp='ssp126';
path=strcat('L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\',ssp);
h=dir(path);
cd (path);
%for model=1:9
data=load(h(model+4).name);
data(data(:,1)>=2100,:)=[];
%% concatenate the historical and scenario data
data19802100=[a;data(3:end,:)];
data=data19802100;
%%


start_year=min(data(:,1));
end_year=max(data(:,1));
n_weeks=52;
tic
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
    final=round(final,2);
    savepath=strcat('L:\sc_PDSI_calc\',ssp);
    dir_savepath=dir(savepath);
    model_name=dir_savepath(model+2).name;
%     disp([grid_index]);
    delete (strcat(savepath,'\',model_name,'\',num2str(grid_index-3),'\','weekly_P.txt'));
    dlmwrite(strcat(savepath,'\',model_name,'\',num2str(grid_index-3),'\','weekly_P'),final,'delimiter','\t');
    disp([ssp,grid_index,model])
end
toc

%writematrix(final,weekly_P
%end
