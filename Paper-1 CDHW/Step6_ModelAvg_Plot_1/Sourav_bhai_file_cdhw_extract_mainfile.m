clc;
clear;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
for i=1:length(latlon(:,1))
    data=importdata(['E:\Sourav\with_kumar\files\Model_name\',num2str(i),'\ACCESS-CM2_ss_Master_matrix.txt']);
       
    n=1;
    for yr=1982:2100
        if latlon(i,2)>=0
            z=find(data(:,1)==yr&data(:,2)>=5&data(:,2)<=10); % Northern Hemisphere
            hwv(n,i)=nansum(data(z,10));
            cdhw(n,i)=nansum(data(z,12));
            cdhwr(n,i)=nansum(data(z,12))/nansum(data(z,10));
        else
            z=find(data(:,1)==yr&data(:,2)>=11|data(:,1)==yr&data(:,2)<=4); % Southern Hemisphere
            hwv(n,i)=nansum(data(z,10));
            cdhw(n,i)=nansum(data(z,12));
            cdhwr(n,i)=nansum(data(z,12))/nansum(data(z,10));
        end
        n=n+1;
       
    end
end
%% Note [insert command following the objective written below
% insert save hwv, cdhw, and cdhwr in mat format (separately) for this model (inside the model folder).

%% spatial average and plot for a single model
sphwv=[[1982:2100]',nanmean(hwv,2)];
spcdhw=[[1982:2100]',nanmean(hwv,2)];
spcdhwr=[[1982:2100]',nanmean(hwv,2)];
%% Note [insert command following the objective written below
% Now save these three files in the same folder of the model in mat format

%% just to look at the plot for a single model
subplot(3,1,1)
plot(sphwv(:,1),sphwv(:,2));
subplot(3,1,2)
plot(spcdhw(:,1),spcdhw(:,2));
subplot(3,1,3)
plot(spcdhwr(:,1),spcdhwr(:,2));