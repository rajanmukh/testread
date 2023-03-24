function retval=readData()
%WAITFORDATAAVAILABILITY Summary of this function goes here
%   Detailed explanation goes here
global available;
global groupindex;
global groupfolderpath;
global channelsGroup;
global channelindices;
global newfiles;
global fID;
global timestamp;
global dbuf;
global readingOver;
global UNSUCCESSFUL;
global SUCCESSFUL;
global fname;
global fileTime;
global files1;

payLoadLength = 131072;


if fID ==-1
    waitseconds = 0;
    while(true)
        %change group index;
        if groupindex == 1
            groupindex=2;
        else
            groupindex=1;
        end
        
        if ~available&& groupindex == 1
            %inspecting the directory for availability
            files1=dir(strcat(groupfolderpath{1,groupindex},'*.bin'));
            currnoOffile=length(files1);
            count=0;
            offset=0;
            for fidx=1:currnoOffile
                if files1(fidx-offset).datenum>fileTime
                    count=count+1;
                else
                    files1(fidx--offset)=[];
                    offset=offset+1;
                end
            end
            newfiles=count;
            available=newfiles>1;
        end
        %         if ~available(2) && groupindex == 2
        %             files2=dir(strcat(groupfolderpath{1,groupindex},'*.bin'));
        %             currnoOffile=length(files2);
        %             count=0;
        %             for fidx=1:currnoOffile
        %                 if files2(fidx).datenum>fileTime(groupindex)
        %                     count=count+1;
        %                 else
        %                     files2(fidx)=[];
        %                 end
        %             end
        %             newfiles(groupindex)=count;
        %             available(groupindex)=newfiles(groupindex)>1;
        %         end
        %
        
        if available
            if groupindex == 1
                %name forming logic
                minVal=files1(1).datenum;idx=1;
                for i=2:newfiles
                    if files1(i).datenum <minVal
                        minVal=files1(i).datenum;
                        idx=i;
                    end
                end
                fname=files1(idx).name; 
                fileTime=files1(idx).datenum;
                files1(idx)=[];
                
            end
            fID = fopen(strcat(groupfolderpath{1,groupindex},fname),'r');strcat(fname, "  ",num2str(groupindex))
            channelindices = channelsGroup{groupindex};
            break;
        end
        %         if available(2) && groupindex == 2
        %             %name forming logic
        %             minVal=files2(1).datenum;idx=1;
        %             for i=2:newfiles(2)
        %                 if files2(i).datenum <minVal
        %                     minVal=files2(i).datenum;
        %                     idx=i;
        %                 end
        %             end
        %
        %             fname=strcat(groupfolderpath{1,2},files2(idx).name);files2(idx).name
        %             fileTime(groupindex)=files2(idx).datenum;
        %             files2(idx)=[];
        %             fID = fopen(fname,'r');
        %             channelindices = channelsGroup{2};
        %             break;
        %         end
        
        if ~available
            if waitseconds >=.1
                readingOver = true;
                break;
            end
            pause(.1)
            waitseconds=waitseconds+.1;
        end
    end
end
if fID~=-1
    fileendflag = false;
    [timeinfo,count]=fread(fID,[1 60],'uint8');
    if count==60
        timestamp(1,groupindex)=timeinfo(45);%year
        timestamp(2,groupindex)=timeinfo(49)+256*timeinfo(50);%day
        timestamp(3,groupindex)=timeinfo(46);%hour
        timestamp(4,groupindex)=timeinfo(47);%minute
        timestamp(5,groupindex)=timeinfo(48)+0.001*timeinfo(51)+0.256*timeinfo(52)+(1e-6)*timeinfo(53)+(256e-6)*timeinfo(54)+(1e-9)*timeinfo(55)+(256e-9)*timeinfo(56);
        
        [dbuf,count]=fread(fID,[1 payLoadLength],'int16');
        %         computation delay
        
        if count~=payLoadLength
            fileendflag=true;
        end
    else
        fileendflag=true;
    end
    if fileendflag
        fclose(fID);
%         delete(strcat(groupfolderpath{1,groupindex},fname));
        fID=-1;
        newfiles=newfiles-1;
        if(newfiles<=1)
            available=false;
        end
    end
end

if fID == -1 || fileendflag == true
    retval = UNSUCCESSFUL;
else
    retval = SUCCESSFUL;
end
end

