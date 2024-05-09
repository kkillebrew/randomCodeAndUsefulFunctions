clear all
close all

HideCursor;
ListenChar(2);

[w,rect]=Screen('OpenWindow',0,[128 128 128],[0 0 1024 768]);
xc=rect(3)/2;
yc=rect(4)/2;

%dots
% while ~KbCheck

% for making video
counter=1; %absoulutely necessary. Keeps track of your movie frames
starttime=GetSecs;

offSet = 150;
xcl=xc-offSet;
xcr=xc+offSet;
ycu=yc-offSet;
ycd=yc+offSet;

r=50;
dr=10;
speed=pi/50;

breakcounter = 0;

speedCounter = pi;

origXCL = xcl+r*cos(speedCounter)-dr;

% array = 128*ones(r*4+dr,r*4+dr);
% texture = Screen('MakeTexture',w,array);
% 
% while ~KbCheck
%     
%     Screen('FrameOval',texture,[0 0 0],[0 0 r*2 r*2],5);
%     Screen('FrameOval',texture,[0 0 0],[r*2+dr r*2+dr r*4+dr r*4+dr],5);
%     Screen('DrawTexture',w,texture,[],textRect(1),);
%     Screen('Flip',w);
%     
% %     
% end


while 1

    if origXCL == xcl+r*cos(speedCounter)-dr
        breakcounter = breakcounter + 1;
    end


    
    Screen('FillOval',w,[0 0 0],[xcl+r*cos(speedCounter)-dr,ycu+r*sin(speedCounter)-dr,xcl+r*cos(speedCounter)+dr,ycu+r*sin(speedCounter)+dr]);
    Screen('FillOval',w,[0 0 0],[xcl+r*cos((speedCounter)-pi)-dr,ycu+r*sin((speedCounter)-pi)-dr,xcl+r*cos((speedCounter)-pi)+dr,ycu+r*sin((speedCounter)-pi)+dr]);
    
    Screen('FillOval',w,[0 0 0],[xcr+r*cos(speedCounter)-dr,ycu+r*sin(speedCounter)-dr,xcr+r*cos(speedCounter)+dr,ycu+r*sin(speedCounter)+dr]);
    Screen('FillOval',w,[0 0 0],[xcr+r*cos((speedCounter)-pi)-dr,ycu+r*sin((speedCounter)-pi)-dr,xcr+r*cos((speedCounter)-pi)+dr,ycu+r*sin((speedCounter)-pi)+dr]);
    
    Screen('FillOval',w,[0 0 0],[xcl+r*cos(speedCounter)-dr,ycd+r*sin(speedCounter)-dr,xcl+r*cos(speedCounter)+dr,ycd+r*sin(speedCounter)+dr]);
    Screen('FillOval',w,[0 0 0],[xcl+r*cos((speedCounter)-pi)-dr,ycd+r*sin((speedCounter)-pi)-dr,xcl+r*cos((speedCounter)-pi)+dr,ycd+r*sin((speedCounter)-pi)+dr]);
    
    Screen('FillOval',w,[0 0 0],[xcr+r*cos(speedCounter)-dr,ycd+r*sin(speedCounter)-dr,xcr+r*cos(speedCounter)+dr,ycd+r*sin(speedCounter)+dr]);
    Screen('FillOval',w,[0 0 0],[xcr+r*cos((speedCounter)-pi)-dr,ycd+r*sin((speedCounter)-pi)-dr,xcr+r*cos((speedCounter)-pi)+dr,ycd+r*sin((speedCounter)-pi)+dr]);
    
    Screen('Flip',w);
    
    speedCounter = speedCounter+speed;
    
    if breakcounter == 2
        break
    end
    
%     for video
    imagetemp(counter).image = Screen('GetImage',w); %Put this command after every Flip command.
    counter=counter+1;      %Put this after every frame grab to make sure
end

%corners
% while ~KbCheck
%     
%     Screen('DrawLine',w,[0 0 0],xcl+r*cos(GetSecs),ycu+r*sin(GetSecs),xcl+r*cos(GetSecs)+dr,ycu+r*sin(GetSecs),2);
%     Screen('DrawLine',w,[0 0 0],xcl+r*cos(GetSecs),ycu+r*sin(GetSecs),xcl+r*cos(GetSecs),ycu+r*sin(GetSecs)+dr,2);
%     Screen('DrawLine',w,[0 0 0],xcl+r*cos((GetSecs)-pi),ycu+r*sin((GetSecs)-pi),xcl+r*cos((GetSecs)-pi)+dr,ycu+r*sin((GetSecs)-pi),2);
%     Screen('DrawLine',w,[0 0 0],xcl+r*cos((GetSecs)-pi),ycu+r*sin((GetSecs)-pi),xcl+r*cos((GetSecs)-pi),ycu+r*sin((GetSecs)-pi)+dr,2);
%     
%     Screen('DrawLine',w,[0 0 0],xcr+r*cos(GetSecs)-dr,ycu+r*sin(GetSecs),xcr+r*cos(GetSecs),ycu+r*sin(GetSecs),2);
%     Screen('DrawLine',w,[0 0 0],xcr+r*cos(GetSecs),ycu+r*sin(GetSecs),xcr+r*cos(GetSecs),ycu+r*sin(GetSecs)+dr,2);
%     Screen('DrawLine',w,[0 0 0],xcr+r*cos((GetSecs)-pi)-dr,ycu+r*sin((GetSecs)-pi),xcr+r*cos((GetSecs)-pi),ycu+r*sin((GetSecs)-pi),2);
%     Screen('DrawLine',w,[0 0 0],xcr+r*cos((GetSecs)-pi),ycu+r*sin((GetSecs)-pi),xcr+r*cos((GetSecs)-pi),ycu+r*sin((GetSecs)-pi)+dr,2);
%     
%     Screen('DrawLine',w,[0 0 0],xcl+r*cos(GetSecs),ycd+r*sin(GetSecs),xcl+r*cos(GetSecs)+dr,ycd+r*sin(GetSecs),2);
%     Screen('DrawLine',w,[0 0 0],xcl+r*cos(GetSecs),ycd+r*sin(GetSecs)-dr,xcl+r*cos(GetSecs),ycd+r*sin(GetSecs),2);
%     Screen('DrawLine',w,[0 0 0],xcl+r*cos((GetSecs)-pi),ycd+r*sin((GetSecs)-pi),xcl+r*cos((GetSecs)-pi)+dr,ycd+r*sin((GetSecs)-pi),2);
%     Screen('DrawLine',w,[0 0 0],xcl+r*cos((GetSecs)-pi),ycd+r*sin((GetSecs)-pi)-dr,xcl+r*cos((GetSecs)-pi),ycd+r*sin((GetSecs)-pi),2);
%     
%     Screen('DrawLine',w,[0 0 0],xcr+r*cos(GetSecs)-dr,ycd+r*sin(GetSecs),xcr+r*cos(GetSecs),ycd+r*sin(GetSecs),2);
%     Screen('DrawLine',w,[0 0 0],xcr+r*cos(GetSecs),ycd+r*sin(GetSecs)-dr,xcr+r*cos(GetSecs),ycd+r*sin(GetSecs),2);
%     Screen('DrawLine',w,[0 0 0],xcr+r*cos((GetSecs)-pi)-dr,ycd+r*sin((GetSecs)-pi),xcr+r*cos((GetSecs)-pi),ycd+r*sin((GetSecs)-pi),2);
%     Screen('DrawLine',w,[0 0 0],xcr+r*cos((GetSecs)-pi),ycd+r*sin((GetSecs)-pi)-dr,xcr+r*cos((GetSecs)-pi),ycd+r*sin((GetSecs)-pi),2);
%     
%     Screen('Flip',w);
% end


Screen('CloseAll');

vidObj = VideoWriter('spinofitsparts','Uncompressed AVI');%set up movie name and type.%be sure to give a new name for each movie, or it will overwrite.
vidObj.FrameRate = 60; %set framerate

open(vidObj);   %all of this should remain the same

for i=1:length(imagetemp)
    
    writeVideo(vidObj,imagetemp(i).image);%writes the current frame to vidObj.
end

%Once we've written our video, close it.

close(vidObj);
Priority(0);


ShowCursor;
ListenChar(0);
