clc;clear;
latlon=readmatrix('L:\Data_preprocess\latlon_AWC.txt');
%% obs data
path='L:\Data_preprocess\MainDataFile';
cd (path);
gpcc=load('GPCC_data_weekly.txt'); %% precip data
cpc=load('tmean_1979_2019_weekly.txt'); %% tmean data
cpc(3:159,:)=[]; %% considering data from 1982
%% ssp545
scenario=['ssp126';'ssp245';'ssp545'];
for kk=1:3
    ssp=scenario(kk,:);
    path=strcat('L:\sc_PDSI_calc\',ssp,'\');
    h=dir(path);
    
    %%% parameter and exe file
    
    for model=1:9
        model_name=h(model+2).name;
        path2=strcat(path,h(model+2).name,'\');
        cd (path2);
        ls=dir(path2);
        fun2make_parameterfile(path2);
        %     %% wk_P file
        gridwise_weeklyP_calculation4scPDSI(model,ssp,model_name,gpcc);
        %     %% wk_T_normal File
        gridwise_weeklyT_normal4scpdsi(model,ssp,model_name);
        %     %% wk_T file
        gridwise_weeklyT_calculation4scPDSI(model,ssp,model_name,cpc);
        disp(model);
    end
end
%% Running the exe file in each folder
clear;clc;
%% ssp545
scenario=['ssp126';'ssp245';'ssp545'];
for kk=1:3

    ssp=scenario(kk,:);
    path=strcat('L:\sc_PDSI_calc\',ssp,'\');
    h=dir(path);
    for model=2%1:9
        model_name=h(model+2).name;
        path2=strcat(path,model_name,'\');
        %hh=dir(path2);
        for i=927:3347%1:3347
            try
            path3=strcat(path2,num2str(i),'\');
            cd (path3);
%             rmdir('weekly');
            rmdir ('weekly','s');
            system(strcat(path3,'sc-pdsi.exe'));
            disp([model,i]);
            catch
            end
        end
    end

end


% % % % % % % % % % %% obs data
% % % % % % % % % % clc;clear;
% % % % % % % % % % latlon=readmatrix('L:\Data_preprocess\latlon_AWC.txt');
% % % % % % % % % % path='L:\Data_preprocess\MainDataFile';
% % % % % % % % % % cd (path);
% % % % % % % % % % gpcc=load('GPCC_data_weekly.txt');
% % % % % % % % % % cpc=load('tmean_1979_2019_weekly.txt');
% % % % % % % % % % cpc_new=cpc([1:2,160:end],:);
% % % % % % % % % % cpc_normal=load('tmean_1979_2019_weekly_tnormal.txt');
% % % % % % % % % % ssp='obsdata';
% % % % % % % % % % path=strcat('L:\sc_PDSI_calc\',ssp,'\');
% % % % % % % % % % h=dir(path);
% % % % % % % % % % %%% parameter and exe file
% % % % % % % % % % model=1;
% % % % % % % % % % path2=strcat(path,h(model+2).name,'\');
% % % % % % % % % % cd (path2);
% % % % % % % % % % % ls=dir(path2);
% % % % % % % % % % fun2make_parameterfile(path2);
% % % % % % % % % % %     %% wk_P file
% % % % % % % % % % gridwise_weeklyP_calculation4scPDSI_obsdata; %% 1982-2019
% % % % % % % % % % %     %% wk_T_normal File
% % % % % % % % % % gridwise_weeklyT_normal4scpdsi_obsdata;
% % % % % % % % % % %     %% wk_T file
% % % % % % % % % % gridwise_weeklyT_calculation4scPDSI_obsdata;
% % % % % % % % % % %% Running the .exe file
% % % % % % % % % % clear;clc;
% % % % % % % % % % scenario=['obsdata'];
% % % % % % % % % % path='L:\sc_PDSI_calc\obsdata\1982_2019\';
% % % % % % % % % % for i=1:3347
% % % % % % % % % %     path2=strcat(path,num2str(i),'\');
% % % % % % % % % %     cd (path2);
% % % % % % % % % %     system(strcat(path2,'sc-pdsi.exe'));
% % % % % % % % % %     disp(i);
% % % % % % % % % % end








