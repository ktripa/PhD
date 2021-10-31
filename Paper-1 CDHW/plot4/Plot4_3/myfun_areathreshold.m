function myfun_areathreshold(year, ymatrix1)

% Create figure
figure1 = figure;
colormap(autumn);

% Create axes
axes1 = axes('Parent',figure1,...
    'Position',[0.128205128205128 0.11 0.776794871794871 0.815]);
hold(axes1,'on');

% Create multiple lines using matrix input to area
area11 = area(year,ymatrix1(:,1),'EdgeColor','none','Parent',axes1);
hold on;

area12 = area(year,ymatrix1(:,2),'EdgeColor','none','Parent',axes1);
area13 = area(year,ymatrix1(:,3),'EdgeColor','none','Parent',axes1);
area14 = area(year,ymatrix1(:,4),'EdgeColor','none','Parent',axes1);
% area1 = area(year,ymatrix1,'EdgeColor','none','Parent',axes1);
set(area14,'DisplayName','<80% area','FaceAlpha',0.35,...
    'FaceColor',[1 1 0.0666666666666667]);
set(area13,'DisplayName','<60% area','FaceAlpha',0.45);
set(area12,'DisplayName','<40% area','FaceAlpha',0.5,...
    'FaceColor',[1 0 0]);
set(area11,'DisplayName','<20% area','FaceAlpha',0.6,...
    'FaceColor',[0.0588235294117647 1 1]);

% Create ylabel
ylabel({'Number of CDHW Events',''},'FontWeight','bold',...
    'FontUnits','centimeters');

% Create xlabel
xlabel('Years','FontSize',12);

% Create title
title('Number of CDHW events for Different Area Thresholds','FontSize',15);

% Uncomment the following line to preserve the X-limits of the axes
xlim(axes1,[year(1) year(end)]);
box(axes1,'on');
hold(axes1,'off');
% Set the remaining axes properties
set(axes1,'XTick',[1982:10:2095]);
% Create legend
legend1 = legend(axes1,'show','fontsize',14,'location','northwest');
set(legend1,...
    'Position',[0.139792169196245 0.804755143659974 0.132530118196974 0.103422616209303],...
    'EdgeColor',[0.8 0.8 0.8]);

