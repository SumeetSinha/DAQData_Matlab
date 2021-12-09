[![DOI](https://zenodo.org/badge/243871097.svg)](https://zenodo.org/badge/latestdoi/243871097) [![View DAQData_Matlab on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/103300-daqdata_matlab)

# DAQData_Matlab
Read and plot binary data files of centrifuge tests conducted at Center for Geotechnical Modeling at @UCDavis

## Requirements
Matlab Version (> R2018b) 

## Instructions to use

The shared archived folder consist of two Matlab files:
 

1) *LoadData.m* – contains the code for reading the binary file and loading sensor data in the memory. The variables corresponding to the sensor name starts with “V_” followed by the sensor name. If the sensor name (in excel config file) has any spaces or dash, the corresponding characters in sensor variable name is replaced with underscore ‘_’.

2) *ProcessData.m* – is the main program where actual manipulation is done. It specifies the filename, calls the LoadData.m to load the sensor data. The load can then be further manipulated as per the user.

3) *Script_Bin_To_Text* - contains stand alone Matlab scripts for converting the binary data files to text files. The scripts can be used to convert more than one binary files to text files. Steps to use the 

	- Just place all the binary files in the Test/BinFile directory
	- Run ConvertBinaryToTextFile.m
	- The corresponding text files are converted in Test/TXTFile directory

---

Send your comments, bugs, issues and features to add to [Sumeet Kumar Sinha](http://www.sumeetksinha.com) at sumeet.kumar507@gmail.com.
