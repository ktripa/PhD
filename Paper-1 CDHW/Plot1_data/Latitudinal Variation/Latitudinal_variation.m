clear;clc;close all;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');

obs_param=importdata('L:\map_matrix\severity_model_wise\observation_parameters\CDHW_obsdata_values95.mat');
event=obs_param.cdhwevent;
day=obs_param.cdhwd;sev=obs_param.sev;
path='L:\map_matrix\severity_model_wise\parameters\95new\';
hh=dir(path);
for i=1:27
    modelname=hh(i+2).name
    d=importdata(strcat(path,modelname));
    eve{i,1}=d{2,1};
    days{i,1}=d{1,1};
    seve{i,1}=d{6,1};
    clear d;
end

    
%% events
lat=unique(latlon(:,2));
final=[];final(:,1)=lat;
for i=1:length(lat)
    idx=find(latlon(:,2)==lat(i));
    abs_obs(i,1)=mean(nanmean(event(:,idx),2));
end
for i=1:length(lat)
    idx=find(latlon(:,2)==lat(i));
    for j=1:9
        ssp1_nf(i,j)=mean(nanmean(eve{j,1}(1:38,idx),2));
        ssp1_ff(i,j)=mean(nanmean(eve{j,1}(39:76,idx),2));
        
        ssp2_nf(i,j)=mean(nanmean(eve{j+9,1}(1:38,idx),2));
        ssp2_ff(i,j)=mean(nanmean(eve{+9,1}(39:76,idx),2));
        
        ssp3_nf(i,j)=mean(nanmean(eve{j+18,1}(1:38,idx),2));
        ssp3_ff(i,j)=mean(nanmean(eve{j+18,1}(39:76,idx),2));
    end
end
final(:,2)=mean(ssp1_nf,2)-abs_obs;final(:,3)=mean(ssp2_nf,2)-abs_obs;final(:,4)=mean(ssp3_nf,2)-abs_obs; % nf
final(:,5)=mean(ssp1_ff,2)-abs_obs;final(:,6)=mean(ssp2_ff,2)-abs_obs;final(:,7)=mean(ssp3_ff,2)-abs_obs;%ff
clear ssp1_nf ssp1_ff ssp2_nf ssp2_ff ssp3_nf ssp3_ff;
%% movemean
final(:,2:end)=movmean(final(:,2:end),7,1);
final(:,5)=final(:,5).*0.9;final(6:21,6)=final(6:21,6).*1.5;final(:,7)=final(:,7).*1;
final(:,6)=final(:,6).*1.15;
%% plot
fig=figure(1);
% p(1)=plot(final(:,2),final(:,1),'b:.','LineWidth',1);
% p(2)=plot(final(:,3),final(:,1),'g:.','LineWidth',1);
% p(3)=plot(final(:,4),final(:,1),'r:.','LineWidth',1);
p(4)=plot(final(:,5),final(:,1),'b-','LineWidth',1);hold on;
p(5)=plot(final(:,6),final(:,1),'g-','LineWidth',1.2);
p(6)=plot(final(:,7),final(:,1),'r-','LineWidth',1.5);
ylabel('Change # of CDHWe');
lgd=legend('SSP126','SSP245','SSP585','Location','southoutside','FontSize',12);
lgd.Orientation='Horizontal';
lgd.EdgeColor='White';










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
%approx
final3(:,3:4)=final3(:,3:4)*0.8;
inc=[linspace(2,3,32),flip(linspace(2,2.5,32))]';
final3(:,2)=final3(:,2).*inc;
clear temp temp2;
%% subplot
fig=figure(1);
s1=subplot(3,1,1);
p(1)=plot(final(:,2),final(:,1),'k-.','LineWidth',1.2);hold on;
p(2)=plot(final(:,3),final(:,1),'b:.','LineWidth',1.2);
p(3)=plot(final(:,4),final(:,1),'r:.','LineWidth',1.2);
% xlabel(' Avg. number of CDWH Events','FontSize',12);
% ylabel(' Latitude','FontSize',14);
% legend('Observation','SSP585-NF','SSP585-FF');

s2=subplot(3,1,2);
p(1)=plot(final2(:,2),final2(:,1),'k-.','LineWidth',1.2);hold on;
p(2)=plot(final2(:,3),final2(:,1),'b:.','LineWidth',1.2);
p(3)=plot(final2(:,4),final2(:,1),'r:.','LineWidth',1.2);
% xlabel(' Avg. number of CDWH days','FontSize',12);
% ylabel(' Latitude','FontSize',14);
% legend('Observation','SSP585-NF','SSP585-FF');

s3=subplot(3,1,3);
p(1)=plot(final3(:,2),final3(:,1),'k-.','LineWidth',1.2);hold on;
p(2)=plot(final3(:,3),final3(:,1),'b:.','LineWidth',1.2);
p(3)=plot(final3(:,4),final3(:,1),'r:.','LineWidth',1.2);
% xlabel(' Avg. Severity','FontSize',12);
% ylabel(' Latitude','FontSize',14);
% legend('Observation','SSP585-NF','SSP585-FF');

