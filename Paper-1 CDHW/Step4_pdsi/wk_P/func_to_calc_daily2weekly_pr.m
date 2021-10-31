function [week]=func_to_calc_daily2weekly_pr(dataframe)
data=dataframe;
t1 = datetime(data(3,1),data(3,2),data(3,3));
t2 = datetime(data(end,1),data(end,2),data(end,3));
time=[t1:days(7):t2];
[y,m,d]=ymd(time);
date=[y',m',d'];
%%
[~,n]=size(data);
data1=data(3:end,:);
%5 convert to weekly
week=zeros(length(d)+2,n);
week(3:end,1:3)=date;
week(1:2,:)=data(1:2,:);
for i =1:length(d)-1
    week(i+2,4:end)=sum(data1(7*(i-1)+1:7*i,4:end),'omitnan');
end
week(end,4:end)=sum(data1(end-1:end,4:end),'omitnan');
week=round(week,2);