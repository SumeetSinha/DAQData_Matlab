% Credits 
% Updated by Sumeet Kumar Sinha (PhD Student, UC Davis) - 02/26/2020
% Modified code from Trevor Carey (PhD Student, UC Davis)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Modified code from Trevor Carey (PhD Student, UC Davis)
% LoadData is the function to read the binary file 
% and load all the sensor data in the memory
% - The variable names corresponding to the sensors start with 'V_'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

FID=fopen(filename);

nextline = fgetl(FID);  % Read in 1st line in file
SampFreq = 1;

% Loop through file until [sampling rate] tag is found
while (isempty(strfind(nextline,'[sampling rate]')) && num2str(nextline)~="-1")
    nextline = fgetl(FID);
end

if(num2str(nextline)~="-1")   
  % Define sampingFreq file was collected with 
  SampFreq = fread(FID,[1 1],'single','s'); % sampling rate {Hz}
else
  frewind(FID)    % Reset to beginning of file 
end

% Loop through file until [excelconfig] tag is found
while isempty(strfind(nextline,'[excelconfig]'))
    nextline = fgetl(FID);
end

% Define [excelconfig] headers and find index of Xdcr Location ID
header = strsplit(fgetl(FID),',');
idx = find(strcmp(header,'Xdcr Location ID'));
j = 0;  % Initialize counter

if(SampFreq==1)
  ID{1,1} = 'TIME';
  ID{2,1} = 'RPM';
  j=2;
end

% Loop through [excelconfig] info and extract IDs 
while isempty(strfind(nextline,'[data]'))        
    j = j+1; % Increase counter
    temp =  strsplit(fgetl(FID),',');   % Split nxt line at delim
    if strcmp(temp{1},'')   % Exit loop when a blank line encountered 
        break
    end
    ID{j,1} = temp{idx}; % Store ID
end

N = length(ID);    % Total number of sensors 
frewind(FID)    % Reset to beginning of file 

% Loop through file until [data] tag is found 
while isempty(strfind(nextline,'[data]'))
    nextline = fgetl(FID);
end

% Read binary data and transpose into column format
data = fread(FID, [N, inf],'single','s'); 

% Create time vector 
Time = (0:1:length(data(1,:))-1)*(1/SampFreq);  % {sec}


lenID=length(ID);

for i=1:1:lenID
  id = string(ID{i,1});

  % replacing dash (-) with underscore (_) in sensor names
  id = id.replace("-","_");
  % replacing spaces () with underscore (_) in sensor names
  id = id.replace(" ","_");
  % adding a alphabet "V_" in case the sensor name starts with a number  
  id = "V_" + id;

  namesensor=sprintf('%s',id);
  expression=sprintf("%s = data(%i,:)",namesensor,i);
  evalc(expression);
  
end

Sensor_ID = ID; % list of sensor ids

% clear useless variables
clear idx N;
clear expression;
clear id ID header FID;
clear lenID;
clear namesensor;
clear nextline;
clear temp;
clear data;
clear i j;
