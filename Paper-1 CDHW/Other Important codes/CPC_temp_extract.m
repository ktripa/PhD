clear;clc;
path= 'K:\CPC_data\tasmin\cat';
cd (path);
ls=dir(path);

t1 = datetime(1979,1,1); %% check in the netcdf file and see what is the initial time from when the time count starts
t2 = datetime(2019,12,31);
time=[t1:days(1):t2];  %% check the netcdf file : if the increments are in days or hours, here I used days
[y,m,d]=ymd(time);
date=[y',m',d']; 
%% Coastlines forextracting the landareas data only
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
filename='tmin_1979_2019_rg.nc';
datnc = netcdf.open(filename,'NC_NOWRITE');
qid = netcdf.inqVarID(datnc,'tmin'); %% if variable name is "precip"
q=round(netcdf.getVar(datnc,qid),2)+273;  %% In Kelvin scale
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
%% Latitude
latid = netcdf.inqVarID(datnc,'lat'); 
lat=netcdf.getVar(datnc,latid);
%% Longitude
lonid = netcdf.inqVarID(datnc,'lon'); 
lon=netcdf.getVar(datnc,lonid);
lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;
%% for GPCC Data Only

datef=date; %% Check if the date vector is okay
fout=[];grid=[];



for i=1:length(latlon(:,1))
    disp(i)
    zlon=find(lon(:,1)==latlon(i,1));
    if isempty(zlon)==0
        zlat=find(lat(:,1)==latlon(i,2));
        if isempty(zlat)==0
            out=squeeze(double(q(zlon,zlat,1:length(timen(:,1)))));
            %% Check if the netcdf file has missing values indicated by a digit (say) -9999
            %% If yes then use:
            out(out(:,1)<=-9999,1)=NaN;
            fout=[fout,out];
            grid=[grid;[lon(zlon,1),lat(zlat,1)]];
        else
        end
    else
    end
end

final=[[[[NaN,NaN,NaN];[NaN,NaN,NaN]],grid'];[datef,fout]];
writematrix(final,'J:\Data_preprocess\MainDataFile\tmin_1979_2019_rg.txt','delimiter','\t');

clear final grid fout
%%%
%% Tasmax 
%%
path= 'K:\CPC_data\Tasmax\cat';
cd (path);
ls=dir(path);
filename='tmax_1979_2019_rg.nc';
datnc = netcdf.open(filename,'NC_NOWRITE');
qid = netcdf.inqVarID(datnc,'tmax'); %% if variable name is "precip"
q=round(netcdf.getVar(datnc,qid),2)+273;
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
%% Latitude
latid = netcdf.inqVarID(datnc,'lat'); 
lat=netcdf.getVar(datnc,latid);
%% Longitude
lonid = netcdf.inqVarID(datnc,'lon'); 
lon=netcdf.getVar(datnc,lonid);
lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;
%% for GPCC Data Only

datef=date; %% Check if the date vector is okay
fout=[];grid=[];



for i=1:length(latlon(:,1))
    disp(i)
    zlon=find(lon(:,1)==latlon(i,1));
    if isempty(zlon)==0
        zlat=find(lat(:,1)==latlon(i,2));
        if isempty(zlat)==0
            out=squeeze(double(q(zlon,zlat,1:length(timen(:,1)))));
            %% Check if the netcdf file has missing values indicated by a digit (say) -9999
            %% If yes then use:
            out(out(:,1)<=-9999,1)=NaN;
            fout=[fout,out];
            grid=[grid;[lon(zlon,1),lat(zlat,1)]];
        else
        end
    else
    end
end

final=[[[[NaN,NaN,NaN];[NaN,NaN,NaN]],grid'];[datef,fout]];
writematrix(final,'J:\Data_preprocess\MainDataFile\tmax_1979_2019_rg.txt','delimiter','\t');



%%%%%%%%%%%%%%%%%%% Mean observed temperature %%%%%%%%%%%%%%
cd 'J:\Data_preprocess\MainDataFile\';
tasmax=load ('tmax_1979_2019_rg.txt');
tasmin=load ('tmin_1979_2019_rg.txt');
tasmean=(tasmax+tasmin)/2;
writematrix(tasmean,'J:\Data_preprocess\MainDataFile\tmean_1979_2019_rg.txt','delimiter','\t');

%% Weekly values
clear;clc;
path='J:\Data_preprocess\MainDataFile';
cd(path);
tmin=load('tmin_1979_2019_rg.txt');
tmax=load('tmax_1979_2019_rg.txt');
tmean=load('tmean_1979_2019_rg.txt');
latlon=load('latlon_GPCCdata.txt')';
%% tmin
[week,final]=func_to_calc_daily2weekly(tmin,latlon);
writematrix(week,'tmin_1979_2019_weekly.txt','delimiter','\t');
writematrix(final,'tmin_1979_2019_weekly_tnormal.txt','delimiter','\t');
%% tmax
[week,final]=func_to_calc_daily2weekly(tmax,latlon);
writematrix(week,'tmax_1979_2019_weekly.txt','delimiter','\t');
writematrix(final,'tmax_1979_2019_weekly_tnormal.txt','delimiter','\t');
%% tmean
[week,final]=func_to_calc_daily2weekly(tmean,latlon);
writematrix(week,'tmean_1979_2019_weekly.txt','delimiter','\t');
writematrix(final,'tmean_1979_2019_weekly_tnormal.txt','delimiter','\t');
%% Weekly Precipitation





