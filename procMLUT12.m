

global chn;
global channelindices;
global for_1st_gen;
global for_2nd_gen;
global readingOver;readingOver=false;
global UNSUCCESSFUL;
global SUCCESSFUL;
global count1;
global count2;
global count3;
global count4;
global count5;
global count6;
global count7;
% noErr1=zeros(200,8);
% noErr2=zeros(200,8);
% load('refdata2.mat');
initializeVars();
detStat = false;
confStat=false;
demodStat=false;
decodeStat=false;
noiseFloor=zeros(10000,1);
tic
while true
    readStat=readData();
    if readingOver
        break;
    elseif readStat == UNSUCCESSFUL
        continue;
    end   
end

