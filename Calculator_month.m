%% Code to process biovolume data into a month-long file
clearvars
source_dir = uigetdir([]); % current folder with both class and feature files for each timestamp
d = dir([source_dir, '/*scores.csv']); % class data
a = dir([source_dir, '/*features.csv']); % feature data
l=length(d);

data=zeros(l,97); % master biovolume record for the month (number of rows)
for k = 1:l
    c=d(k).name;s=readtable(c);s=s(:,2:98);s=table2array(s); % class data
    f=a(k).name;b=readtable(f);b=b(:,3);b=table2array(b); % feature data
                x=zeros(1,97); % value-to-add array
                v=zeros(1,97); % sum array
                [m,I]=max(s,[],2); % finding the maximum likelihood column
                for j=1:height(s)
                    x(1,I(j,1))=b(j,1); % array for biovolume value to add in correct column
                    v=x+v; % adding the biovolume value to the sum array
                    x=zeros(1,97); % reseting the value-to-add array to zero
                end 
                data(k,1:97)=v; % adding summed biovolumes to the master record
end
time = arrayfun(@(a) a.name,d,'UniformOutput',false);
j=table(data,time); % save this file

%% Code to process biovolume data into a month-long file for carbon
clearvars
source_dir = uigetdir([]); % current folder with both class and feature files for each timestamp
d = dir([source_dir, '/*scores.csv']); % class data
a = dir([source_dir, '/*features.csv']); % feature data
l=length(d);

diatoms=[4 5 7 11 13 15 16 17 18 19 25 26 27 33 34 35 37 42 44 45 49 50 53 57 64 67 69 70 73 74 94];
all=zeros(l,97); % master carbon record for the month 
for k = 1:l
 c=d(k).name;s=readtable(c);s=s(:,2:98);s=table2array(s); % class data
 f=a(k).name;b=readtable(f);b=b(:,3);b=table2array(b); % feature data
                check1=zeros(1,97); % check array
                x=zeros(1,97); % value-to-add array
                v=zeros(1,97); % sum array
                [m,I]=max(s,[],2); % finding the maximum likelihood column
                for j=1:height(s)
                    check1(1,I(j,1))=b(j,1);             
                        if max(check1(1,diatoms))>0 % Is the image of a diatom?
                        x(1,I(j,1))=0.288*(b(j,1))^0.811; % array for diatom carbon value to add in correct column
                        else
                        x(1,I(j,1))=0.216*(b(j,1))^0.939; % array for non-diatom carbon value to add in correct column
                        end
                    v=x+v; % adding the carbon value to the sum array
                    x=zeros(1,97); % reseting the value-to-add array to zero
                    check1=zeros(1,97); % reseting the check array to zero
                end 
                all(k,1:97)=v; % adding summed carbon to the master record
end

time = arrayfun(@(a) a.name,d,'UniformOutput',false);
j=table(all,time); % save this file
%% making a timetable
% add file "j" made above 
t=table2array(j(:,2)); 
h=height(t);

for i=1:height(j)
    n=t(i);n=char(n);
    Y=n(2:5);
    M=n(6:7);
    D=n(8:9);
    H=n(11:12);
    MI=n(13:14);
    S=n(15:16);
    d=strcat(Y,'-',M,'-',D,{' '},H,':',MI,':',S);
    dnum(i,1)=datetime(d,'InputFormat','yyyy-MM-dd HH:mm:ss');
end

data=table2array(j(:,1));
TT=timetable(dnum,data); % SAVE TT to 