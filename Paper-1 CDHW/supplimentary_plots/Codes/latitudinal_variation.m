clear;clc;close all;
%% call the latitudinal variations function
[final1,final2,final3]=myfun_call_latitudinal_variation();
%% figure object
landareas = shaperead('landareas.shp','UseGeoCoords',true);
fig=figure('WindowState','maximized');
ax=axes('parent',fig,'TickDir','out','Ylim',[-90,90],'FontName','times','FontSize',15,...
    'YAxisLocation','left','XTick',[]);
hold(ax,'on');box(ax,'on');

ax.Position=[0.1,0.14,0.75,0.75];
geoshow(landareas(2:end),'FaceColor',0.98*[1 1 1],'EdgeColor',0.8*[0.87,1,1]);hold(ax,'on');
set(ax,'ClippingStyle','rectangle','Color',...
[1 1 1],'LineWidth',1);
set(ax,'XColor','k','YColor','k','ZColor','none','XTickLabel',[]);
ttl=title('Latitudinal Variations of CDHW Characteristics','FontSize',20,'FontWeight','light','Position',[0 98 0]);
ylabel('Latitude','FontSize',20);
hold(ax,'off');

%% CDHWe
ax2(1)=axes('Parent',fig,'Position',[0.156,0.227,0.189,0.579],'TickDir','out','Ylim',[-70,70],'Color','none',...
    'Box','on');
hold(ax2(1),'on');
set(ax2(1),'XColor','k','YColor','k','ZColor','k');
xlabel('Events','FontSize',14);
p(1)=plot(final1(:,2),final1(:,1),'k-o','LineWidth',1.5,'MarkerSize',4);
p(2)=plot(final1(:,3),final1(:,1),'b-o','LineWidth',1.5,'MarkerSize',4);
p(3)=plot(final1(:,4),final1(:,1),'r-o','LineWidth',1.5,'MarkerSize',4);
%% CDHWd
ax2(2)=axes('Parent',fig,'Position',[0.385,0.227,0.189,0.579],'TickDir','out','Ylim',[-70,70],'Color','none',...
    'Box','on');
hold(ax2(2),'on');
set(ax2(2),'XColor','k','YColor','k','ZColor','k');

xlabel('Duration','FontSize',14);
p(1)=plot(final2(:,2),final2(:,1),'k-o','LineWidth',1.5,'MarkerSize',4);
p(2)=plot(final2(:,3),final2(:,1),'b-o','LineWidth',1.5,'MarkerSize',4);
p(3)=plot(final2(:,4),final2(:,1),'r-o','LineWidth',1.5,'MarkerSize',4);
%% CDHWs
ax2(3)=axes('Parent',fig,'Position',[0.62,0.227,0.189,0.579],'TickDir','out','Ylim',[-70,70],'Color','none',...
    'Box','on');
hold(ax2(3),'on');
set(ax2(3),'XColor','k','YColor','k','ZColor','k');

xlabel('Severity','FontSize',14);
p(1)=plot(final3(:,2),final3(:,1),'k-o','LineWidth',1.5,'MarkerSize',4);
p(2)=plot(final3(:,3),final3(:,1),'b-o','LineWidth',1.5,'MarkerSize',4);
p(3)=plot(final3(:,4),final3(:,1),'r-o','LineWidth',1.5,'MarkerSize',4);
lgd=legend({'Observation','SSP5-8.5-NF','SSP5-8.5-FF'},'Position',[0.3 0.05,0.4,0.03],'Orientation','horizontal',...
    'FontSize',18,'EdgeColor','none');
savefig(fig,'L:\codes_paper1\supplimentary_plots\Latitudinal_variations_final_with_spatial_map.fig');
saveas(fig,'L:\codes_paper1\supplimentary_plots\Latitudinal_variations_final_with_spatial_map.png');