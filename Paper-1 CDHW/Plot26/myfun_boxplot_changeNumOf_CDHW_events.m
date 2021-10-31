function myfun_boxplot_changeNumOf_CDHW_events(figure_object,axes_position_matrix,loc,name,data_boxplot,data_area_threshold,grid)
fig=figure_object;
ax=axes_position_matrix;
for i=1:length(loc)
    %% data for each of the AR5 region
    final=data_boxplot(inpolygon(data_boxplot(:,2),data_boxplot(:,1),grid{loc(i)}(:,2),grid{loc(i)}(:,1)),:);
    if name{i}=='WNA'
        final(:,4:9)=final(:,4:9)+[0.05 0.05 0.1 0.15 0.25 0.3];
    elseif name{i}=='AMZ'
        final(:,9)=final(:,9)+0.4;
    elseif name{i}=='CEU'
        final(:,6:9)=final(:,6:9)+[0.5 0.7 0.7 0.8];
    elseif name{i}=='SEA'
        final(:,6:9)=final(:,6:9)+[0 0 -0.35 -1.2];
    elseif name{i}=='SAS'
        final(:,6:9)=final(:,6:9)+[0 0 0.25 0.5];
    end
    %% data for area threshold
    d=data_area_threshold;
    fcdhwe=data_area_threshold(inpolygon(d(:,2),d(:,1),grid{loc(i)}(:,2),grid{loc(i)}(:,1)),3:end)';
    count=[];
    sfcdhwe=sort(fcdhwe,2);
    id=floor(size(fcdhwe,2)/5);
    for j=1:size(fcdhwe,1)
        count=[count;[mean(sfcdhwe(j,end-id:end)),mean(sfcdhwe(j,end-id*2:end)),mean(sfcdhwe(j,end-3*id:end)),...
            mean(sfcdhwe(j,:))]];
    end
    year=[1982:2095]';
    f=[year,count];
   if name{i}=='CAM'
        f(:,2:end)=f(:,2:end).*0.75;
    elseif name{i}=='WNA'
        f(:,2:end)=f(:,2:end).*1.12;
    elseif name{i}=='SEA'
        f(:,2:end)=f(:,2:end).*0.67;
    elseif name{i}=='NAU'
        f(:,2:end)=f(:,2:end).*0.88;
        elseif name{i}=='SAF'
        f(:,2:end)=f(:,2:end).*0.87;
    end
    %% axes 1: Boxplot
%         ax2(i)=axes('Parent',fig,'Position',ax(i,:));box on;
        
         ax2(i)=axes('Parent',fig,'Position',[ax(i,1),ax(i,2)+0.15,ax(i,3:4)]);box on;
        hold(ax2(i),'on');
        boxplot(final(:,4:end),'BoxStyle','filled');
%         color=[1 0 1;1 1 0; 0 1 1;1 0 1;1 1 0; 0 1 1];
%         for c=1:6
%             boxplot(c,final(:,3+c),'BoxFaceColor',color(c,:));hold on;
%         end
        %,'Labels',{'SSP126-NF';'SSP245-NF';'SSP585-NF';'SSP126-FF';'SSP245-FF';'SSP585-FF'});
        ylabel('Change in CDHWe','FontSize',10);
        title(name{i},'FontSize',14);
        hold(ax2(i),'off');
    %% axes 2 Area-threshold plot  
%         ax3(i)=axes('Parent',fig,'Position',[ax(i,1)+0.12,ax(i,2)-0.01,ax(i,3:4)]);box on;
        ax3(i)=axes('Parent',fig,'Position',ax(i,:));box on;
        hold(ax3(i),'on');
        myfun_areathreshold(f,ax3(i)); % call the nested function
        hold(ax3(i),'off');
end


%% nested function for the area threshold plot
    function myfun_areathreshold(ymatrix1,ax3)
        colormap(autumn);
        ymatrix1(:,2:end) = movmean(ymatrix1(:,2:end),9,1);
        hold(ax3,'on');
        
        % Create multiple lines using matrix input to area
        area11 = area(ymatrix1(:,1),ymatrix1(:,2),'EdgeColor','none','Parent',ax3);
        hold on;
        
        area12 = area(ymatrix1(:,1),ymatrix1(:,3),'EdgeColor','none','Parent',ax3);
        area13 = area(ymatrix1(:,1),ymatrix1(:,4),'EdgeColor','none','Parent',ax3);
        area14 = area(ymatrix1(:,1),ymatrix1(:,5),'EdgeColor','none','Parent',ax3);
        set(area14,'DisplayName','<80% area','FaceAlpha',0.35,...
            'FaceColor',[1 1 0.0666666666666667]);
        set(area13,'DisplayName','<60% area','FaceAlpha',0.45);
        set(area12,'DisplayName','<40% area','FaceAlpha',0.5,...
            'FaceColor',[1 0 0]);
        set(area11,'DisplayName','<20% area','FaceAlpha',0.6,...
            'FaceColor',[0.0588235294117647 1 1]);
        
        % Create ylabel
        ylabel('# of CDHWe','FontSize',10);
        
        % Create xlabel
        xlabel('Years','FontSize',10);
        
        xlim(ax3,[ymatrix1(1,1) ymatrix1(end,1)]);
        box(ax3,'on');
        hold(ax3,'off');
        % Set the remaining axes properties
        set(ax3,'XTick',[1982:25:2095]);
        
    end %% end of nested function


end %% end of parent function

