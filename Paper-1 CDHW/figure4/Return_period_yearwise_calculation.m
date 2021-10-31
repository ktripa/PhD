clear;clc;close;
%%% this file creates the return period of each grid for every year
%%% threshold also applies
th=load('L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\JointMaxThreshold_Observation95');
thyr=[2016,2028,2038,2049,2057,2066,2073]';
yr_array=thyr+10;
% myfun_to_create_RP_for_31_year_window(yr_array);
%% MME
path='L:\codes_paper1\figure4\data_figure4\ReturnPeriod\';
hh=dir(path);
for model=1:9
    modelname=hh(model+2).name
    dat=importdata([path,modelname]);
    dat(2:end,3:end)= fillmissing(dat(2:end,3:end),'movmean',5);
    ff{model}=dat;
end
final=ff{1};
for i=1:7  
    temp=[];
    for model=1:9
        temp=[temp,ff{model}(2:end,i+2)];
    end
    final(2:end,i+2)=nanmean(temp,2);%MME
end
writematrix(final,'L:\codes_paper1\figure4\data_figure4\GridWise_ReturnPeriod.txt','delimiter','\t');

    
    
    
 