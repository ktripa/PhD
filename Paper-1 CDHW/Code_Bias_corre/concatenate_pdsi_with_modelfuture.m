clear;clc;
path_obs='L:\sc_PDSI_calc\obsdata\1982_2019\';

scenario=['ssp126';'ssp245';'ssp545'];
scpdsi_folder='L:\sc_PDSI_calc\';
for kk=1:3
    path=strcat(scpdsi_folder,scenario(kk,:));
    hh=dir(path);
    for model=1:9
        %% Model for future
        model_path=strcat(path,'\',hh(model+2).name);
        for i=1:3347
            cd(strcat(model_path,'\',num2str(i),'\Weekly\1'));
            pdsi_model=load('PDSI.tbl');
            pdsi_model(1:5,:)=[];
            nan_index=find(pdsi_model==-99);
            pdsi_model(nan_index)=NaN;
            %% obs data
            cd(strcat(path_obs,num2str(i),'\Weekly\1'));
            pdsi_obs=load('PDSI.tbl');
            nan_index=find(pdsi_obs==-99);
            pdsi_obs(nan_index)=NaN;
        end
    end
end
