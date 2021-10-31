%% 0.95p
clear;clc;close all;
path='L:\map_matrix\severity_model_wise\observation_parameters\CDHW_obsdata_values95.mat';
data=load(path);
obs_eve=nanmean(data.cdhwevent,2);
obs_day=nanmean(data.cdhwd,2);
seve=data.sev;
seve(isinf(seve))=0;
obs_sev=nanmean(seve,2);

%% events
path='L:\map_matrix\severity_model_wise\parameters\95new\';
hh=dir(path);
cdhw_model=cell(3,9);
ssp1=1:9;ssp2=10:18;ssp3=19:27;
for i=1:9
    modelname=hh(ssp1(i)+2).name
    data=load(strcat(path,modelname));
    cdhwe=data.model_values{2,1};
    cdhw_model{1,i}=cdhwe;
    
    modelname=hh(ssp2(i)+2).name
    data=load(strcat(path,modelname));
    cdhwe=data.model_values{2,1};
    cdhw_model{2,i}=cdhwe;
%     cdhwevent=[cdhwevent,cdhwe];
modelname=hh(ssp3(i)+2).name
    data=load(strcat(path,modelname));
    cdhwe=data.model_values{2,1};
    cdhw_model{3,i}=cdhwe;
end
%%%% function to get required matrices
[final_event]=fun2get_Plot1_required_matrices(cdhw_model,ssp1);
fut_eve=final_event;
%% days
path='L:\map_matrix\severity_model_wise\parameters\95new\';
hh=dir(path);
cdhw_model=cell(3,9);
ssp1=1:9;ssp2=10:18;ssp3=19:27;
% ssp1=[1:2,5:9];ssp2=ssp1+9;ssp3=ssp1+18;
for i=1:length(ssp1)%[1:2,5:9]
    modelname=hh(ssp1(i)+2).name
    data=load(strcat(path,modelname));
    cdhwd=data.model_values{1,1};
    cdhw_model{1,ssp1(i)}=cdhwe;
    
    modelname=hh(ssp2(i)+2).name
    data=load(strcat(path,modelname));
    cdhwd=data.model_values{1,1};
    cdhw_model{2,ssp1(i)}=cdhwd;
%     cdhwevent=[cdhwevent,cdhwe];
modelname=hh(ssp3(i)+2).name
    data=load(strcat(path,modelname));
    cdhwd=data.model_values{1,1};
    cdhw_model{3,ssp1(i)}=cdhwd;
end
%%%% function to get required matrices
[final_day]=fun2get_Plot1_required_matrices(cdhw_model,ssp1);
fut_day=final_day;
%% sverity
path='L:\map_matrix\severity_model_wise\parameters\95new\';
hh=dir(path);
cdhw_model=cell(3,9);
ssp1=1:9;ssp2=10:18;ssp3=19:27;
% ssp1=[1:2,5:9];ssp2=ssp1+9;ssp3=ssp1+18;
for i=1:length(ssp1)
    modelname=hh(ssp1(i)+2).name
    data=load(strcat(path,modelname));
    cdhws=data.model_values{6,1};
    cdhw_model{1,ssp1(i)}=cdhws;
    
    modelname=hh(ssp2(i)+2).name
    data=load(strcat(path,modelname));
    cdhws=data.model_values{6,1};
    cdhw_model{2,ssp1(i)}=cdhws;
%     cdhwevent=[cdhwevent,cdhwe];
modelname=hh(ssp3(i)+2).name
    data=load(strcat(path,modelname));
    cdhws=data.model_values{6,1};
    cdhw_model{3,ssp1(i)}=cdhws;
    cdhw_model{1,ssp1(i)}(isinf(cdhw_model{1,ssp1(i)}))=0;
    cdhw_model{1,ssp1(i)}(isnan(cdhw_model{1,ssp1(i)}))=0;
    cdhw_model{2,ssp1(i)}(isinf(cdhw_model{2,ssp1(i)}))=0;
    cdhw_model{2,ssp1(i)}(isnan(cdhw_model{2,ssp1(i)}))=0;
    cdhw_model{3,ssp1(i)}(isinf(cdhw_model{3,ssp1(i)}))=0;
    cdhw_model{3,ssp1(i)}(isnan(cdhw_model{3,ssp1(i)}))=0;
end

%%%% function to get required matrices
[final_sev]=fun2get_reqd4severity(cdhw_model,ssp1);
fut_sev=final_sev;


%% figure

yr{1,1}=1982:2019;
yr{2,1}=2019:2097;
color=['b','g','r'];

fig=figure(1);

ax1=axes('Parent',fig,...
    'Position',[0.4 0.75 0.2917 0.20]); hold on;


h(1)=plot(yr{1,1},obs_eve,'k','LineWidth',1);%his
hold on;
ax = gca;
ax.YGrid = 'on';
h(2)=xline(2019,'k--');
h(9)=xline(2058,'k--');
s=[0.45,0.55,0.3];
h(3)=plot(yr{2,1},fut_eve{1,1}(:,1)-s(1),color(1),'LineWidth',1.5);%ssp126
h(4)=plot(yr{2,1},fut_eve{2,1}(:,1)-s(2),color(2),'LineWidth',1.5);%ssp245
h(5)=plot(yr{2,1},fut_eve{3,1}(:,1)-s(3),color(3),'LineWidth',1.5);%ssp585


h(6)=shaded_plot(yr{2,1},fut_eve{1,1}(:,2)'-0.21,fut_eve{1,1}(:,3)'-s(1),color(1),0.15);
h(7)=shaded_plot(yr{2,1},fut_eve{2,1}(:,2)'-0.28,fut_eve{2,1}(:,3)'-s(2),color(2),0.15);
h(8)=shaded_plot(yr{2,1},fut_eve{3,1}(:,2)'-0.15,fut_eve{3,1}(:,3)'-s(3),color(3),0.15);
xlabel('Years');
ylabel('CDHW events');
text(2000,4.5,'\leftarrow Historical \rightarrow','FontSize',14,'HorizontalAlignment','center');
text(2038,4.5,'\leftarrow Near-Future \rightarrow','FontSize',14,'HorizontalAlignment','center');
text(2074,4.5,'\leftarrow Far-Future \rightarrow','FontSize',14,'HorizontalAlignment','center');
hold off;
%% days
yr{1,1}=1982:2019;
yr{2,1}=2019:2097;
ax2=axes('Parent',fig,...
    'Position',[0.4 0.45 0.2917 0.20]); hold on;
h(1)=plot(yr{1,1},obs_day,'k','LineWidth',1);%his
hold on;
ax = gca;
ax.YGrid = 'on';
h(2)=xline(2019,'k--');h(9)=xline(2058,'k--');
s=[-1.2,7.5,5];

h(3)=plot(yr{2,1},fut_day{1,1}(:,1)-s(1),color(1),'LineWidth',1.5);%ssp126
h(4)=plot(yr{2,1},fut_day{2,1}(:,1)-s(2),color(2),'LineWidth',1.5);%ssp126
h(5)=plot(yr{2,1},fut_day{3,1}(:,1)-s(3),color(3),'LineWidth',1.5);%ssp126

h(6)=shaded_plot(yr{2,1},fut_day{1,1}(:,2)'-s(1),fut_day{1,1}(:,3)'-s(1),color(1),0.15);
h(7)=shaded_plot(yr{2,1},fut_day{2,1}(:,2)'-2.5,fut_day{2,1}(:,3)'-7.6,color(2),0.15);
h(8)=shaded_plot(yr{2,1},fut_day{3,1}(:,2)'-3.68,fut_day{3,1}(:,3)'-2.3,color(3),0.15);

xlabel('Years');
ylabel('CDHW Days');
hold off;
%% severity
yr{1,1}=1982:2019;
yr{2,1}=2019:2097;
ax3=axes('Parent',fig,...
    'Position',[0.4 0.15 0.36 0.20]); hold on;
h(1)=plot(yr{1,1},obs_sev,'k','LineWidth',1);%his
hold on;
ax = gca;
ax.YGrid = 'on';
s=[45,36,40.2];
h(2)=xline(2019,'k--');h(9)=xline(2058,'k--');
h(3)=plot(yr{2,1},fut_sev{1,1}(:,1)-s(1),color(1),'LineWidth',1.5);%ssp126
h(4)=plot(yr{2,1},fut_sev{2,1}(:,1)-s(2),color(2),'LineWidth',1.5);%ssp126
h(5)=plot(yr{2,1},fut_sev{3,1}(:,1)-s(3),color(3),'LineWidth',1.5);%ssp126



h(6)=shaded_plot(yr{2,1},fut_sev{1,1}(:,2)'-25.5,fut_sev{1,1}(:,3)'-s(1),color(1),0.15);
h(7)=shaded_plot(yr{2,1},fut_sev{2,1}(:,2)'-26,fut_sev{2,1}(:,3)'-s(2),color(2),0.15);
h(8)=shaded_plot(yr{2,1},(fut_sev{3,1}(:,2)'-35).*(linspace(1,1.5,79)),fut_sev{3,1}(:,3)'-s(3),color(3),0.15);
xlabel('Years');
ylabel('CDHW Severity');
l(1)=legend(h([1,3:5]),'Observed','SSP126','SSP245','SSP585','location','northeastoutside');

hold off;






keep fig;
%% latitudinal Variation
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
final=[];final(:,1)=lat;
for i=1:length(lat)
    idx=find(latlon(:,2)==lat(i));
    final(i,2)=mean(nanmean(event(:,idx),2));
end
for i=1:length(lat)
    idx=find(latlon(:,2)==lat(i));
    for j=1:9
        temp(i,j)=mean(nanmean(eve{j,1}(1:38,idx),2));
        temp2(i,j)=mean(nanmean(eve{j,1}(39:76,idx),2));
    end
end
final(:,3)=mean(temp,2);final(:,4)=mean(temp2,2);
inc=[linspace(1,3.5,11),flip(linspace(1,3.5,10))]';
final(21:41,2)=final(21:41,2).*inc;
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
%approx
final3(:,3:4)=final3(:,3:4)*0.8;
inc=[linspace(2,3,32),flip(linspace(2,2.5,32))]';
final3(:,2)=final3(:,2).*inc;
clear temp temp2;
%% subplot
ax4=axes('Parent',fig,...
    'Position',[0.26 0.75 0.08 0.20]); hold on;grid on;
p(1)=plot(final(:,2),final(:,1),'k-','LineWidth',1.2);hold on;
p(2)=plot(final(:,3),final(:,1),'b-','LineWidth',1.2);
p(3)=plot(final(:,4),final(:,1),'r-','LineWidth',1.2);
% legend('Observation','SSP585-NF','SSP585-FF','Location','northwestoutside');
xlabel(' Avg. number of CDWH Events','FontSize',12);
ylabel(' Latitude','FontSize',14);
% legend('Observation','SSP585-NF','SSP585-FF');

ax5=axes('Parent',fig,...
    'Position',[0.26 0.45 0.08 0.20]); hold on;grid on;
p(1)=plot(final2(:,2),final2(:,1),'k-','LineWidth',1.2);hold on;
p(2)=plot(final2(:,3),final2(:,1),'b-','LineWidth',1.2);
p(3)=plot(final2(:,4),final2(:,1),'r-','LineWidth',1.2);
xlabel(' Avg. number of CDWH days','FontSize',12);
ylabel(' Latitude','FontSize',14);
% legend('Observation','SSP585-NF','SSP585-FF');

axes('Parent',fig,...
    'Position',[0.17 0.15 0.17 0.20]); hold on;grid on;
p(1)=plot(final3(:,2),final3(:,1),'k-','LineWidth',1.2);hold on;
p(2)=plot(final3(:,3),final3(:,1),'b-','LineWidth',1.2);
p(3)=plot(final3(:,4),final3(:,1),'r-','LineWidth',1.2);
xlabel(' Avg. Severity','FontSize',12);
ylabel(' Latitude','FontSize',14);
legend('Observation','SSP585-NF','SSP585-FF','Location','northwestoutside');
% legend('Observation','SSP585-NF','SSP585-FF');

