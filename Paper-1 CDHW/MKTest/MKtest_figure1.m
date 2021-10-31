clear;clc;close all;
data=importdata('L:\codes_paper1\MKTest\Figure1_data_MKtest.mat');
%% MKT
for model=1:3
    for i=1:7
        [H(model,i),p(model,i)]=Mann_Kendall(data{model,1}(:,i),0.01);
    end
end
%% Theil-sen slope
year=[1:38]';
for model=1:3
    for i=1:7
        a(model,i)=Theil_Sen_Regress(year,data{model,1}(:,i));
    end
end