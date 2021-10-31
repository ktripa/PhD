clc;clear;
path='L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\ssp126';
cd (path);
h=dir(path);
for i=1:9
    d1=load(h(12+i).name);
    d2=load(h(21+i).name);
    d3=(d1+d2)/2;
    writematrix(d3,strcat('L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\ssp126\Tmean\','tasmean',h(i+12).name(11:end-4),'_weekly.txt'),'delimiter','\t');
end
%% SSP245
clc;clear;
path='L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\ssp245';
cd (path);
h=dir(path);
for i=1:9
    d1=load(h(13+i).name);
    d2=load(h(22+i).name);
    d3=(d1+d2)/2;
    writematrix(d3,strcat('L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\ssp245\Tmean\','tasmean',h(i+13).name(11:end-4),'_weekly.txt'),'delimiter','\t');
end
%% SSP545
clc;clear;
path='L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\ssp545';
cd (path);
h=dir(path);
for i=1:9
    d1=load(h(13+i).name);
    d2=load(h(22+i).name);
    d3=(d1+d2)/2;
    writematrix(d3,strcat('L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\ssp545\Tmean\',...
    'tasmean',h(i+13).name(11:end-4),'_weekly.txt'),'delimiter','\t');
end

%% Tmean_normal For the T_normal series
clear;clc;
path='L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\';
cd (path);
ls=dir(path);
for i=3:5
    path2=strcat(path,ls(i).name,'\T_normal\');
    ls2=dir(path2);
    cd (path2);
    for j=1:9
        d1=load(ls2(j+3).name);
        d2=load(ls2(j+12).name);
        d3=(d1+d2)/2;
        writematrix(d3,strcat('L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\',ls(i).name,'\T_normal\T_mean_normal\',...
        'tasmean',ls2(j+3).name(11:end-4),'_TMeanNormal.txt'),'delimiter','\t');
    end
end

%%
