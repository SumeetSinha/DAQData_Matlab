Matlab Version (minimum R2018b) 
--------------------------------

You should be able to extract and read data from the binary files with the code that I shared with you last time (also attached here). The shared archived folder consist of two Matlab files:
 

LoadData.m – contains the code for reading the binary file and loading sensor data in the memory. The variables corresponding to the sensor name starts with “V_” followed by the sensor name. If the sensor name (in excel config file) has any spaces or dash, the corresponding characters in sensor variable name is replaced with underscore ‘_’.

ProcessData.m – it is the main program where actual manipulation is done. It specifies the filename, calls the LoadData.m to load the sensor data. The load can then be further manipulated as per the user.