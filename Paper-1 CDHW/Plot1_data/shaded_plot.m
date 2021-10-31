function [h]=shaded_plot(x,y1,y2,color,alpha)

x2 = [x, fliplr(x)];
inBetween = [y1, fliplr(y2)];
h=fill(x2, inBetween,color,'LineStyle','None');%,varargin{1});
set(h,'facealpha',alpha)
end

% x=yr{2,1};
% y1=fut_eve{1,1}(:,2)';
% y2=fut_eve{1,1}(:,3)';