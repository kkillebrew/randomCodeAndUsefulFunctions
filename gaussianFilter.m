

% Gausian filter on a circle
% Help: http://www.icn.ucl.ac.uk/courses/MATLAB-Tutorials/Elliot_Freeman/html/gabor_tutorial.html

clear;

ListenChar(2);

backColor = 128;
dotColor = 128;

gratingsize=100;
drawmask=1;      % Places the gaussian filter
angle=45;          % Angle of the grating w/ repect to vertical dimension
f = .05;             % Frequency of grating in cyceles per pixel
texsize=gratingsize / 2;    % Define Half-Size of the grating image.

white=255;
black=0;
gray=round((white+black)/2);
if gray == white
    gray=white / 2;
end
inc=white-gray;

escape=KbName('A');

[w rect]=Screen('OpenWindow',0,[backColor backColor backColor]);
x0 = rect(3)/2;% screen center
y0 = rect(4)/2;

Screen('BlendFunction', w, GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);

p=ceil(1/f);        % Pixels per cycle rounded up to full pixels
fr=f*2*pi;         % Frequency in radians
visiblesize=2*texsize+1;     % Visible size of the grating (twice the half width of the texture plain plus one pixel to insure symmetry

% Create one single static grating image
x = meshgrid(-texsize:texsize + p, 1);
grating=gray + inc*cos(fr*x);               % Compute cosine gratings
gratingtex=Screen('MakeTexture', w, grating);    % Store 1d single row grating in texture

% Create a two layer texture: one unused luminance channel with same color as back and the
% alpha channel is filled with a gaussian aperture mask
mask=ones(2*texsize+1, 2*texsize+1, 2) * gray;
[x,y]=meshgrid(-1*texsize:1*texsize,-1*texsize:1*texsize);
mask(:, :, 2)=white * (1 - exp(-((x/90).^2)-((y/90).^2)));
masktex=Screen('MakeTexture', w, mask);

dstRect=[0 0 visiblesize visiblesize];
dstRect=CenterRect(dstRect, rect);

HideCursor;

while 1
    Screen('DrawTexture', w, gratingtex, [], dstRect, angle);
    % Draw gaussian mask over grating:
    Screen('DrawTexture', w, masktex, [0 0 visiblesize visiblesize], dstRect, angle);
    Screen('Flip',w);
    if KbCheck
        break;
    end;
end

ListenChar(0);
ShowCursor;
Screen('Close',w);