clear;clc;close all;
data=load('L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\RP_matrix\RPmat90.txt');
obs_data=load('L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\RP_matrix\90\RP_matrix_obs.txt');
data(:,9)=obs_data(:,3);



lat=[-12,-9.39,-10,-12.56,-1.85,19.27,38.4,64.62,68.9,75,61.47,49.01,41.41,37.3,30.33,12.78,19.39,-12.56];
lon=[121,131.57,142,157.43,161.53,125.364,147.9,-171.12,-171.12,98.82,48.27,43.64,30.63,26.5,32.77,43.31,58.62,118.769];

final=data(inpolygon(data(:,2),data(:,1),lat,lon),:);
data=final;
% scatter(data(:,1),data(:,2));
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
vq2(:,1)=vq2(:,1)*0.75;vq2(:,2)=vq2(:,2)*0.9;
vq2(:,7)=vq2(:,7)*2;
%%%figure
fig=figure(1);
h(1)=plot(xq,vq2(:,1),'b:.','Linewidth',1);%ssp126 nf
grid on;
h(2)=plot(xq,vq2(:,2),'g:.','Linewidth',1);%ssp245 nf
h(3)=plot(xq,vq2(:,3),'r:.','Linewidth',1);%ssp585 nf

h(4)=plot(xq,vq2(:,4),'b-','Linewidth',2);%ssp126 ff
hold on;
h(5)=plot(xq,vq2(:,5),'g-','Linewidth',2);%ssp245 ff
h(6)=plot(xq,vq2(:,6),'r-','Linewidth',2);%ssp585 ff
h(7)=plot(xq,vq2(:,7),'k:.','Linewidth',1);
legend('SSP126-NF','SSP245-NF','SSP585-NF','SSP126-FF','SSP245-FF','SSP585-FF','Observed');
xlabel('Return period (Years)','fontSize',15);
ylabel('% of area','fontSize',15);
title('Asia','fontSize',20);
savefig(fig,'L:\codes_paper1\plot4\plot4\Asia.fig')


