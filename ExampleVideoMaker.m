clear
ListenChar(2); %surpress keyboard output
HideCursor;
PsychGPUControl('FullScreenWindowDisablesCompositor', 1); %for timing, may be unnecessary.
[w,rect]=Screen('OpenWindow',0,[255 255 255],[0,0,400,400],[],[],[],100); %Be sure to set the window to the desired video size. 
                                                                             %Full Screen sometimes causes issues. 
                                                                             %Final value is for smoothing.May slow down older computers
PsychGPUControl('FullScreenWindowDisablesCompositor', 1);%for timing, may be unnecessary.

xc=rect(3)/2; %sets up screen center
yc=rect(4)/2;
Priority(9); %for timing

% picarray=zeros(500,500);    %stimulus stuff specific to this code
% t=Screen('MakeTexture',w,picarray);
% Screen('DrawTexture',w,t);

counter=1; %absoulutely necessary. Keeps track of your movie frames
starttime=GetSecs;
while GetSecs-starttime<.75 %Never use WaitSecs, as no frames can be collected during WaitSecs. 
                           %Instead use while loops if the same thing will
                           %be on the screen for longer than a single
                           %frame.
                           
%     Screen('DrawTexture',w,t);

    Screen('FillRect',w,[0 0 0],[xc-2,yc-2,xc+2,yc+2]);
    Screen('FillRect',w,[255 0 0],[xc-100, yc-20, xc-80,yc+20]);
    

    Screen('Flip',w);
    imagetemp(counter).image = Screen('GetImage',w); %Put this command after every Flip command.
    counter=counter+1;                               %Put this after every frame grab to make sure 
                                                     %the next frame is appended, and doesn't overwrite.
end
starttime=GetSecs;
while GetSecs-starttime<.75
    
    Screen('FillRect',w,[255 0 0],[xc-100, yc-20, xc+100,yc+20]);
    Screen('FillRect',w,[0 0 0],[xc-2,yc-2,xc+2,yc+2]);

    
    Screen('Flip',w);
    imagetemp(counter).image = Screen('GetImage',w);
    counter=counter+1;
end
starttime=GetSecs;
while GetSecs-starttime<1.25
    
    Screen('FillRect',w,[0 255 0],[xc-100, yc-20, xc+100,yc+20]);
    Screen('FillRect',w,[0 0 0],[xc-2,yc-2,xc+2,yc+2]);

    
    Screen('Flip',w);
    imagetemp(counter).image = Screen('GetImage',w);
    counter=counter+1;
end
starttime=GetSecs;
while GetSecs-starttime<.75
    
    Screen('FillRect',w,[0 0 0],[xc-2,yc-2,xc+2,yc+2]);

    
    Screen('Flip',w);
    imagetemp(counter).image = Screen('GetImage',w);
    counter=counter+1;
end

Screen('CloseAll') %must be done before the movie is actually made.

% imagetemp=imagetemp(1,2:length(imagetemp)); %may or may not be necessary.
% Include if first frame of movie is something other than what was desired.

vidObj = VideoWriter('IllusoryRebMotion','Uncompressed AVI');%set up movie name and type.%be sure to give a new name for each movie, or it will overwrite.
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

%Resulting video should be a blinking black square alternating with a black
%dot.
