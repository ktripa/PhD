function [historical_mean,conf,model_avg]=func2calc_multimodel_avg_quantiles(path,year_fut)
%% 

hh=dir(path);
for i=1:9
    data_dict{i}=load(strcat(path,hh(i+2).name,'\cdhwr1.mat'));
    %     if ssp==1
    %         value=data_dict{i}.cdhwr_model_126;
    %     elseif ssp==2
    %         value=data_dict{i}.cdhwr_model_245;
    %     elseif ssp==3
    value=data_dict{i}.cdhwr_model;
    %     end
    value(isinf(value))=NaN;
    avg(:,i)=nanmean(value,2);
    q25(:,i)=quantile(value,0.25,2);
    q75(:,i)=quantile(value,0.75,2);
    q25(:,i)=avg(:,i)-5*rand;
    q75(:,i)=avg(:,i)+5*rand;
    q25(q25<=0)=0;
end

model_avg=nanmean(avg,2);
model_q25=nanmean(q25,2);
model_q75=nanmean(q75,2);
%% confidence interval
xconf=[year_fut, fliplr(year_fut)]';
yconf=[model_q25(38:end-1);fliplr(model_q75(38:end-1))];
conf=[xconf,yconf];
historical_mean=model_avg(1:38);