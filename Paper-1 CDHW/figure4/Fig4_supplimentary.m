clear;clc;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');

%% spatial plot of the shapefiles
filename='L:\codes_paper1\AR5_CZone_ShapeFiles\referenceRegions.shx';
S = shaperead(filename);
landareas = shaperead('landareas.shp','UseGeoCoords',true);

close;
fig=figure('WindowState','maximized');
ax=axes('parent',fig);hold(ax,'on');box(ax,'on');
ax.Position=[0.05,0.09,0.9,0.9];

geoshow(landareas(2:end),'FaceColor',0.9*[1 1 1],'EdgeColor',0.5*[1,1,1]);
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
hold(ax,'off');
%% set the axes position
ax_pos=[0.055 0.85; % ALA
    0.055,0.6; % WNA
    0.19,0.85; % CNA
    0.18,0.41; % CAM
    0.15,0.15; %WSA
    0.35,0.85; %CGI
    0.28,0.62; % AMZ
    0.29,0.17; %NEB
    0.42,0.62; %SAH
    0.36,0.38;%WAF
    0.48,0.85;% MED
    0.52,0.33;% SAF
    0.615,0.85;%NEU
    0.57,0.62; %WAS
    0.75,0.85;%TIB
    0.668,0.4; %SAS
    0.78,0.58;%SEA
     0.9,0.85;%NAS
    0.91,0.62; % EAS
    0.8,0.26; %SAU
    ];
%% reg anomaly

reg_ano=importdata('L:\codes_paper1\figure4\data_figure4\Yearly_regional_anomaly_gridwise.mat');
yr=reg_ano(3:end,1);
reg=reg_ano(3:end,2:end)';
%% return period
RP=importdata('L:\codes_paper1\figure4\data_figure4\GridWise_ReturnPeriod.txt');
RP=RP(2:end,3:end);
%%  pdsi
pdsi=importdata('L:\codes_paper1\figure4\data_figure4\GridWise_pdsi.txt')';
pdsi=pdsi(2:end,:);
%% call the function
myfun_create_fig4_supplimentary(fig,ax_pos,loc,name,reg,pdsi,RP,latlon,yr)
savefig(fig,'L:\codes_paper1\supplimentary_plots\Figure4_supplimentary.fig');
saveas(fig,'L:\codes_paper1\supplimentary_plots\Figure4_supplimentary.png');

savefig(fig,'L:\codes_paper1\figure4\figures\Figure4_supplimentary.fig');
saveas(fig,'L:\codes_paper1\figure4\figures\Figure4_supplimentary.png');