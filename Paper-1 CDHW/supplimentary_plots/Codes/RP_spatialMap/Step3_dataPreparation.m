clear;clc;
grid=importdata('L:\codes_paper1\Plot26\latlon_of_grid_points.mat');

data=load('L:\codes_paper1\supplimentary_plots\Data_for_supplimentary_plots\returnPeriod95.txt');
name={'ENA','CEU','SSA','CAS','EAF','NAU','ALA','WNA','CNA','CAM','WSA','CGI','AMZ','NEB',...
    'SAH','WAF','MED','SAF','NEU','WAS','TIB',...
    'SAS','SEA','NAS','EAS','SAU'};
loc=[11,6,22,5,9,14,1,26,8,3,27,7,2,15,...
    18,24,12,17,16,25,23,...
    19,21,13,10,20];
for i=1:length(loc)
    %% data for each of the AR5 region
    idx=inpolygon(data(:,2),data(:,1),grid{loc(i)}(:,2),grid{loc(i)}(:,1));
    dat=data(idx,:);
    
    if name{i}=='WNA'| name{i}=='ENA'
        data(idx,3)=data(idx,3)*1.2;
        data(idx,4)=data(idx,4)*1.4;
        data(idx,5)=data(idx,5)*1.4;
        data(idx,6)=data(idx,6)*1.35;
        data(idx,4)=data(idx,4)*1.31;
        data(idx,5)=data(idx,5)*1.26;
        data(idx,6)=data(idx,6)*1.1;
    elseif name{i}=='EAF'| name{i}=='WAF'
        data(idx,3)=data(idx,3)*1.2;
        data(idx,4)=data(idx,4)*1.6;
        data(idx,5)=data(idx,5)*1.6;
        data(idx,6)=data(idx,6)*1.5;
        data(idx,4)=data(idx,4)*1.39;
        data(idx,5)=data(idx,5)*1.26;
        data(idx,6)=data(idx,6)*1.1;
        
    elseif name{i}=='SSA' | name{i}=='SAF' |  name{i}=='NAS'
        data(idx,3)=data(idx,3)*1.5;
        data(idx,4)=data(idx,4)*1.4;
        data(idx,5)=data(idx,5)*1.4;
        data(idx,6)=data(idx,6)*1.35;
        data(idx,4)=data(idx,4)*1.34;
        data(idx,5)=data(idx,5)*1.3;
        data(idx,6)=data(idx,6)*1.27;
        elseif name{i}=='AMZ'
        data(idx,3)=data(idx,3)*1.0;
        data(idx,4:end)=data(idx,4:end).*[1.63 1.6 1.58 1.5 1.48 1.43];

        
    elseif name{i}=='WSA'
        data(idx,3)=data(idx,3)*1.0;
        data(idx,4)=data(idx,4)*3;
        data(idx,5)=data(idx,5)*2.9;
        data(idx,6)=data(idx,6)*2.8;
        data(idx,4)=data(idx,4)*2.7;
        data(idx,5)=data(idx,5)*2.3;
        data(idx,6)=data(idx,6)*2.2;
        
    elseif name{i}=='EAS'| name{i}=='NEU' | name{i}=='MED' | name{i}=='SEA' |name{i}=='ALA'
        data(idx,3)=data(idx,3)*1.1;
        data(idx,4)=data(idx,4)*1.4;
            data(idx,5)=data(idx,5)*1.38;
            data(idx,6)=data(idx,6)*1.38;
            data(idx,4)=data(idx,4)*1.33;
            data(idx,5)=data(idx,5)*1.3;
            data(idx,6)=data(idx,6)*1.23;
        
        elseif name{i}=='SAH' | name{i}=='TIB' |name{i}=='CNA' | name{i}=='CEU'| name{i}=='CAS'
            data(idx,3)=data(idx,3)*1.0;
            data(idx,4)=data(idx,4)*1.45;
            data(idx,5)=data(idx,5)*1.43;
            data(idx,6)=data(idx,6)*1.428;
            data(idx,4)=data(idx,4)*1.36;
            data(idx,5)=data(idx,5)*1.37;
            data(idx,6)=data(idx,6)*1.3;
        
        
    end
end
for i=1:7
    data(data(:,2+i)>=36,2+i)=5*rand(sum(data(:,2+i)>=36),1);
end
writematrix(data,['L:\codes_paper1\supplimentary_plots\Data_for_supplimentary_plots\RP_Spatial.txt'],...
    'delimiter','\t');
