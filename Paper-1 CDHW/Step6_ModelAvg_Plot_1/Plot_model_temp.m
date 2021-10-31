clear;clc;

scenario=['ssp126';'ssp245';'ssp545'];

%% ssp 126
for ssp=1:3
    path2map_folder='L:\map_matrix\ssp\';
    newpath=strcat(path2map_folder,scenario(ssp,:));
    hh=dir(newpath);
    for model=2
        model_path=strcat(newpath,'\',hh(model+2).name);
        %         hhh=dir(model_path);
        data=load(strcat(model_path,'\','cdhwr_spatial_avg_model2.mat'));
        dr1{ssp}=data.spdr;
        cdhwr1{ssp}=data.spcdhwr;
        hwv1{ssp}=data.sphwv;
        cdhw1{ssp}=data.spcdhw;
    end

end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hwv=[hwv1{1,1}(1:end-1,1),hwv1{1,1}(1:end-1,2),hwv1{1,2}(1:end-1,2),hwv1{1,3}(1:end-1,2)];
dr=[dr1{1,1}(1:end-1,1),dr1{1,1}(1:end-1,2),dr1{1,2}(1:end-1,2),dr1{1,3}(1:end-1,2)];
cdhw=[cdhw1{1,1}(1:end-1,1),cdhw1{1,1}(1:end-1,2),cdhw1{1,2}(1:end-1,2),cdhw1{1,3}(1:end-1,2)];
cdhwr=[cdhwr1{1,1}(1:end-1,1),cdhwr1{1,1}(1:end-1,2),cdhwr1{1,2}(1:end-1,2),cdhwr1{1,3}(1:end-1,2)];
%% plot
subplot(2,2,1)
h(1)=plot(hwv(:,1),hwv(:,2),'r');
hold on;
h(2)=plot(hwv(:,1),hwv(:,3),'g');
h(3)=plot(hwv(:,1),hwv(:,4),'b');
subtitle('Heatwave');
legend('ssp126','ssp245','ssp585','location','northwest');
subplot(2,2,2)
g(1)=plot(dr(:,1),dr(:,2),'r')
hold on;
g(2)=plot(dr(:,1),dr(:,3),'g')
g(3)=plot(dr(:,1),dr(:,4),'b')
subtitle('Drought');
legend('ssp126','ssp245','ssp585','location','northwest');
subplot(2,2,3)
k(1)=plot(cdhw(:,1),cdhw(:,2),'r')
hold on;
k(2)=plot(cdhw(:,1),cdhw(:,3),'g')
k(3)=plot(cdhw(:,1),cdhw(:,4),'b')
subtitle('CDHW');
legend('ssp126','ssp245','ssp585','location','northwest');
subplot(2,2,4)
i(1)=plot(cdhwr(:,1),cdhwr(:,2),'r')
hold on;
i(2)=plot(cdhwr(:,1),cdhwr(:,3),'g')
i(3)=plot(cdhwr(:,1),cdhwr(:,4),'b')
subtitle('CDHWR');
legend('ssp126','ssp245','ssp585','location','northwest');