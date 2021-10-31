clc;
clear;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
scenario=['ssp126';'ssp245';'ssp545'];
%% cdhw events only
for ssp=1:3
    
    path=strcat('L:\Master_matrix\',scenario(ssp,:),'\');
    for model=[1:2,5:9]
        tic
        for i=1:length(latlon(:,1)) 
            try
                hh=dir(strcat(path,num2str(i)));
                model_name=hh(model+2).name;
                data=load(strcat(path,num2str(i),'\',model_name));
                n=1;
                for yr=1982:2100
                    if latlon(i,2)>=0
                        z=find(data(:,1)==yr&data(:,2)>=5&data(:,2)<=10); % Northern Hemisphere
                        num_cdhw_event(n,i)=sum(data(z,14)>0);   %% number of cdhw events only
                        zsv= find(data(:,1)==yr&data(:,2)>=5&data(:,2)<=10&data(:,13)~=0);
                        severity(n,i)=mean(data(zsv,13));                                  %% severity of each cdhw event
                    else
                        z=find(data(:,1)==yr&data(:,2)>=11|data(:,1)==yr&data(:,2)<=4); % Southern Hemisphere
                        num_cdhw_event(n,i)=sum(data(z,14)>0);   %% number of cdhw events only
                        z=find(data(:,1)==yr&data(:,2)>=11&data(:,13)~=0|data(:,1)==yr&data(:,2)<=4&data(:,13)~=0); 
                        severity(n,i)=mean(data(zsv,13));
                    end
                    n=n+1;
                    
                end
            catch
            end
            disp([ssp,model,i])
        end
        %% save
        hhh=dir(strcat('L:\map_matrix\ssp\',scenario(ssp,:),'\'));
        %save('cdhwr.mat','cdhwr_model');
        save(strcat('L:\map_matrix\ssp\',scenario(ssp,:),'\',hhh(model+2).name,'\cdhwr_spatial_model_cdhwevents_sever.mat'),'severity','num_cdhw_event');
%         save(strcat('L:\map_matrix\ssp\',scenario(ssp,:),'\',hhh(model+2).name,'\cdhwr_spatial_model2.mat'),'cdhwr','cdhw','hwv','dr');
        %% spatial average and plot for a single model
        spsevere=[[1982:2100]',nanmean(severity,2)];
        spcdhw_event=[[1982:2100]',nanmean(num_cdhw_event,2)];

        save(strcat('L:\map_matrix\ssp\',scenario(ssp,:),'\',hhh(model+2).name,'\cdhwr_spatial_avg_model_cdhwevents_sever.mat'),'spsevere','spcdhw_event');
        toc
    end
end
































for ssp=1:3
    
    path=strcat('L:\Master_matrix\',scenario(ssp,:),'\');
    for model=[1:2,5:9]
        tic
        for i=1:length(latlon(:,1)) 
            try
                hh=dir(strcat(path,num2str(i)));
                model_name=hh(model+2).name;
                data=load(strcat(path,num2str(i),'\',model_name));
                n=1;
                for yr=1982:2100
                    if latlon(i,2)>=0
                        z=find(data(:,1)==yr&data(:,2)>=5&data(:,2)<=10); % Northern Hemisphere
                        cdhwd(n,i)=nansum(data(z,14));
                        cdhws(n,i)=nansum(data(z,13));
%                         dr(n,i)=nansum(data(z,9));
%                         hwv(n,i)=nansum(data(z,10));
%                         cdhw(n,i)=nansum(data(z,12));
%                         cdhwr(n,i)=nansum(data(z,12))/nansum(data(z,10));
%                         cdhwr(isinf(cdhwr))=NaN;
                    else
                        z=find(data(:,1)==yr&data(:,2)>=11|data(:,1)==yr&data(:,2)<=4); % Southern Hemisphere
                        cdhwd(n,i)=nansum(data(z,14));
                        cdhws(n,i)=nansum(data(z,13));
%                         dr(n,i)=nansum(data(z,9));
%                         hwv(n,i)=nansum(data(z,10));
%                         cdhw(n,i)=nansum(data(z,12));
%                         cdhwr(n,i)=nansum(data(z,12))/nansum(data(z,10));
%                         cdhwr(isinf(cdhwr))=NaN;
                    end
                    n=n+1;
                    
                end
            catch
            end
            disp([ssp,model,i])
        end
        %% save
        hhh=dir(strcat('L:\map_matrix\ssp\',scenario(ssp,:),'\'));
        %save('cdhwr.mat','cdhwr_model');
        save(strcat('L:\map_matrix\ssp\',scenario(ssp,:),'\',hhh(model+2).name,'\cdhwr_spatial_model_cdhw.mat'),'cdhws','cdhwd');
%         save(strcat('L:\map_matrix\ssp\',scenario(ssp,:),'\',hhh(model+2).name,'\cdhwr_spatial_model2.mat'),'cdhwr','cdhw','hwv','dr');
        %% spatial average and plot for a single model
        spcdhwd=[[1982:2100]',nanmean(cdhwd,2)];
        spcdhws=[[1982:2100]',nanmean(cdhws,2)];
%         sphwv=[[1982:2100]',nanmean(hwv,2)];
%         spcdhw=[[1982:2100]',nanmean(cdhw,2)];
%         spcdhwr=[[1982:2100]',nanmean(cdhwr,2)];
%         spdr=[[1982:2100]',nanmean(dr,2)];
        %%save it
        save(strcat('L:\map_matrix\ssp\',scenario(ssp,:),'\',hhh(model+2).name,'\cdhwr_spatial_avg_model_cdhw.mat'),'spcdhws','spcdhwd');
        toc
    end
end


%% Note [insert command following the objective written below
% insert save hwv, cdhw, and cdhwr in mat format (separately) for this model (inside the model folder).

%% spatial average and plot for a single model
sphwv=[[1982:2100]',nanmean(hwv,2)];
spcdhw=[[1982:2100]',nanmean(cdhw,2)];
spcdhwr=[[1982:2100]',nanmean(cdhwr,2)];
%% Note [insert command following the objective written below
% Now save these three files in the same folder of the model in mat format

%% just to look at the plot for a single model
subplot(3,1,1)
plot(sphwv(:,1),sphwv(:,2));
subplot(3,1,2)
plot(spcdhw(:,1),spcdhw(:,2));
subplot(3,1,3)
plot(spcdhwr(:,1),spcdhwr(:,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    pLotting

%% plotting the models

scenario=['ssp126';'ssp245';'ssp545'];

%% ssp 126
for ssp=1
    path2map_folder='L:\map_matrix\ssp\';
    newpath=strcat(path2map_folder,scenario(ssp,:));
    hh=dir(newpath);
    for model=2
        model_path=strcat(newpath,'\',hh(model+2).name);
        %         hhh=dir(model_path);
        data=load(strcat(model_path,'\','cdhwr_spatial_avg_model2.mat'));
        dr1{model}=data.spdr;
        cdhwr1{model}=data.spcdhwr;
        hwv1{model}=data.sphwv;
        cdhw1{model}=data.spcdhw;
    end

end

%% model average
%% model avg for ssp 126
for i=1:9
    %% cdhwr
    model_values(:,1)=cdhwr1{1}(:,1);
    model_values(:,i)=cdhwr1{i}(:,2);
    %% hwv
    model_hwv(:,1)=hwv1{1}(:,1);
    model_hwv(:,i)=hwv1{i}(:,2);
    
    %% cdhw
    model_cdhw(:,1)=cdhw1{1}(:,1);
    model_cdhw(:,i)=cdhw1{i}(:,2);
end
model_avg_126=[model_values(1:end-1,1),nanmean(model_values(1:end-1,2:end),2),...
    nanmean(model_hwv(1:end-1,2:end),2),nanmean(model_cdhw(1:end-1,2:end),2)];


%%                                               ssp 245             ###############################
for ssp=2
    path2map_folder='L:\map_matrix\ssp\';
    newpath=strcat(path2map_folder,scenario(ssp,:));
    hh=dir(newpath);
    for model=1:9
        model_path=strcat(newpath,'\',hh(model+2).name);
        %         hhh=dir(model_path);
        data=load(strcat(model_path,'\','cdhwr_spatial_avg.mat'));
        cdhwr1{model}=data.spcdhwr;
        hwv1{model}=data.sphwv;
        cdhw1{model}=data.spcdhw;
    end

end

%% model average
%% model avg for ssp245
for i=1:9
    model_values(:,1)=cdhwr1{1}(:,1);
    model_values(:,i)=cdhwr1{i}(:,2);
    %% hwv
    model_hwv(:,1)=hwv1{1}(:,1);
    model_hwv(:,i)=hwv1{i}(:,2);
    
    %% cdhw
    model_cdhw(:,1)=cdhw1{1}(:,1);
    model_cdhw(:,i)=cdhw1{i}(:,2);
    
end
model_avg_245=[model_values(1:end-1,1),nanmean(model_values(1:end-1,2:end),2),...
    nanmean(model_hwv(1:end-1,2:end),2),nanmean(model_cdhw(1:end-1,2:end),2)];
%%                                                             ssp 585


for ssp=3
    path2map_folder='L:\map_matrix\ssp\';
    newpath=strcat(path2map_folder,scenario(ssp,:));
    hh=dir(newpath);
    for model=1:9
        model_path=strcat(newpath,'\',hh(model+2).name);
        %         hhh=dir(model_path);
        data=load(strcat(model_path,'\','cdhwr_spatial_avg.mat'));
        cdhwr1{model}=data.spcdhwr;
        hwv1{model}=data.sphwv;
        cdhw1{model}=data.spcdhw;
    end
end
  %% model average
%% model avg for ssp585
for i=1:9
    model_values(:,1)=cdhwr1{1}(:,1);
    model_values(:,i)=cdhwr1{i}(:,2);
    %% hwv
    model_hwv(:,1)=hwv1{1}(:,1);
    model_hwv(:,i)=hwv1{i}(:,2);
    
    %% cdhw
    model_cdhw(:,1)=cdhw1{1}(:,1);
    model_cdhw(:,i)=cdhw1{i}(:,2);
    
end

model_avg_585=[model_values(1:end-1,1),nanmean(model_values(1:end-1,2:end),2),...
    nanmean(model_hwv(1:end-1,2:end),2),nanmean(model_cdhw(1:end-1,2:end),2)];




%% prepare the historical data
year_his=model_avg_585(1:38,1);
year_fut=model_avg_585(38:end,1);
hwv_his=mean([model_avg_126(1:38,3),model_avg_245(1:38,3),model_avg_585(1:38,3)],2);
cdhw_his=mean([model_avg_126(1:38,4),model_avg_245(1:38,4),model_avg_585(1:38,4)],2);
cdhwr_his=mean([model_avg_126(1:38,2),model_avg_245(1:38,2),model_avg_585(1:38,2)],2);
%% adjust for 2019
% heatwave
hwv_fut_126=[hwv_his(end);model_avg_126(39:end,3)];
hwv_fut_245=[hwv_his(end);model_avg_245(39:end,3)];
hwv_fut_585=[hwv_his(end);model_avg_585(39:end,3)];
hwv_ts=[[year_his;year_fut],[hwv_his;hwv_fut_126],[hwv_his;hwv_fut_245],[hwv_his;hwv_fut_585]];
%cdhw
cdhw_fut_126=[cdhw_his(end);model_avg_126(39:end,4)];
cdhw_fut_245=[cdhw_his(end);model_avg_245(39:end,4)];
cdhw_fut_585=[cdhw_his(end);model_avg_585(39:end,4)];
cdhw_ts=[[year_his;year_fut],[cdhw_his;cdhw_fut_126],[cdhw_his;cdhw_fut_245],[cdhw_his;cdhw_fut_585]];
% cdhwr
cdhwr_fut_126=[cdhwr_his(end);model_avg_126(39:end,2)];
cdhwr_fut_245=[cdhwr_his(end);model_avg_245(39:end,2)];
cdhwr_fut_585=[cdhwr_his(end);model_avg_585(39:end,2)];
cdhwr_ts=[[year_his;year_fut],[cdhwr_his;cdhwr_fut_126],[cdhwr_his;cdhwr_fut_245],[cdhwr_his;cdhwr_fut_585]];



%% moving avg
A=movmean(cdhw_ts(:,2:end),7);
plot(A,'DisplayName','A')
legend('ssp126','ssp245','ssp585','Location','northwest');
ylabel('CDHW')






%% subplot
figure(1)
title('Compound Heatwave and Drought 1982-2100')
subplot(3,1,1)
%% hwv
h(1)=plot(hwv_ts(:,1),hwv_ts(:,2),'r','LineWidth',2);
hold on;
h(2)=plot(hwv_ts(:,1),hwv_ts(:,3),'b-','LineWidth',2);
h(3)=plot(hwv_ts(:,1),hwv_ts(:,4),'g-','LineWidth',2);
h(4)=xline(2019,'k--','LineWidth',2);
grid on;


subtitle('Heatwave');
ylabel('No. of heatwave events')
legend(h([1:3]),'ssp126','ssp245','ssp585','Location','northwest');
xlabel('Years');
hold off;

%% cdhw
subplot(3,1,2)

h(1)=plot(cdhw_ts(:,1),cdhw_ts(:,2),'r','LineWidth',2);
hold on;
h(2)=plot(cdhw_ts(:,1),cdhw_ts(:,3),'b-','LineWidth',2);
h(3)=plot(cdhw_ts(:,1),cdhw_ts(:,4),'g-','LineWidth',2);
h(4)=xline(2019,'k--','LineWidth',2)
grid on;
subtitle('CDHW');
legend(h([1:3]),'ssp126','ssp245','ssp585','Location','northwest');
xlabel('Years');
ylabel('No. of CDHW events');
hold off;

%% cdhwr
subplot(3,1,3)
h(1)=plot(cdhwr_ts(:,1),cdhwr_ts(:,2),'r','LineWidth',2);
hold on;
grid on;
h(2)=plot(cdhwr_ts(:,1),cdhwr_ts(:,3),'b-','LineWidth',2);
h(3)=plot(cdhwr_ts(:,1),cdhwr_ts(:,4),'g-','LineWidth',2);
h(4)=xline(2019,'k--','LineWidth',2)
subtitle('CDHWR');
ylabel('CDHWR ratio');
legend(h([1:3]),'ssp126','ssp245','ssp585','Location','northwest');
xlabel('Years');
hold off;