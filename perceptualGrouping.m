close all
clear all

circNum = 4;    % X by X grid of circles; circ size are a proportion of the screen

buttonEscape = KbName('escape');

screenWide=600;
screenHigh=600;
hz = 60;   % refresh rate
colorFlip(1,:) = [0 0 0];
colorFlip(2,:) = [255 255 255];

[w, rect] = Screen('Openwindow',0, [128 128 128],[0 0 screenWide screenHigh]);

% Determine the size of the circles
% (total number of circs + (total num circs/2 +.5)) / total size
circSize = rect(4)/(circNum+(circNum/2 + .5));

% Calculate the coordinates for the circles
rowCount = 1; 
for i=1:circNum
    for j=1:circNum
        
        % Make each circle in each row flicker at one of 4 rates randomly.
        % Ensure that no touching circle is flickering at the same rate.
        
        x1 = (circSize/2)*(i-1) + i*(circSize);
        y1 = (circSize/2)*(j-1) + j*(circSize);
        
        x1coord(i,j) = x1 - circSize/2;
        x2coord(i,j) = x1 + circSize/2;
        y1coord(i,j) = y1 - circSize/2;
        y2coord(i,j) = y1 + circSize/2;
        
        
    end
end

stim_rates(1) = 3; %F1
stim_rates(2) = 5; %F2
stim_rates(3) = 12; %F3
stim_rates(4) = 20; %F4

rate(1)=1/(2*stim_rates(1));
rate(2)=1/(2*stim_rates(2));
rate(3)=1/(2*stim_rates(3));
rate(4)=1/(2*stim_rates(4));

% Variable that determines whether or not a screen flip is
% necessary
check = 0;

% Set sync_time to the time of the initial screen flip
sync_time= Screen('Flip',w,[],2);

% Draw the stimuli to the screen
for i=1:circNum
    for j=1:circNum
        % Draw a black bar connecting the pairs of circles
%         Screen('FillRect',w,[0 0 0],[]);
        
        Screen('FillOval',w,colorFlip(1),[x1coord(i,j), y1coord(i,j), x2coord(i,j), y2coord(i,j)]);
    end
end
run_start=Screen('Flip',w,sync_time,2);

% Preallocate variables
rate_check = zeros(1,circNum);
t = zeros(1,circNum)+run_start;
flip = ones(1,circNum);

% Randomly determine which circles will be flickering at which frequencies
% in each row. Ensure that no frequency is repeated consecutivly in a
% column or row. 
circRates(1,:) = randperm(4);
for i=1:circNum-1
    circRates(i+1,:) = randperm(4);
    while 1
        if circRates(i,1)==circRates(i+1,1) || circRates(i,2)==circRates(i+1,2) || circRates(i,3)==circRates(i+1,3) || circRates(i,4)==circRates(i+1,4)
            circRates(i+1,:) = randperm(4);
        else
            break
        end
    end
end
circRates

[keyisdown, secs, keycode] = KbCheck;
while ~keycode(buttonEscape)
    [keyisdown, secs, keycode] = KbCheck;
    
    % While the total time is less than time elapsed keep looping 
    time_now = GetSecs;
    %Keep track of flicker rates for each stimulus
    trial_check = (time_now - run_start) > 10000;
    
    % While the time elapsed is less than the time of the total
    % trial keep checking for flip times
    switch trial_check
        case 0
            
            % Determines based on individual stimulus frequencies
            % whether or not a screen flip is necessary
            for i=1:circNum
                rate_check(i) = (time_now - t(i)) > rate(i)-1/hz;

                switch rate_check(i)
                    case 1
                        flip(i) =  3-flip(i);
                        t(i)=t(i)+rate(i);
                        check =1;
                    otherwise
                end
            end
            
            %Update changes on the screen
            switch check
                
                case 1
                    % Draw the stimuli to the screen
                    for i=1:circNum
                        for j=1:circNum
                            Screen('FillOval',w,colorFlip(flip(circRates(i,j))),[x1coord(i,j), y1coord(i,j), x2coord(i,j), y2coord(i,j)]);
                        end
                    end
                    Screen('Flip',w,time_now,2);
                    check=0;
                case 0
                    WaitSecs(.0005);
            end
            
        % If total time has been reached break out of the loop
        case 1
            break
    end
end


Screen('CloseAll')




