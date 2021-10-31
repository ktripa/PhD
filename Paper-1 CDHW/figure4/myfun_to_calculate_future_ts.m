function [datef,outf]=myfun_to_calculate_future_ts(fname_tmax,fname_tmin)
t1 = datetime(2015,1,1); 
t2 = datetime(2099,12,31);
time=[t1:days(1):t2];  
[y,m,d]=ymd(time);
date=[y',m',d'];

%% tmax


datnc = netcdf.open(fname_tmax,'NC_NOWRITE');
qid = netcdf.inqVarID(datnc,'tasmax'); 
q=round(netcdf.getVar(datnc,qid),2);
ts=nanmean(nanmean(q,1),2);ts=ts(:);
timeid = netcdf.inqVarID(datnc,'time');
timen=netcdf.getVar(datnc,timeid);
timen=timen(1:length(date));

datef=date(timen+1-timen(1),:); 

datef=datef(1:length(date),:);


datef(:,4)=ts(1:length(date));
datef(1:length(date),4)=convtemp(datef(1:length(date),4),'K','C');
outf(:,1)=unique(datef(1:length(date),1));

%% tmin
datnc = netcdf.open(fname_tmin,'NC_NOWRITE');
qid = netcdf.inqVarID(datnc,'tasmin'); 
q=round(netcdf.getVar(datnc,qid),2);
ts=nanmean(nanmean(q,1),2);ts=ts(:);

datef(1:length(date),5)=ts(1:length(date));
datef(1:length(date),5)=convtemp(datef(1:length(date),5),'K','C');
outf(:,1)=unique(datef(1:length(date),1));
for i=1:length(outf(:,1))
    outf(i,2)=nanmean(datef(datef(:,1)==outf(i,1),4)); %tmax
    outf(i,3)=nanmean(datef(datef(:,1)==outf(i,1),5)); %tmin
end
outf(:,4)=(outf(:,2)+outf(:,3))/2;
datef(1:length(date),6)=(datef(1:length(date),4)+datef(1:length(date),5))/2;
end

