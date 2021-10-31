function myfun_Highlighting_the_shape_files(Seriel_num_of_location_array,name,Structural_shapefile)
loc=Seriel_num_of_location_array;
S=Structural_shapefile;
for i=1:length(loc)
    pgon=polyshape(S(loc(i)).X,S(loc(i)).Y);
    plot(pgon,'FaceColor',[1,1,1],'LineStyle','--','LineWidth',1.22);
    [x_centroid,y_centroid]=centroid(pgon); % centroid of the area
    text(x_centroid,y_centroid,name{i},'HorizontalAlignment','center','FontSize',14,'FontName','times');
end
end

