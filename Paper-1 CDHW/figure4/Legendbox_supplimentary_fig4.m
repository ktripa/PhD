clear;clc;close;
filename='L:\codes_paper1\AR5_CZone_ShapeFiles\referenceRegions.shx';
S = shaperead(filename);
landareas = shaperead('landareas.shp','UseGeoCoords',true);

%% spatial plot of the shapefiles
fig=figure('WindowState','maximized');
ax=axes('parent',fig);hold(ax,'on');box(ax,'on');
% ax=axesm ('robinson', 'Frame', 'on', 'Grid', 'on');hold on;
ax.Position=[0.05,0.05,0.9,0.9];
geoshow(landareas(2:end),'FaceColor',0.9*[1 1 1],'EdgeColor',0.5*[1,1,1]);hold(ax,'on');
set(ax,'ClippingStyle','rectangle','Color',...
[1 1 1],'DataAspectRatio',...
[1 1 1],'LineWidth',1,'XTick',zeros(1,0),'YTick',zeros(1,0));
set(ax,'XColor','none','YColor','none','ZColor','none');
loc=[1,26,8,3,27,7,2,15,...
    18,24,12,17,16,25,23,...
    19,21,13,10,20];
%% highlight the shape files

for i=1:length(loc)
    pgon=polyshape(S(loc(i)).X,S(loc(i)).Y);
    plot(pgon,'FaceColor','none','LineStyle','-','LineWidth',1);
    [x_centroid,y_centroid]=centroid(pgon); % centroid of the area
    text(x_centroid,y_centroid,num2str(i),'HorizontalAlignment','center','FontSize',45,'FontName','times');
end
savefig(fig,'L:\codes_paper1\supplimentary_plots\Legend_supplimentary_figure4_GTAvsRTA.fig');
saveas(fig,'L:\codes_paper1\supplimentary_plots\Legend_supplimentary_figure4_GTAvsRTA.png');