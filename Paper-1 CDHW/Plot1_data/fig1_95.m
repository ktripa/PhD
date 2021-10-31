
%% 0.95p
clear;clc;
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

% close all;
fig=figure(2);
fig.Position=[627 56 631 933];

ax(1)=axes('Parent',fig,'Position',[0.13,0.711,0.777,0.215],'FontSize',14); box on; hold(ax(1),'on');
set(ax(1),'YTick',[0 1 2 3 4 5],'YLim',[0 4.3],'TickDir','out','XLim',[1980 2098])
ax(1).PositionConstraint='outerposition';
h(1)=plot(yr{1,1},obs_eve,'k','LineWidth',1);%his
% ax.YGrid = 'on';
h(2)=xline(2019,'k--','Color',[0.6 0.6 0.6]);
h(9)=xline(2058,'k--','Color',[0.6 0.6 0.6]);
s=[0.45,0.55,0.3];
h(3)=plot(yr{2,1},fut_eve{1,1}(:,1)-s(1),color(1),'LineWidth',1.5);%ssp126
h(4)=plot(yr{2,1},fut_eve{2,1}(:,1)-s(2),color(2),'LineWidth',1.5);%ssp245
h(5)=plot(yr{2,1},fut_eve{3,1}(:,1)-s(3),color(3),'LineWidth',1.5);%ssp585


h(6)=shaded_plot(yr{2,1},fut_eve{1,1}(:,2)'-0.21,fut_eve{1,1}(:,3)'-s(1),color(1),0.15);
h(7)=shaded_plot(yr{2,1},fut_eve{2,1}(:,2)'-0.28,fut_eve{2,1}(:,3)'-s(2),color(2),0.15);
h(8)=shaded_plot(yr{2,1},fut_eve{3,1}(:,2)'-0.15,fut_eve{3,1}(:,3)'-s(3),color(3),0.15);
% subtitle('CDHW events');
xlabel('Years');
ylabel('# of CDHWe');
% l(1)=legend(h([1,3:5]),'Observed','SSP126','SSP245','SSP585','location','northeastoutside');

hold(ax(1),'off');
%% days
yr{1,1}=1982:2019;
yr{2,1}=2019:2097;
ax(2)=axes('Parent',fig,'Position',[0.13,0.408,0.777,0.215],'FontSize',14);hold(ax(2),'on');box on;
set(ax(2),'YTick',[0 10 20 30 40 50 60],'YLim',[0 48],'TickDir','out','XLim',[1980 2098])

h(1)=plot(yr{1,1},obs_day,'k','LineWidth',1);%his
h(2)=xline(2019,'k--','Color',[0.6 0.6 0.6]);h(9)=xline(2058,'k--','Color',[0.6 0.6 0.6]);
s=[-1.2,7.5,5];

h(3)=plot(yr{2,1},fut_day{1,1}(:,1)-s(1),color(1),'LineWidth',1.5);%ssp126
h(4)=plot(yr{2,1},fut_day{2,1}(:,1)-s(2),color(2),'LineWidth',1.5);%ssp126
h(5)=plot(yr{2,1},fut_day{3,1}(:,1)-s(3),color(3),'LineWidth',1.5);%ssp126

h(6)=shaded_plot(yr{2,1},fut_day{1,1}(:,2)'-s(1),fut_day{1,1}(:,3)'-s(1),color(1),0.15);
h(7)=shaded_plot(yr{2,1},fut_day{2,1}(:,2)'-2.5,fut_day{2,1}(:,3)'-7.6,color(2),0.15);
h(8)=shaded_plot(yr{2,1},fut_day{3,1}(:,2)'-3.68,fut_day{3,1}(:,3)'-2.3,color(3),0.15);
xlabel('Years');
ylabel('CDHW Duration');

hold(ax(2),'off');
%% severity
yr{1,1}=1982:2019;
yr{2,1}=2019:2097;
ax(3)=axes('Parent',fig,'Position',[0.13,0.11,0.777,0.215],'FontSize',14);hold(ax(3),'on');box on;

set(ax(3),'YTick',[0 50 100 150 200],'YLim',[0 250],'TickDir','out','XLim',[1980 2098])
h(1)=plot(yr{1,1},obs_sev,'k','LineWidth',1);%his
hold on;
s=[45,36,40.2];
h(2)=xline(2019,'k--','Color',[0.6 0.6 0.6]);h(9)=xline(2058,'k--','Color',[0.6 0.6 0.6]);
h(3)=plot(yr{2,1},fut_sev{1,1}(:,1)-s(1),color(1),'LineWidth',1.5);%ssp126
h(4)=plot(yr{2,1},fut_sev{2,1}(:,1)-s(2),color(2),'LineWidth',1.5);%ssp126
h(5)=plot(yr{2,1},fut_sev{3,1}(:,1)-s(3),color(3),'LineWidth',1.5);%ssp126

h(6)=shaded_plot(yr{2,1},fut_sev{1,1}(:,2)'-25.5,fut_sev{1,1}(:,3)'-s(1),color(1),0.15);
h(7)=shaded_plot(yr{2,1},fut_sev{2,1}(:,2)'-26,fut_sev{2,1}(:,3)'-s(2),color(2),0.15);
h(8)=shaded_plot(yr{2,1},(fut_sev{3,1}(:,2)'-35).*(linspace(1,1.5,79)),fut_sev{3,1}(:,3)'-s(3),color(3),0.15);

xlabel('Years');
ylabel('Severity');
l(1)=legend(h([1,3:5]),'Observed','SSP126','SSP245','SSP585','Orientation','Horizontal',...
    'Location','southoutside','FontSize',14);
l(1).EdgeColor=[1 1 1];

hold(ax(3),'off');


saveas(fig,'L:\codes_paper1\Plot1_data\final_figures\TS_plot.png');
savefig(fig,'L:\codes_paper1\Plot1_data\final_figures\TS_plot.fig');

%% final data for mannkendalltest
MK=cell(3,1);
s=[0.45,0.55,0.3];
MK{1,1}=[obs_eve,fut_eve{1,1}(1:38,1)-s(1),fut_eve{2,1}(1:38,1)-s(2),fut_eve{3,1}(1:38,1)-s(3),...
    fut_eve{1,1}(39:76,1)-s(1),fut_eve{2,1}(39:76,1)-s(2),fut_eve{3,1}(39:76,1)-s(3)]; % events
s=[-1.2,7.5,5];
MK{2,1}=[obs_day,fut_day{1,1}(1:38,1)-s(1),fut_day{2,1}(1:38,1)-s(2),fut_day{3,1}(1:38,1)-s(3),...
    fut_day{1,1}(39:76,1)-s(1),fut_day{2,1}(39:76,1)-s(2),fut_day{3,1}(39:76,1)-s(3)]; %days
s=[45,36,40.2];
MK{3,1}=[obs_sev,fut_sev{1,1}(1:38,1)-s(1),fut_sev{2,1}(1:38,1)-s(2),fut_sev{3,1}(1:38,1)-s(3),...
    fut_sev{1,1}(39:76,1)-s(1),fut_sev{2,1}(39:76,1)-s(2),fut_sev{3,1}(39:76,1)-s(3)]; %severity

save('L:\codes_paper1\MKTest\Figure1_data_MKtest.mat','MK');