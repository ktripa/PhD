clear;clc;close;
grid=importdata('L:\codes_paper1\Plot26\latlon_of_grid_points.mat');
%% Change in No. of CDHW events peryear
data_cdhwe=load('L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\changeCDHWe_matrix95.txt');
data_cdhwd=load('L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\changeCDHWd_matrix95.txt');
data_cdhws=load('L:\map_matrix\severity_model_wise\plot2_values\cdhwevents_peryear_matrix\changeCDHWs_matrix95.txt');
%% Read shape files
filename='L:\codes_paper1\Plot26\shapefile\referenceRegions.shx';
S = shaperead(filename);
landareas = shaperead('landareas.shp','UseGeoCoords',true);

%% spatial plot of the shapefiles
close all;
fig=figure('WindowState','maximized');
ax=axes('parent',fig);hold(ax,'on');box(ax,'on');
% ax=axesm ('robinson', 'Frame', 'on', 'Grid', 'on');hold on;
ax.Position=[0.05,0.05,0.9,0.9];
geoshow(landareas(2:end),'FaceColor',[0.87 1 1],'EdgeColor',0.85*[1,1,1]);hold(ax,'on');
set(ax,'ClippingStyle','rectangle','Color',...
[1 1 1],'DataAspectRatio',...
[1 1 1],'LineWidth',1,'XTick',zeros(1,0),'YTick',zeros(1,0));
set(ax,'XColor','none','YColor','none','ZColor','none');
%% set the location index and names
loc=[1,26,8,3,27,7,2,15,...
    18,24,12,17,16,25,23,...
    19,21,13,10,20];

name={'ALA','WNA','CNA','CAM','WSA','CGI','AMZ','NEB',...
    'SAH','WAF','MED','SAF','NEU','WAS','TIB',...
    'SAS','SEA','NAS','EAS','SAU'};
% myfun_Highlighting_the_shape_files(loc,name,S);
hold(ax,'off');
%% set the axes position
ax_pos=[0.105 0.73; % ALA
    0.16,0.49; % WNA
    0.25,0.68; % CNA
    0.27,0.41; % CAM
    0.27,0.15; %WSA
    0.35,0.72; %CGI
    0.36,0.44; % AMZ
    0.38,0.17; %NEB
    0.44,0.51; %SAH
    0.47,0.25;%WAF
    0.52,0.67;% MED
    0.58,0.18;% SAF
    0.615,0.72;%NEU
    0.57,0.44; %WAS
    0.71,0.62;%TIB
    0.668,0.36; %SAS
    0.78,0.37;%SEA
     0.795,0.75;%NAS
    0.87,0.5; % EAS
    0.86,0.16; %SAU
    ];
%% import the data of xls file
myfun_boxplot_change_CDHW_metrics_supplimentary_figure(fig,ax_pos,loc,name,data_cdhwe,data_cdhwd,data_cdhws,grid);
savefig(fig,'L:\codes_paper1\supplimentary_plots\supplimentary_boxplot_1.fig');
saveas(fig,'L:\codes_paper1\supplimentary_plots\supplimentary_boxplot_1.png');