



%Netstation communication params
NS_host = '169.254.180.49'; % ip address of NetStation host computer
NS_port = 55513; % the ethernet port to be used (Default is 55513 for NetStation.m)
%NS_synclimit = 0.9; % the maximum allowed difference in milliseconds between PTB and NetStation computer clocks (.m default is 2.5)

% Detect and initialize the DAQ for ttl pulses
d=PsychHID('Devices');
numDevices=length(d);
trigDevice=[];
dev=1;
while isempty(trigDevice)
    if d(dev).vendorID==2523 && d(dev).productID==130 %if this is the first trigger device
        trigDevice=dev;
        %if you DO have the USB to the TTL pulse trigger attached
        disp('Found the trigger.');
    elseif dev==numDevices
        %if you do NOT have the USB to the TTL pulse trigger attached
        disp('Warning: trigger not found.');
        disp('Check out the USB devices by typing d=PsychHID(''Devices'').');
        break;
    end
    dev=dev+1;
end

%   trigDevice=4; %if this doesn't work, try 4
%Set port B to output, then make sure it's off
DaqDConfigPort(trigDevice,0,0);
DaqDOut(trigDevice,0,0);
TTL_pulse_dur = 0.005; % duration of TTL pulse to account for ahardware lag

% Connect to the recording computer and start recording
NetStation('Connect', NS_host, NS_port)
NetStation('StartRecording');

% Sync the screen flips for timing purposes
sync_time = Screen('Flip',w,[],2);

% Send trigger pulse
DaqDOut(trigDevice,0,2)
WaitSecs(TTL_pulse_dur);
DaqDOut(trigDevice,0,0)

% Insert stumlus code here

% Flip the screen based on the synced time
run_start=Screen('Flip',w,sync_time,2);

% Make sure to stop recording and disconnect from the recording computer
NetStation('StopRecording');
NetStation('Disconnect');