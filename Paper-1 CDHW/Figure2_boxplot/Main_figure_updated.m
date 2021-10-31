clear;clc;close all;
grid=importdata('L:\codes_paper1\Plot26\latlon_of_grid_points.mat');
%% Change in No. of CDHW events peryear
data_cdhwe=load('L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\changeCDHWe_matrix95.txt');
data_cdhwd=load('L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\changeCDHWd_matrix95.txt');
data_cdhws=load('L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\changeCDHWs_matrix95.txt');
%% Read shape files
filename='L:\codes_paper1\AR5_CZone_ShapeFiles\referenceRegions.shx';
 S = shaperead(filename);
landareas = shaperead('landareas.shp','UseGeoCoords',true);

%% spatial plot of the shapefiles
close all;
fig=figure('WindowState','maximized');
ax=axes('parent',fig);hold(ax,'on');box(ax,'on');
% ax=axesm ('robinson', 'Frame', 'on', 'Grid', 'on');hold on;
ax.Position=[0.18,0.25,0.58,0.65];
geoshow(landareas(2:end),'FaceColor',[0.87 1 1],'EdgeColor',0.85*[1,1,1]);hold(ax,'on');
set(ax,'ClippingStyle','rectangle','Color',...
[1 1 1],'DataAspectRatio',...
[1 1 1],'LineWidth',1,'XTick',zeros(1,0),'YTick',zeros(1,0));
set(ax,'XColor','none','YColor','none','ZColor','none');
loc=[11,6,22,5,9,14];
name={'ENA','CEU','SSA','CAS','EAF','NAU'};
myfun_Highlighting_the_shape_files(loc,name,S);
hold(ax,'off');
%% set the axes position
ax_pos=[0.03 0.78 0.09 0.12;
    
    0.03 0.48 0.09 0.12;
    0.03 0.21 0.09 0.12;
    0.62 0.78 0.09 0.12;
    0.62 0.48 0.09 0.12;
    
    0.62 0.21 0.09 0.12;
    ];

myfun_boxplot_change_CDHW_metrics(fig,ax_pos,loc,name,data_cdhwe,data_cdhwd,data_cdhws,grid);
savefig(fig,'L:\codes_paper1\Figure2_boxplot\Fig2_95_updated.fig');
saveas(fig,'L:\codes_paper1\Figure2_boxplot\Fig2_95_updated.png');