function [vq2,xq]=myfun_ReturnPeriod_vs_Area(grid26)
data=load('L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\RP_matrix\RPmat90.txt');
obs_data=load('L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\RP_matrix\90\RP_matrix_obs.txt');
data(:,9)=obs_data(:,3);
grid=grid26;
final=data(inpolygon(data(:,2),data(:,1),grid(:,2),grid(:,1)),:);
data=final;



output=cell(7,1);
MaxRP=13;
for model=1:7
    d=data(:,model+2);
    intr=linspace(0,MaxRP,29);
    len=length(intr);
    n=1;
    for i=1:len
        z=find(d>=intr(i));
        out(n,1)=intr(i);
        out(n,2)=(size(z,1)/size(data,1))*100;
        n=n+1;
    end
    output{model,1}=out;
end

%% spline interpolation
% inc=linspace(1.5,0.5,100)';

xq=linspace(0.5,MaxRP,100);
for i=1:7
    vq2(:,i)=interp1(output{i,1}(2:end,1),output{i,1}(2:end,2),xq,'spline');
% %     vq2(:,i)=vq2(:,i).*inc;
end
vq2=max(vq2,0);
