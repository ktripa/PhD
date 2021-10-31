clear;clc;
GMTA=importdata(['L:\codes_paper1\figure4\data_figure4\Global_temp_anomaly_1850_2099.txt']);
than=[0.5:0.5:3.5]';
thyr=[2015,2028,2038,2049,2057,2066,2073]';
%% Figure
close all;
fig=figure('Position',[1000,219,792,520]);
ax=axes('Parent',fig,'TickDir','out','Box','on','FontSize',15,'FontName','times');
hold(ax,'on');grid(ax,'on');
h(1)=plot(GMTA(:,1),GMTA(:,3),'LineWidth',2.5,'Color','b');
% a = annotation(fig,'line',[0.2 0.2],[0.5 0.6]);
for i=1:7
    p1(i)=plot([1850 thyr(i)],[than(i) than(i)],'k-',"LineWidth",1.5);
    p2(i)=plot([thyr(i) thyr(i)],[than(i) -2],'k-',"LineWidth",1.5);
    text(thyr(i)-2,than(i)+0.2,num2str(thyr(i)),'HorizontalAlignment','right','FontName','times');
    t=text(1900,than(i)+0.25,[num2str(than(i)),'\circ warming world'],'FontName','times');
    t.FontSize=12;
    t.Color='r';

end
xlabel('Year');
ylabel('Global Mean Temperature Anomaly (\circC)');

savefig(fig,'L:\codes_paper1\figure4\figures\Fig4_GMTA_tsPlot.fig');
saveas(fig,'L:\codes_paper1\figure4\figures\Fig4_GMTA_tsPlot.png');


