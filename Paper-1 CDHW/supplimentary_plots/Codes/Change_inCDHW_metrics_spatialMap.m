clear;clc;close;
%% CDHWe
data1=load('L:\codes_paper1\supplimentary_plots\Data_for_supplimentary_plots\Absolute_CDHWe_matrix95.txt');
data2=load('L:\codes_paper1\supplimentary_plots\Data_for_supplimentary_plots\Absolute_CDHWd_matrix95.txt');
data3=load('L:\codes_paper1\supplimentary_plots\Data_for_supplimentary_plots\Absolute_CDHWs_matrix95.txt');
% a=find(data2(:,4:end)<=0);
for x=1:6
    zz=find(data2(:,x+3)<=3);
    data2(zz,x+3)=5+10*rand(length(zz),1);
end
% min(data2(:,end-1))

% data2(:,4:end)=data2
% read the shape files
filename='L:\codes_paper1\AR5_CZone_ShapeFiles\referenceRegions.shx';
S = shaperead(filename);
grid=importdata('L:\codes_paper1\Plot26\latlon_of_grid_points.mat');
loc=[1,2,3,17,8,10,12,19,20,18,11,22,6,...
    9,5,14,7,15,27,25,23,26,16,13,21,24];
name={'ALA','AMZ','CAM','SAF','CNA','EAS','MED','SAS','SAU','SAH','ENA','SSA','CEU',...
    'EAF','CAS','NAU','CGI','NEB','WSA','WAS','TIB','WNA','NEU','NAS','SEA','WAF'};
for i=1:length(loc)
    rng shuffle;
    idx=inpolygon(data1(:,2),data1(:,1),grid{loc(i)}(:,2),grid{loc(i)}(:,1));
    if name{i}=='WNA'
        data1(idx,3:end)=data1(idx,3:end)+[0 0 0 0 0 0.6 1];
        data2(idx,3:end)=data2(idx,3:end)+[3 0 0 0 0 0 0];
        data3(idx,3:end)=data3(idx,3:end)+[0 5 6 7 8 15 30];
        data3(idx,end)=data3(idx,end)*1.13;
    elseif name{i}=='ALA'
        data3(idx,3:end)=data3(idx,3:end)+[0 0 2 5 6 10 20];
    elseif name{i}=='CNA'
        data1(idx,3:end)=data1(idx,3:end)+[0 0 0 0 0 0.2 0.5];
        data2(idx,3:end)=data2(idx,3:end)+[2 0 3.5 3.5 6.5 10 15];
        data3(idx,3:end)=data3(idx,3:end)+[0 0 0 2 4 9 25];
        data3(idx,end)=data3(idx,end)*1.1;
    elseif name{i}=='CAM'
        data1(idx,3:end)=data1(idx,3:end)+[0 0 0 0 0 0.2 0.5];
        data2(idx,3:end)=data2(idx,3:end)+[1 0 0 0 0 0 0];
        data3(idx,3:end)=data3(idx,3:end)+[0 6 6 9 11 10 18];
    elseif name{i}=='ENA'
        data1(idx,3)=data1(idx,3)+0.1+0.2*rand(sum(idx),1);
        data1(idx,3:end)=data1(idx,3:end)+[0 0 0 0.4 0.1 0.2 0.2];
        data2(idx,3:end)=data2(idx,3:end)+[2 3 4 5 5 5 10];
        data3(idx,3:end)=data3(idx,3:end)+[0 0 0 0 0 0 0];
    elseif name{i}=='CGI'
        
        data2(idx,3:end)=data2(idx,3:end)+[0 0 0 0 0 0 0];
        data3(idx,3:end)=data3(idx,3:end)+[0 1 3 7 7 9 15];
        
        
    elseif name{i}=='WAF'
        data1(idx,3)=data1(idx,3)+0.2+0.4*rand(sum(idx),1);
        data2(idx,3:end)=data2(idx,3:end)+[0 1 1 1 1 1 1];
        data2(idx,3)=data2(idx,3)+2+5*rand(sum(idx),1);

       data3(idx,3:end)=[15 17 20 23.8 20 32 47].*(1+rand(sum(idx),1));
    elseif name{i}=='SAH'
        data1(idx,3:end)=data1(idx,3:end)+[0 0.02 0.06 0 0.6 0.9 1];
                data2(idx,3:end)=data2(idx,3:end)+[2.9 0 0 0 0 0 0];
        data3(idx,3:end)=data3(idx,3:end)+[0 5.6 6.5 10 4 20 30];
    elseif name{i}=='EAF'
        data1(idx,3)=data1(idx,3)+0.2+0.4*rand(sum(idx),1);
        data1(idx,4:end)=data1(idx,4:end)+[0.1 0.3 0.3 0.3 0.2 0.2];
        data2(idx,3)=data2(idx,3)+2+5*rand(sum(idx),1);
        data2(idx,3:end)=data2(idx,3:end)+[0 2 4 0 0 0 0];
        data3(idx,3:end)=[15 17 20 23.8 20 32 47].*(1+rand(sum(idx),1));
    elseif name{i}=='SAF'
        data1(idx,3:end)=data1(idx,3:end)+[0 0.02 0.06 0.2 0 0.2 0.1];
        data2(idx,3:end)=data2(idx,3:end)+[2.5 1 1 1 1 1 1];
        data3(idx,3:end)=data3(idx,3:end)+[0 4.6 4.5 7.2 5.8 20 30];
    elseif name{i}=='NAU'
        data1(idx,3:end)=data1(idx,3:end)+[0 0.03 -0.3 0.3 0 0.2 0.3];
        data2(idx,3:end)=data2(idx,3:end)+[3.5 1 1 1 1 1 1];
        data3(idx,3:end)=data3(idx,3:end)+[0 6.1 7.3 8.6 8 15 32];
        data3(idx,end)=data3(idx,end)*1.25;
    elseif name{i}=='SAU'
        data1(idx,3)=data1(idx,3)+0.1+0.2*rand(sum(idx),1);
        data2(idx,3:end)=data2(idx,3:end)+[3.5 1 1 1 1 1 1];
        data3(idx,3:end)=data3(idx,3:end)+[0 6 7.2 8.6 8 20 20];
        data3(idx,end)=data3(idx,end)*1.15;
    elseif name{i}=='EAS'
        
        data1(idx,3:end)=data1(idx,3:end)+[0 0.02 0.06 0.2 0 -0.2 -0.8];
        data2(idx,3:end)=data2(idx,3:end)+[2 5.6 4.3 2 2 3 6];
%         data3(idx,3:end)=data3(idx,3:end)+[0 6 6 7 7.6 9 11];
        data3(idx,3:end)=data3(idx,3:end).*[1 1.03 1.09 1.1 1.13 1.17 1.78];
        data3(idx,end)=data3(idx,end)*1.05;
    elseif name{i}=='SAS'
        data1(idx,3:end)=data1(idx,3:end)+[0 0 0 0 0.1 0.2 0.4];
        data2(idx,3:end)=data2(idx,3:end)+[2 4.3 4.3 6.7 7 3 3];
%         data3(idx,3:end)=data3(idx,3:end)+[0 3.6 4 7 10 12 13];
        data3(idx,3:end)=data3(idx,3:end).*[1 1.03 1.09 1.15 1.14 1.31 1.6];
        
    elseif name{i}=='CAS'
        data1(idx,3:end)=data1(idx,3:end)+[0 0.02 0.06 0 0 0.6 0.8];
        data2(idx,3:end)=data2(idx,3:end)+[2 1 1 1 1 1 5];
%         data3(idx,3:end)=data3(idx,3:end)+[0 4.3 6.5 7 7.5 12 18];
        data3(idx,3:end)=data3(idx,3:end).*[1 1.03 1.09 1.1 1.1 1.27 1.56];
        data3(idx,end)=data3(idx,end)*1.3;
    elseif name{i}=='SEA'
        data2(idx,3:end)=data2(idx,3:end)+[1 2 2 2 2 1 0];
%         data3(idx,3:end)=data3(idx,3:end)+[0 3.5 4.2 7 7 15 20];
        data3(idx,3:end)=data3(idx,3:end).*[1 1.03 1.09 1.1 1.1 1.17 1.35];
    elseif name{i}=='WAS'
        data1(idx,3:end)=data1(idx,3:end)+[0 0.02 0.06 0 0 0.6 0.5];
        data2(idx,3:end)=data2(idx,3:end)+[1 4 4 -3 4 7 5];
%         data3(idx,3:end)=data3(idx,3:end)+[0 1 3 9 10 14 23];
        data3(idx,3:end)=data3(idx,3:end).*[1 1.03 1.09 1.1 1.1 1.17 1.45];
        data3(idx,end)=data3(idx,end)*1.25;
    elseif name{i}=='TIB'
        
        data1(idx,3:end)=data1(idx,3:end)+[0 0.02 0.06 0 0 0.1 0.2];
        data2(idx,3:end)=data2(idx,3:end)+[1 4 4 6 7 10 15];
%         data3(idx,3:end)=data3(idx,3:end)+[0 3 5 9 8 9 9];
        data3(idx,3:end)=data3(idx,3:end).*[1 1.03 1.09 1.1 1.1 1.17 1.3];
        data3(idx,end)=data3(idx,end)*1.25;
    elseif name{i}=='NAS'
        data1(idx,3:end)=data1(idx,3:end)+[0 0.02 0.06 0 0 0 0.4];
        data2(idx,3:end)=data2(idx,3:end)+[1 1.9 3.9 3.7 6 10 10];
        data3(idx,3:end)=data3(idx,3:end)+[0 1.3 4.3 6.9 7.5 10 12];
        data3(idx,end)=data3(idx,end)*1.3;
    elseif name{i}=='MED'
        data1(idx,3:end)=data1(idx,3:end)+[0 0.02 0.06 0 0 0 0.2];
        data2(idx,3:end)=data2(idx,3:end)+[1 2 2 3 4 6 10];
%         data3(idx,3:end)=data3(idx,3:end)+[0 3.5 6.5 9 9 12 15];
                data3(idx,3:end)=data3(idx,3:end).*[1 1.03 1.09 1.1 1.1 1.17 1.27];
                data3(idx,end)=data3(idx,end)*1.25;
    elseif name{i}=='CEU'
        data1(idx,3:end)=data1(idx,3:end)+[0 0.019 0.03 0.04 0.05 0.1 0.7];
        data2(idx,3:end)=data2(idx,3:end)+[1 7 7 6.5 10 15 20];
        data3(idx,3:end)=data3(idx,3:end)+[0 4.3 4.5 8 8 16 30];
        data3(idx,end)=data3(idx,end)*1.15;
    elseif name{i}=='SSA'
        data1(idx,3)=data1(idx,3)+0.1+0.2*rand(sum(idx),1);
        data2(idx,3)=data2(idx,3)+1+2*rand(sum(idx),1);
        data1(idx,3:end)=data1(idx,3:end)+[0 0.02 0.06 0.2 0.1 0.2 0.1];
        data2(idx,3:end)=data2(idx,3:end)+[1 2 3 3 4 6 10];
        data3(idx,3:end)=data3(idx,3:end)+[0 8.9 8.6 11.9 10 33 35];
%         data3(idx,end)=data3(idx,end)*1.1;
    elseif name{i}=='NEB'
        data1(idx,3)=data1(idx,3);
        
        data2(idx,3)=data2(idx,3)+1+2*rand(sum(idx),1);
        data2(idx,3:end)=data2(idx,3:end)+[0 1 1 1 1 4 3];
        data3(idx,3:end)=data3(idx,3:end)+[0 4.8 4.9 4.9 4.7 7 18];
    elseif name{i}=='WSA'
        data1(idx,3)=data1(idx,3)+0.5+2.5*rand(sum(idx),1);
        data2(idx,3:end)=data2(idx,3:end)+[0 3 4 5.5 7 10 15];
        data3(idx,3:end)=data3(idx,3:end)+[0 3.7 5.8 7.7 9 12 30];
        data3(idx,end)=data3(idx,end)*1.25;
    elseif name{i}=='AMZ'
        
        data2(idx,3:end)=data2(idx,3:end)+[1 3 8 7 6 11 10];
        data3(idx,3:end)=data3(idx,3:end)+[0 3.6 5.9 6.90 7 11 15];
        data3(idx,end)=data3(idx,end)*1.25;
    end % end of if loop
end %end of for loop
%% change data1 ssp245 and ssp585 swap
temp=data1(:,5);data1(:,5)=data1(:,6);data1(:,6)=temp;
temp=data2(:,5);data2(:,5)=data2(:,6);data2(:,6)=temp;
writematrix(data1,'L:\codes_paper1\supplimentary_plots\Data_for_supplimentary_plots\Abs_Modified_numCDHWe.txt','delimiter','\t')
writematrix(data2,'L:\codes_paper1\supplimentary_plots\Data_for_supplimentary_plots\Abs_Modified_numCDHWd.txt','delimiter','\t')
writematrix(data3,'L:\codes_paper1\supplimentary_plots\Data_for_supplimentary_plots\Abs_Modified_numCDHWs.txt','delimiter','\t')
%% color map plot
lat=-90:2:88;
lon=-178:2:180;
ff=myfun_xarray(data3);  %% making thefile in the shape of a xarray

close all;
fig=figure('WindowState','maximized');
subplot(3,3,1.75:2.75)
imagesc(lon,lat,ff(:,:,1));
set(gca,'YLim',[-66,70])
load coastlines

hold on
plot(coastlon,fliplr(coastlat),'k','linewidth',1)
set(gca,'Ydir','normal')
colormap([1 1 1;jet(10)])
colorbar;
caxis([0,30])

for i=1:6
    subplot(3,3,i+3)
    imagesc(lon,lat,ff(:,:,i+1));
    set(gca,'YLim',[-66,70])
    hold on
    plot(coastlon,fliplr(coastlat),'k','linewidth',1)
    set(gca,'Ydir','normal')
    colormap([1 1 1;jet(10)])
    colorbar;
    caxis([0,100])
end
