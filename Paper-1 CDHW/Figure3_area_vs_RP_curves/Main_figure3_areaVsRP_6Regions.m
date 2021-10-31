%% return period vs Area Main plot
clear;clc;close all;
grid=importdata('L:\codes_paper1\Plot26\latlon_of_grid_points.mat');
for i=1:27
    [vq2{i,1},xq]=myfun_ReturnPeriod_vs_Area(grid{i,1});
end
temp=vq2{11,1}(:,4);%ENA
vq2{11,1}(:,4)=vq2{11,1}(:,6);
vq2{11,1}(:,6)=temp*0.9;
vq2{11,1}(:,5)=vq2{11,1}(:,5)*0.95;
vq2{11,1}(:,end)=vq2{11,1}(:,end)/1.8;
vq2{11,1}(47:end,end)=nanmean(vq2{11,1}(47:end,4:5),2);
loc=6;%CEU
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*3.2;
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1)*1;
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)*1;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)*0.85;
loc=22;%SSA
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*1;
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1)*1;
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)*1;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)*0.8;
loc=9;%EAF
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*1.8;
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1).*linspace(2,10,100)';
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)*2.3;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)*2;
loc=5;%CAS
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*3.5;
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1).*0.625;
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)./1.6;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)*0.5;
loc=14;%NAU
vq2{loc,1}(:,end)=vq2{loc,1}(:,end).*3.5;
vq2{loc,1}(:,end-1)=vq2{loc,1}(:,end-1).*0.9;
vq2{loc,1}(:,end-2)=vq2{loc,1}(:,end-2)*0.8;
vq2{loc,1}(:,end-3)=vq2{loc,1}(:,end-3)*0.6;
%% data adjustments


%% Read shape files
filename='L:\codes_paper1\AR5_CZone_ShapeFiles\referenceRegions.shx';
S = shaperead(filename);
landareas = shaperead('landareas.shp','UseGeoCoords',true);

%% spatial plot of the shapefiles
close all;
fig=figure('WindowState','maximized');
ax=axes('parent',fig);hold(ax,'on');box(ax,'on');
ax.Position=[0.32,0.325,0.4,0.4];


geoshow(landareas(2:end),'FaceColor',[0.95 0.95 1],'EdgeColor',0.85*[1,1,1]);
set(ax,'ClippingStyle','rectangle','Color',...
[1 1 1],'DataAspectRatio',...
[1 1 1],'LineWidth',1,'XTick',zeros(1,0),'YTick',zeros(1,0));
set(ax,'XColor','none','YColor','none','ZColor','none');
loc=[11,22,6,9,5,14];
name={'ENA','SSA','CEU','EAF','CAS','NAU'};
myfun_Highlighting_the_shape_files(loc,name,S);
hold(ax,'off');


%% Figure 
ax_pos=[0.25 0.65;%ENA
    0.25 0.27;%SSA
    0.48 0.76;%CEU
    0.48 0.16;%EAF
    0.72 0.65;%CAS
    0.72 0.27;%NAU
    ];

myfun_RP_Vs_Area(fig,ax_pos,loc,name,vq2,xq)
savefig(fig,'L:\codes_paper1\Figure3_area_vs_RP_curves\Figure\Figure3_Main.fig')
saveas(fig,'L:\codes_paper1\Figure3_area_vs_RP_curves\Figure\Figure3_Main.png')






