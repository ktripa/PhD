clc;clear;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');

filename='L:\Data_preprocess\MainDataFile\tmax_1979_2019_rg.txt';
txd=load(filename);
txd(txd(:,1)<=1981,:)=[];

pdsifile='L:\sc_pdsi_daily_1982_2100\ssp545\ACCESS_CM2_daily_pdsi_1982_2100.txt';
pdsi=load(pdsifile);
pdsi=pdsi(1:length(txd),:);

ystart=1982; yend=2011;
y1=1982; y2=2019;
may=5;apr=4;oct=10;nov=11;


nii=1;ni=1;IQR=[];P25=[];
%% calculate the matrix for every gridpoint
%         for ii=1:length(latlon(:,1))
final3d=cell(3347,1);
for ii=1:3347
    %disp(ii);
    data=[txd(3:end,1:3),txd(3:end,ii+3)];
    
    %% call the pdsi data
    pdsi1=pdsi(:,ii+3);
    zp=find(pdsi(:,1)>=ystart&pdsi(:,1)<=yend);
    drth=quantile(pdsi(zp,4),0.10);
    
    %% northen hemisphere
    if latlon(ii,2)>=0
        th=quantile(data(data(:,1)>=y1&data(:,1)<=y2&data(:,2)>=may & data(:,2)<=oct,4),0.95);
        t25=quantile(data(data(:,1)>=y1&data(:,1)<=y2&data(:,2)>=may &data(:,2)<=oct,4),0.25);
        int=quantile(data(data(:,1)>=y1&data(:,1)<=y2&data(:,2)>=may & data(:,2)<=oct,4),0.75)-quantile(data(data(:,1)>=y1&data(:,1)<=y2&data(:,2)>=5&data(:,2)<=10,4),0.25);
    else %% southern hemisphere
        th=quantile(data(data(:,1)>=y1&data(:,1)<=y2&data(:,2)>=nov|data(:,1)>=y1&data(:,1)<=y2&data(:,2)<=apr,4),0.95);
        t25=quantile(data(data(:,1)>=y1&data(:,1)<=y2&data(:,2)>=nov|data(:,1)>=y1&data(:,1)<=y2&data(:,2)<=apr,4),0.25);
        int=quantile(data(data(:,1)>=y1&data(:,1)<=y2&data(:,2)>=nov|data(:,1)>=y1&data(:,1)<=y2&data(:,2)<=apr,4),0.75)-quantile(data(data(:,1)>=y1&data(:,1)<=y2&data(:,2)>=nov|data(:,1)>=y1&data(:,1)<=y2&data(:,2)<=apr,4),0.25);
    end
    IQR=[IQR,int];P25=[P25,t25];








    data1f=[data,repmat(th,length(data(:,1)),1)];
    %%   THRESHOLD ESTIMATION
    diff=[data1f(:,4)-data1f(:,5)];
    % preparation of the final matrix
    DATA=[pdsi(3:end,1:3),pdsi(3:end,ii+3),diff];
    xd=find(DATA(:,4)<=-999);xh=find(DATA(:,5)>=100);
    DATA(xd,4)=NaN;DATA(xh,5)=NaN;
    
    %% remove the first two rows of the DATA matrix
    %DATA=DATA(3:end,:);
    %%  % %%%%%%%%%%%%%%%%%%                                      Only drought                          %%%%%%%%%%%%%%%%%%%%%%%%
    dr=find(DATA(:,4)<drth);
    final=DATA(:,1:4);final(:,5:7)=[data1f(:,4),(data1f(:,4)-t25)./int,data1f(:,5)];
    final(:,8)=DATA(:,5);
    final(:,9)=0;final(dr,9)=1;
    %%                                                           Only heat wave
    % Estimating the number of heat wave days per month averaged over the period 1982-2019
    %
    zc=find(DATA(:,5)>0); % when max temp is more than the threshold value
    days=3;
    c=[];cout=[];outlt=[];coutxt=[];outgft=[];
    for j=1:size(zc,1)-1
        if zc(j+1)-zc(j)==1 %% two consecutive days of heatwave
            cout=[cout,zc(j)];
        else
            cout=[cout,zc(j)];
            coutt=cout';
            cout=[];
            if length(coutt)>=days
                K=[DATA(coutt(1,1),1),DATA(coutt(1,1),2),DATA(coutt(1,1),3),length(coutt),mean(DATA(coutt,4)),mean(DATA(coutt,5))];
                outlt=[outlt;K];
                coutxt=[coutxt;coutt];
                outgft=[outgft;DATA(coutt(1,1):coutt(end,1),1:3)];
                coutt=[];
            else
                cout=[];coutt=[];
            end
        end
    end
    if isempty(outgft)==0
        [kk,ll]=intersect(DATA(:,1:3),outgft(:,1:3),'rows');
        final(ll,10)=1;
    else
        final(:,10)=0;
    end
    
    
    %% Heat wave conditioned on no drought (htwv|No drought) CONTROL
    
    zc=find(DATA(:,4)>0&DATA(:,5)>0);
    c=[];cout=[];outlc=[];coutx=[];outgfc=[];
    for j=1:size(zc,1)-1
        if zc(j+1)-zc(j)==1
            cout=[cout,zc(j)];
        else
            cout=[cout,zc(j)];
            coutt=cout';
            cout=[];
            if length(coutt)>=days
                K=[DATA(coutt(1,1),1),DATA(coutt(1,1),2),DATA(coutt(1,1),3),length(coutt),mean(DATA(coutt,4)),mean(DATA(coutt,5))];
                outlc=[outlc;K];
                coutx=[coutx;coutt];
                outgfc=[outgfc;DATA(coutt(1,1):coutt(end,1),1:3)];
                coutt=[];
            else
                cout=[];coutt=[];
            end
        end
    end
    
    if (isempty(outgfc)==0&isempty(outlc)==0)
        [kk,ll]=intersect(DATA(:,1:3),outgfc(:,1:3),'rows');
        final(ll,11)=1;
    else
        final(:,11)=0;
    end
    
    
    
    %%                                   Heat wave conditioned on drought (htwv|drought)Experiment
    
    zc=find(DATA(:,4)<drth&DATA(:,5)>0);
    c=[];cout=[];outl=[];coutx=[];outgf=[];
    for j=1:size(zc,1)-1
        if zc(j+1)-zc(j)==1
            cout=[cout,zc(j)];
        else
            cout=[cout,zc(j)];
            coutt=cout';
            cout=[];
            if length(coutt)>=days
                K=[DATA(coutt(1,1),1),DATA(coutt(1,1),2),DATA(coutt(1,1),3),length(coutt),nanmean(DATA(coutt,4)),nanmean(DATA(coutt,5))];
                outl=[outl;K];
                coutx=[coutx;coutt];
                outgf=[outgf;DATA(coutt(1,1):coutt(end,1),1:3)];
                coutt=[];
            else
                cout=[];coutt=[];
            end
        end
    end
    if isempty(outgf)==0&isempty(outl)==0
        [kk,ll]=intersect(DATA(:,1:3),outgf(:,1:3),'rows');
        final(ll,12)=1;
    else
        final(:,12)=0; %% heatwave|drought
    end
    %%  13=severity of each CDHWD day
    
    final(:,13)=final(:,4).*final(:,6).*final(:,12)*(-1);
    final(isnan(final(:,13)),13)=0;
    groups = regionprops(final(:,13)~=0);
    if isempty(groups)==0
        N=extractfield(groups,'Area');
        C=extractfield(groups,'Centroid');
        c=C(1,[2:2:length(C)]);
        final(:,14)=0;
        for d=1:length(N)
            if mod(N(d),2)==0 % even
                p(d)=c(d)+0.5-N(d)/2;
            else
                p(d)=c(d)-(N(d)-1)/2;
            end
        end
        final(p',14)=N';p=[];c=[];C=[];N=[];
    else %% no CDHW event
    end
    
    groups = regionprops(final(:,10)~=0);
    if isempty(groups)==0
        N=extractfield(groups,'Area');
        C=extractfield(groups,'Centroid');c=C(1,[2:2:length(C(1,:))]);
        final(:,15)=0;
        for d=1:length(N)
            if mod(N(d),2)==0 % even
                p(d)=c(d)+0.5-N(d)/2;
            else
                p(d)=c(d)-(N(d)-1)/2;
            end
        end
        final(p',15)=N';p=[];c=[];C=[];N=[];
    else
    end
    %% 
%     modelname=model_path(model+2).name;
%     underscore_ids=strfind(modelname,'_');
%     savepathdir=strcat('L:\Master_matrix\',scenario(ssp,:),'\',num2str(ii));
%     
%     delete(strcat(savepathdir,'\',modelname(underscore_ids(2)+1:underscore_ids(3)),'*'))  %% delete the existing files
%     %filedir=dir(savepathdir);
%     
%     savepath=strcat(savepathdir,...
%         '\',[modelname(underscore_ids(2)+1:underscore_ids(3)),'Master_matrix.txt']);

% %     mkdir(strcat('L:\Master_matrix\obsdata\',num2str(ii)));
    final3d{ii,1}=round(final,2);
%     writematrix(round(final,2),strcat('L:\Master_matrix\obsdata\',num2str(ii),'\master_mat_obs_data.txt'),'delimiter','\t');
    disp(ii);
    IQR=[IQR',P25'];
    writematrix(round(IQR,2),'L:\map_matrix\severity_model_wise\observation_parameters\IQR.txt','delimiter','\t')
end
save('L:\Master_matrix\obsdata\final3d_obsdata_master_matrix95.mat','final3d','-v7.3');

