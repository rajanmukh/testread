function initializeVars()
%INITIALIZEVARS Summary of this function goes here
%   Detailed explanation goes here
global groupfolderpath;
groupfolderpath=cell(1,2);
groupfolderpath{1,1}='data1\';
% groupfolderpath{1,1}='';
groupfolderpath{1,2}='data2\';
global available;
available = false;
global fileTime;
fileTime=0;
global channelsGroup;
channelsGroup = cell(1,2);
channelsGroup{1}=1:4;%;
channelsGroup{2}=[];
global channelindices;
global chn;
global for_1st_gen;
for_1st_gen=1;
global for_2nd_gen;
for_2nd_gen=2;
global intervalCntr;
intervalCntr = 1*ones(1,2);
global cbiArr1;
cbiArr1=ones(1,2);
global cbiArr2;
cbiArr2=ones(1,2);
global packet;
packet=zeros(1,644,'uint8');
packet(1)=35;packet(2)=35;packet(3)=35;packet(4)=35;
packet(641)=38;packet(642)=38;packet(643)=38;packet(644)=38;
packet(5)=26;
global sock;
sock = tcpip('192.168.4.150',5008);
sock.OutputBufferSize = 1024;
% fopen(sock);
global groupbuffer;
global groupID;
global groupTOA;
global grRd;
global grWrt;
global groupBtypeList;
grRd=1;
grWrt=1;
groupbuffer = cell(7,8,100);%8 fields in each beacon info , 8 no of channels , 100 = max no of groups at a time
groupID = zeros(1,100,'int64');
groupTOA = zeros(1,100);
groupBtypeList = zeros(1,100);
global TOAList;
global IDList;
global btypeList;
global countList;
global rd;
global wrt;

rd=1;
wrt=1;
TOAList = zeros(1,10000);
IDList = zeros(1,10000,'int64');
btypeList = zeros(1,10000);
countList = zeros(1,10000);

global invalidmsgbuffer;
global invalidmsgTOA;
global invalidmsgID;
global invalidmsgBtype;
global validFlag;
global emptyflag;
global anyValidMsg;
global anyInvalidMsg;
invalidmsgbuffer=cell(7,10);
invalidmsgTOA=zeros(1,10);
invalidmsgID=zeros(1,10,'int64');
invalidmsgBtype=zeros(1,10);
validFlag=zeros(1,10,'logical');
emptyflag=ones(1,10,'logical');
anyValidMsg=false;
anyInvalidMsg=false;

%for 2nd gen message association
global HexID23;
HexID23=zeros(1,92);
HexID23(1)=1;
HexID23(12)=1;
HexID23(13)=0;
HexID23(14)=1;
HexID23(92)=1;
global groupID21;
global groupID22;
global groupTOA2;
global groupbuffer2;
global grRd2;
global grWrt2;
groupID21 = zeros(1,100);
groupID22 = zeros(1,100);
groupTOA2 = zeros(1,100);
groupbuffer2 = cell(7,8,100);%8 fields in each beacon info , 8 no of channels , 100 = max no of groups at a time
grRd2=1;
grWrt2=1;

global failedbuffer;
global failedRdlim;
global failedWrt;
global failedRd;
failedbuffer=cell(4,8,10);
failedRdlim=ones(1,8);
failedRd=failedRdlim;
failedWrt=ones(1,8);

global dec1;
global dec2;
global dec3;
dec1 = comm.BCHDecoder(82,61);
dec2 = comm.BCHDecoder(38,26);
dec3 = comm.BCHDecoder(250,202);
global enc1;
global enc2;
global enc3;
enc1 = comm.BCHEncoder(82,61);
enc2 = comm.BCHEncoder(38,26);
enc3 = comm.BCHEncoder(250,202);
global timestamp;
timestamp=zeros(5,2);
global groupindex;
groupindex=2;
global fID;
fID=-1;
global iqbufWpt;
iqbufWpt=ones(1,2);
global iqbufRpt1;
iqbufRpt1=ones(1,2);
global iqbufRpt2;
iqbufRpt2=ones(1,2);


totalchannels=8;
global noOfBlocks;
noOfBlocks=40;
global bufsize;
bufsize=3072*noOfBlocks;%100000;
global IQsn;
IQsn=zeros(bufsize,totalchannels,'single');
bitlength=24;
chiplength=2*bitlength;
global multiplier;
multiplier=zeros(chiplength,1);
global symbol;
symbol=cos(1.1)+1i*sin(1.1);
global Fs;
Fs=93750;
% global bits;

global arr;
arr=(1:3072)';
% global flattop;
global prdgram;
global prdgramsum;
% flattop=zeros(3072,noOfBlocks);
prdgram=zeros(3072,noOfBlocks,totalchannels,'single');%for storing fft summary of datablocks
prdgramsum=zeros(3072,noOfBlocks,totalchannels,'single');
global decisionPrev;
decisionPrev=zeros(3072,totalchannels,'single');


global IQreffftOP;
global IQreffft1OP;
global IQreffft2OP;
global preambleOP;
global IQreffftTest;
global IQreffft1Test;
global IQreffft2Test;
global preambleTest;
preambleOP=  [1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,1,0,1,1,1,1].';
preambleTest=[1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,1,1,0,1,0,0,0,0].';


global indexAtstamp;
indexAtstamp=zeros(1,2);

end

