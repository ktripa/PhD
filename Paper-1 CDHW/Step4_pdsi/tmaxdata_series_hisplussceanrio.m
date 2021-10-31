clear;clc;
scenario=['ssp126';'ssp245';'ssp545'];
ssppath='L:\Data_preprocess\MainDataFile\';
hh=dir(ssppath);
%% load the historical data
hist_folder=strcat(ssppath,'Historical\');
hist_dir=dir(hist_folder);
for model=1:9
    filename=strcat(ssppath,'Historical\',hist_dir(model+11).name);
    hist_data=load(filename);
    hist_data(hist_data(:,1)<=1981,:)=[];
    for ssp=1:3
        sspname=scenario(ssp,:);
        %% load the ssp data for tmax
        fname=strcat(ssppath,sspname);
        sspdir=dir(fname);
        modelname=sspdir(model+11).name;
        sspdata=load(strcat(fname,'\',modelname));
        newdata=[hist_data;sspdata(3:end,:)];
        
        
        %%
        
        uscoreid=strfind(modelname,'_');
        writematrix(newdata,strcat('L:\Tmax_data_new_1982_2100\',sspname,...
            '\',modelname(uscoreid(2)+1:uscoreid(3)-1),'_tmax_19822100_hisnssp'),'delimiter','\t');
        disp([ssp,model])
    end
end
