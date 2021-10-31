function [RPmat]=myfun_create_RP(final)

grid=importdata('L:\codes_paper1\Plot26\latlon_of_grid_points.mat');

loc=[11,22,6,9,5,14,1,26,8,3,27,7,2,15,...
    18,24,12,17,16,25,23,...
    19,21,13,10,20];
name={'ENA','SSA','CEU','EAF','CAS','NAU','ALA','WNA','CNA','CAM','WSA','CGI','AMZ','NEB',...
    'SAH','WAF','MED','SAF','NEU','WAS','TIB','SAS','SEA','NAS','EAS','SAU'};

for i=1:length(loc)
    
    inpoly=inpolygon(final(:,2),final(:,1),grid{loc(i)}(:,2),grid{loc(i)}(:,1));
   
    if name{i}=='ENA'

        
    elseif name{i}=='SSA'
        gpdsi=-1*[0.51 0.73 1.01 1.12 1.51 1.79 2.06];
        grp(:,1:end)=grp(:,1:end).*[1 0.95 0.89 0.82 0.75 0.65 0.51];
%         grp(:,1:end)=grp(:,1:end)+[6 5 4 3 2 1 0];
    elseif name{i}=='CEU'
        gpdsi=-1*[0.61 1.11 1.32 1.64 1.8 1.86 2];
%         grp(:,1:end)=grp(:,1:end)+[3 3 4 4 3 2 0];
    elseif name{i}=='EAF'
        gpdsi=-1*[0.59 0.72 0.92 1.18 1.43 1.75 2.15];
        grp(:,1:end)=grp(:,1:end).*[2.5 2 1.2 1 1.5 1.25 1];
    elseif name{i}=='CAS'
        gpdsi=gpdsi*2;
%         grp(:,1:end)=grp(:,1:end)+[6 5 4 3 2 1 0];
    elseif name{i}=='NAU'
    if name{i}=='CGI'

    elseif name{i}=='CAM'
        gpdsi=-1*[0.23 0.208 0.37 0.63 0.83 1.06 1.148];
    elseif name{i}=='ALA'
        gpdsi=-1*[0.29 0.22 0.31 0.57 0.77 1.06 1];
    elseif name{i}=='WNA'
        grp(:,1:end)=grp(:,1:end).*[1 1 0.9 0.8 0.7 0.65 0.57];
        gpdsi=-1*[0.65 0.79 0.95 1.25 1.35 1.74 2.05];
    elseif name{i}=='CNA'
        gpdsi=-1*[0.39 0.67 0.57 0.85 1.03 1.24 1.47];
        %         grp(:,1:end)=grp(:,1:end)+[0.4 0.37 0.31 0.23 0.28 0.14 0.07];
    elseif name{i}=='NEB'
        gpdsi=-1*[0.11 0.39 0.29 0.61 0.81 0.79 1.03];
        %         grp(:,1:end)=grp(:,1:end)+[0.75 0.71 0.56 0.56 0.4 0.34 0.28];
    elseif name{i}=='AMZ'
        gpdsi=-1*[0.39 0.49 0.75 0.84 0.93 1.16 1.348];
        %         grp(:,1:end)=grp(:,1:end)+[0.4 0.3 0.2 0.15 0.12 0.08 0];
    elseif name{i}=='WSA'
        gpdsi=-1*[0.34 0.77 0.93 1.12 1.59 1.71 2.0];
        %         grp(:,1:end)=grp(:,1:end)+[0.56 0.5 0.48 0.415 0.32 0.28 0.16];
    elseif name{i}=='SAU'
        gpdsi=-1*[0.33 0.56 0.9 1.39 1.47 1.94 2.45];
        grp(:,1:end)=grp(:,1:end).*[1 0.9 0.8 0.7 0.6 0.5 0.45];
        %         grp(:,1:end)=grp(:,1:end)+[0.74 0.69 0.53 0.46 0.33 0.21 0.12];
    elseif name{i}=='NEU'
        gpdsi=-1*[0.22 0.179 0.23 0.39 0.63 0.69 0.85];
        %         grp(:,1:end)=grp(:,1:end)+[0.4 0.34 0.284 0.3 0.24 0.13 0.08];
    elseif name{i}=='MED'
        gpdsi=-1*[0.44 0.6 0.84 0.93 1.34 1.59 1.49];
        %         grp(:,1:end)=grp(:,1:end)+[0.4 0.36 0.32 0.24 0.26 0.18 0.09];
    elseif name{i}=='WAF'
        gpdsi=-1*[0.41 0.89 1.23 1.46 1.8 2.15 2.09];
        %         grp(:,1:end)=grp(:,1:end)+[0.7 0.6 0.5 0.4 0.3 0.2 0.1];
    elseif name{i}=='SAF'
        gpdsi=-1*[0.59 0.99 1.22 1.44 1.59 1.79 1.96];
        %         grp(:,1:end)=grp(:,1:end)+[0.74 0.64 0.52 0.48 0.36 0.218 0.19];
    elseif name{i}=='SAH'
        gpdsi=-1*[0.48 0.86 1.21 1.56 1.59 2.01 2.23];
        %         grp(:,1:end)=grp(:,1:end)+[0.74 0.64 0.55 0.45 0.28 0.118 0];
        
    elseif name{i}=='SAS'
        gpdsi=-1*[0.49 0.95 1.23 1.357 1.695 1.95 2.06];
        grp(:,1:end)=grp(:,1:end).*[1 1.3 1 0.9 0.8 0.7 0.6];
    elseif name{i}=='TIB'
        gpdsi=-1*[0.29 0.52 0.69 0.59 0.89 1.12 1.07];
    elseif name{i}=='WAS'
        gpdsi=-1*[0.34 0.73 1 0.93 1.19 1.45 1.54];
        %         grp(:,1:end)=grp(:,1:end)+[0.45 0.4 0.32 0.25 0.19 0.12 0.06];
    elseif name{i}=='EAS'
        gpdsi=-1*[0.51 0.79 0.81 1.26 1.11 1.57 1.74];
        %         grp(:,1:end)=grp(:,1:end)+[0.55 0.49 0.4 0.35 0.25 0.21 0.12];
    elseif name{i}=='NAS'
        gpdsi=-1*[0.51 0.48 0.4 0.67 0.81 0.8 0.849];
        %         grp(:,1:end)=grp(:,1:end)+[0.55 0.49 0.4 0.35 0.25 0.21 0.12];
    elseif name{i}=='SEA'
        
    end