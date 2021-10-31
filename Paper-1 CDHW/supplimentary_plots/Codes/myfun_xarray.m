function ff=myfun_xarray(data)

ff=nan(90,180,size(data,2)-2);
for col=1:size(data,2)-2
    final=data(:,[1:2,col+2]);
    lat=-90:2:88;
    lon=-178:2:180;

    
    for i=1:length(lon)
        for j=1:length(lat)
            z=find(final(:,1)==lon(i)&final(:,2)==lat(j));
            id=final(z,1:2);
            if isempty(z)==0
                ff(j,i,col)=final(z,3);
            end
        end
    end
end

end









