origRez = Screen('Resolution',0);
Screen('Resolution',0,1024,768);

[w,rect] = Screen('OpenWindow',0,[255 255 255]);

Screen('CloseAll');

Screen('Resolution',0,origRez.width,origRez.height);