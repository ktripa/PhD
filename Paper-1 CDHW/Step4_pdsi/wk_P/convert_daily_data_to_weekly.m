clear;clc;
path='L:\Data_preprocess\MainDataFile\';
cd (path);
gpcc=readmatrix('full_data_daily_v2020_10_1982_2019_rg.txt');
[week]=func_to_calc_daily2weekly_pr(gpcc);
writematrix(week,strcat('L:\Data_preprocess\MainDataFile\','GPCC_data_weekly.txt'),'delimiter','\t');
%% load a textfile for the ssp545
latlon=readmatrix('L:\Data_preprocess\MainDataFile\latlon_GPCCdata.txt')';
path='L:\Data_preprocess\MainDataFile\Bias_corrected_data\ssp545';
h=dir(path);
cd (path);
for i=[14,20,23,29]-2
    data=readmatrix(h(i+2).name);
    disp(i)
    [week,final]=func_to_calc_daily2weekly(data,latlon);
    writematrix(week,strcat('L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\ssp545\',h(i+2).name(1:end-4),'_weekly.txt'),'delimiter','\t');
    writematrix(final,strcat('L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\ssp545\T_normal\',h(i+2).name(1:end-4),'_weekly_tnormal.txt'),'delimiter','\t');
end


%% load a textfile for the ssp245
path='L:\Data_preprocess\MainDataFile\Bias_corrected_data\ssp245';
h=dir(path);
cd (path);
for i=[14,20,23,29]-2
    data=readmatrix(h(i+2).name);
    [week,final]=func_to_calc_daily2weekly(data,latlon);
    writematrix(week,strcat('L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\ssp245\',h(i+2).name(1:end-4),'_weekly.txt'),'delimiter','\t');
    writematrix(final,strcat('L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\ssp245\T_normal\',h(i+2).name(1:end-4),'_weekly_tnormal.txt'),'delimiter','\t');
end

%% load a textfile for the ssp126
path='L:\Data_preprocess\MainDataFile\Bias_corrected_data\ssp126';
h=dir(path);
cd (path);
for i=[14,20,23,29]-2
    data=readmatrix(h(i+2).name);
    [week,final]=func_to_calc_daily2weekly(data,latlon);
    writematrix(week,strcat('L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\ssp126\',h(i+2).name(1:end-4),'_weekly.txt'),'delimiter','\t');
    writematrix(final,strcat('L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\ssp126\T_normal\',h(i+2).name(1:end-4),'_weekly_tnormal.txt'),'delimiter','\t');
end

