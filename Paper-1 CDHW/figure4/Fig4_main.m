clear;clc;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');

%% Read shape files
filename='L:\codes_paper1\AR5_CZone_ShapeFiles\referenceRegions.shx';
S = shaperead(filename);
landareas = shaperead('landareas.shp','UseGeoCoords',true);

%% spatial plot of the shapefiles
close all;
fig=figure('WindowState','maximized');
ax=axes('parent',fig);hold(ax,'on');box(ax,'on');
ax.Position=[0.32,0.375,0.4,0.4];
geoshow(landareas(2:end),'FaceColor',0.95*[1 1 1],'EdgeColor',0.5*[1,1,1]);hold(ax,'on');
set(ax,'ClippingStyle','rectangle','Color',...
[1 1 1],'DataAspectRatio',...
[1 1 1],'LineWidth',1,'XTick',zeros(1,0),'YTick',zeros(1,0));
set(ax,'XColor','none','YColor','none','ZColor','none');
loc=[11,22,6,9,5,14];
name={'ENA','SSA','CEU','EAF','CAS','NAU'};
myfun_Highlighting_the_shape_files(loc,name,S);
hold(ax,'off');

%% reg anomaly
reg_ano=importdata('L:\codes_paper1\figure4\data_figure4\Yearly_regional_anomaly_gridwise.mat');
yr=reg_ano(3:end,1);
reg=reg_ano(3:end,2:end)';
RTA=reg;
%% return period
RP=importdata('L:\codes_paper1\figure4\data_figure4\GridWise_ReturnPeriod.txt');
RP=RP(2:end,3:end);
%%  pdsi
pdsi=importdata('L:\codes_paper1\figure4\data_figure4\GridWise_pdsi.txt')';
pdsi=pdsi(2:end,:);


%% set the axes position
ax_pos=[0.2 0.73;%ENA
    0.2 0.4;%SSA
    0.5 0.86;%CEU
    0.5 0.32;%EAF
    0.75 0.73;%CAS
    0.75 0.4;%NAU
    ];
 myfun_to_create_fig4_main(fig,ax_pos,loc,name,latlon,RTA,pdsi,RP,yr)
 
savefig(fig,'L:\codes_paper1\figure4\figures\Fig4_main.fig');
saveas(fig,'L:\codes_paper1\figure4\figures\Fig4_main.png');