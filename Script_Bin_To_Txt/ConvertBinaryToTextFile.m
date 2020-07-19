% Coded by: Sumeet Kumar Sinha (sumeet.kumar507@gmail.com)
% PhD Student, UC Davis


% Bin to Txt Script
P.directory='Test';  % You should make a directory, and make two other 
                     % subdirectory, one should be named 'BINFile', and the other 'TXTFile'. 
                     % You should copy all your binary files into the
                     % 'BINFile directory, and you will have the text
                     % files into the 'TXTFile' one.
                     % The code should be outside your main directory.
allFiles=dir([P.directory,'\BINFile\*.bin']);
for i=1:length(allFiles)
    try
        fnc_binToTxt(allFiles(i).name,[P.directory,'\BINFile\'],[P.directory,'\TXTFile\']);
    catch err
        comment=sprintf('Following file has error %s. Error is %s',allFiles(i).name,err.message)
    end
    
end
comment='File conversion complete!'

