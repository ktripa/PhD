function myfun_to_create_RP_for_31_year_window(yr_array)
th=load('L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\JointMaxThreshold_Observation95');
%%%% model wise data calculation
path='L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\95new\';
hh=dir(path);
for model=1:length(hh)-20
    tic
    final=[NaN,NaN,yr_array'];
    filename=hh(model+20).name
    data=load([path,filename]);
   
    for i=1:length(th(:,1))
        datf=data.output{i,1};
        if length(datf(1,:))==15
            disp([model,i]);
            final(i+1,1:2)=th(i,1:2);
            for yr=1:length(yr_array)
                
                if th(i,2)>=0
                    z=find(datf(:,1)>=yr_array(yr)-15&datf(:,1)<=yr_array(yr)+15 &datf(:,2)>=5&datf(:,2)<=10);
                else
                    z=find(yr_array(yr)-15&datf(:,1)<=yr_array(yr)+15&datf(:,2)>=11|...
                        yr_array(yr)-15&datf(:,1)<=yr_array(yr)+15&datf(:,2)<=4);
                end
                final(i+1,yr+2)=1/((size(find(datf(z,13)>=th(i,3)&datf(z,14)>=th(i,4)),1)/size(z,1))*365); 
            end
        end
    end
    final(isinf(final))=NaN;

writematrix(final,['L:\codes_paper1\figure4\data_figure4\ReturnPeriod\RPfile_',filename(end-6:end-4),'.txt'],'delimiter','\t');
clear data final;
toc
end
