rm(list=ls(all=TRUE))
latlon=read.table("J:\Code_Bias_corre\latlon_2deg_CONUS")
latlonf=latlon;
latlonf[,1]=latlon[,1]-360
model=list.files("H:/Sourav/Non-stationary_HI_paper/CMIP5/HI/Rawxrcp85/")
library(rpart)
library(nlme)
library(spatstat)
for(m in 1:length(model)){
  print(model[m])
  dir.create(paste0("H:/Sourav/Non-stationary_HI_paper/CMIP5/HI/Bias_Corrected/HI_rcp45/",model[m]))
  for(l in 1:length(latlon[,1])){
    print(l)
    data1=read.table(paste0("H:/Sourav/Non-stationary_HI_paper/CMIP5/Data_inputs/Aligned_vectors_for_bias_corretion/hi/",model[m],"/data_",latlonf[l,1],"_",latlonf[l,2]),fill=TRUE)
    data2=read.table(paste0("H:/Sourav/Non-stationary_HI_paper/CMIP5/HI/Rawxrcp45/",model[m],"/data_",latlonf[l,1],"_",latlonf[l,2]),fill=TRUE)
    
    if(length(which(is.na(data2[,6])==FALSE))>34000){
      
      xoc=data1[,4]
      moc=data1[,5]
      rcp=data2[data2[,1]>=2006&data2[,1]<=2100,]
      fmp=density(rcp[,6],na.rm=TRUE)
      Fmp=CDF(fmp)
      Fi_oc=as.matrix(quantile(xoc,Fmp(rcp[,6]),na.rm=TRUE))
      Fi_mc=as.matrix(quantile(moc,Fmp(rcp[,6]),na.rm=TRUE))
      ## 10th column is the bias corrected heat index
      EDCDF=as.data.frame(cbind(rcp[,1:3],rcp[,6],Fi_oc,Fi_mc,Fi_oc-Fi_mc,rcp[,6]+Fi_oc-Fi_mc))
      out=cbind(cbind(rcp[,1:6]),rcp[,6]+Fi_oc-Fi_mc)
      rm(EDCDF)
    }else{
      EDCDF=as.data.frame(cbind(rcp[,1:3],rcp[,6],NA,NA,NA,NA))
      rm(EDCDF)
      out=cbind(cbind(rcp[,1:6]),NA)
    }
    write.table(out, paste0("H:/Sourav/Non-stationary_HI_paper/CMIP5/HI/Bias_Corrected/HI_rcp45/",model[m],"/data_",latlonf[l,1],"_",latlonf[l,2]),row.names=FALSE, col.names=FALSE,na = "NaN")
  }
}
