clear;clc;
%% load the Tmax data
path='L:\Data_preprocess\MainDataFile\';
cd (path);
tmax_cpc=load(strcat(path,'tmax_1979_2019_rg.txt'));
tmax_cpc(tmax_cpc(:,1)<=1981,:)=[]; % remove the years from 1979-1981
scenario=['ssp126';'ssp245';'ssp545'];

for kk=3
    path2=strcat(path,scenario(kk,:));
    hh=dir(path2);
    for model=1:9
        disp([kk,model]);
        tic
        %% load the model tmax data 2015-2100
        data=load(strcat(path2,'\',hh(model+11).name));
        data(data(:,1)<=2019,:)=[];
        %% merge the
        new_data=[tmax_cpc;data(3:end,:)];
        conv_new_data=new_data;
        conv_new_data(3:end,4:end)=round(convtemp(new_data(3:end,4:end),'K','F'),2);
        writematrix(conv_new_data,strcat(path,'Tmax_1982_2100\',scenario(kk,:),'\',hh(model+11).name(1:28)),'delimiter','\t');
        toc
    end
end
    