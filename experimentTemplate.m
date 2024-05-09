% This is a template for experiment code. It includes all the necessary and
% or usefull code for every experiment. This code will display a red or green circle or square on
% the screen for 1 second followed by a .5 s delay, then ask the participant if
% they saw a red or green square or cirlce. It will repeat numTrials times.

% It is a good habit to record what each column of rawdata represents at
% the beginning and end of your code
% rawdata(n,1) - when the trial occurred
% rawdata(n,2) - 1=circle 2=square
% rawdata(n,3) - 1=red 2=green
% rawdata(n,4) - 1=responded it was circle 2=responded it was square
% rawdata(n,5) - 1=responded it was red 2=responded it was green

% clears any residual variables and closes any residual open screens
clear all
close all

% INITIALIZATION - set your basic parameters here

% Create the paths, input, and output files
c = clock;
time_stamp = sprintf('%02d/%02d/%04d %02d:%02d:%02.0f',c(2),c(3),c(1),c(4),c(5),c(6)); % month/day/year hour:min:sec
datecode = datestr(now,'mmddyy');
experiment = 'lemonVsDiamond';

% get input (subjects id and the run number)
subjid = input('Enter Subject Code:','s');
runid  = input('Enter Run:');
% define the output path
datadir = '/Users/C-Lab/Google Drive/Lab Projects/Random Code/';

% Outputs - set the name of the output files (we use datafile_full (saves all the variables in the program) and
% rawdata (only saves rawdata))
datafile=sprintf('%s_%s_%s_%03d',subjid,experiment,datecode,runid);
datafile_full=sprintf('%s_full',datafile);

% check to see if this file exists
if exist(fullfile(datadir,[datafile '.mat']),'file')
    tmpfile = input('File exists.  Overwrite? y/n:','s');
    while ~ismember(tmpfile,{'n' 'y'})
        tmpfile = input('Invalid choice. File exists.  Overwrite? y/n:','s');
    end
    if strcmp(tmpfile,'n')
        display('Bye-bye...');
        return; % will need to start over for new input
    end
end

% Hide key presses and cursor (keep in mind that is the cursor is needed
% you may not want to hide it)
HideCursor;
ListenChar(2);

%Get information about the current screen properties, and what to return
%the screen to after the experiment.

oldScreen=Screen('Resolution',0);

%Set the Screen resolution and refresh rate to the values appropriate for
%your experiment;

screenWide=1024;
screenHigh=768;
screenResfresh=85;
Screen('Resolution',0,screenWide,screenHigh,screenRefresh);

% Open the window, assign which window will display the experiment (in
% this case it is window 0) and assign rect (rect is a 4 column array
% displaying the coordinates of the upper left and lower right points of
% the screen. You can also manually assign this by specifying the
% coordinates after the color values)
[w,rect] = Screen('OpenWindow',0,[0 0 0]);

% VARIABLES - should initialize all variables here, before starting trials,
% to maximize preformance

% Specify screen center
x0 = rect(3)/2;
y0 = rect(4)/2;

% Set the text color
tColor = [255 255 255];

% Give subject breaks
% list of proportion of total trials at which to offer subject a self-timed break
break_trials = .1:.1:.9;

%BASIC WINDOW/SCREEN SETUP
% PPD stuff
mon_width_cm = 40;
mon_dist_cm = 73;
mon_width_deg = 2 * (180/pi) * atan((mon_width_cm/2)/mon_dist_cm);
PPD = (screenWide/mon_width_deg);

% Create the lists that will define your trial types
% Create a list for each variable in your experiment, labeling the levels in each condition, followed by a
% variable that holds the size of each list.
shapeList = [1 2]; % 1=circle 2=square
nShape = length(shapeList);
colorList = [1 2]; % 1=red 2=green
nColor = length(colorList);

% This represents the amount of times each trial type will be presented
repetitions = 15;

% varList utilizes the repeat matrix and full factorial functions to create
% an array of size numTrials x number of variables, in which each row
% represents a different trial type.
varList = repmat(fullyfact([nShape nColor]),[repetitions,1]);
numTrials = length(varList);

% trialOrder gives you a random list of numbers from 1 to numTrials that
% represents the trial order presentation.
trialOrder = randperm(numTrials);

% Creates variables that will be used in drawing the stimulus
% This determines the size of the stimulus to be displayed
shapeSize = 300;
% Destermines where on the screen the stimuli will be displayed
shapeRect = [x0-(shapeSize/2), y0-(shapeSize/2), x0+(shapeSize/2), y0+(shapeSize/2)];
% Creates a blank array for color array
shapeColor = [];

% Define the keypresses
buttonR = KbName('r');
buttonG = KbName('g');
buttonC = KbName('c');
buttonS = KbName('s');

%preallocate rawdata
rawdata=zeros(numTrials,5);

% Assign which keyboard you are using (place dev_ID after all Kb commands)
[nums, names] = GetKeyboardIndices;
dev_ID=nums(1);

% Instructions and Waiting for prticipant to initiate experiment
Screen('TextSize',w,35);
text='Attend to the fixation point that will appear in the center of the screen.';
width=RectWidth(Screen('TextBounds',w,text));
Screen('DrawText',w,text,x0-width/2,y0-300,tColor);

text='Indicate whether you saw a red or green square or circle by pressing the indicated button.';
width=RectWidth(Screen('TextBounds',w,text));
Screen('DrawText',w,text,x0-width/2,y0-250,tColor);

text='Press any key to begin';
width=RectWidth(Screen('TextBounds',w,text));
Screen('DrawText',w,text,x0-width/2,y0-200,tColor);
Screen('Flip',w);

% KbWait waits for a key to be pressed and KbReleaseWait waits for all keys
% to be released
KbWait(dev_ID);
KbReleaseWait(dev_ID);

%set a variable to track when a trial occurred
trialNumCounter=1;

% Checks for key presses
[keyIsDown, secs, keycode] = KbCheck(dev_ID);
for n=trialOrder
    
    rawdata(n,1)=trialNumCounter;
    trialNumCounter=trialNumCounter+1;
    
    % create your rawdata array that will hold all the trial information
    % and participant responses, as well as anyother pertinant information,
    % such as timing
    % The Idx values use varList and trialOrder to determine what level the
    % variable will be for the current trial
    shapeIdx = varList(n,2);
    rawdata(n,2) = shapeIdx;   % 1=circle 2=square
    colorIdx = varList(n,1);
    rawdata(n,3) = colorIdx; % 1=red 2=green
    
    % Draws the fixation square at screen center
    Screen('FillOval',w, [256 0 0], [x0-4, y0-4, x0+4, y0+4]);
    Screen('FillOval',w, [0 0 0], [x0-2, y0-2, x0+2, y0+2]);
    
    % Draws the shape to the screen
    Screen('Flip',w);
    % Leaves fization on screen for a second before stimulus presentation
    WaitSecs(1);
    
    % switch between color and shape defending on the idx values
    % Creates a 3 column array of RGB values depending on what trial type
    % color is
    if  colorIdx == 1
        shapeColor = [255 0 0];
    elseif colorIdx == 2
        shapeColor = [0 255 0];
    end
    
    % Draws either a square or a circle using the RGB array created and
    % shapeRect set in the variables section of the code
    if shapeIdx == 1
        Screen('FillOval',w,shapeColor,shapeRect);
    elseif shapeIdx == 2
        Screen('FillRect',w,shapeColor,shapeRect);
    end
    
    % Draws the shape to the screen
    Screen('Flip',w);
    
    % Leave the stim on the screen for a predetermined amount of time
    WaitSecs(1);
    
    % Take the stim off the screen and leave a blank delay for some amount
    % of time
    Screen('Flip',w);
    WaitSecs(.5);
    
    % Ask participant for response
    text='Was the shape a square (S) or a circle (C)?';
    width=RectWidth(Screen('TextBounds',w,text));
    Screen('DrawText',w,text,x0-width/2,y0-200,tColor);
    Screen('Flip',w);
    
    % Utilize a while loop to wait for a response from the participant
    % Checks for key presses
    [keyIsDown, secs, keycode] = KbCheck(dev_ID);
    while 1
        % Checks for key presses
        [keyIsDown, secs, keycode] = KbCheck(dev_ID);
        % Look for a button press of S (square) or C (circle) then record
        % the response in rawdata as a square or circle (if the responded it
        % was a square record a 1 and if a circle record 2
        if keycode(buttonC)
            rawdata(n,4) = 1; % 1 = circle
            break
        elseif keycode(buttonS)
            rawdata(n,4) = 2; % 2 = square
            break
        end
    end
    
    % in the same was as above, ask participant what color it was and
    % record there response in rawdata
    % Ask participant for response
    text='Was the shape green (G) or red (R)?';
    width=RectWidth(Screen('TextBounds',w,text));
    Screen('DrawText',w,text,x0-width/2,y0-200,tColor);
    Screen('Flip',w);
    while 1
        % Checks for key presses
        [keyIsDown, secs, keycode] = KbCheck(dev_ID);
        if keycode(buttonR)
            rawdata(n,5) = 1; % 1 = red
            break
        elseif keycode(buttonG)
            rawdata(n,5) = 2; % 2 = green
            break
        end
    end
    
    
    %save trial information on each trial
    save(sprintf('%s%s',datadir,datafile),'rawdata');
end

% save two files: 1 for rawdata and 2 that holds all the variables you
% created
save(sprintf('%s%s',datadir,datafile),'rawdata');
save(datafile_full);

%sort rawdata based on the order of trial presentations
rawdata=sortrows(rawdata,1);

% Close screen, reset monitor parameters, display key presses, and show cursor
Screen('CloseAll');
Screen('Resolution',0,oldScreen.width,oldScreen.height,oldScreen.hz);
ListenChar(0);
ShowCursor;



% It is a good habit to record what each column of rawdata represents at
% the beginning and end of your code
% rawdata(n,2) - 1=circle 2=square
% rawdata(n,3) - 1=red 2=green
% rawdata(n,4) - 1=responded it was circle 2=responded it was square
% rawdata(n,5) - 1=responded it was red 2=responded it was green


