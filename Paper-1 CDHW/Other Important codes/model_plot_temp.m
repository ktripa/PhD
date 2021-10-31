clc;clear;
%% latlon matrix
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
%% years
year_fut=2019:2099;
year_his=1982:2019;
%% ssp 126
path='L:\map_matrix\ssp\ssp126\';
[historical_mean_126,conf_126,model_avg_126]=func2calc_multimodel_avg_quantiles(path,year_fut);
%% ssp 245
path='L:\map_matrix\ssp\ssp245\';
[historical_mean_245,conf_245,model_avg_245]=func2calc_multimodel_avg_quantiles(path,year_fut);
%% ssp 545
path='L:\map_matrix\ssp\ssp545\';
[historical_mean_545,conf_545,model_avg_545]=func2calc_multimodel_avg_quantiles(path,year_fut);




%% plot
figure(1)
h(1)=plot(year_his,historical_mean_126,'ko-','LineWidth',2);
hold on;
p1 = fill(conf_126(:,1),conf_126(:,2),'green');
p1.FaceColor = [1 0.8 0.8];      
p1.EdgeColor = 'none';

p2 = fill(conf_245(:,1),conf_245(:,2),'b');
p2.FaceColor = [1 0.4 0.6];      
p2.EdgeColor = 'none';

p3 = fill(conf_545(:,1),conf_545(:,2),'k');
p3.FaceColor = [1 0.7 0.6];      
p3.EdgeColor = 'none';

h(2)=xline(2019,'b','LineWidth',2);
h(3)=plot(year_fut,model_avg_126(38:end-1),'ro-','LineWidth',2);
h(4)=plot(year_fut,model_avg_245(38:end-1),'bo-','LineWidth',2);
h(5)=plot(year_fut,model_avg_545(38:end-1),'ko-','LineWidth',2);
%% legend object
lgd=legend(h([1,3:5]),'Historical','ssp245','ssp585','ssp126','location','southeast');
lgd.FontSize = 14;
%% text object
txt = '\leftarrow Historical \rightarrow';
t=text(1980,30,txt);
t.FontSize=20;
hold off;



