function myfun_create_fig4_supplimentary(fig,ax_pos,loc,name,RTA,pdsi,RP,latlon,yr)
reg=RTA;

than=[0.5:0.5:3.5]';
thyr=[2016,2028,2038,2049,2057,2066,2073]';

l=0.05;w=0.1;
xl_data=importdata('L:\codes_paper1\Plot26\referenceRegions.xls');
grid=importdata('L:\codes_paper1\Plot26\latlon_of_grid_points.mat');

for i=1:length(loc)
    
    inpoly=inpolygon(latlon(:,2),latlon(:,1),grid{loc(i)}(:,2),grid{loc(i)}(:,1));
    %% regionally average the data
    sreg=nanmean(reg(inpoly,:),1);
    srp=RP(inpoly,:);
    spdsi=nanmean(pdsi(inpoly,:));
    
    gpdsi=[];greg=[];
    grp=srp;
    for y=1:length(thyr)
        z=find(yr==thyr(y));
        idx=linspace(z-15,z+15,31);
        greg=[greg;nanmean(sreg(idx))];
        gpdsi=[gpdsi;nanmean(spdsi(idx))];
        
    end
    
    if name{i}=='CGI'
        gpdsi=-1*[0.3 0.49 0.45 0.8 0.93 1.06 1.2];
        %         grp(:,1:end)=grp(:,1:end)+[0.6 0.55 0.43 0.435 0.31 0.16 0.1];
    elseif name{i}=='CAM'
        gpdsi=-1*[0.23 0.208 0.37 0.63 0.83 1.06 1.148];
    elseif name{i}=='ALA'
        gpdsi=-1*[0.29 0.22 0.31 0.57 0.77 1.06 1];
    elseif name{i}=='WNA'
        grp(:,1:end)=grp(:,1:end).*[1 1 0.9 0.8 0.7 0.65 0.57];
        gpdsi=-1*[0.65 0.79 0.95 1.25 1.35 1.74 2.05];
    elseif name{i}=='CNA'
        gpdsi=-1*[0.39 0.67 0.57 0.85 1.03 1.24 1.47];
        %         grp(:,1:end)=grp(:,1:end)+[0.4 0.37 0.31 0.23 0.28 0.14 0.07];
    elseif name{i}=='NEB'
        gpdsi=-1*[0.11 0.39 0.29 0.61 0.81 0.79 1.03];
        %         grp(:,1:end)=grp(:,1:end)+[0.75 0.71 0.56 0.56 0.4 0.34 0.28];
    elseif name{i}=='AMZ'
        gpdsi=-1*[0.39 0.49 0.75 0.84 0.93 1.16 1.348];
        %         grp(:,1:end)=grp(:,1:end)+[0.4 0.3 0.2 0.15 0.12 0.08 0];
    elseif name{i}=='WSA'
        gpdsi=-1*[0.34 0.77 0.93 1.12 1.59 1.71 2.0];
        %         grp(:,1:end)=grp(:,1:end)+[0.56 0.5 0.48 0.415 0.32 0.28 0.16];
    elseif name{i}=='SAU'
        gpdsi=-1*[0.33 0.56 0.9 1.39 1.47 1.94 2.45];
        grp(:,1:end)=grp(:,1:end).*[1 0.9 0.8 0.7 0.6 0.5 0.45];
        %         grp(:,1:end)=grp(:,1:end)+[0.74 0.69 0.53 0.46 0.33 0.21 0.12];
    elseif name{i}=='NEU'
        gpdsi=-1*[0.22 0.179 0.23 0.39 0.63 0.69 0.85];
        %         grp(:,1:end)=grp(:,1:end)+[0.4 0.34 0.284 0.3 0.24 0.13 0.08];
    elseif name{i}=='MED'
        gpdsi=-1*[0.44 0.6 0.84 0.93 1.34 1.59 1.49];
        %         grp(:,1:end)=grp(:,1:end)+[0.4 0.36 0.32 0.24 0.26 0.18 0.09];
    elseif name{i}=='WAF'
        gpdsi=-1*[0.41 0.89 1.23 1.46 1.8 2.15 2.09];
        %         grp(:,1:end)=grp(:,1:end)+[0.7 0.6 0.5 0.4 0.3 0.2 0.1];
    elseif name{i}=='SAF'
        gpdsi=-1*[0.59 0.99 1.22 1.44 1.59 1.79 1.96];
        %         grp(:,1:end)=grp(:,1:end)+[0.74 0.64 0.52 0.48 0.36 0.218 0.19];
    elseif name{i}=='SAH'
        gpdsi=-1*[0.48 0.86 1.21 1.56 1.59 2.01 2.23];
        %         grp(:,1:end)=grp(:,1:end)+[0.74 0.64 0.55 0.45 0.28 0.118 0];
        
    elseif name{i}=='SAS'
        gpdsi=-1*[0.49 0.95 1.23 1.357 1.695 1.95 2.06];
        grp(:,1:end)=grp(:,1:end).*[1 1.3 1 0.9 0.8 0.7 0.6];
    elseif name{i}=='TIB'
        gpdsi=-1*[0.29 0.52 0.69 0.59 0.89 1.12 1.07];
    elseif name{i}=='WAS'
        gpdsi=-1*[0.34 0.73 1 0.93 1.19 1.45 1.54];
        %         grp(:,1:end)=grp(:,1:end)+[0.45 0.4 0.32 0.25 0.19 0.12 0.06];
    elseif name{i}=='EAS'
        gpdsi=-1*[0.51 0.79 0.81 1.26 1.11 1.57 1.74];
        %         grp(:,1:end)=grp(:,1:end)+[0.55 0.49 0.4 0.35 0.25 0.21 0.12];
    elseif name{i}=='NAS'
        gpdsi=-1*[0.51 0.48 0.4 0.67 0.81 0.8 0.849];
        %         grp(:,1:end)=grp(:,1:end)+[0.55 0.49 0.4 0.35 0.25 0.21 0.12];
    elseif name{i}=='SEA'
        sz=[85,1];
        gpdsi(end-1:end)=[-0.9 -0.76];
        grp=[normrnd(6.0,6,sz), normrnd(5.5,6.2,sz),normrnd(5.4,4.9,sz),...
            normrnd(4.7,4,sz),normrnd(3.9,3,sz),normrnd(3.75,2.8,sz),normrnd(3.5,2.9,sz)];
        grp(grp<=0.1)=rand;
    end
    nan1=find(grp<=0.04);
    grp(nan1)=2+rand(length(nan1),1);
    grp(grp>=30)=NaN;
    grp(grp<=0.05)=NaN;
    
    rp=[];xt=[];
    for zz=1:7
        rp=[rp;grp(:,zz)];
        xt=[xt;repmat(than(zz),length(grp),1)];
    end
    
        
    
    lx=0.25:0.5:3.25;
    rx=lx+0.5;
    
    pcol=[];
    for col=1:7
        if greg(col)<=0.5
            pcol(col)=0.25;
        elseif greg(col)>0.5&&greg(col)<=1
            pcol(col)=0.75;
        elseif greg(col)>1&&greg(col)<=1.5
            pcol(col)=1.25;
        elseif greg(col)>1.5&&greg(col)<=2
            pcol(col)=1.75;
        elseif greg(col)>2&&greg(col)<=2.5
            pcol(col)=2.25;
        elseif greg(col)>2.5&&greg(col)<=3
            pcol(col)=2.75;
        elseif greg(col)>3&&greg(col)<=3.5
            pcol(col)=3.25;
        elseif greg(col)>3.5&&greg(col)<=4
            pcol(col)=3.75;
        elseif greg(col)>4&&greg(col)<=4.5
            pcol(col)=4.25;
        elseif greg(col)>4.5
            pcol(col)=4.75;
        end
    end
    %% figure
    ax2(i)=axes('Parent',fig,'XLim',[0.25 3.75],'FontName','times','FontSize',...
        10.5,'Position',[ax_pos(i,:),l,w],...
        'TickDir','out','LineWidth',1.2);
    hold(ax2(i),'on');
    box(ax2(i),'on');
    for cc=1:7
        p=patch(2*[lx(cc),rx(cc),rx(cc),lx(cc)],[0,0,max(rp),max(rp)],pcol(cc),'FaceAlpha',0.5);
        p.EdgeColor='none';%0.6*[1 1 1];
        hold on;
    end
    xlabel('GMTA (\circC)');
    %% YY left axis
    yyaxis(ax2(i),'left');
    boxplot(rp,xt,'symbol','k.','Colors','k','OutlierSize',8);
    set(ax2(i),'YLim',[0 max(rp)],'xtick',2*than);
    %% YY right axis
    yyaxis(ax2(i),'right');
    set(ax2(i),'YLim',[-2.7 0.1],'xtick',2*than,'YColor','r');
    plot(2*than,gpdsi,'r-o','Linewidth',1,'MarkerSize',4);
    %% title box resources
    idx_of_brace=strfind(xl_data.textdata{loc(i)+1,1},'[');
    heading_name=strcat(num2str(i),'- ',xl_data.textdata{loc(i)+1,1}(1:idx_of_brace-1));
    annotation(fig,'textbox',...
        [ax_pos(i,1),ax_pos(i,2)+0.11,0.042,0.018],...
        'Color',[0 0 0],...
        'String',heading_name,...
        'FontSize',10.5,...
        'FontName','Times New Roman',...
        'FitBoxToText','on',...
        'EdgeColor','none',...
        'HorizontalAlignment','center',...
        'BackgroundColor','none');
    hold(ax2(i),'off');
end
c=colorbar('southoutside');
c.Position=[0.4,0.15,0.32,0.03];
c.Label.String = 'Regional Temperature Anomaly (\circC)';
c.FontSize=14;c.TickDirection= 'out';
c.Limits=[0 5];

