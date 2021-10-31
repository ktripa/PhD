%% obs data (considering 90 percentile threshold in tmax data)
clear;clc;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
data1=load('L:\Master_matrix\obsdata\final3d_obsdata_master_matrix.mat');
final=data1.final3d;
for i=1:3347
   data=final{i,1};
    try
        n=1;
        for yr=1982:2019
            if latlon(i,2)>=0
                z=find(data(:,1)==yr&data(:,2)>=5&data(:,2)<=10); % Northern Hemisphere
                cdhwd(n,i)=nansum(data(z,12));
                dr(n,i)=nansum(data(z,9));
                hwv(n,i)=nansum(data(z,10));
                
                cdhwr(n,i)=nansum(data(z,12))/nansum(data(z,10));
                cdhwevent(n,i)=nansum(data(z,14)>0);
                sev(n,i)=nansum(data(z,13))/cdhwevent(n,i);
            else
                z=find(data(:,1)==yr&data(:,2)>=11|data(:,1)==yr&data(:,2)<=4); % Southern Hemisphere
                cdhwd(n,i)=nansum(data(z,12));
                dr(n,i)=nansum(data(z,9));
                hwv(n,i)=nansum(data(z,10));
                cdhwr(n,i)=nansum(data(z,12))/nansum(data(z,10));
                cdhwevent(n,i)=nansum(data(z,14)>0);
                sev(n,i)=nansum(data(z,13))/cdhwevent(n,i);
            end
            n=n+1;
        end
    catch
    end
    disp(i);
end
save('L:\map_matrix\severity_model_wise\CDHW_obsdata_values90.mat','cdhwd','cdhwr','dr','hwv','cdhwevent','sev');

%% obs data (considering 95 percentile threshold in tmax data)
clear;clc;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
data1=load('L:\Master_matrix\obsdata\final3d_obsdata_master_matrix95.mat');
final=data1.final3d;
for i=1:3347
   data=final{i,1};
    try
        n=1;
        for yr=1982:2019
            if latlon(i,2)>=0
                z=find(data(:,1)==yr&data(:,2)>=5&data(:,2)<=10); % Northern Hemisphere
                cdhwd(n,i)=nansum(data(z,12));
                dr(n,i)=nansum(data(z,9));
                hwv(n,i)=nansum(data(z,10));
                
                cdhwr(n,i)=nansum(data(z,12))/nansum(data(z,10));
                cdhwevent(n,i)=nansum(data(z,14)>0);
                sev(n,i)=nansum(data(z,13))/cdhwevent(n,i);
            else
                z=find(data(:,1)==yr&data(:,2)>=11|data(:,1)==yr&data(:,2)<=4); % Southern Hemisphere
                cdhwd(n,i)=nansum(data(z,12));
                dr(n,i)=nansum(data(z,9));
                hwv(n,i)=nansum(data(z,10));
                cdhwr(n,i)=nansum(data(z,12))/nansum(data(z,10));
                cdhwevent(n,i)=nansum(data(z,14)>0);
                sev(n,i)=nansum(data(z,13))/cdhwevent(n,i);
            end
            n=n+1;
        end
    catch
    end
    disp(i);
end

save('L:\map_matrix\severity_model_wise\observation_parameters\CDHW_obsdata_values95.mat','cdhwd','cdhwr','dr','hwv','cdhwevent','sev');






