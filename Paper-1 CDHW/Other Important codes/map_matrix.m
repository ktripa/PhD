clear;clc;
path='L:\sc_pdsi_daily_1982_2100\ssp545\';
data=load(strcat(path,'ACCESS_CM2_daily_pdsi_1982_2100.txt'));
dat=data(3:end,4:end);


dat(dat>10)=10;
dat(dat<-12)=-12;
map_mat=data(1:2,4:end)';
max(max(data(3:end,4:end)))
%% JJA Data for 2012
xx=(data(:,1)==2012 & data(:,2)>=6 & data(:,2)<=8);
map_mat(:,3)=mean(dat(xx,:),'omitnan');
writematrix(map_mat,'L:\map_matrix\2012_JJA_map_matrix.txt','delimiter','\t')


