function []=gridwise_weeklyP_calculation4scPDSI_obsdata
data=load('J:\Data_preprocess\MainDataFile\GPCC_data_weekly.txt');
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
    dlmwrite(strcat('J:\sc_PDSI_calc\obsdata\1982_2019\',num2str(grid_index-3),'\','weekly_P'),final,'delimiter','\t');
end
