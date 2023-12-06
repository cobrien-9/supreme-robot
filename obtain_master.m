%% Download files in 'filename' and 'fname' character array
% We have not downloaded files for June 2022 and onward yet

%% Download files without filename (query all possible file names)
% 
% %v2
% clearvars 
% %cd month folder on desktop
% Y='2021';
% M='03'; %
% serial=[125 124 110];
% for D=1:8
%     DS=num2str(D); if D<10, DS=['0',num2str(D)];end
%     for H=0:23; HS=num2str(H); if H<10, HS=['0',num2str(H)];end % SET TO 0:23
%       for m=0:59; mS=num2str(m); if m<10, mS=['0',num2str(m)];end
%           for s=0:59 Ss=num2str(s);if s<10, Ss=['0',num2str(s)];end
% for in=1:3
%               filein=['D',Y,M,DS,'T',HS,mS,Ss,'_IFCB',num2str(serial(in)),'_class_scores.csv']
% httpsUrl = "https://ifcb-data.whoi.edu";
% site='/harpswell/';
% durl=strcat(httpsUrl,site,filein);
%     try
%     data125 = webread(durl);
%     catch ME
%         if strcmp(ME.identifier,'MATLAB:webservices:HTTP404StatusCodeError');
%             fprintf(ME.message),end
%         data125=1;
%     end
% if size(data125,1)>1,writetable(data125,filein);end
% clear durl data125
% end%serial
%           end%seconds
%       end%minutes
%     end%hours
% end%days

%% v1
clearvars 
%cd /Volumes/cobrien/summer2
Y='2021';
M='07'; %
for D=13:17
    DS=num2str(D); if D<10, DS=['0',num2str(D)];end
    for H=0:23; HS=num2str(H); if H<10, HS=['0',num2str(H)];end % SET TO 0:23
      for m=0:59; mS=num2str(m); if m<10, mS=['0',num2str(m)];end
          for s=0:59 Ss=num2str(s);if s<10, Ss=['0',num2str(s)];end

              filein=['D',Y,M,DS,'T',HS,mS,Ss,'_IFCB124_class_scores.csv']
httpsUrl = "https://ifcb-data.whoi.edu";
site='/harpswell/';
durl=strcat(httpsUrl,site,filein);
    try
    data125 = webread(durl);
    catch ME
        if strcmp(ME.identifier,'MATLAB:webservices:HTTP404StatusCodeError');
            fprintf(ME.message),end
        data125=1;
    end
if size(data125,1)>1,writetable(data125,filein);end
clear durl data125
          end%seconds
      end%minutes
    end%hours
end%days

%% v2 

clearvars
source_dir = uigetdir([]); 
d = dir([source_dir, '/*scores.csv']);
l=height(d);
name = {d.name}.';
C=cellfun(@(x) x(1:24), name, 'UniformOutput', false); % SAVE C TO month_files
% a='_features.csv';
% n=strcat(C,a);

%% Classification files
clearvars
load('MASTER_2020.mat'); % This is the cell array naming files
for i=12780:13333 % Index rows for month desired
    filein=[char(C(i)),'_class_scores.csv'];
    httpsUrl = "https://ifcb-data.whoi.edu";
    site='/harpswell/';
    durl=strcat(httpsUrl,site,filein);
    try
    data125 = webread(durl);
    catch ME
        if strcmp(ME.identifier,'MATLAB:webservices:HTTP404StatusCodeError')
            fprintf(ME.message),end
        data125=1;
    end
if size(data125,1)>1,writetable(data125,filein);end
clear durl data125
end

%% features files

%load('MASTER_2022.mat'); % This is the cell array naming files
for i=1:733 % Index rows for month desired
    filein=strcat(C(i),'_features.csv');
    httpsUrl = "https://ifcb-data.whoi.edu";
    site='/harpswell/';
    durl=strcat(httpsUrl,site,filein);
    filein=char(filein);
    try
    data125 = webread(durl);
    catch ME
        if strcmp(ME.identifier,'MATLAB:webservices:HTTP404StatusCodeError')
            fprintf(ME.message),end
        data125=1;
    end
if size(data125,1)>1,writetable(data125,filein);end
clear durl data125
end

%% Fetching files from downloads and renaming
cd downloads
clearvars
source_dir = uigetdir([]); 
d = dir([source_dir, '/*vNone.csv']); 
for i=1:height(d)
    d2=d(i).name;
    e=strcat((d2(1:30)),'_scores.csv');
    movefile(d2,e)
end

%% features files special

clearvars
source_dir = uigetdir([]); 
d = dir([source_dir, '/*scores.csv']);
for i=503:height(d)  % Index rows for month desired
    d2=d(i).name;
    filein=strcat((d2(1:24)),'_features.csv');
    httpsUrl = "https://ifcb-data.whoi.edu";
    site='/harpswell/';
    durl=strcat(httpsUrl,site,filein);
    filein=char(filein);
    try
    data125 = webread(durl);
    catch ME
        if strcmp(ME.identifier,'MATLAB:webservices:HTTP404StatusCodeError')
            fprintf(ME.message),end
        data125=1;
    end
if size(data125,1)>1,writetable(data125,filein);end
clear durl data125
end
