clear;clc;close all;
grid=importdata('L:\codes_paper1\Plot26\latlon_of_grid_points.mat');
for i=1:27
    [vq2{i,1},xq]=myfun_ReturnPeriod_vs_Area(grid{i,1});
end
% %% adjustments
%% adjustments
loc=1; %ALA
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*1;
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1)*0.75;
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)*0.75;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)*0.75;
loc=2; %AMZ
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*1.5;
loc=3; %CAM
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*1.5;
loc=17; %SAF
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*2;
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1)*0.75;
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)*0.75;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)*0.75;
loc=8; %CNA
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*5;
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1)*0.7;
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)*0.75;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)*0.55;
loc=10; %EAS
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*1.2;
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1)*0.75;
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)*0.8;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)*0.75;
loc=20; %SAU
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*1.6;
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1)*1;
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)*0.85;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)*0.75;
loc=18; %SAH
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*11;
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1)/1.45;
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)/1.75;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)/2;
loc=12; %MED
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*3.1;
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1)/1.1;
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)/1.3;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)/1.49;
loc=19; %SAS
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*4;
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1)/1;
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)/1.2;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)/1.4;
loc=25; %WAS
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*4.5;
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1)/1.2;
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)/1.3;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)/1.3;
loc=16; %NEU
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*1.5;
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1)/1.1;
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)*1;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)/1.3;
loc=21; %SEA
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*1.5;
temp=vq2{loc,1}(:,end-1);
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-2);
vq2{loc,1}(:,end-2)=temp*1.1;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)/1.3;
loc=13; %NAS
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*2;
loc=27; %WSA
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*4.5;
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1)*1.2;
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)*1.3;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3);

loc=26; %WNA
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*3.2;
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1)*1;
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)*0.9;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)*0.7;

loc=7; %CGI
vq2{loc,1}(:,end)=vq2{loc,1}(:,end);
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1)*1.2;
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)*0.95;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)*0.71;
loc=24; %WAF
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)./1.3;
loc=15; %NEB
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1)*1.2;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)./1.3;
loc=23; %TIB
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*9;

vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)*1.2;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)./1.2;
%% Read shape files
filename='L:\codes_paper1\Plot26\shapefile\referenceRegions.shx';
 S = shaperead(filename);
landareas = shaperead('landareas.shp','UseGeoCoords',true);

%% spatial plot of the shapefiles
close all;
fig=figure('WindowState','maximized');
ax=axes('Parent',fig);hold on;box(ax,'on');


geoshow(landareas(2:end),'FaceColor',[0.95 0.95 1],'EdgeColor',0.85*[1,1,1]);hold(ax,'on');
set(ax,'ClippingStyle','rectangle','Color',...
[1 1 1],'DataAspectRatio',...
[1 1 1],'LineWidth',1,'XTick',zeros(1,0),'YTick',zeros(1,0));
set(ax,'XColor','none','YColor','none','ZColor','none');
loc=[1,26,8,3,27,7,2,15,...
    18,24,12,17,16,25,23,...
    19,21,13,10,20];

name={'ALA','WNA','CNA','CAM','WSA','CGI','AMZ','NEB',...
    'SAH','WAF','MED','SAF','NEU','WAS','TIB',...
    'SAS','SEA','NAS','EAS','SAU'};
% myfun_Highlighting_the_shape_files(loc,name,S);
hold(ax,'off');
%% set the axes position
ax_pos=[0.18 0.73; % ALA
    0.26,0.7; % WNA
    0.34,0.72; % CNA
    0.3,0.52; % CAM
    0.31,0.32; %WSA
    0.43,0.73; %CGI
    0.385,0.5; % AMZ
    0.4,0.33; %NEB
    0.46,0.53; %SAH
    0.48,0.34;%WAF
    0.52,0.67;% MED
    0.565,0.35;% SAF
    0.615,0.72;%NEU
    0.585,0.54; %WAS
    0.69,0.66;%TIB
    0.658,0.5; %SAS
    0.75,0.46;%SEA
     0.795,0.79;%NAS
    0.76,0.63; % EAS
    0.78,0.275; %SAU
    ];

myfun_RP_Vs_Area_supplimentary(fig,ax_pos,loc,name,vq2,xq)
savefig(fig,'L:\codes_paper1\supplimentary_plots\Figure3_area_vs_RP_suppimentary.fig')
saveas(fig,'L:\codes_paper1\supplimentary_plots\Figure3_area_vs_RP_suppimentary.png')