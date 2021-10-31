function gridwise_weeklyT_normal4scpdsi(model,ssp,model_name)

path=strcat('L:\Data_preprocess\MainDataFile\Bias_corrected_data\Weekly\',ssp,'\T_normal\T_mean_normal');
ls=dir(path);
cd (path);
%% concatenate the obs data with the cmip6 model future data
data=load(ls(model+2).name);
for i=1:3347
    Tnormal=data(3:end,i+1)';
    a = round(convtemp(Tnormal,'K','F'),2);
    dlmwrite(strcat('L:\sc_PDSI_calc\',ssp,'\',model_name,'\',num2str(i),'\','wk_T_normal'),a,'delimiter','\t')
end
end
