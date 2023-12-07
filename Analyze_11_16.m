%   What:  dynamics of coastal phytoplankton and diatom communities
%   Why: project analysis documentation
%   When: Nov 2023
%   Who: Charlie O'Brien
%% create file list
x1=j.time;
 %x2=j.time; % file names
%names=vertcat(x1,x2);
    names=vertcat(names,x1);  

    ch=char(names);
    a=ch(:,1:24);               % SAVED AS namelist11_28.mat

%% Vertically concatenate all month files
cd month_files % 2020 has [2 3 5 6 7 8 9 10 11 12]; 2021 has [1 2 3 4 6 7 8 9 10 11 12] ; 2022 has 1:12; 2023 has 1:11
clearvars
source_dir = uigetdir([]); 
d = dir([source_dir, '/*.mat']);
l=height(d);
a=d.name;load(a);
x=TT;
for i=2:l
    k=d(i,:);
    a=k.name;load(a);
    x=[x; TT];
end                         % SAVED AS raw_all.mat

% rows deleted because of poor image/data quality
x(41110,:) = []; % 17 aug 22
x(39699,:) = []; % 20 jul 22
x(39313,:) = []; % 13 Jul 22
x(38486,:) = []; % 28 jun 22
x(37021:37027,:) = []; % 1 jun 22
x(35807:35808,:) = []; % 11 may 22
x(34474,:) = []; % 13 apr 
x(33992,:) = []; x(33988,:) = []; % 31 mar 22
x(33936,:) = []; % 30 mar 22
x(33529:33599,:) = []; % 22-23 mar 22
x(33092:33094,:) = []; x(33046:33051,:) = []; % 14 mar  22
x(33041:33042,:) = []; x(32995:32999,:) = []; % 13 mar 22
x(32963:32965,:) = []; x(32953:32957,:) = []; % 12 mar 22
x(32795,:) = []; x(32765,:) = [];% 8 mar 22
x(32493:32497,:) = []; % 2-3 mar 22
x(32143:32144,:) = []; % 24 feb 22
x(31679,:) = []; % 16 feb 22
x(31656:31661,:) = []; % 15 feb 22
x(31463,:) = []; % 10 feb 22
x(31005:31007,:) = []; % 2 feb 22
x(29790:29794,:) = []; % 12 jan 22
x(28276,:) = []; % 15 dec 21
x(27469,:) = []; % 1 dec 21
x(26663,:) = []; % 17 nov 21
x(25903,:) = []; % 3 nov 21
x(25737:25852,:) = []; % 29 oct - nov 1 21
x(25639,:) = []; % 27 oct 21
x(25244,:) = []; % 20 oct 21
x(24881:24882,:) = []; % 12 oct 21
x(24721:24748,:) = []; % 9-12 oct 21
x(24609:24660,:) = []; x(24546:24591,:) = [];% 6-7-8 oct 21
x(23750,:) = []; % 22 sep 21
x(23315:23317,:) = []; % 13 sep 21
x(22805:23164,:) = []; % 2-10 sep 21
x(22793:22797,:) = []; % 25-30 aug 21
x(22626,:) = []; % 14 jul 21
x(22569:22570,:) = []; % 13 jul 21
x(22042:22048,:) = []; % 30 jun 21
x(21167,:) = []; % 15 jun 21
x(20379:20383,:) = []; % 2 jun 21
x(20318:20342,:) = []; % 24 apr 21
x(19445:19446,:) = []; %2 apr 21
x(19396:19422,:) = []; % 31 mar 21
x(17761,:) = []; x(17751,:) = []; % 3 mar 21
x(17412,:) = []; % 25 feb 21
x(17363,:) = []; % 24 feb 21
x(16940:16954,:) = []; % 17 feb 21
x(15649:15655,:) = []; % 22 jan 21
x(13840,:) = []; % 21 dec 20
x(12943,:) = []; % 4 dec 20
x(11963:11964,:) = []; % 10 nov 20
x(11686:11687,:) = []; % 5 nov 20
x(11574,:) = []; % 4 nov 20
x(10750,:) = []; % 28 oct 20
x(10347:10357,:) = []; % 22 oct 20
x(10217:10219,:) = []; % 21 oct 20
x(9869:9870,:) = []; % 15 Oct 20
x(9460,:) = []; % 7 Oct 20
x(9376:9386,:) = []; x(9345:9354,:) = [];% 20-21-22 sep 20
x(9109,:) = []; % 16 Sep 2020
x(7383,:) = []; % 12 Aug 20
x(6199:6205,:) = []; % 22 Jul 20
x(5668,:) = []; % 10 jul 20
x(5607,:) = []; % 9 jul 20
x(4305,:) = []; % 17 jun 20
x(3062,:) = []; % 28 may 20
x(2326,:) = []; % 11 may 20
x(2208,:) = []; % 9 may 20
x(2145,:) = []; % 8 may 20;             SAVED AS clean_carbon.mat

% This is in UTC, not EST so...
t=x.dnum;
t=datetime(t,'TimeZone','UTC');
t.Format=[t.Format ' z'];
t.TimeZone="America/New_York";
data=table2array(x(:,1));
X=timetable(t,data); %                  SAVED AS cleancarbon_localtime.mat
%% Find sample volumes analyzed
% volumes=zeros(1,height(a));
% for i=1:height(a)
%     N=a(i,:);
%     httpsUrl = "https://ifcb-data.whoi.edu";
%     site='/timeline?dataset=harpswell&bin=';
%     url=strcat(httpsUrl,site,N);
%     site=webread(url); 
%     %get to volume analyzed now
%     volumes(i,1)= 
% end

%% Divide all sample bvs by thier corresponding volume analyzed

% for k=1:height(x)
%     data=x.data;
%     master_data=data(k,:)./volumes(k);
% end
% dnum=all.dnum;
% MASTER=timetable(dnum,master_data);

%% Interpolate raw data

dt = minutes(1); 
mt = retime(X,'regular','linear','TimeStep',dt); % SAVED AS cleancarbon_localtime_interpolated.mat
        

%% Shift 2m current velocity data to along-sound and interpolate
clearvars
% drag in 'raw_cur_2m.tsv'
s=table2array(rawcur2m(:,2:3));
%east=s(:,1)/10;%(mm/s to cm/s)
north=s(:,2)/10;%(mm/s to cm/s)
theta_rot=25; % heading angle of Harpswell Sound determined from google earth pro
rotN=cosd(theta_rot) + sind(theta_rot);
a = north*rotN; %velocity along-sound 
TT=timetable(rawcur2m.dateEST,a);

% Removing fouled velocities measurements
TT(8470,:) = []; % 16 Feb 22
TT(7989,:) = []; % 29 Dec 21
TT(6707,:) = []; % 29 OCt 21
TT(5716,:) = []; % 17 Sep 21
TT(5287,:) = []; % 29 Aug 21
TT(4478,:) = []; % 24 Jul 21
TT(4449,:) = []; % 23 jul 21
TT(4313,:) = []; % 17 Jul 21
TT(4288,:) = []; % 16 Jul 21
TT(4124,:) = []; % 9 Jul 21
TT(4040,:) = []; % 6 Jul 21
TT(3348:3723,:) = []; % Apr-Mar 21
TT(3180,:) = []; % 15 Mar 21
TT(3074,:) = []; % 10 Mar 21
TT(2996,:) = []; % 7 mar 21
TT(2907,:) = [];TT(2894,:) = []; % 3 Mar 21
TT(2906,:) = []; TT(2866,:) = []; TT(2863,:) = [];% 2 Mar 21
TT(2459,:) = []; TT(2453,:) = [];% 13 Feb 21
TT(2364,:) = []; % 9 Feb 21
TT(2271,:) = []; % 5 Feb 21
TT(2009,:) = []; % 25 jan 21
TT(1944,:) = []; % 22 jan 21            SAVED AS clean_alongsoundcur_2m.mat

dt = minutes(1);
A = retime(TT,'regular','linear','TimeStep',dt); % interpolating    
% (this is already in EDT, but this will indicate so)
t=A.Time;
t=datetime(t,'TimeZone','America/New_York');
t.Format=[t.Format ' z'];
t.TimeZone="America/New_York";
data=A.Var1;
A=timetable(t,data); % SAVED AS clean_alongsoundcur_2m_interpolated.mat

%% LOBO currents interpolation (creating 'mc.mat')
clearvars
% drag in 'Sensor0052-20230208114311.tsv'

sensor=table2array(Sensor005220230208114311(:,2:91));
for n=1:30
    U(1,n)=3+(3*(n-1));E(1,n)=1+(3*(n-1));N(1,n)=2+(3*(n-1));x1(1,n)=0;y1(1,n)=n*(-1);end
up=sensor(:,U)/10; %velocity vertical (mm/s to cm/s)
east=sensor(:,E)/10;%(mm/s to cm/s)
north=sensor(:,N)/10;%(mm/s to cm/s)
theta_rot=25; % whatever angle you determine from the map 
rotN=cosd(theta_rot) + sind(theta_rot);
a = north*rotN; %velocity along-sound 

sizea = size(a);
numrows = sizea(1);
numcols = sizea(2);
threshold = 100;
for i = 1:numrows 
    for j = 1:numcols
        if abs(a(i,j)) > threshold
            a(i,j) = 0;
        end 
        if abs(up(i,j)) > threshold
            up(i,j) = 0;
        end       
    end 
end 

time=table2array(Sensor005220230208114311(:,1));time=datenum(time);
for r=1:height(time)
    x(r,1:30)=x1(1,1:30);y(r,1:30)=y1(1,1:30);
end

sz=size(x);acuravg=zeros(sz);upcuravg=zeros(sz);
for h=1:30
    for j=26:height(time)-25
    low=j-25;high=j+25;    
        acuravg(j,h)=mean(a(low:high,h));
        upcuravg(j,h)=mean(up(low:high,h));
    end
end

TT=timetable(Sensor005220230208114311.dateEST,acuravg);

dt = minutes(30);
mc = retime(TT,'regular','linear','TimeStep',dt); % SAVED AS mc.mat

%% temp and sal interpolation (creating 'lobo_retimed.mat')
clearvars
% drag in 'Sensor0052-20230216144947.tsv'

t=table2array(Sensor005220230216144947(:,1));t=datenum(t);
sal=table2array(Sensor005220230216144947(:,2));
temp=table2array(Sensor005220230216144947(:,3));

timestamp=datetime(t,'InputFormat','dd.MM.yyyy HH:mm:ss.SSS','ConvertFrom','datenum');

TT=timetable(timestamp,temp,sal);

dt = minutes(30);
LOBO = retime(TT,'regular','linear','TimeStep',dt);
        
%% Finding high and low (slack) tide times
clearvars
% load clean_alongsoundcur_2m_interpolated.mat
d=A.data;
t=A.t;
i=0;
for l=1:height(d)
     if d(l)>0 & d(l+1)<0
         i=i+1;
            H(i,1)=t(l);
     end
end

i=0;
for l=1:height(d)
     if d(l)<0 & d(l+1)>0
         i=i+1;
            L(i,1)=t(l);
     end
end                        
 f=[H;L];f=sort(f);                   % H and L and f SAVED AS slacktimes_clean_1minres_2m_all.mat

%% Finding taxa carbon values at the slack tide times
clearvars
% load slacktimes_clean_1minres_all.mat
% load cleancarbon_localtime_interpolated.mat 
d=mt.data;
t=mt.t;

[C,ia,ib] = intersect(f,t);
 % C = f(ia,:) and C = t(ib,:)
 slackdata=d(ib,:);

 slacktimedata=timetable(f,slackdata); % SAVED AS slacktimedata.mat
 
 dt = minutes(1);
slacktimedata_interpolated= retime(slacktimedata,'regular','linear','TimeStep',dt); % SAVED AS slacktimedata_interpolated.mat
                    
[C,ia,ib] = intersect(H,t);
 % C = f(ia,:) and C = t(ib,:)
Hdata=d(ib,:);
Htimedata=timetable(H,Hdata);

[C,ia,ib] = intersect(L,t);
 % C = f(ia,:) and C = t(ib,:)
Ldata=d(ib,:);
Ltimedata=timetable(L,Ldata); % Htimedata and Ltimedata SAVED AS separate_slack_timedata.mat

%% Finding the residual carbon (raw minus tidal model)
clearvars
% load cleancarbon_localtime.mat RAW
Xt=X.t;Xdata=X.data;
Xt=Xt(9146:35366);Xdata=Xdata(9146:35366,:); %Constraining IFCB data range to the range of ADCP data
ResultX=dateshift(Xt, 'start', 'minute', 'nearest'); % Round IFCB data to nearest minute to match minute interpolation in tidal model
% load slacktimedata_interpolated.mat TIDAL MODEL
% Removing innaccurate interpolations (flatlines for several days or weeks)
slacktimedata_interpolated(821949:837031,:) = []; % 11-21 Apr 22
slacktimedata_interpolated(692015:733353,:) = []; % Jan 11-Feb 8 22
slacktimedata_interpolated(634234:643467,:) = []; % 1-8 Dec 21
slacktimedata_interpolated(436357:515408,:) = []; % 17 Jul-10 Sep 21
slacktimedata_interpolated(423692:428867,:) = []; % 8-12 Jul 21
slacktimedata_interpolated(267504:402883,:) = []; % 22 Mar-24 Jun 21
slacktimedata_interpolated(114499:187455,:) = []; % 5 Dec 20-25 Jan 21
slacktimedata_interpolated(98121:106247,:) = []; % 24-30 Nov 20
slacktimedata_interpolated(7486:27160,:) = []; % 22 Sep-6 Oct 20
St=slacktimedata_interpolated.f;Sdata=slacktimedata_interpolated.slackdata;


[C,ia,ib] = intersect(ResultX,St);
 % C = ResultX(ia,:) and C = St(ib,:)
 t=ResultX(ia,:);
Raw=Xdata(ia,:);
Model=Sdata(ib,:);
res=Raw-Model;
Residual=timetable(t,res);                      % SAVED AS residual_total.mat

%% Moon data
clearvars
% load moon.mat (data source:
% https://www.timeanddate.com/moon/phases/@4979178)
time=moon(:,1);
dist=moon(:,2);
ilu=moon(:,3)*100;
numrows = height(time);
dithresh = 1; % nan empty data cells
for i = 1:numrows 
        if dist(i,1) < dithresh
            dist(i,1) = nan;
        end 
end
pa=dist/221500; % Include apogee and perigee factor
a=abs((ilu-50))*2; % subtracting 50 so that quarter moons equal 0, then absolute value of full and new moons is 50, multipled by 2 for percentage (0-100) of tidal magnification by spring(100%)-neap(0%) cycle 
s=a./pa;I = ~isnan(time) & ~isnan(s);
time=time(I);s=s(I); % remove nans
timestamp=datetime(time,'InputFormat','dd.MM.yyyy HH:mm:ss.SSS','ConvertFrom','datenum');

TT1=datetime(timestamp,'TimeZone','America/New_York');
TT1.Format=[TT1.Format ' z'];
TT1.TimeZone="America/New_York";
TT2=timetable(TT1,s);

dt = minutes(30);
moon = retime(TT2,'regular','linear','TimeStep',dt); % SAVED AS moon.mat

dt = minutes(1);
moon = retime(moon,'regular','linear','TimeStep',dt); 

moont=moon.timestamp;
moont=datetime(moont,'TimeZone','America/New_York');
moont.Format=[moont.Format ' z'];
moont.TimeZone="America/New_York";
moond=moon.s;
rest=Residual.t;
[C,ia,ib] = intersect(moont,rest);
 % C = moont(ia,:) and C = rest(ib,:)
 t=moont(ia,:);
d=moond(ia,:);
resdata=Residual.res;
rdata=resdata(ib,:);

moonres=table(d,rdata);  % SAVED AS moonintersectresidual.mat

%% Finding raw currents along sound at all depths
clearvars
% drag in 'raw_dur_alldepths.tsv'
sensor=table2array(rawcuralldepths(:,2:91));
for n=1:30
    U(1,n)=3+(3*(n-1));E(1,n)=1+(3*(n-1));N(1,n)=2+(3*(n-1));x1(1,n)=0;y1(1,n)=n*(-1);end
east=sensor(:,E)/10;%(mm/s to cm/s)
north=sensor(:,N)/10;%(mm/s to cm/s)
theta_rot=25; % heading angle of Harpswell Sound determined from google earth pro
rotN=cosd(theta_rot) + sind(theta_rot);
a = north*rotN; % velocity along-sound 
sizea = size(a);
numrows = sizea(1);
numcols = sizea(2);
threshold = 100;
for i = 1:numrows 
    for j = 1:numcols
        if abs(a(i,j)) > threshold
            a(i,j) = 0;
        end   
    end 
end 
time=table2array(rawcuralldepths(:,1));
time=datetime(time,'TimeZone','America/New_York'); % (this is already in EDT, but this will indicate so)
time.Format=[time.Format ' z'];
time.TimeZone="America/New_York";

TT=timetable(time,a); % SAVED AS raw_cur_(alongsound).mat
%% Finding average currents along sound at all depths and interpolating 
clearvars
% drag in 'raw_cur_alldepths.tsv'

sensor=table2array(rawcuralldepths(:,2:91));
for n=1:30
    U(1,n)=3+(3*(n-1));E(1,n)=1+(3*(n-1));N(1,n)=2+(3*(n-1));x1(1,n)=0;y1(1,n)=n*(-1);end
up=sensor(:,U)/10; % velocity vertical (mm/s to cm/s)
east=sensor(:,E)/10; % (mm/s to cm/s)
north=sensor(:,N)/10; % (mm/s to cm/s)
theta_rot=25; % heading angle of Harpswell Sound determined from google earth pro
rotN=cosd(theta_rot) + sind(theta_rot);
a = north*rotN; %velocity along-sound 

sizea = size(a);
numrows = sizea(1);
numcols = sizea(2);
threshold = 100;
for i = 1:numrows 
    for j = 1:numcols
        if abs(a(i,j)) > threshold
            a(i,j) = 0;
        end 
        if abs(up(i,j)) > threshold
            up(i,j) = 0;
        end       
    end 
end 

time=table2array(rawcuralldepths(:,1));
time=datetime(time,'TimeZone','America/New_York'); % (this is already in EDT, but this will indicate so)
time.Format=[time.Format ' z'];
time.TimeZone="America/New_York";
for r=1:height(time)
    x(r,1:30)=x1(1,1:30);y(r,1:30)=y1(1,1:30);
end

sz=size(x);acuravg=zeros(sz);upcuravg=zeros(sz);
for h=1:30
    for j=13:height(time)-13
    low=j-12;high=j+13;  % 25 hour average removes tides (hourly data points)
        acuravg(j,h)=mean(a(low:high,h));
        upcuravg(j,h)=mean(up(low:high,h));
    end
end

TT=timetable(time,acuravg);
TT(26500,:) = []; % remove fouled data (reduntant values for 13 or 14 March due to daylight
TT(20593,:) = []; %savings
dt = minutes(30);
avgcur_alldepths = retime(TT,'regular','linear','TimeStep',dt); % SAVED AS avgcur_alldepths.mat


%% intersect of Temperature and Salinity data with residual
clearvars
% drag in 'LOBO_tempsal.tsv'
lo=LOBOtempsal(24830:36338,:);
% removing fouled data (salinity<10 PSU)
lo(10284,:) = []; % 18 mar 22
lo(10155,:) = []; % 13 mar 22 (daylight savings)
lo(7758,:) = [];  % 29 Oct 21
lo(5723,:) = []; % 3 aug 21
lo(3854,:) = []; % 14 mar 21 (daylight savings)
lo(2594,:) = []; % 20 jan 21

t=lo.dateEST;t=datetime(t,'TimeZone','America/New_York');
t.Format=[t.Format ' z'];
t.TimeZone="America/New_York";

sal=lo.salinityPSU;
temp=lo.temperatureC;

TT=timetable(t,temp,sal); % SAVED AS LOBO_timetempsal.mat

dt = minutes(1);
LOBO = retime(TT,'regular','linear','TimeStep',dt);

lobot=LOBO.t;
temp=LOBO.temp;
sal=LOBO.sal;

% load Residual.mat
rest=Residual.t;
[C,ia,ib] = intersect(lobot,rest);
 % C = lobot(ia,:) and C = rest(ib,:)
 t=lobot(ia,:);
temperature=temp(ia,:);
salinity=sal(ia,:);
resdata=Residual.res;
rdata=resdata(ib,:);

tempsalres=table(temperature,salinity,rdata);  % SAVED AS temp_sal_residual.mat

%% biomass versus abs(current velocity 2 m)
clearvars
%load clean_alongsoundcur_2m_interpolated.mat
%load cleancarbon_localtime.mat
pdata=X.data;
ptime=X.t;
ptime=dateshift(ptime, 'start', 'minute', 'nearest'); % Round IFCB data to nearest minute to match minute interpolation in tidal model
cdata=A.data;
ctime=A.t;

[C,ia,ib] = intersect(ptime,ctime);
 % C = ptime(ia,:) and C = ctime(ib,:)
 t=ptime(ia,:);
Pdata=pdata(ia,:);
Cdata=cdata(ib,:);

current_biomass=table(Cdata,Pdata);   % SAVED AS cur_biomass.mat




%% summary timetable (all variables)
clearvars
% load cleancarbon_localtime.mat 
% load slacktimedata.mat
% load separate_slack_timedata.mat
% load clean_alongsoundcur_2m_interpolated.mat
% load slacktimedata_interpolated.mat & residual.mat

M=synchronize(X,slacktimedata,Htimedata,Ltimedata,A,slacktimedata_interpolated,Residual);

% M SAVED AS master.mat

% % %% Find daily means of BV
% cd month_files
% for y=20:23
%     for m=1:12
%         if m<10
%             j=strcat('0',m);
%             n=strcat(y,'-',j,'.mat');
%         load n
%         end
%         n=strcat(y,'-',m,'.mat');
%         load n
%         all=all+TT;
%     end 
% end
% bv=all.data;
% time=all.time;
% data=zeros(height(all),97);
% for j=26:height(all)-25
%     x=j-25;y=j+25;
%         data(j,:)=mean(bv(x:y,:));
% end
% save('daily.mat','data','time');
% 

%plot(slacktimedata_interpolated.f,slacktimedata_interpolated.slackdata,"k")