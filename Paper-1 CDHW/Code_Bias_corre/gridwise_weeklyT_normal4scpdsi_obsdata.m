function gridwise_weeklyT_normal4scpdsi_obsdata
data1=load('J:\Data_preprocess\MainDataFile\tmean_1979_2019_weekly_tnormal.txt');
for i=1:3347
    Tnormal=data1(3:end,i+1)';
    a = round(convtemp(Tnormal,'K','F'),2);
    dlmwrite(strcat('J:\sc_PDSI_calc\obsdata\1982_2019\',num2str(i),'\','wk_T_normal'),a,'delimiter','\t')
end
end