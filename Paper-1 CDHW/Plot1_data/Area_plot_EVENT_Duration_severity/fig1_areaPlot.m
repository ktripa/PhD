clear;clc;close all;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
%% obs data
data=importdata(['L:\map_matrix\severity_model_wise\observation_parameters\CDHW_obsdata_values95.mat']);
obs{1,1}=data.cdhwevent;
obs{2,1}=data.cdhwd;
obs{3,1}=data.sev;
%% model data
path='L:\map_matrix\severity_model_wise\parameters\95new\';
hh=dir(path);
col=0;
for i=[1:2,5:9]
    col=col+1;% consider only ssp585 data
    filename=hh(i+20).name
    data=importdata([path,filename]);
    params{1,col}=data{2,1};
    params{2,col}=data{1,1};
    params{3,col}=data{6,1};
end
%%
cdhw_param=cell(3,1);
for param=1:3
    for i=1:3347
        temp=[];
        for j=1:7
            temp=[temp,params{param,j}(:,i)];
        end
        cdhw_param{param,1}=[cdhw_param{param,1},nanmean(temp,2)]; % model evg
    end
end
cdhw_param{3,1}(isinf(cdhw_param{3,1}))=NaN;
%% cat the obs data
par={[obs{1,1};cdhw_param{1,1}];[obs{2,1};cdhw_param{2,1}];[obs{3,1};cdhw_param{3,1}]};
% treatment of the nan values using movmean in the severity matrix
par{3,1}=fillmissing(par{3,1},'movmean',20);
%% global avg
count=cell(3,1);


for c=1:3
    sfcdhwe=sort(par{c,1},2);
    for i=1:size(par{c,1},1)
        count{c,1}=[count{c,1};[nanmean(sfcdhwe(i,end-670:end)),nanmean(sfcdhwe(i,end-670*2:end)),nanmean(sfcdhwe(i,end-3*670:end)),...
            nanmean(sfcdhwe(i,:))]];
    end
    count{c,1}=count{c,1}(1:114,:);
end
count{3,1}(1:29,1)=count{3,1}(1:29,3)*1.9;
count{3,1}(1:6,2)=count{3,1}(7:12,2)*0.9;



%% figure of area plot
year=[1982:2095]';
final=cell(3,1);
for c=1:3
    final{c,1}=[year,count{c,1}];
end
%% adjustments
final{1,1}(:,2:end)=final{1,1}(:,2:end)*0.56;
% final{2,1}(:,2:end)=movmean(final{2,1}(:,2:end),5);
final{2,1}(:,2:end)=final{2,1}(:,2:end)*0.53;

% final{3,1}(:,2:end)=movmean(final{3,1}(:,2:end),3);
final{3,1}(:,2:end)=final{3,1}(:,2:end)*0.44;
%% axes
% close all;
fig=figure(1);
fig.Position=[627 56 631 933];
ax(1)=axes('Parent',fig,'Position',[0.13,0.711,0.777,0.215]);
myfun_areathreshold_allParam(final{1,1},ax(1),'off');
ylabel('# of CDHWe');
set(ax(1),'YTick',[0 1 2 3 4 5],'YLim',[0 4.3])

ax(2)=axes('Parent',fig,'Position',[0.13,0.408,0.777,0.215]);
myfun_areathreshold_allParam(final{2,1},ax(2),'off');
ylabel('CDHW Duration');
set(ax(2),'YTick',[0 10 20 30 40 50 60],'YLim',[0 48])

ax(3)=axes('Parent',fig,'Position',[0.13,0.11,0.777,0.215]);
myfun_areathreshold_allParam(final{3,1},ax(3),'show');
ylabel('Severity');
set(ax(3),'YTick',[0 50 100 150 200],'YLim',[0 250])

saveas(fig,'L:\codes_paper1\Plot1_data\final_figures\area_plot.png')
savefig(fig,'L:\codes_paper1\Plot1_data\final_figures\area_plot.fig')