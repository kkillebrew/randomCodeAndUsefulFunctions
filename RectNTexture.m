close all
clear all

ListenChar(2);
HideCursor;

backColor = 255;
dotColor = 0;
textColor = [256, 256, 256];

% Sets the inputs to come in from the other computer
[nums, names] = GetKeyboardIndices;
dev_ID=nums(1);
con_ID=nums(1);

rect=[0 100 1024 868];     % test comps
[w,rect]=Screen('OpenWindow', 0,[backColor backColor backColor],rect,[],[],[],100);
x0 = rect(3)/2;% screen center
y0 = rect(4)/2;

KbName('UnifyKeyNames');

buttonUp = KbName('UpArrow');
buttonDown = KbName('DownArrow');
buttonLeft = KbName('LeftArrow');
buttonRight = KbName('RightArrow');
buttonEscape = KbName('Escape');

[keyIsDown, secs, keycode] = KbCheck(dev_ID);

radius = 30;

while ~keycode(buttonEscape)
    
    [keyIsDown, secs, keycode] = KbCheck(dev_ID);
    
    array = 128*ones(radius*2,radius*2);
    
    texture = Screen('MakeTexture',w,array);
    
    Screen('FrameRect',texture,[255 0 0],[0 0 radius*2 radius*2]);
    
    Screen('DrawTexture',w,texture);
    
    Screen('Flip',w);
    
end



ListenChar(0);
Screen('CloseAll');
ShowCursor;
