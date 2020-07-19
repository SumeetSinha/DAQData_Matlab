% Coded by: Sumeet Kumar Sinha (sumeet.kumar507@gmail.com)
% PhD Student, UC Davis

function [varargout]=fnc_binToTxt(filename,inputDirectory,outputDirectory)

Output_File =fopen([outputDirectory,filename(1:end-4),'.txt'],'w');
Input_File  =fopen([inputDirectory,filename],'r','b','Macintosh');
Line_Data =fgetl(Input_File); % Chanel info

%% Read the channels name
while isempty(strfind(Line_Data,'[channel name list]')) %loops through the header information until we get to the instrument names
    Line_Data = fgetl(Input_File);
end
Line_Data    = fgetl(Input_File); % Instrument channel
Channel_List = Line_Data;
Channel_List = textscan(Line_Data,'%s','delimiter',',');
Channel_List = Channel_List{1};
Number_of_Channels=length(Channel_List);
Number_of_Data_Columns = Number_of_Channels;

%% Read the sensors name
while isempty(strfind(Line_Data,'[Xdcr Serial Numbers]')) %loops through the header information until we get to the sensors name
    Line_Data = fgetl(Input_File);
end
Line_Data = fgetl(Input_File); % Instrument name
Sensor_List = Line_Data;
Sensor_List = textscan(Line_Data,'%s','delimiter',',');
Sensor_List = Sensor_List{1};
Number_of_Sensors=length(Sensor_List);

%% Get the sampling Frequency
Line_Data = fgetl(Input_File);
FlagSampFreq=0;
Sampling_Frequency = 1;
Number_of_Excel_Config_Lines = Number_of_Channels-1;
while isempty(strfind(Line_Data,'[data]'))

    %% Read the excel configuration file
    if ~isempty(strfind(Line_Data,'[excelconfig]')) %loops through the header information until we get to the configuration name
        
        if FlagSampFreq==1
            Number_of_Excel_Config_Lines = Number_of_Channels+1;
            Number_of_Data_Columns       = Number_of_Channels+1;
        end

        for i =1:Number_of_Excel_Config_Lines
            Line_Data = fgetl(Input_File); % Number of instruments
            Config_File{i} = Line_Data;
        end
    end

    if ~isempty(strfind(Line_Data,'[sampling rate]'))
        Sampling_Frequency = fread(Input_File,[1 1],'single','s'); % sampling rate
        FlagSampFreq=1;
    end


    Line_Data=fgetl(Input_File);
end

% if FlagSampFreq==1
%     Number_of_Data_Columns = Number_of_Channels + 1;
% end

%% Print sampling frequency
fprintf(Output_File,'Sampling Frequency, %d\n',Sampling_Frequency);
fprintf(Output_File,'Number of Channels, %d\n',Number_of_Channels);
fprintf(Output_File,'Number of Sensors, %d\n',Number_of_Sensors);
fprintf(Output_File,'Number of Excel Config Lines, %d\n',Number_of_Excel_Config_Lines);
fprintf(Output_File,'Number of Data Columns, %d\n',Number_of_Data_Columns);


%% Print configuration file
for i =1:Number_of_Excel_Config_Lines
    fprintf(Output_File,' %s\n',Config_File{i});
end

%% Print channel list
if FlagSampFreq==1
    fprintf(Output_File,'TIME, ');
end
for i =1:Number_of_Channels
    fprintf(Output_File,' %s,',Channel_List{i});
end
fprintf(Output_File,'\n');

%% Print sensors list
if FlagSampFreq==1
    fprintf(Output_File,'TIME, ');
end
for i =1:Number_of_Sensors
    fprintf(Output_File,' %s,',Sensor_List{i});
end
fprintf(Output_File,'\n');

% ftell(Input_File);

%% Read the data
tempdata= fread(Input_File, [Number_of_Channels, inf],'single','s')';% read data

if(FlagSampFreq==1)
    Number_of_Channels = Number_of_Channels+1;
    time=(0:1:length(tempdata(:,1))-1)*1/Sampling_Frequency;
    data(:,1)=time';
    data(:,2:Number_of_Channels)=tempdata(:,1:end);
else
    data(:,1:Number_of_Channels)=tempdata(:,1:end);
end

%% Write the data
format='%20.12f,';
FORMAT='';
for i =1:Number_of_Channels-1
    FORMAT=strcat(FORMAT,format);
end
FORMAT=strcat(FORMAT,format,'\n');
fprintf(Output_File,FORMAT,data(:,1:Number_of_Channels).');

fprintf(' - %s converted \n', filename)

%% Close the file
fclose(Input_File);
fclose(Output_File);

end