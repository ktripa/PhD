function [week,final]=func_to_calc_daily2weekly_temperature(dataframe,latlon)
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
    week(i+2,4:end)=mean(data1(7*(i-1)+1:7*i,4:end));
end
week(end,4:end)=mean(data1(end-1:end,4:end));
week=round(week,2);

% final=0;
start_year=min(week(:,1));
end_year=max(week(:,1));
years=start_year:end_year;
[~,n]=size(data);
n_weeks=52;
%% Check how many weeks are there in the final year: NorESMm and CanEsM have problems some times
% last_weeks=sum(week(3:end,1)==end_year);
mat=zeros(n_weeks,length(years));

% Final matrix shape
final=zeros(n_weeks+2,n-2);
final(1:2,1)=[NaN,NaN];
final(1:2,2:end)=latlon';
final(3:end,1)=1:n_weeks;
for g=4:n
    for i=1:(end_year-start_year+1)
        start_col=find(week(:,1)==start_year-1+i,1);
        end_col=start_col+51;
        if end_col<=length(week)
            mat(:,i)=week(start_col:end_col,g);
        elseif end_col>length(week)
            cc=end_col-length(week);
            mat(1:end-cc,i)=week(start_col:length(week),g);
            mat(end-cc+1:end,i)=mat(1:cc,i);
        end
    end
    final(3:end,g-2)=mean(mat,2,'omitnan');
end
final=round(final,2);
end
