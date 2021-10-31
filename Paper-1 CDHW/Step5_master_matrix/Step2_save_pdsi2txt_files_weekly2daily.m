clear;clc;
scenario=['ssp126';'ssp245';'ssp545'];
scpdsi_folder='L:\sc_PDSI_calc\';
tic
for kk=1:3
    path=strcat(scpdsi_folder,scenario(kk,:));
    hh=dir(path);
    ssp=scenario(kk,:);
    tic
    for jj=1:9
        disp([kk,jj]);
        modelname=hh(jj+2).name;
        weekly2daily(ssp,modelname) %5 call the function
    end
    toc
end
toc
        