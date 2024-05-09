

% Weird graph motion thing
% as seen here: http://www.icn.ucl.ac.uk/courses/MATLAB-Tutorials/Elliot_Freeman/html/gabor_tutorial.html


clear;

ListenChar(2);

backColor = 0;
dotColor = 128;

escape=KbName('A');

[w,rect]=Screen('OpenWindow', 1,[backColor backColor backColor],rect);
x0 = rect(3)/2;% screen center
y0 = rect(4)/2;

HideCursor;

imSize = 100;                           % image size: n X n
lamda = 10;                             % wavelength (number of pixels per cycle)
theta = 15;                              % grating orientation
sigma = 10;                             % gaussian standard deviation in pixels
phase = .25;                            % phase (0 -> 1)
trim = .005;                             % trim off gaussian values smaller than this

X = 1:imSize;                           % X is a vector from 1 to imageSize
X0 = (X / imSize) - .5;                 % rescale X -> -.5 to .5

freq = imSize/lamda;                    % compute frequency from wavelength
Xf = X0 * freq * 2*pi;                  % convert X to radians: 0 -> ( 2*pi * frequency)
sinX = sin(Xf) ;
phaseRad = (phase * 2* pi);             % convert to radians: 0 -> 2*pi
sinX2 = sin( Xf + phaseRad) ;            % make phase-shifted sinewave

% Preallocating the noise filter for each trial
noiseMatrix=[];
for i=1:rect(3)/4
    for j=1:rect(4)/4
        if n==sinX
            ;
        end
    end
end

destRect = [rect(3)/4,rect(4)/4,(rect(3)*.75),(rect(4)*.75)];
noise=Screen('MakeTexture',w,noiseMatrix);

while 1
    
    Screen('DrawTexture',w,noise,[],destRect);
    
    while 1
        if keyIsDown
            break
        end
        [keyIsDown, secs, keycode] = KbCheck(dev_ID);
    end
    break
end



ListenChar(0);
ShowCursor;
Screen('Close',w);