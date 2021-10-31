clear;clc;close all;
data=load('L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\RP_matrix\RPmat90.txt');
obs_data=load('L:\mastermatrix_matfiles_ssp_output_folder_10thmay2021\RP_files\RP_matrix\90\RP_matrix_obs.txt');
data(:,9)=obs_data(:,3);



lat=[9.7,-34,-35.4,32.17,36.26,38.1,33.04,12.5,12.5];
lon=[53.5,53.5,-15.2,-26.1,-4.4,9.6,29.02,43.5,54.3];

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

h(2)=plot(xq,vq2(:,2),'g:.','Linewidth',1);%ssp245 nf
h(3)=plot(xq,vq2(:,3),'r:.','Linewidth',1);%ssp585 nf

h(4)=plot(xq,vq2(:,4),'b-','Linewidth',2);%ssp126 ff
 hold on;
h(5)=plot(xq,vq2(:,5),'g-','Linewidth',2);%ssp245 ff
h(6)=plot(xq,vq2(:,6),'r-','Linewidth',2);%ssp585 ff
h(7)=plot(xq,vq2(:,7),'k:.','Linewidth',1);
legend('SSP126-FF','SSP245-FF','SSP585-FF','Observed');
xlabel('Return period (Years)','fontSize',15);
ylabel('% of Area','fontSize',15);
title('Africa','fontSize',20);
savefig(fig,'L:\codes_paper1\plot4\plot4\Africa.fig')


