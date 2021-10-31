function fun2make_parameterfile(path)
latlon=readmatrix('J:\Data_preprocess\latlon_AWC.txt');
for i=1:length(latlon)
    %%% parameter file
    mkdir (num2str(i));
    p=latlon(i,[3,2]);
    destin=strcat(path,num2str(i),'\parameter');
    writematrix(p,destin,'delimiter','\t');
    %%% exe file
    copyfile ('J:\ip\sc-pdsi.exe', strcat(path,num2str(i),'\'));    
end