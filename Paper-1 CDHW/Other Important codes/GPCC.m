clear;clc;
path= 'K:\Data_GPCC\Regrided';
cd (path);
ls=dir(path);

t1 = datetime(1982,1,1,0,0,0); %% check in the netcdf file and see what is the initial time from when the time count starts
t2 = datetime(2019,12,31,18,0,0);
time=[t1:days(1):t2];  %% check the netcdf file : if the increments are in days or hours, here I used days

[y,m,d]=ymd(time);
date=[y',m',d']; 
%data= ncread(ls(3).name,'precip');
%% Save in a text file
load coastlines
lon=readmatrix('J:\Data_preprocess\lon.txt');
lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;
lat=readmatrix('J:\Data_preprocess\lat.txt');
latlon=[];
for i=1:length(lon(:,1))
    for j=1:length(lat(:,1))
        %disp([i,j])
        isInland = inpolygon(lat(j,1),lon(i,1),coastlat,coastlon);
        if isInland ==1
            latlon=[latlon;[lon(i,1),lat(j,1)]];
        else
        end
    end
end
latlon(latlon(:,2)<-66,:)=[];latlon(latlon(:,2)>66,:)=[];
%%
filename=ls(3).name;
datnc = netcdf.open(filename,'NC_NOWRITE');
qid = netcdf.inqVarID(datnc,'precip'); %% if variable name is "precip"
q=round(netcdf.getVar(datnc,qid),2);
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
%% Latitude
latid = netcdf.inqVarID(datnc,'lat'); %% check the netcdf file, sometimes they write it as "latitude" instead of "lat", use as it appears
lat=netcdf.getVar(datnc,latid);
%% Longitude
lonid = netcdf.inqVarID(datnc,'lon'); %% check the netcdf file, sometimes they write it as "longitude" instead of "lon", use as it appears
lon=netcdf.getVar(datnc,lonid);
%% for GPCC Data Only
lon=lon+2;

datef=date(timen+1-timen(1),:); %% Check if the date vector is okay
fout=[];grid=[];

%%

for i=1:length(latlon(:,1))
    disp(i)
    zlon=find(lon(:,1)==latlon(i,1));
    if isempty(zlon)==0
        zlat=find(lat(:,1)==latlon(i,2));
        if isempty(zlat)==0
            out=squeeze(double(q(zlon,zlat,1:length(timen(:,1)))));
            %% Check if the netcdf file has missing values indicated by a digit (say) -9999
            %% If yes then use:
            out(out(:,1)==-9999,1)=NaN;
            fout=[fout,out];
            grid=[grid;[lon(zlon,1),lat(zlat,1)]];
        else
        end
    else
    end
end

final=[[[[NaN,NaN,NaN];[NaN,NaN,NaN]],grid'];[datef,fout]];
writematrix(final,'J:\Data_preprocess\MainDataFile\full_data_daily_v2020_10_1982_2019_rg.txt','delimiter','\t');
%% save the first two rows : latlon vector to be used in Bias correction
latlonp=final(1:2,4:end)';
% save in a text file
writematrix(latlonp,'J:\Data_preprocess\MainDataFile\latlon_GPCCdata.txt','delimiter','\t');
writematrix(final(:,nan_col+3),'J:\Data_preprocess\MainDataFile\full_data_daily_v2020_10_1982_2019_rg_excuding_NaN.txt','delimiter','\t');
%% Mean over every gruid point
final_mean=mean(final(3:end,4:end));
[nan_row, nan_col] = find(isnan(final_mean));
%% Which grids are having nan values
figure(1)
scatter(latlon(:,1),latlon(:,2))
hold on;
scatter(latlon(nan_col,1),latlon(nan_col,2),'rx')
xlabel('Longitude')
hold off