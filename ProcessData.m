clc; clear all; close all;

%User Inputs
%filename='07052019@140737@140838@999.0rpm.bin' ; %fastdata filename
%filename='07052019@140737.bin' ; %slow data filename
filename='01292020@144006.bin' ; %slow data filename

% load the data in the memory with variables as sensor names appended with character "V_"
% requires LoadData.m in the working directory
LoadData


%Now you can manipulate the sensor data
% Here I am plotting the data as an example 
% plot(Time, V_LP_493,'k')
% plot(Time, V_LP_312,'r')
% xlabel("Time[s]")
% ylabel("Displacement [mm]") 
