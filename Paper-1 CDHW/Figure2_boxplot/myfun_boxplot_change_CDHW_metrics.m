function myfun_boxplot_change_CDHW_metrics(fig,ax_pos,loc,name,data_cdhwe,data_cdhwd,data_cdhws,grid)

ax=ax_pos;
for i=1:length(loc)
    %% data for each of the AR5 region
    finale=data_cdhwe(inpolygon(data_cdhwe(:,2),data_cdhwe(:,1),grid{loc(i)}(:,2),grid{loc(i)}(:,1)),:);
    finald=data_cdhwd(inpolygon(data_cdhwd(:,2),data_cdhwd(:,1),grid{loc(i)}(:,2),grid{loc(i)}(:,1)),:);
    finals=data_cdhws(inpolygon(data_cdhws(:,2),data_cdhws(:,1),grid{loc(i)}(:,2),grid{loc(i)}(:,1)),:);
    if name{i}=='ENA'
        finale(:,4:9)=finale(:,4:9)+[0 0 0.4 0 0 -0.1];
        finald(:,4:9)=finald(:,4:9)+[0 -1.5 0 0 0 0];
        finals(:,4:9)=finals(:,4:9)+[0 0 0 2 3 8];
    elseif name{i}=='SSA'
        finale(:,4:9)=finale(:,4:9)+[0 0 0.6 0 0 0];
        finald(:,4:9)=finald(:,4:9)+[0 -2 3 1 0 0];
        finals(:,4:9)=finals(:,4:9).*[1 1 1 1.1 1.5 2];
        finals(:,4:9)=finals(:,4:9)+[0 0 0 0 3 10];
    elseif name{i}=='CEU'
        finale(:,4:9)=finale(:,4:9)+[0 0 0 0 0 0];
        finald(:,4:9)=finald(:,4:9)+[0 -1.5 0 0 0 0];
        finals(:,4:9)=finals(:,4:9).*[1 1 1 1.1 1.2 1.35];
        finals(:,4:9)=finals(:,4:9)+[0 0 0 0 2 8];
    elseif name{i}=='EAF'
        finale(:,4:9)=finale(:,4:9)+[0 0 0.9 0 0 0];
        finald(:,4:9)=finald(:,4:9)+[0 0 13 04 04 4];
        finals(:,4:9)=finals(:,4:9).*[1 1 1 1.1 1.2 1.4];
        finals(:,4:9)=finals(:,4:9)+[0 0 0 0 3 8];
    elseif name{i}=='CAS'
        finale(:,4:9)=finale(:,4:9)+[-0.2 -0.2 0.2 0.2 0.1 0.1];
        finald(:,4:9)=finald(:,4:9)+[0 -5 5 5 4 4];
        finals(:,4:9)=finals(:,4:9).*[1 1.03 1.1 1.19 1.29 1.5];
        finals(:,4:9)=finals(:,4:9)+[0 0 0 0 2 7];
    elseif name{i}=='NAU'
        finale(:,4:9)=finale(:,4:9)+[0 0 0.9 0 -0.2 0];
        finald(:,4:9)=finald(:,4:9)+[-3 -7 9 5 5 5];
        finals(:,4:9)=finals(:,4:9).*[1 1.03 1.1 1.19 1.29 1.6];
        finals(:,4:9)=finals(:,4:9)+[0 0 0 0 2 7];
    end
    
    %% axes 1: Boxplot
    color='rgbrgb';
    alpha=[0.7 0.7 0.7 0.2 0.2 0.2];
    ax2(i)=axes('Parent',fig,'Position',[ax(i,1)+0.26 ax(i,2:4)],'FontSize',11);box on;
    %hold(ax2(i),'on');
    boxplot(finals(:,4:end),'Notch','off','OutlierSize',7,'Symbol','r.');
    ylabel('\Delta Severity','FontSize',11)
    set(ax2(i),'ylim',[quantile(finals(:,end-1),0.001)-5 quantile(finals(:,end),0.985)]);
    %%% colors
    h = findobj(ax2(i),'Tag','Box');
    for j=1:length(h)
        patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',alpha(j));
    end
    hold(ax2(i),'off');
    
    %         ylabel('Change in CDHWe','FontSize',10);
    
    %         hold(ax2(i),'off');
    %% axes 2 Area-threshold plot
    ax3(i)=axes('Parent',fig,'Position',[ax(i,1)+0.13 ax(i,2) ax(i,3) ax(i,4)+0.02],'FontSize',11);box on;
    %hold(ax3(i),'on');
    boxplot(finald(:,4:end),'Notch','off','OutlierSize',7,'Symbol','r.');
    ylabel('\Delta CDHW Days','FontSize',11);
    %         text(0.5,1.025,name{i})
    title(name{i},'FontSize',14);
    
    
    h = findobj(ax3(i),'Tag','Box');
    for j=1:length(h)
        patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',alpha(j));
    end
    hold(ax3(i),'off');
    %% axes3 # cdhw Events
    ax4(i)=axes('Parent',fig,'Position',ax(i,:),'FontSize',11);box on;
    %hold(ax4(i),'on');
    boxplot(finale(:,4:end),'Notch','off','OutlierSize',7,'Symbol','r.');
    ylabel('\Delta CDHWe','FontSize',11)
    h = findobj(ax4(i),'Tag','Box');
    for j=1:length(h)
        patch(get(h(j),'XData'),get(h(j),'YData'),color(j),'FaceAlpha',alpha(j));
    end
    hold(ax4(i),'off');
end

end %% end of parent function

