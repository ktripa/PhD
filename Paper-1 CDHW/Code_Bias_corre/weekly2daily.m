function [daily_pdsi]=weekly2daily(ssp,modelname)
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt')';
% start_year=min(data(:,1));
% end_year=max(data(:,1));
start_year=1982;
end_year=2100;
len_year=end_year-start_year;
t1 = datetime(start_year,1,1); %% check in the netcdf file and see what is the initial time from when the time count starts
t2 = datetime(end_year,12,31);
time=[t1:days(1):t2]; 
[y,m,d]=ymd(time);
date=[y',m',d'];

%% initialize a matrix that will hold the daily pdsi for all the grids
mat=nan(length(date),3347);
for grid =1:3347
    try
        data=load(strcat('L:\sc_PDSI_calc\',ssp,'\',modelname,'\',num2str(grid),'\weekly\1\PDSI.tbl'));
        data(data==-99)=NaN;
        for i=1:len_year
            
            first_index_year=find(date(:,1)==start_year+i-1,1); %first index of year in date vector
            last_index_year=find(date(:,1)==start_year+i-1);
            last_index_year=last_index_year(end); %% last index of year
            index=find(data(i,1)==date(:,1));
            every_row_data=reshape(data(i,2:end).',[],1);
            r=repmat(every_row_data,1,7)';
            r=r(:);
            length_index=length(index);
            length_r=length(r);
            dev=length_index-length_r;
            mat(first_index_year:first_index_year+length_r-1,grid)=r;
            if dev==1
                mat(last_index_year,grid)=r(end);
            else
                mat(last_index_year-1:last_index_year,grid)=r(end);
            end
           
        end
    catch
        
    end
end

final=[[[NaN,NaN,NaN];[NaN,NaN,NaN]],latlon;date,mat];
writematrix(final,strcat('L:\sc_pdsi_daily_1982_2100\',ssp,'\',strcat(modelname,'_daily_pdsi_1982_2100.txt')),'delimiter','\t');
