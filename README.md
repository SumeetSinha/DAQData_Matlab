# DAQData_Matlab
Read and plot binary data files of centrifuge tests conducted at Center for Geotechnical Modeling at @UCDavis

## Requirements
Matlab Version (> R2018b) 

## Instructions to use

The shared archived folder consist of two Matlab files:
 

1) *LoadData.m* – contains the code for reading the binary file and loading sensor data in the memory. The variables corresponding to the sensor name starts with “V_” followed by the sensor name. If the sensor name (in excel config file) has any spaces or dash, the corresponding characters in sensor variable name is replaced with underscore ‘_’.

2) *ProcessData.m* – it is the main program where actual manipulation is done. It specifies the filename, calls the LoadData.m to load the sensor data. The load can then be further manipulated as per the user.

3) *Script_Bin_To_Text* - contains the Matlab script for converting the binary data files to text files. 