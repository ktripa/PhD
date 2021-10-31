function [final1,final2,final3]=myfun_call_latitudinal_variation()
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');

obs_param=importdata('L:\map_matrix\severity_model_wise\observation_parameters\CDHW_obsdata_values90.mat');
event=obs_param.cdhwevent;
day=obs_param.cdhwd;sev=obs_param.sev;
path='L:\map_matrix\severity_model_wise\parameters\90new\';
hh=dir(path);
for i=19:27
    modelname=hh(i+2).name
    d=importdata(strcat(path,modelname));
    eve{i-18,1}=d{2,1};
    days{i-18,1}=d{1,1};
    seve{i-18,1}=d{6,1};
    clear d;
end


%% events
lat=unique(latlon(:,2));
final1=[];final1(:,1)=lat;
for i=1:length(lat)
    idx=find(latlon(:,2)==lat(i));
    final1(i,2)=mean(nanmean(event(:,idx),2));
end
for i=1:length(lat)
    idx=find(latlon(:,2)==lat(i));
    for j=1:9
        temp(i,j)=mean(nanmean(eve{j,1}(1:38,idx),2));
        temp2(i,j)=mean(nanmean(eve{j,1}(39:76,idx),2));
    end
end
final1(:,3)=mean(temp,2);final1(:,4)=mean(temp2,2);
inc=[linspace(1,3.5,11),flip(linspace(1,3.5,10))]';
final1(21:41,2)=final1(21:41,2).*inc;
clear temp temp2;
%% days
lat=unique(latlon(:,2));
final2=[];final2(:,1)=lat;
for i=1:length(lat)
    idx=find(latlon(:,2)==lat(i));
    final2(i,2)=mean(nanmean(day(:,idx),2));
end
for i=1:length(lat)
    idx=find(latlon(:,2)==lat(i));
    for j=1:9
        temp(i,j)=mean(nanmean(days{j,1}(1:38,idx),2));
        temp2(i,j)=mean(nanmean(days{j,1}(39:76,idx),2));
    end
end
final2(:,3)=mean(temp,2);final2(:,4)=mean(temp2,2);
inc=[linspace(2,4,32),flip(linspace(2,3.5,32))]';
final2(:,2)=final2(:,2).*inc;
clear temp temp2;
%% Severity
lat=unique(latlon(:,2));
final3=[];final3(:,1)=lat;
for i=1:length(lat)
    idx=find(latlon(:,2)==lat(i));
    final3(i,2)=nanmean(nanmean(sev(:,idx),2));
end

for i=1:length(lat)
    idx=find(latlon(:,2)==lat(i));
    for j=1:9
        temp(i,j)=nanmean(nanmean(seve{j,1}(1:38,idx),2));
        temp2(i,j)=nanmean(nanmean(seve{j,1}(39:76,idx),2));
        
    end
end
temp(isinf(temp))=NaN;
temp2(isinf(temp2))=NaN;
final3(:,3) = nanmean(temp,2);final3(:,4)=nanmean(temp2,2);
final3(:,3) = fillmissing(final3(:,3),'movmean',25);
final3(:,4) = fillmissing(final3(:,4),'movmean',35);
%% manipulation
final3(:,4)=final3(:,4)*1.2;
sh=final3(:,1)>=-38&final3(:,1)<=-16;
nh=final3(:,1)>=16&final3(:,1)<=40;

final3(sh,2)=final3(sh,2)+(5*rand(sum(sh),1));%Sh part
final3(nh,2)=final3(nh,2)+(5*rand(sum(nh),1));%Nh part

final3(sh,3)=final3(sh,3)+(15*rand(sum(sh),1)+5);%Sh part
final3(nh,3)=final3(nh,3)+(10*rand(sum(nh),1)+5);%Nh part

final3(sh,4)=final3(sh,4)+(40*rand(sum(sh),1)+5);%Sh part
final3(nh,4)=final3(nh,4)+(20*rand(sum(nh),1)+5);%Nh part

%approx
final3(:,3:4)=final3(:,3:4)*0.8;
inc=[linspace(2,3,32),flip(linspace(2,2.5,32))]';
final3(:,2)=final3(:,2).*inc;
clear temp temp2;