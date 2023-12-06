
%% Raw versus average current example
clearvars
% load raw_cur_(alongsound).mat
time=datenum(TT.time);
a=TT.a;
for n=1:30
    x1(1,n)=0;y1(1,n)=n*(-1);end
for r=1:height(time)
    x(r,1:30)=x1(1,1:30);y(r,1:30)=y1(1,1:30);
end
for q=2:30
 time(:,q)=time(:,1);end
roi=22538:22726;time=datenum(time);
time=time(roi,:);y=y(roi,:);a=a(roi,:);

figure(11)
subplot(2,1,1)
nanContourf(time,y,time,y,a,100);grid on;
mycolormap = customcolormap(linspace(0,1,11), {'#68011d','#b5172f','#d75f4e','#f7a580','#fedbc9','#f5f9f3','#d5e2f0','#93c5dc','#4295c1','#2265ad','#062e61'});
colorbar('eastoutside');
clim([-40 40]);h = colorbar;set(h, 'ylim', [-40 40]);colormap(mycolormap);
ylabel(h,'Current velocity (cm/s)',FontSize=11);%set(get(gca,'YLabel'),'Rotation',30)
    ax=gca;xlim('tight');g1=xlim;r=g1(1):1:g1(2);ax.XTick=r; datetick('x','mmm dd','keeplimits');
ylabel('Depth (m)');
xlim([738388 738396])

clearvars
subplot(2,1,2)
% load avgcur_alldepths.mat
for n=1:30
    x1(1,n)=0;y1(1,n)=n*(-1);end
roi=127355:127739;
time=avgcur_alldepths.time(roi,:);time=datenum(time);
acuravg=avgcur_alldepths.acuravg(roi,:);
for r=1:height(time)
    x(r,1:30)=x1(1,1:30);y(r,1:30)=y1(1,1:30);end
for q=2:30
 time(:,q)=time(:,1);end
    nanContourf(time,y,time,y,acuravg,100);grid on;
mycolormap = customcolormap(linspace(0,1,11), {'#68011d','#b5172f','#d75f4e','#f7a580','#fedbc9','#f5f9f3','#d5e2f0','#93c5dc','#4295c1','#2265ad','#062e61'});
colorbar('eastoutside');
clim([-12 12]);h = colorbar;set(h, 'ylim', [-15 15]);colormap(mycolormap);
ylabel(h,'Residual current velocity (cm/s)',FontSize=11); %set(get(gca,'YLabel'),'Rotation',30)
    ax=gca;xlim('tight');g1=xlim;r=g1(1):1:g1(2);ax.XTick=r; datetick('x','mmm dd','keeplimits');
ylabel('Depth (m)');
fontname(gcf,"Times New Roman");
%% Integrated diatom contributions
clearvars
% load clean_carbon.mat
diatoms=[4 5 7 11 13 15 16 17 18 19 25 26 27 33 34 35 37 42 44 45 49 50 53 57 64 67 69 70 73 74 94];
c=x.data;
d1=c(:,diatoms);
d2=sum(d1);
n=cell(1); % Paste in header names so it becomes 97x1
nx=n(diatoms,1);nx=categorical(nx);
[o1,I]=sort(d2,'descend');
o2=nx(I);
o3=reordercats(o2,string(o2));
figure(472)
bar(o3,o1,'k');ylabel('Integrated Biomass (pg C)');set(gca,'YScale','log');fontname(gcf,"Times New Roman");

%% Calculating phytoplankton C observed
clearvars
% load cleancarbon_localtime.mat
t=X.t;
t1=t(1);t2=t(2050); % Accounting for time gaps in data here (duration is 2 yrs 6 months but have data only for 1yr 10 months)
d1=between(t1,t2);
t1=t(2051);t2=t(9384);
d2=between(t1,t2);
t1=t(9385);t2=t(12695);
d3=between(t1,t2);
t1=t(12696);t2=t(20200);
d4=between(t1,t2);
t1=t(20201);t2=t(22634);
d5=between(t1,t2);
t1=t(22635);t2=t(22641);
d6=between(t1,t2);
t1=t(22642);t2=t(40893);
d7=between(t1,t2);
D=d1+d2+d3+d4+d5+d6+d7; % Duration of carbon data
Y=1+(10/12)+(102/365.25)+(78/24/365.25)+(38/60/24/365.25)+(29/60/60/24/365.25);% Duration of carbon data in years

diatoms=[4 5 7 11 13 15 16 17 18 19 25 26 27 33 34 35 37 42 44 45 49 50 53 57 64 67 69 70 73 74 94];
dinos=[1 2 3 8 9 10 23 24 32 36 38 39 40 46 47 52 58 59 60 61 62 63 68 78];
flag=[12 14 20 22 28 54 55 65 66 77 79 91];
cil=[6 21 29 30 31 41 43 48 56 71 75 76 84];
nano=[92 93];
coco=[51 72 85];
c=X.data;
g=c(:,diatoms); q=g.'; w=sum(q); dia=w.';
g=c(:,dinos); q=g.'; w=sum(q); din=w.';
g=c(:,flag); q=g.'; w=sum(q); fla=w.';
g=c(:,cil); q=g.'; w=sum(q); ci=w.';
g=c(:,nano); q=g.'; w=sum(q); na=w.';
g=c(:,coco); q=g.'; w=sum(q); coc=w.';
m(:,1)=dia+din+fla+na+coc;
integrated=sum(m); % total phytoplankton Carbon observed by IFCB
dia_integrated=sum(dia);
din_integrated=sum(din);

i=height(X); % number of samples
minv=i*2; % minimum total volume of water analyzed
maxv=i*4.5; % maximum total volume of water analyzed

G1(1)=dia_integrated/minv/Y; %  max diatom pg C observed per ml per year
G1(2)=dia_integrated/maxv/Y; %  min diatom pg C observed per ml per year

gmly1=G1./1000000000000; % g diatom C observed per ml per year
gmcubedy1=gmly1*1000000; % g diatom C observed per m^3 per year

G2(1)=din_integrated/minv/Y; %  max dino pg C observed per ml per year
G2(2)=din_integrated/maxv/Y; %  min dino pg C observed per ml per year

gmly2=G2./1000000000000; % g dino C observed per ml per year
gmcubedy2=gmly2*1000000; % g dino C observed per m^3 per year

G(1)=integrated/minv/Y; %  max total pg C observed per ml per year
G(2)=integrated/maxv/Y; %  min total pg C observed per ml per year

gmly=G./1000000000000; % g total C observed per ml per year
gmcubedy=gmly*1000000; % g total C observed per m^3 per year

%% total seasonal biomass
clearvars
% load clean_carbon.mat
diatoms=[4 5 7 11 13 15 16 17 18 19 25 26 27 33 34 35 37 42 44 45 49 50 53 57 64 67 69 70 73 74 94];
dinos=[1 2 3 8 9 10 23 24 32 36 38 39 40 46 47 52 58 59 60 61 62 63 68 78];
flag=[12 14 20 22 28 54 55 65 66 77 79 91];
cil=[6 21 29 30 31 41 43 48 56 71 75 76 84];
nano=[92 93];
coco=[51 72 85];
det=[86 87 88 89 90 95 96];
zoo=97;

c=x.data;
g=c(:,diatoms); q=g.'; w=sum(q); dia=w.';
g=c(:,dinos); q=g.'; w=sum(q); din=w.';
g=c(:,flag); q=g.'; w=sum(q); fla=w.';
g=c(:,cil); q=g.'; w=sum(q); ci=w.';
g=c(:,nano); q=g.'; w=sum(q); na=w.';
g=c(:,coco); q=g.'; w=sum(q); coc=w.';
g=c(:,det); q=g.'; w=sum(q); de=w.';
zo=c(:,zoo);
m(:,1)=dia+din+fla+na+coc;
m(:,2)=dia;m(:,3)=din;m(:,4)=fla;m(:,5)=ci;m(:,6)=na;m(:,7)=coc;m(:,8)=de;m(:,9)=zo;

% 
figure(496)
tiledlayout(3,3);
nexttile
plot(x.dnum,m(:,1),'k');
dl = datetime('1-Jan-2020');
dr = datetime('31-Dec-2020');
ylim([0 20000000]);
ylabel('Biomass(pg C)');grid on;
xlim([dl dr]);xticklabels('');
nexttile
plot(x.dnum,m(:,1),'k');
dl = datetime('1-Jan-2021');
dr = datetime('31-Dec-2021');
xlim([dl dr]);xticklabels('');grid on;ylim([0 20000000]);
nexttile
plot(x.dnum,m(:,1),'k');
dl = datetime('1-Jan-2022');
dr = datetime('31-Dec-2022');
xlim([dl dr]);xticklabels('');grid on;ylim([0 20000000]);
%
nexttile
plot(x.dnum,dia,'k');
dl = datetime('1-Jan-2020');
dr = datetime('31-Dec-2020');
ylim([0 15000000]);
xlim([dl dr]);xticklabels('');ylabel('Biomass (pg C)');grid on;
nexttile
plot(x.dnum,dia,'k');
dl = datetime('1-Jan-2021');
dr = datetime('31-Dec-2021');
xlim([dl dr]);xticklabels('');grid on;ylim([0 15000000]);
nexttile
plot(x.dnum,dia,'k');
dl = datetime('1-Jan-2022');
dr = datetime('31-Dec-2022');
xlim([dl dr]);xticklabels('');grid on;ylim([0 15000000]);
%
nexttile
plot(x.dnum,din,'k');
dl = datetime('1-Jan-2020');
dr = datetime('31-Dec-2020');
ylim([0 15000000]);
xlim([dl dr]);ylabel('Biomass (pg C)');grid on;
nexttile
plot(x.dnum,din,'k');
dl = datetime('1-Jan-2021');
dr = datetime('31-Dec-2021');
xlim([dl dr]);grid on;ylim([0 15000000]);
nexttile
plot(x.dnum,din,'k');
dl = datetime('1-Jan-2022');
dr = datetime('31-Dec-2022');
xlim([dl dr]);grid on;ylim([0 15000000]);
fontname(gcf,"Times New Roman");

%% total phytoplankton biomass (non)conservative gain/loss
clearvars
% load cleancarbon_localtime.mat 
diatoms=[4 5 7 11 13 15 16 17 18 19 25 26 27 33 34 35 37 42 44 45 49 50 53 57 64 67 69 70 73 74 94];
dinos=[1 2 3 8 9 10 23 24 32 36 38 39 40 46 47 52 58 59 60 61 62 63 68 78];
flag=[12 14 20 22 28 54 55 65 66 77 79 91];
cil=[6 21 29 30 31 41 43 48 56 71 75 76 84];
nano=[92 93];
coco=[51 72 85];
det=[86 87 88 89 90 95 96];
c=X.data;
g=c(:,diatoms); q=g.'; w=sum(q); dia=w.';
g=c(:,dinos); q=g.'; w=sum(q); din=w.';
g=c(:,flag); q=g.'; w=sum(q); fla=w.';
g=c(:,cil); q=g.'; w=sum(q); ci=w.';
g=c(:,nano); q=g.'; w=sum(q); na=w.';
g=c(:,coco); q=g.'; w=sum(q); coc=w.';
g=c(:,det); q=g.'; w=sum(q); de=w.';
m(:,1)=dia+din+fla+na+coc;
figure(8268)
tiledlayout(5,1);
nexttile
plot(X.t,m(:,1),'k');ylabel('Biomass (pg C)');
dl = datetime('21-Apr-2022 00:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');hold on;
% load slacktimedata.mat
c=slacktimedata.slackdata;
g=c(:,diatoms); q=g.'; w=sum(q); dia=w.';
g=c(:,dinos); q=g.'; w=sum(q); din=w.';
g=c(:,flag); q=g.'; w=sum(q); fla=w.';
g=c(:,cil); q=g.'; w=sum(q); ci=w.';
g=c(:,nano); q=g.'; w=sum(q); na=w.';
g=c(:,coco); q=g.'; w=sum(q); coc=w.';
g=c(:,det); q=g.'; w=sum(q); de=w.';
m2(:,1)=dia+din+fla+na+coc;
nexttile
plot(slacktimedata.f,m2(:,1),"Color","#4DBEEE","LineWidth",2);
dl = datetime('21-Apr-2022 00:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');hold on;
% load separate_slack_timedata.mat
c=Htimedata.Hdata;
g=c(:,diatoms); q=g.'; w=sum(q); dia=w.';
g=c(:,dinos); q=g.'; w=sum(q); din=w.';
g=c(:,flag); q=g.'; w=sum(q); fla=w.';
g=c(:,cil); q=g.'; w=sum(q); ci=w.';
g=c(:,nano); q=g.'; w=sum(q); na=w.';
g=c(:,coco); q=g.'; w=sum(q); coc=w.';
g=c(:,det); q=g.'; w=sum(q); de=w.';
m3(:,1)=dia+din+fla+na+coc;
plot(Htimedata.H,m3(:,1),'b.');
dl = datetime('21-Apr-2022 00:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mm/dd','keeplimits');hold on;
c=Ltimedata.Ldata;
g=c(:,diatoms); q=g.'; w=sum(q); dia=w.';
g=c(:,dinos); q=g.'; w=sum(q); din=w.';
g=c(:,flag); q=g.'; w=sum(q); fla=w.';
g=c(:,cil); q=g.'; w=sum(q); ci=w.';
g=c(:,nano); q=g.'; w=sum(q); na=w.';
g=c(:,coco); q=g.'; w=sum(q); coc=w.';
g=c(:,det); q=g.'; w=sum(q); de=w.';
m4(:,1)=dia+din+fla+na+coc;
plot(Ltimedata.L,m4(:,1),'r.');
dl = datetime('21-Apr-2022 00:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mm/dd','keeplimits');
datetick('x','mmm dd','keeplimits');
ylabel('Biomass (pg C)');
%next tile
nexttile
plot(X.t,m(:,1),'k.');ylabel('Biomass (pg C)');
dl = datetime('21-Apr-2022 00:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');hold on;
plot(slacktimedata.f,m2(:,1),"Color","#4DBEEE","LineWidth",2);
dl = datetime('21-Apr-2022 00:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');hold on;
% load clean_alongsoundcur_2m_interpolated.mat and moon.mat
nexttile
yyaxis right
plot(A.t,A.data,"Color","#D95319");hold on;
dl = datetime('21-Apr-2022 00:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');ylabel('Current velocity (cm/s)');
ylim([-25 100]);hold on;
yline(0); hold on;
yyaxis left
plot(moon.TT1,moon.s,'k');
dl = datetime('21-Apr-2022 00:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');
ylabel('Tidal magnification (%)','Color','k');ylim([-100 100]);
ax=gca;ax.YColor='k';
% load slacktimedata_interpolated.mat &
% residual.mat
c=Residual.res;
g=c(:,diatoms); q=g.'; w=sum(q); dia=w.';
g=c(:,dinos); q=g.'; w=sum(q); din=w.';
g=c(:,flag); q=g.'; w=sum(q); fla=w.';
g=c(:,cil); q=g.'; w=sum(q); ci=w.';
g=c(:,nano); q=g.'; w=sum(q); na=w.';
g=c(:,coco); q=g.'; w=sum(q); coc=w.';
g=c(:,det); q=g.'; w=sum(q); de=w.';
m5(:,1)=dia+din+fla+na+coc;
nexttile
plot(Residual.t,m5(:,1),"k.");hold on;
yline(0,'k');
dl = datetime('21-Apr-2022 00:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);ylabel('Biomass (pg C)');grid on; datetick('x','mmm dd','keeplimits');
fontname(gcf,"Times New Roman");

%% diatom biomass (non)conservative gain/loss
clearvars
figure(82864) % make large figure
subplot(4,3,1)
% load slacktimedata.mat & separate_slack_timedata.mat
c=slacktimedata.slackdata;
gblueline=c(:,33); 
plot(slacktimedata.f,gblueline,"Color","#4DBEEE","LineWidth",2);
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');hold on;
c=Htimedata.Hdata;
g=c(:,33);
plot(Htimedata.H,g,'b.');
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mm/dd','keeplimits');hold on;
c=Ltimedata.Ldata;
g=c(:,33);
plot(Ltimedata.L,g,'r.');
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mm/dd','keeplimits');
datetick('x','mmm dd','keeplimits');
ylabel('Biomass (pg C)');
c=slacktimedata.slackdata;    %
tblueline=c(:,74); 
subplot(4,3,4)
plot(slacktimedata.f,tblueline,"Color","#4DBEEE","LineWidth",2);
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');hold on;
c=Htimedata.Hdata;
g=c(:,74);
plot(Htimedata.H,g,'b.');
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mm/dd','keeplimits');hold on;
c=Ltimedata.Ldata;
g=c(:,74);
plot(Ltimedata.L,g,'r.');
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mm/dd','keeplimits');
datetick('x','mmm dd','keeplimits');
ylabel('Biomass (pg C)');
c=slacktimedata.slackdata;     %
sblueline=c(:,69); 
subplot(4,3,7)
plot(slacktimedata.f,sblueline,"Color","#4DBEEE","LineWidth",2);
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');hold on;
c=Htimedata.Hdata;
g=c(:,69);
plot(Htimedata.H,g,'b.');
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mm/dd','keeplimits');hold on;
c=Ltimedata.Ldata;
g=c(:,69);
plot(Ltimedata.L,g,'r.');
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mm/dd','keeplimits');
datetick('x','mmm dd','keeplimits');
ylabel('Biomass (pg C)');
%next column load cleancarbon_localtime.mat
subplot(4,3,2)
c=X.data;
g=c(:,33);
plot(X.t,g,'k.');ylabel('Biomass (pg C)');
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');hold on;
plot(slacktimedata.f,gblueline,"Color","#4DBEEE","LineWidth",2);
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');hold on;
subplot(4,3,5)     %
c=X.data;
g=c(:,74);
plot(X.t,g,'k.');ylabel('Biomass (pg C)');
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');hold on;
plot(slacktimedata.f,tblueline,"Color","#4DBEEE","LineWidth",2);
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');hold on;
subplot(4,3,8)     %
c=X.data;
g=c(:,69);
plot(X.t,g,'k.');ylabel('Biomass (pg C)');
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');hold on;
plot(slacktimedata.f,sblueline,"Color","#4DBEEE","LineWidth",2);
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');hold on;
% next column load slacktimedata_interpolated.mat & residual.mat
c=Residual.res;
g=c(:,33);
subplot(4,3,3)
plot(Residual.t,g,"k.");hold on;
yline(0,'g',"LineWidth",2);
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);ylabel('Biomass (pg C)');grid on; datetick('x','mmm dd','keeplimits');
g=c(:,74);
subplot(4,3,6)
plot(Residual.t,g,"k.");hold on;
yline(0,'g',"LineWidth",2);
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);ylabel('Biomass (pg C)');grid on; datetick('x','mmm dd','keeplimits');
g=c(:,69);
subplot(4,3,9)
plot(Residual.t,g,"k.");hold on;
yline(0,'g',"LineWidth",2);
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);ylabel('Biomass (pg C)');grid on; datetick('x','mmm dd','keeplimits');
% last row
clearvars
% load clean_alongsoundcur_2m_interpolated.mat and moon.mat
subplot(4,3,10)
yyaxis right
plot(A.t,A.data,"Color","#D95319");hold on;
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');ylabel('Current velocity (cm/s)');
ylim([-40 100]);hold on;
yline(0); hold on;
yyaxis left
plot(moon.TT1,moon.s,'k');
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');
ylabel('Tidal magnification (%)','Color','k');ylim([-100 100]);
ax=gca;ax.YColor='k';

subplot(4,3,11)
% load avgcur_alldepths.mat
for n=1:30
    x1(1,n)=0;y1(1,n)=n*(-1);end
roi=135647:140431;
time=avgcur_alldepths.time(roi,:);time=datenum(time);
acuravg=avgcur_alldepths.acuravg(roi,:);
for r=1:height(time)
    x(r,1:30)=x1(1,1:30);y(r,1:30)=y1(1,1:30);end
for q=2:30
 time(:,q)=time(:,1);end
    nanContourf(time,y,time,y,acuravg,100);grid on;
mycolormap = customcolormap(linspace(0,1,11), {'#68011d','#b5172f','#d75f4e','#f7a580','#fedbc9','#f5f9f3','#d5e2f0','#93c5dc','#4295c1','#2265ad','#062e61'});
colorbar('eastoutside');
clim([-12 12]);h = colorbar;set(h, 'ylim', [-15 15]);colormap(mycolormap);
ylabel(h,'Residual current velocity (cm/s)',FontSize=11); %set(get(gca,'YLabel'),'Rotation',30)
    ax=gca;xlim('tight');g1=xlim;r=g1(1):1:g1(2);ax.XTick=r; datetick('x','mmm dd','keeplimits');
ylabel('Depth (m)');

subplot(4,3,12)
% load LOBO_timetempsal.mat
sal=TT.sal;temp=TT.temp;time=TT.t;
sizea = size(temp);numrows = sizea(1);tthresh = -1;sthresh = 25;
for i = 1:numrows 
        if temp(i,1) < tthresh
            temp(i,1) = nan;
        end 
        if sal(i,1) < sthresh
            sal(i,1) = nan;
        end       
end 
colororder({'r','k'});
yyaxis left;plot(time,temp,'r');grid on;
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');ylabel('Temperature (°C)');
yyaxis right;
plot(time,sal,'k');grid on;
dl = datetime('8-Feb-2022 17:00:00','TimeZone','America/New_York');
dr = datetime('20-May-2022 00:00:00','TimeZone','America/New_York');
xlim([dl dr]);grid on; datetick('x','mmm dd','keeplimits');ylabel('Salinity (ppt)');
fontname(gcf,"Times New Roman");
%% Residual (nonconservative variability) for spring-neap phase
clearvars
% load moonintersectresidual.mat
c=moonres.rdata;
diatoms=[4 5 7 11 13 15 16 17 18 19 25 26 27 33 34 35 37 42 44 45 49 50 53 57 64 67 69 70 73 74 94];
dinos=[1 2 3 8 9 10 23 24 32 36 38 39 40 46 47 52 58 59 60 61 62 63 68 78];
flag=[12 14 20 22 28 54 55 65 66 77 79 91];
cil=[6 21 29 30 31 41 43 48 56 71 75 76 84];
nano=[92 93];
coco=[51 72 85];
det=[86 87 88 89 90 95 96];
g=c(:,diatoms); q=g.'; w=sum(q); dia=w.';
g=c(:,dinos); q=g.'; w=sum(q); din=w.';
g=c(:,flag); q=g.'; w=sum(q); fla=w.';
g=c(:,cil); q=g.'; w=sum(q); ci=w.';
g=c(:,nano); q=g.'; w=sum(q); na=w.';
g=c(:,coco); q=g.'; w=sum(q); coc=w.';
g=c(:,det); q=g.'; w=sum(q); de=w.';
m(:,1)=dia+din+fla+na+coc;
p=moonres.d;
figure(3849)
tiledlayout(3,1);nexttile;
yline(0);hold on;
plot(p,m(:,1),'k.');ylabel('Residual C (g)');
grid on;fontname(gcf,"Times New Roman");
nexttile;
yline(0);hold on;
plot(p,dia,'k.');ylabel('Residual C (g)');
grid on;fontname(gcf,"Times New Roman");
nexttile
yline(0);hold on;
plot(p,din,'k.');xlabel('Tidal magnification (%)');ylabel('Residual C (g)');
grid on;fontname(gcf,"Times New Roman");

%% Residual for temperature and salinity
clearvars
% load temp_sal_residual.mat
c=tempsalres.rdata;
diatoms=[4 5 7 11 13 15 16 17 18 19 25 26 27 33 34 35 37 42 44 45 49 50 53 57 64 67 69 70 73 74 94];
dinos=[1 2 3 8 9 10 23 24 32 36 38 39 40 46 47 52 58 59 60 61 62 63 68 78];
flag=[12 14 20 22 28 54 55 65 66 77 79 91];
cil=[6 21 29 30 31 41 43 48 56 71 75 76 84];
nano=[92 93];
coco=[51 72 85];
det=[86 87 88 89 90 95 96];
g=c(:,diatoms); q=g.'; w=sum(q); dia=w.';
g=c(:,dinos); q=g.'; w=sum(q); din=w.';
g=c(:,flag); q=g.'; w=sum(q); fla=w.';
g=c(:,cil); q=g.'; w=sum(q); ci=w.';
g=c(:,nano); q=g.'; w=sum(q); na=w.';
g=c(:,coco); q=g.'; w=sum(q); coc=w.';
g=c(:,det); q=g.'; w=sum(q); de=w.';
m(:,1)=dia+din+fla+na+coc;
temp=tempsalres.temperature;
figure(3849075)
tiledlayout(3,1);nexttile;
yline(0);hold on;
plot(temp,m(:,1),'k.');ylabel('Residual C (g)');
grid on;fontname(gcf,"Times New Roman");
nexttile;
yline(0);hold on;
plot(temp,dia,'k.');ylabel('Residual C (g)');
grid on;fontname(gcf,"Times New Roman");
nexttile
yline(0);hold on;
plot(temp,din,'k.');xlabel('Temperature (°C)');ylabel('Residual C (g)');
grid on;fontname(gcf,"Times New Roman");
%
sal=tempsalres.salinity;
figure(38490)
tiledlayout(3,1);nexttile;
yline(0);hold on;
plot(sal,m(:,1),'k.');ylabel('Residual C (g)');
grid on;fontname(gcf,"Times New Roman");
nexttile;
yline(0);hold on;
plot(sal,dia,'k.');ylabel('Residual C (g)');
grid on;fontname(gcf,"Times New Roman");
nexttile
yline(0);hold on;
plot(sal,din,'k.');xlabel('Salinity (ppt)');ylabel('Residual C (g)');
grid on;fontname(gcf,"Times New Roman");

%% TEST:simple comparison
clearvars
load('21feb.mat');
x=TT.data;
figure(2)
plot(TT.dnum,x(:,69),"Color",'r');hold on;
plot(TT.dnum,x(:,11),"Color",[0.8500 0.3250 0.0980]);hold on;
plot(TT.dnum,x(:,74),"Color",[0 0.4470 0.7410]);hold on;
plot(TT.dnum,x(:,5),"Color",[0.4940 0.1840 0.5560]);hold on;
plot(TT.dnum,x(:,7),"Color",[0.9290 0.6940 0.1250]);hold on;
plot(TT.dnum,x(:,33),"Color",[0.4660 0.6740 0.1880]);hold on;
load('21jan.mat'); hold on;
x=TT.data;
plot(TT.dnum,x(:,69),"Color",'r');hold on;
plot(TT.dnum,x(:,11),"Color",[0.8500 0.3250 0.0980]);hold on;
plot(TT.dnum,x(:,74),"Color",[0 0.4470 0.7410]);
plot(TT.dnum,x(:,5),"Color",[0.4940 0.1840 0.5560])
plot(TT.dnum,x(:,7),"Color",[0.9290 0.6940 0.1250])
plot(TT.dnum,x(:,33),"Color",[0.4660 0.6740 0.1880])
legend('Skeletonema spp.','Chaetoceros spp.','Thalassiosira spp.','Unidentified pennate','Cerataulina pelagica','Guinardia delicatula');
ylabel('Biovolume (\mum^3)');

%% TEST: c versus bv comparison

clearvars
% load clean_all.mat
diatoms=[4 5 7 11 13 15 16 17 18 19 25 26 27 33 34 35 37 42 44 45 49 50 53 57 64 67 69 70 73 74 94];
dinos=[1 2 3 8 9 10 23 24 32 36 38 39 40 46 47 52 58 59 60 61 62 63 68 78];
flag=[12 14 20 22 28 54 55 65 66 77 79 91];
cil=[6 21 29 30 31 41 43 48 56 71 75 76 84];
nano=[92 93];
coco=[51 72 85];
det=[86 87 88 89 90 95 96];
zoo=97;

c=x.data;
g=c(:,diatoms); q=g.'; w=sum(q); dia=w.';
g=c(:,dinos); q=g.'; w=sum(q); din=w.';
g=c(:,flag); q=g.'; w=sum(q); fla=w.';
g=c(:,cil); q=g.'; w=sum(q); ci=w.';
g=c(:,nano); q=g.'; w=sum(q); na=w.';
g=c(:,coco); q=g.'; w=sum(q); coc=w.';
g=c(:,det); q=g.'; w=sum(q); de=w.';
zo=c(:,zoo);
m(:,1)=dia+din+fla+na+coc;
m(:,2)=dia;m(:,3)=din;m(:,4)=fla;m(:,5)=ci;m(:,6)=na;m(:,7)=coc;m(:,8)=de;m(:,9)=zo;

figure(839)
Ylabels=["Phytoplankton ([\mum])","Diatom","Dinoflagellate","Flagellate"];
s=stackedplot(x.dnum,m(:,1:4),"DisplayLabels",Ylabels);
dl = datetime('1-Feb-2020');
dr = datetime('29-Feb-2020');
xlim([dl dr]);
s.LineWidth = .5;s.Color='k';
s.AxesProperties(1).YLimits=[0 500000000];
s.AxesProperties(2).YLimits=[0 500000000];
s.AxesProperties(3).YLimits=[0 100000000];
s.AxesProperties(4).YLimits=[0 60000000];
%
clearvars
%load 20-02.mat
diatoms=[4 5 7 11 13 15 16 17 18 19 25 26 27 33 34 35 37 42 44 45 49 50 53 57 64 67 69 70 73 74 94];
dinos=[1 2 3 8 9 10 23 24 32 36 38 39 40 46 47 52 58 59 60 61 62 63 68 78];
flag=[12 14 20 22 28 54 55 65 66 77 79 91];
cil=[6 21 29 30 31 41 43 48 56 71 75 76 84];
nano=[92 93];
coco=[51 72 85];
det=[86 87 88 89 90 95 96];
zoo=97;

c=TT.data;
g=c(:,diatoms); q=g.'; w=sum(q); dia=w.';
g=c(:,dinos); q=g.'; w=sum(q); din=w.';
g=c(:,flag); q=g.'; w=sum(q); fla=w.';
g=c(:,cil); q=g.'; w=sum(q); ci=w.';
g=c(:,nano); q=g.'; w=sum(q); na=w.';
g=c(:,coco); q=g.'; w=sum(q); coc=w.';
g=c(:,det); q=g.'; w=sum(q); de=w.';
zo=c(:,zoo);
m(:,1)=dia+din+fla+na+coc;
m(:,2)=dia;m(:,3)=din;m(:,4)=fla;m(:,5)=ci;m(:,6)=na;m(:,7)=coc;m(:,8)=de;m(:,9)=zo;

% 
figure(751)
Ylabels=["Phytoplankton ([pg C])","Diatom","Dinoflagellate","Flagellate"];
s=stackedplot(TT.dnum,m(:,1:4),"DisplayLabels",Ylabels);
dl = datetime('1-Feb-2020');
dr = datetime('29-Feb-2020');
xlim([dl dr]);
s.LineWidth = .5;s.Color='k';
% s.AxesProperties(1).YLimits=[0 500000000];
% s.AxesProperties(2).YLimits=[0 500000000];
% s.AxesProperties(3).YLimits=[0 100000000];
% s.AxesProperties(4).YLimits=[0 60000000];