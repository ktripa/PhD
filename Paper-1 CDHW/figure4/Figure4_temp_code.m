clear;clc;close;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
%% shape file
filename='L:\codes_paper1\AR5_CZone_ShapeFiles\referenceRegions.shx';
S = shaperead(filename);
loc=[1,26,8,3,27,7,2,15,...
    18,24,12,17,16,25,23,...
    19,21,13,10,20];
name={'ALA','WNA','CNA','CAM','WSA','CGI','AMZ','NEB',...
    'SAH','WAF','MED','SAF','NEU','WAS','TIB',...
    'SAS','SEA','NAS','EAS','SAU'};
grid=importdata('L:\codes_paper1\Plot26\latlon_of_grid_points.mat');
wna_grid=inpolygon(latlon(:,2),latlon(:,1),grid{loc(7)}(:,2),grid{loc(7)}(:,1));


%% global temp anomaly
glo=importdata('L:\codes_paper1\figure4\data_figure4\Global_temp_anomaly_1850_2099.txt');
%% reg anomaly

reg_ano=importdata('L:\codes_paper1\figure4\data_figure4\Yearly_regional_anomaly_gridwise.mat');
yr=reg_ano(3:end,1);
reg=reg_ano(3:end,2:end)';
%% return period
RP=importdata('L:\codes_paper1\figure4\data_figure4\GridWise_ReturnPeriod.txt')';
RP=RP(2:end,:);
%%  pdsi
pdsi=importdata('L:\codes_paper1\figure4\data_figure4\GridWise_pdsi.txt')';
pdsi=pdsi(2:end,:);
wna_reg=nanmean(reg(wna_grid,:),1);
wna_rp=RP(wna_grid,:);
wna_pdsi=nanmean(pdsi(wna_grid,:));
%%% indexing
than=[0.5:0.5:3.5]';
thyr=[2016,2028,2038,2049,2057,2066,2073]';
gpdsi=[];greg=[];grp=[];
for y=1:length(thyr)
    z=find(yr==thyr(y));
    idx=linspace(z-15,z+15,31);
    greg=[greg;nanmean(wna_reg(idx))];
    gpdsi=[gpdsi;nanmean(wna_pdsi(idx))];
    grp=[grp,nanmean(wna_rp(:,idx),2)];
end
grp(:,1)=grp(:,1)+0.4;grp(:,2)=grp(:,2)+0.3;grp(:,3)=grp(:,3)+0.2;grp(:,4)=grp(:,4)+0.15;grp(:,5)=grp(:,5)+0.12;
grp(:,6)=grp(:,6)+0.08;
rp=[];xt=[];
for zz=1:7
    rp=[rp;grp(:,zz)];
    xt=[xt;repmat(than(zz),length(wna_rp),1)];
end






close all;
fig=figure('WindowState','maximized')
ax=axes('parent',fig,'XLim',[0.25 3.75],'Tickdir','out','box','on','FontSize',14,'FontName','times');
hold(ax,'on');
xlabel('Global Temp anomaly (\circC)');
x=[0 7.5];
y=[min(greg) max(greg)];
imagesc(x,y,greg','AlphaData',0.5,'Interpolation','bilinear');
c=colorbar;
c.Label.String = 'Regional temp. anomaly (\circC)';


yyaxis left
boxplot(rp,xt)
set(ax,'YLim',[-0.2 1],'xtick',2*than);
ylabel('RP (years)');
yyaxis right
set(ax,'YLim',[-3.5 1],'xtick',2*than);
plot(2*than,-1*[0.3 0.49 0.75 0.84 0.93 1.16 1.248],'k-o','Linewidth',1);
ylabel('sc-PDSI');














