clear;clc;close;
%%% first part of this code is already run and saved.. go to the next part
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
th=load('L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\JointMaxThreshold_Observation95');

path='L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\95new\';
hh=dir(path);

for model=1:length(hh)-2
    filename=hh(model+2).name
    data=load([path,filename]);
    disp(model)
    n=1;fut=[];
    for i=1:length(th(:,1))
        
        datf=data.output{i,1};
        if th(i,2)>=0
            znf=find(datf(:,1)>=2020&datf(:,1)<=2057&datf(:,2)>=5&datf(:,2)<=10);
            zff=find(datf(:,1)>=2058&datf(:,1)<=2099&datf(:,2)>=5&datf(:,2)<=10);
            
        else
            znf=find(datf(:,1)>=2020&datf(:,1)<=2057&datf(:,2)>=11|datf(:,1)>=2020&datf(:,1)<=2057&datf(:,2)<=4);
            zff=find(datf(:,1)>=2058&datf(:,1)<=2099&datf(:,2)>=11|datf(:,1)>=2058&datf(:,1)<=2099&datf(:,2)<=4);
            
        end
        if length(datf(1,:))==15
            fut(n,1:2)=th(i,1:2);
            fut(n,3)=1/((size(find(datf(znf,13)>=th(i,3)&datf(znf,14)>=th(i,4)),1)/size(znf,1))*365);
            fut(isinf(fut(:,3)),3)=NaN;
            %%% far future 
            fut(n,4)=1/((size(find(datf(zff,13)>=th(i,3)&datf(zff,14)>=th(i,4)),1)/size(zff,1))*365);
            fut(isinf(fut(:,4)),4)=NaN;
            n=n+1;
        else
        end
    end
    writematrix(round(fut,4),['L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\RP_matrix\95\RP_matrix95',...
        filename(end-7:end-4),'.txt'],'delimiter','\t')
    clear data;
end
%% Rp_obs
clear;clc;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
filename='L:\Master_matrix\obsdata\final3d_obsdata_master_matrix95.mat';
data=importdata(filename);
n=1;fut=[];
for i=1:length(data)
    datf=data{i,1};
    if latlon(i,2)>=0
        z=find(datf(:,1)>=1982&datf(:,1)<=2019&datf(:,2)>=5&datf(:,2)<=10);
    else
        z=find(datf(:,1)>=1982&datf(:,1)<=2019&datf(:,2)>=11|datf(:,1)>=1982&datf(:,1)<=2019&datf(:,2)<=4);
    end
    if length(datf(1,:))==15
        fut(n,1:2)=latlon(i,1:2);
        fut(n,3)=1/((sum(datf(z,12)==1)/size(z,1))*365);
        fut(isinf(fut(:,3)),3)=NaN;
        n=n+1;
    end
end
writematrix(round(fut,4),['L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\RP_matrix_obs_spatial_data.txt',...
        ],'delimiter','\t')