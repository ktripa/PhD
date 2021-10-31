clear;clc;
%% get the 12th column of each master matrix for the obs period 1982-2019
scenario=['ssp126';'ssp245';'ssp545'];
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
path='L:\Master_matrix\ssp126\';
cdhw=[];sv=[];
for i=1:length(latlon)
    sev=[];
    data=load(strcat(path,num2str(i),'\ACCESS-CM2_Master_matrix.txt'));
    cdhw=[cdhw,data(1:13879,12)];
    sev=data(cdhw(:,i)==1,13);
    %% avg severity of CDHW events for the obs period (1982-2019)
    sv=[sv,mean(sev)];
    disp(i);
end
writematrix(cdhw,'L:\codes_paper1\RP.txt','delimiter','\t');
%% near-future (2020-2057)

%% far-future (2058-2095)





%% load cdhw matrix
clear;clc;
data=load('L:\codes_paper1\RP.txt');
%% obs period
% rowwise sum of matrix RP
jprob=sum(data,1)/length(data);
rp=(1./jprob)%*(1/365);
rp(isinf(rp)==1)=NaN;