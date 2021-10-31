clc;clear;

latlon=importdata(['D:/Observed_Conc_htwv_drought/latlon_awc_1deg']);
txd=importdata(['F:\Sourav\CDHW_GRL_Review_comments\New folder\Tmax_1981_2016']);
txd(txd(:,1)==1981,:)=[];
nii=1;ni=1;
% initializing the matrix
for ii=1:length(latlon(:,1))
    disp(ii)
    data=[txd(:,1:3),txd(:,ii+3)];
    file=['data_',num2str(latlon(ii,1)),'_',num2str(latlon(ii,2))];
    filename=fullfile('H:\Sourav\JGR_paper\Gridded_1deg_PDSI_sc\1week\',file);
    if exist(filename,'file') == 2
        
        % climatological period
        ystart=1982; yend=2011;
        % period of analysis
        y1=1982; y2=2016;
        %% Drought
        pdsi=importdata(['H:\Sourav\JGR_paper\Gridded_1deg_PDSI_sc\1week\data_',num2str(latlon(ii,1)),'_',num2str(latlon(ii,2))]);
        % pdsi data management
        pdsi(pdsi(:,4)==-99,4)=NaN;
        %         z1=find(pdsi(:,3)==30);
        %         z2=find(pdsi(:,3)==31);
        %         pdsi(z1,4)=pdsi(z1-1,4);
        %         pdsi(z2,4)=pdsi(z2-2,4);
        % Drought threshold = 10th percentile
        zp=find(pdsi(:,1)>=ystart&pdsi(:,1)<=yend);
        drth=quantile(pdsi(zp,4),0.10);
        
        %% Heatwave
        if latlon(ii,2)>=0
            th=quantile(data(data(:,1)>=1982&data(:,1)<=2016&data(:,2)>=5&data(:,2)<=10,4),0.9);
            t25=quantile(data(data(:,1)>=1982&data(:,1)<=2016&data(:,2)>=5&data(:,2)<=10,4),0.25);
            int=quantile(data(data(:,1)>=1982&data(:,1)<=2016&data(:,2)>=5&data(:,2)<=10,4),0.75)-quantile(data(data(:,1)>=1982&data(:,1)<=2016&data(:,2)>=5&data(:,2)<=10,4),0.25);
        else
            th=quantile(data(data(:,1)>=1982&data(:,1)<=2016&data(:,2)>=11|data(:,1)>=1982&data(:,1)<=2016&data(:,2)<=4,4),0.9);
            t25=quantile(data(data(:,1)>=1982&data(:,1)<=2016&data(:,2)>=11|data(:,1)>=1982&data(:,1)<=2016&data(:,2)<=4,4),0.25);
            int=quantile(data(data(:,1)>=1982&data(:,1)<=2016&data(:,2)>=11|data(:,1)>=1982&data(:,1)<=2016&data(:,2)<=4,4),0.75)-quantile(data(data(:,1)>=1982&data(:,1)<=2016&data(:,2)>=11|data(:,1)>=1982&data(:,1)<=2016&data(:,2)<=4,4),0.25);
        end
        data1f=[data,repmat(th,length(data(:,1)),1)];
        
        %%   THRESHOLD ESTIMATION
        
        % preparation of the final matrix
        DATA=[pdsi(:,1:4),[data1f(:,4)-data1f(:,5)]];
        xd=find(DATA(:,4)<=-999);xh=find(DATA(:,5)>=100);
        DATA(xd,4)=NaN;DATA(xh,5)=NaN;
        
        %%                                                              Only drought
        dr=find(DATA(:,4)<drth);
        final=DATA(:,1:4);final(:,5:7)=[data1f(:,4),(data1f(:,4)-t25)./int,data1f(:,5)];
        final(:,8)=DATA(:,5);
        final(:,9)=0;final(dr,9)=1;
        
        %%                                                           Only heat wave
        % Estimating the number of heat wave days per month averaged over the period 1982-2016
        %
        zc=find(DATA(:,5)>0);
        days=3;
        c=[];cout=[];outlt=[];coutxt=[];outgft=[];
        for j=1:size(zc,1)-1
            if zc(j+1)-zc(j)==1
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
        %%                                   Heat wave conditioned on no drought (htwv|No drought) CONTROL
        
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
        
        if isempty(outgfc)==0&isempty(outlc)==0
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
                    K=[DATA(coutt(1,1),1),DATA(coutt(1,1),2),DATA(coutt(1,1),3),length(coutt),mean(DATA(coutt,4)),mean(DATA(coutt,5))];
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
            final(:,12)=0;
        end
        final(:,13)=final(:,4).*final(:,6).*final(:,12)*-1;
        final(isnan(final(:,13)),13)=0;
        groups = regionprops(final(:,13)~=0);
        if isempty(groups)==0
            N=extractfield(groups,'Area');
            C=extractfield(groups,'Centroid');c=C(1,[2:2:length(C(1,:))]);
            final(:,14)=0;
            for d=1:length(N)
                if mod(N(d),2)==0 % even
                    p(d)=c(d)+0.5-N(d)/2;
                else
                    p(d)=c(d)-(N(d)-1)/2;
                end
            end
            final(p',14)=N';p=[];c=[];C=[];N=[];
        else
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
        %% 1=year,2=month,3=day,4=pdsi,5=temp,6=zscore_temp,7=thr,8=anomaly_wrt_threshold,9=drought event,10=heatwave event,11=htwv|no drought, 12=heatwave|drought 13=severity of each CDHWD day | 14= CDHW event days | 15= total HW event days
        dlmwrite(['D:\CDHW_data_analysis\Results\gridded_master_matrix\ERA5_only\data_',num2str(latlon(ii,1)),'_',num2str(latlon(ii,2))],final,'delimiter','\t')
    else
        % File does not exist.
    end
    
end