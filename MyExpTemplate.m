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

% Open the window, assign which window will display the experiment (in
% this case it is window 0) and assign rect (rect is a 4 column array
% displaying the coordinates of the upper left and lower right points of
% the screen. You can also manually assign this by specifying the
% coordinates after the color values)
[w,rect] = Screen('OpenWindow',0,[0 0 0], );

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
PPD = (1024/mon_width_deg);

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

% Define the keypresses
buttonR = KbName('r');
buttonG = KbName('g');
buttonC = KbName('c');
buttonS = KbName('s');

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

% Checks for key presses
[keyIsDown, secs, keycode] = KbCheck(dev_ID);
for n=1:numTrials
    
    % create your rawdata array that will hold all the trial information
    % and participant responses, as well as anyother pertinant information,
    % such as timing
    % The Idx values use varList and trialOrder to determine what level the
    % variable will be for the current trial
    shapeIdx = varList(trialOrder(n),2);
    rawdata(n,1) = shapeIdx;   % 1=circle 2=square
    colorIdx = varList(trialOrder(n),1);
    rawdata(n,2) = colorIdx; % 1=red 2=green
    
    % Draws the fixation square at screen center
    Screen('FillOval',w, [256 0 0], [x0-4, y0-4, x0+4, y0+4]);
    Screen('FillOval',w, [0 0 0], [x0-2, y0-2, x0+2, y0+2]);
end

% save two files: 1 for rawdata and 2 that holds all the variables you
% created
save(sprintf('%s%s',datadir,datafile),'rawdata');
save(datafile_full);


% Close screen, display key presses, and show cursor
Screen('CloseAll');
ListenChar(0);
ShowCursor;


