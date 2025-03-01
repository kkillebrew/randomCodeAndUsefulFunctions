clear all
close all

% load in the txt file and skip the first three lines
% fileID=fopen('cc_20140925_114801_fil_seg.log');
% formatSpec='%s %s %s';
% textout=textscan(fileID,formatSpec,Inf,'headerLines',3);
% 
% % make two arrays from the array containing the labels and times
% labels=textout{1};
% times=textout{7};

% To pull exactly the first x columns from a txt file
fileID=fopen('cc_20140925_114801_fil_seg.log');
formatSpec='%s %s %s';

counter = 1;
while 1
    textout{counter+1}=textscan(fileID,formatSpec,1,'Headerlines',counter);
    if isempty(textout{counter+1})
       break 
    end
    counter = counter + 1;
end
textout = textout';

% % format the numbers
% for i=1:length(times)
%     bob=times{i};
%     bob=str2double(bob(1:2))*60*60+str2double(bob(4:5))*60+str2double(bob(7:length(bob)));
%     times{i}=num2str(bob);
% end
% 
% % change the array into doubles
% icarenums=str2double(times);
% 
% % calculate the timing difference
% counter=1;
% for i=2:2:length(icarenums)
%     diffarray(counter)=icarenums(i)-icarenums(i-1);
%     counter=counter+1;
% end
% 
% % calculate the mean
% meandiff=mean(diffarray);
% fclose('all');