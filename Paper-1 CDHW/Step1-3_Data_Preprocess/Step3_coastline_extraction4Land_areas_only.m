clc;
clear all;
t1 = datetime(2015,1,1,0,0,0); %% check in the netcdf file and see what is the initial time from when the time count starts
t2 = datetime(2100,12,31,18,0,0);
time=[t1:days(1):t2];  %% check the netcdf file : if the increments are in days or hours, here I used days

[y,m,d]=ymd(time);
date=[y',m',d']; %% check if the date vector is okay
%% Generating longitude latitude file for the land surface
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
scatter(latlon(:,1),latlon(:,2))
%%
% read the netcdf files
ls=dir(['J:\CMIP6_rg\ssp545']);
cd 'J:\CMIP6_rg\ssp545';
%for i=3:length(ls)
for i=3:11
filename=ls(i).name;
datnc = netcdf.open(filename,'NC_NOWRITE');
%ncdisp(filename);
qid = netcdf.inqVarID(datnc,'pr'); %% if variable name is "precip"
q=round(86400*netcdf.getVar(datnc,qid),2);
%% Time
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
%% Latitude
latid = netcdf.inqVarID(datnc,'lat'); %% check the netcdf file, sometimes they write it as "latitude" instead of "lat", use as it appears
lat=netcdf.getVar(datnc,latid);
%% Longitude
lonid = netcdf.inqVarID(datnc,'lon'); %% check the netcdf file, sometimes they write it as "longitude" instead of "lon", use as it appears
lon=netcdf.getVar(datnc,lonid);
lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;          %% this is only important if you want your range of longitude to be from -180 deg to +180 deg

datef=date(timen+1-timen(1),:); %% Check if the date vector is okay
fout=[];grid=[];

for i=1:length(latlon(:,1))
    %disp(i)
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
    writematrix(final,strcat('J:\Data_preprocess\MainDataFile\ssp545\',filename(1:end-3)),'delimiter','\t');
end
% dlmwrite(['J:\gg'],final,'delimiter','\t')
% scatter(final(1,4:end),final(2,4:end))

for i=12:20
filename=ls(i).name;
datnc = netcdf.open(filename,'NC_NOWRITE');
%ncdisp(filename);
qid = netcdf.inqVarID(datnc,'tasmax'); %% if variable name is "precip"
q=round(netcdf.getVar(datnc,qid),1);
%% Time
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
%% Latitude
latid = netcdf.inqVarID(datnc,'lat'); %% check the netcdf file, sometimes they write it as "latitude" instead of "lat", use as it appears
lat=netcdf.getVar(datnc,latid);
%% Longitude
lonid = netcdf.inqVarID(datnc,'lon'); %% check the netcdf file, sometimes they write it as "longitude" instead of "lon", use as it appears
lon=netcdf.getVar(datnc,lonid);
lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;          %% this is only important if you want your range of longitude to be from -180 deg to +180 deg

datef=date(timen+1-timen(1),:); %% Check if the date vector is okay
fout=[];grid=[];

for i=1:length(latlon(:,1))
        %disp([i,j])
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
    writematrix(final,strcat('J:\Data_preprocess\MainDataFile\ssp545\',filename(1:end-3)),'delimiter','\t');
end


for i=21:29
filename=ls(i).name;
datnc = netcdf.open(filename,'NC_NOWRITE');
%ncdisp(filename);
qid = netcdf.inqVarID(datnc,'tasmin'); %% if variable name is "precip"
q=round(netcdf.getVar(datnc,qid),1);
%% Time
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
%% Latitude
latid = netcdf.inqVarID(datnc,'lat'); %% check the netcdf file, sometimes they write it as "latitude" instead of "lat", use as it appears
lat=netcdf.getVar(datnc,latid);
%% Longitude
lonid = netcdf.inqVarID(datnc,'lon'); %% check the netcdf file, sometimes they write it as "longitude" instead of "lon", use as it appears
lon=netcdf.getVar(datnc,lonid);
lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;            %% this is only important if you want your range of longitude to be from -180 deg to +180 deg

datef=date(timen+1-timen(1),:); %% Check if the date vector is okay
fout=[];grid=[];

for i=1:length(latlon(:,1))
        %disp([i,j])
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
    writematrix(final,strcat('J:\Data_preprocess\MainDataFile\ssp545\',filename(1:end-3)),'delimiter','\t');
end







%% ssp245

% read the netcdf files
ls=dir(['J:\CMIP6_rg\ssp245']);
cd 'J:\CMIP6_rg\ssp245';
%for i=3:length(ls)
for i=3:11
filename=ls(i).name;
datnc = netcdf.open(filename,'NC_NOWRITE');
%ncdisp(filename);
qid = netcdf.inqVarID(datnc,'pr'); %% if variable name is "precip"
q=round(86400*netcdf.getVar(datnc,qid),2);
%% Time
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
%% Latitude
latid = netcdf.inqVarID(datnc,'lat'); %% check the netcdf file, sometimes they write it as "latitude" instead of "lat", use as it appears
lat=netcdf.getVar(datnc,latid);
%% Longitude
lonid = netcdf.inqVarID(datnc,'lon'); %% check the netcdf file, sometimes they write it as "longitude" instead of "lon", use as it appears
lon=netcdf.getVar(datnc,lonid);
lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;          %% this is only important if you want your range of longitude to be from -180 deg to +180 deg

datef=date(timen+1-timen(1),:); %% Check if the date vector is okay
fout=[];grid=[];

for i=1:length(latlon(:,1))
        %disp([i,j])
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
    writematrix(final,strcat('J:\Data_preprocess\MainDataFile\ssp245\',filename(1:end-3)),'delimiter','\t');
end


for i=12:20
filename=ls(i).name;
datnc = netcdf.open(filename,'NC_NOWRITE');
%ncdisp(filename);
qid = netcdf.inqVarID(datnc,'tasmax'); %% if variable name is "precip"
q=round(netcdf.getVar(datnc,qid),2);
%% Time
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
%% Latitude
latid = netcdf.inqVarID(datnc,'lat'); %% check the netcdf file, sometimes they write it as "latitude" instead of "lat", use as it appears
lat=netcdf.getVar(datnc,latid);
%% Longitude
lonid = netcdf.inqVarID(datnc,'lon'); %% check the netcdf file, sometimes they write it as "longitude" instead of "lon", use as it appears
lon=netcdf.getVar(datnc,lonid);
lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;          %% this is only important if you want your range of longitude to be from -180 deg to +180 deg

datef=date(timen+1-timen(1),:); %% Check if the date vector is okay
fout=[];grid=[];

for i=1:length(latlon(:,1))
        %disp([i,j])
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
    writematrix(final,strcat('J:\Data_preprocess\MainDataFile\ssp245\',filename(1:end-3)),'delimiter','\t');
end


for i=21:29
filename=ls(i).name;
datnc = netcdf.open(filename,'NC_NOWRITE');
%ncdisp(filename);
qid = netcdf.inqVarID(datnc,'tasmin'); %% if variable name is "precip"
q=round(netcdf.getVar(datnc,qid),2);
%% Time
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
%% Latitude
latid = netcdf.inqVarID(datnc,'lat'); %% check the netcdf file, sometimes they write it as "latitude" instead of "lat", use as it appears
lat=netcdf.getVar(datnc,latid);
%% Longitude
lonid = netcdf.inqVarID(datnc,'lon'); %% check the netcdf file, sometimes they write it as "longitude" instead of "lon", use as it appears
lon=netcdf.getVar(datnc,lonid);
lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;          %% this is only important if you want your range of longitude to be from -180 deg to +180 deg

datef=date(timen+1-timen(1),:); %% Check if the date vector is okay
fout=[];grid=[];

for i=1:length(latlon(:,1))
        %disp([i,j])
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
    writematrix(final,strcat('J:\Data_preprocess\MainDataFile\ssp245\',filename(1:end-3)),'delimiter','\t');
end



%% ssp126
% read the netcdf files
ls=dir(['J:\CMIP6_rg\ssp126']);
cd 'J:\CMIP6_rg\ssp126';
%for i=3:length(ls)
for i=3:11
    filename=ls(i).name;
    datnc = netcdf.open(filename,'NC_NOWRITE');
    %ncdisp(filename);
    qid = netcdf.inqVarID(datnc,'pr'); %% if variable name is "precip"
    q=round(86400*netcdf.getVar(datnc,qid),2);
    %% Time
    timeid = netcdf.inqVarID(datnc,'time');
    timen=netcdf.getVar(datnc,timeid);
    %% Latitude
    latid = netcdf.inqVarID(datnc,'lat'); %% check the netcdf file, sometimes they write it as "latitude" instead of "lat", use as it appears
    lat=netcdf.getVar(datnc,latid);
    %% Longitude
    lonid = netcdf.inqVarID(datnc,'lon'); %% check the netcdf file, sometimes they write it as "longitude" instead of "lon", use as it appears
    lon=netcdf.getVar(datnc,lonid);
    lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;          %% this is only important if you want your range of longitude to be from -180 deg to +180 deg
    
    datef=date(timen+1-timen(1),:); %% Check if the date vector is okay
    fout=[];grid=[];
    
    for i=1:length(latlon(:,1))
        %disp([i,j])
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
    writematrix(final,strcat('J:\Data_preprocess\MainDataFile\ssp126\',filename(1:end-3)),'delimiter','\t');
end



for i=12:20
filename=ls(i).name;
datnc = netcdf.open(filename,'NC_NOWRITE');
%ncdisp(filename);
qid = netcdf.inqVarID(datnc,'tasmax'); %% if variable name is "precip"
q=round(netcdf.getVar(datnc,qid),2);
%% Time
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
%% Latitude
latid = netcdf.inqVarID(datnc,'lat'); %% check the netcdf file, sometimes they write it as "latitude" instead of "lat", use as it appears
lat=netcdf.getVar(datnc,latid);
%% Longitude
lonid = netcdf.inqVarID(datnc,'lon'); %% check the netcdf file, sometimes they write it as "longitude" instead of "lon", use as it appears
lon=netcdf.getVar(datnc,lonid);
lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;          %% this is only important if you want your range of longitude to be from -180 deg to +180 deg

datef=date(timen+1-timen(1),:); %% Check if the date vector is okay
fout=[];grid=[];

for i=1:length(latlon(:,1))
        %disp([i,j])
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
    writematrix(final,strcat('J:\Data_preprocess\MainDataFile\ssp126\',filename(1:end-3)),'delimiter','\t');
end









%% Historical
t1 = datetime(1850,1,1,0,0,0); %% check in the netcdf file and see what is the initial time from when the time count starts
t2 = datetime(2014,12,31,18,0,0);
time=[t1:days(1):t2];  %% check the netcdf file : if the increments are in days or hours, here I used days

[y,m,d]=ymd(time);
date=[y',m',d']; %% check if the date vector is okay
%% Generating longitude latitude file for the land surface
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
scatter(latlon(:,1),latlon(:,2))



ls=dir(['J:\CMIP6_rg\Historical\']);
cd 'J:\CMIP6_rg\Historical\';
%for i=3:length(ls)
for i=3:11
filename=ls(i).name;
datnc = netcdf.open(filename,'NC_NOWRITE');
%ncdisp(filename);
qid = netcdf.inqVarID(datnc,'pr'); %% if variable name is "precip"
q=round(86400*netcdf.getVar(datnc,qid),2);
%% Time
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
%% Latitude
latid = netcdf.inqVarID(datnc,'lat'); %% check the netcdf file, sometimes they write it as "latitude" instead of "lat", use as it appears
lat=netcdf.getVar(datnc,latid);
%% Longitude
lonid = netcdf.inqVarID(datnc,'lon'); %% check the netcdf file, sometimes they write it as "longitude" instead of "lon", use as it appears
lon=netcdf.getVar(datnc,lonid);
lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;          %% this is only important if you want your range of longitude to be from -180 deg to +180 deg

datef=date(timen+1-timen(1),:); %% Check if the date vector is okay
fout=[];grid=[];

for i=1:length(latlon(:,1))
    %disp(i)
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
    writematrix(final,strcat('J:\Data_preprocess\MainDataFile\Historical\',filename(1:end-3)),'delimiter','\t');
end




for i=3:11
    filename=ls(i).name;
    datnc = netcdf.open(filename,'NC_NOWRITE');
    %ncdisp(filename);
    qid = netcdf.inqVarID(datnc,'pr'); %% if variable name is "precip"
    q=round(86400*netcdf.getVar(datnc,qid),2);
    %% Time
    timeid = netcdf.inqVarID(datnc,'time');
    timen=netcdf.getVar(datnc,timeid);
    %% Latitude
    latid = netcdf.inqVarID(datnc,'lat'); %% check the netcdf file, sometimes they write it as "latitude" instead of "lat", use as it appears
    lat=netcdf.getVar(datnc,latid);
    %% Longitude
    lonid = netcdf.inqVarID(datnc,'lon'); %% check the netcdf file, sometimes they write it as "longitude" instead of "lon", use as it appears
    lon=netcdf.getVar(datnc,lonid);
    lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;          %% this is only important if you want your range of longitude to be from -180 deg to +180 deg
    
    datef=date(timen+1-timen(1),:); %% Check if the date vector is okay
    fout=[];grid=[];
    
    for i=1:length(latlon(:,1))
        %disp([i,j])
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
    writematrix(final,strcat('J:\Data_preprocess\MainDataFile\Historical\',filename(1:end-3)),'delimiter','\t');
end



for i=12:17
filename=ls(i).name;
datnc = netcdf.open(filename,'NC_NOWRITE');
%ncdisp(filename);
qid = netcdf.inqVarID(datnc,'tasmax'); %% if variable name is "precip"
q=round(netcdf.getVar(datnc,qid),2);
%% Time
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
%% Latitude
latid = netcdf.inqVarID(datnc,'lat'); %% check the netcdf file, sometimes they write it as "latitude" instead of "lat", use as it appears
lat=netcdf.getVar(datnc,latid);
%% Longitude
lonid = netcdf.inqVarID(datnc,'lon'); %% check the netcdf file, sometimes they write it as "longitude" instead of "lon", use as it appears
lon=netcdf.getVar(datnc,lonid);
lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;          %% this is only important if you want your range of longitude to be from -180 deg to +180 deg

datef=date(timen+1-timen(1),:); %% Check if the date vector is okay
fout=[];grid=[];

for i=1:length(latlon(:,1))
        disp([i,j])
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
    writematrix(final,strcat('J:\Data_preprocess\MainDataFile\Historical\',filename(1:end-3)),'delimiter','\t');
end
%% tasmin
for i=18:23
filename=ls(i).name;
datnc = netcdf.open(filename,'NC_NOWRITE');
%ncdisp(filename);
qid = netcdf.inqVarID(datnc,'tasmin'); %% if variable name is "precip"
q=round(netcdf.getVar(datnc,qid),2);
%% Time
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
%% Latitude
latid = netcdf.inqVarID(datnc,'lat'); %% check the netcdf file, sometimes they write it as "latitude" instead of "lat", use as it appears
lat=netcdf.getVar(datnc,latid);
%% Longitude
lonid = netcdf.inqVarID(datnc,'lon'); %% check the netcdf file, sometimes they write it as "longitude" instead of "lon", use as it appears
lon=netcdf.getVar(datnc,lonid);
lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;          %% this is only important if you want your range of longitude to be from -180 deg to +180 deg

datef=date(timen+1-timen(1),:); %% Check if the date vector is okay
fout=[];grid=[];

for i=1:length(latlon(:,1))
        %disp([i,j])
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
    writematrix(final,strcat('J:\Data_preprocess\MainDataFile\Historical\',filename(1:end-3)),'delimiter','\t');
end



%% ssp126
clc;
clear all;
t1 = datetime(2015,1,1,0,0,0); %% check in the netcdf file and see what is the initial time from when the time count starts
t2 = datetime(2100,12,31,18,0,0);
time=[t1:days(1):t2];  %% check the netcdf file : if the increments are in days or hours, here I used days

[y,m,d]=ymd(time);
date=[y',m',d']; %% check if the date vector is okay
%% Generating longitude latitude file for the land surface
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
%scatter(latlon(:,1),latlon(:,2))
%% ssp126
% read the netcdf files
ls=dir(['J:\CMIP6_rg\ssp126']);
cd 'J:\CMIP6_rg\ssp126';


for i=[25,26,27,29]
filename=ls(i).name;
datnc = netcdf.open(filename,'NC_NOWRITE');
%ncdisp(filename);
qid = netcdf.inqVarID(datnc,'tasmin'); %% if variable name is "precip"
q=round(netcdf.getVar(datnc,qid),2);
%% Time
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
%% Latitude
latid = netcdf.inqVarID(datnc,'lat'); %% check the netcdf file, sometimes they write it as "latitude" instead of "lat", use as it appears
lat=netcdf.getVar(datnc,latid);
%% Longitude
lonid = netcdf.inqVarID(datnc,'lon'); %% check the netcdf file, sometimes they write it as "longitude" instead of "lon", use as it appears
lon=netcdf.getVar(datnc,lonid);
lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;          %% this is only important if you want your range of longitude to be from -180 deg to +180 deg

datef=date(timen+1-timen(1),:); %% Check if the date vector is okay
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
            out(out(:,1)==-9999,1)=NaN;
            fout=[fout,out];
            grid=[grid;[lon(zlon,1),lat(zlat,1)]];
        else
        end
    else
    end
end

    final=[[[[NaN,NaN,NaN];[NaN,NaN,NaN]],grid'];[datef,fout]];
    writematrix(final,strcat('J:\Data_preprocess\MainDataFile\ssp126\',filename(1:end-3)),'delimiter','\t');
end
%%

%%%%%%%%%%%%  March 2, 2021  %%%%%%%%%%%%%%%%%%%
clc;
clear all;
t1 = datetime(1850,1,1); %% check in the netcdf file and see what is the initial time from when the time count starts
t2 = datetime(2014,12,31);
time=[t1:days(1):t2];  %% check the netcdf file : if the increments are in days or hours, here I used days

[y,m,d]=ymd(time);
date=[y',m',d']; %% check if the date vector is okay
%% Generating longitude latitude file for the land surface
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
scatter(latlon(:,1),latlon(:,2))
%% ssp126
% read the netcdf files
ls=dir(['J:\CMIP6_rg\Historical\']);
cd 'J:\CMIP6_rg\Historical\';


for i=28
filename=ls(i).name;
datnc = netcdf.open(filename,'NC_NOWRITE');
%ncdisp(filename);
qid = netcdf.inqVarID(datnc,'tasmin'); %% if variable name is "precip"
q=round(netcdf.getVar(datnc,qid),2);
%% Time
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
%% Latitude
latid = netcdf.inqVarID(datnc,'lat'); %% check the netcdf file, sometimes they write it as "latitude" instead of "lat", use as it appears
lat=netcdf.getVar(datnc,latid);
%% Longitude
lonid = netcdf.inqVarID(datnc,'lon'); %% check the netcdf file, sometimes they write it as "longitude" instead of "lon", use as it appears
lon=netcdf.getVar(datnc,lonid);
lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;          %% this is only important if you want your range of longitude to be from -180 deg to +180 deg

datef=date(timen+1-timen(1),:); %% Check if the date vector is okay
fout=[];grid=[];

for i=1:length(latlon(:,1))
    disp([i,j])
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
    writematrix(final,strcat('J:\Data_preprocess\MainDataFile\Historical\',filename(1:end-3)),'delimiter','\t');
end


%%
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
scatter(latlon(:,1),latlon(:,2))
%% ssp126
% read the netcdf files
ls=dir(['J:\CMIP6_rg\Historical\']);
cd 'J:\CMIP6_rg\Historical\';


for i=28
filename=ls(i).name;
datnc = netcdf.open(filename,'NC_NOWRITE');
%ncdisp(filename);
qid = netcdf.inqVarID(datnc,'tasmin'); %% if variable name is "precip"
q=round(netcdf.getVar(datnc,qid),2);
%% Time
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
%% Latitude
latid = netcdf.inqVarID(datnc,'lat'); %% check the netcdf file, sometimes they write it as "latitude" instead of "lat", use as it appears
lat=netcdf.getVar(datnc,latid);
%% Longitude
lonid = netcdf.inqVarID(datnc,'lon'); %% check the netcdf file, sometimes they write it as "longitude" instead of "lon", use as it appears
lon=netcdf.getVar(datnc,lonid);
lon(lon(:,1)>180,1)=lon(lon(:,1)>180,1)-360;          %% this is only important if you want your range of longitude to be from -180 deg to +180 deg

datef=date(timen+1-timen(1),:); %% Check if the date vector is okay
fout=[];grid=[];

for i=1:length(latlon(:,1))
        disp([i,j])
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
    writematrix(final,strcat('J:\Data_preprocess\MainDataFile\Historical\',filename(1:end-3)),'delimiter','\t');
end