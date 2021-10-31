clear;clc;close all;

path='L:\codes_paper1\plot4\plot4\';
% fig=figure(1);
% subplot(3,2,1)
% openfig([path,'Asia.fig']);

cd(path);
h1 = openfig('Asia.fig','reuse'); % open figure
ax1 = gca; % get handle to axes of figure
h2 = openfig('Europe.fig','reuse');
ax2 = gca;


h3 = openfig('Australia.fig','reuse'); % open figure
ax3 = gca; % get handle to axes of figure
h4= openfig('South America.fig','reuse');
ax4 = gca;

h5 = openfig('Africa.fig','reuse'); % open figure
ax5 = gca; % get handle to axes of figure
h6= openfig('NorthAmerica.fig','reuse');
ax6 = gca;
% test1.fig and test2.fig are the names of the figure files which you would % like to copy into multiple subplots
h3 = figure;
sgtitle('Return period Vs. Area curves')
s1 = subplot(3,2,1);subtitle('Asia','fontsize',16);xlabel('Return Period (Years)');ylabel('% of Area');
legend%('SSP126','SSP245','SSP585','Observed');
grid on;
s2 = subplot(3,2,2);grid on;subtitle('Europe','fontsize',16);xlabel('Return Period (Years)');ylabel('% of Area');

s3 = subplot(3,2,3);grid on;subtitle('Australia','fontsize',16);xlabel('Return Period (Years)');ylabel('% of Area');
s4 = subplot(3,2,4);grid on;subtitle('South America','fontsize',16);xlabel('Return Period (Years)');ylabel('% of Area');

s5 = subplot(3,2,5); grid on;subtitle('Africa','fontsize',16);xlabel('Return Period (Years)');ylabel('% of Area');
s6= subplot(3,2,6);grid on;subtitle('North America','fontsize',16);xlabel('Return Period (Years)');ylabel('% of Area');


fig1 = get(ax1,'children'); 
fig2 = get(ax2,'children');
fig3 = get(ax3,'children'); 
fig4 = get(ax4,'children');
fig5 = get(ax5,'children'); 
fig6 = get(ax6,'children');
copyobj(fig1,s1); 
copyobj(fig2,s2);
copyobj(fig3,s3); 
copyobj(fig4,s4);
copyobj(fig5,s5); 
copyobj(fig6,s6);