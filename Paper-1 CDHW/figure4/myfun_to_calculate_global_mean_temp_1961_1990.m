function [datef,outf,pid]=myfun_to_calculate_global_mean_temp_1961_1990(fname_tmax,fname_tmin)
%% tmax
datnc = netcdf.open(fname_tmax,'NC_NOWRITE');
qid = netcdf.inqVarID(datnc,'tasmax'); 
q=round(netcdf.getVar(datnc,qid),2);
ts=nanmean(nanmean(q,1),2);ts=ts(:);
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
t1 = datetime(1850,1,1,0,0,0); 
t2 = datetime(2014,12,31,18,0,0);
time=[t1:days(1):t2];  
[y,m,d]=ymd(time);
date=[y',m',d'];
datef=date(timen+1-timen(1),:); 
datef(:,4)=ts;
datef(:,4)=convtemp(datef(:,4),'K','C');

pid(1,1)=nanmean(datef(datef(:,1)>=1961&datef(:,1)<=1990,4));
outf(:,1)=unique(datef(:,1));

%% tmin
datnc = netcdf.open(fname_tmin,'NC_NOWRITE');
qid = netcdf.inqVarID(datnc,'tasmin'); 
q=round(netcdf.getVar(datnc,qid),2);
ts=nanmean(nanmean(q,1),2);ts=ts(:);
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);


datef(:,5)=ts;
datef(:,5)=convtemp(datef(:,5),'K','C');
pid(1,2)=nanmean(datef(datef(:,1)>=1961&datef(:,1)<=1990,5));
outf(:,1)=unique(datef(:,1));
for i=1:length(outf(:,1))
    outf(i,2)=nanmean(datef(datef(:,1)==outf(i,1),4)); %tmax
    outf(i,3)=nanmean(datef(datef(:,1)==outf(i,1),5)); %tmin
end
outf(:,4)=(outf(:,2)+outf(:,3))/2;
datef(:,6)=(datef(:,4)+datef(:,5))/2;
pid(1,3)=(pid(1,1)+pid(1,2))/2;
end

