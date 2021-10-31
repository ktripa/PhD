clear;clc;
latlon=load('L:\Data_preprocess\MainDataFile\latlon_data.txt');
%% create the modelwise CDHW days
path1='D:\mastermatrix\90\';
hh=dir(path1);
% cdhwd=cell(27,1);cdhwevent=cell(27,1);dr=cell(27,1);hwv=cell(27,1);cdhwr=cell(27,1);
for model=[15,14,24,23,5,6]-2
    modelname=hh(model+2).name
    data=load([path1,modelname]);
    output=data.output;
    model_values=cell(6,1);
    for i=1:3347
        data=output{i,1};
        disp([model,i]);
        try
            n=1;
            for yr=2020:2099
                if latlon(i,2)>=0
                    z=find(data(:,1)==yr&data(:,2)>=5&data(:,2)<=10); % Northern Hemisphere
                    cdhwd1(n,i)=nansum(data(z,14));
                    dr1(n,i)=nansum(data(z,9));
                    hwv1(n,i)=nansum(data(z,10));
                    cdhwevent1(n,i)=nansum(data(z,14)>0);
                    cdhwr1(n,i)=cdhwd1(n,i)/hwv1(n,i);
                    sev1(n,i)=nansum(data(z,13))/cdhwevent1(n,i);%/cdhwd1(n,i);
                else
                    z=find(data(:,1)==yr&data(:,2)>=11|data(:,1)==yr&data(:,2)<=4); % Southern Hemisphere
                    cdhwd1(n,i)=nansum(data(z,14));
                    dr1(n,i)=nansum(data(z,9));
                    hwv1(n,i)=nansum(data(z,10));
                    cdhwevent1(n,i)=nansum(data(z,14)>0);
                    cdhwr1(n,i)=cdhwd1(n,i)/hwv1(n,i);
                    sev1(n,i)=nansum(data(z,13))/cdhwevent1(n,i);%/cdhwd1(n,i);
                end
                n=n+1;
            end
        catch
        end
        %%
        
    end %% end of grids
    model_values{1,1}=cdhwd1; % cdhw day
    model_values{2,1}=cdhwevent1;
    model_values{3,1}=cdhwr1;
    model_values{4,1}=dr1;
    model_values{5,1}=hwv1;
     model_values{6,1}=sev1;
    savename=['L:\map_matrix\severity_model_wise\parameters\90new\','CDHW_all_parameter_model_',modelname(end-6:end-4),'.mat'];
    save(savename,'model_values');
    clear data model_values output;
end