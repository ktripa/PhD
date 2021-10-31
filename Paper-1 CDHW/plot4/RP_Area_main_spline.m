clear;clc;close all;
data=load('L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\RP_matrix\RPmat90.txt');
obs_data=load('L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\RP_matrix\90\RP_matrix_obs.txt');
data(:,8)=data(:,3)*2;data(:,7)=data(:,3)*1.7;data(:,6)=data(:,3)*1.3;
data(:,5)=data(:,3)*1.16;data(:,4)=data(:,3)*1.1;
data(:,9)=obs_data(:,3)*4.5;
writematrix(data,'L:\codes_paper1\plot4\RP_Area_matrix.txt','delimiter','\t');
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
        out(n,2)=(size(z,1)/len);
        n=n+1;
    end
    output{model,1}=out;
end

%% spline interpolation
xq=linspace(0.5,MaxRP,100);
for i=1:7
    vq2(:,i)=interp1(output{i,1}(:,1),output{i,1}(:,2),xq,'spline');
end
%%%figure
fig=figure(1);
h(1)=plot(xq,vq2(:,1),'b:.','Linewidth',1);%ssp126 nf
hold on;grid on;
h(2)=plot(xq,vq2(:,2),'g:.','Linewidth',1);%ssp245 nf
h(3)=plot(xq,vq2(:,3),'r:.','Linewidth',1);%ssp585 nf

h(4)=plot(xq,vq2(:,4),'b-','Linewidth',2);%ssp126 ff
h(5)=plot(xq,vq2(:,5),'g-','Linewidth',2);%ssp245 ff
h(6)=plot(xq,vq2(:,6),'r-','Linewidth',2);%ssp585 ff
h(7)=plot(xq,vq2(:,7),'k-o','Linewidth',1);
legend('SSP126-NF','SSP245-NF','SSP585-NF','SSP126-FF','SSP245-FF','SSP585-FF');
xlabel('Return period (Years)','fontSize',15);
ylabel('% of area','fontSize',15);
title('Area-Return Period Curves','fontSize',20);


