function []=gridwise_weeklyP_calculation4scPDSI(model,ssp,model_name,obsdata)

path=strcat('L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\',ssp);
h=dir(path);
cd (path);
%% concatenate the obs data with the cmip6 model future data
data=load(h(model+4).name);
start_year_index=find(data(:,1)==2020,1); 
data(1:start_year_index,:)=[]; %% remove the years 2015-2019
xx=[obsdata;data];
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
    final=round(final,2);
    final(isnan(final))=-99;
    dlmwrite(strcat('L:\sc_PDSI_calc\',ssp,'\',model_name,'\',num2str(grid_index-3),'\','weekly_P'),final,'delimiter','\t');
%     writematrix(final,strcat('J:\sc_PDSI_calc\',ssp,'\',model_name,'\',num2str(grid_index-3),'\','weekly_P'),'delimiter','\t');
end

%writematrix(final,weekly_P
%end
