clear;clc;
%% obs data
data=importdata(['L:\map_matrix\severity_model_wise\observation_parameters\CDHW_obsdata_values95.mat']);
obs_cdhwe=data.cdhwevent;
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
    for j=1:9
        temp=[temp,cdhwe{j,1}(:,i)];
    end
    cdhwev=[cdhwev,nanmean(temp,2)]; % model evg
end

fcdhwe=[obs_cdhwe;cdhwev];
%% num of cdhw events vs. area
count=[];
sfcdhwe=sort(fcdhwe,2);
for i=1:size(fcdhwe,1)
    count=[count;[mean(sfcdhwe(i,end-499:end)),mean(sfcdhwe(i,end-1499:end)),mean(sfcdhwe(i,end-2499:end)),...
        mean(sfcdhwe(i,:))]];
end
count=count(77:114,:);    
year=[2058:2095]';
myfun_areathreshold(year,count);



    
    
