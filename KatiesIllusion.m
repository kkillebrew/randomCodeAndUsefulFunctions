clear all
close all

Screen('Preference', 'SkipSyncTests', 1);

%BASIC WINDOW/SCREEN SETUP
% PPD stuff
mon_width_cm = 40;
mon_dist_cm = 73;
mon_width_deg = 2 * (180/pi) * atan((mon_width_cm/2)/mon_dist_cm);
PPD = (1024/mon_width_deg);

% Color vars
backColor = [128 128 128];
squareColor{1} = [255 255 255];
squareColor{2} = [0 0 0];
circColor = [0 0 0];

[w, rect] = Screen('Openwindow', 0, backColor, [0 0 1920 1080]);
x0 = rect(3)/2;
y0 = rect(4)/2;HideCursor;
ListenChar(2);

buttonEscape = KbName('escape');
buttonEnter = KbName('return');

Screen('BlendFunction',w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);  % Must have for alpha values for some reason

% Vars
numSquares = 10;
squareLength = rect(4)/numSquares;
circLength = 20;
circColorCounter = -1;

[keyIsDown, secs, keycode] = KbCheck;
while ~keycode(buttonEscape)
    [keyIsDown, secs, keycode] = KbCheck;
    
    % Draw the checkerboard the same length as the y axis
    y1=0;
    squareColorStatus = 1;
    for i=1:numSquares
        x1 = x0-y0;
        y2 = y1+squareLength;
        for j=1:numSquares
            
            x2 = x1+squareLength;
            squareArray{i,j} = [x1,y1,x2,y2];
            Screen('FillRect',w,squareColor{squareColorStatus},squareArray{i,j});
            x1 = x1+squareLength;
            % Change the color of the square
            if squareColorStatus == 1
                squareColorStatus = 2;
            elseif squareColorStatus == 2
                squareColorStatus = 1;
            end

             
        end
        y1 = y1+squareLength;
        if ~mod(numSquares,2)
            % Change the color of the square
            if squareColorStatus == 1
                squareColorStatus = 2;
            elseif squareColorStatus == 2
                squareColorStatus = 1;
            end
        end
    end
    
    % Draw the circles
    y1=0;
    for i=1:numSquares
        x1 = x0-y0;
        y2 = y1+squareLength;
        for j=1:numSquares
            
            if i~=numSquares && j~=numSquares
                
                x2 = x1+squareLength;
                circArray = [x2-circLength/2, y2-circLength/2, x2+circLength/2, y2+circLength/2];
                Screen('FillOval',w,circColor,circArray);
                x1 = x1+squareLength;
                
            end
        end
        y1 = y1+squareLength;
    end
    
    if circColor(1) >= 255 || circColor(1) <= 0
        circColorCounter = circColorCounter*(-1);
    end
    circColor = [circColor(1)+circColorCounter circColor(2)+circColorCounter circColor(1)+circColorCounter];
    
    
    Screen('Flip',w);
    
end



Screen('CloseAll');
ListenChar(0);
ShowCursor;