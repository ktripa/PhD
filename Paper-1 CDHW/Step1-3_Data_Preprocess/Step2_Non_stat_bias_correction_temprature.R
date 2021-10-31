rm(list=ls(all=TRUE))
#All reqd Packages
library(rpart)
library(nlme)
library(spatstat)
# Latlon table
latlon=read.table("J:/Data_preprocess/MainDataFile/latlon_GPCCdata.txt")

#Read the observed cpc Data

his=dir("J:/Data_preprocess/MainDataFile/Historical/")
# read ssp126 
d126=dir("J:/Data_preprocess/MainDataFile/ssp126/")
d245=dir("J:/Data_preprocess/MainDataFile/ssp245/")
d545=dir("J:/Data_preprocess/MainDataFile/ssp545/")












dataobs_tmin=read.table("J:/Data_preprocess/MainDataFile/tmin_1979_2016_rg.txt")
dataobs_tmax=read.table("J:/Data_preprocess/MainDataFile/tmax_1979_2016_rg.txt")


################################################################################################################
#Bias-corrected dataset for ssp126
for (model in 23:27){
  datahis=read.table(paste0("J:/Data_preprocess/MainDataFile/Historical/",his[model]))
  data126=read.table(paste0("J:/Data_preprocess/MainDataFile/ssp126/",d126[model]))
  bcd126=data126
  for(l in 1:length(latlon[,1]))
    
    {
    
    print(c(model,l))
    xoc=dataobs_tmin[3:length(dataobs_tmin[,l+3]),l+3]
    if (all(is.na(xoc)==T)) next
    # sprintf("Going to the next iteration since no observed data for the latlon: %d",c(latlon[l,1],latlon[l,2]))
    
    moc=datahis[3:length(datahis[,l+3]),l+3]
    rcp=data126[3:length(data126[,l+3]),l+3]
    Fmp=ecdf(rcp)
    Fi_oc=as.matrix(quantile(xoc,Fmp(rcp),na.rm=TRUE))
    Fi_mc=as.matrix(quantile(moc,Fmp(rcp),na.rm=TRUE))
    dif=Fi_oc-Fi_mc
    bcd126[3:dim(bcd126)[1],l+3]=round(rcp+Fi_oc-Fi_mc,2)
  }

  xxna=which(is.na(bcd126),arr.ind = T)
  bcd126[xxna]=data126[xxna]
  write.table(bcd126, paste0("J:/Data_preprocess/MainDataFile/Bias_corrected_data/ssp126/",substr(d126[model],1,nchar(d126[model])-4),"_BC.txt"),row.names=FALSE,col.names=FALSE,sep = "\t")
  
}
rm(xx,xxna,bcd126,data126,moc,xoc,Fi_mc,Fi_oc)
################################################################################################################
#Bias-corrected dataset for ssp245
for (model in 26:27){
  datahis=read.table(paste0("J:/Data_preprocess/MainDataFile/Historical/",his[model]))
  data245=read.table(paste0("J:/Data_preprocess/MainDataFile/ssp245/",d245[model]))
  bcd245=data245
  for(l in 1:length(latlon[,1]))
    
  {
    
    print(c(model,l))
    xoc=dataobs_tmin[3:length(dataobs_tmin[,l+3]),l+3]
    if (all(is.na(xoc)==T)) next
    # sprintf("Going to the next iteration since no observed data for the latlon: %d",c(latlon[l,1],latlon[l,2]))
    
    moc=datahis[3:length(datahis[,l+3]),l+3]
    rcp=data245[3:length(data245[,l+3]),l+3]
    Fmp=ecdf(rcp)
    Fi_oc=as.matrix(quantile(xoc,Fmp(rcp),na.rm=TRUE))
    Fi_mc=as.matrix(quantile(moc,Fmp(rcp),na.rm=TRUE))
    dif=Fi_oc-Fi_mc
    bcd245[3:dim(bcd245)[1],l+3]=round(rcp+Fi_oc-Fi_mc,2)
  }
  # Determine which elements are NA or negative
  ##xx=which(bcd245<0,arr.ind = T)
  ##bcd245[xx]=0
  # if NaN exists then replace it with the scenario value( No bias correction)
  xxna=which(is.na(bcd245),arr.ind = T)
  bcd245[xxna]=data245[xxna]
  write.table(bcd245, paste0("J:/Data_preprocess/MainDataFile/Bias_corrected_data/ssp245/",substr(d245[model],1,nchar(d245[model])-4),"_BC.txt"),row.names=FALSE,col.names=FALSE,sep = "\t")
  
}
rm(xx,xxna,bcd245,data245,moc,xoc,Fi_mc,Fi_oc)


#Bias-corrected dataset for ssp545
for (model in 26:27){
  datahis=read.table(paste0("J:/Data_preprocess/MainDataFile/Historical/",his[model]))
  data545=read.table(paste0("J:/Data_preprocess/MainDataFile/ssp545/",d545[model]))
  bcd545=data545
  for(l in 1:length(latlon[,1]))
    
  {
    
    print(c(model,l))
    xoc=dataobs_tmin[3:length(dataobs_tmin[,l+3]),l+3]
    if (all(is.na(xoc)==T)) next
    # sprintf("Going to the next iteration since no observed data for the latlon: %d",c(latlon[l,1],latlon[l,2]))
    
    moc=datahis[3:length(datahis[,l+3]),l+3]
    rcp=data545[3:length(data545[,l+3]),l+3]
    Fmp=ecdf(rcp)
    Fi_oc=as.matrix(quantile(xoc,Fmp(rcp),na.rm=TRUE))
    Fi_mc=as.matrix(quantile(moc,Fmp(rcp),na.rm=TRUE))
    dif=Fi_oc-Fi_mc
    bcd545[3:dim(bcd545)[1],l+3]=round(rcp+Fi_oc-Fi_mc,2)
  }
  # Determine which elements are NA or negative
  ##xx=which(bcd545<0,arr.ind = T)
  ##bcd545[xx]=0
  # if NaN exists then replace it with the scenario value( No bias correction)
  xxna=which(is.na(bcd545),arr.ind = T)
  bcd545[xxna]=data545[xxna]
  write.table(bcd545, paste0("J:/Data_preprocess/MainDataFile/Bias_corrected_data/ssp545/",substr(d545[model],1,nchar(d545[model])-4),"_BC.txt"),row.names=FALSE,col.names=FALSE,sep = "\t")
  
}
rm(xx,xxna,bcd545,data545,moc,xoc,Fi_mc,Fi_oc)