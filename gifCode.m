

% Create imageArray either using preexisting images or code that you
% created using GetImage
imageArray={'AccidentalView1','AccidentalView2','AccidentalView3','AccidentalView4','AccidentalView5'};
% imageArray = Screen('GetImage', w, [(edgeBufferX-20) (edgeBufferY-20) (rect(3)-edgeBufferX+20) (rect(4)-edgeBufferY+20)]);
% imwrite is a Matlab function, not a PTB-3 function
imwrite(imageArray, 'test.jpg')

%Creates the .gif
delayTime = .5; %Screen refresh rate of 60Hz = 1/60
for i=1:length(imageArray)
    %Gifs can't take RBG matrices: they have to be specified with the pixels as indices into a colormap
    %See the help for imwrite for more details
    [y, newmap] = cmunique(imageArray{i});
    
    %Creates a .gif animation - makes first frame, then appends the rest
    if i==1
        imwrite(y, newmap, 'DegredationDemo.gif');
    else
        imwrite(y, newmap, 'DegredationDemo.gif', 'DelayTime', delayTime, 'WriteMode', 'append','LoopCount',inf);
    end
end



