function [final_globe_ssp]=fun2get_reqd4severity(cdhw_model,modelidx)
[m,n]=size(cdhw_model);


%% mean, 0.25p and 0.75p
qtile=cell(m,n);
for i=1:m
    for j=modelidx % these models are considered
        for k=1:80
            idx=find(cdhw_model{i,j}(k,:)>0);
            val=cdhw_model{i,j}(k,idx);
            qtile{i,j}(k,1)=nanmean(val,2);
            qtile{i,j}(k,2)=quantile(val,0.15);
            qtile{i,j}(k,3)=quantile(val,0.85);
        end
    end
end

%% take mean of all the dataset
global_mean=cell(3,3);
for ssp=1:3
    for i=1:3
        for j=modelidx
            global_mean{ssp,i}=[global_mean{ssp,i},qtile{ssp,j}(1:end-1,i)];
        end
    end
end
%% model avg
model_avg=cell(3,1);

model_avg{1,1}=[model_avg{1,1},mean(global_mean{1,1},2),mean(global_mean{1,2},2),mean(global_mean{1,3},2)];
model_avg{2,1}=[model_avg{2,1},mean(global_mean{2,1},2),mean(global_mean{2,2},2),mean(global_mean{2,3},2)];
model_avg{3,1}=[model_avg{3,1},mean(global_mean{3,1},2),mean(global_mean{3,2},2),mean(global_mean{3,3},2)];

% %%hist part of CDHW
% his_model_avg=zeros(38,3);
% 
% his_model_avg(:,1)=(model_avg{1,1}(1:38,1)+model_avg{2,1}(1:38,1)+model_avg{3,1}(1:38,1))/3;
% his_model_avg(:,2)=(model_avg{1,1}(1:38,1)+model_avg{2,1}(1:38,1)+model_avg{3,1}(1:38,1))/3;
% his_model_avg(:,3)=(model_avg{1,1}(1:38,1)+model_avg{2,1}(1:38,1)+model_avg{3,1}(1:38,1))/3;

%% inc var
inc=linspace(0.2,0.9,79)';
%% diff cell
dif=cell(3,1);
for ssp=1:3
    for j=1:2
        dif{ssp,1}(:,j)=(model_avg{ssp,1}(:,j+1)-model_avg{ssp,1}(:,1)).*inc;
    end
end
final_globe_ssp=cell(3,1);
for ssp=1:3
    base=model_avg{ssp,1}(:,1);
    final_globe_ssp{ssp,1}=[base,base+dif{ssp,1}(:,1),base+dif{ssp,1}(:,2)];
end

for ssp=1:3
    for i=1:3
        final_globe_ssp{ssp,1}(final_globe_ssp{ssp,1}(:,i)<0,i)=0;
    end
end