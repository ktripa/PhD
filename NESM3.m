clear;clc;close;
latlon =load('L:\PhD\Fire Weather Index\dataset\latlon_data.txt');
ng =length(latlon);
path='L:\PhD\Fire Weather Index\dataset\NESM3\';
tmax=readmatrix([path,'tasmax_day_NESM3_ssp585_r1i1p1f1_gn_20150101_21001231_rg_BC.txt']);
tmax =tmax(3:end,:);
tmax(:,4:end)= convtemp(tmax(:,4:end),'K','C');
% tmin = readmatrix([path,'tasmin_day_NESM3_ssp585_r1i1p1f1_gn_20150101_21001231_rg_BC.txt']);
% tmean = 0.5*( tmax(3:end,:)+tmin(3:end,:) );
% tmean(:,4:end) = convtemp(tmean(:,4:end),'K','C');
% writematrix(round(tmean,2), [path, 'tasmean_day_NESM3_ssp585_r1i1p1f1_gn_20150101_21001231_rg_BC.txt'],...
%     'delimiter','\t');
% tmean = readmatrix([path, 'tasmean_day_NESM3_ssp585_r1i1p1f1_gn_20150101_21001231_rg_BC.txt']);
pr = readmatrix([path, 'pr_day_NESM3_ssp585_r1i1p1f1_gn_20150101_21001231_rg_BC.txt']);
pr =pr(3:end,:);
wd = readmatrix([path, 'resultant_ws_day_NESM3_ssp585_r1i1p1f1_gn_20150101-21001231_rg.txt']);
rh = readmatrix([path, 'hur_day_NESM3_ssp585_r1i1p1f1_gn_20150101-21001231_pressure_1000hpa_rg.txt']);
%% 
ffmc0=[85];dmc0=[6];dc0=[15];
tic
for ig =1:ng
    disp(ig);
    for tim =1:length(rh)
        
        temp = tmax(tim,ig+3);rhum = rh(tim,ig+3); wind = wd(tim,ig+3); prcp = pr(tim,ig+3);
        month = tmax(tim,2);
        [ffmc(tim,ig),dmc(tim,ig),dc(tim,ig),isi(tim,ig),bui(tim,ig),fwi(tim,ig)] = FWICLASS(temp,rhum,wind,prcp,ffmc0,dmc0,dc0,month);
        ffmc0 = ffmc(tim,ig);dmc0=dmc(tim,ig); dc0=dmc(tim,ig);
    end
    ffmc0=[85];dmc0=[6];dc0=[15];
end
toc
date = tmax(:,1:3);
savepath ='L:\PhD\Fire Weather Index\';
writematrix(round([date,ffmc],2),[savepath,'FFMC_NESM3.txt'],'delimiter','\t');
writematrix([date,round(dmc,2)],[savepath,'DMC_NESM3.txt'],'delimiter','\t');
writematrix([date,round(dc,2)],[savepath,'DC_NESM3.txt'],'delimiter','\t');
writematrix([date,round(isi,2)],[savepath,'ISI_NESM3.txt'],'delimiter','\t');
writematrix([date,round(bui,2)],[savepath,'BUI_NESM3.txt'],'delimiter','\t');
writematrix([date,round(fwi,2)],[savepath,'FWI_NESM3.txt'],'delimiter','\t');

















    

