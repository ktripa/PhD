clear;clc;
latlim = [-90 90];
lonlim = [-180 180];
rasterSize = [90 180];
R = georefcells(latlim,lonlim,rasterSize,'ColumnsStartFrom','north');

lat=-90:2:88;
lon=-178:2:180;
ff=myfun_xarray(final); 

%% map
fig=figure(1);
subplot(4,2,1:2)
d1=ff(:,:,1);
landareas = shaperead('landareas.shp','UseGeoCoords',true);
axesm ('robinson', 'Frame', 'on', 'Grid', 'off');
geoshow(landareas(2:end),'FaceColor','none','EdgeColor',[.6 .6 .6]);
geoshow(fliplr(d1')',R,'DisplayType','surface');

for i=1:6
    subplot(4,2,i+2)
    d1=ff(:,:,i+1);
    landareas = shaperead('landareas.shp','UseGeoCoords',true);
    axesm ('robinson', 'Frame', 'on', 'Grid', 'off');
    geoshow(landareas(2:end),'FaceColor','none','EdgeColor',[.6 .6 .6]);
    geoshow(fliplr(d1')',R,'DisplayType','surface');
end