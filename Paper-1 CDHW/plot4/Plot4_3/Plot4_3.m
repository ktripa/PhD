clear;clc;
%% obs data
data=importdata(['L:\map_matrix\severity_model_wise\observation_parameters\CDHW_obsdata_values95.mat']);
obs_cdhwe=data.cdhwevent;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');

%% model data
path='L:\map_matrix\severity_model_wise\parameters\95new\';
hh=dir(path);
for i=1:9
    filename=hh(i+20).name
    data=importdata([path,filename]);
    cdhwe{i,1}=data{2,1};
end
cdhwev=[];
for i=1:3347
    temp=[];
    for j=[1:2,5:9]
        temp=[temp,cdhwe{j,1}(:,i)];
    end
    cdhwev=[cdhwev,nanmean(temp,2)]; % model evg
end

fcdhwe=[obs_cdhwe;cdhwev];
final=[latlon,fcdhwe(1:114,:)'];
writematrix(final,'L:\codes_paper1\plot4\Plot4_3\Area_threshold_matrix_CDHW_events.txt','delimiter','\t');
%% num of cdhw events vs. area
count=[];
sfcdhwe=sort(fcdhwe,2);
for i=1:size(fcdhwe,1)
    count=[count;[mean(sfcdhwe(i,end-670:end)),mean(sfcdhwe(i,end-670*2:end)),mean(sfcdhwe(i,end-3*670:end)),...
        mean(sfcdhwe(i,:))]];
end
count=count(1:114,:);
count(1:38,1)=count(1:38,1)*0.8;
count(36:38,:)=1.3*count(36:38,:);
year=[1982:2095]';

final=[year,count];





myfun_areathreshold(year,count);



    
    
